Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF1FC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 04:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3CD12072E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 04:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgFKEF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 00:05:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:2720 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgFKEFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 00:05:55 -0400
IronPort-SDR: 7WvZCNgXNnrdc/hl5CdNtAshReqWEmbuvsqSKhjTbjqk3p2x07lWv/E7pL85eQv/e7zDLSoP4k
 lox3KSvJo0Og==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 21:05:52 -0700
IronPort-SDR: rBcKN0m/zBL0QanZwGU2OGEGNjdvVgKAtPcsxfzchmZobG0b00WQS6uQpcyAvdT3syq41uc+51
 i7EnAUIUGPSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,498,1583222400"; 
   d="scan'208";a="306804398"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga008.jf.intel.com with ESMTP; 10 Jun 2020 21:05:51 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 3/3] iommu/vt-d: Sanity check uapi argsz filled by users
Date:   Wed, 10 Jun 2020 21:12:15 -0700
Message-Id: <1591848735-12447-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591848735-12447-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1591848735-12447-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOMMU UAPI data has an argsz field which is filled by user. As the data
structures expands, argsz may change. As the UAPI data are shared among
different architectures, extensions of UAPI data could be a result of
one architecture which has no impact on another. Therefore, these argsz
santity checks are performed in the model specific IOMMU drivers. This
patch adds sanity checks in the VT-d to ensure argsz passed by userspace
matches feature flags and other contents.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 16 ++++++++++++++++
 drivers/iommu/intel-svm.c   | 12 ++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 27ebf4b9faef..c98b5109684b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5365,6 +5365,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 	struct device_domain_info *info;
 	struct intel_iommu *iommu;
 	unsigned long flags;
+	unsigned long minsz;
 	int cache_type;
 	u8 bus, devfn;
 	u16 did, sid;
@@ -5385,6 +5386,21 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 	if (!(dmar_domain->flags & DOMAIN_FLAG_NESTING_MODE))
 		return -EINVAL;
 
+	minsz = offsetofend(struct iommu_cache_invalidate_info, padding);
+	if (inv_info->argsz < minsz)
+		return -EINVAL;
+
+	/* Sanity check user filled invalidation dat sizes */
+	if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
+		inv_info->argsz != offsetofend(struct iommu_cache_invalidate_info,
+					addr_info))
+		return -EINVAL;
+
+	if (inv_info->granularity == IOMMU_INV_GRANU_PASID &&
+		inv_info->argsz != offsetofend(struct iommu_cache_invalidate_info,
+					pasid_info))
+		return -EINVAL;
+
 	spin_lock_irqsave(&device_domain_lock, flags);
 	spin_lock(&iommu->lock);
 	info = get_domain_info(dev);
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 35b43fe819ed..64dc2c66dfff 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -235,15 +235,27 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	struct dmar_domain *dmar_domain;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm;
+	unsigned long minsz;
 	int ret = 0;
 
 	if (WARN_ON(!iommu) || !data)
 		return -EINVAL;
 
+	/*
+	 * We mandate that no size change in IOMMU UAPI data before the
+	 * variable size union at the end.
+	 */
+	minsz = offsetofend(struct iommu_gpasid_bind_data, padding);
+	if (data->argsz < minsz)
+		return -EINVAL;
+
 	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
 	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
 		return -EINVAL;
 
+	if (data->argsz != offsetofend(struct iommu_gpasid_bind_data, vtd))
+		return -EINVAL;
+
 	if (!dev_is_pci(dev))
 		return -ENOTSUPP;
 
-- 
2.7.4

