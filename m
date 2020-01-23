Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B81FC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 01:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A1324673
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 01:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579742041;
	bh=qyzRU2B7Xw6wKUGaKGWwp7d9aPqqAiGcaZX9p0fHTig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sH1hQcmZVnoxTpClP8BJYJKIqvkROFIU7+QazhGXmWGBnL3coiErxut3fb+ILRT9v
	 K8CPTA50zGBT5EmfDypOi9ZdfuAq9Qg4hsjQ45XiLs/9BUJRdETe1LLnAUJXpCk1zq
	 174S+Js1LLUszeD2+ePl4AjZ9U2xiXT6fBXiMJJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgAWBN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 20:13:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgAWBN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 20:13:58 -0500
Received: from localhost (unknown [104.132.0.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 914DE24676;
        Thu, 23 Jan 2020 01:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579742036;
        bh=qyzRU2B7Xw6wKUGaKGWwp7d9aPqqAiGcaZX9p0fHTig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ye9RnSu0VR9FN913KwuHQWrkDJAdtEMYR+7blrY7O+7JYtORwpaP26bTeo/lWHbik
         WfGNQ01AWTQlj/Cz75V3yJF3znBccOgakPXjUL36QHS3mKdh1aEm7S8NH3vDYxhYHa
         2YLTPpBzVPPTzdU7cYmJD7HeleO4R5FnjFvRWZTA=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Hridya Valsaraju <hridya@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: Add f2fs stats to sysfs
Date:   Wed, 22 Jan 2020 17:13:54 -0800
Message-Id: <20200123011354.75282-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
In-Reply-To: <20200123011354.75282-1-jaegeuk@kernel.org>
References: <20200123011354.75282-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hridya Valsaraju <hridya@google.com>

Currently f2fs stats are only available from /d/f2fs/status. This patch
adds some of the f2fs stats to sysfs so that they are accessible even
when debugfs is not mounted.

The following sysfs nodes are added:
-/sys/fs/f2fs/<disk>/free_segments
-/sys/fs/f2fs/<disk>/cp_foreground_calls
-/sys/fs/f2fs/<disk>/cp_background_calls
-/sys/fs/f2fs/<disk>/gc_foreground_calls
-/sys/fs/f2fs/<disk>/gc_background_calls
-/sys/fs/f2fs/<disk>/moved_blocks_foreground
-/sys/fs/f2fs/<disk>/moved_blocks_background
-/sys/fs/f2fs/<disk>/avg_vblocks

Signed-off-by: Hridya Valsaraju <hridya@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  47 ++++++++
 fs/f2fs/debug.c                         |   2 +-
 fs/f2fs/f2fs.h                          |   2 +
 fs/f2fs/sysfs.c                         | 139 ++++++++++++++++++------
 4 files changed, 157 insertions(+), 33 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 7cdaed02981a..1a6cd5397129 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -271,3 +271,50 @@ Date		July 2019
 Contact:	"Daniel Rosenberg" <drosen@google.com>
 Description:	Displays name and version of the encoding set for the filesystem.
 		If no encoding is set, displays (none)
+
+What:		/sys/fs/f2fs/<disk>/free_segments
+Date:		September 2019
+Contact:	"Hridya Valsaraju" <hridya@google.com>
+Description:	Number of free segments in disk.
+
+What:		/sys/fs/f2fs/<disk>/cp_foreground_calls
+Date:		September 2019
+Contact:	"Hridya Valsaraju" <hridya@google.com>
+Description:	Number of checkpoint operations performed on demand. Available when
+		CONFIG_F2FS_STAT_FS=y.
+
+What:		/sys/fs/f2fs/<disk>/cp_background_calls
+Date:		September 2019
+Contact:	"Hridya Valsaraju" <hridya@google.com>
+Description:	Number of checkpoint operations performed in the background to
+		free segments. Available when CONFIG_F2FS_STAT_FS=y.
+
+What:		/sys/fs/f2fs/<disk>/gc_foreground_calls
+Date:		September 2019
+Contact:	"Hridya Valsaraju" <hridya@google.com>
+Description:	Number of garbage collection operations performed on demand.
+		Available when CONFIG_F2FS_STAT_FS=y.
+
+What:		/sys/fs/f2fs/<disk>/gc_background_calls
+Date:		September 2019
+Contact:	"Hridya Valsaraju" <hridya@google.com>
+Description:	Number of garbage collection operations triggered in background.
+		Available when CONFIG_F2FS_STAT_FS=y.
+
+What:		/sys/fs/f2fs/<disk>/moved_blocks_foreground
+Date:		September 2019
+Contact:	"Hridya Valsaraju" <hridya@google.com>
+Description:	Number of blocks moved by garbage collection in foreground.
+		Available when CONFIG_F2FS_STAT_FS=y.
+
+What:		/sys/fs/f2fs/<disk>/moved_blocks_background
+Date:		September 2019
+Contact:	"Hridya Valsaraju" <hridya@google.com>
+Description:	Number of blocks moved by garbage collection in background.
+		Available when CONFIG_F2FS_STAT_FS=y.
+
+What:		/sys/fs/f2fs/<disk>/avg_vblocks
+Date:		September 2019
+Contact:	"Hridya Valsaraju" <hridya@google.com>
+Description:	Average number of valid blocks.
+		Available when CONFIG_F2FS_STAT_FS=y.
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index ce2936554ef8..7565ba9967dd 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -150,7 +150,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 /*
  * This function calculates BDF of every segments
  */
-static void update_sit_info(struct f2fs_sb_info *sbi)
+void update_sit_info(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_stat_info *si = F2FS_STAT(sbi);
 	unsigned long long blks_per_sec, hblks_per_sec, total_vblocks;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 61d62cd06449..148f45f3ea0e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3584,6 +3584,7 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi);
 void f2fs_destroy_stats(struct f2fs_sb_info *sbi);
 void __init f2fs_create_root_stats(void);
 void f2fs_destroy_root_stats(void);
+void update_sit_info(struct f2fs_sb_info *sbi);
 #else
 #define stat_inc_cp_count(si)				do { } while (0)
 #define stat_inc_bg_cp_count(si)			do { } while (0)
@@ -3626,6 +3627,7 @@ static inline int f2fs_build_stats(struct f2fs_sb_info *sbi) { return 0; }
 static inline void f2fs_destroy_stats(struct f2fs_sb_info *sbi) { }
 static inline void __init f2fs_create_root_stats(void) { }
 static inline void f2fs_destroy_root_stats(void) { }
+static inline void update_sit_info(struct f2fs_sb_info *sbi) {}
 #endif
 
 extern const struct file_operations f2fs_dir_operations;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 5152a7487335..0ea95c06f2cf 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -25,6 +25,9 @@ enum {
 	DCC_INFO,	/* struct discard_cmd_control */
 	NM_INFO,	/* struct f2fs_nm_info */
 	F2FS_SBI,	/* struct f2fs_sb_info */
+#ifdef CONFIG_F2FS_STAT_FS
+	STAT_INFO,      /* struct f2fs_stat_info */
+#endif
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	FAULT_INFO_RATE,	/* struct f2fs_fault_info */
 	FAULT_INFO_TYPE,	/* struct f2fs_fault_info */
@@ -42,6 +45,9 @@ struct f2fs_attr {
 	int id;
 };
 
+static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
+			     struct f2fs_sb_info *sbi, char *buf);
+
 static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
 {
 	if (struct_type == GC_THREAD)
@@ -58,6 +64,10 @@ static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
 	else if (struct_type == FAULT_INFO_RATE ||
 					struct_type == FAULT_INFO_TYPE)
 		return (unsigned char *)&F2FS_OPTION(sbi).fault_info;
+#endif
+#ifdef CONFIG_F2FS_STAT_FS
+	else if (struct_type == STAT_INFO)
+		return (unsigned char *)F2FS_STAT(sbi);
 #endif
 	return NULL;
 }
@@ -65,35 +75,15 @@ static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
 static ssize_t dirty_segments_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
-		(unsigned long long)(dirty_segments(sbi)));
+	return sprintf(buf, "%llu\n",
+			(unsigned long long)(dirty_segments(sbi)));
 }
 
