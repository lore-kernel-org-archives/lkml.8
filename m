Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BFBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 515222158C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580177;
	bh=P9JcKZNM/8l/scsQa6x9Ys0iK7XhzU3x66U2UwdZeQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FPWDpf2u12MkKJOmUnY/LAycdgIEcR7xWF2DOpz/LsqmQipnQ2oQMGZOmJquaM3+t
	 a2Xu0N9drJIh3pBMkevVrgeALQbElus2zlF5yKwmOZdjobAPkVemAQpAtxTSJ7xC49
	 /UzDYySuRyOtJsIBTVqyFCP9fqWo/WXL1GOix4ns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393094AbgFSPWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:22:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403903AbgFSPTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:19:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E87472184D;
        Fri, 19 Jun 2020 15:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579939;
        bh=P9JcKZNM/8l/scsQa6x9Ys0iK7XhzU3x66U2UwdZeQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DPgWiUoB3A84rz2VvIf831tWXtZKyXyqbSF8lZFdSji5OMBZdDioic+2a6Ly7B6tx
         nByrM41F8pKMYGoad1CHWleJhKQoJyv3Du5CzCtzSHaVDNUpd2KQIO15CqtCrMb8JC
         m3QUtdsUpGoi/xzc198Z5KAa0LpY8JuuC661AtT4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 062/376] btrfs: account for trans_block_rsv in may_commit_transaction
Date:   Fri, 19 Jun 2020 16:29:40 +0200
Message-Id: <20200619141713.292497147@linuxfoundation.org>
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

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit bb4f58a747f0421b10645fbf75a6acc88da0de50 ]

On ppc64le with 64k page size (respectively 64k block size) generic/320
was failing and debug output showed we were getting a premature ENOSPC
with a bunch of space in btrfs_fs_info::trans_block_rsv.

This meant there were still open transaction handles holding space, yet
the flusher didn't commit the transaction because it deemed the freed
space won't be enough to satisfy the current reserve ticket. Fix this
by accounting for space in trans_block_rsv when deciding whether the
current transaction should be committed or not.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/space-info.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index ff17a4420358..3c0e9999bfd7 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -626,6 +626,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	struct reserve_ticket *ticket = NULL;
 	struct btrfs_block_rsv *delayed_rsv = &fs_info->delayed_block_rsv;
 	struct btrfs_block_rsv *delayed_refs_rsv = &fs_info->delayed_refs_rsv;
+	struct btrfs_block_rsv *trans_rsv = &fs_info->trans_block_rsv;
 	struct btrfs_trans_handle *trans;
 	u64 bytes_needed;
 	u64 reclaim_bytes = 0;
@@ -688,6 +689,11 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	spin_lock(&delayed_refs_rsv->lock);
 	reclaim_bytes += delayed_refs_rsv->reserved;
 	spin_unlock(&delayed_refs_rsv->lock);
+
+	spin_lock(&trans_rsv->lock);
+	reclaim_bytes += trans_rsv->reserved;
+	spin_unlock(&trans_rsv->lock);
+
 	if (reclaim_bytes >= bytes_needed)
 		goto commit;
 	bytes_needed -= reclaim_bytes;
-- 
2.25.1



