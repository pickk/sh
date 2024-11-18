package main

import (
	"bytes"
	"fmt"
	"os/exec"
	"strings"
	"time"
)

func cmdIPHistory() []string {
	cmd := exec.Command("bash", "-c", `last -i | awk '{print $3}' | uniq`)

	var out bytes.Buffer
	cmd.Stdout = &out
	// 执行命令
	err := cmd.Run()
	if err != nil {
		fmt.Printf("执行命令时出错: %v\n", err)
	}

	// 解析输出
	output := out.String()
	loggedIPs := strings.Split(strings.TrimSpace(output), "\n")
	return loggedIPs
}
func main() {
	firstRead := cmdIPHistory()[0]
	for true {
		// 读取当前的IP历史记录
		loggedIPs := cmdIPHistory()

		// fmt.Println(rememberedIPs)
		// 如果当前的IP历史记录和第一次读取的IP历史记录不一样
		if firstRead != loggedIPs[0] {
			fmt.Println("New IP detected: ", loggedIPs[0])
			firstRead = loggedIPs[0]
			for i := 0; i < len(loggedIPs); i++ {
				cmd := exec.Command("bash", "-c", "ufw insert 1 allow from "+loggedIPs[i])
				// 执行命令
				err := cmd.Run()
				if err != nil {
					fmt.Println(err)
				}
			}
		}
		time.Sleep(1 * time.Second)
	}
}
