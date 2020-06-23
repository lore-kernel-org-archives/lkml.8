Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC00AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 870432137B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943447;
	bh=yjLNnVrXTbpjqg3oWOo5sCoBcJMvFQZ0j9rLHkHf8so=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DuBNGqOg44jaJs2XoDoMl81BYcQBjcK3gAjYTTQJKUbIbYiHyKshx+yf9i9Jt79Tu
	 EJ2aLKHuAg0strOLeKnwQH0nnBV7JaxWf/zHmXigHY5fcBt0Tqk+zg0iVc+CpaqzFV
	 gbVw4RuPqtxhTJXgZD5rXOkee6HucmVzcEh/At7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389556AbgFWURZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:17:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389540AbgFWURW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:17:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D083B2080C;
        Tue, 23 Jun 2020 20:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943442;
        bh=yjLNnVrXTbpjqg3oWOo5sCoBcJMvFQZ0j9rLHkHf8so=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wREgFz49PHGA7lQTpE5j713py80xWZrk6aw2qDraQqrbDKL9KHVFtySfiWw/qPlRv
         umVJ8MXeRswQCcgKLOazFkoUJZDdHecV12s66FfRpIsHen1ShL52DFYsealeY4Na7Q
         UiUzoM/grRzIGsgJzXkwVRvPJvp7gK1OP79UT0Nk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 393/477] afs: afs_write_end() should change i_size under the right lock
Date:   Tue, 23 Jun 2020 21:56:30 +0200
Message-Id: <20200623195426.103767931@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit 1f32ef79897052ef7d3d154610d8d6af95abde83 ]

Fix afs_write_end() to change i_size under vnode->cb_lock rather than
->wb_lock so that it doesn't race with afs_vnode_commit_status() and
afs_getattr().

The ->wb_lock is only meant to guard access to ->wb_keys which isn't
accessed by that piece of code.

Fixes: 4343d00872e1 ("afs: Get rid of the afs_writeback record")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/write.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 371db86c6c5ec..96b042af62485 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -194,11 +194,11 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 
 	i_size = i_size_read(&vnode->vfs_inode);
 	if (maybe_i_size > i_size) {
-		spin_lock(&vnode->wb_lock);
+		write_seqlock(&vnode->cb_lock);
 		i_size = i_size_read(&vnode->vfs_inode);
 		if (maybe_i_size > i_size)
 			i_size_write(&vnode->vfs_inode, maybe_i_size);
-		spin_unlock(&vnode->wb_lock);
+		write_sequnlock(&vnode->cb_lock);
 	}
 
 	if (!PageUptodate(page)) {
-- 
2.25.1



