Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF222C3524A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2652067C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgA2F4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:56:49 -0500
Received: from mga02.intel.com ([134.134.136.20]:33109 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbgA2F4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:56:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 21:56:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,376,1574150400"; 
   d="scan'208";a="222346541"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga008.jf.intel.com with ESMTP; 28 Jan 2020 21:56:41 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>, Liu@vger.kernel.org
Subject: [PATCH V9 09/10] iommu/vt-d: Add custom allocator for IOASID
Date:   Tue, 28 Jan 2020 22:01:52 -0800
Message-Id: <1580277713-66934-10-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580277713-66934-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1580277713-66934-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When VT-d driver runs in the guest, PASID allocation must be
performed via virtual command interface. This patch registers a
custom IOASID allocator which takes precedence over the default
XArray based allocator. The resulting IOASID allocation will always
come from the host. This ensures that PASID namespace is system-
wide.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 84 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  2 ++
 2 files changed, 86 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b8aa6479b87f..2f0bf7cc70ce 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1758,6 +1758,9 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 		if (ecap_prs(iommu->ecap))
 			intel_svm_finish_prq(iommu);
 	}
+	if (ecap_vcs(iommu->ecap) && vccap_pasid(iommu->vccap))
+		ioasid_unregister_allocator(&iommu->pasid_allocator);
+
 #endif
 }
 
@@ -3294,6 +3297,84 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 	return ret;
 }
 
+#ifdef CONFIG_INTEL_IOMMU_SVM
+static ioasid_t intel_ioasid_alloc(ioasid_t min, ioasid_t max, void *data)
+{
+	struct intel_iommu *iommu = data;
+	ioasid_t ioasid;
+
+	if (!iommu)
+		return INVALID_IOASID;
+	/*
+	 * VT-d virtual command interface always uses the full 20 bit
+	 * PASID range. Host can partition guest PASID range based on
+	 * policies but it is out of guest's control.
+	 */
+	if (min < PASID_MIN || max > intel_pasid_max_id)
+		return INVALID_IOASID;
+
+	if (vcmd_alloc_pasid(iommu, &ioasid))
+		return INVALID_IOASID;
+
+	return ioasid;
+}
+
+static void intel_ioasid_free(ioasid_t ioasid, void *data)
+{
+	struct intel_iommu *iommu = data;
+
+	if (!iommu)
+		return;
+	/*
+	 * Sanity check the ioasid owner is done at upper layer, e.g. VFIO
+	 * We can only free the PASID when all the devices are unbound.
+	 */
+	if (ioasid_find(NULL, ioasid, NULL)) {
+		pr_alert("Cannot free active IOASID %d\n", ioasid);
+		return;
+	}
+	vcmd_free_pasid(iommu, ioasid);
+}
+
+static void register_pasid_allocator(struct intel_iommu *iommu)
+{
+	/*
+	 * If we are running in the host, no need for custom allocator
+	 * in that PASIDs are allocated from the host system-wide.
+	 */
+	if (!cap_caching_mode(iommu->cap))
+		return;
+
+	if (!sm_supported(iommu)) {
+		pr_warn("VT-d Scalable Mode not enabled, no PASID allocation\n");
+		return;
+	}
+
+	/*
+	 * Register a custom PASID allocator if we are running in a guest,
+	 * guest PASID must be obtained via virtual command interface.
+	 * There can be multiple vIOMMUs in each guest but only one allocator
+	 * is active. All vIOMMU allocators will eventually be calling the same
+	 * host allocator.
+	 */
+	if (ecap_vcs(iommu->ecap) && vccap_pasid(iommu->vccap)) {
+		pr_info("Register custom PASID allocator\n");
+		iommu->pasid_allocator.alloc = intel_ioasid_alloc;
+		iommu->pasid_allocator.free = intel_ioasid_free;
+		iommu->pasid_allocator.pdata = (void *)iommu;
+		if (ioasid_register_allocator(&iommu->pasid_allocator)) {
+			pr_warn("Custom PASID allocator failed, scalable mode disabled\n");
+			/*
+			 * Disable scalable mode on this IOMMU if there
+			 * is no custom allocator. Mixing SM capable vIOMMU
+			 * and non-SM vIOMMU are not supported.
+			 */
+			intel_iommu_sm = 0;
+		}
+	}
+}
+#endif
+
 static int __init init_dmars(void)
 {
 	struct dmar_drhd_unit *drhd;
@@ -3411,6 +3492,9 @@ static int __init init_dmars(void)
 	 */
 	for_each_active_iommu(iommu, drhd) {
 		iommu_flush_write_buffer(iommu);
+#ifdef CONFIG_INTEL_IOMMU_SVM
+		register_pasid_allocator(iommu);
+#endif
 		iommu_set_root_entry(iommu);
 		iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
 		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 0df734db19a9..7955afc1ec94 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -19,6 +19,7 @@
 #include <linux/iommu.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/dmar.h>
+#include <linux/ioasid.h>
 
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -561,6 +562,7 @@ struct intel_iommu {
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	struct page_req_dsc *prq;
 	unsigned char prq_name[16];    /* Name for PRQ interrupt */
+	struct ioasid_allocator_ops pasid_allocator; /* Custom allocator for PASIDs */
 #endif
 	struct q_inval  *qi;            /* Queued invalidation info */
 	u32 *iommu_state; /* Store iommu states between suspend and resume.*/
-- 
2.7.4

