Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F260C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F89920775
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591662173;
	bh=L0QoRAgWtQseVlwB82qHXXUrftjn7bHptGI3PhND3X4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NliXCGu4q5z2SAfS1B/YTXKoZFAbftkZ3sqGSNq68e7QHBJNqmfbpz4GdQr+r9y1C
	 zJ1aIb5WG3BDDluBa4vLXW7FEnRo7jOZtKafeuS00drFxjUVqAMUCrdvRRl58VOsrV
	 o5a3ZW4E2c5LJAvxH6eC/4T394LOsEvwVBHgyxkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbgFHXRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:17:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbgFHXOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:14:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 326AC208C3;
        Mon,  8 Jun 2020 23:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658041;
        bh=L0QoRAgWtQseVlwB82qHXXUrftjn7bHptGI3PhND3X4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iMR6LUf3s/UtJRp1qy7d/lXnDk/D7Xlwj52UjYKvNFupnqVPt/32pKnYph8JRXlCl
         ekEb85ARQrwi7DapD+G/1M/BI4uhrbF12uZlITHqf3lv59LfU3TkSfDkvLm8aQJrTl
         Vfc4nvBZ0mdIvTJYc91+31oG2ff7lIZ/6k7xRH5Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>, linux-mtd@lists.infradead.org
Subject: [PATCH AUTOSEL 5.6 091/606] ubifs: remove broken lazytime support
Date:   Mon,  8 Jun 2020 19:03:36 -0400
Message-Id: <20200608231211.3363633-91-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

