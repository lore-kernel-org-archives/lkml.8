Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A44EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 03:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22AB120738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 03:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arG8xAF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgEUDlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 23:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgEUDlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 23:41:24 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C44C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 20:41:23 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x15so2651271pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 20:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zPOt+rZy3yVqIjlCQ22SZH1YNq9iJkRuAJAifhQaXQY=;
        b=arG8xAF127Ec6yLkr0Mn2iYX5jMh506ig9Tb9Iu3xoEVFlPK7xDYbZvAoqzk/mKg9j
         pn2xPk7/cfFHbj/FpHbBWnjOad5Uq3pAWv+hj254jZkuoORgzybGVMFLrIIt2OOvcQWu
         iMDltWkBowSJZSY3sD1CARTEIyKi4BtehtcyBBwiklp8iCRMoaNDVupN/iU1AaZNufip
         JixdVc6pPOHJADjCaHDsy4UDwFlt68FhbrWv6kf0HCAwo41kY0ax3k6zV6RlhpcBA7Gi
         2kJkKaPCsszTQu/PY9MWJhs+owCQtNA/paNlyUNKxyyYll2bHuO1RpeiHE1b7475we8i
         Z8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zPOt+rZy3yVqIjlCQ22SZH1YNq9iJkRuAJAifhQaXQY=;
        b=c174W1XGnaRPMTLcwwNqGOF0jyoihWMgWl/xAXjBCUtZ3BRt9nqJCQY6cn6Z5vaDCu
         2/wcl25ZThmZIrLeeZqimHQKlWu8SUVQ6DZwOiFDfoX3dAP6t5koSmT1Yju83MrEX1Vx
         6wIJP4wS9caprWUlSmM28vadzgP269cfgESkcQ2HREEL9ZklDWe7pjYEHN+emiBckMOQ
         BMET9Fe3MEBgy6MFP3OMpEehckKD89k6x+g5MJnKjge62bmVoNEuKGuHinjsJOYvkn/e
         /rZbisn2a1yYs6Eb5hGIVi0QuAA/9feX6Its8B8wvWl8hpSDHjum7+Nzf6MVlnMR45GV
         eB7g==
X-Gm-Message-State: AOAM530GyKD7Uq2UNBa8Sb2rmV8LGnywmdIl6+wU1+TD1nP6b/dLfphO
        8JVC23kZ+9JBTO5ValGh77ekUByb
X-Google-Smtp-Source: ABdhPJxsbWe9rftealA9Dk7wU/jTJwfBW3Wbvjzfe6ktSPJa+Yp1n1rEjxtRqqEgOs6OKEdABBja1A==
X-Received: by 2002:a63:7d3:: with SMTP id 202mr6772464pgh.279.1590032483032;
        Wed, 20 May 2020 20:41:23 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id d126sm3271454pfc.81.2020.05.20.20.41.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2020 20:41:22 -0700 (PDT)
From:   zhouchuangao <chuangaozhou@gmail.com>
X-Google-Original-From: zhouchuangao <zhouchuangao@xiaomi.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux@dominikbrodowski.net, zhouchuangao@xiaomi.com, tytso@mit.edu,
        davem@davemloft.net, pc@cjr.nz, dhowells@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] init/do_mounts: fix a coding style error
Date:   Thu, 21 May 2020 11:41:12 +0800
Message-Id: <1590032472-16082-1-git-send-email-zhouchuangao@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix code style errors reported by scripts/checkpatch.pl.

Signed-off-by: zhouchuangao <zhouchuangao@xiaomi.com>
---
 init/do_mounts.c | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 29d326b..2f8bd41 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -249,7 +249,7 @@ dev_t name_to_dev_t(const char *name)
 #endif
 
 	if (strncmp(name, "/dev/", 5) != 0) {
-		unsigned maj, min, offset;
+		unsigned int maj, min, offset;
 		char dummy;
 
 		if ((sscanf(name, "%u:%u%c", &maj, &min, &dummy) == 2) ||
@@ -412,8 +412,7 @@ static int __init do_mount_root(const char *name, const char *fs,
 	ksys_chdir("/root");
 	s = current->fs->pwd.dentry->d_sb;
 	ROOT_DEV = s->s_dev;
-	printk(KERN_INFO
-	       "VFS: Mounted root (%s filesystem)%s on device %u:%u.\n",
+	pr_info("VFS: Mounted root (%s filesystem)%s on device %u:%u.\n",
 	       s->s_type->name,
 	       sb_rdonly(s) ? " readonly" : "",
 	       MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
@@ -437,25 +436,26 @@ void __init mount_block_root(char *name, int flags)
 retry:
 	for (p = fs_names; *p; p += strlen(p)+1) {
 		int err = do_mount_root(name, p, flags, root_mount_data);
+
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
+		pr_info("Please append a correct \"root=\" boot option; here are the available partitions:\n");
 
 		printk_all_partitions();
 #ifdef CONFIG_DEBUG_BLOCK_EXT_DEVT
-		printk("DEBUG_BLOCK_EXT_DEVT is enabled, you need to specify "
+		pr_info("DEBUG_BLOCK_EXT_DEVT is enabled, you need to specify "
 		       "explicit textual name for \"root=\" boot option.\n");
 #endif
 		panic("VFS: Unable to mount root fs on %s", b);
@@ -465,17 +465,17 @@ void __init mount_block_root(char *name, int flags)
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
@@ -560,6 +560,7 @@ void __init change_floppy(char *fmt, ...)
 	char c;
 	int fd;
 	va_list args;
+
 	va_start(args, fmt);
 	vsprintf(buf, fmt, args);
 	va_end(args);
@@ -568,7 +569,7 @@ void __init change_floppy(char *fmt, ...)
 		ksys_ioctl(fd, FDEJECT, 0);
 		ksys_close(fd);
 	}
-	printk(KERN_NOTICE "VFS: Insert %s and press ENTER\n", buf);
+	pr_notice("VFS: Insert %s and press ENTER\n", buf);
 	fd = ksys_open("/dev/console", O_RDWR, 0);
 	if (fd >= 0) {
 		ksys_ioctl(fd, TCGETS, (long)&termios);
@@ -585,27 +586,27 @@ void __init change_floppy(char *fmt, ...)
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
@@ -633,7 +634,7 @@ void __init prepare_namespace(void)
 	int is_floppy;
 
 	if (root_delay) {
-		printk(KERN_INFO "Waiting %d sec before mounting root device...\n",
+		pr_info("Waiting %d sec before mounting root device...\n",
 		       root_delay);
 		ssleep(root_delay);
 	}
@@ -666,8 +667,7 @@ void __init prepare_namespace(void)
 
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

