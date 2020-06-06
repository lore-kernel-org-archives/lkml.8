Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4C8C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 19:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F1A42053B
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 19:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgFFTQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 15:16:22 -0400
Received: from smtprelay0209.hostedemail.com ([216.40.44.209]:46804 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728873AbgFFTQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 15:16:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 1E063180A7FE5;
        Sat,  6 Jun 2020 19:16:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hour66_0a10d3c26dab
X-Filterd-Recvd-Size: 1803
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sat,  6 Jun 2020 19:16:18 +0000 (UTC)
Message-ID: <5a663096b489b86472fe3bfbd5138c411d669bad.camel@perches.com>
Subject: [Possible PATCH] iommu/qcom: Change CONFIG_BIG_ENDIAN to
 CONFIG_CPU_BIG_ENDIAN
From:   Joe Perches <joe@perches.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Sat, 06 Jun 2020 12:16:17 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_BIG_ENDIAN does not exist as a Kconfig symbol.

Signed-off-by: Joe Perches <joe@perches.com>
---

I don't have the hardware, so I can't tell if this is a
correct change, but it is a logical one.

Found by a test script that looks for IS_ENABLED(FOO)
where FOO must also exist in Kconfig files.

 drivers/iommu/qcom_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index c3e1fbd1988c..69e113471ecb 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -304,7 +304,7 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 		      ARM_SMMU_SCTLR_M | ARM_SMMU_SCTLR_S1_ASIDPNE |
 		      ARM_SMMU_SCTLR_CFCFG;
 
-		if (IS_ENABLED(CONFIG_BIG_ENDIAN))
+		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
 			reg |= ARM_SMMU_SCTLR_E;
 
 		iommu_writel(ctx, ARM_SMMU_CB_SCTLR, reg);

