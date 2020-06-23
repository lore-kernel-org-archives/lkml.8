Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1ADC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A681720738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQa8AWqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbgFWAqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731883AbgFWAqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:46:20 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A33C061796
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 17:45:27 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l188so4339232qkf.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 17:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=si2kjgv58qXbTAC/RlkXU5DQ/4DuwGRbCWH3I/I0x2c=;
        b=PQa8AWqbpOu4qXQJCZbba0vzqW5g+MOYYZAtV5JKQCRopYs7oKXkSuiJRNkcWGQhRz
         3giCdibusf2sADitQ6SRWooDBNJAnnD7V48jsjOMzJcS3w5po8p6RJRwHETGEfB3Az8T
         dMbRDkHp+86l2XWfxLqZh8kQxzKtHnB9o001L+Zqvye6xvLGMVmoSsvjiy3XpONvoPz0
         XeLKnyhmpipAD6VLWo5BPVhoDjE+mDaNlhGWTVqGEesA1dFStrRXhGE53MCnNmb4UHad
         Afi2iGFVas7k0wZZDn8xLCTa5Ekq6TJ+mSfwoKmbykB6P2e1cBpnPhh976SC0gfbB88e
         KZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=si2kjgv58qXbTAC/RlkXU5DQ/4DuwGRbCWH3I/I0x2c=;
        b=cEAyixNX8qPKgNUGLr7CLABvBgjI9Fr/DYCyD5y1geEJPqMVo0/WVtTxJp+RQmO+7q
         jkEAJBCPhkwuNaFjNNlDVBG7iIcHc20IbHuWVU2aWr2+oZBJV/sqRMx6FW12UrFvk3Hu
         RWMcPZgcQDoTuO64G8klQYKKIKI1fVDyLcf+g/A6ShsQP/paFqgtgXDbNy6YcPytcZjZ
         Izf9zaW5pSsWtmkoAGuDWtyBFGupJCyRMkrtpTEunhT+3gpD9ti0H0bDo91vZNHum4+0
         Uqxtu4UYuTocdbbaH2HgHZXd0sFv0WQSXa6oaMrLbU5YZuQMU75s+uwjtY/0/2mcEw85
         Vm6g==
X-Gm-Message-State: AOAM530+WiRcPqaKA+1GaLxxb5CRXKkCRKPpMq9g2/ZZdmUKoMJmHYmU
        TLYYk9Euij3efmv44z8qC3yM9KgT
X-Google-Smtp-Source: ABdhPJyD3e8iZXmtIxuBoMDjBig50sU4pW0aWDi4/RZ0sg0r6XqqTKXuwOmgIMnb/16sjsTtDGJ8Cw==
X-Received: by 2002:a37:9a06:: with SMTP id c6mr12605630qke.161.1592873126687;
        Mon, 22 Jun 2020 17:45:26 -0700 (PDT)
Received: from localhost.localdomain ([72.53.229.195])
        by smtp.gmail.com with ESMTPSA id r2sm9493715qtn.27.2020.06.22.17.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 17:45:26 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        David Howells <dhowells@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Janos Farkas <chexum+dev@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v1 1/2] romfs: use s_blocksize(_bits) if CONFIG_BLOCK
Date:   Mon, 22 Jun 2020 20:45:19 -0400
Message-Id: <20200623004520.26520-2-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200623004520.26520-1-TheSven73@gmail.com>
References: <20200623004520.26520-1-TheSven73@gmail.com>
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

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Janos Farkas <chexum+dev@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>
To: linux-kernel@vger.kernel.org
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

