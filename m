Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CE0C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC81E20771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587049299;
	bh=voR2c5oles2bsqgJ3Oq75JQIQaJoorClTevFqXOzlbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dA9GAgSHTJ2qBKjngvVdg9D1ahTodWLCp/IDHj5Of+jFfYUzA/WmSNcpq6VYtk/VK
	 tb9A+VaojzT5dgfPpNPPnPHG0WzhP3Hgzgm4hBRC7JpAllMJYni/3PnIiO4Jt/M/iq
	 tK23fK06YOkzeTr63LKvIYttAGVssec9RjAAM6tA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409323AbgDPPBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgDPNyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:54:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54CAF20786;
        Thu, 16 Apr 2020 13:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045263;
        bh=voR2c5oles2bsqgJ3Oq75JQIQaJoorClTevFqXOzlbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dhE2hQgJW6hpt8Gd4pBmx4CyrncwaEd+Bx3IkfYcgceJFntYgOupmKbL0GmOpB3Qb
         IkD0nOY5zYBNqBR8hH+11qbdChRh7aT7QL5JPiLjokN04f/tOzol2SFLMGQ+G1KIXj
         AYN0rsDYWHm/RX+PZyo3pdygT7Nuz91vPY7KByCs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 064/254] btrfs: restart relocate_tree_blocks properly
Date:   Thu, 16 Apr 2020 15:22:33 +0200
Message-Id: <20200416131333.917036185@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 50dbbb71c79df89532ec41d118d59386e5a877e3 ]

There are two bugs here, but fixing them independently would just result
in pain if you happened to bisect between the two patches.

First is how we handle the -EAGAIN from relocate_tree_block().  We don't
set error, unless we happen to be the first node, which makes no sense,
I have no idea what the code was trying to accomplish here.

We in fact _do_ want err set here so that we know we need to restart in
relocate_block_group().  Also we need finish_pending_nodes() to not
actually call link_to_upper(), because we didn't actually relocate the
block.

And then if we do get -EAGAIN we do not want to set our backref cache
last_trans to the one before ours.  This would force us to update our
backref cache if we didn't cross transaction ids, which would mean we'd
have some nodes updated to their new_bytenr, but still able to find
their old bytenr because we're searching the same commit root as the
last time we went through relocate_tree_blocks.

Fixing these two things keeps us from panicing when we start breaking
out of relocate_tree_blocks() either for delayed ref flushing or enospc.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/relocation.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index db6abe3f10e57..d7e8839048d71 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3175,9 +3175,8 @@ int relocate_tree_blocks(struct btrfs_trans_handle *trans,
 		ret = relocate_tree_block(trans, rc, node, &block->key,
 					  path);
 		if (ret < 0) {
-			if (ret != -EAGAIN || &block->rb_node == rb_first(blocks))
-				err = ret;
-			goto out;
+			err = ret;
+			break;
 		}
 	}
 out:
@@ -4151,12 +4150,6 @@ restart:
 		if (!RB_EMPTY_ROOT(&blocks)) {
 			ret = relocate_tree_blocks(trans, rc, &blocks);
 			if (ret < 0) {
-				/*
-				 * if we fail to relocate tree blocks, force to update
-				 * backref cache when committing transaction.
-				 */
-				rc->backref_cache.last_trans = trans->transid - 1;
-
 				if (ret != -EAGAIN) {
 					err = ret;
 					break;
-- 
2.20.1



