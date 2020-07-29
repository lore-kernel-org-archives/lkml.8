Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C767C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A7062075F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="AldEa3VY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgG2DrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 23:47:03 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:61678 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726751AbgG2DrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 23:47:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595994419; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Up7I/CriwmOnAvRCo5VD/fL2c6xGM0a9cxYx/5GGg1k=; b=AldEa3VY2Iz82dL+fVJ4reSMArWP8W8qZW/iLRgQ9mMr+G4GG0to26rSwMzozI3CmJFf8lhl
 i83yUn6KgmfPCVW9p8zhPU7aNRTIRdagVB1Z8F1H1XULd5kzuA+zgSr04w67937cvCcfPrUP
 8CKwDVcSBzCN0lYiNlZwXDjiyfM=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-east-1.postgun.com with SMTP id
 5f20f124a61bb9e3f525042c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 29 Jul 2020 03:46:44
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CBE0DC433A1; Wed, 29 Jul 2020 03:46:43 +0000 (UTC)
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hemantk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C908C433A0;
        Wed, 29 Jul 2020 03:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C908C433A0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=hemantk@codeaurora.org
From:   Hemant Kumar <hemantk@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] bus: mhi: core: Move MHI_MAX_MTU to external header file
Date:   Tue, 28 Jul 2020 20:46:33 -0700
Message-Id: <1595994395-20143-3-git-send-email-hemantk@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595994395-20143-1-git-send-email-hemantk@codeaurora.org>
References: <1595994395-20143-1-git-send-email-hemantk@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently this macro is defined in internal MHI header as
a TRE length mask. Moving it to external header allows MHI
client drivers to set this upper bound for the transmit
buffer size.

Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
---
 drivers/bus/mhi/core/internal.h | 1 -
 include/linux/mhi.h             | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
index 7989269..4abf0cf 100644
--- a/drivers/bus/mhi/core/internal.h
+++ b/drivers/bus/mhi/core/internal.h
@@ -453,7 +453,6 @@ enum mhi_pm_state {
 #define CMD_EL_PER_RING			128
 #define PRIMARY_CMD_RING		0
 #define MHI_DEV_WAKE_DB			127
-#define MHI_MAX_MTU			0xffff
 #define MHI_RANDOM_U32_NONZERO(bmsk)	(prandom_u32_max(bmsk) + 1)
 
 enum mhi_er_type {
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 6565528..610f3b0 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -16,6 +16,9 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
+/* MHI client drivers to set this upper bound for tx buffer */
+#define MHI_MAX_MTU 0xffff
+
 #define MHI_MAX_OEM_PK_HASH_SEGMENTS 16
 
 struct mhi_chan;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

