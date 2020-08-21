Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E421EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 22:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C701D207C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 22:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgHUWQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 18:16:49 -0400
Received: from smtprelay0124.hostedemail.com ([216.40.44.124]:37568 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726747AbgHUWQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 18:16:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 3F740180A7FF6;
        Fri, 21 Aug 2020 22:16:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rifle02_4a01f112703c
X-Filterd-Recvd-Size: 5660
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Aug 2020 22:16:44 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ntfs3: Use more common logging function names and style
Date:   Fri, 21 Aug 2020 15:16:38 -0700
Message-Id: <1e246c968ee9e4fec03094ace92b4076c297ff80.1598047822.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1598047822.git.joe@perches.com>
References: <cover.1598047822.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ntfs_<foo>_trace function names to _printk.

Miscellanea:

o Change the macros that use these functions
o Use the more common ..., ##__VA_ARGS__ style

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/ntfs3/debug.h   | 30 +++++++++++++++++-------------
 fs/ntfs3/ntfs_fs.h |  4 ++--
 fs/ntfs3/super.c   | 31 ++++++++++++++++++++-----------
 3 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/fs/ntfs3/debug.h b/fs/ntfs3/debug.h
index ee348daeb7a9..b8f09f41508a 100644
--- a/fs/ntfs3/debug.h
+++ b/fs/ntfs3/debug.h
@@ -23,23 +23,27 @@
 #define WordAlign(n) (((n) + 1u) & (~1u))
 #define IsWordAligned(n) (!((size_t)(n)&1u))
 
-__printf(3, 4) void __ntfs_trace(const struct super_block *sb,
-				 const char *level, const char *fmt, ...);
+__printf(2, 3)
+void ntfs_printk(const struct super_block *sb,
+				const char *fmt, ...);
 __printf(3, 4) void __ntfs_fs_error(struct super_block *sb, int report,
 				    const char *fmt, ...);
-__printf(3, 4) void __ntfs_inode_trace(struct inode *inode, const char *level,
-				       const char *fmt, ...);
+__printf(2, 3)
+void ntfs_inode_printk(struct inode *inode, const char *fmt, ...);
 
-#define ntfs_trace(sb, fmt, args...) __ntfs_trace(sb, KERN_NOTICE, fmt, ##args)
-#define ntfs_error(sb, fmt, args...) __ntfs_trace(sb, KERN_ERR, fmt, ##args)
-#define ntfs_warning(sb, fmt, args...)                                         \
-	__ntfs_trace(sb, KERN_WARNING, fmt, ##args)
+#define ntfs_trace(sb, fmt, ...)					\
+	ntfs_printk(sb, KERN_NOTICE fmt, ##__VA_ARGS__)
+#define ntfs_error(sb, fmt, ...)					\
+	ntfs_printk(sb, KERN_ERR fmt, ##__VA_ARGS__)
+#define ntfs_warning(sb, fmt, ...)					\
+	ntfs_printk(sb, KERN_WARNING fmt, ##__VA_ARGS__)
 
-#define ntfs_fs_error(sb, fmt, args...) __ntfs_fs_error(sb, 1, fmt, ##args)
-#define ntfs_inode_error(inode, fmt, args...)                                  \
-	__ntfs_inode_trace(inode, KERN_ERR, fmt, ##args)
-#define ntfs_inode_warning(inode, fmt, args...)                                \
-	__ntfs_inode_trace(inode, KERN_WARNING, fmt, ##args)
+#define ntfs_fs_error(sb, fmt, ...)					\
+	__ntfs_fs_error(sb, 1, fmt, ##__VA_ARGS__)
+#define ntfs_inode_error(inode, fmt, ...)				\
+	ntfs_inode_printk(inode, KERN_ERR fmt, ##__VA_ARGS__)
+#define ntfs_inode_warning(inode, fmt, ...)				\
+	ntfs_inode_printk(inode, KERN_WARNING fmt, ##__VA_ARGS__)
 
 static inline void *ntfs_alloc(size_t size, int zero)
 {
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 0024fcad3b89..4609467e211c 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -857,8 +857,8 @@ static inline struct buffer_head *ntfs_bread(struct super_block *sb,
 	if (bh)
 		return bh;
 
-	__ntfs_trace(sb, KERN_ERR, "failed to read volume at offset 0x%llx",
-		     (u64)block << sb->s_blocksize_bits);
+	ntfs_error(sb, "failed to read volume at offset 0x%llx",
+		   (u64)block << sb->s_blocksize_bits);
 	return NULL;
 }
 
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index af41aec384b1..3a8a0a6c2cb8 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -31,35 +31,40 @@
 #include "ntfs_fs.h"
 
 /**
- * ntfs_trace() - print preformated ntfs specific messages.
+ * ntfs_printk() - print preformatted ntfs specific messages.
  */
-void __ntfs_trace(const struct super_block *sb, const char *level,
-		  const char *fmt, ...)
+void ntfs_printk(const struct super_block *sb, const char *fmt, ...)
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
 	if (!sb)
-		printk("%sntfs3: %pV", level, &vaf);
+		printk("%c%cntfs3: %pV",
+		       KERN_SOH_ASCII, level, &vaf);
 	else
-		printk("%sntfs3: %s: %pV", level, sb->s_id, &vaf);
+		printk("%c%cntfs3: %s: %pV",
+		       KERN_SOH_ASCII, level, sb->s_id, &vaf);
+
 	va_end(args);
 }
 
 /* prints info about inode using dentry case if */
-void __ntfs_inode_trace(struct inode *inode, const char *level, const char *fmt,
-			...)
+void ntfs_inode_printk(struct inode *inode, const char *fmt, ...)
 {
 	struct super_block *sb = inode->i_sb;
 	ntfs_sb_info *sbi = sb->s_fs_info;
 	struct dentry *dentry;
 	const char *name = "?";
 	char buf[48];
-	va_list args;
 	struct va_format vaf;
+	va_list args;
+	int level;
 
 	if (!__ratelimit(&sbi->ratelimit))
 		return;
@@ -74,9 +79,13 @@ void __ntfs_inode_trace(struct inode *inode, const char *level, const char *fmt,
 	}
 
 	va_start(args, fmt);
-	vaf.fmt = fmt;
+
+	level = printk_get_level(fmt);
+	vaf.fmt = printk_skip_level(fmt);
 	vaf.va = &args;
-	printk("%s%s on %s: %pV", level, name, sb->s_id, &vaf);
+	printk("%c%c%s on %s: %pV",
+	       KERN_SOH_ASCII, level, name, sb->s_id, &vaf);
+
 	va_end(args);
 
 	if (dentry) {
-- 
2.26.0

