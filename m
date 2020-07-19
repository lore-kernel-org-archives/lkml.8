Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F3CC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 05:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9686920734
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 05:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jV22vwSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgGSFo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 01:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgGSFo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 01:44:27 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756FCC0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 22:44:27 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a14so7429210pfi.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 22:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AyFRPd1KqAbJdK62U99Tk4B0iYN4wPv7oVxjjBvR+KE=;
        b=jV22vwSG6dcFHuT7GYez0ARiif9z2x5vdRW2U7MxbX2PIWs82Y2UA0LILo1r/ksBkg
         hyIj7TGEc3F2a+jszVtQyXp39d+yUVN9/MG6myjjhkVhCmiwCOYtUIAbR6M2RVtWv88x
         9+bDPR4IYuO4De9frT3ebHUDpzYeUWOt6iFch9vWMJswtVvXCH/Ur5rKku2jzmV3sF4T
         O4mrNZTcGscxbcoTmpbjiV9/FT9PYWakEPesbn/PlYM5+b7BDREtfUad9fPSKwbBWSmF
         iDLfSNtSvB5t/woG0Jwrdb5zw2JyxpXxV7B+/dkJ9PS8RtC0KPHdRNvdAvD3xaJMJSmk
         Pejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AyFRPd1KqAbJdK62U99Tk4B0iYN4wPv7oVxjjBvR+KE=;
        b=KLykWD+rnA6IYHAKcVkLY1L1aDEJJDioepQ55JGLmfdzc7fFKXNv3DINduS8smM84c
         Z5fDsAKwxJvnygF5Id5VSU7H9NaU+ZbvldJzwBbEM4LQAkWsLnGSkFyu7UpIgDn/yl7d
         74EEH73EzUIShR9XmLJGP67pEVNL/PkoOzNpn1c3F6txsliwyyo+ccZLzkClkeMQor6b
         XBUp8suoUP+yX7zN74x8POUc0pqSqK15a2JtmQUzTQh64HL5P1alHeZjyalFmgnD8hgT
         57kDIHtEorO3DLA5s/do/jzOY/UKgzzZmlMAxxicWMte+VLdAGgbrFzKppBSzmw1E9YV
         5Y8A==
X-Gm-Message-State: AOAM531GHyq2v+iQuGxK8JY3iNd+MVWdjjdg+nEgDn53AKsd6/4VKejL
        nl3+yVNy9T+M6Rb3ZyrfnSkRCnWflL0=
X-Google-Smtp-Source: ABdhPJwe25PkmSdtqQJnV2SBBq7sAbbmcQFZ4dEOa9/YxfarO35nCykbdoUrs2kgzJA9fqLRnrCR7Q==
X-Received: by 2002:a62:8848:: with SMTP id l69mr14135010pfd.314.1595137466463;
        Sat, 18 Jul 2020 22:44:26 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id l207sm12573821pfd.79.2020.07.18.22.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 22:44:25 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 1/2] f2fs: add sysfs symbolic link to kobject with volume name
