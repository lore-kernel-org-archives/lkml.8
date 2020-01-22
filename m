Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB11C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0692468C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686468;
	bh=maQjfsgIA8NAW0yeqbgi7Z5dRYal60dykrMctvY3S00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x/fJCGCsDxYSZD4T3r71DfjMZ6epPPkSDYKPinkKo33evryXE3K45tpZawlQNEG4D
	 IlWidaXtplShfXF3FkSSfLiR9Bb4za8uXVVzF0b/bK6+Tkn9d/SyxgBei+VKbxswV1
	 VMqHtUDQxHeNBd90oi+VKS3jBhoU6dzZjqOOwxws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387639AbgAVJlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:41:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:33172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733257AbgAVJlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:41:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3604B2467B;
        Wed, 22 Jan 2020 09:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686104;
        bh=maQjfsgIA8NAW0yeqbgi7Z5dRYal60dykrMctvY3S00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yL14orwyW3Z6qhJVFt16cv90FNhSv7lsx1PSTtbXCJ3+jXhdMVEk3hbWGKvoyYuNg
         gZRXItZbpj4yo1kKwktgYsHXuJ28/7gLR8kP3kHftfdbjdp5noFMYWy/6AmrPSv51n
         EaWYfQoeV3nesM35nVkxIf0OAynlJWp8B+9w8jj8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 045/103] btrfs: fix memory leak in qgroup accounting
Date:   Wed, 22 Jan 2020 10:29:01 +0100
Message-Id: <20200122092810.614009389@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092803.587683021@linuxfoundation.org>
References: <20200122092803.587683021@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

commit 26ef8493e1ab771cb01d27defca2fa1315dc3980 upstream.

When running xfstests on the current btrfs I get the following splat from
kmemleak:

unreferenced object 0xffff88821b2404e0 (size 32):
  comm "kworker/u4:7", pid 26663, jiffies 4295283698 (age 8.776s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 10 ff fd 26 82 88 ff ff  ...........&....
    10 ff fd 26 82 88 ff ff 20 ff fd 26 82 88 ff ff  ...&.... ..&....
  backtrace:
    [<00000000f94fd43f>] ulist_alloc+0x25/0x60 [btrfs]
    [<00000000fd023d99>] btrfs_find_all_roots_safe+0x41/0x100 [btrfs]
    [<000000008f17bd32>] btrfs_find_all_roots+0x52/0x70 [btrfs]
    [<00000000b7660afb>] btrfs_qgroup_rescan_worker+0x343/0x680 [btrfs]
    [<0000000058e66778>] btrfs_work_helper+0xac/0x1e0 [btrfs]
    [<00000000f0188930>] process_one_work+0x1cf/0x350
    [<00000000af5f2f8e>] worker_thread+0x28/0x3c0
    [<00000000b55a1add>] kthread+0x109/0x120
    [<00000000f88cbd17>] ret_from_fork+0x35/0x40

This corresponds to:

  (gdb) l *(btrfs_find_all_roots_safe+0x41)
  0x8d7e1 is in btrfs_find_all_roots_safe (fs/btrfs/backref.c:1413).
  1408
  1409            tmp = ulist_alloc(GFP_NOFS);
  1410            if (!tmp)
  1411                    return -ENOMEM;
  1412            *roots = ulist_alloc(GFP_NOFS);
  1413            if (!*roots) {
  1414                    ulist_free(tmp);
  1415                    return -ENOMEM;
  1416            }
  1417

Following the lifetime of the allocated 'roots' ulist, it gets freed
again in btrfs_qgroup_account_extent().

But this does not happen if the function is called with the
'BTRFS_FS_QUOTA_ENABLED' flag cleared, then btrfs_qgroup_account_extent()
does a short leave and directly returns.

Instead of directly returning we should jump to the 'out_free' in order to
free all resources as expected.

CC: stable@vger.kernel.org # 4.14+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
[ add comment ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/qgroup.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2055,8 +2055,12 @@ int btrfs_qgroup_account_extent(struct b
 	u64 nr_old_roots = 0;
 	int ret = 0;
 
+	/*
+	 * If quotas get disabled meanwhile, the resouces need to be freed and
+	 * we can't just exit here.
+	 */
 	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
-		return 0;
+		goto out_free;
 
 	if (new_roots) {
 		if (!maybe_fs_roots(new_roots))


