Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE99C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B66C207D0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593461285;
	bh=+CZ1Ya6xfPZttiJxEVIJEq0Qr4UQlcxzo5YMQg1Qbts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F9RYfq14+hfBcOHtgpFD+9+ovC/KszKSE5Nov+0wIjOjhgHhNz8o0hFicGu+bvx5k
	 20PNqNHu6cg7KOnkPv7QufT7SotPRL6QoXwFj21Al5d6z1HrcgzlNMDrxQzeok039+
	 hkgBb1DPWwGxvil7tH+stJArTfq6xQiR2fMQQzQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388929AbgF2UIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:08:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732935AbgF2TaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ACFB25242;
        Mon, 29 Jun 2020 15:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444958;
        bh=+CZ1Ya6xfPZttiJxEVIJEq0Qr4UQlcxzo5YMQg1Qbts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vg8LIWdLl+IGqyKYrcmDkFJ0rL9NvDAzm/9ceLA7So6N/9AfeZ5sf/0y/xgtm7c0p
         S31nGLAuOwPrrCbpo6elffhvfUfKWS1Lyk0f3SpaBfH3iE/wy+kMFqc0H5piBh8M5M
         xMLQSz8rmhj5YgtAkYv2pZb8kSIqrY6l6B3Io4PA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zheng Bin <zhengbin13@huawei.com>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.19 057/131] loop: replace kill_bdev with invalidate_bdev
Date:   Mon, 29 Jun 2020 11:33:48 -0400
Message-Id: <20200629153502.2494656-58-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629153502.2494656-1-sashal@kernel.org>
References: <20200629153502.2494656-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.131-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.131-rc1
X-KernelTest-Deadline: 2020-07-01T15:34+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng Bin <zhengbin13@huawei.com>

commit f4bd34b139a3fa2808c4205f12714c65e1548c6c upstream.

When a filesystem is mounted on a loop device and on a loop ioctl
LOOP_SET_STATUS64, because of kill_bdev, buffer_head mappings are getting
destroyed.
kill_bdev
  truncate_inode_pages
    truncate_inode_pages_range
      do_invalidatepage
        block_invalidatepage
          discard_buffer  -->clear BH_Mapped flag

sb_bread
  __bread_gfp
  bh = __getblk_gfp
  -->discard_buffer clear BH_Mapped flag
  __bread_slow
    submit_bh
      submit_bh_wbc
        BUG_ON(!buffer_mapped(bh))  --> hit this BUG_ON

Fixes: 5db470e229e2 ("loop: drop caches if offset or block_size are changed")
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/loop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c1341c86bcded..728681a20b7f4 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1238,7 +1238,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	if (lo->lo_offset != info->lo_offset ||
 	    lo->lo_sizelimit != info->lo_sizelimit) {
 		sync_blockdev(lo->lo_device);
-		kill_bdev(lo->lo_device);
+		invalidate_bdev(lo->lo_device);
 	}
 
 	/* I/O need to be drained during transfer transition */
@@ -1512,12 +1512,12 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 
 	if (lo->lo_queue->limits.logical_block_size != arg) {
 		sync_blockdev(lo->lo_device);
-		kill_bdev(lo->lo_device);
+		invalidate_bdev(lo->lo_device);
 	}
 
 	blk_mq_freeze_queue(lo->lo_queue);
 
-	/* kill_bdev should have truncated all the pages */
+	/* invalidate_bdev should have truncated all the pages */
 	if (lo->lo_queue->limits.logical_block_size != arg &&
 			lo->lo_device->bd_inode->i_mapping->nrpages) {
 		err = -EAGAIN;
-- 
2.25.1

