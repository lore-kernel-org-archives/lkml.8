Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4BEC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 606112070B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgEGJXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 05:23:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3839 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbgEGJXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 05:23:47 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2E810F2A30BCBDF2A368;
        Thu,  7 May 2020 17:23:44 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.237) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 7 May 2020
 17:23:37 +0800
To:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hushiyuan@huawei.com>, <hewenliang4@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] tools/bootconfig: fix resource leak in apply_xbc()
Message-ID: <583a49c9-c27a-931d-e6c2-6f63a4b18bea@huawei.com>
Date:   Thu, 7 May 2020 17:23:36 +0800
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

The @data and @fd is leak in the error path of apply_xbc(), so this
patch fix it.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 tools/bootconfig/main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 16b9a420e6fd..001076c51712 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -314,6 +314,7 @@ int apply_xbc(const char *path, const char *xbc_path)
 	ret = delete_xbc(path);
 	if (ret < 0) {
 		pr_err("Failed to delete previous boot config: %d\n", ret);
+		free(data);
 		return ret;
 	}

@@ -321,24 +322,26 @@ int apply_xbc(const char *path, const char *xbc_path)
 	fd = open(path, O_RDWR | O_APPEND);
 	if (fd < 0) {
 		pr_err("Failed to open %s: %d\n", path, fd);
+		free(data);
 		return fd;
 	}
 	/* TODO: Ensure the @path is initramfs/initrd image */
 	ret = write(fd, data, size + 8);
 	if (ret < 0) {
 		pr_err("Failed to apply a boot config: %d\n", ret);
-		return ret;
+		goto out;
 	}
 	/* Write a magic word of the bootconfig */
 	ret = write(fd, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
 	if (ret < 0) {
 		pr_err("Failed to apply a boot config magic: %d\n", ret);
-		return ret;
+		goto out;
 	}
+out:
 	close(fd);
 	free(data);

-	return 0;
+	return ret;
 }

 int usage(void)
-- 
1.8.3.1

