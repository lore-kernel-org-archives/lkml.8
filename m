Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB5AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 01:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72E152076A
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 01:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589591061;
	bh=YxpuI17mMTnCsgPgr4+idWQJpE0CThxM8O7KvpRZj9o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=YWYQ12sYpOs+P2H81Zk+Q3fH+bTyolSpe3tpUnDtadhG41AID4xIpVLaKhMPm3VwK
	 LEJE0/oK6NXWYo4p2NYRuQe3DaBm+iwgS0t7cjXyNFiQJYryo6LQTUtjzcXOEUfoTx
	 2+kMpq5nPeP4ZGb64/2Or1i7duqQPy7kMBM+9LEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgEPBEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 21:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgEPBEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 21:04:20 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 810FA20671;
        Sat, 16 May 2020 01:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589591059;
        bh=YxpuI17mMTnCsgPgr4+idWQJpE0CThxM8O7KvpRZj9o=;
        h=From:To:Cc:Subject:Date:From;
        b=zzTXUDS0VoiW9kPvGtDXz+emZ5aDm3SUE+Jo9Q9VFtrWok1oDDY6ZtOsTliuYBKcG
         +FiZZYoV/lqQiq3c+M/Q/PjLiHTxmMtfSEP9q/eQxFdgtoP5X98fxQorwIFn1b6UAx
         OsMpjAcVdB8qovjQHw8TYuJZoWYm8G2SydZIYRS8=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix checkpoint=disable:%u%%
Date:   Fri, 15 May 2020 18:04:16 -0700
Message-Id: <20200516010416.116281-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When parsing the mount option, we don't have sbi->user_block_count.
Should do it after getting it.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/super.c | 25 +++++++++++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 51863e4f5d4e0..fb180020e175c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -139,6 +139,7 @@ struct f2fs_mount_info {
 	int fs_mode;			/* fs mode: LFS or ADAPTIVE */
 	int bggc_mode;			/* bggc mode: off, on or sync */
 	bool test_dummy_encryption;	/* test dummy encryption */
+	block_t unusable_cap_perc;	/* percentage for cap */
 	block_t unusable_cap;		/* Amount of space allowed to be
 					 * unusable when disabling checkpoint
 					 */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 441eaaf9739c4..a71da699cb2d5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -284,6 +284,22 @@ static inline void limit_reserve_root(struct f2fs_sb_info *sbi)
 					   F2FS_OPTION(sbi).s_resgid));
 }
 
+static inline void adjust_unusable_cap_perc(struct f2fs_sb_info *sbi)
+{
+	if (!F2FS_OPTION(sbi).unusable_cap_perc)
+		return;
+
+	if (F2FS_OPTION(sbi).unusable_cap_perc == 100)
+		F2FS_OPTION(sbi).unusable_cap = sbi->user_block_count;
+	else
+		F2FS_OPTION(sbi).unusable_cap = (sbi->user_block_count / 100) *
+					F2FS_OPTION(sbi).unusable_cap_perc;
+
+	f2fs_info(sbi, "Adjust unusable cap for checkpoint=disable = %u / %u%%",
+			F2FS_OPTION(sbi).unusable_cap,
+			F2FS_OPTION(sbi).unusable_cap_perc);
+}
+
 static void init_once(void *foo)
 {
 	struct f2fs_inode_info *fi = (struct f2fs_inode_info *) foo;
@@ -785,12 +801,7 @@ static int parse_options(struct super_block *sb, char *options)
 				return -EINVAL;
 			if (arg < 0 || arg > 100)
 				return -EINVAL;
-			if (arg == 100)
-				F2FS_OPTION(sbi).unusable_cap =
-					sbi->user_block_count;
-			else
-				F2FS_OPTION(sbi).unusable_cap =
-					(sbi->user_block_count / 100) *	arg;
+			F2FS_OPTION(sbi).unusable_cap_perc = arg;
 			set_opt(sbi, DISABLE_CHECKPOINT);
 			break;
 		case Opt_checkpoint_disable_cap:
@@ -1840,6 +1851,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
 
 	limit_reserve_root(sbi);
+	adjust_unusable_cap_perc(sbi);
 	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
 	return 0;
 restore_gc:
@@ -3516,6 +3528,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->reserved_blocks = 0;
 	sbi->current_reserved_blocks = 0;
 	limit_reserve_root(sbi);
+	adjust_unusable_cap_perc(sbi);
 
 	for (i = 0; i < NR_INODE_TYPE; i++) {
 		INIT_LIST_HEAD(&sbi->inode_list[i]);
-- 
2.26.2.761.g0e0b3e54be-goog

