Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF2CC55181
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 002AD206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgDUSrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:47:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:22250 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgDUSrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:47:07 -0400
IronPort-SDR: eggzKmniwdjczxwpQmiIbM5jx2cYcM+w/weyIcGUwI0JlyTI9tkh/nHt3/NbjAb6HEZjQ32Eb5
 uq0YKhniBQeg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 11:46:48 -0700
IronPort-SDR: DsiTezOEkjJQB2JMQUi+n1mm62LrxW0smgu6s6BrZtmWO2R/xa/APV55eL/Txf0IB01zK31MCP
 ZQckcVGOCCGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; 
   d="scan'208";a="334367870"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 21 Apr 2020 11:46:48 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Lu Baolu" <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>, Liu@vger.kernel.org
Subject: [PATCH v12 3/8] iommu/vt-d: Add nested translation helper function
Date:   Tue, 21 Apr 2020 11:52:40 -0700
Message-Id: <1587495165-80096-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587495165-80096-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1587495165-80096-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nested translation mode is supported in VT-d 3.0 Spec.CH 3.8.
With PASID granular translation type set to 0x11b, translation
result from the first level(FL) also subject to a second level(SL)
page table translation. This mode is used for SVA virtualization,
where FL performs guest virtual to guest physical translation and
SL performs guest physical to host physical translation.

This patch adds a helper function for setting up nested translation
where second level comes from a domain and first level comes from
a guest PGD.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/intel-iommu.c |  25 -----
 drivers/iommu/intel-pasid.c | 251 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/iommu/intel-pasid.h |  10 ++
 include/linux/intel-iommu.h |  28 +++++
 include/uapi/linux/iommu.h  |   5 +
 5 files changed, 291 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 60c31db9ee93..9c01e391a931 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -296,31 +296,6 @@ static inline void context_clear_entry(struct context_entry *context)
 static struct dmar_domain *si_domain;
 static int hw_pass_through = 1;
 
-/* si_domain contains mulitple devices */
-#define DOMAIN_FLAG_STATIC_IDENTITY		BIT(0)
-
-/*
- * This is a DMA domain allocated through the iommu domain allocation
- * interface. But one or more devices belonging to this domain have
- * been chosen to use a private domain. We should avoid to use the
- * map/unmap/iova_to_phys APIs on it.
- */
-#define DOMAIN_FLAG_LOSE_CHILDREN		BIT(1)
-
-/*
- * When VT-d works in the scalable mode, it allows DMA translation to
- * happen through either first level or second level page table. This
- * bit marks that the DMA translation for the domain goes through the
- * first level page table, otherwise, it goes through the second level.
- */
-#define DOMAIN_FLAG_USE_FIRST_LEVEL		BIT(2)
-
-/*
- * Domain represents a virtual machine which demands iommu nested
- * translation mode support.
- */
-#define DOMAIN_FLAG_NESTING_MODE		BIT(3)
-
 #define for_each_domain_iommu(idx, domain)			\
 	for (idx = 0; idx < g_num_of_iommus; idx++)		\
 		if (domain->iommu_refcnt[idx])
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index d9cea3011b58..becd6cc7f608 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -359,6 +359,76 @@ pasid_set_flpm(struct pasid_entry *pe, u64 value)
 	pasid_set_bits(&pe->val[2], GENMASK_ULL(3, 2), value << 2);
 }
 
