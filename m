Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D93DC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1603C221F5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vge5HBC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgGNHDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgGNHDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:03:06 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C383AC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 00:03:05 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ls15so1139805pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 00:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Rdhn+d7zXGOEToxM82erlKSD9gBZ1meITiSFSsl/lrA=;
        b=Vge5HBC0Yt8vHi/9y1JnmAnlAiguP52F9F2CVrSwsidWarpyQWWwbuPN6Xz1sXNOTm
         8z70h0ACOByOQjM39HJpiZYxEAy0/e6IEkw9Va8IRXkueXpKv/OPTCRpSI8ZHILs1mpF
         8cpQg2X/7A8RLM6BpBXP++ryOExmm5xcVqh5Miw8pM4D3Gl2Vb6xwzslfNZ2ubQTfzYO
         iLN4LKiIUFrdhV5VPviUmS2OshpUXhpaVvFegR0H85t05wPWMarPbvmtUAVrweKB+rHo
         aUvJLQ5/3/8CNQFlS7r2pcSQD/P3x23RthY0LH7SwccFp66Zc5XgxhkORvkIdEG/BvMR
         NUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rdhn+d7zXGOEToxM82erlKSD9gBZ1meITiSFSsl/lrA=;
        b=soJ74xd35e5aG8Twh1irfRioFhm0//4r4zB3Pavb/ClvgzK6sBfRFpxcTdAeUgzMMI
         TtSOYD++OsI5ODPMaT6ayBEdZXhs3M39YjSy/NEbDndD/FKPoO9PoVb9p3MDku2EMDVW
         2keWtX4ofwFdA/PZ0JgGIUyJS6mCTDIncNvbpVKNnqxRMt/jhmpv6rZ7pDMA1jBKS4Be
         Yv9qIYCggUzirOB0N1050CojdEK/d/UfaH9JLMvOqdObgt9RaLsiI4nkqCcAKtQD6cjU
         /1Q9PWZUYJDWggIzIBhmnuRUjFdUZLOmSEX5OcsfNrtw9Z+uAUDS4B+CJWpZGxb12mtG
         ZNIg==
X-Gm-Message-State: AOAM532yA0RsUdmE8STQXoDHtfe4P5I0ZuosJF3QYhaBeY+PPTs+/oXo
        Jcx7z0380Ty2MddZBtyoE7Y=
X-Google-Smtp-Source: ABdhPJynek5IyZk2HEZ8jWK3i966lmxFOQihZiwe+TnIVaXDQ2HfggtzG9/7BJsvkhUOzzGMXLZ8sA==
X-Received: by 2002:a17:90a:5218:: with SMTP id v24mr2782651pjh.223.1594710185183;
        Tue, 14 Jul 2020 00:03:05 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id o18sm18118277pfu.138.2020.07.14.00.03.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 00:03:04 -0700 (PDT)
From:   zhouchuangao <chuangaozhou@gmail.com>
X-Google-Original-From: zhouchuangao <zhouchuangao@xiaomi.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux@dominikbrodowski.net, pc@cjr.nz, axboe@kernel.dk,
        dhowells@redhat.com, linux-kernel@vger.kernel.org,
        zhouchuangao <zhouchuangao@xiaomi.com>
Subject: [PATCH] init/do_mounts: fix a coding style error
Date:   Tue, 14 Jul 2020 15:02:58 +0800
Message-Id: <1594710178-27825-1-git-send-email-zhouchuangao@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix code style errors reported by scripts/checkpatch.pl.

Signed-off-by: zhouchuangao <zhouchuangao@xiaomi.com>
---
 init/do_mounts.c | 55 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 29d326b..89bf389 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -101,7 +101,8 @@ static int match_dev_by_uuid(struct device *dev, const void *data)
  * by filesystem UUIDs.
  *
  * If @uuid_str is followed by a "/PARTNROFF=%d", then the number will be
- * extracted and used as an offset from the partition identified by the UUID.
+ * extracted and used as an offset from the partition identified by the
+ * UUID.
  *
  * Returns the matching dev_t on success or 0 on failure.
  */
