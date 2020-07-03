Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82132C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5160420771
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCLm88+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgGCGy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 02:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgGCGy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 02:54:29 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2381AC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 23:54:29 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b92so13598897pjc.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 23:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wrm96WwHAY7NcmiKOn3dljT8L1OhqnpuLxqvg48PumA=;
        b=sCLm88+vkuRQY6ys7VFVSVrDtAebX7oYvKYStBKqLq8LA5KxvoGDVYpPxCe6DAM2KK
         gVkbR/39VlRkxGe3FM2wbraa2c9DL3PhOF7wK4yJO8HLUX/Zd+la/1ZR9WDjfbF/r8nY
         KSiV6Sb2Aed1W4EdtxNjwhQrpgU6JNuUIOJ7pgpNrTO4LJG/XdlER0j4Bamrrqq80R9B
         S4rIwSUXSDqRheVC3LNh7h4qlZlqOmA7PejkOLL0DBvunpvdPOawNJD0QnT/Ai7h/ErG
         vOBBU5fnZMFJbeG683ybX6Rr8ewBx6FjQPc4AgCAWzShkoINhWPM8QfB7I05KoHY+Jek
         H4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wrm96WwHAY7NcmiKOn3dljT8L1OhqnpuLxqvg48PumA=;
        b=Yz1b1ttDcPu9MWwwCVbxnyYJU/K3c54EBGQ3+hDRscb735bsJjQPJ9u0loqFhH5R9Y
         V21j2J1XjxJ6rvLDwuCDDjMkckBsLLjUtuB97ap3pXQQSd/0CJMjX6kRz7DZwHdHehGT
         5/z6J2R3pOvEUQQEd6ZZdPqc7MZL5eiuThp9iCs55GBs9D9FNo3Ba9Kz3VaOwoi1IHhe
         dpxnbqLPeaIU71qanRBPcr/5DVNSQuHXGcgCXZk6eIedZairb7kqKWPz+1NW+ZA8eYOp
         hXtbfnBeEQ1dv1KfJdbYsctTXOeOHV01ti5HZI6+rrwKPpZTgfoZn3QM2f5Evfig8A1O
         Gf4Q==
X-Gm-Message-State: AOAM5327yml0Y0mpxop2LC5nuzY+VO25iOfJcN+tjowc140vetuKLrUP
        MQFJP+kLKMlu3Zxf0bnhML4prVvA4XU=
X-Google-Smtp-Source: ABdhPJzaaweCWAO9H20DaJW4o6GMcuLpt1uhD39YL08FGVQMNekiW2THDFuGNU+a2KJ8950pygM/pw==
X-Received: by 2002:a17:902:8a85:: with SMTP id p5mr2277820plo.308.1593759268136;
        Thu, 02 Jul 2020 23:54:28 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id s188sm10295612pfb.118.2020.07.02.23.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 23:54:27 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v3] f2fs: add symbolic link to kobject in sysfs
Date:   Fri,  3 Jul 2020 15:54:20 +0900
Message-Id: <20200703065420.3544269-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added a symbolic link to directory of sysfs. It will
create a symbolic link such as "mount_0" and "mount_1" to
each f2fs mount in the order of mounting filesystem. But
once one mount point was umounted, that sequential number
@x in "mount_@x" could be reused by later newly mounted
point. It will provide easy access to sysfs node even if
not knowing the specific device node name like sda19 and
dm-3.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 Documentation/filesystems/f2fs.rst | 13 ++++++++++++-
 fs/f2fs/f2fs.h                     |  4 ++++
 fs/f2fs/sysfs.c                    | 31 ++++++++++++++++++++++++++----
 3 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 535021c46260..916956d433b2 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -279,7 +279,18 @@ Sysfs Entries
 
 Information about mounted f2fs file systems can be found in
 /sys/fs/f2fs.  Each mounted filesystem will have a directory in
