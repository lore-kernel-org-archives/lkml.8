Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD9BC433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 11:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B98A20663
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 11:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="qTNJgXII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgFGLJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 07:09:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:45309 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgFGLJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 07:09:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591528185; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=/hsbFOuqSBY+VZzRO8uUfNPtY30KTsN27zx5uQIR8g0=; b=qTNJgXIIJHvdm3JLCgZaVZdNAVUHCLHAitZc4UI2kMUGnasVN3ZBoQvtK9/L73D/Z2CvCxf1
 Cl3yaJHl6KDsZmcyXNBtPdSmDVSLG9pMMBziWGwZFqBgEvCERHsKB8RM0Rf27XCFhmfEZkbJ
 MG0wGZeTzGQtJi39l6eWZVzCA4Q=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5edccae8f1889e857a9ad789 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 07 Jun 2020 11:09:28
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EEC45C43395; Sun,  7 Jun 2020 11:09:27 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BEA0BC433CA;
        Sun,  7 Jun 2020 11:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BEA0BC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [RFC PATCH] iommu/arm-smmu: Remove shutdown callback
Date:   Sun,  7 Jun 2020 16:39:18 +0530
Message-Id: <20200607110918.1733-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove SMMU shutdown callback since it seems to cause more
problems than benefits. With this callback, we need to make
sure that all clients/consumers of SMMU do not perform any
DMA activity once the SMMU is shutdown and translation is
disabled. In other words we need to add shutdown callbacks
for all those clients to make sure they do not perform any
DMA or else we see all kinds of weird crashes during reboot
or shutdown. This is clearly not scalable as the number of
clients of SMMU would vary across SoCs and we would need to
add shutdown callbacks to almost all drivers eventually.
This callback was added for kexec usecase where it was known
to cause memory corruptions when SMMU was not shutdown but
that does not directly relate to SMMU because the memory
corruption could be because of the client of SMMU which is
not shutdown properly before booting into new kernel. So in
that case, we need to identify the client of SMMU causing
the memory corruption and add appropriate shutdown callback
to the client rather than to the SMMU.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 drivers/iommu/arm-smmu-v3.c | 6 ------
 drivers/iommu/arm-smmu.c    | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 8a908c50c306..634da02fef78 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -4142,11 +4142,6 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static void arm_smmu_device_shutdown(struct platform_device *pdev)
-{
-	arm_smmu_device_remove(pdev);
-}
-
 static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v3", },
 	{ },
@@ -4161,7 +4156,6 @@ static struct platform_driver arm_smmu_driver = {
 	},
 	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
-	.shutdown = arm_smmu_device_shutdown,
 };
 module_platform_driver(arm_smmu_driver);
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 243bc4cb2705..4d80516c789f 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2276,11 +2276,6 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static void arm_smmu_device_shutdown(struct platform_device *pdev)
-{
-	arm_smmu_device_remove(pdev);
-}
-
 static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
 {
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
@@ -2335,7 +2330,6 @@ static struct platform_driver arm_smmu_driver = {
 	},
 	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
-	.shutdown = arm_smmu_device_shutdown,
 };
 module_platform_driver(arm_smmu_driver);
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

