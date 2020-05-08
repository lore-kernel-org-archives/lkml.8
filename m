Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D28C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C97920725
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgEHMKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:10:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39142 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726627AbgEHMKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:10:09 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 75BC7E1BE2FFC8B5EA40;
        Fri,  8 May 2020 20:10:07 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.237) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Fri, 8 May 2020
 20:09:58 +0800
To:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
        <Markus.Elfring@web.de>, <rostedt@goodmis.org>,
        <kernel-janitors@vger.kernel.org>, <dan.carpenter@oracle.com>
CC:     Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH v4] tools/bootconfig: fix resource leak in apply_xbc()
Message-ID: <bdda096b-9f8a-dacb-9f89-9077d1288ad7@huawei.com>
Date:   Fri, 8 May 2020 20:09:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.237]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An error is found by a internel analysis tool:
  "Memory leak: data" and "Resource leak: fd" in tools/bootconfig/main.c

Fix the @data and @fd allocations that are leaked in the error path of
apply_xbc().

Fixes: 85c46b78da58 ("bootconfig: Add bootconfig magic word for indicating bootconfig explicitly")
Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
v3 -> v4:
 - update the commit message

v2 -> v3:
 - set 'ret' to 0 before returning on success

v1 -> v2:
 - complete the error handling at other error path
 - add "Fixes" tag

 tools/bootconfig/main.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 16b9a420e6fd..17a9837dcfaa 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -314,31 +314,35 @@ int apply_xbc(const char *path, const char *xbc_path)
 	ret = delete_xbc(path);
 	if (ret < 0) {
 		pr_err("Failed to delete previous boot config: %d\n", ret);
-		return ret;
+		goto free_data;
 	}

 	/* Apply new one */
 	fd = open(path, O_RDWR | O_APPEND);
 	if (fd < 0) {
 		pr_err("Failed to open %s: %d\n", path, fd);
-		return fd;
+		ret = fd;
+		goto free_data;
 	}
 	/* TODO: Ensure the @path is initramfs/initrd image */
 	ret = write(fd, data, size + 8);
 	if (ret < 0) {
 		pr_err("Failed to apply a boot config: %d\n", ret);
-		return ret;
+		goto close_fd;
 	}
 	/* Write a magic word of the bootconfig */
 	ret = write(fd, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
-	if (ret < 0) {
+	if (ret < 0)
 		pr_err("Failed to apply a boot config magic: %d\n", ret);
-		return ret;
-	}
+
+	ret = 0;
+
+close_fd:
 	close(fd);
+free_data:
 	free(data);

-	return 0;
+	return ret;
 }

 int usage(void)
-- 
1.8.3.1

