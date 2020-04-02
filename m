Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39318C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B74F20678
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389255AbgDBUWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 16:22:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:4431 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbgDBUWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:22:19 -0400
IronPort-SDR: qA7e+AS07UAnIiiQU0SKbQmSN8c7Gujy/2WM//rBv+yxkXIKqA8aJthJU5vLoV/TxUQ3nfz8Hd
 8DAo9nyYUCsw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 13:22:18 -0700
IronPort-SDR: 1UaY7sL5a+H2oJS3MZJ+4iwnYVSq9S14rLCavgetdbkLYNjRD1pFQQzmCgVWYWPYCBlRty+SBP
 sCWVHutzgVOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="268138483"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 02 Apr 2020 13:22:18 -0700
Date:   Thu, 2 Apr 2020 13:28:06 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Jonathan Cameron" <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH V10 11/11] iommu/vt-d: Add custom allocator for IOASID
Message-ID: <20200402132806.49421237@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D805FAF@SHSMSX104.ccr.corp.intel.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1584746861-76386-12-git-send-email-jacob.jun.pan@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7FA146@SHSMSX104.ccr.corp.intel.com>
        <20200401084759.575b38c4@jacob-builder>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D805FAF@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Apr 2020 02:18:45 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Wednesday, April 1, 2020 11:48 PM
> > 
> > On Sat, 28 Mar 2020 10:22:41 +0000
> > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >   
> > > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > Sent: Saturday, March 21, 2020 7:28 AM
> > > >
> > > > When VT-d driver runs in the guest, PASID allocation must be
> > > > performed via virtual command interface. This patch registers a
> > > > custom IOASID allocator which takes precedence over the default
> > > > XArray based allocator. The resulting IOASID allocation will
> > > > always come from the host. This ensures that PASID namespace is
> > > > system- wide.
> > > >
> > > > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > > Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> > > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > ---
> > > >  drivers/iommu/intel-iommu.c | 84
> > > > +++++++++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/intel-iommu.h |  2 ++
> > > >  2 files changed, 86 insertions(+)
> > > >
> > > > diff --git a/drivers/iommu/intel-iommu.c
> > > > b/drivers/iommu/intel-iommu.c index a76afb0fd51a..c1c0b0fb93c3
> > > > 100644 --- a/drivers/iommu/intel-iommu.c
> > > > +++ b/drivers/iommu/intel-iommu.c
> > > > @@ -1757,6 +1757,9 @@ static void free_dmar_iommu(struct  
> > intel_iommu  
> > > > *iommu)
> > > >  		if (ecap_prs(iommu->ecap))
> > > >  			intel_svm_finish_prq(iommu);
> > > >  	}
> > > > +	if (ecap_vcs(iommu->ecap) && vccap_pasid(iommu->vccap))
> > > > +
> > > > ioasid_unregister_allocator(&iommu->pasid_allocator); +
> > > >  #endif
> > > >  }
> > > >
> > > > @@ -3291,6 +3294,84 @@ static int copy_translation_tables(struct
> > > > intel_iommu *iommu)
> > > >  	return ret;
> > > >  }
> > > >
> > > > +#ifdef CONFIG_INTEL_IOMMU_SVM
> > > > +static ioasid_t intel_ioasid_alloc(ioasid_t min, ioasid_t max,
> > > > void *data)  
> > >
> > > the name is too generic... can we add vcmd in the name to clarify
> > > its purpose, e.g. intel_vcmd_ioasid_alloc?
> > >  
> > I feel the intel_ prefix is a natural extension of a generic API,
> > we do that for other IOMMU APIs, right?  
> 
> other IOMMU APIs have no difference between host and guest, but
> this one only applies to guest with vcmd interface. 
> 
OK, sounds good. It is more explicit, improves readability.

