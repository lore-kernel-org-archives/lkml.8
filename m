Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EF9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81071206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRMrEMK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbgFWAnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731566AbgFWAnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:43:09 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C583C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 17:43:09 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id h23so7061613qtr.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 17:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=gI9pS1mqjIiKsOZw3bHNWDsK2+KfBRfYsBXHVmchETY=;
        b=YRMrEMK2FD5EgAt7slTSNakAf3MQcSlDcU8BaG293S6SAhQ4NKnHBt6bFYUq1qZsaT
         p0D4h6K+X7F3H9CaBVBwBYF9yWHsyd/kDowWYvnCwCs3tzTNFz2lDzaWIOY1i8y3cfHT
         m8mg5fwS8kUkhkBAv6jzm4fzUvyn7T0jV+/8Ccwf62cwlRRC+Zzq855PqPXjdCQbCn3h
         EzNoBb0P+wREcyy3Hv3yaG9t3ntej2p9MiD12ciQUlK4huYBm1a0D9/A+E51bkXJu2Bf
         jvMG4l13y2++iPX/dDD2ViiXZRdUSuTn0RNUUUMBt3dAJBhvG0VXsdIf7LAwry1oE+Tp
         bmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=gI9pS1mqjIiKsOZw3bHNWDsK2+KfBRfYsBXHVmchETY=;
        b=ShV7ZRcvL4qosOHE4hTYcRkJmoll6ZUSAagSxFLHFsktkO4MvFvrebUqSJA/xeGOHr
         /voSyeRUfCd/Y6hex2Li0W7Ew4zts7zuajZ8+9zbA+C3HbuX14WXeWyidMXzxkRZ6M68
         bpH7eMWIT4MBCyh3Yuf9/nVpKXIa8fYv5BoCWtt7CPIhfdfO7ne3qxlhA4dzgvHzI9JO
         CaaA1AOJVIrieDMwdCeqnFKn83Oh9vjeJvUL5OSeos5Fp2DNrUeye3uCDAEJcQyXbXom
         g34+duos0YMyYdga0ZOzZR0MZoK+MURW2Z65IAPbgzD8yvK5LFGloQOmheEp0kGiZY2d
         oOFA==
X-Gm-Message-State: AOAM530bzyMPtkSqiGcthiFEwqYgr5VDPxCUrXyKXc++IgSKLRL0fUfS
        QgQYg5mkGHYlliPqqSlAeb59yI/u
X-Google-Smtp-Source: ABdhPJzjYFf0x4awSHwTVpIGnac8kpkZ/bjjVTwGs0nybFPwpEXCoGkXcx/S69sakiCkkQwf2ClUHw==
X-Received: by 2002:ac8:1742:: with SMTP id u2mr19651292qtk.341.1592872988144;
        Mon, 22 Jun 2020 17:43:08 -0700 (PDT)
Received: from localhost.localdomain ([72.53.229.195])
        by smtp.gmail.com with ESMTPSA id i14sm14544702qkl.105.2020.06.22.17.43.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 17:43:07 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] romfs: use s_blocksize(_bits) if CONFIG_BLOCK
Date:   Mon, 22 Jun 2020 20:43:00 -0400
Message-Id: <20200623004301.26117-2-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200623004301.26117-1-TheSven73@gmail.com>
References: <20200623004301.26117-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The super_block fields s_blocksize and s_blocksize_bits always
reflect the actual configured blocksize for a filesystem.

Use these in all calculations where blocksize is required.
This allows us to easily change the blocksize in a later patch.

