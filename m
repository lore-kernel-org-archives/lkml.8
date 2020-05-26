Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E6DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1411320776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520916;
	bh=L0QoRAgWtQseVlwB82qHXXUrftjn7bHptGI3PhND3X4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T9AowTqDyMsGEyjr+cdt3X8SuZOSYIwv73IjQSeg5QohbnHNL5pUr7ljhtmAAMRZ9
	 wSmJ2Ma1iwCld1P5DKS9ZhQn+rIycmNTT498nsAuAhwr1PTTNy1vG8dJcnNV6mjpJl
	 Qg0PbRB2jdl2UG+JaMGZZE57zwfJ0Ymry+o/RZss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404483AbgEZTVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:21:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392034AbgEZTLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:11:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A367208A7;
        Tue, 26 May 2020 19:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520265;
        bh=L0QoRAgWtQseVlwB82qHXXUrftjn7bHptGI3PhND3X4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AlB5ZTOxHiD5FL7+6QVddGEz94eUhBZyo7WzpjMHR38Y5IAeT4h6EysNxtmMePSar
         HzdmScxifGwB/eAeudyCubR1KfMXnY6l6EbY2H4jeUOTSxRS3n2P25h3va0Df/B50G
         ahTBd16esq3gF+G0QwQbOZiiu7sX4WZcNaOxn+Tg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 012/126] ubifs: remove broken lazytime support
Date:   Tue, 26 May 2020 20:52:29 +0200
Message-Id: <20200526183938.597411064@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183937.471379031@linuxfoundation.org>
References: <20200526183937.471379031@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit ecf84096a526f2632ee85c32a3d05de3fa60ce80 ]

When "ubifs: introduce UBIFS_ATIME_SUPPORT to ubifs" introduced atime
support to ubifs, it also added lazytime support.  As far as I can tell
the lazytime support is terminally broken, as it causes
mark_inode_dirty_sync to be called from __writeback_single_inode, which
will then trigger the locking assert in ubifs_dirty_inode.  Just remove
the broken lazytime support for now, it can be added back later,
especially as some infrastructure changes should make that easier soon.

Fixes: 8c1c5f263833 ("ubifs: introduce UBIFS_ATIME_SUPPORT to ubifs")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ubifs/file.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 743928efffc1..49fe062ce45e 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1375,7 +1375,6 @@ int ubifs_update_time(struct inode *inode, struct timespec64 *time,
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	struct ubifs_budget_req req = { .dirtied_ino = 1,
 			.dirtied_ino_d = ALIGN(ui->data_len, 8) };
-	int iflags = I_DIRTY_TIME;
 	int err, release;
 
 	if (!IS_ENABLED(CONFIG_UBIFS_ATIME_SUPPORT))
@@ -1393,11 +1392,8 @@ int ubifs_update_time(struct inode *inode, struct timespec64 *time,
 	if (flags & S_MTIME)
 		inode->i_mtime = *time;
 
-	if (!(inode->i_sb->s_flags & SB_LAZYTIME))
-		iflags |= I_DIRTY_SYNC;
-
 	release = ui->dirty;
-	__mark_inode_dirty(inode, iflags);
+	__mark_inode_dirty(inode, I_DIRTY_SYNC);
 	mutex_unlock(&ui->ui_mutex);
 	if (release)
 		ubifs_release_budget(c, &req);
-- 
2.25.1



