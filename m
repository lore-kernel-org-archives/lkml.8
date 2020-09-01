Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96692C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 677F9205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598974381;
	bh=MGiUJRBIBouh01SmxxQoSYbdAvmzto3mlPe7Cw8cerw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lQhbkdWIcKjDKlaapUpN2BCu0A/vLD1O4TRdt4W11v93a7tXMovNrKb3hZK+afgff
	 xzAsr9W3ttNe833n/gCSE/VvNB9xcHBa/rFJogWHemGAJmoF5agXmHuLx2acBofJ9F
	 NrqOLnk2+P7F+7TTecZ6BkS0bHsHalDmrDZFiJvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbgIAPc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:32:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728473AbgIAPcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:32:52 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3208A21534;
        Tue,  1 Sep 2020 15:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974371;
        bh=MGiUJRBIBouh01SmxxQoSYbdAvmzto3mlPe7Cw8cerw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i0ktn6ZKLkbq+WskbO7ncFlYyraM9503MeJ0pr7Rl2fBdcdAH8yv8xo12+MXSXnBA
         HiNBFFhtSruL3WrG41C8LUedOupfi9o4AV1IHXATaUqG5iwp+s96f/uz5UWkVk+mza
         ozsbOjUrDCFAh7GQohqLdvrRsh5LrV30ImsLaoTU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Coly Li <colyli@suse.de>,
        Hannes Reinecke <hare@suse.com>, Xiao Ni <xni@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Evan Green <evgreen@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.4 150/214] block: loop: set discard granularity and alignment for block device backed loop
Date:   Tue,  1 Sep 2020 17:10:30 +0200
Message-Id: <20200901151000.152159836@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

commit bcb21c8cc9947286211327d663ace69f07d37a76 upstream.

In case of block device backend, if the backend supports write zeros, the
loop device will set queue flag of QUEUE_FLAG_DISCARD. However,
limits.discard_granularity isn't setup, and this way is wrong,
see the following description in Documentation/ABI/testing/sysfs-block:

	A discard_granularity of 0 means that the device does not support
	discard functionality.

Especially 9b15d109a6b2 ("block: improve discard bio alignment in
__blkdev_issue_discard()") starts to take q->limits.discard_granularity
for computing max discard sectors. And zero discard granularity may cause
kernel oops, or fail discard request even though the loop queue claims
discard support via QUEUE_FLAG_DISCARD.

Fix the issue by setup discard granularity and alignment.

Fixes: c52abf563049 ("loop: Better discard support for block devices")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Coly Li <colyli@suse.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Xiao Ni <xni@redhat.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Evan Green <evgreen@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -863,6 +863,7 @@ static void loop_config_discard(struct l
 	struct file *file = lo->lo_backing_file;
 	struct inode *inode = file->f_mapping->host;
 	struct request_queue *q = lo->lo_queue;
+	u32 granularity, max_discard_sectors;
 
 	/*
 	 * If the backing device is a block device, mirror its zeroing
@@ -875,11 +876,10 @@ static void loop_config_discard(struct l
 		struct request_queue *backingq;
 
 		backingq = bdev_get_queue(inode->i_bdev);
-		blk_queue_max_discard_sectors(q,
-			backingq->limits.max_write_zeroes_sectors);
 
-		blk_queue_max_write_zeroes_sectors(q,
-			backingq->limits.max_write_zeroes_sectors);
+		max_discard_sectors = backingq->limits.max_write_zeroes_sectors;
+		granularity = backingq->limits.discard_granularity ?:
+			queue_physical_block_size(backingq);
 
 	/*
 	 * We use punch hole to reclaim the free space used by the
@@ -888,23 +888,26 @@ static void loop_config_discard(struct l
 	 * useful information.
 	 */
 	} else if (!file->f_op->fallocate || lo->lo_encrypt_key_size) {
-		q->limits.discard_granularity = 0;
-		q->limits.discard_alignment = 0;
-		blk_queue_max_discard_sectors(q, 0);
-		blk_queue_max_write_zeroes_sectors(q, 0);
+		max_discard_sectors = 0;
+		granularity = 0;
 
 	} else {
-		q->limits.discard_granularity = inode->i_sb->s_blocksize;
-		q->limits.discard_alignment = 0;
-
-		blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
-		blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
+		max_discard_sectors = UINT_MAX >> 9;
+		granularity = inode->i_sb->s_blocksize;
 	}
 
-	if (q->limits.max_write_zeroes_sectors)
+	if (max_discard_sectors) {
+		q->limits.discard_granularity = granularity;
+		blk_queue_max_discard_sectors(q, max_discard_sectors);
+		blk_queue_max_write_zeroes_sectors(q, max_discard_sectors);
 		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
-	else
+	} else {
+		q->limits.discard_granularity = 0;
+		blk_queue_max_discard_sectors(q, 0);
+		blk_queue_max_write_zeroes_sectors(q, 0);
 		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
+	}
+	q->limits.discard_alignment = 0;
 }
 
 static void loop_unprepare_queue(struct loop_device *lo)


