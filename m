Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75257C433E4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 00:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E68120786
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 00:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgGFAaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 20:30:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:32284 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbgGFAaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 20:30:17 -0400
IronPort-SDR: NPdvHupZdy6LTlXOpfTj3g+QDHt5PHC81guSnt/w655XuFNSV9cuiqNShoXQNbMuK5GzFOtQrv
 NXX+uBgIYX9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="212331321"
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="scan'208";a="212331321"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2020 17:30:16 -0700
IronPort-SDR: pHhb659F8hdUQyygF4paG1fQFF39d+fLmMVXuK8ZYni1jiD/59cLm5gbf+fJ+gW9zB75chJyum
 dbaNhrFpuWpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="scan'208";a="266404962"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jul 2020 17:30:14 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux-foundation.org
Cc:     Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 3/4] iommu/vt-d: Report page request faults for guest SVA
Date:   Mon,  6 Jul 2020 08:25:34 +0800
Message-Id: <20200706002535.9381-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706002535.9381-1-baolu.lu@linux.intel.com>
References: <20200706002535.9381-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A pasid might be bound to a page table from a VM guest via the iommu
ops.sva_bind_gpasid. In this case, when a DMA page fault is detected
on the physical IOMMU, we need to inject the page fault request into
the guest. After the guest completes handling the page fault, a page
response need to be sent back via the iommu ops.page_response().

This adds support to report a page request fault. Any external module
which is interested in handling this fault should regiester a notifier
callback.

Co-developed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Co-developed-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 99 ++++++++++++++++++++++++++++++++-------
 1 file changed, 81 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index c23167877b2b..08c58c2b1a06 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -815,6 +815,57 @@ static void intel_svm_drain_prq(struct device *dev, int pasid)
 	}
 }
 
+static int prq_to_iommu_prot(struct page_req_dsc *req)
+{
+	int prot = 0;
+
+	if (req->rd_req)
+		prot |= IOMMU_FAULT_PERM_READ;
+	if (req->wr_req)
+		prot |= IOMMU_FAULT_PERM_WRITE;
+	if (req->exe_req)
+		prot |= IOMMU_FAULT_PERM_EXEC;
+	if (req->pm_req)
+		prot |= IOMMU_FAULT_PERM_PRIV;
+
+	return prot;
+}
+
+static int
+intel_svm_prq_report(struct device *dev, struct page_req_dsc *desc)
+{
+	struct iommu_fault_event event;
+	u8 bus, devfn;
+
+	memset(&event, 0, sizeof(struct iommu_fault_event));
+	bus = PCI_BUS_NUM(desc->rid);
+	devfn = desc->rid & 0xff;
+
+	/* Fill in event data for device specific processing */
+	event.fault.type = IOMMU_FAULT_PAGE_REQ;
+	event.fault.prm.addr = desc->addr;
+	event.fault.prm.pasid = desc->pasid;
+	event.fault.prm.grpid = desc->prg_index;
+	event.fault.prm.perm = prq_to_iommu_prot(desc);
+
+	/*
+	 * Set last page in group bit if private data is present,
+	 * page response is required as it does for LPIG.
+	 */
+	if (desc->lpig)
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
+	if (desc->pasid_present)
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+	if (desc->priv_data_present) {
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA;
+		memcpy(event.fault.prm.private_data, desc->priv_data,
+		       sizeof(desc->priv_data));
+	}
+
+	return iommu_report_device_fault(dev, &event);
+}
+
 static irqreturn_t prq_event_thread(int irq, void *d)
 {
 	struct intel_iommu *iommu = d;
@@ -828,7 +879,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
 	head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
 	while (head != tail) {
-		struct intel_svm_dev *sdev;
+		struct intel_svm_dev *sdev = NULL;
 		struct vm_area_struct *vma;
 		struct page_req_dsc *req;
 		struct qi_desc resp;
@@ -864,6 +915,20 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			}
 		}
 
+		if (!sdev || sdev->sid != req->rid) {
+			struct intel_svm_dev *t;
+
+			sdev = NULL;
+			rcu_read_lock();
+			list_for_each_entry_rcu(t, &svm->devs, list) {
+				if (t->sid == req->rid) {
+					sdev = t;
+					break;
+				}
+			}
+			rcu_read_unlock();
+		}
+
 		result = QI_RESP_INVALID;
 		/* Since we're using init_mm.pgd directly, we should never take
 		 * any faults on kernel addresses. */
@@ -874,6 +939,17 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		if (!is_canonical_address(address))
 			goto bad_req;
 
+		/*
+		 * If prq is to be handled outside iommu driver via receiver of
+		 * the fault notifiers, we skip the page response here.
+		 */
+		if (svm->flags & SVM_FLAG_GUEST_MODE) {
+			if (sdev && !intel_svm_prq_report(sdev->dev, req))
+				goto prq_advance;
+			else
+				goto bad_req;
+		}
+
 		/* If the mm is already defunct, don't handle faults. */
 		if (!mmget_not_zero(svm->mm))
 			goto bad_req;
@@ -892,24 +968,10 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			goto invalid;
 
 		result = QI_RESP_SUCCESS;
-	invalid:
+invalid:
 		mmap_read_unlock(svm->mm);
 		mmput(svm->mm);
-	bad_req:
-		/* Accounting for major/minor faults? */
-		rcu_read_lock();
-		list_for_each_entry_rcu(sdev, &svm->devs, list) {
-			if (sdev->sid == req->rid)
-				break;
-		}
-		/* Other devices can go away, but the drivers are not permitted
-		 * to unbind while any page faults might be in flight. So it's
-		 * OK to drop the 'lock' here now we have it. */
-		rcu_read_unlock();
-
-		if (WARN_ON(&sdev->list == &svm->devs))
-			sdev = NULL;
-
+bad_req:
 		if (sdev && sdev->ops && sdev->ops->fault_cb) {
 			int rwxp = (req->rd_req << 3) | (req->wr_req << 2) |
 				(req->exe_req << 1) | (req->pm_req);
@@ -920,7 +982,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		   and these can be NULL. Do not use them below this point! */
 		sdev = NULL;
 		svm = NULL;
-	no_pasid:
+no_pasid:
 		if (req->lpig || req->priv_data_present) {
 			/*
 			 * Per VT-d spec. v3.0 ch7.7, system software must
@@ -945,6 +1007,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			resp.qw3 = 0;
 			qi_submit_sync(iommu, &resp, 1, 0);
 		}
+prq_advance:
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
 
-- 
2.17.1

