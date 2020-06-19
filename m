Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A04C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 620EA206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592581057;
	bh=ODtiBtkmDmoeoNHrq7w+eQVE6/6veRoEj9SxNrZcqI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WphtZvMIqmSwk00qA1VNqnAamfFqgdYQ1sw0e74PDHIRvAWoetLsRABoLD9MpM4eq
	 uICdDrOuL3evkz4I9+TcMvUjqzWgAGnlP8EpyA+G8JjbrL5sao19to80wOcjhcxLpN
	 gEapPXSdZbpc81nWgKKWnf6RK/FIqYHbjLmkAE14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405136AbgFSPhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:37:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404757AbgFSPaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:30:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3228920734;
        Fri, 19 Jun 2020 15:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580600;
        bh=ODtiBtkmDmoeoNHrq7w+eQVE6/6veRoEj9SxNrZcqI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EDeHJFJSgqSYe2R2evQDAxNSaCm7Pj27A8KX0Up8wd95HwrQW2ypbDWs6FwjI3uTn
         qHsD+tO6U5RAsuJ+w7T+uBg9293L8JiZ+8ko4ufMFsb80eCiTZ8L2pAHYPwxwYNNWe
         MFqqvUFTe2+6OIfWliBCX77xlAsH+ZVPJuuuFq4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>, stable@kernel.org,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.7 281/376] ext4: fix buffer_head refcnt leak when ext4_iget() fails
Date:   Fri, 19 Jun 2020 16:33:19 +0200
Message-Id: <20200619141723.638850700@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

commit 3bbd0ef26098d241dc59ee77ba14b7dab0df0786 upstream.

ext4_orphan_get() invokes ext4_read_inode_bitmap(), which returns a
reference of the specified buffer_head object to "bitmap_bh" with
increased refcnt.

When ext4_orphan_get() returns, local variable "bitmap_bh" becomes
invalid, so the refcount should be decreased to keep refcount balanced.

The reference counting issue happens in one exception handling path of
ext4_orphan_get(). When ext4_iget() fails, the function forgets to
decrease the refcnt increased by ext4_read_inode_bitmap(), causing a
refcnt leak.

Fix this issue by calling brelse() when ext4_iget() fails.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Cc: stable@kernel.org
Link: https://lore.kernel.org/r/1587618568-13418-1-git-send-email-xiyuyang19@fudan.edu.cn
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/ialloc.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1246,6 +1246,7 @@ struct inode *ext4_orphan_get(struct sup
 		ext4_error_err(sb, -err,
 			       "couldn't read orphan inode %lu (err %d)",
 			       ino, err);
+		brelse(bitmap_bh);
 		return inode;
 	}
 


