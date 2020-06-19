Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6BAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8870721707
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584074;
	bh=C00lb73rbG9xsFzU6HfWKhv3Y6ec1kY1TeDnLPYBR4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q/Voq8AnoXExHmECE3lvDbwH2tt/3cusOsGdyrB82d878Udz8BzGPALu/GmzSnxMU
	 +nlsBfyCfREfxvsbYBCXg7cU71NleHnggttGkQi3zTshWHZSzCpz80J1WRppMxgeAI
	 zrTRp17nf+oF2aT4BfpFu5g5e5akhT3NvmQV0CIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394911AbgFSQ1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:27:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389463AbgFSOzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:55:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ACC721835;
        Fri, 19 Jun 2020 14:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578531;
        bh=C00lb73rbG9xsFzU6HfWKhv3Y6ec1kY1TeDnLPYBR4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EDucm9fkLB/+T7m8FCW+qQPvHAAYVKfHZoH/N04xIMfRGWbDJ5g7LTBFSmC6GsyzC
         Tp/vn1W6ZYfB11OabJLm0bmMJZV37mssRdGhksn1TI2O3l+GRkRd/Mf2xJKFEbUa8o
         TcXLwdoz/CncJocQtCT5DSlR9M9LjX26+rWpMLrA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        Su Yue <suy.fnst@cn.fujitsu.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 027/267] btrfs: tree-checker: Check level for leaves and nodes
Date:   Fri, 19 Jun 2020 16:30:12 +0200
Message-Id: <20200619141650.167676951@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit f556faa46eb4e96d0d0772e74ecf66781e132f72 ]

Although we have tree level check at tree read runtime, it's completely
based on its parent level.
We still need to do accurate level check to avoid invalid tree blocks
sneak into kernel space.

The check itself is simple, for leaf its level should always be 0.
For nodes its level should be in range [1, BTRFS_MAX_LEVEL - 1].

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Su Yue <suy.fnst@cn.fujitsu.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/tree-checker.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 235c2970b944..d98ec885b72a 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -485,6 +485,13 @@ static int check_leaf(struct btrfs_fs_info *fs_info, struct extent_buffer *leaf,
 	u32 nritems = btrfs_header_nritems(leaf);
 	int slot;
 
+	if (btrfs_header_level(leaf) != 0) {
+		generic_err(fs_info, leaf, 0,
+			"invalid level for leaf, have %d expect 0",
+			btrfs_header_level(leaf));
+		return -EUCLEAN;
+	}
+
 	/*
 	 * Extent buffers from a relocation tree have a owner field that
 	 * corresponds to the subvolume tree they are based on. So just from an
@@ -649,9 +656,16 @@ int btrfs_check_node(struct btrfs_fs_info *fs_info, struct extent_buffer *node)
 	unsigned long nr = btrfs_header_nritems(node);
 	struct btrfs_key key, next_key;
 	int slot;
+	int level = btrfs_header_level(node);
 	u64 bytenr;
 	int ret = 0;
 
+	if (level <= 0 || level >= BTRFS_MAX_LEVEL) {
+		generic_err(fs_info, node, 0,
+			"invalid level for node, have %d expect [1, %d]",
+			level, BTRFS_MAX_LEVEL - 1);
+		return -EUCLEAN;
+	}
 	if (nr == 0 || nr > BTRFS_NODEPTRS_PER_BLOCK(fs_info)) {
 		btrfs_crit(fs_info,
 "corrupt node: root=%llu block=%llu, nritems too %s, have %lu expect range [1,%u]",
-- 
2.25.1



