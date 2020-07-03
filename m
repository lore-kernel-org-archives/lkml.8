Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23777C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86E7208FE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dae73+uy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgGCETh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 00:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgGCETh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 00:19:37 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244F5C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 21:19:37 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z3so4162340pfn.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 21:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EvLTEidoAGZVVhYEfJ1iRMW1yqo2GUTqtH2XjpP1cdI=;
        b=dae73+uy+g+DPGJTvHno9/JIfwzZ+ouEgSwh/WQpD+Evttdxkvo/JHXoaZ99vF4MyY
         6jp7GTQ2vBBWKKGv0rc4H4kPMGafGqb/NiQdaAx7KHfdPKmV/ul3/V5mv508RuDSA2nJ
         LKpEybpiuxOAL9IRXBlg6aRj82NaOVUlZs8X0lGR3iY3TvSXeX8z9CWqShk70OD4I+m2
         ZE20xVAhWGV7bPQsDJI/zxYxRsZqZ+kTZQ6Gr980wPD/OsL5K+MvnFpshjmaM/8w3Zg0
         0QHjy6X9aal2dymKloturpL2STcXCtoYlzsb14zyV3L/1VxQ89RvG+4mdAyFT73hqvg5
         L7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EvLTEidoAGZVVhYEfJ1iRMW1yqo2GUTqtH2XjpP1cdI=;
        b=lKdonwQiwPdnhzcNQKy96z1JAQgUv/QJ3/9TKFUJRAgXfwQHiOc8jUU9RSmAGnwu0u
         vVMW5fystpSnZMqWJrWQscavl/gIjg262+pMjvDiGM3/FaqygXk3nX0M7nF8715k1DW5
         t/Ewyfu/r+aLqhpnnKFcV66NYaKdBy9oDlDbFxn3VDWwZXrU1Sy2jXKvENntB5h6PXrq
         pjHTNq+G8U9Wk311q2vWApGTk1Vw6+hB3bp8aU0jipz34C2YziPqzx+Xg3zW5vZ/aXVF
         HuBOxsI1NRDNUT40Uy7BVz+v8SajwHMtvRuJVwcKcqfqCxDUEXKGrBGEX5MEkcTHmw7n
         UEEg==
X-Gm-Message-State: AOAM5302fMbrathLvsWadVpjZ7YNIfTFMBAzT9wY98A9BcsjAV3F4tap
        8uCoMDbKphIDePZlLhaaVw2iPGOPtMQ=
X-Google-Smtp-Source: ABdhPJwzVTvQq9xkJUChZhhcG9h0YRPIxbVXnm0+G5A8bNIBIVaEUatdjjmHDZNV3VYLMiJzDHyuLA==
X-Received: by 2002:aa7:8389:: with SMTP id u9mr30319839pfm.269.1593749975964;
        Thu, 02 Jul 2020 21:19:35 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id n18sm10622481pfd.99.2020.07.02.21.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 21:19:35 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs: add symbolic link to kobject in sysfs
Date:   Fri,  3 Jul 2020 13:19:29 +0900
Message-Id: <20200703041929.3290946-1-daeho43@gmail.com>
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

