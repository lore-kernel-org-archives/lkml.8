Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FEEC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F09E206EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598975017;
	bh=fIHIM0NwOWuvBqLrNo02Cp7DkkhrsMdirJnurd7PR9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aBiwRrr1ji9BG5fU9FsjQHscRTqlgolQdV1BjyUhATI7e09wFt8XA4vtNULgi5Lui
	 OQ+ij2z2EDQKA3cfKuzAoiKbLiORnf4CEDLjiUHE6q8zRBP+boveTuDwTQA9qZyCDg
	 lHQQbUcZLwInMI5ITqAdjxW/LL+ZZgphhVtTZ1Ng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbgIAPne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:43:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731516AbgIAPk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:40:58 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32D55206EF;
        Tue,  1 Sep 2020 15:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974857;
        bh=fIHIM0NwOWuvBqLrNo02Cp7DkkhrsMdirJnurd7PR9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OZRGggsI/1nB6HuuvX8PyQryDuACLFlYfP5SSiI4fpgSvCL9izZIrm31ConDHgoNh
         bjnIvUlevUe7PH1rFKCsWQl1xTUOZZCVCq0eN314jcKxPPoRT67xIXjCBGRhx38fI3
         D630ZpY1mvIn57hy3hfHW7+XWB4V9JUiTaTv09PM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Changpeng Liu <changpeng.liu@intel.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 087/255] block: virtio_blk: fix handling single range discard request
Date:   Tue,  1 Sep 2020 17:09:03 +0200
Message-Id: <20200901151004.895777425@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit af822aa68fbdf0a480a17462ed70232998127453 ]

1f23816b8eb8 ("virtio_blk: add discard and write zeroes support") starts
to support multi-range discard for virtio-blk. However, the virtio-blk
disk may report max discard segment as 1, at least that is exactly what
qemu is doing.

So far, block layer switches to normal request merge if max discard segment
limit is 1, and multiple bios can be merged to single segment. This way may
cause memory corruption in virtblk_setup_discard_write_zeroes().

Fix the issue by handling single max discard segment in straightforward
way.

Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Changpeng Liu <changpeng.liu@intel.com>
Cc: Daniel Verkamp <dverkamp@chromium.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/virtio_blk.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 980df853ee497..99991b6a6f0ed 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -126,16 +126,31 @@ static int virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
 	if (!range)
 		return -ENOMEM;
 
-	__rq_for_each_bio(bio, req) {
-		u64 sector = bio->bi_iter.bi_sector;
-		u32 num_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
-
-		range[n].flags = cpu_to_le32(flags);
-		range[n].num_sectors = cpu_to_le32(num_sectors);
-		range[n].sector = cpu_to_le64(sector);
-		n++;
+	/*
+	 * Single max discard segment means multi-range discard isn't
+	 * supported, and block layer only runs contiguity merge like
+	 * normal RW request. So we can't reply on bio for retrieving
+	 * each range info.
+	 */
+	if (queue_max_discard_segments(req->q) == 1) {
+		range[0].flags = cpu_to_le32(flags);
+		range[0].num_sectors = cpu_to_le32(blk_rq_sectors(req));
+		range[0].sector = cpu_to_le64(blk_rq_pos(req));
+		n = 1;
+	} else {
+		__rq_for_each_bio(bio, req) {
+			u64 sector = bio->bi_iter.bi_sector;
+			u32 num_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
+
+			range[n].flags = cpu_to_le32(flags);
+			range[n].num_sectors = cpu_to_le32(num_sectors);
+			range[n].sector = cpu_to_le64(sector);
+			n++;
+		}
 	}
 
+	WARN_ON_ONCE(n != segments);
+
 	req->special_vec.bv_page = virt_to_page(range);
 	req->special_vec.bv_offset = offset_in_page(range);
 	req->special_vec.bv_len = sizeof(*range) * segments;
-- 
2.25.1



