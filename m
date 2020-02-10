Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10D7C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73EB20842
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340684;
	bh=Wr7nmr6SVOu771PfcvgyxO26NvzBCiIOiBCs3Lt01tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n1e7W8O3SpDcIu6myqZ9NSfqhdXWbIMBnwroGf2Qsv0mK7ag3rLJaC2gPZ5xEiE3X
	 tryLnlIJSyjKSiv08O+XA7l/IL2soMY6EKsYsN7P1rFYrsaBcR6yQN9eiDFTUsHszE
	 I1MvnVkhYpz0Osar7tAuJkcPWGGLTeenkraiAlb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgBJMh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:37:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:56274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbgBJMgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:36:36 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 514932051A;
        Mon, 10 Feb 2020 12:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338194;
        bh=Wr7nmr6SVOu771PfcvgyxO26NvzBCiIOiBCs3Lt01tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z+VBtB5cx6hXpxIwYZmb9bRyjf4YFrJwAseiEvuvhLWuwoVwcWBakBEKl+ISY7++Y
         a8CVh8Q8jnZsi0Jz3XSeEqm2YAlxtpFGh1rNtYvBS9rynjhMus7T9Fqfv8GCdpsPlp
         2VuSyYFzkpcfu8AguXtWMikA+ELmT1vBfXFqfkD8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 178/195] btrfs: free block groups after freeing fs trees
Date:   Mon, 10 Feb 2020 04:33:56 -0800
Message-Id: <20200210122322.539836731@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 4e19443da1941050b346f8fc4c368aa68413bc88 ]

Sometimes when running generic/475 we would trip the
WARN_ON(cache->reserved) check when free'ing the block groups on umount.
This is because sometimes we don't commit the transaction because of IO
errors and thus do not cleanup the tree logs until at umount time.

These blocks are still reserved until they are cleaned up, but they
aren't cleaned up until _after_ we do the free block groups work.  Fix
this by moving the free after free'ing the fs roots, that way all of the
tree logs are cleaned up and we have a properly cleaned fs.  A bunch of
loops of generic/475 confirmed this fixes the problem.

CC: stable@vger.kernel.org # 4.9+
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/disk-io.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d296ea329bd4e..9e467e8a8cb5d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3983,11 +3983,18 @@ void close_ctree(struct btrfs_fs_info *fs_info)
 	invalidate_inode_pages2(fs_info->btree_inode->i_mapping);
 	btrfs_stop_all_workers(fs_info);
 
-	btrfs_free_block_groups(fs_info);
-
 	clear_bit(BTRFS_FS_OPEN, &fs_info->flags);
 	free_root_pointers(fs_info, true);
 
+	/*
+	 * We must free the block groups after dropping the fs_roots as we could
+	 * have had an IO error and have left over tree log blocks that aren't
+	 * cleaned up until the fs roots are freed.  This makes the block group
+	 * accounting appear to be wrong because there's pending reserved bytes,
+	 * so make sure we do the block group cleanup afterwards.
+	 */
+	btrfs_free_block_groups(fs_info);
+
 	iput(fs_info->btree_inode);
 
 #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
-- 
2.20.1



