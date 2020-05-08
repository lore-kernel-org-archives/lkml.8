Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C09C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C49BC20A8B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgEHKxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 06:53:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4302 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726325AbgEHKxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 06:53:05 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C14AC10F0AFAD4AF2FD8;
        Fri,  8 May 2020 18:53:02 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.237) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Fri, 8 May 2020
 18:52:53 +0800
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH v3] tools/bootconfig: fix resource leak in apply_xbc()
To:     <mhiramat@kernel.org>, <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <Markus.Elfring@web.de>, <dan.carpenter@oracle.com>,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Message-ID: <3569aa33-8963-966d-9247-ec79b3b3d56d@huawei.com>
Date:   Fri, 8 May 2020 18:52:53 +0800
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

Fix the @data and @fd allocations that are leaked in the error path of
apply_xbc().

Fixes: 85c46b78da58 ("bootconfig: Add bootconfig magic word for indicating bootconfig explicitly")
Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
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

