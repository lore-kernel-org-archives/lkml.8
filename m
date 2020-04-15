Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F51C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 885952078B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389925AbgDOF3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 01:29:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:30113 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407966AbgDOF3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 01:29:13 -0400
IronPort-SDR: 7sKv+fdyfWmA9l2ujVoAqyvQHK4I3VupdYSGWmB9UcHoniQ/uk2xYcD/y2BMWndR+S1yRoa5Cg
 X+bH6hKo3Xbg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 22:29:11 -0700
IronPort-SDR: OvGXTUQb+261zgqu8bzjekwJmZRxO24/QbIUFrvkzaQne/dE1loragWUFJmhevrzmCZiLCO0zI
 h2g10tL18iCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,385,1580803200"; 
   d="scan'208";a="277504218"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 14 Apr 2020 22:29:09 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        Liu Yi L <yi.l.liu@intel.com>, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 5/7] iommu/vt-d: Save prq descriptors in an internal list
Date:   Wed, 15 Apr 2020 13:25:40 +0800
Message-Id: <20200415052542.30421-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200415052542.30421-1-baolu.lu@linux.intel.com>
References: <20200415052542.30421-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the page request interrupt thread handles the page
requests in the queue in this way:

- Clear PPR bit to ensure new interrupt could come in;
- Read and record the head and tail registers;
- Handle all descriptors between head and tail;
- Write tail to head register.

This might cause some descriptors to be handles multiple times.
An example sequence:

- Thread A got scheduled with PRQ_1 and PRQ_2 in the queue;
- Thread A clear the PPR bit and record the head and tail;
- A new PRQ_3 comes and Thread B gets scheduled;
- Thread B record the head and tail which includes PRQ_1
  and PRQ_2.

As the result, PRQ_1 and PRQ_2 are handled twice in Thread_A and
Thread_B.

       Thread_A            Thread_B
      .--------.          .--------.
      |        |          |        |
      .--------.          .--------.
  head| PRQ_1  |      head| PRQ_1  |
      .--------.          .--------.
      | PRQ_2  |          | PRQ_2  |
      .--------.          .--------.
  tail|        |          | PRQ_3  |
      .--------.          .--------.
      |        |      tail|        |
      '--------'          '--------'

To avoid this, probably, we need to apply a spinlock to ensure
that PRQs are handled in a serialized way. But that means the
intel_svm_process_prq() will be called with a spinlock held.
This causes extra complexities in intel_svm_process_prq().

This aims to make PRQ descriptors to be handled in a serialized
way while remove the requirement of holding the spin lock in
intel_svm_process_prq() by saving the descriptors in a list.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-svm.c   | 58 ++++++++++++++++++++++++++++++-------
 include/linux/intel-iommu.h |  2 ++
 2 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index a1921b462783..05aeb8ea51c4 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -50,6 +50,8 @@ int intel_svm_enable_prq(struct intel_iommu *iommu)
 		return ret;
 	}
 	iommu->pr_irq = irq;
+	INIT_LIST_HEAD(&iommu->prq_list);
+	spin_lock_init(&iommu->prq_lock);
 
 	snprintf(iommu->prq_name, sizeof(iommu->prq_name), "dmar%d-prq", iommu->seq_id);
 
@@ -698,6 +700,14 @@ struct page_req_dsc {
 
 #define PRQ_RING_MASK	((0x1000 << PRQ_ORDER) - 0x20)
 
+struct page_req {
+	struct list_head list;
+	struct page_req_dsc desc;
+	unsigned int processing:1;
+	unsigned int drained:1;
+	unsigned int completed:1;
+};
+
 static bool access_error(struct vm_area_struct *vma, struct page_req_dsc *req)
 {
 	unsigned long requested = 0;
@@ -842,34 +852,60 @@ static void process_single_prq(struct intel_iommu *iommu,
 	}
 }
 
-static void intel_svm_process_prq(struct intel_iommu *iommu,
-				  struct page_req_dsc *prq,
-				  int head, int tail)
+static void intel_svm_process_prq(struct intel_iommu *iommu)
 {
-	struct page_req_dsc *req;
-
-	while (head != tail) {
-		req = &iommu->prq[head / sizeof(*req)];
-		process_single_prq(iommu, req);
-		head = (head + sizeof(*req)) & PRQ_RING_MASK;
+	struct page_req *req;
+	unsigned long flags;
+
+	spin_lock_irqsave(&iommu->prq_lock, flags);
+	while (!list_empty(&iommu->prq_list)) {
+		req = list_first_entry(&iommu->prq_list, struct page_req, list);
+		if (!req->processing) {
+			req->processing = true;
+			spin_unlock_irqrestore(&iommu->prq_lock, flags);
+			process_single_prq(iommu, &req->desc);
+			spin_lock_irqsave(&iommu->prq_lock, flags);
+			req->completed = true;
+		} else if (req->completed) {
+			list_del(&req->list);
+			kfree(req);
+		} else {
+			break;
+		}
 	}
+	spin_unlock_irqrestore(&iommu->prq_lock, flags);
 }
 
 static irqreturn_t prq_event_thread(int irq, void *d)
 {
 	struct intel_iommu *iommu = d;
+	unsigned long flags;
 	int head, tail;
 
+	spin_lock_irqsave(&iommu->prq_lock, flags);
 	/*
 	 * Clear PPR bit before reading head/tail registers, to
 	 * ensure that we get a new interrupt if needed.
 	 */
 	writel(DMA_PRS_PPR, iommu->reg + DMAR_PRS_REG);
-
 	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
 	head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
-	intel_svm_process_prq(iommu, iommu->prq, head, tail);
+	while (head != tail) {
+		struct page_req_dsc *dsc;
+		struct page_req *req;
+
+		dsc = &iommu->prq[head / sizeof(*dsc)];
+		req = kzalloc(sizeof (*req), GFP_ATOMIC);
+		if (!req)
+			break;
+		req->desc = *dsc;
+		list_add_tail(&req->list, &iommu->prq_list);
+		head = (head + sizeof(*dsc)) & PRQ_RING_MASK;
+	}
 	dmar_writeq(iommu->reg + DMAR_PQH_REG, tail);
+	spin_unlock_irqrestore(&iommu->prq_lock, flags);
+
+	intel_svm_process_prq(iommu);
 
 	return IRQ_RETVAL(1);
 }
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index cca1e5f9aeaa..80715a59491c 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -590,6 +590,8 @@ struct intel_iommu {
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	struct page_req_dsc *prq;
 	unsigned char prq_name[16];    /* Name for PRQ interrupt */
+	struct list_head prq_list;	/* pending page request list */
+	spinlock_t prq_lock;		/* protect above pending list */
 	struct ioasid_allocator_ops pasid_allocator; /* Custom allocator for PASIDs */
 #endif
 	struct q_inval  *qi;            /* Queued invalidation info */
-- 
2.17.1

