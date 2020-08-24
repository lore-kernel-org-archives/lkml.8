Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF72C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0656B2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598260907;
	bh=yzddTpnn2h210LpLCaM7zxT/uiMjrpvCKxK9gRPQYAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kUuIbxjAaMalFiV9uVK6YJ4GTYcEbqK4NT9sTago+g85QApKPjWDbh5/D4m0r1w0e
	 srMea/x79Hn1Wvm5ofJQMNm2G965mynlHU/RIVYsFmWbzPOt/vQDJziNO4GYkfUK+K
	 hRdpczwEA2+TmzmzrrnU0FcRwHdB9EvxsZN3kzO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgHXJVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:21:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730196AbgHXIzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:55:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA6D72074D;
        Mon, 24 Aug 2020 08:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259345;
        bh=yzddTpnn2h210LpLCaM7zxT/uiMjrpvCKxK9gRPQYAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uHysMcqa+VIXYWCdOYvNY+za9/rKpFZFx0yGnv1/+6LbROIGsleVvFCkLGzU2+lZo
         lDLvJJXdJaaGWDSyRp8bZPOkvv06M6oePgz8A3zWDVMSMQKXgRPXNtEWcEeieuA+qc
         o07Aq//5tf5hCwAmc38Am2h+zIwIJEGXhhBp/YNs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luciano Chavez <chavez@us.ibm.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 08/71] btrfs: inode: fix NULL pointer dereference if inode doesnt need compression
Date:   Mon, 24 Aug 2020 10:30:59 +0200
Message-Id: <20200824082356.292830154@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082355.848475917@linuxfoundation.org>
References: <20200824082355.848475917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 1e6e238c3002ea3611465ce5f32777ddd6a40126 ]

[BUG]
There is a bug report of NULL pointer dereference caused in
compress_file_extent():

  Oops: Kernel access of bad area, sig: 11 [#1]
  LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
  Workqueue: btrfs-delalloc btrfs_delalloc_helper [btrfs]
  NIP [c008000006dd4d34] compress_file_range.constprop.41+0x75c/0x8a0 [btrfs]
  LR [c008000006dd4d1c] compress_file_range.constprop.41+0x744/0x8a0 [btrfs]
  Call Trace:
  [c000000c69093b00] [c008000006dd4d1c] compress_file_range.constprop.41+0x744/0x8a0 [btrfs] (unreliable)
  [c000000c69093bd0] [c008000006dd4ebc] async_cow_start+0x44/0xa0 [btrfs]
  [c000000c69093c10] [c008000006e14824] normal_work_helper+0xdc/0x598 [btrfs]
  [c000000c69093c80] [c0000000001608c0] process_one_work+0x2c0/0x5b0
  [c000000c69093d10] [c000000000160c38] worker_thread+0x88/0x660
  [c000000c69093db0] [c00000000016b55c] kthread+0x1ac/0x1c0
  [c000000c69093e20] [c00000000000b660] ret_from_kernel_thread+0x5c/0x7c
  ---[ end trace f16954aa20d822f6 ]---

[CAUSE]
For the following execution route of compress_file_range(), it's
possible to hit NULL pointer dereference:

 compress_file_extent()
 |- pages = NULL;
 |- start = async_chunk->start = 0;
 |- end = async_chunk = 4095;
 |- nr_pages = 1;
 |- inode_need_compress() == false; <<< Possible, see later explanation
 |  Now, we have nr_pages = 1, pages = NULL
 |- cont:
 |- 		ret = cow_file_range_inline();
 |- 		if (ret <= 0) {
 |-		for (i = 0; i < nr_pages; i++) {
 |-			WARN_ON(pages[i]->mapping);	<<< Crash

To enter above call execution branch, we need the following race:

    Thread 1 (chattr)     |            Thread 2 (writeback)
--------------------------+------------------------------
                          | btrfs_run_delalloc_range
                          | |- inode_need_compress = true
                          | |- cow_file_range_async()
btrfs_ioctl_set_flag()    |
|- binode_flags |=        |
   BTRFS_INODE_NOCOMPRESS |
                          | compress_file_range()
                          | |- inode_need_compress = false
                          | |- nr_page = 1 while pages = NULL
                          | |  Then hit the crash

[FIX]
This patch will fix it by checking @pages before doing accessing it.
This patch is only designed as a hot fix and easy to backport.

More elegant fix may make btrfs only check inode_need_compress() once to
avoid such race, but that would be another story.

Reported-by: Luciano Chavez <chavez@us.ibm.com>
Fixes: 4d3a800ebb12 ("btrfs: merge nr_pages input and output parameter in compress_pages")
CC: stable@vger.kernel.org # 4.14.x: cecc8d9038d16: btrfs: Move free_pages_out label in inline extent handling branch in compress_file_range
CC: stable@vger.kernel.org # 4.14+
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8507192cd6449..bdfe159a60da6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -629,11 +629,18 @@ cont:
 						     page_error_op |
 						     PAGE_END_WRITEBACK);
 
-			for (i = 0; i < nr_pages; i++) {
-				WARN_ON(pages[i]->mapping);
-				put_page(pages[i]);
+			/*
+			 * Ensure we only free the compressed pages if we have
+			 * them allocated, as we can still reach here with
+			 * inode_need_compress() == false.
+			 */
+			if (pages) {
+				for (i = 0; i < nr_pages; i++) {
+					WARN_ON(pages[i]->mapping);
+					put_page(pages[i]);
+				}
+				kfree(pages);
 			}
-			kfree(pages);
 
 			return;
 		}
-- 
2.25.1