-/sys/fs/f2fs based on its device name (i.e., /sys/fs/f2fs/sda).
+/sys/fs/f2fs based on its device name (i.e., /sys/fs/f2fs/sda),
+or mount_#x (#x is the number representing the order of mounting).
+But once one mount point was umounted, that sequential number @x
+in "mount_@x" could be reused by later newly mounted point.
+
+Here is an example of this.
+
+mount dev0 mount0 (mount_0 -> dev0)
+mount dev1 mount1 (mount_1 -> dev1)
+umount mount0
+mount dev2 (mount_0 -> dev2)
+
 The files in each per-device directory are shown in table below.
 
 Files in /sys/fs/f2fs/<devname>
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4b28fd42fdbc..7d6c5f8ce16b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1419,6 +1419,8 @@ struct decompress_io_ctx {
 #define MAX_COMPRESS_LOG_SIZE		8
 #define MAX_COMPRESS_WINDOW_SIZE	((PAGE_SIZE) << MAX_COMPRESS_LOG_SIZE)
 
+#define MOUNT_NAME_SIZE			20
+
 struct f2fs_sb_info {
 	struct super_block *sb;			/* pointer to VFS super block */
 	struct proc_dir_entry *s_proc;		/* proc entry */
@@ -1599,6 +1601,8 @@ struct f2fs_sb_info {
 	/* For sysfs suppport */
 	struct kobject s_kobj;
 	struct completion s_kobj_unregister;
+	int s_mount_id;
+	char s_mount_name[MOUNT_NAME_SIZE];
 
 	/* For shrinker support */
 	struct list_head s_list;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 2a140657fc4d..703d9f460d03 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -18,6 +18,7 @@
 #include <trace/events/f2fs.h>
 
 static struct proc_dir_entry *f2fs_proc_root;
+static struct ida f2fs_mount_ida;
 
 /* Sysfs support for f2fs */
 enum {
@@ -908,6 +909,9 @@ int __init f2fs_init_sysfs(void)
 	} else {
 		f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
 	}
+
+	ida_init(&f2fs_mount_ida);
+
 	return ret;
 }
 
@@ -917,6 +921,7 @@ void f2fs_exit_sysfs(void)
 	kset_unregister(&f2fs_kset);
 	remove_proc_entry("fs/f2fs", NULL);
 	f2fs_proc_root = NULL;
+	ida_destroy(&f2fs_mount_ida);
 }
 
 int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
@@ -928,12 +933,22 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 	init_completion(&sbi->s_kobj_unregister);
 	err = kobject_init_and_add(&sbi->s_kobj, &f2fs_sb_ktype, NULL,
 				"%s", sb->s_id);
-	if (err) {
-		kobject_put(&sbi->s_kobj);
-		wait_for_completion(&sbi->s_kobj_unregister);
-		return err;
+	if (err)
+		goto err1;
+
+	sbi->s_mount_id = ida_simple_get(&f2fs_mount_ida, 0, 0, GFP_KERNEL);
+	if (sbi->s_mount_id < 0) {
+		err = sbi->s_mount_id;
+		goto err1;
 	}
 
+	snprintf(sbi->s_mount_name, MOUNT_NAME_SIZE, "mount_%d",
+			sbi->s_mount_id);
+	err = sysfs_create_link(&f2fs_kset.kobj, &sbi->s_kobj,
+			sbi->s_mount_name);
+	if (err)
+		goto err2;
+
 	if (f2fs_proc_root)
 		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);
 
@@ -948,6 +963,12 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 				victim_bits_seq_show, sb);
 	}
 	return 0;
+err2:
+	ida_simple_remove(&f2fs_mount_ida, sbi->s_mount_id);
+err1:
+	kobject_put(&sbi->s_kobj);
+	wait_for_completion(&sbi->s_kobj_unregister);
+	return err;
 }
 
 void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
@@ -959,6 +980,8 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
 		remove_proc_entry("victim_bits", sbi->s_proc);
 		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
 	}
+	sysfs_remove_link(&f2fs_kset.kobj, sbi->s_mount_name);
+	ida_simple_remove(&f2fs_mount_ida, sbi->s_mount_id);
 	kobject_del(&sbi->s_kobj);
 	kobject_put(&sbi->s_kobj);
 }
-- 
2.27.0.383.g050319c2ae-goog

