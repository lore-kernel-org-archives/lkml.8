Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82A9C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 13:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF31D206F2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 13:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="w0Fu58Le"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgC0N3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 09:29:22 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:22124 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbgC0N3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 09:29:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585315761; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=wk6z8lY+8A26/AMPDqUoidffKFNMBrvM9I+CQYQywl8=; b=w0Fu58LeKwsGD2oP/tfMVWn4stLcMrW09wCBAMJgMwzrruLMsv7p14WbZqzPx2Hkl+iQw8c4
 YAJOeGIf3l+TZvlBurefbwBKe4duZc1df1Wv3Ug+jQPzROxUr/5rYzMV7B0wAsq46+KVFIg+
 i3HWcquKs5M4qhUGh8rv7WwfyEg=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7dffa3.7fec5bd37500-smtp-out-n01;
 Fri, 27 Mar 2020 13:29:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 63EA7C433F2; Fri, 27 Mar 2020 13:29:07 +0000 (UTC)
Received: from blr-ubuntu-311.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 71A98C433D2;
        Fri, 27 Mar 2020 13:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 71A98C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Douglas Anderson <dianders@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH] iommu/arm-smmu: Demote error messages to debug in shutdown callback
Date:   Fri, 27 Mar 2020 18:58:52 +0530
Message-Id: <20200327132852.10352-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on reboot/shutdown, the following messages are
displayed on the console as error messages before the
system reboots/shutdown.

On SC7180:

  arm-smmu 15000000.iommu: removing device with active domains!
  arm-smmu 5040000.iommu: removing device with active domains!

Demote the log level to debug since it does not offer much
help in identifying/fixing any issue as the system is anyways
going down and reduce spamming the kernel log.

Reported-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 16c4b87af42b..0a865e32054a 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2250,7 +2250,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 		return -ENODEV;
 
 	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
-		dev_err(&pdev->dev, "removing device with active domains!\n");
+		dev_dbg(&pdev->dev, "removing device with active domains!\n");
 
 	arm_smmu_bus_init(NULL);
 	iommu_device_unregister(&smmu->iommu);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
