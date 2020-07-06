Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FE8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AB5720663
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgGFU7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:59:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:3273 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgGFU7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 16:59:00 -0400
IronPort-SDR: tTW7E40kVs5dGH8e+ntCDjS5wXqg1ucms4YGVmE7bRmISvn5Vuqg12wnyOtCD13Ev3REnIL4Yo
 7zBNL2b4j/5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="145605313"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="145605313"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 13:58:59 -0700
IronPort-SDR: 3rvXn4NLKCIRVFAX6OYMotbGWW3F8BZp0YCQDd18XpMnkX/ikCcWy/6zuniWkNQCloi8AQBWUG
 qs1u15e8crxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="305424906"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jul 2020 13:58:59 -0700
Date:   Mon, 6 Jul 2020 14:05:17 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 5/7] iommu/vt-d: Fix devTLB flush for vSVA
Message-ID: <20200706140517.3f6ca616@jacob-builder>
In-Reply-To: <f44409e8-7c68-9b26-cf87-b0887668e879@redhat.com>
References: <1593617636-79385-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1593617636-79385-6-git-send-email-jacob.jun.pan@linux.intel.com>
        <f44409e8-7c68-9b26-cf87-b0887668e879@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jul 2020 10:39:26 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob, Yi,
> On 7/1/20 5:33 PM, Jacob Pan wrote:
> > From: Liu Yi L <yi.l.liu@intel.com>
> > 
> > For guest SVA usage, in order to optimize for less VMEXIT, guest
> > request of IOTLB flush also includes device TLB.
> > 
> > On the host side, IOMMU driver performs IOTLB and implicit devTLB
> > invalidation. When PASID-selective granularity is requested by the
> > guest we need to derive the equivalent address range for devTLB
> > instead of using the address information in the UAPI data. The
> > reason for that is, unlike IOTLB flush, devTLB flush does not
> > support PASID-selective granularity. This is to say, we need to set
> > the following in the PASID based devTLB invalidation descriptor:
> > - entire 64 bit range in address ~(0x1 << 63)
> > - S bit = 1 (VT-d CH 6.5.2.6).
> > 
> > Without this fix, device TLB flush range is not set properly for
> > PASID selective granularity. This patch also merged devTLB flush
> > code for both implicit and explicit cases.
> > 
> > Fixes: 6ee1b77ba3ac ("iommu/vt-d: Add svm/sva invalidate function")
> > Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel/iommu.c | 28 ++++++++++++++++++----------
> >  1 file changed, 18 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c
> > b/drivers/iommu/intel/iommu.c index 96340da57075..6a0c62c7395c
> > 100644 --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -5408,7 +5408,7 @@ intel_iommu_sva_invalidate(struct
> > iommu_domain *domain, struct device *dev, sid = PCI_DEVID(bus,
> > devfn); 
> >  	/* Size is only valid in address selective invalidation */
> > -	if (inv_info->granularity != IOMMU_INV_GRANU_PASID)
> > +	if (inv_info->granularity == IOMMU_INV_GRANU_ADDR)
> >  		size =
> > to_vtd_size(inv_info->addr_info.granule_size,
> > inv_info->addr_info.nb_granules); 
> > @@ -5417,6 +5417,7 @@ intel_iommu_sva_invalidate(struct
> > iommu_domain *domain, struct device *dev, IOMMU_CACHE_INV_TYPE_NR) {
> >  		int granu = 0;
> >  		u64 pasid = 0;
> > +		u64 addr = 0;
> >  
> >  		granu = to_vtd_granularity(cache_type,
> > inv_info->granularity); if (granu == -EINVAL) {
> > @@ -5456,24 +5457,31 @@ intel_iommu_sva_invalidate(struct
> > iommu_domain *domain, struct device *dev, (granu ==
> > QI_GRAN_NONG_PASID) ? -1 : 1 << size, inv_info->addr_info.flags &
> > IOMMU_INV_ADDR_FLAGS_LEAF); 
> > +			if (!info->ats_enabled)
> > +				break;
> >  			/*
> >  			 * Always flush device IOTLB if ATS is
> > enabled. vIOMMU
> >  			 * in the guest may assume IOTLB flush is
> > inclusive,
> >  			 * which is more efficient.
> >  			 */
> > -			if (info->ats_enabled)
> > -				qi_flush_dev_iotlb_pasid(iommu,
> > sid,
> > -						info->pfsid, pasid,
> > -						info->ats_qdep,
> > -
> > inv_info->addr_info.addr,
> > -						size);
> > -			break;
> > +			fallthrough;
> >  		case IOMMU_CACHE_INV_TYPE_DEV_IOTLB:
> > +			/*
> > +			 * There is no PASID selective flush for
> > device TLB, so
> > +			 * the equivalent of that is we set the
> > size to be the
> > +			 * entire range of 64 bit. User only
> > provides PASID info
> > +			 * without address info. So we set addr to
> > 0.  
> The "PASID selective flush for device TLB" terminology above sounds a
> bit confusing to me. I would rather say Intel device TLB has no
> support for OMMU_INV_GRANU_PASID granularity but only supports
> IOMMU_INV_GRANU_ADDR. Indeed 6.5.2.6 title is "PASID-based-Device-TLB
> Invalidate Descriptor"
Sounds good, will rewrite comment accordingly.

> > +			 */
> > +			if (inv_info->granularity ==
> > IOMMU_INV_GRANU_PASID) {
> > +				size = 64 - VTD_PAGE_SHIFT;
> > +				addr = 0;  
> I have my answer for previous patch review question. In that case the
> addr is not formatted with the least significant 0 matching the
> size_order.
> 
> > +			} else if (inv_info->granularity ==
> > IOMMU_INV_GRANU_ADDR)
> > +				addr = inv_info->addr_info.addr;
> > +
> >  			if (info->ats_enabled)
> >  				qi_flush_dev_iotlb_pasid(iommu,
> > sid, info->pfsid, pasid,
> > -						info->ats_qdep,
> > -
> > inv_info->addr_info.addr,
> > +						info->ats_qdep,
> > addr, size);
> >  			else
> >  				pr_warn_ratelimited("Passdown
> > device IOTLB flush w/o ATS!\n"); 
> 
> Besides
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Thanks
> 
> Eric
> 

[Jacob Pan]
