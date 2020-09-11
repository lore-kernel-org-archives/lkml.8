Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E229CC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 13:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E84E22229
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 13:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599829332;
	bh=YXvxJU50/o7JM1lhiqRe+v3U3CdBUoWn/IcA6FOdLtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FbesL0VkIv0enm9iDr3k4+kfh/PfQLKegPVRk9XIdOR8crOES8io/13hw0erw0o6v
	 TmhXmK8aEqaFd6Vtnjl16XwzlyqBMgrgSj/wu3getPdBahr9mDwi1Cxk+V6c535cJB
	 o9/jtmnz1M/jUhj5kqI0HP04Bj4OafiVFdYfDnhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgIKNBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 09:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgIKMzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:55:03 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 747A12222C;
        Fri, 11 Sep 2020 12:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599828849;
        bh=YXvxJU50/o7JM1lhiqRe+v3U3CdBUoWn/IcA6FOdLtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2kayIAgVnjSzg52/+yfMhtFCLplH4sRKNJ+qdKO/8mGfDOR/bk0uYe7zQ1cXuCKBe
         fZNSGMu4up59QrMnAoWtmlhHHFBMymR4my6zcrSyPw57uKtOTSmZdT87IDr4XubbsO
         DeGHwW5WaZl4hUPCg7nRys00sI6IDwjXi8mf59S0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 23/62] btrfs: Remove redundant extent_buffer_get in get_old_root
Date:   Fri, 11 Sep 2020 14:46:06 +0200
Message-Id: <20200911122503.553102172@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911122502.395450276@linuxfoundation.org>
References: <20200911122502.395450276@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolay Borisov <nborisov@suse.com>

[ Upstream commit 6c122e2a0c515cfb3f3a9cefb5dad4cb62109c78 ]

get_old_root used used only by btrfs_search_old_slot to initialise the
path structure. The old root is always a cloned buffer (either via alloc
dummy or via btrfs_clone_extent_buffer) and its reference count is 2: 1
from allocation, 1 from extent_buffer_get call in get_old_root.

This latter explicit ref count acquire operation is in fact unnecessary
since the semantic is such that the newly allocated buffer is handed
over to the btrfs_path for lifetime management. Considering this just
remove the extra extent_buffer_get in get_old_root.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ctree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 8eac5f75bca36..8765312743f16 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1441,7 +1441,6 @@ get_old_root(struct btrfs_root *root, u64 time_seq)
 
 	if (!eb)
 		return NULL;
-	extent_buffer_get(eb);
 	btrfs_tree_read_lock(eb);
 	if (old_root) {
 		btrfs_set_header_bytenr(eb, eb->start);
-- 
2.25.1



