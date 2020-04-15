Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B34C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8D6C20771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635967AbgDOJPR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:15:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:41756 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2635933AbgDOJPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:15:12 -0400
IronPort-SDR: EBD5uJb9u73ObVuedsYxVnGXYVeLq18Z4GLb7pHzrPE2DaPjevKao7OXvHYHCqFvVB6b1kIjgu
 V2hs0YUWBiaw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 02:15:12 -0700
IronPort-SDR: G7SxwdTdds52WSaypSBIwb0txoYlVCmAdU3Q55gXABjuRWLpPHTFT+8XhK/ddhPN2Lj+XXr29x
 AX/DVWezkGHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="256800916"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga006.jf.intel.com with ESMTP; 15 Apr 2020 02:15:11 -0700
Received: from fmsmsx121.amr.corp.intel.com (10.18.125.36) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 02:15:11 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx121.amr.corp.intel.com (10.18.125.36) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 02:15:11 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.209]) with mapi id 14.03.0439.000;
 Wed, 15 Apr 2020 17:15:08 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/7] iommu/vt-d: Refactor prq_event_thread()
Thread-Topic: [PATCH v2 4/7] iommu/vt-d: Refactor prq_event_thread()
Thread-Index: AQHWEubRj0OcXUZM5Ue5YsCKNv25uqh55psw
Date:   Wed, 15 Apr 2020 09:15:08 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D820761@SHSMSX104.ccr.corp.intel.com>
References: <20200415052542.30421-1-baolu.lu@linux.intel.com>
 <20200415052542.30421-5-baolu.lu@linux.intel.com>
