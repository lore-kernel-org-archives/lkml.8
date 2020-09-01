Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A93C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 007C22078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598978462;
	bh=DkAnR+iaMjM5GOBkP+c9xavILewYbraf9p+EsXs1328=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z5a/ideCOjz+DJC9OBos5ef3XX88RdmC8OUdZUE7iNQsaAAiW4DsyJvQWYDvbcnlj
	 xKPbkI8c02SHCvr9P0HiBPLmqcqgYRIWf+Cb0Wuyuwy09sVJdk+QzH7ip9wwxRixnG
	 eDVk7wb7TOpjhbBx9f1BblD0ZqE3nnteSWOL7aTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbgIAQk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730395AbgIAP2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:28:45 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3DE1206C0;
        Tue,  1 Sep 2020 15:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974122;
        bh=DkAnR+iaMjM5GOBkP+c9xavILewYbraf9p+EsXs1328=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OPqtDOOVue/XLTg9lX5yte6fsyhkMHqHUiwEEFcYEl1OF8LbfiNg78euoGMuKYYWz
         QVysBL52zl4Z3LmAXOYnKWh1f0AWNeMphRR1y3arAVUNXy8Dq1WdZMu6/FQNWD7dTo
         peVkEE8+oI5sr7wpY5xmAlZCsv81LVhbgIVNw2RU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 052/214] btrfs: file: reserve qgroup space after the hole punch range is locked
Date:   Tue,  1 Sep 2020 17:08:52 +0200
Message-Id: <20200901150955.473793414@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit a7f8b1c2ac21bf081b41264c9cfd6260dffa6246 ]

The incoming qgroup reserved space timing will move the data reservation
to ordered extent completely.

However in btrfs_punch_hole_lock_range() will call
btrfs_invalidate_page(), which will clear QGROUP_RESERVED bit for the
range.

In current stage it's OK, but if we're making ordered extents handle the
reserved space, then btrfs_punch_hole_lock_range() can clear the
QGROUP_RESERVED bit before we submit ordered extent, leading to qgroup
reserved space leakage.

So here change the timing to make reserve data space after
btrfs_punch_hole_lock_range().
The new timing is fine for either current code or the new code.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 3cfbccacef7fd..a02c44b6a2be5 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3130,14 +3130,14 @@ reserve_space:
 		if (ret < 0)
 			goto out;
 		space_reserved = true;
-		ret = btrfs_qgroup_reserve_data(inode, &data_reserved,
-						alloc_start, bytes_to_reserve);
-		if (ret)
-			goto out;
 		ret = btrfs_punch_hole_lock_range(inode, lockstart, lockend,
 						  &cached_state);
 		if (ret)
 			goto out;
+		ret = btrfs_qgroup_reserve_data(inode, &data_reserved,
+						alloc_start, bytes_to_reserve);
+		if (ret)
+			goto out;
 		ret = btrfs_prealloc_file_range(inode, mode, alloc_start,
 						alloc_end - alloc_start,
 						i_blocksize(inode),
-- 
2.25.1



