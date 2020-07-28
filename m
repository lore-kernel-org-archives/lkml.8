Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF68C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C0E9207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595956156;
	bh=drzFY1Bjn9Jmo6o8Q37vv3qLVrJCJ/FYL0oLYPswpPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GjE7oPHV+rE9OCKBRyeseYbYetGUXwgjIF1AOh7MW+9Syv9fr4VRmhDBTnTvmcUKE
	 t5kAV8XBFUssSEWfVeJ0ZOHub/n26UKsCOttVJrLVvy77ErJiG2YWdBMPKF6nwZ8mV
	 /kfx8F5G10skYpnoFXY88pUZAXkPHfcwH9xAF/mg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbgG1RJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 13:09:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731510AbgG1RJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:09:13 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 896DF20829;
        Tue, 28 Jul 2020 17:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595956152;
        bh=drzFY1Bjn9Jmo6o8Q37vv3qLVrJCJ/FYL0oLYPswpPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HDQX7NDfUea8PQ/0hXDSjnCKNpNdv8wrQq+4T/lFsUziwoz4UaPmIA+VPrlZJ+uRD
         oPaoWk55haQlQ70UawEEt4SHDgUvEsbDKPxHbB9woQyUDDiZBcRyrWPeP0jY/yiHAC
         Fu8BWv99FyqS14VZ6X+3cgeHrSrVeFftNfidcy/Q=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Rob Clark <robdclark@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/3] iommu: qcom: Drop of_match_ptr to fix -Wunused-const-variable
Date:   Tue, 28 Jul 2020 19:08:59 +0200
Message-Id: <20200728170859.28143-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728170859.28143-1-krzk@kernel.org>
References: <20200728170859.28143-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_device_id is included unconditionally by of.h header and used
in the driver as well.  Remove of_match_ptr to fix W=1 compile test
warning with !CONFIG_OF:

    drivers/iommu/qcom_iommu.c:910:34: warning: 'qcom_iommu_of_match' defined but not used [-Wunused-const-variable=]
      910 | static const struct of_device_id qcom_iommu_of_match[] = {

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/iommu/qcom_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index af6bec3ace00..9535a6af7553 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -752,7 +752,7 @@ static const struct of_device_id ctx_of_match[] = {
 static struct platform_driver qcom_iommu_ctx_driver = {
 	.driver	= {
 		.name		= "qcom-iommu-ctx",
-		.of_match_table	= of_match_ptr(ctx_of_match),
+		.of_match_table	= ctx_of_match,
 	},
 	.probe	= qcom_iommu_ctx_probe,
 	.remove = qcom_iommu_ctx_remove,
@@ -915,7 +915,7 @@ static const struct of_device_id qcom_iommu_of_match[] = {
 static struct platform_driver qcom_iommu_driver = {
 	.driver	= {
 		.name		= "qcom-iommu",
-		.of_match_table	= of_match_ptr(qcom_iommu_of_match),
+		.of_match_table	= qcom_iommu_of_match,
 		.pm		= &qcom_iommu_pm_ops,
 	},
 	.probe	= qcom_iommu_device_probe,
-- 
2.17.1