-static ssize_t unusable_show(struct f2fs_attr *a,
+static ssize_t free_segments_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
-	block_t unusable;
-
-	if (test_opt(sbi, DISABLE_CHECKPOINT))
-		unusable = sbi->unusable_block_count;
-	else
-		unusable = f2fs_get_unusable_blocks(sbi);
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
-		(unsigned long long)unusable);
-}
-
-static ssize_t encoding_show(struct f2fs_attr *a,
-		struct f2fs_sb_info *sbi, char *buf)
-{
-#ifdef CONFIG_UNICODE
-	if (f2fs_sb_has_casefold(sbi))
-		return snprintf(buf, PAGE_SIZE, "%s (%d.%d.%d)\n",
-			sbi->s_encoding->charset,
-			(sbi->s_encoding->version >> 16) & 0xff,
-			(sbi->s_encoding->version >> 8) & 0xff,
-			sbi->s_encoding->version & 0xff);
-#endif
-	return snprintf(buf, PAGE_SIZE, "(none)");
+	return sprintf(buf, "%llu\n",
+			(unsigned long long)(free_segments(sbi)));
 }
 
 static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
@@ -102,10 +92,10 @@ static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
 	struct super_block *sb = sbi->sb;
 
 	if (!sb->s_bdev->bd_part)
