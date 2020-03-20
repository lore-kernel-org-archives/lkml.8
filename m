Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B83C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42462078B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgCTXWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:22:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:42258 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCTXWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:22:02 -0400
IronPort-SDR: kRcmsuzTTFKgTZBd1F1rAFYMVLcuitZAlSYuB0LzdazUJHjtMBlT4lkapr6EaDJqUHhbn5e9Di
 SSgWdeSVB+rQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 16:22:01 -0700
IronPort-SDR: zm8+sqo2Y4c3rylIhy759Oscrl2radw/23Wj1LvZqvMxCGDwCLVpDbxwITPW4onYclC77fAA2Y
 sAvTh6XGuy3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,286,1580803200"; 
   d="scan'208";a="418877227"
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
Subject: [PATCH V10 03/11] iommu/vt-d: Add a helper function to skip agaw
Date:   Fri, 20 Mar 2020 16:27:33 -0700
Message-Id: <1584746861-76386-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-pasid.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 22b30f10b396..191508c7c03e 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -500,6 +500,28 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 }
 
 /*
+ * Skip top levels of page tables for iommu which has less agaw
+ * than default. Unnecessary for PT mode.
+ */
+static inline int iommu_skip_agaw(struct dmar_domain *domain,
+				  struct intel_iommu *iommu,
+				  struct dma_pte **pgd)
+{
+	int agaw;
+
+	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
+		*pgd = phys_to_virt(dma_pte_addr(*pgd));
+		if (!dma_pte_present(*pgd)) {
+			return -EINVAL;
+		}
+	}
+	pr_debug_ratelimited("%s: pgd: %llx, agaw %d d_agaw %d\n", __func__, (u64)*pgd,
+		iommu->agaw, domain->agaw);
+
+	return agaw;
+}
+
+/*
  * Set up the scalable mode pasid entry for second only translation type.
  */
 int intel_pasid_setup_second_level(struct intel_iommu *iommu,
-- 
2.7.4

