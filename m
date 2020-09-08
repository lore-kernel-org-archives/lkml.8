Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B64C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F29E32080C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599590045;
	bh=YQm2xnSsC7JdTQ9gVr+99YbUrnBi7Xrz9a7cQX14VMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1GhkppUZuGaOisgFK2V6/Zy6HeJqxrQz3vsmkpZM6pgPcJsNAfJrbh0g2d9cQUUHE
	 St1uUEfP1FCEPdyNDI+c6ykIlkFd0rHVtV8l6IFxH3yT5LR9bMHkb8+syqXrEKC2/2
	 LEsYmXv1KzIYYTLpwwtiD3Tx4geAi0WQRPmBAhnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbgIHSdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:33:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731366AbgIHQJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:09:28 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1078E2417B;
        Tue,  8 Sep 2020 15:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599580169;
        bh=YQm2xnSsC7JdTQ9gVr+99YbUrnBi7Xrz9a7cQX14VMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W7+FTIdPnIqiH20XZMbqXcJ07PnFQaBZAWdKH5gc3wWqPRjGmMtyngyXjuPDS5/0R
         N/4GA0IQq+ac3L3F9LfxbSar6XaK9vDStB3+Nc/E4h6j4d3CAelst0w9caZa4SJ3k5
         xtXFrPb97wJWh2znqJ9DtrfuZqx0SEuViUcdCBiM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 58/88] btrfs: Remove redundant extent_buffer_get in get_old_root
Date:   Tue,  8 Sep 2020 17:25:59 +0200
Message-Id: <20200908152224.031893625@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152221.082184905@linuxfoundation.org>
References: <20200908152221.082184905@linuxfoundation.org>
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
index c9943d70e2cb2..6c13d7d83f5ca 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1421,7 +1421,6 @@ get_old_root(struct btrfs_root *root, u64 time_seq)
 
 	if (!eb)
 		return NULL;
-	extent_buffer_get(eb);
 	btrfs_tree_read_lock(eb);
 	if (old_root) {
 		btrfs_set_header_bytenr(eb, eb->start);
-- 
2.25.1



