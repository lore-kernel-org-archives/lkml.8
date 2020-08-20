Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E22C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F52D2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597917368;
	bh=n7wzPQ3M0ERQ59sffFXEWhQWFOF761BQYOzZAulle1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fIeUlqRaYWbnVY+/YWTPPcJGTuacBpy/LzPrQnWIB/8ygJuIxZMKFG1xBHEWcXsQ1
	 pXTbkRJZXopvCPkUX55v87qRqD1L0jAyeonACY8NV84qp+BcSRZDADmsX2FuiGupFx
	 fCnv5jmDnkD665A3sTtYER5pI/yRL44uNKYO3nYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbgHTJ4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:56:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730219AbgHTJzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:55:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30CAC2067C;
        Thu, 20 Aug 2020 09:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917350;
        bh=n7wzPQ3M0ERQ59sffFXEWhQWFOF761BQYOzZAulle1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HWNBt75kHj/CQVv8X8Dv/YKdtDC34vHwTzPKk0l3RXdtuZXiR+y0xwZ/p9HhoW0+V
         ZTkP7LB6zjHRBFLmhIoM+eihkYagqobeFrXG124RvO5HYFOREx2jabXBA1nA4yPVl0
         nrrVd7OamLH23iqlB/9dSkeQRFpv3qJ1DD28yLVo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Qiujun Huang <anenbupt@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 79/92] fs/minix: fix block limit check for V1 filesystems
Date:   Thu, 20 Aug 2020 11:22:04 +0200
Message-Id: <20200820091541.764302089@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091537.490965042@linuxfoundation.org>
References: <20200820091537.490965042@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit 0a12c4a8069607247cb8edc3b035a664e636fd9a ]

The minix filesystem reads its maximum file size from its on-disk
superblock.  This value isn't necessarily a multiple of the block size.
When it's not, the V1 block mapping code doesn't allow mapping the last
possible block.  Commit 6ed6a722f9ab ("minixfs: fix block limit check")
fixed this in the V2 mapping code.  Fix it in the V1 mapping code too.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Qiujun Huang <anenbupt@gmail.com>
Link: http://lkml.kernel.org/r/20200628060846.682158-6-ebiggers@kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/minix/itree_v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/minix/itree_v1.c b/fs/minix/itree_v1.c
index c0d418209ead1..405573a79aab4 100644
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
2.25.1