-		return snprintf(buf, PAGE_SIZE, "0\n");
+		return sprintf(buf, "0\n");
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
-		(unsigned long long)(sbi->kbytes_written +
+	return sprintf(buf, "%llu\n",
+			(unsigned long long)(sbi->kbytes_written +
 			BD_PART_WRITTEN(sbi)));
 }
 
@@ -116,7 +106,7 @@ static ssize_t features_show(struct f2fs_attr *a,
 	int len = 0;
 
 	if (!sb->s_bdev->bd_part)
-		return snprintf(buf, PAGE_SIZE, "0\n");
+		return sprintf(buf, "0\n");
 
 	if (f2fs_sb_has_encrypt(sbi))
 		len += snprintf(buf, PAGE_SIZE - len, "%s",
@@ -166,9 +156,66 @@ static ssize_t features_show(struct f2fs_attr *a,
 static ssize_t current_reserved_blocks_show(struct f2fs_attr *a,
 					struct f2fs_sb_info *sbi, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%u\n", sbi->current_reserved_blocks);
+	return sprintf(buf, "%u\n", sbi->current_reserved_blocks);
+}
+
+static ssize_t unusable_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	block_t unusable;
+
+	if (test_opt(sbi, DISABLE_CHECKPOINT))
+		unusable = sbi->unusable_block_count;
+	else
+		unusable = f2fs_get_unusable_blocks(sbi);
+	return sprintf(buf, "%llu\n", (unsigned long long)unusable);
 }
 
+static ssize_t encoding_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+#ifdef CONFIG_UNICODE
+	if (f2fs_sb_has_casefold(sbi))
+		return snprintf(buf, PAGE_SIZE, "%s (%d.%d.%d)\n",
+			sbi->s_encoding->charset,
+			(sbi->s_encoding->version >> 16) & 0xff,
+			(sbi->s_encoding->version >> 8) & 0xff,
+			sbi->s_encoding->version & 0xff);
+#endif
+	return sprintf(buf, "(none)");
+}
+
+#ifdef CONFIG_F2FS_STAT_FS
+static ssize_t moved_blocks_foreground_show(struct f2fs_attr *a,
+				struct f2fs_sb_info *sbi, char *buf)
+{
+	struct f2fs_stat_info *si = F2FS_STAT(sbi);
+
+	return sprintf(buf, "%llu\n",
+		(unsigned long long)(si->tot_blks -
+			(si->bg_data_blks + si->bg_node_blks)));
+}
+
+static ssize_t moved_blocks_background_show(struct f2fs_attr *a,
+				struct f2fs_sb_info *sbi, char *buf)
+{
+	struct f2fs_stat_info *si = F2FS_STAT(sbi);
+
+	return sprintf(buf, "%llu\n",
+		(unsigned long long)(si->bg_data_blks + si->bg_node_blks));
+}
+
+static ssize_t avg_vblocks_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	struct f2fs_stat_info *si = F2FS_STAT(sbi);
+
+	si->dirty_count = dirty_segments(sbi);
+	update_sit_info(sbi);
+	return sprintf(buf, "%llu\n", (unsigned long long)(si->avg_vblocks));
+}
+#endif
+
 static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 			struct f2fs_sb_info *sbi, char *buf)
 {
@@ -202,7 +249,7 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 
 	ui = (unsigned int *)(ptr + a->offset);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", *ui);
+	return sprintf(buf, "%u\n", *ui);
 }
 
 static ssize_t __sbi_store(struct f2fs_attr *a,
@@ -413,7 +460,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
 	case FEAT_SB_CHECKSUM:
 	case FEAT_CASEFOLD:
 	case FEAT_COMPRESSION:
-		return snprintf(buf, PAGE_SIZE, "supported\n");
+		return sprintf(buf, "supported\n");
 	}
 	return 0;
 }
