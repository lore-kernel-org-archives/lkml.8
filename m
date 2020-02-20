Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDB4C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B76324676
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582201129;
	bh=xF8MoQDBs9qynEtE627xfPX8j+CvCOnGAOnDOMBq+N0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jdsl1Vb2kyQVLngKLxdyjRhDihlnsgjcbe7Jnq7+vEj/JE41MAfjOAEud5Zg8H4MO
	 jlvSdbYoCRVz2QUWKyiwnxRoygtChJ3tGvvyZnt1wReUZn7K8EpcEE7jiRuD9ZO1Uf
	 vv9hdOeA3J1fcoko05ELHyXrl8xLpkEeMtG3qTnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgBTMSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 07:18:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727761AbgBTMSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:18:48 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3053D24673;
        Thu, 20 Feb 2020 12:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582201127;
        bh=xF8MoQDBs9qynEtE627xfPX8j+CvCOnGAOnDOMBq+N0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mNZphXdmJmF0rtYgQQhXf2i+JglLE5QJqGxudRUCEEWNzUmNPVsSgmIUctZpO8qgB
         6cBDDGkWFxgofAEA/HoDuR+Iti8ipe2k/mypKZQMT1nwlXwg/ILxjRzXwtM1hfV7hk
         WTlpYquuJe5x5OqtDRR+mwLY8t764jZrhdvJCTYo=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 2/8] bootconfig: Add bootconfig magic word for indicating bootconfig explicitly
Date:   Thu, 20 Feb 2020 21:18:42 +0900
Message-Id: <158220112263.26565.3944814205960612841.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158220110257.26565.4812934676257459744.stgit@devnote2>
References: <158220110257.26565.4812934676257459744.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bootconfig magic word to the end of bootconfig on initrd
image for indicating explicitly the bootconfig is there.
Also tools/bootconfig treats wrong size or wrong checksum or
parse error as an error, because if there is a bootconfig magic
word, there must be a bootconfig.

The bootconfig magic word is "#BOOTCONFIG\n", 12 bytes word.
Thus the block image of the initrd file with bootconfig is
as follows.

