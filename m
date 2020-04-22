Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FCFC38A30
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 04:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F9F20706
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 04:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="qF6eJpFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgDVEUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 00:20:06 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:29399 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726403AbgDVEUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 00:20:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587529202; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=WIo04m5DvvXhO1a8uko76GWkE9AMVf53ZeZpDgYxOKs=; b=qF6eJpFDO1zhEetQlwXJCVAgeLWCk6QOD++ky3C/afP+jqOJo2ph7OX+8evwO1cNeI6KDgYu
 K1Pha14C5vX4ukOJ1OsB+r+FRbq4wViROqhJ3i+nhXf57hNcjB7y1W7lCBvEo79ljyoUszI/
 KMbIGZMsfjZqnOTWWe658j8TZoE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9fc5e7.7fe344cf5768-smtp-out-n02;
 Wed, 22 Apr 2020 04:19:51 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CFD39C43637; Wed, 22 Apr 2020 04:19:51 +0000 (UTC)
Received: from bbhatt-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 61A18C433BA;
        Wed, 22 Apr 2020 04:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 61A18C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v1 6/8] bus: mhi: core: Return appropriate error codes for AMSS load failure
Date:   Tue, 21 Apr 2020 21:19:33 -0700
Message-Id: <1587529175-27778-7-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1587529175-27778-1-git-send-email-bbhatt@codeaurora.org>
References: <1587529175-27778-1-git-send-email-bbhatt@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When loading AMSS firmware using BHIe protocol, return -ETIMEDOUT if no
response is received within the timeout or return -EIO in case of a
protocol returned failure or an MHI error state.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
---
 drivers/bus/mhi/core/boot.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
index bc70edc..4e49a0e 100644
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
