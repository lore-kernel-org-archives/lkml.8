Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373FBC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12D9C2078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598976417;
	bh=RqdeLEbmMQXULoSZsQmjQtt6OU/wzOpttepJrcg+/Zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w+6Yv7ZUfzSlHBCBrf7qn2hTzEtz1YscxIlZiKlFcr6B/VN8J3ioNvZEhJ/ocX4VH
	 czoPeW4H2f6qstO0t2aBqt/JhW2G+KZXf9rmjTV+JLYC/0l5ywBQ2Ddd0YwT6sWzUa
	 81q6EPALHqTJ3IPw1Wazee6M/Wz1cQFb3+PfdSz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbgIAQGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:06:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728421AbgIAPk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:40:56 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A47E02098B;
        Tue,  1 Sep 2020 15:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974855;
        bh=RqdeLEbmMQXULoSZsQmjQtt6OU/wzOpttepJrcg+/Zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zgf03aGc/9Tmg6NDlL7R/maAt9zs8hfHOEgsr78SbNWVd7iGppbNQw1u3laBs7LHL
         U6vpTUi5//LQHSI5QErParolRhMBEECP3DDCPvAf1zs8ysbXUMo9QuW2fIsSEZ3PeD
         /rrTJ2ZC3CXYrvU9aYexLySW/pJZd5gjLo5u3jLE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 086/255] block: respect queue limit of max discard segment
Date:   Tue,  1 Sep 2020 17:09:02 +0200
Message-Id: <20200901151004.853971341@linuxfoundation.org>
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

[ Upstream commit 943b40c832beb71115e38a1c4d99b640b5342738 ]

When queue_max_discard_segments(q) is 1, blk_discard_mergable() will
return false for discard request, then normal request merge is applied.
However, only queue_max_segments() is checked, so max discard segment
limit isn't respected.

Check max discard segment limit in the request merge code for fixing
the issue.

Discard request failure of virtio_blk is fixed.

Fixes: 69840466086d ("block: fix the DISCARD request merge")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-merge.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index f0b0bae075a0c..0b590907676af 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -534,10 +534,17 @@ int __blk_rq_map_sg(struct request_queue *q, struct request *rq,
 }
 EXPORT_SYMBOL(__blk_rq_map_sg);
 
+static inline unsigned int blk_rq_get_max_segments(struct request *rq)
+{
+	if (req_op(rq) == REQ_OP_DISCARD)
+		return queue_max_discard_segments(rq->q);
+	return queue_max_segments(rq->q);
+}
+
 static inline int ll_new_hw_segment(struct request *req, struct bio *bio,
 		unsigned int nr_phys_segs)
 {
-	if (req->nr_phys_segments + nr_phys_segs > queue_max_segments(req->q))
+	if (req->nr_phys_segments + nr_phys_segs > blk_rq_get_max_segments(req))
 		goto no_merge;
 
 	if (blk_integrity_merge_bio(req->q, req, bio) == false)
@@ -625,7 +632,7 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 		return 0;
 
 	total_phys_segments = req->nr_phys_segments + next->nr_phys_segments;
-	if (total_phys_segments > queue_max_segments(q))
+	if (total_phys_segments > blk_rq_get_max_segments(req))
 		return 0;
 
 	if (blk_integrity_merge_rq(q, req, next) == false)
-- 
2.25.1



