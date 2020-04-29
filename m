Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B548DC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94CC3214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgD2Daq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:30:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:53603 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbgD2Dan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:30:43 -0400
IronPort-SDR: DUfdH/P+LSv8Ig52+0bFKAL6V6MGbfu+SRkGAvEgiGSiCH49RmqaDqHHN4EjFKqECH2FAR+rW9
 zSMLVs3KOJNQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 20:30:42 -0700
IronPort-SDR: /rzWIOXv4+dgYsqavHURKVD22MUAw392H4FSOdMyaKGLYmyZ/ulbgEMR455DcMG618GytgWOUB
 ez7lCqzWOvgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,329,1583222400"; 
   d="scan'208";a="432416057"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 28 Apr 2020 20:30:42 -0700
Date:   Tue, 28 Apr 2020 20:36:44 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        Liu Yi L <yi.l.liu@intel.com>, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 3/4] iommu/vt-d: Add page request draining support
Message-ID: <20200428203644.3dcf13f2@jacob-builder>
In-Reply-To: <20200422080611.15689-4-baolu.lu@linux.intel.com>
References: <20200422080611.15689-1-baolu.lu@linux.intel.com>
        <20200422080611.15689-4-baolu.lu@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 16:06:10 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> When a PASID is stopped or terminated, there can be pending PRQs
