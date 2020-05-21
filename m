Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE4BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27FDF20826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b4LS6EOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbgEURDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 13:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730162AbgEURDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 13:03:33 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43E5C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:03:32 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m7so3070541plt.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YtxBsNcbjxYaraBBLc9LHB2kflGQYubfrn2EZIQwrU0=;
        b=b4LS6EOrYJ77BRIRZ6pJ5vVyrlCp5wg95KEK1sPqN6gxGXAkd2wcD8TTW8Sek9FQMx
         sfMVFbnlmlsY3Hx25u6yvpu+gsfZ4chiK+7yZgLa9JsZAJFzqQRpSpJDpS0o+JoTXBNV
         IAWRY9VpGrAloV6/qeSMc43R+lc7AToLeDB3tB66THs/JiqNYl6Pxhn1njxW28SkFgFM
         6rFBtTu112DCrhUZ6rO/xcwaDB68P/s7yseyyRUtzKghotL0YAGJRe7DMbhyoRLcRPZ/
         GB3wOapfTdKm1axHODM+BEUa6AjmG5fWCCQYxiAsQJx2+zhkm2ENXCA+5XTbV2bZtegU
         6j6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YtxBsNcbjxYaraBBLc9LHB2kflGQYubfrn2EZIQwrU0=;
        b=kehGygm2q+OEu25l90fu0oFlU++VtMWRmoniAX57j7EMTlCya3wiHxGEA9A+US1vTz
         Bxq86MXPqFxfK2FL2+uzFx2ddAbzwiSikf3cpDqjkuwj0Yj81wkSMNxION4iREUXyqhq
         zowJn+Du3VJ1lB5H14H260jxDzm8tK9ljkH3vnCmgBxUA76Z0rhqUALxQPfwYAeD4G7i
         6GXQGFwkoPylk4l5De4epDolRr5YK0RadpjA4aTcJDIMw96JSWOE3oNjEZvyKiKrAIBf
         H6D4G1LBnnOAfolZTHRVBObJuN23di7EC+3dX2B+bOMcCQA+rSW3XAcfGXVelZAqHacJ
         +fqg==
X-Gm-Message-State: AOAM532l9G5jmvXBhu955L80fBvtYs78uG69LwPqqipl/+eLKNP3quHj
        CdJ/hl5Aj0fjZLP/RMBIgd5B
X-Google-Smtp-Source: ABdhPJz0iOQTtcPaebEEwAJTWKYsd502KMhJzhCJ2v9aWfem8Z1ZcaR1nf+xTbh4u10X9B1luFMBMQ==
X-Received: by 2002:a17:90b:a13:: with SMTP id gg19mr12498675pjb.49.1590080612407;
        Thu, 21 May 2020 10:03:32 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:69f:45f2:3d8d:3719:f568:7ee9])
        by smtp.gmail.com with ESMTPSA id e26sm4874693pff.137.2020.05.21.10.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 10:03:31 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 07/14] bus: mhi: core: Improve debug logs for loading firmware
Date:   Thu, 21 May 2020 22:32:42 +0530
Message-Id: <20200521170249.21795-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521170249.21795-1-manivannan.sadhasivam@linaro.org>
References: <20200521170249.21795-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

Add log messages to track boot flow errors and timeouts in SBL or AMSS
firmware loading to aid in debug.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/boot.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
index cf6dc5a2361c..80e4d7609aaa 100644
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
 
@@ -435,7 +441,12 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
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
@@ -463,8 +474,10 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	if (!mhi_cntrl->fbc_download)
 		return;
 
-	if (ret)
+	if (ret) {
+		dev_err(dev, "MHI did not enter READY state\n");
 		goto error_read;
+	}
 
 	/* Wait for the SBL event */
 	ret = wait_event_timeout(mhi_cntrl->state_event,
@@ -482,6 +495,8 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	ret = mhi_fw_load_amss(mhi_cntrl,
 			       /* Vector table is the last entry */
 			       &image_info->mhi_buf[image_info->entries - 1]);
+	if (ret)
+		dev_err(dev, "MHI did not load AMSS, ret:%d\n", ret);
 
 	release_firmware(firmware);
 
-- 
2.17.1