Note that I cannot determine what happens if !CONFIG_BLOCK, as
I have no access to such a system. Out of an abundance of caution,
I have left all !CONFIG_BLOCK codepaths in their original state.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 fs/romfs/storage.c | 25 +++++++++++++------------
 fs/romfs/super.c   |  9 ++++++++-
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/fs/romfs/storage.c b/fs/romfs/storage.c
index 6b2b4362089e..5e84efadac3f 100644
--- a/fs/romfs/storage.c
+++ b/fs/romfs/storage.c
@@ -109,9 +109,9 @@ static int romfs_blk_read(struct super_block *sb, unsigned long pos,
 
 	/* copy the string up to blocksize bytes at a time */
 	while (buflen > 0) {
-		offset = pos & (ROMBSIZE - 1);
-		segment = min_t(size_t, buflen, ROMBSIZE - offset);
-		bh = sb_bread(sb, pos >> ROMBSBITS);
+		offset = pos & (sb->s_blocksize - 1);
+		segment = min_t(size_t, buflen, sb->s_blocksize - offset);
+		bh = sb_bread(sb, pos >> sb->s_blocksize_bits);
 		if (!bh)
 			return -EIO;
 		memcpy(buf, bh->b_data + offset, segment);
@@ -138,9 +138,9 @@ static ssize_t romfs_blk_strnlen(struct super_block *sb,
 
 	/* scan the string up to blocksize bytes at a time */
 	while (limit > 0) {
-		offset = pos & (ROMBSIZE - 1);
-		segment = min_t(size_t, limit, ROMBSIZE - offset);
-		bh = sb_bread(sb, pos >> ROMBSBITS);
+		offset = pos & (sb->s_blocksize - 1);
+		segment = min_t(size_t, limit, sb->s_blocksize - offset);
+		bh = sb_bread(sb, pos >> sb->s_blocksize_bits);
 		if (!bh)
 			return -EIO;
 		buf = bh->b_data + offset;
@@ -170,9 +170,9 @@ static int romfs_blk_strcmp(struct super_block *sb, unsigned long pos,
 
 	/* compare string up to a block at a time */
 	while (size > 0) {
-		offset = pos & (ROMBSIZE - 1);
-		segment = min_t(size_t, size, ROMBSIZE - offset);
-		bh = sb_bread(sb, pos >> ROMBSBITS);
+		offset = pos & (sb->s_blocksize - 1);
+		segment = min_t(size_t, size, sb->s_blocksize - offset);
+		bh = sb_bread(sb, pos >> sb->s_blocksize_bits);
 		if (!bh)
 			return -EIO;
 		matched = (memcmp(bh->b_data + offset, str, segment) == 0);
@@ -180,7 +180,8 @@ static int romfs_blk_strcmp(struct super_block *sb, unsigned long pos,
 		size -= segment;
 		pos += segment;
 		str += segment;
-		if (matched && size == 0 && offset + segment < ROMBSIZE) {
+		if (matched && size == 0 &&
+				offset + segment < sb->s_blocksize) {
 			if (!bh->b_data[offset + segment])
 				terminated = true;
 			else
@@ -194,8 +195,8 @@ static int romfs_blk_strcmp(struct super_block *sb, unsigned long pos,
 	if (!terminated) {
 		/* the terminating NUL must be on the first byte of the next
 		 * block */
-		BUG_ON((pos & (ROMBSIZE - 1)) != 0);
-		bh = sb_bread(sb, pos >> ROMBSBITS);
+		BUG_ON((pos & (sb->s_blocksize - 1)) != 0);
+		bh = sb_bread(sb, pos >> sb->s_blocksize_bits);
 		if (!bh)
 			return -EIO;
 		matched = !bh->b_data[0];
diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index e582d001f792..6fecdea791f1 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -411,10 +411,17 @@ static int romfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 	buf->f_type = ROMFS_MAGIC;
 	buf->f_namelen = ROMFS_MAXFN;
-	buf->f_bsize = ROMBSIZE;
 	buf->f_bfree = buf->f_bavail = buf->f_ffree;
+#ifdef CONFIG_BLOCK
+	buf->f_bsize = sb->s_blocksize;
+	buf->f_blocks =
+		(romfs_maxsize(dentry->d_sb) + sb->s_blocksize - 1) >>
+		sb->s_blocksize_bits;
+#else
+	buf->f_bsize = ROMBSIZE;
 	buf->f_blocks =
 		(romfs_maxsize(dentry->d_sb) + ROMBSIZE - 1) >> ROMBSBITS;
+#endif
 	buf->f_fsid.val[0] = (u32)id;
 	buf->f_fsid.val[1] = (u32)(id >> 32);
 	return 0;
-- 
2.17.1