@@ -249,7 +250,7 @@ dev_t name_to_dev_t(const char *name)
 #endif
 
 	if (strncmp(name, "/dev/", 5) != 0) {
-		unsigned maj, min, offset;
+		unsigned int maj, min, offset;
 		char dummy;
 
 		if ((sscanf(name, "%u:%u%c", &maj, &min, &dummy) == 2) ||
@@ -412,8 +413,7 @@ static int __init do_mount_root(const char *name, const char *fs,
 	ksys_chdir("/root");
 	s = current->fs->pwd.dentry->d_sb;
 	ROOT_DEV = s->s_dev;
-	printk(KERN_INFO
-	       "VFS: Mounted root (%s filesystem)%s on device %u:%u.\n",
+	pr_info("VFS: Mounted root (%s filesystem)%s on device %u:%u.\n",
 	       s->s_type->name,
 	       sb_rdonly(s) ? " readonly" : "",
 	       MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
@@ -438,24 +438,25 @@ void __init mount_block_root(char *name, int flags)
 	for (p = fs_names; *p; p += strlen(p)+1) {
 		int err = do_mount_root(name, p, flags, root_mount_data);
 		switch (err) {
-			case 0:
-				goto out;
-			case -EACCES:
-			case -EINVAL:
-				continue;
+		case 0:
+			goto out;
+		case -EACCES:
+		case -EINVAL:
+			continue;
 		}
-	        /*
+		/*
 		 * Allow the user to distinguish between failed sys_open
 		 * and bad superblock on root device.
 		 * and give them a list of the available devices
 		 */
-		printk("VFS: Cannot open root device \"%s\" or %s: error %d\n",
+		pr_info("VFS: Cannot open root device \"%s\" or %s: error %d\n",
 				root_device_name, b, err);
-		printk("Please append a correct \"root=\" boot option; here are the available partitions:\n");
+		pr_info("Please append a correct \"root=\" boot option; "
+			"here are the available partitions:\n");
 
 		printk_all_partitions();
 #ifdef CONFIG_DEBUG_BLOCK_EXT_DEVT
-		printk("DEBUG_BLOCK_EXT_DEVT is enabled, you need to specify "
+		pr_info("DEBUG_BLOCK_EXT_DEVT is enabled, you need to specify "
 		       "explicit textual name for \"root=\" boot option.\n");
 #endif
 		panic("VFS: Unable to mount root fs on %s", b);
@@ -465,17 +466,17 @@ void __init mount_block_root(char *name, int flags)
 		goto retry;
 	}
 
-	printk("List of all partitions:\n");
+	pr_info("List of all partitions:\n");
 	printk_all_partitions();
-	printk("No filesystem could mount root, tried: ");
+	pr_info("No filesystem could mount root, tried: ");
 	for (p = fs_names; *p; p += strlen(p)+1)
-		printk(" %s", p);
-	printk("\n");
+		pr_info(" %s", p);
+	pr_info("\n");
 	panic("VFS: Unable to mount root fs on %s", b);
 out:
 	put_page(page);
 }
- 
+
 #ifdef CONFIG_ROOT_NFS
 
 #define NFSROOT_TIMEOUT_MIN	5
@@ -560,6 +561,7 @@ void __init change_floppy(char *fmt, ...)
 	char c;
 	int fd;
 	va_list args;
+
 	va_start(args, fmt);
 	vsprintf(buf, fmt, args);
 	va_end(args);
@@ -568,7 +570,7 @@ void __init change_floppy(char *fmt, ...)
 		ksys_ioctl(fd, FDEJECT, 0);
 		ksys_close(fd);
 	}
-	printk(KERN_NOTICE "VFS: Insert %s and press ENTER\n", buf);
+	pr_notice("VFS: Insert %s and press ENTER\n", buf);
 	fd = ksys_open("/dev/console", O_RDWR, 0);
 	if (fd >= 0) {
 		ksys_ioctl(fd, TCGETS, (long)&termios);
@@ -585,27 +587,27 @@ void __init change_floppy(char *fmt, ...)
 void __init mount_root(void)
 {
 #ifdef CONFIG_ROOT_NFS
-	if (ROOT_DEV == Root_NFS) {
+	if (Root_NFS == ROOT_DEV) {
 		if (mount_nfs_root())
 			return;
 
-		printk(KERN_ERR "VFS: Unable to mount root fs via NFS, trying floppy.\n");
+		pr_err("VFS: Unable to mount root fs via NFS, trying floppy.\n");
 		ROOT_DEV = Root_FD0;
 	}
 #endif
 #ifdef CONFIG_CIFS_ROOT
-	if (ROOT_DEV == Root_CIFS) {
+	if (Root_CIFS == ROOT_DEV) {
 		if (mount_cifs_root())
 			return;
 
-		printk(KERN_ERR "VFS: Unable to mount root fs via SMB, trying floppy.\n");
+		pr_err("VFS: Unable to mount root fs via SMB, trying floppy.\n");
 		ROOT_DEV = Root_FD0;
 	}
 #endif
 #ifdef CONFIG_BLK_DEV_FD
 	if (MAJOR(ROOT_DEV) == FLOPPY_MAJOR) {
 		/* rd_doload is 2 for a dual initrd/ramload setup */
-		if (rd_doload==2) {
+		if (rd_doload == 2) {
 			if (rd_load_disk(1)) {
 				ROOT_DEV = Root_RAM1;
 				root_device_name = NULL;
@@ -633,7 +635,7 @@ void __init prepare_namespace(void)
 	int is_floppy;
 
 	if (root_delay) {
-		printk(KERN_INFO "Waiting %d sec before mounting root device...\n",
+		pr_info("Waiting %d sec before mounting root device...\n",
 		       root_delay);
 		ssleep(root_delay);
 	}
@@ -666,8 +668,7 @@ void __init prepare_namespace(void)
 
 	/* wait for any asynchronous scanning to complete */
 	if ((ROOT_DEV == 0) && root_wait) {
-		printk(KERN_INFO "Waiting for root device %s...\n",
-			saved_root_name);
+		pr_info("Waiting for root device %s...\n", saved_root_name);
 		while (driver_probe_done() != 0 ||
 			(ROOT_DEV = name_to_dev_t(saved_root_name)) == 0)
 			msleep(5);
-- 
2.7.4

