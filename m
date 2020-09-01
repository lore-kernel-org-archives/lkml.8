Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B60CC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0425A208CA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598980638;
	bh=YprBujwCNjdQBe6mfhfGwFK2UYFCsqQ4kKCODmIigBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g8iWAcUTmxuEwmB/37nNcycnGLt+5VA9tm2094PhIWZUQ2sEaKgpB+JrwAtyKSwHL
	 XyVlHd9rIn+lRLzgoJVl4W7LCRnAK93KJ98iDBiOOd9AuuWzhIUr5ix55giNlQyd8y
	 5hAiwCizm7Ij+2E7B48gmKGaFb5JWiTnszlnlmdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732608AbgIARRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:17:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729019AbgIAPOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:14:12 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 893DF20FC3;
        Tue,  1 Sep 2020 15:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973252;
        bh=YprBujwCNjdQBe6mfhfGwFK2UYFCsqQ4kKCODmIigBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qvv7RXVfm8ZFvWl/T3vGpz8fHgl89yZ37rNpofuekcYCXJtDYOB/iZDiHv3nlYm8n
         hwVVbSq3XEJ7VZB8w6xW9EIWULWtRw9LUp07PSPFTRLnamJSXsH4zhaulHJTdqwzFR
         +5Hak4FYYikqlUAmYXMC72QuibFO/DNwct59h8sU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 60/62] btrfs: check the right error variable in btrfs_del_dir_entries_in_log
Date:   Tue,  1 Sep 2020 17:10:43 +0200
Message-Id: <20200901150923.751316659@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150920.697676718@linuxfoundation.org>
References: <20200901150920.697676718@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit fb2fecbad50964b9f27a3b182e74e437b40753ef ]

With my new locking code dbench is so much faster that I tripped over a
transaction abort from ENOSPC.  This turned out to be because
btrfs_del_dir_entries_in_log was checking for ret == -ENOSPC, but this
function sets err on error, and returns err.  So instead of properly
marking the inode as needing a full commit, we were returning -ENOSPC
and aborting in __btrfs_unlink_inode.  Fix this by checking the proper
variable so that we return the correct thing in the case of ENOSPC.

The ENOENT needs to be checked, because btrfs_lookup_dir_item_index()
can return -ENOENT if the dir item isn't in the tree log (which would
happen if we hadn't fsync'ed this guy).  We actually handle that case in
__btrfs_unlink_inode, so it's an expected error to get back.

Fixes: 4a500fd178c8 ("Btrfs: Metadata ENOSPC handling for tree log")
CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ add note and comment about ENOENT ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/tree-log.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 820d3b5bc4150..8f0f91de436d5 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3169,11 +3169,13 @@ int btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 	btrfs_free_path(path);
 out_unlock:
 	mutex_unlock(&BTRFS_I(dir)->log_mutex);
-	if (ret == -ENOSPC) {
+	if (err == -ENOSPC) {
 		btrfs_set_log_full_commit(root->fs_info, trans);
-		ret = 0;
-	} else if (ret < 0)
-		btrfs_abort_transaction(trans, root, ret);
+		err = 0;
+	} else if (err < 0 && err != -ENOENT) {
+		/* ENOENT can be returned if the entry hasn't been fsynced yet */
+		btrfs_abort_transaction(trans, root, err);
+	}
 
 	btrfs_end_log_trans(root);
 
-- 
2.25.1



