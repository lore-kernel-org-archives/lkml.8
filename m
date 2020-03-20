Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344AAC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125CF2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgCTXWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:22:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:42259 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbgCTXWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:22:02 -0400
IronPort-SDR: iipT0ZxzD394PgMHsImpWUzAmRyItrA+CFNda8fVVvzPEK1zpwgrGkhnKm489T8FhLIr6N+7OR
 oiTcAZHIQwMw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 16:22:01 -0700
IronPort-SDR: sFqZaL8OHLTqINBQ8R4AfRkHxYiK58VJg4zXN5l0QpKwK2U64koOB4ZwUyF92xUe1eVcokkofF
 i01FrZlFbm6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,286,1580803200"; 
   d="scan'208";a="418877231"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 20 Mar 2020 16:22:01 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Lu Baolu" <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH V10 04/11] iommu/vt-d: Use helper function to skip agaw for SL
Date:   Fri, 20 Mar 2020 16:27:34 -0700
Message-Id: <1584746861-76386-5-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-pasid.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 191508c7c03e..9bdb7ee228b6 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -544,17 +544,11 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 		return -EINVAL;
 	}
 
-	/*
-	 * Skip top levels of page tables for iommu which has less agaw
-	 * than default. Unnecessary for PT mode.
-	 */
 	pgd = domain->pgd;
-	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
-		pgd = phys_to_virt(dma_pte_addr(pgd));
-		if (!dma_pte_present(pgd)) {
-			dev_err(dev, "Invalid domain page table\n");
-			return -EINVAL;
-		}
+	agaw = iommu_skip_agaw(domain, iommu, &pgd);
+	if (agaw < 0) {
+		dev_err(dev, "Invalid domain page table\n");
+		return -EINVAL;
 	}
 
 	pgd_val = virt_to_phys(pgd);
-- 
2.7.4

