Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBDCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B28020737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591663334;
	bh=uLIiV6a2C3DabdgHiCkwzzxOz16o+QawDnotDiKh0h4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d+88Pboek5nlLzzQrGwPkjiNYhRenWLyJfXxwHrOL9Un8q0o3PC3kMGn/zu565ek8
	 0JZLM5GhNcZg93e0IMEZy9K1Tio7mLJcSdy37389dIAQivox9QrJ3zHEEMENSAeddg
	 o6x39Ft754AS7XtjhPLejHURYybbfq4NhRxFh/Yk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgFIAmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:42:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbgFHXMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:12:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E08420897;
        Mon,  8 Jun 2020 23:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657953;
        bh=uLIiV6a2C3DabdgHiCkwzzxOz16o+QawDnotDiKh0h4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iivHfWh6Nb3X707PQg1h3SaN0CV+ah2peMl4kFbgMS8f/wb3c1xObjYQodJm3ng7F
         yacAJTywosYZF2qACNqAKsW1Kxz7rFaL5PctrbfHRW3FuhmZf6dJJUWLlA2E5oeiIo
         kD0jGgGNUrr9h4cNN6FUdD6iGNirM4wMnUWCabaM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH AUTOSEL 5.6 018/606] bootconfig: Fix to remove bootconfig data from initrd while boot
Date:   Mon,  8 Jun 2020 19:02:23 -0400
Message-Id: <20200608231211.3363633-18-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

commit de462e5f10718517bacf2f84c8aa2804567ef7df upstream.

If there is a bootconfig data in the tail of initrd/initramfs,
initrd image sanity check caused an error while decompression
stage as follows.

[    0.883882] Unpacking initramfs...
[    2.696429] Initramfs unpacking failed: invalid magic at start of compressed archive

This error will be ignored if CONFIG_BLK_DEV_RAM=n,
but CONFIG_BLK_DEV_RAM=y the kernel failed to mount rootfs
and causes a panic.

To fix this issue, shrink down the initrd_end for removing
tailing bootconfig data while boot the kernel.

Link: http://lkml.kernel.org/r/158788401014.24243.17424755854115077915.stgit@devnote2

Cc: Borislav Petkov <bp@alien8.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org
Fixes: 7684b8582c24 ("bootconfig: Load boot config from the tail of initrd")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 init/main.c | 69 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 52 insertions(+), 17 deletions(-)

diff --git a/init/main.c b/init/main.c
index 9c7948b3763a..ee0345e7e9f1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -257,6 +257,47 @@ static int __init loglevel(char *str)
 
 early_param("loglevel", loglevel);
 
+#ifdef CONFIG_BLK_DEV_INITRD
+static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
+{
+	u32 size, csum;
+	char *data;
+	u32 *hdr;
+
+	if (!initrd_end)
+		return NULL;
+
+	data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
+	if (memcmp(data, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN))
+		return NULL;
+
+	hdr = (u32 *)(data - 8);
+	size = hdr[0];
+	csum = hdr[1];
+
+	data = ((void *)hdr) - size;
+	if ((unsigned long)data < initrd_start) {
+		pr_err("bootconfig size %d is greater than initrd size %ld\n",
+			size, initrd_end - initrd_start);
+		return NULL;
+	}
+
+	/* Remove bootconfig from initramfs/initrd */
+	initrd_end = (unsigned long)data;
+	if (_size)
+		*_size = size;
+	if (_csum)
+		*_csum = csum;
+
+	return data;
+}
+#else
+static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
+{
+	return NULL;
+}
+#endif
+
 #ifdef CONFIG_BOOT_CONFIG
 
 char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
@@ -355,9 +396,12 @@ static void __init setup_boot_config(const char *cmdline)
 	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
 	u32 size, csum;
 	char *data, *copy;
-	u32 *hdr;
 	int ret;
 
+	data = get_boot_config_from_initrd(&size, &csum);
+	if (!data)
+		goto not_found;
+
 	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 	parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
 		   bootconfig_params);
@@ -365,27 +409,12 @@ static void __init setup_boot_config(const char *cmdline)
 	if (!bootconfig_found)
 		return;
 
-	if (!initrd_end)
-		goto not_found;
-
-	data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
-	if (memcmp(data, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN))
-		goto not_found;
-
-	hdr = (u32 *)(data - 8);
-	size = hdr[0];
-	csum = hdr[1];
-
 	if (size >= XBC_DATA_MAX) {
 		pr_err("bootconfig size %d greater than max size %d\n",
 			size, XBC_DATA_MAX);
 		return;
 	}
 
-	data = ((void *)hdr) - size;
-	if ((unsigned long)data < initrd_start)
-		goto not_found;
-
 	if (boot_config_checksum((unsigned char *)data, size) != csum) {
 		pr_err("bootconfig checksum failed\n");
 		return;
@@ -414,8 +443,14 @@ static void __init setup_boot_config(const char *cmdline)
 not_found:
 	pr_err("'bootconfig' found on command line, but no bootconfig found\n");
 }
+
 #else
-#define setup_boot_config(cmdline)	do { } while (0)
+
+static void __init setup_boot_config(const char *cmdline)
+{
+	/* Remove bootconfig data from initrd */
+	get_boot_config_from_initrd(NULL, NULL);
+}
 
 static int __init warn_bootconfig(char *str)
 {
-- 
2.25.1

