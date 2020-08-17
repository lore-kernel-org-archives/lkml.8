Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D0DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 526042053B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597689100;
	bh=mDvJv/VK+kao2IarrXzUF5c67w22XnuUMVb8zUHLb6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ioIxRvNPFoaFB95VmjuzHt/LanDITdv/TSxQSU/7FmG6F6sIy1bEN8AWf7GCpAWRl
	 rCt8BA7M4LasmorVLTXw3tiCNRn81qAMPJ6xQ291hrieVad6Kdg8r81WFYa8bw37yO
	 9JVdDnr1PsInraXEyl7UX11APaZG3yrTazuBjQfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389621AbgHQSbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387991AbgHQQBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:01:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8570E20729;
        Mon, 17 Aug 2020 16:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680075;
        bh=mDvJv/VK+kao2IarrXzUF5c67w22XnuUMVb8zUHLb6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MF1m84Z7OaXpKlxiPdGUKm9QQ95bnpa2V7sodZyyUvKd8BvmMPIIQtmBCjISLE+Qs
         Y8IdCj2fAjn9eioFSrgzJhg0hxB30PVe/F5gEfnuJCILA2ppdnxCP41wMQqHwgXlQP
         7JQaRvP9S1dGNOPhYeQuuPm+GJKgrQumB/rchaVA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 043/270] nvme-rdma: fix controller reset hang during traffic
Date:   Mon, 17 Aug 2020 17:14:04 +0200
Message-Id: <20200817143757.947858638@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 9f98772ba307dd89a3d17dc2589f213d3972fc64 ]

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
 drivers/nvme/host/rdma.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index cd0d499781908..d0336545e1fe0 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -890,15 +890,20 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 			ret = PTR_ERR(ctrl->ctrl.connect_q);
 			goto out_free_tag_set;
 		}
-	} else {
-		blk_mq_update_nr_hw_queues(&ctrl->tag_set,
-			ctrl->ctrl.queue_count - 1);
 	}
 
 	ret = nvme_rdma_start_io_queues(ctrl);
 	if (ret)
 		goto out_cleanup_connect_q;
 
+	if (!new) {
+		nvme_start_queues(&ctrl->ctrl);
+		nvme_wait_freeze(&ctrl->ctrl);
+		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
+			ctrl->ctrl.queue_count - 1);
+		nvme_unfreeze(&ctrl->ctrl);
+	}
+
 	return 0;
 
 out_cleanup_connect_q:
@@ -931,6 +936,7 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
 	if (ctrl->ctrl.queue_count > 1) {
+		nvme_start_freeze(&ctrl->ctrl);
 		nvme_stop_queues(&ctrl->ctrl);
 		nvme_rdma_stop_io_queues(ctrl);
 		if (ctrl->ctrl.tagset) {
-- 
2.25.1



