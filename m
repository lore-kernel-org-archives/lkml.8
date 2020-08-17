Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CC8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D2420786
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597689743;
	bh=tu5BHVgGfCYGAiaqVkbBFErksR4pdIG1CSJuZ8WnQyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LU/PIjYifgn0N5jVdRO5VWGP/qrvjQQEH9EC25px1S4zliEZejAAz9jGw+5T8qNZO
	 +dYT3HKxi9++gjSHYqb7/X5FmD/pYAuvqCRV94sKYtiVDIthDf6KOA0JC9or3tSZer
	 gIzrBO8dJgCPda+oSYTiXDeyAPPBby6MqFCOT48g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391455AbgHQSmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:42:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387519AbgHQP5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:57:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A149120729;
        Mon, 17 Aug 2020 15:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679835;
        bh=tu5BHVgGfCYGAiaqVkbBFErksR4pdIG1CSJuZ8WnQyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mySpNKUzApYfNDfaJ0f8FtJAR3hY8XSYzRhtBG35PaHESB7u9H4XHS8ADYmt6RwKY
         OGIcYqBkNzEqh/rClkgbm8BdRCWtPP38u8fLHVe9rH+bbUl38boR4T+LamJITSW/dD
         YjUhnpq7od/zCIqr5MWAh59RVRDGMGuhLnxyuD0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c7d9ec7a1a7272dd71b3@syzkaller.appspotmail.com,
        syzbot+3b7b03a0c28948054fb5@syzkaller.appspotmail.com,
        syzbot+6e056ee473568865f3e6@syzkaller.appspotmail.com,
        Eric Biggers <ebiggers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Qiujun Huang <anenbupt@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.7 349/393] fs/minix: reject too-large maximum file size
Date:   Mon, 17 Aug 2020 17:16:39 +0200
Message-Id: <20200817143836.530703027@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 270ef41094e9fa95273f288d7d785313ceab2ff3 upstream.

If the minix filesystem tries to map a very large logical block number to
its on-disk location, block_to_path() can return offsets that are too
large, causing out-of-bounds memory accesses when accessing indirect index
blocks.  This should be prevented by the check against the maximum file
size, but this doesn't work because the maximum file size is read directly
from the on-disk superblock and isn't validated itself.

Fix this by validating the maximum file size at mount time.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+c7d9ec7a1a7272dd71b3@syzkaller.appspotmail.com
Reported-by: syzbot+3b7b03a0c28948054fb5@syzkaller.appspotmail.com
Reported-by: syzbot+6e056ee473568865f3e6@syzkaller.appspotmail.com
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Qiujun Huang <anenbupt@gmail.com>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/20200628060846.682158-4-ebiggers@kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/minix/inode.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -150,6 +150,23 @@ static int minix_remount (struct super_b
 	return 0;
 }
 
+static bool minix_check_superblock(struct minix_sb_info *sbi)
+{
+	if (sbi->s_imap_blocks == 0 || sbi->s_zmap_blocks == 0)
+		return false;
+
+	/*
+	 * s_max_size must not exceed the block mapping limitation.  This check
+	 * is only needed for V1 filesystems, since V2/V3 support an extra level
+	 * of indirect blocks which places the limit well above U32_MAX.
+	 */
+	if (sbi->s_version == MINIX_V1 &&
+	    sbi->s_max_size > (7 + 512 + 512*512) * BLOCK_SIZE)
+		return false;
+
+	return true;
+}
+
 static int minix_fill_super(struct super_block *s, void *data, int silent)
 {
 	struct buffer_head *bh;
@@ -228,11 +245,12 @@ static int minix_fill_super(struct super
 	} else
 		goto out_no_fs;
 
+	if (!minix_check_superblock(sbi))
+		goto out_illegal_sb;
+
 	/*
 	 * Allocate the buffer map to keep the superblock small.
 	 */
-	if (sbi->s_imap_blocks == 0 || sbi->s_zmap_blocks == 0)
-		goto out_illegal_sb;
 	i = (sbi->s_imap_blocks + sbi->s_zmap_blocks) * sizeof(bh);
 	map = kzalloc(i, GFP_KERNEL);
 	if (!map)


