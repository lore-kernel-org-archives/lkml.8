Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F94EC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 387732087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599593229;
	bh=F6E0uU3Gz+72YBSzrH0izRjdV0y0ftaElR3dUaV65Ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=opJ4jfi9sF/RqT7fle6qWJdcwA3ElLwO2hDBX5OmO+I164MOGKDPE1okYp3ZWVnBa
	 aQsBVUX2SVvWmpFXtTdo+vv1RCcw51PRbPrwWRI/UPvCEbRiwifs/SkWCda8M8kxSj
	 NF62uL0GPODNQjHc1KvHSfWcS7fVXixfH8GdUQTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732162AbgIHT1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:27:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731056AbgIHQAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:00:04 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58E722464B;
        Tue,  8 Sep 2020 15:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579560;
        bh=F6E0uU3Gz+72YBSzrH0izRjdV0y0ftaElR3dUaV65Ho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F+7tHRIrn5U3qgeNsBuYkJcnm8msy2uIcJyo/udwWXkVBUECqw1fjzDvBBS+mIroa
         ElOSNwWh/4wA7hefAKZ5kNLLu/prGFjQNmTLvAtegqvI5hn4R20Q+MuH1kczTQIVC0
         HYW44BwxvbHr4UwYrAryyYtJkAthFSjPxuu0zQRc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.8 128/186] btrfs: set the correct lockdep class for new nodes
Date:   Tue,  8 Sep 2020 17:24:30 +0200
Message-Id: <20200908152247.842898789@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
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
@@ -4527,7 +4527,7 @@ btrfs_init_new_buffer(struct btrfs_trans
 		return ERR_PTR(-EUCLEAN);
 	}
 
-	btrfs_set_buffer_lockdep_class(root->root_key.objectid, buf, level);
+	btrfs_set_buffer_lockdep_class(owner, buf, level);
 	btrfs_tree_lock(buf);
 	btrfs_clean_tree_block(buf);
 	clear_bit(EXTENT_BUFFER_STALE, &buf->bflags);