+/*
+ * Setup the Extended Memory Type(EMT) field (Bits 91-93)
+ * of a scalable mode PASID entry.
+ */
+static inline void
+pasid_set_emt(struct pasid_entry *pe, u64 value)
+{
+	pasid_set_bits(&pe->val[1], GENMASK_ULL(29, 27), value << 27);
+}
+
+/*
+ * Setup the Page Attribute Table (PAT) field (Bits 96-127)
+ * of a scalable mode PASID entry.
+ */
+static inline void
+pasid_set_pat(struct pasid_entry *pe, u64 value)
+{
+	pasid_set_bits(&pe->val[1], GENMASK_ULL(63, 32), value << 32);
+}
+
+/*
+ * Setup the Cache Disable (CD) field (Bit 89)
+ * of a scalable mode PASID entry.
+ */
+static inline void
+pasid_set_cd(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[1], 1 << 25, 1 << 25);
+}
+
+/*
+ * Setup the Extended Memory Type Enable (EMTE) field (Bit 90)
+ * of a scalable mode PASID entry.
+ */
+static inline void
+pasid_set_emte(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[1], 1 << 26, 1 << 26);
+}
+
+/*
+ * Setup the Extended Access Flag Enable (EAFE) field (Bit 135)
+ * of a scalable mode PASID entry.
+ */
+static inline void
+pasid_set_eafe(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[2], 1 << 7, 1 << 7);
+}
+
+/*
+ * Setup the Page-level Cache Disable (PCD) field (Bit 95)
+ * of a scalable mode PASID entry.
+ */
+static inline void
+pasid_set_pcd(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[1], 1 << 31, 1 << 31);
+}
+
+/*
+ * Setup the Page-level Write-Through (PWT)) field (Bit 94)
+ * of a scalable mode PASID entry.
+ */
+static inline void
+pasid_set_pwt(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[1], 1 << 30, 1 << 30);
+}
+
 static void
 pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
 				    u16 did, int pasid)
@@ -492,7 +562,7 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
 
 	/* Setup Present and PASID Granular Transfer Type: */
-	pasid_set_translation_type(pte, 1);
+	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_FL_ONLY);
 	pasid_set_present(pte);
 	pasid_flush_caches(iommu, pte, pasid, did);
 
@@ -561,7 +631,7 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	pasid_set_domain_id(pte, did);
 	pasid_set_slptr(pte, pgd_val);
 	pasid_set_address_width(pte, agaw);
-	pasid_set_translation_type(pte, 2);
+	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_SL_ONLY);
 	pasid_set_fault_enable(pte);
 	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
 
@@ -595,7 +665,7 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 	pasid_clear_entry(pte);
 	pasid_set_domain_id(pte, did);
 	pasid_set_address_width(pte, iommu->agaw);
-	pasid_set_translation_type(pte, 4);
+	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_PT);
 	pasid_set_fault_enable(pte);
 	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
 
@@ -609,3 +679,178 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 
 	return 0;
 }