@@ -442,6 +489,14 @@ static struct f2fs_attr f2fs_attr_##_name = {			\
 	.id	= _id,						\
 }
 
+#define F2FS_STAT_ATTR(_struct_type, _struct_name, _name, _elname)	\
+static struct f2fs_attr f2fs_attr_##_name = {			\
+	.attr = {.name = __stringify(_name), .mode = 0444 },	\
+	.show = f2fs_sbi_show,					\
+	.struct_type = _struct_type,				\
+	.offset = offsetof(struct _struct_name, _elname),       \
+}
+
 F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_urgent_sleep_time,
 							urgent_sleep_time);
 F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_min_sleep_time, min_sleep_time);
@@ -483,11 +538,21 @@ F2FS_RW_ATTR(FAULT_INFO_RATE, f2fs_fault_info, inject_rate, inject_rate);
 F2FS_RW_ATTR(FAULT_INFO_TYPE, f2fs_fault_info, inject_type, inject_type);
 #endif
 F2FS_GENERAL_RO_ATTR(dirty_segments);
+F2FS_GENERAL_RO_ATTR(free_segments);
 F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
 F2FS_GENERAL_RO_ATTR(features);
 F2FS_GENERAL_RO_ATTR(current_reserved_blocks);
 F2FS_GENERAL_RO_ATTR(unusable);
 F2FS_GENERAL_RO_ATTR(encoding);
+#ifdef CONFIG_F2FS_STAT_FS
+F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_foreground_calls, cp_count);
+F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_background_calls, bg_cp_count);
+F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, gc_foreground_calls, call_count);
+F2FS_STAT_ATTR(F2FS_SBI, f2fs_sb_info, gc_background_calls, bg_gc);
+F2FS_GENERAL_RO_ATTR(moved_blocks_background);
+F2FS_GENERAL_RO_ATTR(moved_blocks_foreground);
+F2FS_GENERAL_RO_ATTR(avg_vblocks);
+#endif
 
 #ifdef CONFIG_FS_ENCRYPTION
 F2FS_FEATURE_RO_ATTR(encryption, FEAT_CRYPTO);
@@ -549,12 +614,22 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(inject_type),
 #endif
 	ATTR_LIST(dirty_segments),
+	ATTR_LIST(free_segments),
 	ATTR_LIST(unusable),
 	ATTR_LIST(lifetime_write_kbytes),
 	ATTR_LIST(features),
 	ATTR_LIST(reserved_blocks),
 	ATTR_LIST(current_reserved_blocks),
 	ATTR_LIST(encoding),
+#ifdef CONFIG_F2FS_STAT_FS
+	ATTR_LIST(cp_foreground_calls),
+	ATTR_LIST(cp_background_calls),
+	ATTR_LIST(gc_foreground_calls),
+	ATTR_LIST(gc_background_calls),
+	ATTR_LIST(moved_blocks_foreground),
+	ATTR_LIST(moved_blocks_background),
+	ATTR_LIST(avg_vblocks),
+#endif
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs);
-- 
2.24.0.525.g8f36a354ae-goog