[Initrd][bootconfig][size][csum][#BOOTCONFIG\n]

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 V2: Update Kconfig comment.
---
 Documentation/admin-guide/bootconfig.rst |   10 +++++--
 include/linux/bootconfig.h               |    3 ++
 init/Kconfig                             |    2 +
 init/main.c                              |    6 +++-
 tools/bootconfig/main.c                  |   43 ++++++++++++++++++++++--------
 tools/bootconfig/test-bootconfig.sh      |    2 +
 6 files changed, 49 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index b342a6796392..5e7609936507 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -102,9 +102,13 @@ Boot Kernel With a Boot Config
 ==============================
 
 Since the boot configuration file is loaded with initrd, it will be added
-to the end of the initrd (initramfs) image file. The Linux kernel decodes
-the last part of the initrd image in memory to get the boot configuration
-data.
+to the end of the initrd (initramfs) image file with size, checksum and
+12-byte magic word as below.
+
+[initrd][bootconfig][size(u32)][checksum(u32)][#BOOTCONFIG\n]
+
+The Linux kernel decodes the last part of the initrd image in memory to
+get the boot configuration data.
 Because of this "piggyback" method, there is no need to change or
 update the boot loader and the kernel image itself.
 
diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 7e18c939663e..d11e183fcb54 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -10,6 +10,9 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 
+#define BOOTCONFIG_MAGIC	"#BOOTCONFIG\n"
+#define BOOTCONFIG_MAGIC_LEN	12
+
 /* XBC tree node */
 struct xbc_node {
 	u16 next;
diff --git a/init/Kconfig b/init/Kconfig
index e76e9241552c..6ffaf4940f3e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1231,7 +1231,7 @@ config BOOT_CONFIG
 	  Extra boot config allows system admin to pass a config file as
 	  complemental extension of kernel cmdline when booting.
 	  The boot config file must be attached at the end of initramfs
-	  with checksum and size.
+	  with checksum, size and magic word.
 	  See <file:Documentation/admin-guide/bootconfig.rst> for details.
 
 	  If unsure, say Y.
diff --git a/init/main.c b/init/main.c
index ae4e37681247..fe3ed874c748 100644
--- a/init/main.c
+++ b/init/main.c
@@ -374,7 +374,11 @@ static void __init setup_boot_config(const char *cmdline)
 	if (!initrd_end)
 		goto not_found;
 
-	hdr = (u32 *)(initrd_end - 8);
+	data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
+	if (memcmp(data, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN))
+		goto not_found;
+
+	hdr = (u32 *)(data - 8);
 	size = hdr[0];
 	csum = hdr[1];
 
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index e18eeb070562..742271f019a9 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -131,15 +131,26 @@ int load_xbc_from_initrd(int fd, char **buf)
 	struct stat stat;
 	int ret;
 	u32 size = 0, csum = 0, rcsum;
+	char magic[BOOTCONFIG_MAGIC_LEN];
 
 	ret = fstat(fd, &stat);
 	if (ret < 0)
 		return -errno;
 
-	if (stat.st_size < 8)
+	if (stat.st_size < 8 + BOOTCONFIG_MAGIC_LEN)
 		return 0;
 
-	if (lseek(fd, -8, SEEK_END) < 0) {
+	if (lseek(fd, -BOOTCONFIG_MAGIC_LEN, SEEK_END) < 0) {
+		pr_err("Failed to lseek: %d\n", -errno);
+		return -errno;
+	}
+	if (read(fd, magic, BOOTCONFIG_MAGIC_LEN) < 0)
+		return -errno;
+	/* Check the bootconfig magic bytes */
+	if (memcmp(magic, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN) != 0)
+		return 0;
+
+	if (lseek(fd, -(8 + BOOTCONFIG_MAGIC_LEN), SEEK_END) < 0) {
 		pr_err("Failed to lseek: %d\n", -errno);
 		return -errno;
 	}
@@ -150,11 +161,14 @@ int load_xbc_from_initrd(int fd, char **buf)
 	if (read(fd, &csum, sizeof(u32)) < 0)
 		return -errno;
 
-	/* Wrong size, maybe no boot config here */
-	if (stat.st_size < size + 8)
-		return 0;
+	/* Wrong size error  */
+	if (stat.st_size < size + 8 + BOOTCONFIG_MAGIC_LEN) {
+		pr_err("bootconfig size is too big\n");
+		return -E2BIG;
+	}
 
-	if (lseek(fd, stat.st_size - 8 - size, SEEK_SET) < 0) {
+	if (lseek(fd, stat.st_size - (size + 8 + BOOTCONFIG_MAGIC_LEN),
+		  SEEK_SET) < 0) {
 		pr_err("Failed to lseek: %d\n", -errno);
 		return -errno;
 	}
@@ -163,17 +177,17 @@ int load_xbc_from_initrd(int fd, char **buf)
 	if (ret < 0)
 		return ret;
 
-	/* Wrong Checksum, maybe no boot config here */
+	/* Wrong Checksum */
 	rcsum = checksum((unsigned char *)*buf, size);
 	if (csum != rcsum) {
 		pr_err("checksum error: %d != %d\n", csum, rcsum);
-		return 0;
+		return -EINVAL;
 	}
 
 	ret = xbc_init(*buf);
-	/* Wrong data, maybe no boot config here */
+	/* Wrong data */
 	if (ret < 0)
-		return 0;
+		return ret;
 
 	return size;
 }
@@ -226,7 +240,8 @@ int delete_xbc(const char *path)
 	} else if (size > 0) {
 		ret = fstat(fd, &stat);
 		if (!ret)
-			ret = ftruncate(fd, stat.st_size - size - 8);
+			ret = ftruncate(fd, stat.st_size
+					- size - 8 - BOOTCONFIG_MAGIC_LEN);
 		if (ret)
 			ret = -errno;
 	} /* Ignore if there is no boot config in initrd */
@@ -295,6 +310,12 @@ int apply_xbc(const char *path, const char *xbc_path)
 		pr_err("Failed to apply a boot config: %d\n", ret);
 		return ret;
 	}
+	/* Write a magic word of the bootconfig */
+	ret = write(fd, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
+	if (ret < 0) {
+		pr_err("Failed to apply a boot config magic: %d\n", ret);
+		return ret;
+	}
 	close(fd);
 	free(data);
 
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index 1de06de328e2..adafb7c50940 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -49,7 +49,7 @@ xpass $BOOTCONF -a $TEMPCONF $INITRD
 new_size=$(stat -c %s $INITRD)
 
 echo "File size check"
-xpass test $new_size -eq $(expr $bconf_size + $initrd_size + 9)
+xpass test $new_size -eq $(expr $bconf_size + $initrd_size + 9 + 12)
 
 echo "Apply command repeat test"
 xpass $BOOTCONF -a $TEMPCONF $INITRD

