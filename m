Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EB9C4332E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72DE520724
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgCVQkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 12:40:08 -0400
Received: from smtprelay0030.hostedemail.com ([216.40.44.30]:43884 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725881AbgCVQkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 12:40:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id AFA5B180178EE;
        Sun, 22 Mar 2020 16:40:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: body50_1dd702395da2b
X-Filterd-Recvd-Size: 3629
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sun, 22 Mar 2020 16:40:04 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nilfs2: Convert __nilfs_msg to integrate the level and format
Date:   Sun, 22 Mar 2020 09:38:10 -0700
Message-Id: <1d5b32e77f71e41ab7884ab57f1ef9755198b710.1584894497.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1584894497.git.joe@perches.com>
References: <cover.1584894497.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce object size a bit by removing the KERN_<LEVEL> as a
separate argument and adding it to the format string.

Reduce overall object size by about ~.5% (x86-64 defconfig w/ nilfs2)

old:
$ size -t fs/nilfs2/built-in.a | tail -1
 191738	   8676	     44	 200458	  30f0a	(TOTALS)

new:
$ size -t fs/nilfs2/built-in.a | tail -1
 190971	   8676	     44	 199691	  30c0b	(TOTALS)

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/nilfs2/nilfs.h |  9 ++++-----
 fs/nilfs2/super.c | 16 +++++++++++-----
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index 42395b..979a410 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -289,9 +289,8 @@ static inline int nilfs_mark_inode_dirty_sync(struct inode *inode)
 /* super.c */
 extern struct inode *nilfs_alloc_inode(struct super_block *);
 
-extern __printf(3, 4)
-void __nilfs_msg(struct super_block *sb, const char *level,
-		 const char *fmt, ...);
+__printf(2, 3)
+void __nilfs_msg(struct super_block *sb, const char *fmt, ...);
 extern __printf(3, 4)
 void __nilfs_error(struct super_block *sb, const char *function,
 		   const char *fmt, ...);
@@ -299,7 +298,7 @@ void __nilfs_error(struct super_block *sb, const char *function,
 #ifdef CONFIG_PRINTK
 
 #define nilfs_msg(sb, level, fmt, ...)					\
-	__nilfs_msg(sb, level, fmt, ##__VA_ARGS__)
+	__nilfs_msg(sb, level fmt, ##__VA_ARGS__)
 #define nilfs_error(sb, fmt, ...)					\
 	__nilfs_error(sb, __func__, fmt, ##__VA_ARGS__)
 
@@ -307,7 +306,7 @@ void __nilfs_error(struct super_block *sb, const char *function,
 
 #define nilfs_msg(sb, level, fmt, ...)					\
 	do {								\
-		no_printk(fmt, ##__VA_ARGS__);				\
+		no_printk(level fmt, ##__VA_ARGS__);			\
 		(void)(sb);						\
 	} while (0)
 #define nilfs_error(sb, fmt, ...)					\
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 5729ee..fef482 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -62,19 +62,25 @@ struct kmem_cache *nilfs_btree_path_cache;
 static int nilfs_setup_super(struct super_block *sb, int is_mount);
 static int nilfs_remount(struct super_block *sb, int *flags, char *data);
 
-void __nilfs_msg(struct super_block *sb, const char *level, const char *fmt,
-		 ...)
+void __nilfs_msg(struct super_block *sb, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
+	int level;
 
 	va_start(args, fmt);
-	vaf.fmt = fmt;
+
+	level = printk_get_level(fmt);
+	vaf.fmt = printk_skip_level(fmt);
 	vaf.va = &args;
+
 	if (sb)
-		printk("%sNILFS (%s): %pV\n", level, sb->s_id, &vaf);
+		printk("%c%cNILFS (%s): %pV\n",
+		       KERN_SOH_ASCII, level, sb->s_id, &vaf);
 	else
-		printk("%sNILFS: %pV\n", level, &vaf);
+		printk("%c%cNILFS: %pV\n",
+		       KERN_SOH_ASCII, level, &vaf);
+
 	va_end(args);
 }
 
-- 
2.24.0

