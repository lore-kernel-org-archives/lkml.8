Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B926C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12541207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597924188;
	bh=0vbpsik9GH1sOS6luzvN5FmPVmEen3xws3Rpjd3rdO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WCWa7bKqpt9SdNb2SknI8t9J5aM9vsegheVkJtRfwAJP89OzSl4sNJ+LKaFJUriFg
	 GSp4eRPoP5XRVdGiBA1p1tQSJuVZLnbQyUnURG/MvhNcvcwxE/8aioTNHcLkd/zju+
	 x8Hr1Aqpq3eIjTMgFSnqfwwSf7C2VAXSadvtDJ/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbgHTLtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729936AbgHTKD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:03:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E50222BF5;
        Thu, 20 Aug 2020 10:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917801;
        bh=0vbpsik9GH1sOS6luzvN5FmPVmEen3xws3Rpjd3rdO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AVdpmPhiO6DH5c8isGQW1uUVU6An4JHXBkwM4tB8vRcLJf7YK/yJmj4Zogeg/hAgQ
         TwLMAcRnjfGJbcPtFphyDdsdUe4KQGejUYQe2iUFkpeG5O98E2lrhOYB4BQj2Ky+0Z
         e0XqdoehSD6iL47JJeVmDP0MNRARfipra0wVzAgo=
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
Subject: [PATCH 4.9 162/212] fs/minix: reject too-large maximum file size
Date:   Thu, 20 Aug 2020 11:22:15 +0200
Message-Id: <20200820091610.585803499@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
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
@@ -155,6 +155,23 @@ static int minix_remount (struct super_b
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
@@ -233,11 +250,12 @@ static int minix_fill_super(struct super
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


