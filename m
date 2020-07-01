Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275F5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1BD32074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xqc61nrv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgGAJAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbgGAJAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:00:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C674CC061755;
        Wed,  1 Jul 2020 02:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MVPFkWqT27H+EK/gr/8Zgz6Ls+wUfbhG+l5NiS06UDM=; b=Xqc61nrvMsR15YDOdMP6gtz3OE
        dp+q2eYG614WsXa61aoCzCbPCQ7EVEVjOMGDkZ7NwFsWva1CU/EvlYVng9fHqdWz36bmP6jHTHMtm
        9HwoHIhv4HRqd58L1tsbK2MdDGVgvpVUQYejP9ypWrETeNZsm35WLbdn6x/AvJVm+VOSzNnxf8fIp
        KbxYtgEm6H6dIO6eulryJM42lvmAA4qbqnqGgGosrBmekGRp2FABgjxHfMQ4AZJpDtEP0NdKqhokl
        jx62VheF1t1OKHUt+hiBH3kaQ5UWqD0m6Z3qmOJFA/qujzu0C+QlUtYPS+cJEhcj1NpJAxoejnICo
        sgM4n4Xg==;
Received: from [2001:4bb8:184:76e3:ea38:596b:3e9e:422a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqYbD-0008FC-9s; Wed, 01 Jul 2020 09:00:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org,
        drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 15/20] block: remove the nr_sectors variable in generic_make_request_checks
Date:   Wed,  1 Jul 2020 10:59:42 +0200
Message-Id: <20200701085947.3354405-16-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701085947.3354405-1-hch@lst.de>
References: <20200701085947.3354405-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable is only used once, so just open code the bio_sector()
there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 37435d0d433564..28f60985dc75cc 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -974,7 +974,6 @@ static noinline_for_stack bool
 generic_make_request_checks(struct bio *bio)
 {
 	struct request_queue *q = bio->bi_disk->queue;
-	int nr_sectors = bio_sectors(bio);
 	blk_status_t status = BLK_STS_IOERR;
 
 	might_sleep();
@@ -1007,7 +1006,7 @@ generic_make_request_checks(struct bio *bio)
 	if (op_is_flush(bio->bi_opf) &&
 	    !test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
 		bio->bi_opf &= ~(REQ_PREFLUSH | REQ_FUA);
-		if (!nr_sectors) {
+		if (!bio_sectors(bio)) {
 			status = BLK_STS_OK;
 			goto end_io;
 		}
-- 
2.26.2

