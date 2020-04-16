Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FFAC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 00:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 179732078B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 00:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwmmkCx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391255AbgDPAHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 20:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729647AbgDPAHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 20:07:03 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4591FC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 17:07:03 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d77so2482193wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 17:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KSN4M7h6noJlk4DJCOy/8QIHBLWgsOiLxa8wzPtAAos=;
        b=UwmmkCx+udz09X9rXuoNfx5Ydf7C+E8AnjxtIWMQUpNmQNqnjpFXCwSRZBEW7lu7oP
         Utnle45wVHCE3CzuuQyGydYx7JBUJrpteIuZaFa2QN02ZY5y0Hb50u5JnKsYGy6JNmXi
         FjbVG1OR9gjX5i1e2aJTsOCIUOKAvuaepzc4R87xS2awLzxvqds+vduf+z5dLBGq/5RH
         GpoF2P9ax08MKOkjc8Yovr1CqRXI06G7ekEsFeegIb2VevWcrZYIuPmqU4obQUncz0Aj
         y7scKKMkXnvxZ7K7VZgdK5VwjvK11xD0cAGNh65xUJtg0WZ2r7R5pRMC2kDQfg4C25m4
         mZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KSN4M7h6noJlk4DJCOy/8QIHBLWgsOiLxa8wzPtAAos=;
        b=h3fCjNIHXlqjzT6Q4ihfYhqws/bfu7rQ59Sh+rOG07tCk8CUFspz5EEjnhaDnvxTuc
         pYrYBo3zAnufdIeeq5+eC8IGLBlPsaKUrkkm/Fi8yjSKcKdUCRvJzZ6nkP7TX2ow4H0z
         p69zkfX+vT+QuoVb2u/+Zp42clonOGMEPZj9L+LlYPsd3nDMueOMejjWLNyQJaqDmk45
         V0zD9ix1Ap2o6lk/HJt1iYDf2GIUIeQGFzAWlT1hHSDjz76HRdY6Wk9R9i39eHVtrkBv
         i26qoX9cPLmaPRSKOM99grcdk9P3AZ7Wbj7zhiAjl9Tf2WkZhaUacKeasdMJBzSFwBlA
         oRXA==
X-Gm-Message-State: AGi0Pua6r+pEKL3kIGq3QjjLNBeCHOmzFaRTAr7+HQ1NSgniKKMRW7Ws
        myVuE25VQqYUz2oiNaYG5PlW7102DJA=
X-Google-Smtp-Source: APiQypIBOXdNeLp0PNvpq9QhTUzNvIU9jwT9HQp5BMSyHexQzLadAnGviimPsHBUqmlWrtmbxqTKzA==
X-Received: by 2002:a05:600c:441a:: with SMTP id u26mr181787wmn.154.1586995621663;
        Wed, 15 Apr 2020 17:07:01 -0700 (PDT)
Received: from gamer-pc.Home ([78.17.242.181])
        by smtp.gmail.com with ESMTPSA id n11sm26717154wrg.72.2020.04.15.17.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 17:07:00 -0700 (PDT)
From:   Paul McQuade <paulmcquad@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul McQuade <paulmcquad@gmail.com>
Subject: [PATCH] fs: minix: Fixed styles
Date:   Thu, 16 Apr 2020 01:06:53 +0100
Message-Id: <20200416000653.37696-1-paulmcquad@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed whitespaces and a bit of styling

Signed-off-by: Paul McQuade <paulmcquad@gmail.com>
---
 fs/minix/bitmap.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/fs/minix/bitmap.c b/fs/minix/bitmap.c
index f4e5e5181a14..90ff9597d024 100644
--- a/fs/minix/bitmap.c
+++ b/fs/minix/bitmap.c
@@ -22,9 +22,11 @@ static DEFINE_SPINLOCK(bitmap_lock);
 /*
  * bitmap consists of blocks filled with 16bit words
  * bit set == busy, bit clear == free
- * endianness is a mess, but for counting zero bits it really doesn't matter...
+ * endianness is a mess, but for counting zero
+ * it really doesn't matter...
  */
-static __u32 count_free(struct buffer_head *map[], unsigned blocksize, __u32 numbits)
+static __u32 count_free(struct buffer_head *map[], unsigned int blocksize,
+			__u32 numbits)
 {
 	__u32 sum = 0;
 	unsigned blocks = DIV_ROUND_UP(numbits, blocksize * 8);
@@ -52,7 +54,7 @@ void minix_free_block(struct inode *inode, unsigned long block)
 		return;
 	}
 	zone = block - sbi->s_firstdatazone + 1;
-	bit = zone & ((1<<k) - 1);
+	bit = zone & ((1 << k) - 1);
 	zone >>= k;
 	if (zone >= sbi->s_zmap_blocks) {
 		printk("minix_free_block: nonexistent bitmap buffer\n");
@@ -68,7 +70,7 @@ void minix_free_block(struct inode *inode, unsigned long block)
 	return;
 }
 
