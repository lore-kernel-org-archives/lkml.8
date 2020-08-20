Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D313EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC05722CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597915488;
	bh=79vjTGqCALhCjjQuXM0iFlKNzKmobrwLY9mfAF9im6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ES55Bt3tGL9+XnNWcAqRyRWOya5nKKLGpcRQ4SvRtPh+/XJx0wJ8rha5P996lxn/2
	 ZBp+CHfPIQgnoz8Ns60WzTAx5x6CcWh1WV0eP+/qvQprPL9WNjg7/VFJj2X9Mb4Yeb
	 cvwERCthGFFNABnGa62vVva87AEllO5DwtFRbwpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgHTJYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:24:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbgHTJYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:24:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF6D822CB2;
        Thu, 20 Aug 2020 09:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915453;
        bh=79vjTGqCALhCjjQuXM0iFlKNzKmobrwLY9mfAF9im6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZnR4dO3yLd2snCkBRdrCgOhj3puXP0xu1iVZkZBNAanVg9xZVsJZcOwtqSkPOHHLi
         AMB1NOxrh6RgkLCAUZI/T0CBB2mIJnr5ro00JwcMpwSclUlH8v7iGZGvmNRDKn+VOX
         Y6pu+hT8Cau8ynVtY3M6DqWErq9ZeT/P6cWG+7qM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.8 019/232] btrfs: stop incremening log_batch for the log root tree when syncing log
Date:   Thu, 20 Aug 2020 11:17:50 +0200
Message-Id: <20200820091613.667356588@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

commit 28a9579561bcb9082715e720eac93012e708ab94 upstream.

We are incrementing the log_batch atomic counter of the root log tree but
we never use that counter, it's used only for the log trees of subvolume
roots. We started doing it when we moved the log_batch and log_write
counters from the global, per fs, btrfs_fs_info structure, into the
btrfs_root structure in commit 7237f1833601dc ("Btrfs: fix tree logs
parallel sync").

So just stop doing it for the log root tree and add a comment over the
field declaration so inform it's used only for log trees of subvolume
roots.

This patch is part of a series that has the following patches:

1/4 btrfs: only commit the delayed inode when doing a full fsync
2/4 btrfs: only commit delayed items at fsync if we are logging a directory
3/4 btrfs: stop incremening log_batch for the log root tree when syncing log
4/4 btrfs: remove no longer needed use of log_writers for the log root tree

After the entire patchset applied I saw about 12% decrease on max latency
reported by dbench. The test was done on a qemu vm, with 8 cores, 16Gb of
ram, using kvm and using a raw NVMe device directly (no intermediary fs on
the host). The test was invoked like the following:

  mkfs.btrfs -f /dev/sdk
  mount -o ssd -o nospace_cache /dev/sdk /mnt/sdk
  dbench -D /mnt/sdk -t 300 8
  umount /mnt/dsk

CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/ctree.h    |    1 +
 fs/btrfs/tree-log.c |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1061,6 +1061,7 @@ struct btrfs_root {
 	struct list_head log_ctxs[2];
 	atomic_t log_writers;
 	atomic_t log_commit[2];
+	/* Used only for log trees of subvolumes, not for the log root tree */
 	atomic_t log_batch;
 	int log_transid;
 	/* No matter the commit succeeds or not*/
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3116,7 +3116,6 @@ int btrfs_sync_log(struct btrfs_trans_ha
 	btrfs_init_log_ctx(&root_log_ctx, NULL);
 
 	mutex_lock(&log_root_tree->log_mutex);
-	atomic_inc(&log_root_tree->log_batch);
 	atomic_inc(&log_root_tree->log_writers);
 
 	index2 = log_root_tree->log_transid % 2;


