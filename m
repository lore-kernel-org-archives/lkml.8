Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAF7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AE9D20738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597919271;
	bh=biRqXmOebpO0pjYFSWAZMT/eOE9edb5Rb+V4jgapiJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qCdcQDGQMwKhAF4uW+PLEPcOieV65cU2PwJcyLaoIO2Fky4TvGanyscRDQx4zXgpb
	 YZerciSGG9/Pd14qjMysl06VRIVB9tTxicReGnroAt4zsYL7WRlP332YNycS8/eVj6
	 ZCh0p5JUOQrjd88vstyYPRU72VMuMf4RPOaxre24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbgHTKWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:22:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731569AbgHTKVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:21:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D908920658;
        Thu, 20 Aug 2020 10:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918909;
        bh=biRqXmOebpO0pjYFSWAZMT/eOE9edb5Rb+V4jgapiJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p2WY2XQRa9f5fcYllscB2s+85apvuBaMnxibSPvySLTtJbDr2N2yLR9rV8nde+MD/
         8bP/7LR6BXGCUSEhbejk4NboxdNrkOmWPEmx4LBT0ZK2xzlO7qQtWF+4lFWb9zVxNI
         ZO6TTId+wjjijFm9elFGGOkVyy70EWkpusjyON9E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+4a88b2b9dc280f47baf4@syzkaller.appspotmail.com,
        Eric Biggers <ebiggers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qiujun Huang <anenbupt@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 111/149] fs/minix: check return value of sb_getblk()
Date:   Thu, 20 Aug 2020 11:23:08 +0200
Message-Id: <20200820092131.077639425@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit da27e0a0e5f655f0d58d4e153c3182bb2b290f64 upstream.

Patch series "fs/minix: fix syzbot bugs and set s_maxbytes".

This series fixes all syzbot bugs in the minix filesystem:

	KASAN: null-ptr-deref Write in get_block
	KASAN: use-after-free Write in get_block
	KASAN: use-after-free Read in get_block
	WARNING in inc_nlink
	KMSAN: uninit-value in get_block
	WARNING in drop_nlink

It also fixes the minix filesystem to set s_maxbytes correctly, so that
userspace sees the correct behavior when exceeding the max file size.

This patch (of 6):

sb_getblk() can fail, so check its return value.

This fixes a NULL pointer dereference.

Originally from Qiujun Huang.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+4a88b2b9dc280f47baf4@syzkaller.appspotmail.com
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Qiujun Huang <anenbupt@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/20200628060846.682158-1-ebiggers@kernel.org
Link: http://lkml.kernel.org/r/20200628060846.682158-2-ebiggers@kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/minix/itree_common.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/fs/minix/itree_common.c
+++ b/fs/minix/itree_common.c
@@ -74,6 +74,7 @@ static int alloc_branch(struct inode *in
 	int n = 0;
 	int i;
 	int parent = minix_new_block(inode);
+	int err = -ENOSPC;
 
 	branch[0].key = cpu_to_block(parent);
 	if (parent) for (n = 1; n < num; n++) {
@@ -84,6 +85,11 @@ static int alloc_branch(struct inode *in
 			break;
 		branch[n].key = cpu_to_block(nr);
 		bh = sb_getblk(inode->i_sb, parent);
+		if (!bh) {
+			minix_free_block(inode, nr);
+			err = -ENOMEM;
+			break;
+		}
 		lock_buffer(bh);
 		memset(bh->b_data, 0, bh->b_size);
 		branch[n].bh = bh;
@@ -102,7 +108,7 @@ static int alloc_branch(struct inode *in
 		bforget(branch[i].bh);
 	for (i = 0; i < n; i++)
 		minix_free_block(inode, block_to_cpu(branch[i].key));
-	return -ENOSPC;
+	return err;
 }
 
 static inline int splice_branch(struct inode *inode,


