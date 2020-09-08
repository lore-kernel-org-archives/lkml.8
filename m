Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CDBC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7E972087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599592161;
	bh=YmEHi+GZhYZlb4S1hR8Hui+LW2rAkyoIkqRRDUul3FE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jsYs9P3SBJcEv4O9jwQ3oBYq8LviqVnnk6PVwAmCPweASnxAJ+o+cz7n4vCH3dTW/
	 Wq7zIPk4JaO9NzELNDRDaT4Al+NGYcbInkTtZ01gVHxcPquIK9Myn6cKR+/0N8FiWn
	 tDHTfGk58yWUhLplDMWYwPbpPR98xx6Eza/N6Ti8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgIHTJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:09:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731241AbgIHQGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:06:06 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD16623D97;
        Tue,  8 Sep 2020 15:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579983;
        bh=YmEHi+GZhYZlb4S1hR8Hui+LW2rAkyoIkqRRDUul3FE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SXv8Hk1yiBwfemwo2zt0pRel/MBCdZMBJhOYNsqwGt1+di/KULOT32PSUNF1G2OIj
         L/HyXnAdpPKzhhGQ8CsHgmZX7wuEnbrzbL4iffwz348KY+4/qnfplMgycs30VCQym6
         uUu7XRwXLsaGphsc6kgwBgZ+1Pjq+OwWP6srsyb8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.4 083/129] btrfs: set the correct lockdep class for new nodes
Date:   Tue,  8 Sep 2020 17:25:24 +0200
Message-Id: <20200908152233.845059178@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
References: <20200908152229.689878733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

commit ad24466588ab7d7c879053c5afd919b0c555fec0 upstream.

When flipping over to the rw_semaphore I noticed I'd get a lockdep splat
in replace_path(), which is weird because we're swapping the reloc root
with the actual target root.  Turns out this is because we're using the
root->root_key.objectid as the root id for the newly allocated tree
block when setting the lockdep class, however we need to be using the
actual owner of this new block, which is saved in owner.

The affected path is through btrfs_copy_root as all other callers of
btrfs_alloc_tree_block (which calls init_new_buffer) have root_objectid
== root->root_key.objectid .

CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/extent-tree.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4446,7 +4446,7 @@ btrfs_init_new_buffer(struct btrfs_trans
 		return ERR_PTR(-EUCLEAN);
 	}
 
-	btrfs_set_buffer_lockdep_class(root->root_key.objectid, buf, level);
+	btrfs_set_buffer_lockdep_class(owner, buf, level);
 	btrfs_tree_lock(buf);
 	btrfs_clean_tree_block(buf);
 	clear_bit(EXTENT_BUFFER_STALE, &buf->bflags);