+
+static int
+intel_pasid_setup_bind_data(struct intel_iommu *iommu, struct pasid_entry *pte,
+			    struct iommu_gpasid_bind_data_vtd *pasid_data)
+{
+	/*
+	 * Not all guest PASID table entry fields are passed down during bind,
+	 * here we only set up the ones that are dependent on guest settings.
+	 * Execution related bits such as NXE, SMEP are not meaningful to IOMMU,
+	 * therefore not set. Other fields, such as snoop related, are set based
+	 * on host needs regardless of guest settings.
+	 */
+	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_SRE) {
+		if (!ecap_srs(iommu->ecap)) {
+			pr_err_ratelimited("No supervisor request support on %s\n",
+					   iommu->name);
+			return -EINVAL;
+		}
+		pasid_set_sre(pte);
+	}
+
+	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_EAFE) {
+		if (!ecap_eafs(iommu->ecap)) {
+			pr_err_ratelimited("No extended access flag support on %s\n",
+					   iommu->name);
+			return -EINVAL;
+		}
+		pasid_set_eafe(pte);
+	}
+
+	/*
+	 * Memory type is only applicable to devices inside processor coherent
+	 * domain. PCIe devices are not included. We can skip the rest of the
+	 * flags if IOMMU does not support MTS.
+	 */
+	if (!(pasid_data->flags & IOMMU_SVA_VTD_GPASID_MTS_MASK))
+		return 0;
+
+	if (!ecap_mts(iommu->ecap)) {
+		pr_err_ratelimited("No memory type support for bind guest PASID on %s\n",
+				   iommu->name);
+		return -EINVAL;
+	}
+
+	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_EMTE) {
+		pasid_set_emte(pte);
+		pasid_set_emt(pte, pasid_data->emt);
+	}
+	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_PCD)
+		pasid_set_pcd(pte);
+	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_PWT)
+		pasid_set_pwt(pte);
+	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_CD)
+		pasid_set_cd(pte);
+	pasid_set_pat(pte, pasid_data->pat);
+
+	return 0;
+}
+
+/**
+ * intel_pasid_setup_nested() - Set up PASID entry for nested translation.
+ * This could be used for guest shared virtual address. In this case, the
+ * first level page tables are used for GVA-GPA translation in the guest,
+ * second level page tables are used for GPA-HPA translation.
+ *
+ * @iommu:      IOMMU which the device belong to
+ * @dev:        Device to be set up for translation
+ * @gpgd:       FLPTPTR: First Level Page translation pointer in GPA
+ * @pasid:      PASID to be programmed in the device PASID table
+ * @pasid_data: Additional PASID info from the guest bind request
+ * @domain:     Domain info for setting up second level page tables
+ * @addr_width: Address width of the first level (guest)
+ */
+int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
+			     pgd_t *gpgd, int pasid,
+			     struct iommu_gpasid_bind_data_vtd *pasid_data,
+			     struct dmar_domain *domain, int addr_width)
+{
+	struct pasid_entry *pte;
+	struct dma_pte *pgd;
+	int ret = 0;
+	u64 pgd_val;
+	int agaw;
+	u16 did;
+
+	if (!ecap_nest(iommu->ecap)) {
+		pr_err_ratelimited("IOMMU: %s: No nested translation support\n",
+				   iommu->name);
+		return -EINVAL;
+	}
+
+	if (!(domain->flags & DOMAIN_FLAG_NESTING_MODE)) {
+		pr_err_ratelimited("Domain is not in nesting mode, %x\n",
+				   domain->flags);
+		return -EINVAL;
+	}
+
+	pte = intel_pasid_get_entry(dev, pasid);
+	if (WARN_ON(!pte))
+		return -EINVAL;
+
+	/*
+	 * Caller must ensure PASID entry is not in use, i.e. not bind the
+	 * same PASID to the same device twice.
+	 */
+	if (pasid_pte_is_present(pte))
+		return -EBUSY;
+
+	pasid_clear_entry(pte);
+
+	/* Sanity checking performed by caller to make sure address
+	 * width matching in two dimensions:
+	 * 1. CPU vs. IOMMU
+	 * 2. Guest vs. Host.
+	 */
+	switch (addr_width) {
+#ifdef CONFIG_X86
+	case ADDR_WIDTH_5LEVEL:
+		if (cpu_feature_enabled(X86_FEATURE_LA57) &&
+		    cap_5lp_support(iommu->cap)) {
+			pasid_set_flpm(pte, 1);
+		} else {
+			dev_err_ratelimited(dev, "5-level paging not supported\n");
+			return -EINVAL;
+		}
+		break;
+#endif
+	case ADDR_WIDTH_4LEVEL:
+		pasid_set_flpm(pte, 0);
+		break;
+	default:
+		dev_err_ratelimited(dev, "Invalid guest address width %d\n",
+				    addr_width);
+		return -EINVAL;
+	}
+
+	/* First level PGD is in GPA, must be supported by the second level */
+	if ((unsigned long long)gpgd > domain->max_addr) {
+		dev_err_ratelimited(dev,
+				    "Guest PGD %llx not supported, max %llx\n",
+				    (unsigned long long)gpgd, domain->max_addr);
+		return -EINVAL;
+	}
+	pasid_set_flptr(pte, (u64)gpgd);
+
+	ret = intel_pasid_setup_bind_data(iommu, pte, pasid_data);
+	if (ret) {
+		dev_err_ratelimited(dev, "Guest PASID bind data not supported\n");
+		return ret;
+	}
+
+	/* Setup the second level based on the given domain */
+	pgd = domain->pgd;
+
+	agaw = iommu_skip_agaw(domain, iommu, &pgd);
+	if (agaw < 0) {
+		dev_err_ratelimited(dev, "Invalid domain page table\n");
+		return -EINVAL;
+	}
+	pgd_val = virt_to_phys(pgd);
+	pasid_set_slptr(pte, pgd_val);
+	pasid_set_fault_enable(pte);
+
+	did = domain->iommu_did[iommu->seq_id];
+	pasid_set_domain_id(pte, did);
+
+	pasid_set_address_width(pte, agaw);
+	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
+
+	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_NESTED);
+	pasid_set_present(pte);
+	pasid_flush_caches(iommu, pte, pasid, did);
+
+	return ret;
+}
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index 92de6df24ccb..ccd50c2ae75c 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -36,6 +36,7 @@
  * to vmalloc or even module mappings.
  */
 #define PASID_FLAG_SUPERVISOR_MODE	BIT(0)
