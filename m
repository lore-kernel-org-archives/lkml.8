Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B7CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49B37204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ukitFuYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgF2Stb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:49:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:25340 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgF2StX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:49:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593456562; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=oISdcZeNyMoDDttsitQszm0YRjEiAJPv4XIM51liqTc=; b=ukitFuYQ55VbSiEFpe6ai9udh0fHv4MVTuNMRn3SYgd3TguhJHlIZRg/LlvejnX0iyUOVHZ9
 Ij+PkrjFo4pFnmuHRmehaxBNoLSt8XdjJFxzlp5yG0lzVLC/W0k2cPDRBVQTryzbzcfx0VZ0
 XXCC1Q/aJPxiP8LReAxtTawnmkI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-west-2.postgun.com with SMTP id
 5efa195a4c9690533a7b2ad7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Jun 2020 16:39:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ACC10C433CA; Mon, 29 Jun 2020 16:39:54 +0000 (UTC)
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19EA4C433CB;
        Mon, 29 Jun 2020 16:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19EA4C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v4 3/9] bus: mhi: core: Use helper API to trigger a non-blocking host resume
Date:   Mon, 29 Jun 2020 09:39:36 -0700
Message-Id: <1593448782-8385-4-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593448782-8385-1-git-send-email-bbhatt@codeaurora.org>
References: <1593448782-8385-1-git-send-email-bbhatt@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Autonomous low power mode support requires the MHI host to resume from
multiple places and post a wakeup source to exit system suspend. This
needs to be done in a non-blocking manner. Introduce a helper API to
trigger the host resume for data transfers and other non-blocking use
cases while supporting implementation of autonomous low power modes.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
---
 drivers/bus/mhi/core/internal.h |  8 ++++++++
 drivers/bus/mhi/core/main.c     | 21 +++++++--------------
 drivers/bus/mhi/core/pm.c       |  6 ++----
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
index bcfa7b6..cb32eaf 100644
--- a/drivers/bus/mhi/core/internal.h
+++ b/drivers/bus/mhi/core/internal.h
@@ -599,6 +599,14 @@ int mhi_queue_state_transition(struct mhi_controller *mhi_cntrl,
 int mhi_send_cmd(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
 		 enum mhi_cmd_type cmd);
 
+static inline void mhi_trigger_resume(struct mhi_controller *mhi_cntrl,
+				      bool hard_wakeup)
+{
+	pm_wakeup_dev_event(&mhi_cntrl->mhi_dev->dev, 0, hard_wakeup);
+	mhi_cntrl->runtime_get(mhi_cntrl);
+	mhi_cntrl->runtime_put(mhi_cntrl);
+}
+
 /* Register access methods */
 void mhi_db_brstmode(struct mhi_controller *mhi_cntrl, struct db_cfg *db_cfg,
 		     void __iomem *db_addr, dma_addr_t db_val);
diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index 1f622ce..8d6ec34 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -909,8 +909,7 @@ void mhi_ctrl_ev_task(unsigned long data)
 		 * process it since we are probably in a suspended state,
 		 * so trigger a resume.
 		 */
-		mhi_cntrl->runtime_get(mhi_cntrl);
-		mhi_cntrl->runtime_put(mhi_cntrl);
+		mhi_trigger_resume(mhi_cntrl, false);
 
 		return;
 	}
@@ -971,10 +970,8 @@ int mhi_queue_skb(struct mhi_device *mhi_dev, enum dma_data_direction dir,
 	}
 
 	/* we're in M3 or transitioning to M3 */
-	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state)) {
-		mhi_cntrl->runtime_get(mhi_cntrl);
-		mhi_cntrl->runtime_put(mhi_cntrl);
-	}
+	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
+		mhi_trigger_resume(mhi_cntrl, false);
 
 	/* Toggle wake to exit out of M2 */
 	mhi_cntrl->wake_toggle(mhi_cntrl);
@@ -1032,10 +1029,8 @@ int mhi_queue_dma(struct mhi_device *mhi_dev, enum dma_data_direction dir,
 	}
 
 	/* we're in M3 or transitioning to M3 */
-	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state)) {
-		mhi_cntrl->runtime_get(mhi_cntrl);
-		mhi_cntrl->runtime_put(mhi_cntrl);
-	}
+	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
+		mhi_trigger_resume(mhi_cntrl, false);
 
 	/* Toggle wake to exit out of M2 */
 	mhi_cntrl->wake_toggle(mhi_cntrl);
@@ -1147,10 +1142,8 @@ int mhi_queue_buf(struct mhi_device *mhi_dev, enum dma_data_direction dir,
 	read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
 
 	/* we're in M3 or transitioning to M3 */
-	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state)) {
-		mhi_cntrl->runtime_get(mhi_cntrl);
-		mhi_cntrl->runtime_put(mhi_cntrl);
-	}
+	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
+		mhi_trigger_resume(mhi_cntrl, false);
 
 	/* Toggle wake to exit out of M2 */
 	mhi_cntrl->wake_toggle(mhi_cntrl);
diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index 661d704..5e3994e 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -1139,10 +1139,8 @@ void mhi_device_put(struct mhi_device *mhi_dev)
 
 	mhi_dev->dev_wake--;
 	read_lock_bh(&mhi_cntrl->pm_lock);
-	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state)) {
-		mhi_cntrl->runtime_get(mhi_cntrl);
-		mhi_cntrl->runtime_put(mhi_cntrl);
-	}
+	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
+		mhi_trigger_resume(mhi_cntrl, false);
 
 	mhi_cntrl->wake_put(mhi_cntrl, false);
 	read_unlock_bh(&mhi_cntrl->pm_lock);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