In-Reply-To: <20200415052542.30421-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, April 15, 2020 1:26 PM
> 
> Move the software processing page request descriptors part from
> prq_event_thread() into a separated function. No any functional
> changes.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-svm.c | 256 ++++++++++++++++++++------------------
>  1 file changed, 135 insertions(+), 121 deletions(-)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 83dc4319f661..a1921b462783 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -722,142 +722,156 @@ static bool is_canonical_address(u64 addr)
>  	return (((saddr << shift) >> shift) == saddr);
>  }
> 
> -static irqreturn_t prq_event_thread(int irq, void *d)
> +static void process_single_prq(struct intel_iommu *iommu,
> +			       struct page_req_dsc *req)
>  {
> -	struct intel_iommu *iommu = d;
> -	struct intel_svm *svm = NULL;
> -	int head, tail, handled = 0;
> -
> -	/* Clear PPR bit before reading head/tail registers, to
> -	 * ensure that we get a new interrupt if needed. */
> -	writel(DMA_PRS_PPR, iommu->reg + DMAR_PRS_REG);
> -
> -	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) &
> PRQ_RING_MASK;
> -	head = dmar_readq(iommu->reg + DMAR_PQH_REG) &
> PRQ_RING_MASK;
> -	while (head != tail) {
> -		struct intel_svm_dev *sdev;
> -		struct vm_area_struct *vma;
> -		struct page_req_dsc *req;
> -		struct qi_desc resp;
> -		int result;
> -		vm_fault_t ret;
> -		u64 address;
> -
> -		handled = 1;
> -
> -		req = &iommu->prq[head / sizeof(*req)];
> +	int result = QI_RESP_FAILURE;
> +	struct intel_svm_dev *sdev;
> +	struct vm_area_struct *vma;
> +	struct intel_svm *svm;
> +	struct qi_desc resp;
> +	vm_fault_t ret;
> +	u64 address;
> +
> +	address = (u64)req->addr << VTD_PAGE_SHIFT;
> +	if (!req->pasid_present) {
> +		pr_err("%s: Page request without PASID: %08llx %08llx\n",
> +		       iommu->name, ((unsigned long long *)req)[0],
> +		       ((unsigned long long *)req)[1]);
> +		goto no_pasid;
> +	}
> 
> -		result = QI_RESP_FAILURE;
> -		address = (u64)req->addr << VTD_PAGE_SHIFT;
> -		if (!req->pasid_present) {
> -			pr_err("%s: Page request without
> PASID: %08llx %08llx\n",
> -			       iommu->name, ((unsigned long long *)req)[0],
> -			       ((unsigned long long *)req)[1]);
> -			goto no_pasid;
> -		}
> +	rcu_read_lock();
> +	svm = ioasid_find(NULL, req->pasid, NULL);
> +	/*
> +	 * It *can't* go away, because the driver is not permitted
> +	 * to unbind the mm while any page faults are outstanding.
> +	 * So we only need RCU to protect the internal idr code.
> +	 */
> +	rcu_read_unlock();
> 
> -		if (!svm || svm->pasid != req->pasid) {
> -			rcu_read_lock();
> -			svm = ioasid_find(NULL, req->pasid, NULL);
> -			/* It *can't* go away, because the driver is not
> permitted
> -			 * to unbind the mm while any page faults are
> outstanding.
> -			 * So we only need RCU to protect the internal idr
> code. */
> -			rcu_read_unlock();
> -			if (IS_ERR_OR_NULL(svm)) {
> -				pr_err("%s: Page request for invalid
> PASID %d: %08llx %08llx\n",
> -				       iommu->name, req->pasid, ((unsigned
> long long *)req)[0],
> -				       ((unsigned long long *)req)[1]);
> -				goto no_pasid;
> -			}
> -		}
> +	if (IS_ERR_OR_NULL(svm)) {
> +		pr_err("%s: Page request for invalid
> PASID %d: %08llx %08llx\n",
> +		       iommu->name, req->pasid, ((unsigned long long *)req)[0],
> +		       ((unsigned long long *)req)[1]);
> +		goto no_pasid;
> +	}
> 
> -		result = QI_RESP_INVALID;
> -		/* Since we're using init_mm.pgd directly, we should never
> take
> -		 * any faults on kernel addresses. */
> -		if (!svm->mm)
> -			goto bad_req;
> +	result = QI_RESP_INVALID;
> +	/* Since we're using init_mm.pgd directly, we should never take
> +	 * any faults on kernel addresses. */
> +	if (!svm->mm)
> +		goto bad_req;
> +
> +	/* If address is not canonical, return invalid response */
> +	if (!is_canonical_address(address))
> +		goto bad_req;
> +
> +	/* If the mm is already defunct, don't handle faults. */
> +	if (!mmget_not_zero(svm->mm))
> +		goto bad_req;
> +
> +	down_read(&svm->mm->mmap_sem);
> +	vma = find_extend_vma(svm->mm, address);
> +	if (!vma || address < vma->vm_start)
> +		goto invalid;
> +
> +	if (access_error(vma, req))
> +		goto invalid;
> +
> +	ret = handle_mm_fault(vma, address,
> +			      req->wr_req ? FAULT_FLAG_WRITE : 0);
> +	if (ret & VM_FAULT_ERROR)
> +		goto invalid;
> +
> +	result = QI_RESP_SUCCESS;
> +invalid:
> +	up_read(&svm->mm->mmap_sem);
> +	mmput(svm->mm);
> +bad_req:
> +	/* Accounting for major/minor faults? */
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(sdev, &svm->devs, list) {
> +		if (sdev->sid == req->rid)
> +			break;
> +	}
> 
> -		/* If address is not canonical, return invalid response */
> -		if (!is_canonical_address(address))
> -			goto bad_req;
> +	/* Other devices can go away, but the drivers are not permitted
> +	 * to unbind while any page faults might be in flight. So it's
> +	 * OK to drop the 'lock' here now we have it. */
> +	rcu_read_unlock();
> 
> -		/* If the mm is already defunct, don't handle faults. */
> -		if (!mmget_not_zero(svm->mm))
> -			goto bad_req;
> +	if (WARN_ON(&sdev->list == &svm->devs))
> +		sdev = NULL;
> 
> -		down_read(&svm->mm->mmap_sem);
> -		vma = find_extend_vma(svm->mm, address);
> -		if (!vma || address < vma->vm_start)
> -			goto invalid;
> +	if (sdev && sdev->ops && sdev->ops->fault_cb) {
> +		int rwxp = (req->rd_req << 3) | (req->wr_req << 2) |
> +			(req->exe_req << 1) | (req->pm_req);
> +		sdev->ops->fault_cb(sdev->dev, req->pasid, req->addr,
> +				    req->priv_data, rwxp, result);
> +	}
> 
> -		if (access_error(vma, req))
> -			goto invalid;
> +	/* We get here in the error case where the PASID lookup failed,
> +	   and these can be NULL. Do not use them below this point! */
> +	sdev = NULL;
> +	svm = NULL;
> +no_pasid:
> +	if (req->lpig || req->priv_data_present) {
> +		/*
> +		 * Per VT-d spec. v3.0 ch7.7, system software must
> +		 * respond with page group response if private data
> +		 * is present (PDP) or last page in group (LPIG) bit
> +		 * is set. This is an additional VT-d feature beyond
> +		 * PCI ATS spec.
> +		 */
> +		resp.qw0 = QI_PGRP_PASID(req->pasid) |
> +			QI_PGRP_DID(req->rid) |
> +			QI_PGRP_PASID_P(req->pasid_present) |
> +			QI_PGRP_PDP(req->pasid_present) |
> +			QI_PGRP_RESP_CODE(result) |
> +			QI_PGRP_RESP_TYPE;
> +		resp.qw1 = QI_PGRP_IDX(req->prg_index) |
> +			QI_PGRP_LPIG(req->lpig);
> +
> +		if (req->priv_data_present)
> +			memcpy(&resp.qw2, req->priv_data,
> +			       sizeof(req->priv_data));
> +		resp.qw2 = 0;
> +		resp.qw3 = 0;
> +		qi_submit_sync(iommu, &resp, 1, 0);
> +	}
> +}
> 
> -		ret = handle_mm_fault(vma, address,
> -				      req->wr_req ? FAULT_FLAG_WRITE : 0);
> -		if (ret & VM_FAULT_ERROR)
> -			goto invalid;
> +static void intel_svm_process_prq(struct intel_iommu *iommu,
> +				  struct page_req_dsc *prq,
> +				  int head, int tail)
> +{
> +	struct page_req_dsc *req;
> 
> -		result = QI_RESP_SUCCESS;
> -	invalid:
> -		up_read(&svm->mm->mmap_sem);
> -		mmput(svm->mm);
> -	bad_req:
> -		/* Accounting for major/minor faults? */
> -		rcu_read_lock();
> -		list_for_each_entry_rcu(sdev, &svm->devs, list) {
> -			if (sdev->sid == req->rid)
> -				break;
> -		}
> -		/* Other devices can go away, but the drivers are not
> permitted
> -		 * to unbind while any page faults might be in flight. So it's
> -		 * OK to drop the 'lock' here now we have it. */
> -		rcu_read_unlock();
> -
> -		if (WARN_ON(&sdev->list == &svm->devs))
> -			sdev = NULL;
> -
> -		if (sdev && sdev->ops && sdev->ops->fault_cb) {
> -			int rwxp = (req->rd_req << 3) | (req->wr_req << 2) |
> -				(req->exe_req << 1) | (req->pm_req);
> -			sdev->ops->fault_cb(sdev->dev, req->pasid, req-
> >addr,
> -					    req->priv_data, rwxp, result);
> -		}
> -		/* We get here in the error case where the PASID lookup
> failed,
> -		   and these can be NULL. Do not use them below this point!
> */
> -		sdev = NULL;
> -		svm = NULL;
> -	no_pasid:
> -		if (req->lpig || req->priv_data_present) {
> -			/*
> -			 * Per VT-d spec. v3.0 ch7.7, system software must
> -			 * respond with page group response if private data
> -			 * is present (PDP) or last page in group (LPIG) bit
> -			 * is set. This is an additional VT-d feature beyond
> -			 * PCI ATS spec.
> -			 */
> -			resp.qw0 = QI_PGRP_PASID(req->pasid) |
> -				QI_PGRP_DID(req->rid) |
> -				QI_PGRP_PASID_P(req->pasid_present) |
> -				QI_PGRP_PDP(req->pasid_present) |
> -				QI_PGRP_RESP_CODE(result) |
> -				QI_PGRP_RESP_TYPE;
> -			resp.qw1 = QI_PGRP_IDX(req->prg_index) |
> -				QI_PGRP_LPIG(req->lpig);
> -
> -			if (req->priv_data_present)
> -				memcpy(&resp.qw2, req->priv_data,
> -				       sizeof(req->priv_data));
> -			resp.qw2 = 0;
> -			resp.qw3 = 0;
> -			qi_submit_sync(iommu, &resp, 1, 0);
> -		}
> +	while (head != tail) {
> +		req = &iommu->prq[head / sizeof(*req)];
> +		process_single_prq(iommu, req);
>  		head = (head + sizeof(*req)) & PRQ_RING_MASK;
>  	}
> +}
> +
> +static irqreturn_t prq_event_thread(int irq, void *d)
> +{
> +	struct intel_iommu *iommu = d;
> +	int head, tail;
> 
> +	/*
> +	 * Clear PPR bit before reading head/tail registers, to
> +	 * ensure that we get a new interrupt if needed.
> +	 */
> +	writel(DMA_PRS_PPR, iommu->reg + DMAR_PRS_REG);
> +
> +	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) &
> PRQ_RING_MASK;
> +	head = dmar_readq(iommu->reg + DMAR_PQH_REG) &
> PRQ_RING_MASK;
> +	intel_svm_process_prq(iommu, iommu->prq, head, tail);
>  	dmar_writeq(iommu->reg + DMAR_PQH_REG, tail);
> 
> -	return IRQ_RETVAL(handled);
> +	return IRQ_RETVAL(1);

this might be a functional change, since previously (0) could
be returned when head==tail.

>  }
> 
>  #define to_intel_svm_dev(handle) container_of(handle, struct
> intel_svm_dev, sva)
> --
> 2.17.1

