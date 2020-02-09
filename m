Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A183C35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 13:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30F32080C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 13:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581253520;
	bh=m4uTi4EUt+AZH+yMYrsgLrZveDwyhEw2EO/mrXBTSPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A4rVo0zLXVQKQ+WoycbD4lwjFH2pe7SWFVED50nu3dXR5nSsQ+v+86X0OhDaauKTB
	 cCtfDycE2tazohwC4nHldf9Iy92aQg7wvT/axJ7VzJyO4dIaUhYsI1QoBJUFUE23G0
	 u75xB9bF4aL25z+vJ36eJdMj898jiqaq0wWCj58I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgBINFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 08:05:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727654AbgBINFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 08:05:19 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98C6420733;
        Sun,  9 Feb 2020 13:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581253518;
        bh=m4uTi4EUt+AZH+yMYrsgLrZveDwyhEw2EO/mrXBTSPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qtxKt6ck5Dw5DqiS5QxxSe8zOa4waDLou70WLXGpSGYUiQAoCwDY2xSKMkV20HuoD
         a+AvWZsFnx/QFaAwb9kMKeNHgaJ7EEimS6oSLF2Skr7dR12Uw21o5RGHGFVERMabWG
         xau16WnAn3F4c/2UbXV60eNptGvQcu9g771BqLgE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] tools/bootconfig: Suppress non-error messages
Date:   Sun,  9 Feb 2020 22:05:13 +0900
Message-Id: <158125351377.16911.13283712972275131160.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87lfpd1gi7.fsf@mpe.ellerman.id.au>
References: <87lfpd1gi7.fsf@mpe.ellerman.id.au>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suppress non-error messages when applying new bootconfig
to initrd image. To enable it, replace printf for error
message with pr_err() macro.
This also adds a testcase for this fix.

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/main.c             |   28 ++++++++++++++--------------
 tools/bootconfig/test-bootconfig.sh |    9 +++++++++
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 47f488458328..e18eeb070562 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -140,7 +140,7 @@ int load_xbc_from_initrd(int fd, char **buf)
 		return 0;
 
 	if (lseek(fd, -8, SEEK_END) < 0) {
-		printf("Failed to lseek: %d\n", -errno);
+		pr_err("Failed to lseek: %d\n", -errno);
 		return -errno;
 	}
 
@@ -155,7 +155,7 @@ int load_xbc_from_initrd(int fd, char **buf)
 		return 0;
 
 	if (lseek(fd, stat.st_size - 8 - size, SEEK_SET) < 0) {
-		printf("Failed to lseek: %d\n", -errno);
+		pr_err("Failed to lseek: %d\n", -errno);
 		return -errno;
 	}
 
@@ -166,7 +166,7 @@ int load_xbc_from_initrd(int fd, char **buf)
 	/* Wrong Checksum, maybe no boot config here */
 	rcsum = checksum((unsigned char *)*buf, size);
 	if (csum != rcsum) {
-		printf("checksum error: %d != %d\n", csum, rcsum);
+		pr_err("checksum error: %d != %d\n", csum, rcsum);
 		return 0;
 	}
 
@@ -185,13 +185,13 @@ int show_xbc(const char *path)
 
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
-		printf("Failed to open initrd %s: %d\n", path, fd);
+		pr_err("Failed to open initrd %s: %d\n", path, fd);
 		return -errno;
 	}
 
 	ret = load_xbc_from_initrd(fd, &buf);
 	if (ret < 0)
-		printf("Failed to load a boot config from initrd: %d\n", ret);
+		pr_err("Failed to load a boot config from initrd: %d\n", ret);
 	else
 		xbc_show_compact_tree();
 
@@ -209,7 +209,7 @@ int delete_xbc(const char *path)
 
 	fd = open(path, O_RDWR);
 	if (fd < 0) {
-		printf("Failed to open initrd %s: %d\n", path, fd);
+		pr_err("Failed to open initrd %s: %d\n", path, fd);
 		return -errno;
 	}
 
@@ -222,7 +222,7 @@ int delete_xbc(const char *path)
 	pr_output = 1;
 	if (size < 0) {
 		ret = size;
-		printf("Failed to load a boot config from initrd: %d\n", ret);
+		pr_err("Failed to load a boot config from initrd: %d\n", ret);
 	} else if (size > 0) {
 		ret = fstat(fd, &stat);
 		if (!ret)
@@ -245,7 +245,7 @@ int apply_xbc(const char *path, const char *xbc_path)
 
 	ret = load_xbc_file(xbc_path, &buf);
 	if (ret < 0) {
-		printf("Failed to load %s : %d\n", xbc_path, ret);
+		pr_err("Failed to load %s : %d\n", xbc_path, ret);
 		return ret;
 	}
 	size = strlen(buf) + 1;
@@ -262,7 +262,7 @@ int apply_xbc(const char *path, const char *xbc_path)
 	/* Check the data format */
 	ret = xbc_init(buf);
 	if (ret < 0) {
-		printf("Failed to parse %s: %d\n", xbc_path, ret);
+		pr_err("Failed to parse %s: %d\n", xbc_path, ret);
 		free(data);
 		free(buf);
 		return ret;
@@ -279,20 +279,20 @@ int apply_xbc(const char *path, const char *xbc_path)
 	/* Remove old boot config if exists */
 	ret = delete_xbc(path);
 	if (ret < 0) {
-		printf("Failed to delete previous boot config: %d\n", ret);
+		pr_err("Failed to delete previous boot config: %d\n", ret);
 		return ret;
 	}
 
 	/* Apply new one */
 	fd = open(path, O_RDWR | O_APPEND);
 	if (fd < 0) {
-		printf("Failed to open %s: %d\n", path, fd);
+		pr_err("Failed to open %s: %d\n", path, fd);
 		return fd;
 	}
 	/* TODO: Ensure the @path is initramfs/initrd image */
 	ret = write(fd, data, size + 8);
 	if (ret < 0) {
-		printf("Failed to apply a boot config: %d\n", ret);
+		pr_err("Failed to apply a boot config: %d\n", ret);
 		return ret;
 	}
 	close(fd);
@@ -334,12 +334,12 @@ int main(int argc, char **argv)
 	}
 
 	if (apply && delete) {
-		printf("Error: You can not specify both -a and -d at once.\n");
+		pr_err("Error: You can not specify both -a and -d at once.\n");
 		return usage();
 	}
 
 	if (optind >= argc) {
-		printf("Error: No initrd is specified.\n");
+		pr_err("Error: No initrd is specified.\n");
 		return usage();
 	}
 
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index 87725e8723f8..1de06de328e2 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -64,6 +64,15 @@ echo "File size check"
 new_size=$(stat -c %s $INITRD)
 xpass test $new_size -eq $initrd_size
 
+echo "No error messge while applying"
+OUTFILE=`mktemp tempout-XXXX`
+dd if=/dev/zero of=$INITRD bs=4096 count=1
+printf " \0\0\0 \0\0\0" >> $INITRD
+$BOOTCONF -a $TEMPCONF $INITRD > $OUTFILE 2>&1
+xfail grep -i "failed" $OUTFILE
+xfail grep -i "error" $OUTFILE
+rm $OUTFILE
+
 echo "Max node number check"
 
 echo -n > $TEMPCONF

