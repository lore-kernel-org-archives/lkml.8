Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920C0C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 683C72084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="HFevCgtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgEGQTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 12:19:51 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:42697 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726701AbgEGQTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:19:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588868391; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=sUMLkHN8s8HSlHYFjwFPv/7eTnfMzsw+sp7Uz/sbxUI=; b=HFevCgtLxVsohDWszmB73jil3DxMEohJyOtVyVqI2YubF51etU8CUQNJetQHQHxuGEhQulXY
 TNGtGGEz81iCuXSOILRIPHIzdFIL6XREvFryzWhRsBC1jtZvqdvT36s+L+2Wv/R8nC9B2WYw
 JWkzCfH/zhvieOD0xEHBo7tXz+s=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb43526.7fbc621d7ca8-smtp-out-n05;
 Thu, 07 May 2020 16:19:50 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2757BC433D2; Thu,  7 May 2020 16:19:50 +0000 (UTC)
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 49755C433F2;
        Thu,  7 May 2020 16:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49755C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org, hemantk@codeaurora.org
Cc:     bbhatt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v4] bus: mhi: core: Handle syserr during power_up
Date:   Thu,  7 May 2020 10:19:31 -0600
Message-Id: <1588868371-8365-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MHI device may be in the syserr state when we attempt to init it in
power_up().  Since we have no local state, the handling is simple -
reset the device and wait for it to transition out of the reset state.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---

v4:
-Implemented Hemant's suggested solution from v2.  The spec will be amended
to indicate the intvec interrupt will be triggered for the reset state change
which matches the current implementations and enables Hemant's solution to
be used, which is cleaner.

 drivers/bus/mhi/core/pm.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index dc83d65..ddef693 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -760,6 +760,7 @@ static void mhi_deassert_dev_wake(struct mhi_controller *mhi_cntrl,
 
 int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
 {
+	enum mhi_state state;
 	enum mhi_ee_type current_ee;
 	enum dev_st_transition next_state;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
@@ -829,6 +830,32 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
 		goto error_bhi_offset;
 	}
 
+	state = mhi_get_mhi_state(mhi_cntrl);
+	if (state == MHI_STATE_SYS_ERR) {
+		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
+		ret = wait_event_timeout(mhi_cntrl->state_event,
+				MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state) ||
+					mhi_read_reg_field(mhi_cntrl,
+							   mhi_cntrl->regs,
+							   MHICTRL,
+							   MHICTRL_RESET_MASK,
+							   MHICTRL_RESET_SHIFT,
+							   &val) ||
+					!val,
+				msecs_to_jiffies(mhi_cntrl->timeout_ms));
+		if (ret) {
+			ret = -EIO;
+			dev_info(dev, "Failed to reset MHI due to syserr state\n");
+			goto error_bhi_offset;
+		}
+
+		/*
+		 * device cleares INTVEC as part of RESET processing,
+		 * re-program it
+		 */
+		mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
+	}
+
 	/* Transition to next state */
 	next_state = MHI_IN_PBL(current_ee) ?
 		DEV_ST_TRANSITION_PBL : DEV_ST_TRANSITION_READY;
-- 
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
