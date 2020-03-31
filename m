Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE69C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A532D2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgCaSHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:07:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:33654 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgCaSHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:07:48 -0400
IronPort-SDR: +uYI2S+0MWbulGgf++UdKu7lpjo6izDTegNJNcsgKUuEDy8o1jDdKw5QqwPAoI4p0qavond3L/
 e1PltMl3k6dw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 11:07:45 -0700
IronPort-SDR: ozOR1wTx35jy3xePHpo2X4YB7CrAIhtAh1QTgWOqa6Y0rCeaKkXTXay4rRTx9Hg9601LpVFg0x
 mT0fE66ihrXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,328,1580803200"; 
   d="scan'208";a="252329911"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga006.jf.intel.com with ESMTP; 31 Mar 2020 11:07:45 -0700
Date:   Tue, 31 Mar 2020 11:13:32 -0700
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
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH V10 08/11] iommu/vt-d: Add svm/sva invalidate function
Message-ID: <20200331111332.0718ffd2@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7FA0AB@SHSMSX104.ccr.corp.intel.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1584746861-76386-9-git-send-email-jacob.jun.pan@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7FA0AB@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Mar 2020 10:01:42 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Saturday, March 21, 2020 7:28 AM
> > 
> > When Shared Virtual Address (SVA) is enabled for a guest OS via
> > vIOMMU, we need to provide invalidation support at IOMMU API and
> > driver level. This patch adds Intel VT-d specific function to
> > implement iommu passdown invalidate API for shared virtual address.
> > 
> > The use case is for supporting caching structure invalidation
> > of assigned SVM capable devices. Emulated IOMMU exposes queue  
> 
> emulated IOMMU -> vIOMMU, since virito-iommu could use the
> interface as well.
> 
True, but it does not invalidate this statement about emulated IOMMU. I
will add another statement saying "the same interface can be used for
virtio-IOMMU as well". OK?

