Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18295C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 010E620738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389446AbgFXGuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:50:17 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:60629 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389354AbgFXGuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:50:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U0ZTZul_1592981407;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U0ZTZul_1592981407)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Jun 2020 14:50:07 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] nvme: Add Arbitration Burst support
Date:   Wed, 24 Jun 2020 14:49:57 +0800
Message-Id: <32d99c016d23d660f5be4a9754b5b9aafe81ab6c.1592980985.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1592980985.git.baolin.wang@linux.alibaba.com>
References: <cover.1592980985.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1592980985.git.baolin.wang@linux.alibaba.com>
References: <cover.1592980985.git.baolin.wang@linux.alibaba.com>
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
 drivers/nvme/host/core.c | 29 +++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 include/linux/nvme.h     |  1 +
 3 files changed, 31 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2c5bc4..f5f882f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -61,6 +61,10 @@
 module_param(streams, bool, 0644);
 MODULE_PARM_DESC(streams, "turn on support for Streams write directives");
 
+static bool use_rab;
+module_param(use_rab, bool, 0644);
+MODULE_PARM_DESC(use_rab, "use controller's recommended arbitration burst");
+
 /*
  * nvme_wq - hosts nvme related works that are not reset or delete
  * nvme_reset_wq - hosts nvme reset works
@@ -1241,6 +1245,28 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 }
 EXPORT_SYMBOL_GPL(nvme_set_queue_count);
 
+static void nvme_set_arbitration_burst(struct nvme_ctrl *ctrl)
+{
+	u32 result;
+	int status;
+
+	if (!use_rab || !ctrl->rab)
+		return;
+
+	/*
+	 * The Arbitration Burst setting indicates the maximum number of
+	 * commands that the controller may launch at one time from a
+	 * particular Submission Queue. It is recommended that host software
+	 * configure the Arbitration Burst setting as close to the recommended
+	 * value by the controller as possible.
+	 */
+	status = nvme_set_features(ctrl, NVME_FEAT_ARBITRATION,
+				   ctrl->rab & NVME_FEAT_ARBITRATION_MASK,
+				   NULL, 0, &result);
+	if (status)
+		dev_warn(ctrl->device, "Failed to set Arbitration Burst\n");
+}
+
 #define NVME_AEN_SUPPORTED \
 	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
 	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
@@ -2953,6 +2979,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	} else
 		ctrl->shutdown_timeout = shutdown_timeout;
 
+	ctrl->rab = id->rab;
+	nvme_set_arbitration_burst(ctrl);
+
 	ctrl->npss = id->npss;
 	ctrl->apsta = id->apsta;
 	prev_apst_enabled = ctrl->apst_enabled;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c0f4226..bc424c5 100644
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
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 5ce51ab..fa629c8 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -909,6 +909,7 @@ enum {
 	NVME_SQ_PRIO_MEDIUM	= (2 << 1),
 	NVME_SQ_PRIO_LOW	= (3 << 1),
 	NVME_FEAT_ARBITRATION	= 0x01,
+	NVME_FEAT_ARBITRATION_MASK = 0x7,
 	NVME_FEAT_POWER_MGMT	= 0x02,
 	NVME_FEAT_LBA_RANGE	= 0x03,
 	NVME_FEAT_TEMP_THRESH	= 0x04,
-- 
1.8.3.1

