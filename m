Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAF3C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 02:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF69F206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 02:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="rGUFcPHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgD1C7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 22:59:48 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:13991 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726344AbgD1C7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 22:59:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588042785; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=/U7ZQNKlwzyc95nZ/adQCEBsp8bMii9uKS4aK6zQ5T8=; b=rGUFcPHdNxX2i0kgG6eyoIcPMCuN7auN4PUW3R+8zMZaOoRkl5ms3gNXs7uvfOBaSQQoR1YR
 Orpy0pYzNGQlnFKFQpcs8HpDOKOwNtFGJiyuC4Q5/dkbG70A+Mpc3ZNh6/JPzjmkIRQHZCgU
 93Rf/9VA0uMpLhC9cYo69SzSFs0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea79c20.7f38d7ee9d88-smtp-out-n01;
 Tue, 28 Apr 2020 02:59:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 56464C433BA; Tue, 28 Apr 2020 02:59:43 +0000 (UTC)
Received: from bbhatt-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 05E7AC44791;
        Tue, 28 Apr 2020 02:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 05E7AC44791
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     mani@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantk@codeaurora.org, Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v2 7/8] bus: mhi: core: Improve debug logs for loading firmware
Date:   Mon, 27 Apr 2020 19:59:25 -0700
Message-Id: <1588042766-17496-8-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1588042766-17496-1-git-send-email-bbhatt@codeaurora.org>
References: <1588042766-17496-1-git-send-email-bbhatt@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add log messages to track boot flow errors and timeouts in SBL or AMSS
firmware loading to aid in debug.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
---
 drivers/bus/mhi/core/boot.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
index 4e49a0e..0bc9c50 100644
--- a/drivers/bus/mhi/core/boot.c
+++ b/drivers/bus/mhi/core/boot.c
@@ -121,7 +121,8 @@ static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
 		ee = mhi_get_exec_env(mhi_cntrl);
 	}
 
-	dev_dbg(dev, "Waiting for image download completion, current EE: %s\n",
+	dev_dbg(dev,
+		"Waiting for RDDM image download via BHIe, current EE:%s\n",
 		TO_MHI_EXEC_STR(ee));
 
 	while (retry--) {
@@ -152,11 +153,14 @@ static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
 int mhi_download_rddm_img(struct mhi_controller *mhi_cntrl, bool in_panic)
 {
 	void __iomem *base = mhi_cntrl->bhie;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	u32 rx_status;
 
 	if (in_panic)
 		return __mhi_download_rddm_in_panic(mhi_cntrl);
 
+	dev_dbg(dev, "Waiting for RDDM image download via BHIe\n");
+
 	/* Wait for the image download to complete */
 	wait_event_timeout(mhi_cntrl->state_event,
 			   mhi_read_reg_field(mhi_cntrl, base,
@@ -174,6 +178,7 @@ static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
 			    const struct mhi_buf *mhi_buf)
 {
 	void __iomem *base = mhi_cntrl->bhie;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
 	u32 tx_status, sequence_id;
 	int ret;
@@ -184,6 +189,7 @@ static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
 		return -EIO;
 	}
 
+	dev_dbg(dev, "Starting AMSS download via BHIe\n");
 	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECADDR_HIGH_OFFS,
 		      upper_32_bits(mhi_buf->dma_addr));
 
@@ -441,7 +447,12 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 		release_firmware(firmware);
 
 	/* Error or in EDL mode, we're done */
-	if (ret || mhi_cntrl->ee == MHI_EE_EDL)
+	if (ret) {
+		dev_err(dev, "MHI did not load SBL, ret:%d\n", ret);
+		return;
+	}
+
+	if (mhi_cntrl->ee == MHI_EE_EDL)
 		return;
 
 	write_lock_irq(&mhi_cntrl->pm_lock);
@@ -469,8 +480,10 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	if (!mhi_cntrl->fbc_download)
 		return;
 
-	if (ret)
+	if (ret) {
+		dev_err(dev, "MHI did not enter READY state\n");
 		goto error_read;
+	}
 
 	/* Wait for the SBL event */
 	ret = wait_event_timeout(mhi_cntrl->state_event,
@@ -488,6 +501,8 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	ret = mhi_fw_load_amss(mhi_cntrl,
 			       /* Vector table is the last entry */
 			       &image_info->mhi_buf[image_info->entries - 1]);
+	if (ret)
+		dev_err(dev, "MHI did not load AMSS, ret:%d\n", ret);
 
 	release_firmware(firmware);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
