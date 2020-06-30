Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A009C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E48C20781
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTohZQf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgF3A4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 20:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgF3A4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 20:56:32 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF18C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 17:56:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id j4so7779000plk.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 17:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lXITmVMDUTrmqOpIM7LrpJSSmhuv7Ic7kn2DxL4oq8s=;
        b=cTohZQf7UuAV4F8nd+HEfTb7iR/DP//sAZhOZCpjx1aH1otvJCZr0rDjZ7ZqFSGWG6
         B5yjQfTiA5OpENjblTHvext5EUDh0E1hM0rIoNIXBu25DoZJXGKE6sg0MivEkkx852bm
         PhhbTpN538p6jo4q+2SYA9nSGQLbBnKN48vG6TKxWbwxEyDwEDgQmLCtiX/Gh0ro/u2y
         9NfNaau1B3DIAJ1gp4io2BWwPdWRLImVJVRp6okGhZUAgNa3YNykyGUM0L+U/SNHXtWe
         jdXorTh90R5OPwfxWjmj54WIMpimNcy3Aqa9bl3oTOv/H8TeS54zwL9CTZVMgp1YrBFX
         6aGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lXITmVMDUTrmqOpIM7LrpJSSmhuv7Ic7kn2DxL4oq8s=;
        b=V6+zMHNIE7XTJwp7VSApbJmvxz40Vme1+JBq6wdB7RFBnAK4LK0w3wdnt49W1sxrN5
         zvgoaQ6dlkyOYntLVkIba0gaOo022nRjZw5a9TywpG563PcRdsxahWAPVJGIWqbyQDlD
         U4scnZLwJpZvTggGoZP6ihpeVKg+WDx6iAUgMJ2f7anATwNRPgJ6sorR3WnHzhBmPsHB
         Pdfx0qtNNxyDdsFRthO8Rn3MQsrgqsaABsuQxYGUSmBBzBFIxRxQEvZ5VCed7Lx86/t7
         NxZiISRlGp/CRQItszE9cYcmVk8wYzOQjpq5TDWaDtXRjX6I3xA1V6F5LDNKhgLttpiz
         f2Qg==
X-Gm-Message-State: AOAM531YiO8kCKcJCjyTVJpu1Cbxqajkq4nCWlE0EeTEMDWb+jqFRy0M
        B3zbQsTTVFOB+q3veVR1s+xUWz+9cVc=
X-Google-Smtp-Source: ABdhPJy2Qawi9gRPaj2nnaa/A8KjGOre/+SdEdZjDGQTuWicoAqOGnqR0MQY4KH2FdTOabKocLtmRg==
X-Received: by 2002:a17:902:b187:: with SMTP id s7mr14261435plr.188.1593478591439;
        Mon, 29 Jun 2020 17:56:31 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:b8f4:bbde:37ba:20bd])
        by smtp.gmail.com with ESMTPSA id 9sm722636pfx.131.2020.06.29.17.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 17:56:30 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: add symbolic link to kobject in sysfs
Date:   Tue, 30 Jun 2020 09:56:25 +0900
Message-Id: <20200630005625.2405062-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added a symbolic link to directory of sysfs. It will
create a symbolic link such as "mount_0" and "mount_1" to
each f2fs mount in the order of mounting filesystem. It will
provide easy access to sysfs node even if not knowing the
specific device node name like sda19 and dm-3.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/f2fs.h  |  4 ++++
 fs/f2fs/sysfs.c | 31 +++++++++++++++++++++++++++----
 2 files changed, 31 insertions(+), 4 deletions(-)

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
index ab40e1f89f23..64bbe0b3b830 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -18,6 +18,7 @@
 #include <trace/events/f2fs.h>
 
 static struct proc_dir_entry *f2fs_proc_root;
+static struct ida f2fs_mount_ida;
 
 /* Sysfs support for f2fs */
 enum {
@@ -906,6 +907,9 @@ int __init f2fs_init_sysfs(void)
 	} else {
 		f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
 	}
+
+	ida_init(&f2fs_mount_ida);
+
 	return ret;
 }
 
@@ -915,6 +919,7 @@ void f2fs_exit_sysfs(void)
 	kset_unregister(&f2fs_kset);
 	remove_proc_entry("fs/f2fs", NULL);
 	f2fs_proc_root = NULL;
+	ida_destroy(&f2fs_mount_ida);
 }
 
 int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
@@ -926,12 +931,22 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
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
 
@@ -946,6 +961,12 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
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
@@ -957,6 +978,8 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
 		remove_proc_entry("victim_bits", sbi->s_proc);
 		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
 	}
+	sysfs_remove_link(&f2fs_kset.kobj, sbi->s_mount_name);
+	ida_simple_remove(&f2fs_mount_ida, sbi->s_mount_id);
 	kobject_del(&sbi->s_kobj);
 	kobject_put(&sbi->s_kobj);
 }
-- 
2.27.0.212.ge8ba1cc988-goog

