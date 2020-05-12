Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CBAC47255
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 00:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DEF9206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 00:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgELA4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 20:56:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:36642 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbgELA4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 20:56:42 -0400
IronPort-SDR: 8e5jOOibWANDrBGlNsz4BrA22PaOTYEwgFb7l0FR9Yms4/gEe7aVGUa2oVyTRO3h2F0J+3SeZb
 TMM9LNR61jAA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 17:56:42 -0700
IronPort-SDR: NeIDnNh1RruP25dD8zoFnLcJqs0USrcE0cB9VoQkP3AlRPTzjopL4so+I8wFUIBMW0leqvqE+2
 gGl4Bq5LuBdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; 
   d="scan'208";a="286458416"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2020 17:56:39 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        Liu Yi L <yi.l.liu@intel.com>, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 3/5] iommu/vt-d: Disable non-recoverable fault processing before unbind
Date:   Tue, 12 May 2020 08:53:05 +0800
Message-Id: <20200512005307.19860-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512005307.19860-1-baolu.lu@linux.intel.com>
References: <20200512005307.19860-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a PASID is used for SVA by the device, it's possible that the PASID
entry is cleared before the device flushes all ongoing DMA requests. The
IOMMU should tolerate and ignore the non-recoverable faults caused by the
untranslated requests from this device.

For example, when an exception happens, the process terminates before the
device driver stops DMA and call IOMMU driver to unbind PASID. The flow
of process exist is as follows:

do_exit() {
     exit_mm() {
             mm_put();
             exit_mmap() {
                     intel_invalidate_range() //mmu notifier
                     tlb_finish_mmu()
                     mmu_notifier_release(mm) {
                             intel_iommu_release() {
[2]                                  intel_iommu_teardown_pasid();
                                     intel_iommu_flush_tlbs();
                             }
                     }
                     unmap_vmas();
                     free_pgtables();
             };
     }
     exit_files(tsk) {
             close_files() {
                     dsa_close();
[1]                  dsa_stop_dma();
                     intel_svm_unbind_pasid();
             }
     }
}

Care must be taken on VT-d to avoid unrecoverable faults between the time
window of [1] and [2]. [Process exist flow was contributed by Jacob Pan.]

Intel VT-d provides such function through the FPD bit of the PASID entry.
This sets FPD bit when PASID entry is changing from present to nonpresent
in the mm notifier and will clear it when the pasid is unbound.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-iommu.c |  4 ++--
 drivers/iommu/intel-pasid.c | 26 +++++++++++++++++++++-----
 drivers/iommu/intel-pasid.h |  4 +++-
 drivers/iommu/intel-svm.c   |  9 ++++++---
 4 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d1866c0905b1..7811422b5a68 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5352,7 +5352,7 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	if (info->dev) {
 		if (dev_is_pci(info->dev) && sm_supported(iommu))
 			intel_pasid_tear_down_entry(iommu, info->dev,
-					PASID_RID2PASID);
+					PASID_RID2PASID, false);
 
 		iommu_disable_dev_iotlb(info);
 		domain_context_clear(iommu, info->dev);
@@ -5587,7 +5587,7 @@ static void aux_domain_remove_dev(struct dmar_domain *domain,
 	auxiliary_unlink_device(domain, dev);
 
 	spin_lock(&iommu->lock);
-	intel_pasid_tear_down_entry(iommu, dev, domain->default_pasid);
+	intel_pasid_tear_down_entry(iommu, dev, domain->default_pasid, false);
 	domain_detach_iommu(domain, iommu);
 	spin_unlock(&iommu->lock);
 
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 7969e3dac2ad..110b2c2c4cb7 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -292,7 +292,20 @@ static inline void pasid_clear_entry(struct pasid_entry *pe)
 	WRITE_ONCE(pe->val[7], 0);
 }
 
-static void intel_pasid_clear_entry(struct device *dev, int pasid)
+static inline void pasid_clear_entry_with_fpd(struct pasid_entry *pe)
+{
+	WRITE_ONCE(pe->val[0], PASID_PTE_FPD);
+	WRITE_ONCE(pe->val[1], 0);
+	WRITE_ONCE(pe->val[2], 0);
+	WRITE_ONCE(pe->val[3], 0);
+	WRITE_ONCE(pe->val[4], 0);
+	WRITE_ONCE(pe->val[5], 0);
+	WRITE_ONCE(pe->val[6], 0);
+	WRITE_ONCE(pe->val[7], 0);
+}
+
+static void
+intel_pasid_clear_entry(struct device *dev, int pasid, bool fault_ignore)
 {
 	struct pasid_entry *pe;
 
@@ -300,7 +313,10 @@ static void intel_pasid_clear_entry(struct device *dev, int pasid)
 	if (WARN_ON(!pe))
 		return;
 
-	pasid_clear_entry(pe);
+	if (fault_ignore && pasid_pte_is_present(pe))
+		pasid_clear_entry_with_fpd(pe);
+	else
+		pasid_clear_entry(pe);
 }
 
 static inline void pasid_set_bits(u64 *ptr, u64 mask, u64 bits)
@@ -533,8 +549,8 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - VTD_PAGE_SHIFT);
 }
 
-void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
-				 struct device *dev, int pasid)
+void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
+				 int pasid, bool fault_ignore)
 {
 	struct pasid_entry *pte;
 	u16 did;
@@ -544,7 +560,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 		return;
 
 	did = pasid_get_domain_id(pte);
-	intel_pasid_clear_entry(dev, pasid);
+	intel_pasid_clear_entry(dev, pasid, fault_ignore);
 
 	if (!ecap_coherent(iommu->ecap))
 		clflush_cache_range(pte, sizeof(*pte));
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index a41b09b3ffde..c5318d40e0fa 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -15,6 +15,7 @@
 #define PASID_MAX			0x100000
 #define PASID_PTE_MASK			0x3F
 #define PASID_PTE_PRESENT		1
+#define PASID_PTE_FPD			2
 #define PDE_PFN_MASK			PAGE_MASK
 #define PASID_PDE_SHIFT			6
 #define MAX_NR_PASID_BITS		20
@@ -120,7 +121,8 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu,
 			     struct iommu_gpasid_bind_data_vtd *pasid_data,
 			     struct dmar_domain *domain, int addr_width);
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
-				 struct device *dev, int pasid);
+				 struct device *dev, int pasid,
+				 bool fault_ignore);
 int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid);
 void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid);
 #endif /* __INTEL_PASID_H */
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 83dc4319f661..9561ba59a170 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -207,7 +207,8 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdev, &svm->devs, list) {
-		intel_pasid_tear_down_entry(svm->iommu, sdev->dev, svm->pasid);
+		intel_pasid_tear_down_entry(svm->iommu, sdev->dev,
+					    svm->pasid, true);
 		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
 	}
 	rcu_read_unlock();
@@ -400,7 +401,8 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 		sdev->users--;
 		if (!sdev->users) {
 			list_del_rcu(&sdev->list);
-			intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
+			intel_pasid_tear_down_entry(iommu, dev,
+						    svm->pasid, false);
 			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
 			/* TODO: Drain in flight PRQ for the PASID since it
 			 * may get reused soon, we don't want to
@@ -643,7 +645,8 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 			 * to use. We have a *shared* PASID table, because it's
 			 * large and has to be physically contiguous. So it's
 			 * hard to be as defensive as we might like. */
-			intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
+			intel_pasid_tear_down_entry(iommu, dev,
+						    svm->pasid, false);
 			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
 			kfree_rcu(sdev, rcu);
 
-- 
2.17.1

