Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214BAC2BA1A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 06:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A32206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 06:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587884016;
	bh=AX72LrszXZVr3GndLIzHGcqKzv1x/vpPvEudF3/4TvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m2nh3fFzgcv6TqvkSOtWXfwuw/M/kj1LNrMJiFQPC48Z0DW5aZhSqPEZnLtL8/wFg
	 8OkP9RC9OsxKKokYtbm2R1gCqHy7CsC1j/GoejzWvDmw+07OTNy2HtTPZtEqr0oDDj
	 d8Mmv+zPoj5jlM5JkQ7nL+Iv/JCGJmJML2C43F9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgDZGxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 02:53:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgDZGxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 02:53:34 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63F1B206B6;
        Sun, 26 Apr 2020 06:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587884014;
        bh=AX72LrszXZVr3GndLIzHGcqKzv1x/vpPvEudF3/4TvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gljatc4u33OL5OuVaTllZP9PkbFfwTwkMAavfoa1DUFT1JAWb5UcpFBLjl1daoEJC
         euW/AlmgKN/fS9xkDkCfGsXO7Vr20FZ/KpbVFWxJWWZ1DsbAyAKUpuC4FmG/xMgy2H
         2IXB54siLdZtgYVxLNS6k7btgpKOz78DbuUtkGTY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Borislav Petkov <bp@alien8.de>, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [BUGFIX PATCH v2 1/1] bootconfig: Fix to remove bootconfig data from initrd while boot
Date:   Sun, 26 Apr 2020 15:53:30 +0900
Message-Id: <158788401014.24243.17424755854115077915.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424195833.1487a1a0@oasis.local.home>
References: <20200424195833.1487a1a0@oasis.local.home>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Fixes: 7684b8582c24 ("bootconfig: Load boot config from the tail of initrd")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 Changes in v2:
	- Make new functions __init.
	- Do nothing if CONFIG_BLK_DEV_INITRD=n
---
 init/main.c |   69 ++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 17 deletions(-)

diff --git a/init/main.c b/init/main.c
index 295aec3a1a7a..f55cb15f23d2 100644
--- a/init/main.c
+++ b/init/main.c
@@ -258,6 +258,47 @@ static int __init loglevel(char *str)
 
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
@@ -358,9 +399,12 @@ static void __init setup_boot_config(const char *cmdline)
 	int pos;
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
@@ -368,27 +412,12 @@ static void __init setup_boot_config(const char *cmdline)
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
@@ -421,8 +450,14 @@ static void __init setup_boot_config(const char *cmdline)
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