+#define PASID_FLAG_NESTED		BIT(1)
 
 /*
  * The PASID_FLAG_FL5LP flag Indicates using 5-level paging for first-
@@ -51,6 +52,11 @@ struct pasid_entry {
 	u64 val[8];
 };
 
+#define PASID_ENTRY_PGTT_FL_ONLY	(1)
+#define PASID_ENTRY_PGTT_SL_ONLY	(2)
+#define PASID_ENTRY_PGTT_NESTED		(3)
+#define PASID_ENTRY_PGTT_PT		(4)
+
 /* The representative of a PASID table */
 struct pasid_table {
 	void			*table;		/* pasid table pointer */
@@ -99,6 +105,10 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 				   struct dmar_domain *domain,
 				   struct device *dev, int pasid);
+int intel_pasid_setup_nested(struct intel_iommu *iommu,
+			     struct device *dev, pgd_t *pgd, int pasid,
+			     struct iommu_gpasid_bind_data_vtd *pasid_data,
+			     struct dmar_domain *domain, int addr_width);
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 				 struct device *dev, int pasid);
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index ed7171d2ae1f..6da03f627ba3 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -42,6 +42,9 @@
 #define DMA_FL_PTE_PRESENT	BIT_ULL(0)
 #define DMA_FL_PTE_XD		BIT_ULL(63)
 
+#define ADDR_WIDTH_5LEVEL	(57)
+#define ADDR_WIDTH_4LEVEL	(48)
+
 #define CONTEXT_TT_MULTI_LEVEL	0
 #define CONTEXT_TT_DEV_IOTLB	1
 #define CONTEXT_TT_PASS_THROUGH 2
@@ -480,6 +483,31 @@ struct context_entry {
 	u64 hi;
 };
 
+/* si_domain contains mulitple devices */
+#define DOMAIN_FLAG_STATIC_IDENTITY		BIT(0)
+
+/*
+ * This is a DMA domain allocated through the iommu domain allocation
+ * interface. But one or more devices belonging to this domain have
+ * been chosen to use a private domain. We should avoid to use the
+ * map/unmap/iova_to_phys APIs on it.
+ */
+#define DOMAIN_FLAG_LOSE_CHILDREN		BIT(1)
+
+/*
+ * When VT-d works in the scalable mode, it allows DMA translation to
+ * happen through either first level or second level page table. This
+ * bit marks that the DMA translation for the domain goes through the
+ * first level page table, otherwise, it goes through the second level.
+ */
+#define DOMAIN_FLAG_USE_FIRST_LEVEL		BIT(2)
+
+/*
+ * Domain represents a virtual machine which demands iommu nested
+ * translation mode support.
+ */
+#define DOMAIN_FLAG_NESTING_MODE		BIT(3)
+
 struct dmar_domain {
 	int	nid;			/* node id */
 
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 4ad3496e5c43..e907b7091a46 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -285,6 +285,11 @@ struct iommu_gpasid_bind_data_vtd {
 	__u32 emt;
 };
 
+#define IOMMU_SVA_VTD_GPASID_MTS_MASK	(IOMMU_SVA_VTD_GPASID_CD | \
+					 IOMMU_SVA_VTD_GPASID_EMTE | \
+					 IOMMU_SVA_VTD_GPASID_PCD |  \
+					 IOMMU_SVA_VTD_GPASID_PWT)
+
 /**
  * struct iommu_gpasid_bind_data - Information about device and guest PASID binding
  * @version:	Version of this data structure
-- 
2.7.4

