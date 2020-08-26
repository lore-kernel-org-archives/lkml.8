Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966BDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 03:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CD7F20707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 03:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgHZDEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 23:04:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:19502 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbgHZDEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 23:04:07 -0400
IronPort-SDR: 2jIqBcp3y4W0sLumFVhb/cilxfjFFj3P7t/VL6v34owkoWumzsBAz2twhlaVtJ6/DK+3dHKvhT
 bG9ElVwbh2/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="156218399"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="156218399"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 20:04:05 -0700
IronPort-SDR: vZCSZjAmN1KuXvBvUWo3r2HqIN/RlVKrI6kt6XOFXyb3zAw8dMvvOFV/gjdrdiE8CfeJKr2sLw
 OJqXAvCOklqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="402937427"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 25 Aug 2020 20:04:00 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Serialize IOMMU GCMD register modifications
Date:   Wed, 26 Aug 2020 10:58:25 +0800
Message-Id: <20200826025825.2322-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VT-d spec requires (10.4.4 Global Command Register, GCMD_REG General
Description) that:

If multiple control fields in this register need to be modified, software
must serialize the modifications through multiple writes to this register.

However, in irq_remapping.c, modifications of IRE and CFI are done in one
write. We need to do two separate writes with STS checking after each.

Fixes: af8d102f999a4 ("x86/intel/irq_remapping: Clean up x2apic opt-out security warning mess")
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/irq_remapping.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 9564d23d094f..19d7e18876fe 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -507,12 +507,16 @@ static void iommu_enable_irq_remapping(struct intel_iommu *iommu)
 
 	/* Enable interrupt-remapping */
 	iommu->gcmd |= DMA_GCMD_IRE;
-	iommu->gcmd &= ~DMA_GCMD_CFI;  /* Block compatibility-format MSIs */
 	writel(iommu->gcmd, iommu->reg + DMAR_GCMD_REG);
-
 	IOMMU_WAIT_OP(iommu, DMAR_GSTS_REG,
 		      readl, (sts & DMA_GSTS_IRES), sts);
 
+	/* Block compatibility-format MSIs */
+	iommu->gcmd &= ~DMA_GCMD_CFI;
+	writel(iommu->gcmd, iommu->reg + DMAR_GCMD_REG);
+	IOMMU_WAIT_OP(iommu, DMAR_GSTS_REG,
+		      readl, !(sts & DMA_GSTS_CFIS), sts);
+
 	/*
 	 * With CFI clear in the Global Command register, we should be
 	 * protected from dangerous (i.e. compatibility) interrupts
-- 
2.17.1

