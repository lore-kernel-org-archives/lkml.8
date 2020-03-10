Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B65C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8C124680
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583847359;
	bh=LZ40uhp+Qj5rGMav06nF1ngi0XnelvzK7sYakf3VD2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PPApyvSQ/MMHoIK7GksHjbo61fXKfMTR4NTYbmTPlY7VRx+wXVOpxGTNJttnP0gL/
	 79wGd4A0XjJWub1Tqpw0q3PbTMTic8/N+A8gm/2b11Zw+xF8ltAT3lBsRA0ziRpdvK
	 gPsapVaoYL0qQat/YDm45DVA0rsKJIDzpShmWuPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgCJNf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727613AbgCJMni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:43:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 936AD24695;
        Tue, 10 Mar 2020 12:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844218;
        bh=LZ40uhp+Qj5rGMav06nF1ngi0XnelvzK7sYakf3VD2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aErLiDpfHs+eU2lPab9l8KhGv90dtumtOtQ1VIcRtPvswq14DxIKmzL2cjO+Lj/2A
         0XEFFhMpOsP1lJ43eHcgkl04TyxXh28sPaXKPf74r1IST4p7KXw/tNp11ZH+TnHfzc
         oCWXuWKow4W55O5KKIySKVXN5+7iZNhdjIpZFTiM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+9d82b8de2992579da5d0@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 56/72] fat: fix uninit-memory access for partial initialized inode
Date:   Tue, 10 Mar 2020 13:39:09 +0100
Message-Id: <20200310123615.177738527@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123601.053680753@linuxfoundation.org>
References: <20200310123601.053680753@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

commit bc87302a093f0eab45cd4e250c2021299f712ec6 upstream.

When get an error in the middle of reading an inode, some fields in the
inode might be still not initialized.  And then the evict_inode path may
access those fields via iput().

To fix, this makes sure that inode fields are initialized.

Reported-by: syzbot+9d82b8de2992579da5d0@syzkaller.appspotmail.com
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/871rqnreqx.fsf@mail.parknet.co.jp
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fat/inode.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -653,6 +653,13 @@ static struct inode *fat_alloc_inode(str
 		return NULL;
 
 	init_rwsem(&ei->truncate_lock);
+	/* Zeroing to allow iput() even if partial initialized inode. */
+	ei->mmu_private = 0;
+	ei->i_start = 0;
+	ei->i_logstart = 0;
+	ei->i_attrs = 0;
+	ei->i_pos = 0;
+
 	return &ei->vfs_inode;
 }
 
@@ -1276,16 +1283,6 @@ out:
 	return 0;
 }
 
-static void fat_dummy_inode_init(struct inode *inode)
-{
-	/* Initialize this dummy inode to work as no-op. */
-	MSDOS_I(inode)->mmu_private = 0;
-	MSDOS_I(inode)->i_start = 0;
-	MSDOS_I(inode)->i_logstart = 0;
-	MSDOS_I(inode)->i_attrs = 0;
-	MSDOS_I(inode)->i_pos = 0;
-}
-
 static int fat_read_root(struct inode *inode)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
@@ -1730,13 +1727,11 @@ int fat_fill_super(struct super_block *s
 	fat_inode = new_inode(sb);
 	if (!fat_inode)
 		goto out_fail;
-	fat_dummy_inode_init(fat_inode);
 	sbi->fat_inode = fat_inode;
 
 	fsinfo_inode = new_inode(sb);
 	if (!fsinfo_inode)
 		goto out_fail;
-	fat_dummy_inode_init(fsinfo_inode);
 	fsinfo_inode->i_ino = MSDOS_FSINFO_INO;
 	sbi->fsinfo_inode = fsinfo_inode;
 	insert_inode_hash(fsinfo_inode);


