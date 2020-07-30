Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85C0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 00:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E8CA207F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 00:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgG3AOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 20:14:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:33272 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728225AbgG3AOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 20:14:24 -0400
IronPort-SDR: lEqg5LnYcX5iTzxui68tohMnh2MnhWQ3Gb89UkMzoJtYfz94Q9KB7xAO4iRggG+fCKkg2TkjXI
 EaLWdL2z4pfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="152748851"
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; 
   d="scan'208";a="152748851"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 17:14:20 -0700
IronPort-SDR: 0ILJmDgohE/d9exFAy37m6A2IdOQjA+z1isX7wk15sn2vyRYV54jkNNKPkBxSC88ZZujMVw9ve
 2t0Mo+/4oOJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; 
   d="scan'208";a="286680262"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga003.jf.intel.com with ESMTP; 29 Jul 2020 17:14:19 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v7 7/7] iommu/vt-d: Check UAPI data processed by IOMMU core
Date:   Wed, 29 Jul 2020 17:21:07 -0700
Message-Id: <1596068467-49322-8-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596068467-49322-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1596068467-49322-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOMMU generic layer already does sanity checks UAPI data for version
match and argsz range under generic information.
Remove the redundant version check from VT-d driver and check for vendor
specific data size.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 3 +--
 drivers/iommu/intel/svm.c   | 7 +++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 021f62078f52..7e03cca31a0e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5391,8 +5391,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 	int ret = 0;
 	u64 size = 0;
 
-	if (!inv_info || !dmar_domain ||
-	    inv_info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
+	if (!inv_info || !dmar_domain)
 		return -EINVAL;
 
 	if (!dev || !dev_is_pci(dev))
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 713b3a218483..55ea11e9c0f5 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -240,8 +240,11 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	if (WARN_ON(!iommu) || !data)
 		return -EINVAL;
 
-	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
-	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
+	if (data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
+		return -EINVAL;
+
+	/* IOMMU core ensures argsz is more than the start of the union */
+	if (data->argsz < offsetofend(struct iommu_gpasid_bind_data, vendor.vtd))
 		return -EINVAL;
 
 	if (!dev_is_pci(dev))
-- 
2.7.4

