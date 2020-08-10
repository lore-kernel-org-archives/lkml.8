Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC9AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E39F206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="fz6F4PNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgHJWC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:02:27 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:12407 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727059AbgHJWCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 18:02:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597096943; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=XS6WycnaqRRIfStzHC4a88Vy8H2kYMsGjNh8O2sYIpE=; b=fz6F4PNFO2zf91pWjpak5e350KrIWUDLc5r4tUVpPLOF/wr0UDFOf7aI9I5OaZPyoIEFPMMT
 uFmubbZ28bd9p741L/kHRp1AIkeRVLR+ZT2FDaNaL5ZiQI3ymaTFfiudP2KqKSyebQKDUAa3
 V+QQ0alFR8wqoayygSvnyWd1ZkE=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-east-1.postgun.com with SMTP id
 5f31c3ad91f8def8b29f0a1d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 10 Aug 2020 22:01:17
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 284D9C433AF; Mon, 10 Aug 2020 22:01:17 +0000 (UTC)
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 57C2FC433CB;
        Mon, 10 Aug 2020 22:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 57C2FC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v7 07/11] bus: mhi: core: Introduce counters to track MHI device state transitions
Date:   Mon, 10 Aug 2020 15:01:01 -0700
Message-Id: <1597096865-19636-8-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597096865-19636-1-git-send-email-bbhatt@codeaurora.org>
References: <1597096865-19636-1-git-send-email-bbhatt@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use counters to track MHI device state transitions such as those
to M0, M2, or M3 states. This can help in better debug, allowing
the user to see the number of transitions to a certain MHI state
when queried using debugfs entries or via other mechanisms.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/pm.c | 4 ++++
 include/linux/mhi.h       | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index 27bb471..ce4d969 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -256,6 +256,7 @@ int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl)
 		dev_err(dev, "Unable to transition to M0 state\n");
 		return -EIO;
 	}
+	mhi_cntrl->M0++;
 
 	/* Wake up the device */
 	read_lock_bh(&mhi_cntrl->pm_lock);
@@ -326,6 +327,8 @@ void mhi_pm_m1_transition(struct mhi_controller *mhi_cntrl)
 		mhi_cntrl->dev_state = MHI_STATE_M2;
 
 		write_unlock_irq(&mhi_cntrl->pm_lock);
+
+		mhi_cntrl->M2++;
 		wake_up_all(&mhi_cntrl->state_event);
 
 		/* If there are any pending resources, exit M2 immediately */
@@ -362,6 +365,7 @@ int mhi_pm_m3_transition(struct mhi_controller *mhi_cntrl)
 		return -EIO;
 	}
 
+	mhi_cntrl->M3++;
 	wake_up_all(&mhi_cntrl->state_event);
 
 	return 0;
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index a8379b3..d360020 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -328,6 +328,7 @@ struct mhi_controller_config {
  * @dev_state: MHI device state
  * @dev_wake: Device wakeup count
  * @pending_pkts: Pending packets for the controller
+ * @M0, M2, M3: Counters to track number of device MHI state changes
  * @transition_list: List of MHI state transitions
  * @transition_lock: Lock for protecting MHI state transition list
  * @wlock: Lock for protecting device wakeup
@@ -407,6 +408,7 @@ struct mhi_controller {
 	enum mhi_state dev_state;
 	atomic_t dev_wake;
 	atomic_t pending_pkts;
+	u32 M0, M2, M3;
 	struct list_head transition_list;
 	spinlock_t transition_lock;
 	spinlock_t wlock;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

