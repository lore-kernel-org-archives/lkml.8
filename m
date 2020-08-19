Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB83C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADBB520B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597859651;
	bh=xQWEIIlwVSrNVIwqxQa97UJ/2LYi1t/KDj5ZfXkSnIM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oqjHMileikGaLpg4TeQ01PpCUYWptjQ4D1rMmTvcrrdYBlLPUQUtZxMWzYcNhcqih
	 H1Uben//L8Cj0xgeU79bVqa5h1OM2cHSBGvVz/sk2dFO802iWLvuTMJseXp2ZeQDxw
	 gEApb9PM+vWjO9QzShl8wcQydSIf8bskpmjfH+q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgHSRyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:54:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgHSRyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 13:54:02 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6510E20882;
        Wed, 19 Aug 2020 17:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597859641;
        bh=xQWEIIlwVSrNVIwqxQa97UJ/2LYi1t/KDj5ZfXkSnIM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Kr++aJx5I/+vnkogrZnmW2Zx+reR+cV0sFSv6uwfYVcPtNuxeqeiCfwoXinQvA5oJ
         EgTrvKHu2z5bIzR4nQUzQQsiT7WGnfZIrAFG6tPJpDHv2oXtZCkn+6Z0yICnIqj3ee
         d2DXfOpa0P2ZYiHK1Qea/WBOabUPysyPM3FivzGs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [RESEND PATCH 3/5] iommu: amd: Fix kerneldoc
Date:   Wed, 19 Aug 2020 19:53:43 +0200
Message-Id: <20200819175345.20833-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819175345.20833-1-krzk@kernel.org>
References: <20200819175345.20833-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 compile warnings (invalid kerneldoc):

    drivers/iommu/amd/init.c:1586: warning: Function parameter or member 'ivrs' not described in 'get_highest_supported_ivhd_type'
    drivers/iommu/amd/init.c:1938: warning: Function parameter or member 'iommu' not described in 'iommu_update_intcapxt'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/iommu/amd/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c652f16eb702..908d8e89764c 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1578,7 +1578,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 
 /**
  * get_highest_supported_ivhd_type - Look up the appropriate IVHD type
- * @ivrs          Pointer to the IVRS header
+ * @ivrs: Pointer to the IVRS header
  *
  * This function search through all IVDB of the maximum supported IVHD
  */
@@ -1929,7 +1929,7 @@ static int iommu_setup_msi(struct amd_iommu *iommu)
 #define XT_INT_VEC(x)		(((x) & 0xFFULL) << 32)
 #define XT_INT_DEST_HI(x)	((((x) >> 24) & 0xFFULL) << 56)
 
-/**
+/*
  * Setup the IntCapXT registers with interrupt routing information
  * based on the PCI MSI capability block registers, accessed via
  * MMIO MSI address low/hi and MSI data registers.
-- 
2.17.1

