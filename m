Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE781C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4F6D206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732674AbgFWNZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:25:00 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:65012 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732594AbgFWNY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:24:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U0WDs5d_1592918683;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U0WDs5d_1592918683)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Jun 2020 21:24:43 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] nvme: Add Arbitration Burst support
Date:   Tue, 23 Jun 2020 21:24:32 +0800
Message-Id: <bf3f47ba50f72d0b775ca4bd098f183056d964ba.1592916850.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the NVMe spec, "In order to make efficient use of the non-volatile
memory, it is often advantageous to execute multiple commands from a
Submission Queue in parallel. For Submission Queues that are using
weighted round robin with urgent priority class or round robin
arbitration, host software may configure an Arbitration Burst setting".
Thus add Arbitration Burst setting support.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 23 +++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/pci.c  |  2 ++
 3 files changed, 27 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2c5bc4..c3a60d8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1241,6 +1241,28 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 }
 EXPORT_SYMBOL_GPL(nvme_set_queue_count);
 
+void nvme_set_arbitration_burst(struct nvme_ctrl *ctrl)
+{
+	u32 result;
+	int status;
+
+	if (!ctrl->rab)
+		return;
+
+	/*
+	 * The Arbitration Burst setting indicates the maximum number of
+	 * commands that the controller may launch at one time from a
+	 * particular Submission Queue. It is recommended that host software
+	 * configure the Arbitration Burst setting as close to the recommended
+	 * value by the controller as possible.
+	 */
+	status = nvme_set_features(ctrl, NVME_FEAT_ARBITRATION, ctrl->rab,
+				   NULL, 0, &result);
+	if (status)
+		dev_warn(ctrl->device, "Failed to set Arbitration Burst\n");
+}
+EXPORT_SYMBOL_GPL(nvme_set_arbitration_burst);
+
 #define NVME_AEN_SUPPORTED \
 	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
 	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
@@ -2953,6 +2975,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	} else
 		ctrl->shutdown_timeout = shutdown_timeout;
 
+	ctrl->rab = id->rab;
 	ctrl->npss = id->npss;
 	ctrl->apsta = id->apsta;
 	prev_apst_enabled = ctrl->apst_enabled;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c0f4226..3934426 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -246,6 +246,7 @@ struct nvme_ctrl {
 	u16 kas;
 	u8 npss;
 	u8 apsta;
+	u8 rab;
 	u16 wctemp;
 	u16 cctemp;
 	u32 oaes;
@@ -550,6 +551,7 @@ int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
 		      u32 *result);
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
+void nvme_set_arbitration_burst(struct nvme_ctrl *ctrl);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e2bacd3..4b4b7b7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2111,6 +2111,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	
 	clear_bit(NVMEQ_ENABLED, &adminq->flags);
 
+	nvme_set_arbitration_burst(&dev->ctrl);
+
 	if (dev->cmb_use_sqes) {
 		result = nvme_cmb_qdepth(dev, nr_io_queues,
 				sizeof(struct nvme_command));
-- 
1.8.3.1