> (requests that haven't received responses) in remapping hardware.
> This adds the interface to drain page requests and call it when a
> PASID is terminated.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-svm.c   | 103
> ++++++++++++++++++++++++++++++++++-- include/linux/intel-iommu.h |
> 4 ++ 2 files changed, 102 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 83dc4319f661..2534641ef707 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -23,6 +23,7 @@
>  #include "intel-pasid.h"
>  
>  static irqreturn_t prq_event_thread(int irq, void *d);
> +static void intel_svm_drain_prq(struct device *dev, int pasid);
>  
>  #define PRQ_ORDER 0
>  
> @@ -66,6 +67,8 @@ int intel_svm_enable_prq(struct intel_iommu *iommu)
>  	dmar_writeq(iommu->reg + DMAR_PQT_REG, 0ULL);
>  	dmar_writeq(iommu->reg + DMAR_PQA_REG,
> virt_to_phys(iommu->prq) | PRQ_ORDER); 
> +	init_completion(&iommu->prq_complete);
> +
>  	return 0;
>  }
>  
> @@ -208,6 +211,7 @@ static void intel_mm_release(struct mmu_notifier
> *mn, struct mm_struct *mm) rcu_read_lock();
>  	list_for_each_entry_rcu(sdev, &svm->devs, list) {
>  		intel_pasid_tear_down_entry(svm->iommu, sdev->dev,
> svm->pasid);
> +		intel_svm_drain_prq(sdev->dev, svm->pasid);
mmu_notifier release is called in atomic context, drain_prq needs to
wait for completion. I tested exit path when a process crashes. I got

[  +0.696214] BUG: sleeping function called from invalid context at kernel/sched/completion.c:101
[  +0.000068] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3235, name: dsatest
[  +0.000046] INFO: lockdep is turned off.
[  +0.000002] CPU: 1 PID: 3235 Comm: dsatest Not tainted 5.7.0-rc1-z-svmtest+ #1637
[  +0.000000] Hardware name: Intel Corporation Kabylake Client platform/Skylake Halo DDR4 RVP11, BIOS 
04.1709050855 09/05/2017
[  +0.000001] Call Trace:
[  +0.000004]  dump_stack+0x68/0x9b
[  +0.000003]  ___might_sleep+0x229/0x250
[  +0.000003]  wait_for_completion_timeout+0x3c/0x110
[  +0.000003]  intel_svm_drain_prq+0x12f/0x210
[  +0.000003]  intel_mm_release+0x73/0x110
[  +0.000003]  __mmu_notifier_release+0x94/0x220
[  +0.000002]  ? do_munmap+0x10/0x10
[  +0.000002]  ? prepare_ftrace_return+0x5c/0x80
[  +0.000003]  exit_mmap+0x156/0x1a0
[  +0.000002]  ? mmput+0x44/0x120
[  +0.000003]  ? exit_mmap+0x5/0x1a0
[  +0.000002]  ? ftrace_graph_caller+0xa0/0xa0
[  +0.000001]  mmput+0x5e/0x120


>  		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
>  	}
>  	rcu_read_unlock();
> @@ -401,12 +405,8 @@ int intel_svm_unbind_gpasid(struct device *dev,
> int pasid) if (!sdev->users) {
>  			list_del_rcu(&sdev->list);
>  			intel_pasid_tear_down_entry(iommu, dev,
> svm->pasid);
> +			intel_svm_drain_prq(dev, svm->pasid);
>  			intel_flush_svm_range_dev(svm, sdev, 0, -1,
> 0);
> -			/* TODO: Drain in flight PRQ for the PASID
> since it
> -			 * may get reused soon, we don't want to
> -			 * confuse with its previous life.
> -			 * intel_svm_drain_prq(dev, pasid);
> -			 */
>  			kfree_rcu(sdev, rcu);
>  
>  			if (list_empty(&svm->devs)) {
> @@ -644,6 +644,7 @@ int intel_svm_unbind_mm(struct device *dev, int
> pasid)
>  			 * large and has to be physically
> contiguous. So it's
>  			 * hard to be as defensive as we might like.
> */ intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
> +			intel_svm_drain_prq(dev, svm->pasid);
>  			intel_flush_svm_range_dev(svm, sdev, 0, -1,
> 0); kfree_rcu(sdev, rcu);
>  
> @@ -722,6 +723,92 @@ static bool is_canonical_address(u64 addr)
>  	return (((saddr << shift) >> shift) == saddr);
>  }
>  
> +/**
> + * intel_svm_drain_prq:
> + *
> + * Drain all pending page requests and responses related to a
> specific
> + * pasid in both software and hardware.
> + */
> +static void intel_svm_drain_prq(struct device *dev, int pasid)
> +{
> +	struct device_domain_info *info;
> +	struct dmar_domain *domain;
> +	struct intel_iommu *iommu;
> +	struct qi_desc desc[3];
> +	struct pci_dev *pdev;
> +	int head, tail;
> +	u16 sid, did;
> +	int qdep;
> +
> +	info = get_domain_info(dev);
> +	if (WARN_ON(!info || !dev_is_pci(dev)))
> +		return;
> +
> +	if (!info->ats_enabled)
> +		return;
> +
> +	iommu = info->iommu;
> +	domain = info->domain;
> +	pdev = to_pci_dev(dev);
> +	sid = PCI_DEVID(info->bus, info->devfn);
> +	did = domain->iommu_did[iommu->seq_id];
> +	qdep = pci_ats_queue_depth(pdev);
> +
> +	memset(desc, 0, sizeof(desc));
> +	desc[0].qw0 = QI_IWD_STATUS_DATA(QI_DONE) |
> +			QI_IWD_FENCE |
> +			QI_IWD_TYPE;
> +	desc[1].qw0 = QI_EIOTLB_PASID(pasid) |
> +			QI_EIOTLB_DID(did) |
> +			QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
> +			QI_EIOTLB_TYPE;
> +	desc[2].qw0 = QI_DEV_EIOTLB_PASID(pasid) |
> +			QI_DEV_EIOTLB_SID(sid) |
> +			QI_DEV_EIOTLB_QDEP(qdep) |
> +			QI_DEIOTLB_TYPE |
> +			QI_DEV_IOTLB_PFSID(info->pfsid);
> +
> +	/*
> +	 * Submit an invalidation wait descriptor with fence and
> page request
> +	 * drain flags set to invalidation queue. This ensures that
> all requests
> +	 * submitted to the invalidation queue ahead of this wait
> descriptor are
> +	 * processed and completed, and all already issued page
> requests from
> +	 * the device are put in the page request queue.
> +	 */
> +	qi_submit_sync(iommu, desc, 1, QI_OPT_WAIT_DRAIN);
> +
> +	/*
> +	 * Check and wait until all pending page requests in the
> queue are
> +	 * handled by the intr thread.
> +	 */
> +prq_retry:
> +	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
> +	head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
> +	while (head != tail) {
> +		struct page_req_dsc *req;
> +
> +		req = &iommu->prq[head / sizeof(*req)];
> +		if (!req->pasid_present || req->pasid != pasid) {
> +			head = (head + sizeof(*req)) & PRQ_RING_MASK;
> +			continue;
> +		}
> +
> +		wait_for_completion_timeout(&iommu->prq_complete,
> HZ);
> +		goto prq_retry;
> +	}
> +
> +	/*
> +	 * Perform steps described in VT-d spec CH7.10 to drain page
> +	 * requests and responses in hardware.
> +	 */
> +qi_retry:
> +	qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN);
> +	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO) {
> +		wait_for_completion_timeout(&iommu->prq_complete,
> HZ);
> +		goto qi_retry;
> +	}
> +}
> +
>  static irqreturn_t prq_event_thread(int irq, void *d)
>  {
>  	struct intel_iommu *iommu = d;
> @@ -856,6 +943,12 @@ static irqreturn_t prq_event_thread(int irq,
> void *d) }
>  
>  	dmar_writeq(iommu->reg + DMAR_PQH_REG, tail);
> +	/*
> +	 * Clear the page request overflow bit and wake up all
> threads that
> +	 * are waiting for the completion of this handling.
> +	 */
> +	writel(DMA_PRS_PRO, iommu->reg + DMAR_PRS_REG);
> +	complete(&iommu->prq_complete);
>  
>  	return IRQ_RETVAL(handled);
>  }
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index cca1e5f9aeaa..a0512b401a59 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -292,6 +292,8 @@
>  
>  /* PRS_REG */
>  #define DMA_PRS_PPR	((u32)1)
> +#define DMA_PRS_PRO	((u32)2)
> +
>  #define DMA_VCS_PAS	((u64)1)
>  
>  #define IOMMU_WAIT_OP(iommu, offset, op, cond,
> sts)			\ @@ -333,6 +335,7 @@ enum {
>  
>  #define QI_IWD_STATUS_DATA(d)	(((u64)d) << 32)
>  #define QI_IWD_STATUS_WRITE	(((u64)1) << 5)
> +#define QI_IWD_FENCE		(((u64)1) << 6)
>  #define QI_IWD_PRQ_DRAIN	(((u64)1) << 7)
>  
>  #define QI_IOTLB_DID(did) 	(((u64)did) << 16)
> @@ -590,6 +593,7 @@ struct intel_iommu {
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  	struct page_req_dsc *prq;
>  	unsigned char prq_name[16];    /* Name for PRQ interrupt */
> +	struct completion prq_complete;
>  	struct ioasid_allocator_ops pasid_allocator; /* Custom
> allocator for PASIDs */ #endif
>  	struct q_inval  *qi;            /* Queued invalidation info
> */

[Jacob Pan]
