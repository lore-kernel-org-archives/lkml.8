Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B0EC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A55AD20768
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599498353;
	bh=s8u0FvbdNPOxEgiRzZ5VZ3uoWPrvjaK2/bRhnKrDr3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p9d48ZxDS++PKf300feoJTkQITrwAPI5/uYyls6cJ2BeXy1Sho90pWp1GYKLkxyxR
	 LqWb+vFHQ+tEwF8lMZDw9oSCd7jGZCHalzbjzgbOrlWRmGd+Kjsk2D2tU54lxuJjla
	 2kLz13tekmlmL9oTg59Cyw6ozWMQ9EfEQYzGIQ0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbgIGRFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:05:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730663AbgIGQdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:33:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66FA620757;
        Mon,  7 Sep 2020 16:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496385;
        bh=s8u0FvbdNPOxEgiRzZ5VZ3uoWPrvjaK2/bRhnKrDr3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kowUw7aX51PPWCy0xQUr/E/iFK1qaMqa8ib7l3btDItjq1txAhscDrArFD4yaMv8O
         Vzz1dv3pBtg5IG86lAw5n5r0oSiJOUzOu301ErLlRXdi4SFK3M1H+imKAxyzisS+91
         Ksb9EFkZBTe+unR/FnKg7c0LAZXYpluNwd3Mlz+E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.8 35/53] nvme-rdma: fix reset hang if controller died in the middle of a reset
Date:   Mon,  7 Sep 2020 12:32:01 -0400
Message-Id: <20200907163220.1280412-35-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163220.1280412-1-sashal@kernel.org>
References: <20200907163220.1280412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 2362acb6785611eda795bfc12e1ea6b202ecf62c ]

If the controller becomes unresponsive in the middle of a reset, we
will hang because we are waiting for the freeze to complete, but that
cannot happen since we have commands that are inflight holding the
q_usage_counter, and we can't blindly fail requests that times out.

So give a timeout and if we cannot wait for queue freeze before
unfreezing, fail and have the error handling take care how to
proceed (either schedule a reconnect of remove the controller).

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/rdma.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 99bf88eb812c5..6c07bb55b0f83 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -950,7 +950,15 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
 	if (!new) {
 		nvme_start_queues(&ctrl->ctrl);
-		nvme_wait_freeze(&ctrl->ctrl);
+		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
+			/*
+			 * If we timed out waiting for freeze we are likely to
+			 * be stuck.  Fail the controller initialization just
+			 * to be safe.
+			 */
+			ret = -ENODEV;
+			goto out_wait_freeze_timed_out;
+		}
 		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
 			ctrl->ctrl.queue_count - 1);
 		nvme_unfreeze(&ctrl->ctrl);
@@ -958,6 +966,9 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
 	return 0;
 
+out_wait_freeze_timed_out:
+	nvme_stop_queues(&ctrl->ctrl);
+	nvme_rdma_stop_io_queues(ctrl);
 out_cleanup_connect_q:
 	if (new)
 		blk_cleanup_queue(ctrl->ctrl.connect_q);
-- 
2.25.1

