Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD3EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 954EF206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598977360;
	bh=iHraPqcWIuC6KUiwWwCGn2hqCPFfZxVGTyd79HTIvtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r7uioHEHQUbu2hlXWMIxUg46ignu3mM+xS1Jt1Yxv3BWtFlDwXJUtLqjxo0YDb/BZ
	 eiMkSsfKe5XjBviCLS1y0JJ9KF42ErsM332RSK8U+GM5niPRVUmAOwxxaGWxUUBOIj
	 93dck8TZd4/pPT5wzR1heRB8ZUpPc3DynRzQf5y8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbgIAPcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:32:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730635AbgIAPaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:30:55 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C49BE20FC3;
        Tue,  1 Sep 2020 15:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974252;
        bh=iHraPqcWIuC6KUiwWwCGn2hqCPFfZxVGTyd79HTIvtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=akDXqimAjwnJen8vguT3ReJ76uulIFtNp2j9f4VsuMJ/LMsC5+TOjxIi4+6i0FnrF
         on528O/XAdvabPf/EBdXnAbJ0j67mk8NitGBIG1x/z6y3IueAU6D76Q76TArtIrwKk
         6axX6iMi9aBqjPcgWoP0qJJVuQKEdYV14nIz3D0c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 105/214] blk-mq: insert request not through ->queue_rq into sw/scheduler queue
Date:   Tue,  1 Sep 2020 17:09:45 +0200
Message-Id: <20200901150958.018897922@linuxfoundation.org>
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
index ae7d31cb5a4e1..8f67f0f16ec2e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1869,7 +1869,8 @@ insert:
 	if (bypass_insert)
 		return BLK_STS_RESOURCE;
 
-	blk_mq_request_bypass_insert(rq, false, run_queue);
+	blk_mq_sched_insert_request(rq, false, run_queue, false);
+
 	return BLK_STS_OK;
 }
 
-- 
2.25.1



