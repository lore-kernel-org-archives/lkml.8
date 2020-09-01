Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E25CC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16B37207D3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598974944;
	bh=vzNBNtq1DCoZBAIMujwwjrAo0CYY6LBrr9qeIlp0IQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tHla5Pj6LmXeQBKxY+aOwbPXZt6ZA0JRfrvaiibIv0IX9Rc931JhCPOqicfCD5eeL
	 oV2ObyQiovJELAfobK6jr3JtHpYYnFrsI/5ramLmh0RCPd4+wAsoRbhnElpLiH3xs+
	 D4nVSWYVwsTWcbr1vywy4UGwzZOmIDl8p8zfOJNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731460AbgIAPmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:42:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731478AbgIAPju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:39:50 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60C0C20866;
        Tue,  1 Sep 2020 15:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974790;
        bh=vzNBNtq1DCoZBAIMujwwjrAo0CYY6LBrr9qeIlp0IQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZUO4eGge5TNFd1jxF4/JcJ0dopVFx9v3Moj2usxcLksIJQL2D10XEOTDmaIxIuDeI
         eEdUYgzG6hYM0tvbP5WljXW8QOotd0mS8vBoF2PdV7vtFL/BMGcQhrwptSSVX/Wehk
         vUrR0xlLoO/8MPyfRAbXYVx3u62XAgJ2rTwaou5s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 092/255] blk-mq: insert request not through ->queue_rq into sw/scheduler queue
Date:   Tue,  1 Sep 2020 17:09:08 +0200
Message-Id: <20200901151005.133336204@linuxfoundation.org>
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

[ Upstream commit db03f88fae8a2c8007caafa70287798817df2875 ]

c616cbee97ae ("blk-mq: punt failed direct issue to dispatch list") supposed
to add request which has been through ->queue_rq() to the hw queue dispatch
list, however it adds request running out of budget or driver tag to hw queue
too. This way basically bypasses request merge, and causes too many request
dispatched to LLD, and system% is unnecessary increased.

Fixes this issue by adding request not through ->queue_rq into sw/scheduler
queue, and this way is safe because no ->queue_rq is called on this request
yet.

High %system can be observed on Azure storvsc device, and even soft lock
is observed. This patch reduces %system during heavy sequential IO,
meantime decreases soft lockup risk.

Fixes: c616cbee97ae ("blk-mq: punt failed direct issue to dispatch list")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4e0d173beaa35..e86ccfe377779 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1909,7 +1909,8 @@ insert:
 	if (bypass_insert)
 		return BLK_STS_RESOURCE;
 
-	blk_mq_request_bypass_insert(rq, false, run_queue);
+	blk_mq_sched_insert_request(rq, false, run_queue, false);
+
 	return BLK_STS_OK;
 }
 
-- 
2.25.1



