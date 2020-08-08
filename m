Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2992C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCEAB207FB
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596929846;
	bh=n4p+AeW6JiuIsLx1WW7NJfTXfksep1+709oM9kBwEgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F+hDlRmFIGF1O9+DPfMuhLRDOKxzjXpBm3BzlDipW1ImvVYtXXtF8inFilv8l1sq1
	 RuQCrrZb3CAsyRl0IQRmPWk2HTH0hZ7AAPUu3JnD/DsGP30S1ZhXWlqmPKLxu6zkK0
	 Gvx2uDI41dEq53tgcySD+noeNIQydPnAVWXA85pU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgHHXhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:37:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbgHHXhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:37:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0605420716;
        Sat,  8 Aug 2020 23:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929836;
        bh=n4p+AeW6JiuIsLx1WW7NJfTXfksep1+709oM9kBwEgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KViAebb0CFrW9Tm9xR+XkQvF25HJvWtBFXXG2ijKVVNkQv37xAm7EIAsEYnMFryy7
         +YUnMas5wNs+OZqckMUQ7DlVGkTdyAOsVavhn8JMK0J2HHO/yjg4A+dB/6Gf7JdraY
         w5/8rgW5mRlJxMpT03aTj+C+Sau/q9e8sE2BGm3I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.8 67/72] nvme-tcp: fix controller reset hang during traffic
Date:   Sat,  8 Aug 2020 19:35:36 -0400
Message-Id: <20200808233542.3617339-67-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233542.3617339-1-sashal@kernel.org>
References: <20200808233542.3617339-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index f3a91818167b1..83bb329d4113a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1744,15 +1744,20 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
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
@@ -1857,6 +1862,7 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 {
 	if (ctrl->queue_count <= 1)
 		return;
+	nvme_start_freeze(ctrl);
 	nvme_stop_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
 	if (ctrl->tagset) {
-- 
2.25.1