> >   
> > > > +{
> > > > +	struct intel_iommu *iommu = data;
> > > > +	ioasid_t ioasid;
> > > > +
> > > > +	if (!iommu)
> > > > +		return INVALID_IOASID;
> > > > +	/*
> > > > +	 * VT-d virtual command interface always uses the full
> > > > 20 bit
> > > > +	 * PASID range. Host can partition guest PASID range
> > > > based on
> > > > +	 * policies but it is out of guest's control.
> > > > +	 */
> > > > +	if (min < PASID_MIN || max > intel_pasid_max_id)
> > > > +		return INVALID_IOASID;
> > > > +
> > > > +	if (vcmd_alloc_pasid(iommu, &ioasid))
> > > > +		return INVALID_IOASID;
> > > > +
> > > > +	return ioasid;
> > > > +}
> > > > +
> > > > +static void intel_ioasid_free(ioasid_t ioasid, void *data)
> > > > +{
> > > > +	struct intel_iommu *iommu = data;
> > > > +
> > > > +	if (!iommu)
> > > > +		return;
> > > > +	/*
> > > > +	 * Sanity check the ioasid owner is done at upper
> > > > layer, e.g. VFIO
> > > > +	 * We can only free the PASID when all the devices are
> > > > unbound.
> > > > +	 */
> > > > +	if (ioasid_find(NULL, ioasid, NULL)) {
> > > > +		pr_alert("Cannot free active IOASID %d\n",
> > > > ioasid);
> > > > +		return;
> > > > +	}  
> > >
> > > However the sanity check is not done in default_free. Is there a
> > > reason why using vcmd adds such  new requirement?
> > >  
> > Since we don't support nested guest. This vcmd allocator is only
> > used by the guest IOMMU driver not VFIO. We expect IOMMU driver to
> > have control of the free()/unbind() ordering.
> > 
> > For default_free, it can come from user space and host VFIO which
> > can be out of order. But we will solve that issue with the blocking
> > notifier.
> >   
> > > > +	vcmd_free_pasid(iommu, ioasid);
> > > > +}
> > > > +
> > > > +static void register_pasid_allocator(struct intel_iommu *iommu)
> > > > +{
> > > > +	/*
> > > > +	 * If we are running in the host, no need for custom
> > > > allocator
> > > > +	 * in that PASIDs are allocated from the host
> > > > system-wide.
> > > > +	 */
> > > > +	if (!cap_caching_mode(iommu->cap))
> > > > +		return;  
> > >
> > > is it more accurate to check against vcmd capability?
> > >  
> > I think this is sufficient. The spec says if vcmd is present, we
> > must use it but not the other way.  
> 
> No, what about an vIOMMU implementation reports CM but not
> VCMD?
> I didn't get the rationale why we check an indirect capability
> when there is already one well defined for the purpose.
> 
We _do_ check ecap_vcs() later on. Just an ordering thing, my thinking
was a quick check if we are running in a host.
...
	if (ecap_vcs(iommu->ecap) && vccap_pasid(iommu->vccap)) {

> >   
>  [...]  
> > >
> > > which one? the first or last?
> > >  
> > All allocators share the same ops, so first=last. IOASID code will
> > inspect the ops function and see if they are shared with others then
> > use the same ops.  
> 
> ok, got you.
> 
> >   
>  [...]  
> > >
> > > since you register an allocator for every vIOMMU, means previously
> > > registered allocators should also be unregistered here?
> > >  
>  [...]  
> > > > +		}
> > > > +	}
> > > > +}
> > > > +#endif
> > > > +
> > > >  static int __init init_dmars(void)
> > > >  {
> > > >  	struct dmar_drhd_unit *drhd;
> > > > @@ -3408,6 +3489,9 @@ static int __init init_dmars(void)
> > > >  	 */
> > > >  	for_each_active_iommu(iommu, drhd) {
> > > >  		iommu_flush_write_buffer(iommu);
> > > > +#ifdef CONFIG_INTEL_IOMMU_SVM
> > > > +		register_pasid_allocator(iommu);
> > > > +#endif
> > > >  		iommu_set_root_entry(iommu);
> > > >  		iommu->flush.flush_context(iommu, 0, 0, 0,
> > > > DMA_CCMD_GLOBAL_INVL);
> > > >  		iommu->flush.flush_iotlb(iommu, 0, 0, 0,
> > > > DMA_TLB_GLOBAL_FLUSH);
> > > > diff --git a/include/linux/intel-iommu.h
> > > > b/include/linux/intel-iommu.h index 9cbf5357138b..9c357a325c72
> > > > 100644 --- a/include/linux/intel-iommu.h
> > > > +++ b/include/linux/intel-iommu.h
> > > > @@ -19,6 +19,7 @@
> > > >  #include <linux/iommu.h>
> > > >  #include <linux/io-64-nonatomic-lo-hi.h>
> > > >  #include <linux/dmar.h>
> > > > +#include <linux/ioasid.h>
> > > >
> > > >  #include <asm/cacheflush.h>
> > > >  #include <asm/iommu.h>
> > > > @@ -563,6 +564,7 @@ struct intel_iommu {
> > > >  #ifdef CONFIG_INTEL_IOMMU_SVM
> > > >  	struct page_req_dsc *prq;
> > > >  	unsigned char prq_name[16];    /* Name for PRQ
> > > > interrupt */
> > > > +	struct ioasid_allocator_ops pasid_allocator; /* Custom
> > > > allocator for PASIDs */
> > > >  #endif
> > > >  	struct q_inval  *qi;            /* Queued invalidation
> > > > info */ u32 *iommu_state; /* Store iommu states between suspend
> > > > and resume.*/
> > > > --
> > > > 2.7.4  
> > >  
> > 
> > [Jacob Pan]  

[Jacob Pan]
