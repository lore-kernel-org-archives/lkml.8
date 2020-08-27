Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2147C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF82920786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgH0GC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 02:02:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:41865 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgH0GC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 02:02:28 -0400
IronPort-SDR: KCIQ06N3G1iaqIsz1JlqMFaujbqplsweBql2jJqV2yDSyCO/TYgXyHwidRjlZUKSJlVMOf1xpw
 P/FPjb/eHIcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="174478312"
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="174478312"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 23:02:28 -0700
IronPort-SDR: g458IpR5q5Fk5w4SrGst7CMiEYyAC/8cVA3zQox3Z5s+/Q4cI2JgieD4dwA5Qt1ej3VyCAJgtN
 EXdHjEoePllQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="403302698"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 26 Aug 2020 23:02:26 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Use device numa domain if RHSA is missing
Date:   Thu, 27 Aug 2020 13:56:40 +0800
Message-Id: <20200827055640.31408-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there are multiple NUMA domains but the RHSA is missing in ACPI/DMAR
table, we could default to the device NUMA domain as fall back. This also
benefits the vIOMMU use case where only a single vIOMMU is exposed, hence
no RHSA will be present but device numa domain can be correct.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e0516d64d7a3..bce158468abf 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -700,12 +700,41 @@ static int domain_update_iommu_superpage(struct dmar_domain *domain,
 	return fls(mask);
 }
 
+static int domain_update_device_node(struct dmar_domain *domain)
+{
+	struct device_domain_info *info;
+	int nid = NUMA_NO_NODE;
+
+	assert_spin_locked(&device_domain_lock);
+
+	if (list_empty(&domain->devices))
+		return NUMA_NO_NODE;
+
+	list_for_each_entry(info, &domain->devices, link) {
+		if (!info->dev)
+			continue;
+
+		nid = dev_to_node(info->dev);
+		if (nid != NUMA_NO_NODE)
+			break;
+	}
+
+	return nid;
+}
+
 /* Some capabilities may be different across iommus */
 static void domain_update_iommu_cap(struct dmar_domain *domain)
 {
 	domain_update_iommu_coherency(domain);
 	domain->iommu_snooping = domain_update_iommu_snooping(NULL);
 	domain->iommu_superpage = domain_update_iommu_superpage(domain, NULL);
+
+	/*
+	 * If RHSA is missing, we should default to the device numa domain
+	 * as fall back.
+	 */
+	if (domain->nid == NUMA_NO_NODE)
+		domain->nid = domain_update_device_node(domain);
 }
 
 struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
@@ -5086,8 +5115,6 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 		if (type == IOMMU_DOMAIN_DMA)
 			intel_init_iova_domain(dmar_domain);
 
-		domain_update_iommu_cap(dmar_domain);
-
 		domain = &dmar_domain->domain;
 		domain->geometry.aperture_start = 0;
 		domain->geometry.aperture_end   =
-- 
2.17.1

