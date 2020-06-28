Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D295BC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 06:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A542320702
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 06:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593324662;
	bh=Wb34f6YaEsfsLzZc+19skL3TFpPrVgSg64xcmo1mMfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aD6XiR0UhT5EeYF7Y2iJZkHp4p15flo3z+sNKIDv7NFRW92RW02o1a26BN/4j9Qpk
	 GjhKvsroESEIyUbv9Fw1zexoz/URaV7PkQ/GrLkUqMsnxfL154wDpJ4JbnSX8DKcpH
	 kGJnZ0KXrZRS3N3ou8axXLqFz/RrH8j+KjV3sOzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgF1GLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 02:11:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbgF1GKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 02:10:36 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8E662145D;
        Sun, 28 Jun 2020 06:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593324636;
        bh=Wb34f6YaEsfsLzZc+19skL3TFpPrVgSg64xcmo1mMfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=08ZhrHK/MNWDqDnSW9PXmSFzOsc+jrVDUK3HWQENJUNUghQ3EhJtcw4k2laTwRsZO
         j/7R02nkigf4TCGqqrcLGoaQP13qnj4XZuIVVYobwiRlU7+wuaSHZISsp7wMKc8Qs/
         ZOSC1vPLDXdA69pAl4qVamYNdOnVFZN6tREsTT4A=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH 5/6] fs/minix: fix block limit check for V1 filesystems
Date:   Sat, 27 Jun 2020 23:08:44 -0700
Message-Id: <20200628060846.682158-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200628060846.682158-1-ebiggers@kernel.org>
References: <20200628060846.682158-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The minix filesystem reads its maximum file size from its on-disk
superblock.  This value isn't necessarily a multiple of the block size.
When it's not, the V1 block mapping code doesn't allow mapping the last
possible block.  Commit 6ed6a722f9ab ("minixfs: fix block limit check")
fixed this in the V2 mapping code.  Fix it in the V1 mapping code too.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/minix/itree_v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/minix/itree_v1.c b/fs/minix/itree_v1.c
index c0d418209ead..405573a79aab 100644
--- a/fs/minix/itree_v1.c
+++ b/fs/minix/itree_v1.c
@@ -29,7 +29,7 @@ static int block_to_path(struct inode * inode, long block, int offsets[DEPTH])
 	if (block < 0) {
 		printk("MINIX-fs: block_to_path: block %ld < 0 on dev %pg\n",
 			block, inode->i_sb->s_bdev);
-	} else if (block >= inode->i_sb->s_maxbytes/BLOCK_SIZE) {
+	} else if ((u64)block * BLOCK_SIZE >= inode->i_sb->s_maxbytes) {
 		if (printk_ratelimit())
 			printk("MINIX-fs: block_to_path: "
 			       "block %ld too big on dev %pg\n",
-- 
2.27.0

