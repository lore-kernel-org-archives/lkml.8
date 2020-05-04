Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6AEC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2AE2073B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615523;
	bh=36t+28ha0pvansKr+5GrYto8lZ8+lmXOLyll20WdTgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sBhX2gboafvv2f2L0pmUxjQH7pJ9lwKOzNusaV6+s9RJzphHn160/JJTf7gLOMtLk
	 lOMtm6yQFS9+355f8rou4BtxOBeEW6O8AZJ00I+B/9USpbygtDntuOkcCWb2sA+lR4
	 K9Af5gw6oC5VgCLIZzaCW7DqMBOqfEo74HfsUync=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbgEDSFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:05:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731791AbgEDSFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:05:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 148D22073E;
        Mon,  4 May 2020 18:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615516;
        bh=36t+28ha0pvansKr+5GrYto8lZ8+lmXOLyll20WdTgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K7znjZWlx0c4d9hMqVyy3fxni/UNkIGTvIAc/N5G0j2S25wavBViYudCJMKO09E12
         TG/5AED2yVMsqq4s7d56B52uWIIeC9J5vGdviw+Y4SQULSYD5CIRpbwoI7jUhoS4XM
         ulDGNLnWnZGf+vB9FxRz7tC9VkahbwqzjFGZMtus=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 5.6 13/73] btrfs: fix block group leak when removing fails
Date:   Mon,  4 May 2020 19:57:16 +0200
Message-Id: <20200504165504.395419662@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165501.781878940@linuxfoundation.org>
References: <20200504165501.781878940@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

commit f6033c5e333238f299c3ae03fac8cc1365b23b77 upstream.

btrfs_remove_block_group() invokes btrfs_lookup_block_group(), which
returns a local reference of the block group that contains the given
bytenr to "block_group" with increased refcount.

When btrfs_remove_block_group() returns, "block_group" becomes invalid,
so the refcount should be decreased to keep refcount balanced.

The reference counting issue happens in several exception handling paths
of btrfs_remove_block_group(). When those error scenarios occur such as
btrfs_alloc_path() returns NULL, the function forgets to decrease its
refcnt increased by btrfs_lookup_block_group() and will cause a refcnt
leak.

Fix this issue by jumping to "out_put_group" label and calling
btrfs_put_block_group() when those error scenarios occur.

CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/block-group.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -916,7 +916,7 @@ int btrfs_remove_block_group(struct btrf
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
-		goto out;
+		goto out_put_group;
 	}
 
 	/*
@@ -954,7 +954,7 @@ int btrfs_remove_block_group(struct btrf
 		ret = btrfs_orphan_add(trans, BTRFS_I(inode));
 		if (ret) {
 			btrfs_add_delayed_iput(inode);
-			goto out;
+			goto out_put_group;
 		}
 		clear_nlink(inode);
 		/* One for the block groups ref */
@@ -977,13 +977,13 @@ int btrfs_remove_block_group(struct btrf
 
 	ret = btrfs_search_slot(trans, tree_root, &key, path, -1, 1);
 	if (ret < 0)
-		goto out;
+		goto out_put_group;
 	if (ret > 0)
 		btrfs_release_path(path);
 	if (ret == 0) {
 		ret = btrfs_del_item(trans, tree_root, path);
 		if (ret)
-			goto out;
+			goto out_put_group;
 		btrfs_release_path(path);
 	}
 
@@ -1102,9 +1102,9 @@ int btrfs_remove_block_group(struct btrf
 
 	ret = remove_block_group_free_space(trans, block_group);
 	if (ret)
-		goto out;
+		goto out_put_group;
 
-	btrfs_put_block_group(block_group);
+	/* Once for the block groups rbtree */
 	btrfs_put_block_group(block_group);
 
 	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
@@ -1127,6 +1127,10 @@ int btrfs_remove_block_group(struct btrf
 		/* once for the tree */
 		free_extent_map(em);
 	}
+
+out_put_group:
+	/* Once for the lookup reference */
+	btrfs_put_block_group(block_group);
 out:
 	if (remove_rsv)
 		btrfs_delayed_refs_rsv_release(fs_info, 1);


