Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E9AC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F17520714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339679;
	bh=K1efC3JBk6ObqZnm+LOvXza1vx34qmzuI/GLeOdilYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n0l4moG7oVTCzmrwWkT2lFSu4t4k2tzG81JKpf+Tod/L0blUvq4jz9vj7oBeoxDqJ
	 V7gR9/9KHtXUopkLpbwcVS3l5iHUovtoHB8e4M2fYtnoTAH8SaN2o+j8iERcL39fSD
	 0uEcxln9E7rXbj9Q9AxSdsUXCD+DcTrpoZg4aZOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbgBJNBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:01:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:41782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729824AbgBJMkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:40:53 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C027E20873;
        Mon, 10 Feb 2020 12:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338452;
        bh=K1efC3JBk6ObqZnm+LOvXza1vx34qmzuI/GLeOdilYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M/M/JOAf2HEF2FW97be3JSR3M0EohFlT9fCryRlusgl027aGVc21TbTTUKym9nZTU
         I0M6YR6pWSC9/Et4gF1VQQ1Z5C+yJtp4MWxTT14XnJO2fylA2PtQl7tIi79YVXTlvD
         ArK9c6G4fSNvg2NfgM1o+pXEk4rOp3m4pp6F5k2U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.5 199/367] btrfs: drop log root for dropped roots
Date:   Mon, 10 Feb 2020 04:31:52 -0800
Message-Id: <20200210122442.934140062@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

commit 889bfa39086e86b52fcfaa04d72c95eaeb12f9a5 upstream.

If we fsync on a subvolume and create a log root for that volume, and
then later delete that subvolume we'll never clean up its log root.  Fix
this by making switch_commit_roots free the log for any dropped roots we
encounter.  The extra churn is because we need a btrfs_trans_handle, not
the btrfs_transaction.

CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/transaction.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -147,13 +147,14 @@ void btrfs_put_transaction(struct btrfs_
 	}
 }
 
-static noinline void switch_commit_roots(struct btrfs_transaction *trans)
+static noinline void switch_commit_roots(struct btrfs_trans_handle *trans)
 {
+	struct btrfs_transaction *cur_trans = trans->transaction;
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *root, *tmp;
 
 	down_write(&fs_info->commit_root_sem);
-	list_for_each_entry_safe(root, tmp, &trans->switch_commits,
+	list_for_each_entry_safe(root, tmp, &cur_trans->switch_commits,
 				 dirty_list) {
 		list_del_init(&root->dirty_list);
 		free_extent_buffer(root->commit_root);
@@ -165,16 +166,17 @@ static noinline void switch_commit_roots
 	}
 
 	/* We can free old roots now. */
-	spin_lock(&trans->dropped_roots_lock);
-	while (!list_empty(&trans->dropped_roots)) {
-		root = list_first_entry(&trans->dropped_roots,
+	spin_lock(&cur_trans->dropped_roots_lock);
+	while (!list_empty(&cur_trans->dropped_roots)) {
+		root = list_first_entry(&cur_trans->dropped_roots,
 					struct btrfs_root, root_list);
 		list_del_init(&root->root_list);
-		spin_unlock(&trans->dropped_roots_lock);
+		spin_unlock(&cur_trans->dropped_roots_lock);
+		btrfs_free_log(trans, root);
 		btrfs_drop_and_free_fs_root(fs_info, root);
-		spin_lock(&trans->dropped_roots_lock);
+		spin_lock(&cur_trans->dropped_roots_lock);
 	}
-	spin_unlock(&trans->dropped_roots_lock);
+	spin_unlock(&cur_trans->dropped_roots_lock);
 	up_write(&fs_info->commit_root_sem);
 }
 
@@ -1421,7 +1423,7 @@ static int qgroup_account_snapshot(struc
 	ret = commit_cowonly_roots(trans);
 	if (ret)
 		goto out;
-	switch_commit_roots(trans->transaction);
+	switch_commit_roots(trans);
 	ret = btrfs_write_and_wait_transaction(trans);
 	if (ret)
 		btrfs_handle_fs_error(fs_info, ret,
@@ -2309,7 +2311,7 @@ int btrfs_commit_transaction(struct btrf
 	list_add_tail(&fs_info->chunk_root->dirty_list,
 		      &cur_trans->switch_commits);
 
-	switch_commit_roots(cur_trans);
+	switch_commit_roots(trans);
 
 	ASSERT(list_empty(&cur_trans->dirty_bgs));
 	ASSERT(list_empty(&cur_trans->io_bgs));


