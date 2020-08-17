Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AA9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E8B52053B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597680269;
	bh=REczOt4TXKPZcId4XYB6HQe/95cS7RHQwDga/Y9APWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T3BrkBtaRwVDrbmOPN56C0Q0pNk0iLhzRtZk0BI4663bG6v2MRruBHcM8U7JxXKze
	 /PXT5n55zVNEm5dLKit4WGf+3i+Sx8PihENXmcUEEwgkZx0XCvfVVDEBgegI2f2fi1
	 DhpXMHmR0Tu/wuZwGZJ+iOab2octvtU5rHD7ch5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388300AbgHQQEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387690AbgHQPoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:44:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6217B2075B;
        Mon, 17 Aug 2020 15:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679078;
        bh=REczOt4TXKPZcId4XYB6HQe/95cS7RHQwDga/Y9APWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqVKpWSAGw8jy9DgiRr3/tP52PupFNgVBAKxf/ncSZDLTnwoEXQCERZmmLdbH3hIv
         5lydJsEjmFYry14ERCLig/V8qKX8JWfGKwqHaYwByEqZ5IqsZJjFAymBiQZq/f/6fv
         VjDrxt5TFuhsjjbqYym6lVAYlimYWKhgL78DSAzc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 058/393] nvme-tcp: fix controller reset hang during traffic
Date:   Mon, 17 Aug 2020 17:11:48 +0200
Message-Id: <20200817143822.430709851@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 2875b0aecabe2f081a8432e2bc85b85df0529490 ]

commit fe35ec58f0d3 ("block: update hctx map when use multiple maps")
exposed an issue where we may hang trying to wait for queue freeze
during I/O. We call blk_mq_update_nr_hw_queues which in case of multiple
queue maps (which we have now for default/read/poll) is attempting to
freeze the queue. However we never started queue freeze when starting the
reset, which means that we have inflight pending requests that entered the
queue that we will not complete once the queue is quiesced.

So start a freeze before we quiesce the queue, and unfreeze the queue
after we successfully connected the I/O queues (and make sure to call
blk_mq_update_nr_hw_queues only after we are sure that the queue was
already frozen).

This follows to how the pci driver handles resets.

Fixes: fe35ec58f0d3 ("block: update hctx map when use multiple maps")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 26461bf3fdcc3..99eaa0474e10b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1753,15 +1753,20 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 			ret = PTR_ERR(ctrl->connect_q);
 			goto out_free_tag_set;
 		}
-	} else {
-		blk_mq_update_nr_hw_queues(ctrl->tagset,
-			ctrl->queue_count - 1);
 	}
 
 	ret = nvme_tcp_start_io_queues(ctrl);
 	if (ret)
 		goto out_cleanup_connect_q;
 
+	if (!new) {
+		nvme_start_queues(ctrl);
+		nvme_wait_freeze(ctrl);
+		blk_mq_update_nr_hw_queues(ctrl->tagset,
+			ctrl->queue_count - 1);
+		nvme_unfreeze(ctrl);
+	}
+
 	return 0;
 
 out_cleanup_connect_q:
@@ -1866,6 +1871,7 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 {
 	if (ctrl->queue_count <= 1)
 		return;
+	nvme_start_freeze(ctrl);
 	nvme_stop_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
 	if (ctrl->tagset) {
-- 
2.25.1



