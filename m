Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6ED6C11D83
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C34D24673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582183631;
	bh=gNpQOo75W4YLRpD51kQW68GQAjp3lojNEFVKa6mHe7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s5W+2HAgl/86IEDd2orleTQVczeryfxFtu+bsHCCWPeBaNukP9c4NY1gMeJ8Qo3r3
	 5fQAOCAX7x4F1SP+uUng91mQd7u6tC0bmnZnGO6ASjazFNhkD8hoSCLdSkBEeqFsev
	 xJENJiNR0+nlpY4qXceuPxBSlI4tXIE6uDv09h7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgBTH1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:27:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbgBTH1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:27:09 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D4102465D;
        Thu, 20 Feb 2020 07:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582183628;
        bh=gNpQOo75W4YLRpD51kQW68GQAjp3lojNEFVKa6mHe7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EBGmTpzTuVNtwmiS+mg2G7GbrFtovAIX8gnvnGmlYlkltniNlVM25lbZf7EtXKL0N
         3fwX+ISRSVMEdt9zgsieJXaSpno4qIGL7IKlLt7aJbRz0M5InM54xkdv4y0MmHJ4sb
         pE5uf30w56uOj+UfKWGRDWn/4gRIz0PbsjLCIngw=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4/8] bootconfig: Remove unneeded checksum
Date:   Thu, 20 Feb 2020 16:27:03 +0900
Message-Id: <158218362341.6940.14280785204151694189.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158218358363.6940.18380270211351882136.stgit@devnote2>
References: <158218358363.6940.18380270211351882136.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove checksum of bootconfig because we already use a magic
word to identify bootconfig. This checksum was used for
checking whether there is a bootconfig at the end of initrd
or not. Since we have a bootconfig magic word to identify
the bootconfig data, we do not this checksum anymore.

Thus the block image of the initrd file with bootconfig is
as follows.

