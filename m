Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59119C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF7E206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgBUTIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 14:08:46 -0500
Received: from mga11.intel.com ([192.55.52.93]:30776 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbgBUTIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 14:08:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 11:08:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,469,1574150400"; 
   d="scan'208";a="383546855"
Received: from jacob-xps-13-9365.jf.intel.com (HELO jacob-XPS-13-9365) ([10.54.75.153])
  by orsmga004.jf.intel.com with ESMTP; 21 Feb 2020 11:08:44 -0800
Date:   Fri, 21 Feb 2020 11:08:52 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH V9 06/10] iommu/vt-d: Add svm/sva invalidate function
Message-ID: <20200221110852.536531fd@jacob-XPS-13-9365>
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A1C629C@SHSMSX104.ccr.corp.intel.com>
References: <1580277713-66934-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1580277713-66934-7-git-send-email-jacob.jun.pan@linux.intel.com>
        <A2975661238FB949B60364EF0F2C25743A1C629C@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 06:34:35 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Wednesday, January 29, 2020 2:02 PM
> > Subject: [PATCH V9 06/10] iommu/vt-d: Add svm/sva invalidate
> > function
> > 
> > When Shared Virtual Address (SVA) is enabled for a guest OS via
> > vIOMMU, we need to provide invalidation support at IOMMU API and
> > driver level. This patch adds Intel VT-d specific function to
> > implement iommu passdown invalidate API for shared virtual address.
> > 
> > The use case is for supporting caching structure invalidation of
> > assigned SVM capable devices. Emulated IOMMU exposes queue
> > invalidation capability and passes down all descriptors from the
> > guest to the physical IOMMU.
> > 
> > The assumption is that guest to host device ID mapping should be
> > resolved prior to calling IOMMU driver. Based on the device handle,
> > host IOMMU driver can replace certain fields before submit to the
> > invalidation queue.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>  
> 
> May be update my  email to Liu Yi L <yi.l.liu@intel.com> :-)
> @linux.intel.com account no more work for me.  :-(
> 
Will do. Thanks.
> > ---
> >  drivers/iommu/intel-iommu.c | 173
> > ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 173 insertions(+)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index 8a4136e805ac..b8aa6479b87f
> > 100644 --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -5605,6 +5605,178 @@ static void
> > intel_iommu_aux_detach_device(struct iommu_domain *domain,
> >  	aux_domain_remove_dev(to_dmar_domain(domain), dev);  }
> > 
> > +/*
> > + * 2D array for converting and sanitizing IOMMU generic TLB
> > granularity +to
> > + * VT-d granularity. Invalidation is typically included in the
> > unmap +operation
> > + * as a result of DMA or VFIO unmap. However, for assigned device
> > where +guest
> > + * could own the first level page tables without being shadowed by
> > +QEMU. In
> > + * this case there is no pass down unmap to the host IOMMU as a
> > result +of unmap
> > + * in the guest. Only invalidations are trapped and passed down.
> > + * In all cases, only first level TLB invalidation (request with
> > PASID) +can be
> > + * passed down, therefore we do not include IOTLB granularity for
> > +request
> > + * without PASID (second level).
> > + *
> > + * For an example, to find the VT-d granularity encoding for IOTLB
> > + * type and page selective granularity within PASID:
> > + * X: indexed by iommu cache type
> > + * Y: indexed by enum iommu_inv_granularity
> > + * [IOMMU_CACHE_INV_TYPE_IOTLB][IOMMU_INV_GRANU_ADDR]
> > + *
> > + * Granu_map array indicates validity of the table. 1: valid, 0:
> > +invalid
> > + *
> > + */
> > +const static int
> > inv_type_granu_map[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV_GRANU_N
> > R] = {
> > +	/* PASID based IOTLB, support PASID selective and page
> > selective */
> > +	{0, 1, 1},
> > +	/* PASID based dev TLBs, only support all PASIDs or single
> > PASID */
> > +	{1, 1, 0},
> > +	/* PASID cache */
> > +	{1, 1, 0}
> > +};
> > +
> > +const static u64
> > inv_type_granu_table[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV_GRANU_
> > NR] = {
> > +	/* PASID based IOTLB */
> > +	{0, QI_GRAN_NONG_PASID, QI_GRAN_PSI_PASID},
> > +	/* PASID based dev TLBs */
> > +	{QI_DEV_IOTLB_GRAN_ALL, QI_DEV_IOTLB_GRAN_PASID_SEL, 0},
> > +	/* PASID cache */
> > +	{QI_PC_ALL_PASIDS, QI_PC_PASID_SEL, 0}, };
> > +
> > +static inline int to_vtd_granularity(int type, int granu, u64
> > +*vtd_granu) {
> > +	if (type >= IOMMU_CACHE_INV_TYPE_NR || granu >=
> > IOMMU_INV_GRANU_NR ||
> > +		!inv_type_granu_map[type][granu])
> > +		return -EINVAL;
> > +
> > +	*vtd_granu = inv_type_granu_table[type][granu];
> > +
> > +	return 0;
> > +}
> > +
> > +static inline u64 to_vtd_size(u64 granu_size, u64 nr_granules) {
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
> > iommu_cache_invalidate_info *inv_info) {
> > +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> > +	struct device_domain_info *info;
> > +	struct intel_iommu *iommu;
> > +	unsigned long flags;
> > +	int cache_type;
> > +	u8 bus, devfn;
> > +	u16 did, sid;
> > +	int ret = 0;
> > +	u64 size;
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
> > +	}
> > +	did = dmar_domain->iommu_did[iommu->seq_id];
> > +	sid = PCI_DEVID(bus, devfn);
> > +	size = to_vtd_size(inv_info->addr_info.granule_size,
> > +inv_info->addr_info.nb_granules);  
> 
> Here I have a concern that we always try to get size via
> to_vtd_size(). But the inv_info->addr_info.granule_size and
> inv_info->addr_info.nb_granules may be meaningless if the
> invalidation is not a page selective one. May we add a check here on
> the invalidation granularity. :-)
> 
Good point. We should add a check:
if (inv_info->granularity != IOMMU_INV_GRANU_PASID)
> > +	for_each_set_bit(cache_type, (unsigned long
> > *)&inv_info->cache, IOMMU_CACHE_INV_TYPE_NR) {
> > +		u64 granu = 0;
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
> > +		if (inv_info->granularity == IOMMU_INV_GRANU_PASID)
> > +			pasid = inv_info->pasid_info.pasid;
> > +		else if (inv_info->granularity ==
> > IOMMU_INV_GRANU_ADDR)
> > +			pasid = inv_info->addr_info.pasid;
> > +		else {
> > +			pr_err("Cannot find PASID for given cache
> > type and granularity\n");
> > +			break;
> > +		}
> > +
> > +		switch (BIT(cache_type)) {
> > +		case IOMMU_CACHE_INV_TYPE_IOTLB:
> > +			if (size && (inv_info->addr_info.addr &
> > ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {  
> 
> May  need to update acoordingly if the above comment was accepted.
> :-)
> 
Yes, need to add a check here also. Otherwise, size can be out of range
for PASID selective invalidation and cause functional problems.

Thanks!

Jacob

> Regards,
> Yi Liu
> 

[Jacob Pan]