> > invalidation capability and passes down all descriptors from the
> > guest to the physical IOMMU.
> > 
> > The assumption is that guest to host device ID mapping should be
> > resolved prior to calling IOMMU driver. Based on the device handle,
> > host IOMMU driver can replace certain fields before submit to the
> > invalidation queue.
> > 
> > ---
> > v7 review fixed in v10
> > ---
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> > ---
> >  drivers/iommu/intel-iommu.c | 182
> > ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 182 insertions(+)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index b1477cd423dd..a76afb0fd51a
> > 100644 --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -5619,6 +5619,187 @@ static void
> > intel_iommu_aux_detach_device(struct iommu_domain *domain,
> >  	aux_domain_remove_dev(to_dmar_domain(domain), dev);
> >  }
> > 
> > +/*
> > + * 2D array for converting and sanitizing IOMMU generic TLB
> > granularity to
> > + * VT-d granularity. Invalidation is typically included in the
> > unmap operation
> > + * as a result of DMA or VFIO unmap. However, for assigned devices
> > guest
> > + * owns the first level page tables. Invalidations of translation
> > caches in the
> > + * guest are trapped and passed down to the host.
> > + *
> > + * vIOMMU in the guest will only expose first level page tables,
> > therefore
> > + * we do not include IOTLB granularity for request without PASID
> > (second level).  
> 
> I would revise above as "We do not support IOTLB granularity for
> request without PASID (second level), therefore any vIOMMU
> implementation that exposes the SVA capability to the guest should
> only expose the first level page tables, implying all invalidation
> requests from the guest will include a valid PASID"
> 
Sounds good.

> > + *
> > + * For example, to find the VT-d granularity encoding for IOTLB
> > + * type and page selective granularity within PASID:
> > + * X: indexed by iommu cache type
> > + * Y: indexed by enum iommu_inv_granularity
> > + * [IOMMU_CACHE_INV_TYPE_IOTLB][IOMMU_INV_GRANU_ADDR]
> > + *
> > + * Granu_map array indicates validity of the table. 1: valid, 0:
> > invalid
> > + *
> > + */
> > +const static int
> > inv_type_granu_map[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV_GRANU_
> > NR] = {
> > +	/*
> > +	 * PASID based IOTLB invalidation: PASID selective (per
> > PASID),
> > +	 * page selective (address granularity)
> > +	 */
> > +	{0, 1, 1},
> > +	/* PASID based dev TLBs, only support all PASIDs or single
> > PASID */
> > +	{1, 1, 0},  
> 
> Is this combination correct? when single PASID is being specified, it
> is essentially a page-selective invalidation since you need provide
> Address and Size. 
> 
This is for translation between generic UAPI granu to VT-d granu, it
has nothing to do with address and size.
e.g.
If user passes IOMMU_INV_GRANU_PASID for the single PASID case as you
mentioned, this map table shows it is valid.

Then the lookup result will get VT-d granu:
QI_DEV_IOTLB_GRAN_PASID_SEL, which means G=0.


> > +	/* PASID cache */  
> 
> PASID cache is fully managed by the host. Guest PASID cache
> invalidation is interpreted by vIOMMU for bind and unbind operations.
> I don't think we should accept any PASID cache invalidation from
> userspace or guest.
> 

True for vIOMMU, this is here for completeness. Can be used by virtio
IOMMU, since PC flush is inclusive (IOTLB, devTLB), it is more
efficient.

> > +	{1, 1, 0}
> > +};
> > +
> > +const static int
> > inv_type_granu_table[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV_GRANU
> > _NR] = {
> > +	/* PASID based IOTLB */
> > +	{0, QI_GRAN_NONG_PASID, QI_GRAN_PSI_PASID},
> > +	/* PASID based dev TLBs */
> > +	{QI_DEV_IOTLB_GRAN_ALL, QI_DEV_IOTLB_GRAN_PASID_SEL, 0},
> > +	/* PASID cache */
> > +	{QI_PC_ALL_PASIDS, QI_PC_PASID_SEL, 0},
> > +};
> > +
> > +static inline int to_vtd_granularity(int type, int granu, int
> > *vtd_granu) +{
> > +	if (type >= IOMMU_CACHE_INV_TYPE_NR || granu >=
> > IOMMU_INV_GRANU_NR ||
> > +		!inv_type_granu_map[type][granu])
> > +		return -EINVAL;
> > +
> > +	*vtd_granu = inv_type_granu_table[type][granu];
> > +  
> 
> btw do we really need both map and table here? Can't we just
> use one table with unsupported granularity marked as a special
> value?
> 
Yes, for value = 1. e.g. G=0 but still valid.

> > +	return 0;
> > +}
> > +
> > +static inline u64 to_vtd_size(u64 granu_size, u64 nr_granules)
> > +{
> > +	u64 nr_pages = (granu_size * nr_granules) >>
> > VTD_PAGE_SHIFT; +
> > +	/* VT-d size is encoded as 2^size of 4K pages, 0 for 4k, 9
> > for 2MB, etc.
> > +	 * IOMMU cache invalidate API passes granu_size in bytes,
> > and number of
> > +	 * granu size in contiguous memory.
> > +	 */
> > +	return order_base_2(nr_pages);
> > +}
> > +
> > +#ifdef CONFIG_INTEL_IOMMU_SVM
> > +static int intel_iommu_sva_invalidate(struct iommu_domain *domain,
> > +		struct device *dev, struct
> > iommu_cache_invalidate_info *inv_info)
> > +{
> > +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> > +	struct device_domain_info *info;
> > +	struct intel_iommu *iommu;
> > +	unsigned long flags;
> > +	int cache_type;
> > +	u8 bus, devfn;
> > +	u16 did, sid;
> > +	int ret = 0;
> > +	u64 size = 0;
> > +
> > +	if (!inv_info || !dmar_domain ||
> > +		inv_info->version !=
> > IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
> > +		return -EINVAL;
> > +
> > +	if (!dev || !dev_is_pci(dev))
> > +		return -ENODEV;
> > +
> > +	iommu = device_to_iommu(dev, &bus, &devfn);
> > +	if (!iommu)
> > +		return -ENODEV;
> > +
> > +	spin_lock_irqsave(&device_domain_lock, flags);
> > +	spin_lock(&iommu->lock);
> > +	info = iommu_support_dev_iotlb(dmar_domain, iommu, bus,
> > devfn);
> > +	if (!info) {
> > +		ret = -EINVAL;
> > +		goto out_unlock;  
> 
> -ENOTSUPP?
> 
I guess it can go either way in that the error is based on invalid
inputs.

> > +	}
> > +	did = dmar_domain->iommu_did[iommu->seq_id];
> > +	sid = PCI_DEVID(bus, devfn);
> > +
> > +	/* Size is only valid in non-PASID selective invalidation
> > */
> > +	if (inv_info->granularity != IOMMU_INV_GRANU_PASID)
> > +		size =
> > to_vtd_size(inv_info->addr_info.granule_size,
> > +
> > inv_info->addr_info.nb_granules); +
> > +	for_each_set_bit(cache_type, (unsigned long
> > *)&inv_info->cache, IOMMU_CACHE_INV_TYPE_NR) {
> > +		int granu = 0;
> > +		u64 pasid = 0;
> > +
> > +		ret = to_vtd_granularity(cache_type,
> > inv_info->granularity, &granu);
> > +		if (ret) {
> > +			pr_err("Invalid cache type and granu
> > combination %d/%d\n", cache_type,
> > +				inv_info->granularity);
> > +			break;
> > +		}
> > +
> > +		/* PASID is stored in different locations based on
> > granularity */
> > +		if (inv_info->granularity == IOMMU_INV_GRANU_PASID
> > &&
> > +			inv_info->pasid_info.flags &
> > IOMMU_INV_PASID_FLAGS_PASID)
> > +			pasid = inv_info->pasid_info.pasid;
> > +		else if (inv_info->granularity ==
> > IOMMU_INV_GRANU_ADDR &&
> > +			inv_info->addr_info.flags &
> > IOMMU_INV_ADDR_FLAGS_PASID)
> > +			pasid = inv_info->addr_info.pasid;
> > +		else {
> > +			pr_err("Cannot find PASID for given cache
> > type and granularity\n");
> > +			break;
> > +		}
> > +
> > +		switch (BIT(cache_type)) {
> > +		case IOMMU_CACHE_INV_TYPE_IOTLB:
> > +			if ((inv_info->granularity !=
> > IOMMU_INV_GRANU_PASID) &&  
> 
> granularity == IOMMU_INV_GRANU_ADDR? otherwise it's unclear
> why IOMMU_INV_GRANU_DOMAIN also needs size check.
> 
Good point! will fix.

> > +				size && (inv_info->addr_info.addr &
> > ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
> > +				pr_err("Address out of range,
> > 0x%llx, size order %llu\n",
> > +					inv_info->addr_info.addr,
> > size);
> > +				ret = -ERANGE;
> > +				goto out_unlock;
> > +			}
> > +
> > +			qi_flush_piotlb(iommu, did,
> > +					pasid,
> > +					mm_to_dma_pfn(inv_info-  
> > >addr_info.addr),  
> > +					(granu ==
> > QI_GRAN_NONG_PASID) ? - 1 : 1 << size,
> > +					inv_info->addr_info.flags &
> > IOMMU_INV_ADDR_FLAGS_LEAF);
> > +
> > +			/*
> > +			 * Always flush device IOTLB if ATS is
> > enabled since guest
> > +			 * vIOMMU exposes CM = 1, no device IOTLB
> > flush will be passed
> > +			 * down.
> > +			 */  
> 
> Does VT-d spec mention that no device IOTLB flush is required when
> CM=1?
> 
Not explicitly. Just following the guideline in CH6.1 for efficient
virtualization. Early on, we also had discussion on supporting virtio
where IOTLB flush is inclusive.
Let me rephrase the comment:
/*
 * Always flush device IOTLB if ATS is enabled. vIOMMU
 * in the guest may assume IOTLB flush is inclusive,
 * which is more efficient.
 */


> > +			if (info->ats_enabled) {
> > +				qi_flush_dev_iotlb_pasid(iommu,
> > sid, info-  
> > >pfsid,  
> > +						pasid,
> > info->ats_qdep,
> > +
> > inv_info->addr_info.addr, size,
> > +						granu);
> > +			}
> > +			break;
> > +		case IOMMU_CACHE_INV_TYPE_DEV_IOTLB:
> > +			if (info->ats_enabled) {
> > +				qi_flush_dev_iotlb_pasid(iommu,
> > sid, info-  
> > >pfsid,  
> > +
> > inv_info->addr_info.pasid, info->ats_qdep,
> > +
> > inv_info->addr_info.addr, size,
> > +						granu);  
> 
> I'm confused here. There are two granularities allowed for devtlb,
> but here you only handle one of them?
> 
granu is passed into the flush function, which can be 1 or 0.

> > +			} else
> > +				pr_warn("Passdown device IOTLB
> > flush w/o ATS!\n");
> > +
> > +			break;
> > +		case IOMMU_CACHE_INV_TYPE_PASID:
> > +			qi_flush_pasid_cache(iommu, did, granu,
> > inv_info-  
> > >pasid_info.pasid);  
> > +  
> 
> as earlier comment, we shouldn't allow userspace or guest to
> invalidate PASID cache
> 
same explanation :)

> > +			break;
> > +		default:
> > +			dev_err(dev, "Unsupported IOMMU
> > invalidation type %d\n",
> > +				cache_type);
> > +			ret = -EINVAL;
> > +		}
> > +	}
> > +out_unlock:
> > +	spin_unlock(&iommu->lock);
> > +	spin_unlock_irqrestore(&device_domain_lock, flags);
> > +
> > +	return ret;
> > +}
> > +#endif
> > +
> >  static int intel_iommu_map(struct iommu_domain *domain,
> >  			   unsigned long iova, phys_addr_t hpa,
> >  			   size_t size, int iommu_prot, gfp_t gfp)
> > @@ -6204,6 +6385,7 @@ const struct iommu_ops intel_iommu_ops = {
> >  	.is_attach_deferred	=
> > intel_iommu_is_attach_deferred, .pgsize_bitmap		=
> > INTEL_IOMMU_PGSIZES, #ifdef CONFIG_INTEL_IOMMU_SVM
> > +	.cache_invalidate	= intel_iommu_sva_invalidate,
> >  	.sva_bind_gpasid	= intel_svm_bind_gpasid,
> >  	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
> >  #endif
> > --
> > 2.7.4  
> 

[Jacob Pan]
