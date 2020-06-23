Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D76C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B85BA20702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592946613;
	bh=yjLNnVrXTbpjqg3oWOo5sCoBcJMvFQZ0j9rLHkHf8so=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KwiwYURPIkB/0n6WWATQVN3WnoxpwF2/NVChFsF47UqSLh9ntGLXHzgT92sVRVEcT
	 1KTzU1z0G7RxvRRaWcvmHoqwc74yxJVyGe3/5+2mwVCxnSkLQJ5j0QNEZmwgxd97jA
	 MirsZjAnZof2smJfbFkT7ypmZ2UuzDOHN/1F5lbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393395AbgFWVKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390818AbgFWUdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:33:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC5072098B;
        Tue, 23 Jun 2020 20:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944424;
        bh=yjLNnVrXTbpjqg3oWOo5sCoBcJMvFQZ0j9rLHkHf8so=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lnqknm3WwGU6o9vzOJz12+vTMekZJycytHwYFEh47vNDSclsbkQ6bXL3e0GAMl3Gf
         tTWD62C2QFV9FElQXzC6lgAUu1tpUVKdslFpU7DMbzEyNreDdas8/ZhJknnhYGZ/8A
         HXwk3h7dJ7/bIUTCbXIfR6taBY1ijzEy1PivWqm4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 269/314] afs: afs_write_end() should change i_size under the right lock
Date:   Tue, 23 Jun 2020 21:57:44 +0200
Message-Id: <20200623195351.817322134@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
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



