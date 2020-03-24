Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CB7C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E8D2076F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgCXPZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:25:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:19547 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728424AbgCXPZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:25:44 -0400
IronPort-SDR: 5wNT/eGAiVBzJ7VabqLh6tyNvgfRsyjsNTQ8mBeAljQVXOz95Ao/MxFkfih061a6C0e3GZyXIw
 3aCgIfjdMGeQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 08:25:42 -0700
IronPort-SDR: u51fJ+Z0ZBbmP6QCfNUjTvwozWzNupiZsNbkcUKr1KzpRJD7fx4oNvUs51Yhdb4t9Pgc1U+U41
 0MHk6Mh/sONw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,300,1580803200"; 
   d="scan'208";a="325939618"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 24 Mar 2020 08:25:42 -0700
Date:   Tue, 24 Mar 2020 08:31:25 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 1/3] iommu/vt-d: Remove redundant IOTLB flush
Message-ID: <20200324083125.27b78594@jacob-builder>
In-Reply-To: <06c9751a-417d-3c32-65af-0788593f811a@linux.intel.com>
References: <1584678751-43169-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1584678751-43169-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <26ab1917-f087-aafa-e861-6a2478000a6f@linux.intel.com>
        <20200320092047.4a4cf551@jacob-builder>
        <06c9751a-417d-3c32-65af-0788593f811a@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Mar 2020 09:32:45 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> On 2020/3/21 0:20, Jacob Pan wrote:
> > On Fri, 20 Mar 2020 21:45:26 +0800
> > Lu Baolu <baolu.lu@linux.intel.com> wrote:
> >   
> >> On 2020/3/20 12:32, Jacob Pan wrote:  
> >>> IOTLB flush already included in the PASID tear down process. There
> >>> is no need to flush again.  
> >>
> >> It seems that intel_pasid_tear_down_entry() doesn't flush the pasid
> >> based device TLB?
> >>  
> > I saw this code in intel_pasid_tear_down_entry(). Isn't the last
> > line flush the devtlb? Not in guest of course since the passdown
> > tlb flush is inclusive.
> > 
> > 	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
> > 	iotlb_invalidation_with_pasid(iommu, did, pasid);
> > 
> > 	/* Device IOTLB doesn't need to be flushed in caching mode.
> > */ if (!cap_caching_mode(iommu->cap))
> > 		devtlb_invalidation_with_pasid(iommu, dev, pasid);
> >   
> 
> But devtlb_invalidation_with_pasid() doesn't do the right thing, it
> flushes the device tlb, instead of pasid-based device tlb.
> 
Hmm, you are right. But the function name is misleading, pasid argument
is not used, is there a reason why?
This is used for PASID based device IOTLB flush, right?

> static void
> devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
>                                 struct device *dev, int pasid)
> {
>          struct device_domain_info *info;
>          u16 sid, qdep, pfsid;
> 
>          info = dev->archdata.iommu;
>          if (!info || !info->ats_enabled)
>                  return;
> 
>          sid = info->bus << 8 | info->devfn;
>          qdep = info->ats_qdep;
>          pfsid = info->pfsid;
> 
>          qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - 
> VTD_PAGE_SHIFT);
> }
> 
> Best regards,
> baolu
> 
> >> Best regards,
> >> baolu
> >>  
> >>>
> >>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> >>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >>> ---
> >>>    drivers/iommu/intel-svm.c | 6 ++----
> >>>    1 file changed, 2 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> >>> index 8f42d717d8d7..1483f1845762 100644
> >>> --- a/drivers/iommu/intel-svm.c
> >>> +++ b/drivers/iommu/intel-svm.c
> >>> @@ -268,10 +268,9 @@ static void intel_mm_release(struct
> >>> mmu_notifier *mn, struct mm_struct *mm)
> >>>    	 * *has* to handle gracefully without affecting other
> >>> processes. */
> >>>    	rcu_read_lock();
> >>> -	list_for_each_entry_rcu(sdev, &svm->devs, list) {
> >>> +	list_for_each_entry_rcu(sdev, &svm->devs, list)
> >>>    		intel_pasid_tear_down_entry(svm->iommu,
> >>> sdev->dev, svm->pasid);
> >>> -		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
> >>> -	}
> >>> +
> >>>    	rcu_read_unlock();
> >>>    
> >>>    }
> >>> @@ -731,7 +730,6 @@ int intel_svm_unbind_mm(struct device *dev,
> >>> int pasid)
> >>>    			 * large and has to be physically
> >>> contiguous. So it's
> >>>    			 * hard to be as defensive as we might
> >>> like. */ intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
> >>> -			intel_flush_svm_range_dev(svm, sdev, 0,
> >>> -1, 0); kfree_rcu(sdev, rcu);
> >>>    
> >>>    			if (list_empty(&svm->devs)) {
> >>>      
> > 
> > [Jacob Pan]
> >   

[Jacob Pan]
