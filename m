Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D387EC433F2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6AD920792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="t/Tt3hCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgGWWhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 18:37:10 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:61666 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728189AbgGWWhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 18:37:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595543828; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=V6tQauXNnRZsRCe4EKcmLR9wT3s+aJk+zpsyhH/0h9k=; b=t/Tt3hCG4wPJm88+I6ozMdzBi82w2GHikTm7imBf/BczJP5mkmkN70ECWaJVfZUpmHG+x7PQ
 Rb6DlYSHHlVd+cEfEC2tUaOyPlY/yaa2zGpxf/qgkA9V1072UTxHdhOYH3Btre4dg+JxsugN
 7s4dvE/iQB37nkZhuXtyz3Ui9/A=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-east-1.postgun.com with SMTP id
 5f1a11081e603dbb4451cc0c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 23 Jul 2020 22:36:56
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8BC64C433AD; Thu, 23 Jul 2020 22:36:55 +0000 (UTC)
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E50B8C433CA;
        Thu, 23 Jul 2020 22:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E50B8C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v5 09/10] bus: mhi: core: Read and save device hardware information from BHI
Date:   Thu, 23 Jul 2020 15:36:41 -0700
Message-Id: <1595543802-17859-10-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595543802-17859-1-git-send-email-bbhatt@codeaurora.org>
References: <1595543802-17859-1-git-send-email-bbhatt@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device hardware specific information such as serial number and the OEM
PK hash can be read using BHI and saved on host to identify the
endpoint.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/boot.c | 17 ++++++++++++++++-
 include/linux/mhi.h         |  6 ++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
index 0b38014..24422f5 100644
--- a/drivers/bus/mhi/core/boot.c
+++ b/drivers/bus/mhi/core/boot.c
@@ -392,13 +392,28 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	void *buf;
 	dma_addr_t dma_addr;
 	size_t size;
-	int ret;
+	int i, ret;
 
 	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
 		dev_err(dev, "Device MHI is not in valid state\n");
 		return;
 	}
 
+	/* save hardware info from BHI */
+	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_SERIALNU,
+			   &mhi_cntrl->serial_number);
+	if (ret)
+		dev_err(dev, "Could not capture serial number via BHI\n");
+
+	for (i = 0; i < ARRAY_SIZE(mhi_cntrl->oem_pk_hash); i++) {
+		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_OEMPKHASH(i),
+				   &mhi_cntrl->oem_pk_hash[i]);
+		if (ret) {
+			dev_err(dev, "Could not capture OEM PK HASH via BHI\n");
+			break;
+		}
+	}
+
 	/* If device is in pass through, do reset to ready state transition */
 	if (mhi_cntrl->ee == MHI_EE_PTHRU)
 		goto fw_load_ee_pthru;
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index b1e8b4f..dad6246 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -16,6 +16,8 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
+#define MHI_MAX_OEM_PK_HASH_SEGMENTS 16
+
 struct mhi_chan;
 struct mhi_event;
 struct mhi_ctxt;
@@ -315,6 +317,8 @@ struct mhi_controller_config {
  * @device_number: MHI controller device number
  * @major_version: MHI controller major revision number
  * @minor_version: MHI controller minor revision number
+ * @serial_number: MHI controller serial number obtained from BHI
+ * @oem_pk_hash: MHI controller OEM PK Hash obtained from BHI
  * @mhi_event: MHI event ring configurations table
  * @mhi_cmd: MHI command ring configurations table
  * @mhi_ctxt: MHI device context, shared memory between host and device
@@ -394,6 +398,8 @@ struct mhi_controller {
 	u32 device_number;
 	u32 major_version;
 	u32 minor_version;
+	u32 serial_number;
+	u32 oem_pk_hash[MHI_MAX_OEM_PK_HASH_SEGMENTS];
 
 	struct mhi_event *mhi_event;
 	struct mhi_cmd *mhi_cmd;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