-int minix_new_block(struct inode * inode)
+int minix_new_block(struct inode *inode)
 {
 	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
 	int bits_per_zone = 8 * inode->i_sb->s_blocksize;
@@ -84,7 +86,7 @@ int minix_new_block(struct inode * inode)
 			minix_set_bit(j, bh->b_data);
 			spin_unlock(&bitmap_lock);
 			mark_buffer_dirty(bh);
-			j += i * bits_per_zone + sbi->s_firstdatazone-1;
+			j += i * bits_per_zone + sbi->s_firstdatazone - 1;
 			if (j < sbi->s_firstdatazone || j >= sbi->s_nzones)
 				break;
 			return j;
@@ -103,8 +105,8 @@ unsigned long minix_count_free_blocks(struct super_block *sb)
 		<< sbi->s_log_zone_size);
 }
 
-struct minix_inode *
-minix_V1_raw_inode(struct super_block *sb, ino_t ino, struct buffer_head **bh)
+struct minix_inode *minix_V1_raw_inode(struct super_block *sb, ino_t ino,
+				       struct buffer_head **bh)
 {
 	int block;
 	struct minix_sb_info *sbi = minix_sb(sb);
@@ -117,7 +119,7 @@ minix_V1_raw_inode(struct super_block *sb, ino_t ino, struct buffer_head **bh)
 	}
 	ino--;
 	block = 2 + sbi->s_imap_blocks + sbi->s_zmap_blocks +
-		 ino / MINIX_INODES_PER_BLOCK;
+		ino / MINIX_INODES_PER_BLOCK;
 	*bh = sb_bread(sb, block);
 	if (!*bh) {
 		printk("Unable to read inode block\n");
@@ -127,13 +129,14 @@ minix_V1_raw_inode(struct super_block *sb, ino_t ino, struct buffer_head **bh)
 	return p + ino % MINIX_INODES_PER_BLOCK;
 }
 
-struct minix2_inode *
-minix_V2_raw_inode(struct super_block *sb, ino_t ino, struct buffer_head **bh)
+struct minix2_inode *minix_V2_raw_inode(struct super_block *sb, ino_t ino,
+					struct buffer_head **bh)
 {
 	int block;
 	struct minix_sb_info *sbi = minix_sb(sb);
 	struct minix2_inode *p;
-	int minix2_inodes_per_block = sb->s_blocksize / sizeof(struct minix2_inode);
+	int minix2_inodes_per_block =
+		sb->s_blocksize / sizeof(struct minix2_inode);
 
 	*bh = NULL;
 	if (!ino || ino > sbi->s_ninodes) {
@@ -143,7 +146,7 @@ minix_V2_raw_inode(struct super_block *sb, ino_t ino, struct buffer_head **bh)
 	}
 	ino--;
 	block = 2 + sbi->s_imap_blocks + sbi->s_zmap_blocks +
-		 ino / minix2_inodes_per_block;
+		ino / minix2_inodes_per_block;
 	*bh = sb_bread(sb, block);
 	if (!*bh) {
 		printk("Unable to read inode block\n");
@@ -176,11 +179,11 @@ static void minix_clear_inode(struct inode *inode)
 	}
 	if (bh) {
 		mark_buffer_dirty(bh);
-		brelse (bh);
+		brelse(bh);
 	}
 }
 
-void minix_free_inode(struct inode * inode)
+void minix_free_inode(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
@@ -193,14 +196,14 @@ void minix_free_inode(struct inode * inode)
 		printk("minix_free_inode: inode 0 or nonexistent inode\n");
 		return;
 	}
-	bit = ino & ((1<<k) - 1);
+	bit = ino & ((1 << k) - 1);
 	ino >>= k;
 	if (ino >= sbi->s_imap_blocks) {
 		printk("minix_free_inode: nonexistent imap in superblock\n");
 		return;
 	}
 
-	minix_clear_inode(inode);	/* clear on-disk copy */
+	minix_clear_inode(inode); /* clear on-disk copy */
 
 	bh = sbi->s_imap[ino];
 	spin_lock(&bitmap_lock);
@@ -210,12 +213,13 @@ void minix_free_inode(struct inode * inode)
 	mark_buffer_dirty(bh);
 }
 
-struct inode *minix_new_inode(const struct inode *dir, umode_t mode, int *error)
+struct inode *minix_new_inode(const struct inode *dir,
+		umode_t mode, int *error)
 {
 	struct super_block *sb = dir->i_sb;
 	struct minix_sb_info *sbi = minix_sb(sb);
 	struct inode *inode = new_inode(sb);
-	struct buffer_head * bh;
+	struct buffer_head *bh;
 	int bits_per_zone = 8 * sb->s_blocksize;
 	unsigned long j;
 	int i;
@@ -239,7 +243,7 @@ struct inode *minix_new_inode(const struct inode *dir, umode_t mode, int *error)
 		iput(inode);
 		return NULL;
 	}
-	if (minix_test_and_set_bit(j, bh->b_data)) {	/* shouldn't happen */
+	if (minix_test_and_set_bit(j, bh->b_data)) { /* shouldn't happen */
 		spin_unlock(&bitmap_lock);
 		printk("minix_new_inode: bit already set\n");
 		iput(inode);
-- 
2.26.0

