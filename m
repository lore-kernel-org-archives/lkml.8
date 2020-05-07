Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1480C47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A14E920838
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588861771;
	bh=b85oKzszIxZ11ye5Qonp+eyp5AgBQc6r/Xa4SbDQhSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NrmHH2HIcXCOVUyO97swAoc/T+AuAEB1qscYEBTaOsMRtF5/9zHKuX3ZZUcd/6cPQ
	 dP79qEJSlZ4cG5+1F4A2gY52mkvgIiO+l8aNP1IXjAi9NuMrq0XwTHfA+p/MCNJKk4
	 oK9dlO8ifYN/2ZohPeF2V1qNsFTyaNW4KwN2i8to=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgEGO3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:29:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728490AbgEGO3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:29:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BCAA2084D;
        Thu,  7 May 2020 14:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588861755;
        bh=b85oKzszIxZ11ye5Qonp+eyp5AgBQc6r/Xa4SbDQhSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kxoeJNypB/bM675jak1pqTPCtcFyZv4A099CnmG25EGLvqkKHnnnKsT2aDsKGW7f1
         K3wdtavh+cPgwdaEd/hbxtsiwydO98225AyPyMvitud25kYKqbFNubCd8OvsSXAMm4
         +BOrn2Lx96q9WtzVhSWBMNRLLM9r7fRbsmdNoeS0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tang Bin <tangbin@cmss.chinamobile.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 35/35] iommu/qcom: Fix local_base status check
Date:   Thu,  7 May 2020 10:28:29 -0400
Message-Id: <20200507142830.26239-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507142830.26239-1-sashal@kernel.org>
References: <20200507142830.26239-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tang Bin <tangbin@cmss.chinamobile.com>

[ Upstream commit b52649aee6243ea661905bdc5fbe28cc5f6dec76 ]

The function qcom_iommu_device_probe() does not perform sufficient
error checking after executing devm_ioremap_resource(), which can
result in crashes if a critical error path is encountered.

Fixes: 0ae349a0f33f ("iommu/qcom: Add qcom_iommu")
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20200418134703.1760-1-tangbin@cmss.chinamobile.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/qcom_iommu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index e0b3fa2bb7ab4..280de92b332ed 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -814,8 +814,11 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 	qcom_iommu->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res)
+	if (res) {
 		qcom_iommu->local_base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(qcom_iommu->local_base))
+			return PTR_ERR(qcom_iommu->local_base);
+	}
 
 	qcom_iommu->iface_clk = devm_clk_get(dev, "iface");
 	if (IS_ERR(qcom_iommu->iface_clk)) {
-- 
2.20.1

