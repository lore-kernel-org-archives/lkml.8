Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC45C47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2BCE2073B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="sv+t2rmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbgEEWrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 18:47:43 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:43612 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728737AbgEEWrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 18:47:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588718860; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=7hzUwGmWRl05YfEuRakRYnz0izFE+MkI9+t81/uGOUo=; b=sv+t2rmh8oVe4BCTbwNKbCMYg0Y/OT6j1xO7780oUbHremDYKFDD4eGKNQRSPey3Odb7hxCn
 jYu8R8/If6u8VzqZk4FBKCru9o2FdHzFanwdlo2UjnUM4uyYvvlXYIr6tB39f76eJvZbObgu
 iM3ZogFBm8zB5Su06+TDONUuavU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb1ecfb.7f88f64b2340-smtp-out-n01;
 Tue, 05 May 2020 22:47:23 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 72480C433BA; Tue,  5 May 2020 22:47:23 +0000 (UTC)
Received: from bbhatt-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B48FEC433D2;
        Tue,  5 May 2020 22:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B48FEC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     mani@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantk@codeaurora.org, jhugo@codeaurora.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v6 6/8] bus: mhi: core: Return appropriate error codes for AMSS load failure
Date:   Tue,  5 May 2020 15:47:10 -0700
Message-Id: <1588718832-4891-7-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1588718832-4891-1-git-send-email-bbhatt@codeaurora.org>
References: <1588718832-4891-1-git-send-email-bbhatt@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When loading AMSS firmware using BHIe protocol, return -ETIMEDOUT if no
response is received within the timeout or return -EIO in case of a
protocol returned failure or an MHI error state.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/bus/mhi/core/boot.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
index 17c636b..05627fe 100644
--- a/drivers/bus/mhi/core/boot.c
+++ b/drivers/bus/mhi/core/boot.c
@@ -176,6 +176,7 @@ static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
 	void __iomem *base = mhi_cntrl->bhie;
 	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
 	u32 tx_status, sequence_id;
+	int ret;
 
 	read_lock_bh(pm_lock);
 	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
@@ -198,19 +199,19 @@ static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
 	read_unlock_bh(pm_lock);
 
 	/* Wait for the image download to complete */
-	wait_event_timeout(mhi_cntrl->state_event,
-			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
-			   mhi_read_reg_field(mhi_cntrl, base,
-					      BHIE_TXVECSTATUS_OFFS,
-					      BHIE_TXVECSTATUS_STATUS_BMSK,
-					      BHIE_TXVECSTATUS_STATUS_SHFT,
-					      &tx_status) || tx_status,
-			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
-
-	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
+				 mhi_read_reg_field(mhi_cntrl, base,
+						    BHIE_TXVECSTATUS_OFFS,
+						   BHIE_TXVECSTATUS_STATUS_BMSK,
+						   BHIE_TXVECSTATUS_STATUS_SHFT,
+						    &tx_status) || tx_status,
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
+	    tx_status != BHIE_TXVECSTATUS_STATUS_XFER_COMPL)
 		return -EIO;
 
-	return (tx_status == BHIE_TXVECSTATUS_STATUS_XFER_COMPL) ? 0 : -EIO;
+	return (!ret) ? -ETIMEDOUT : 0;
 }
 
 static int mhi_fw_load_sbl(struct mhi_controller *mhi_cntrl,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