Date:   Sun, 19 Jul 2020 14:44:08 +0900
Message-Id: <20200719054409.3050516-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added a symbolic link directory pointing to its device name
directory using the volume name of the partition in sysfs.
(i.e., /sys/fs/f2fs/vol_#x -> /sys/fs/f2fs/sda1)
"vol" is the volume name of the partition, "#x" is the number
representing the order of mounting with the same volume name.
We allow the volume name duplication within 100, which means the
range of #x should be 0 ~ 99. Once one mount point was umounted,
that sequential number #x in "vol_#x" could be reused by later
newly mounted point.

It will provide easy access to sysfs node using volume name,
even if not knowing the specific device node name like sda1 and
dm-3.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 Documentation/filesystems/f2fs.rst | 21 +++++++++++--
 fs/f2fs/f2fs.h                     | 14 +++++++++
 fs/f2fs/file.c                     |  2 ++
 fs/f2fs/super.c                    |  1 +
 fs/f2fs/sysfs.c                    | 50 ++++++++++++++++++++++++++++++
 5 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index de43239a3c31..8221f3af6042 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -278,8 +278,25 @@ Sysfs Entries
 =============
 
 Information about mounted f2fs file systems can be found in
-/sys/fs/f2fs.  Each mounted filesystem will have a directory in
-/sys/fs/f2fs based on its device name (i.e., /sys/fs/f2fs/sda).
+/sys/fs/f2fs. Each mounted filesystem will have a directory in
+/sys/fs/f2fs based on its device name (i.e., /sys/fs/f2fs/sda),
+or, if the partition has the volume name in the on-disk super
+block, the volume name with the number (i.e., /sys/fs/f2fs/vol_#x).
+"vol" is the volume name of the partition, "#x" is the number
+representing the order of mounting with the same volume name.
+We allow the volume name duplication within 100, which means the
+range of #x should be 0 ~ 99. Once one mount point was umounted,
+that sequential number #x in "vol_#x" could be reused by later
+newly mounted point.
+
+Here is an example of this.
+
+mount dev0 mount0 (vol_0 -> dev0)
+mount dev1 mount1 (vol_1 -> dev1)
+umount mount0
+mount dev2 mount2 (vol_0 -> dev2)
+* dev0, dev1 and dev2 have the same volume name "vol".
+
 The files in each per-device directory are shown in table below.
 
 Files in /sys/fs/f2fs/<devname>
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a555377cf51f..392ee7d7a37d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1382,6 +1382,10 @@ struct decompress_io_ctx {
 #define MAX_COMPRESS_LOG_SIZE		8
 #define MAX_COMPRESS_WINDOW_SIZE	((PAGE_SIZE) << MAX_COMPRESS_LOG_SIZE)
 
+#define MAX_DUP_NAME			8
+#define MAX_SYSLINK_NAME		(MAX_VOLUME_NAME + MAX_DUP_NAME)
+#define MAX_DUP_NUM			100
+
 struct f2fs_sb_info {
 	struct super_block *sb;			/* pointer to VFS super block */
 	struct proc_dir_entry *s_proc;		/* proc entry */
@@ -1586,6 +1590,10 @@ struct f2fs_sb_info {
 
 	struct kmem_cache *inline_xattr_slab;	/* inline xattr entry */
 	unsigned int inline_xattr_slab_size;	/* default inline xattr slab size */
+
+	/* For sysfs symlink per volume */
+	char syslink_name[MAX_SYSLINK_NAME];
+	struct mutex syslink_mutex;
 };
 
 struct f2fs_private_dio {
@@ -3816,6 +3824,12 @@ int __init f2fs_init_sysfs(void);
 void f2fs_exit_sysfs(void);
 int f2fs_register_sysfs(struct f2fs_sb_info *sbi);
 void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi);
+void f2fs_reload_syslink(struct f2fs_sb_info *sbi);
+
+static inline bool f2fs_has_syslink(struct f2fs_sb_info *sbi)
+{
+	return strlen(sbi->syslink_name);
+}
 
 /* verity.c */
 extern const struct fsverity_operations f2fs_verityops;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 521987cd8772..4612f645007a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3418,6 +3418,8 @@ static int f2fs_ioc_setfslabel(struct file *filp, unsigned long arg)
 
 	up_write(&sbi->sb_lock);
 
+	f2fs_reload_syslink(sbi);
+
 	mnt_drop_write_file(filp);
 out:
 	kfree(vbuf);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2686b07ae7eb..7b002785417a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3021,6 +3021,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 
 	init_rwsem(&sbi->sb_lock);
 	init_rwsem(&sbi->pin_sem);
+	mutex_init(&sbi->syslink_mutex);
 }
 
 static int init_percpu_info(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 50524401c8e6..e9818dd338c1 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -11,6 +11,7 @@
 #include <linux/f2fs_fs.h>
 #include <linux/seq_file.h>
 #include <linux/unicode.h>
+#include <linux/nls.h>
 
 #include "f2fs.h"
 #include "segment.h"
@@ -897,6 +898,51 @@ static int __maybe_unused victim_bits_seq_show(struct seq_file *seq,
 	return 0;
 }
 
+static void f2fs_unload_syslink(struct f2fs_sb_info *sbi)
+{
+	if (!f2fs_has_syslink(sbi))
+		return;
+
+	sysfs_remove_link(&f2fs_kset.kobj, sbi->syslink_name);
+	memset(sbi->syslink_name, 0, MAX_SYSLINK_NAME);
+}
+
+static int f2fs_load_syslink(struct f2fs_sb_info *sbi)
+{
+	int idx, count, ret;
+
+	down_read(&sbi->sb_lock);
+	count = utf16s_to_utf8s(sbi->raw_super->volume_name,
+			ARRAY_SIZE(sbi->raw_super->volume_name),
+			UTF16_LITTLE_ENDIAN, sbi->syslink_name,
+			MAX_VOLUME_NAME);
+	up_read(&sbi->sb_lock);
+
+	if (!count)
+		return -ENOENT;
+
+	for (idx = 0; idx < MAX_DUP_NUM; idx++) {
+		snprintf(sbi->syslink_name + count, MAX_DUP_NAME, "_%d", idx);
+		ret = sysfs_create_link(&f2fs_kset.kobj, &sbi->s_kobj,
+				sbi->syslink_name);
+		if (ret != -EEXIST)
+			break;
+	}
+
+	if (ret)
+		memset(sbi->syslink_name, 0, MAX_SYSLINK_NAME);
+
+	return ret;
+}
+
+void f2fs_reload_syslink(struct f2fs_sb_info *sbi)
+{
+	mutex_lock(&sbi->syslink_mutex);
+	f2fs_unload_syslink(sbi);
+	f2fs_load_syslink(sbi);
+	mutex_unlock(&sbi->syslink_mutex);
+}
+
 int __init f2fs_init_sysfs(void)
 {
 	int ret;
@@ -954,11 +1000,15 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 		proc_create_single_data("victim_bits", S_IRUGO, sbi->s_proc,
 				victim_bits_seq_show, sb);
 	}
+
+	f2fs_load_syslink(sbi);
+
 	return 0;
 }
 
 void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
 {
+	f2fs_unload_syslink(sbi);
 	if (sbi->s_proc) {
 		remove_proc_entry("iostat_info", sbi->s_proc);
 		remove_proc_entry("segment_info", sbi->s_proc);
-- 
2.28.0.rc0.105.gf9edc3c819-goog