[initrd][bootconfig][size(u32)][#BOOTCONFIG\n]

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/admin-guide/bootconfig.rst |    6 ++--
 init/main.c                              |   20 +-------------
 tools/bootconfig/main.c                  |   42 ++++++------------------------
 tools/bootconfig/test-bootconfig.sh      |    2 +
 4 files changed, 15 insertions(+), 55 deletions(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index 5e7609936507..48675052c963 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -102,10 +102,10 @@ Boot Kernel With a Boot Config
 ==============================
 
 Since the boot configuration file is loaded with initrd, it will be added
-to the end of the initrd (initramfs) image file with size, checksum and
-12-byte magic word as below.
+to the end of the initrd (initramfs) image file with 4-byte size and 12-byte
+magic word as below.
 
-[initrd][bootconfig][size(u32)][checksum(u32)][#BOOTCONFIG\n]
+[initrd][bootconfig][size][#BOOTCONFIG\n]
 
 The Linux kernel decodes the last part of the initrd image in memory to
 get the boot configuration data.
diff --git a/init/main.c b/init/main.c
index 671dd355fe9b..7c4ca805562a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -335,16 +335,6 @@ static char * __init xbc_make_cmdline(const char *key)
 	return new_cmdline;
 }
 
-u32 boot_config_checksum(unsigned char *p, u32 size)
-{
-	u32 ret = 0;
-
-	while (size--)
-		ret += *p++;
-
-	return ret;
-}
-
 static int __init bootconfig_params(char *param, char *val,
 				    const char *unused, void *arg)
 {
@@ -359,7 +349,7 @@ static int __init bootconfig_params(char *param, char *val,
 static void __init setup_boot_config(const char *cmdline)
 {
 	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
-	u32 size, csum;
+	u32 size;
 	char *data, *copy;
 	u32 *hdr;
 	int ret;
@@ -378,9 +368,8 @@ static void __init setup_boot_config(const char *cmdline)
 	if (memcmp(data, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN))
 		goto not_found;
 
-	hdr = (u32 *)(data - 8);
+	hdr = (u32 *)(data - sizeof(u32));
 	size = hdr[0];
-	csum = hdr[1];
 
 	if (size >= XBC_DATA_MAX) {
 		pr_err("bootconfig size %d greater than max size %d\n",
@@ -392,11 +381,6 @@ static void __init setup_boot_config(const char *cmdline)
 	if ((unsigned long)data < initrd_start)
 		goto not_found;
 
-	if (boot_config_checksum((unsigned char *)data, size) != csum) {
-		pr_err("bootconfig checksum failed\n");
-		return;
-	}
-
 	copy = memblock_alloc(size + 1, SMP_CACHE_BYTES);
 	if (!copy) {
 		pr_err("Failed to allocate memory for bootconfig\n");
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index a9b97814d1a9..01acb86c6273 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -75,17 +75,6 @@ static void xbc_show_compact_tree(void)
 	}
 }
 
-/* Simple real checksum */
-int checksum(unsigned char *buf, int len)
-{
-	int i, sum = 0;
-
-	for (i = 0; i < len; i++)
-		sum += buf[i];
-
-	return sum;
-}
-
 #define PAGE_SIZE	4096
 
 int load_xbc_fd(int fd, char **buf, int size)
@@ -128,14 +117,14 @@ int load_xbc_from_initrd(int fd, char **buf)
 {
 	struct stat stat;
 	int ret;
-	u32 size = 0, csum = 0, rcsum;
+	u32 size = 0;
 	char magic[BOOTCONFIG_MAGIC_LEN];
 
 	ret = fstat(fd, &stat);
 	if (ret < 0)
 		return -errno;
 
-	if (stat.st_size < 8 + BOOTCONFIG_MAGIC_LEN)
+	if (stat.st_size < 4 + BOOTCONFIG_MAGIC_LEN)
 		return 0;
 
 	if (lseek(fd, -BOOTCONFIG_MAGIC_LEN, SEEK_END) < 0) {
@@ -148,7 +137,7 @@ int load_xbc_from_initrd(int fd, char **buf)
 	if (memcmp(magic, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN) != 0)
 		return 0;
 
-	if (lseek(fd, -(8 + BOOTCONFIG_MAGIC_LEN), SEEK_END) < 0) {
+	if (lseek(fd, -(4 + BOOTCONFIG_MAGIC_LEN), SEEK_END) < 0) {
 		pr_err("Failed to lseek: %d\n", -errno);
 		return -errno;
 	}
@@ -156,16 +145,13 @@ int load_xbc_from_initrd(int fd, char **buf)
 	if (read(fd, &size, sizeof(u32)) < 0)
 		return -errno;
 
-	if (read(fd, &csum, sizeof(u32)) < 0)
-		return -errno;
-
 	/* Wrong size error  */
-	if (stat.st_size < size + 8 + BOOTCONFIG_MAGIC_LEN) {
+	if (stat.st_size < size + 4 + BOOTCONFIG_MAGIC_LEN) {
 		pr_err("bootconfig size is too big\n");
 		return -E2BIG;
 	}
 
-	if (lseek(fd, stat.st_size - (size + 8 + BOOTCONFIG_MAGIC_LEN),
+	if (lseek(fd, stat.st_size - (size + 4 + BOOTCONFIG_MAGIC_LEN),
 		  SEEK_SET) < 0) {
 		pr_err("Failed to lseek: %d\n", -errno);
 		return -errno;
@@ -175,13 +161,6 @@ int load_xbc_from_initrd(int fd, char **buf)
 	if (ret < 0)
 		return ret;
 
-	/* Wrong Checksum */
-	rcsum = checksum((unsigned char *)*buf, size);
-	if (csum != rcsum) {
-		pr_err("checksum error: %d != %d\n", csum, rcsum);
-		return -EINVAL;
-	}
-
 	ret = xbc_init(*buf);
 	/* Wrong data */
 	if (ret < 0)
@@ -233,7 +212,7 @@ int delete_xbc(const char *path)
 		ret = fstat(fd, &stat);
 		if (!ret)
 			ret = ftruncate(fd, stat.st_size
-					- size - 8 - BOOTCONFIG_MAGIC_LEN);
+					- size - 4 - BOOTCONFIG_MAGIC_LEN);
 		if (ret)
 			ret = -errno;
 	} /* Ignore if there is no boot config in initrd */
@@ -246,7 +225,7 @@ int delete_xbc(const char *path)
 
 int apply_xbc(const char *path, const char *xbc_path)
 {
-	u32 size, csum;
+	u32 size;
 	char *buf, *data;
 	int ret, fd;
 
@@ -256,15 +235,13 @@ int apply_xbc(const char *path, const char *xbc_path)
 		return ret;
 	}
 	size = strlen(buf) + 1;
-	csum = checksum((unsigned char *)buf, size);
 
 	/* Prepare xbc_path data */
-	data = malloc(size + 8);
+	data = malloc(size + 4);
 	if (!data)
 		return -ENOMEM;
 	strcpy(data, buf);
 	*(u32 *)(data + size) = size;
-	*(u32 *)(data + size + 4) = csum;
 
 	/* Check the data format */
 	ret = xbc_init(buf);
@@ -277,7 +254,6 @@ int apply_xbc(const char *path, const char *xbc_path)
 	printf("Apply %s to %s\n", xbc_path, path);
 	printf("\tNumber of nodes: %d\n", ret);
 	printf("\tSize: %u bytes\n", (unsigned int)size);
-	printf("\tChecksum: %d\n", (unsigned int)csum);
 
 	/* TODO: Check the options by schema */
 	xbc_destroy_all();
@@ -297,7 +273,7 @@ int apply_xbc(const char *path, const char *xbc_path)
 		return fd;
 	}
 	/* TODO: Ensure the @path is initramfs/initrd image */
-	ret = write(fd, data, size + 8);
+	ret = write(fd, data, size + 4);
 	if (ret < 0) {
 		pr_err("Failed to apply a boot config: %d\n", ret);
 		return ret;
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index adafb7c50940..c5965eff62c5 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -49,7 +49,7 @@ xpass $BOOTCONF -a $TEMPCONF $INITRD
 new_size=$(stat -c %s $INITRD)
 
 echo "File size check"
-xpass test $new_size -eq $(expr $bconf_size + $initrd_size + 9 + 12)
+xpass test $new_size -eq $(expr $bconf_size + $initrd_size + 5 + 12)
 
 echo "Apply command repeat test"
 xpass $BOOTCONF -a $TEMPCONF $INITRD

