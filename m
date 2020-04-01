Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C6BC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A0D206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbgDAG5t convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 02:57:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:18497 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731764AbgDAG5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 02:57:49 -0400
IronPort-SDR: mCYDgjJHYN+IU84zo1tqDgJUBvhDPlXa+Kmux3g3grit+q5fPhZTG3MJiHzeQc8wlV+UfPjuLn
 hGL/i2Tfwsjw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 23:57:47 -0700
IronPort-SDR: XGutmR2ChxLrg+jWU2eaI3Ir9XjE/o85E7vsb3/RJduB9xCoOl+9mhmIU8JcsMCoQzOjQO0uMy
 X4VZCogRpCEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,330,1580803200"; 
   d="scan'208";a="252502299"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga006.jf.intel.com with ESMTP; 31 Mar 2020 23:57:45 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 23:57:45 -0700
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 23:57:44 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.191]) with mapi id 14.03.0439.000;
 Wed, 1 Apr 2020 14:57:42 +0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: RE: [PATCH V10 08/11] iommu/vt-d: Add svm/sva invalidate function
Thread-Topic: [PATCH V10 08/11] iommu/vt-d: Add svm/sva invalidate function
Thread-Index: AQHV/w5hiFCIIwap/Eaujod2FPXZGKhdS4kAgAVAaQCAAMw6gIAAjMkA
Date:   Wed, 1 Apr 2020 06:57:42 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A21C475@SHSMSX104.ccr.corp.intel.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1584746861-76386-9-git-send-email-jacob.jun.pan@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7FA0AB@SHSMSX104.ccr.corp.intel.com>
 <20200331111332.0718ffd2@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D803C1B@SHSMSX104.ccr.corp.intel.com>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D803C1B@SHSMSX104.ccr.corp.intel.com>
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

> From: Tian, Kevin <kevin.tian@intel.com>
> Sent: Wednesday, April 1, 2020 2:24 PM
> To: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Subject: RE: [PATCH V10 08/11] iommu/vt-d: Add svm/sva invalidate function
> 
> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Wednesday, April 1, 2020 2:14 AM
> >
> > On Sat, 28 Mar 2020 10:01:42 +0000
> > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >
> > > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > Sent: Saturday, March 21, 2020 7:28 AM
> > > >
> > > > When Shared Virtual Address (SVA) is enabled for a guest OS via
> > > > vIOMMU, we need to provide invalidation support at IOMMU API and
> > > > driver level. This patch adds Intel VT-d specific function to
> > > > implement iommu passdown invalidate API for shared virtual address.
> > > >
> > > > The use case is for supporting caching structure invalidation
> > > > of assigned SVM capable devices. Emulated IOMMU exposes queue
> > >
> > > emulated IOMMU -> vIOMMU, since virito-iommu could use the
> > > interface as well.
> > >
> > True, but it does not invalidate this statement about emulated IOMMU. I
> > will add another statement saying "the same interface can be used for
> > virtio-IOMMU as well". OK?
> 
> sure
> 
> >
> > > > invalidation capability and passes down all descriptors from the
> > > > guest to the physical IOMMU.
> > > >
> > > > The assumption is that guest to host device ID mapping should be
> > > > resolved prior to calling IOMMU driver. Based on the device handle,
> > > > host IOMMU driver can replace certain fields before submit to the
> > > > invalidation queue.
> > > >
> > > > ---
> > > > v7 review fixed in v10
> > > > ---
> > > >
> > > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > > > Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> > > > ---
> > > >  drivers/iommu/intel-iommu.c | 182
> > > > ++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 182 insertions(+)
> > > >
> > > > diff --git a/drivers/iommu/intel-iommu.c
> > > > b/drivers/iommu/intel-iommu.c index b1477cd423dd..a76afb0fd51a
> > > > 100644 --- a/drivers/iommu/intel-iommu.c
> > > > +++ b/drivers/iommu/intel-iommu.c
> > > > @@ -5619,6 +5619,187 @@ static void
> > > > intel_iommu_aux_detach_device(struct iommu_domain *domain,
> > > >  	aux_domain_remove_dev(to_dmar_domain(domain), dev);
> > > >  }
> > > >
> > > > +/*
> > > > + * 2D array for converting and sanitizing IOMMU generic TLB
> > > > granularity to
> > > > + * VT-d granularity. Invalidation is typically included in the
> > > > unmap operation
> > > > + * as a result of DMA or VFIO unmap. However, for assigned devices
> > > > guest
> > > > + * owns the first level page tables. Invalidations of translation
> > > > caches in the
> > > > + * guest are trapped and passed down to the host.
> > > > + *
> > > > + * vIOMMU in the guest will only expose first level page tables,
> > > > therefore
> > > > + * we do not include IOTLB granularity for request without PASID
> > > > (second level).
> > >
> > > I would revise above as "We do not support IOTLB granularity for
> > > request without PASID (second level), therefore any vIOMMU
> > > implementation that exposes the SVA capability to the guest should
> > > only expose the first level page tables, implying all invalidation
> > > requests from the guest will include a valid PASID"
> > >
> > Sounds good.
> >
> > > > + *
> > > > + * For example, to find the VT-d granularity encoding for IOTLB
> > > > + * type and page selective granularity within PASID:
> > > > + * X: indexed by iommu cache type
> > > > + * Y: indexed by enum iommu_inv_granularity
> > > > + * [IOMMU_CACHE_INV_TYPE_IOTLB][IOMMU_INV_GRANU_ADDR]
> > > > + *
> > > > + * Granu_map array indicates validity of the table. 1: valid, 0:
> > > > invalid
> > > > + *
> > > > + */
> > > > +const static int
> > > >
> > inv_type_granu_map[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV_GRANU_
> > > > NR] = {
> > > > +	/*
> > > > +	 * PASID based IOTLB invalidation: PASID selective (per
> > > > PASID),
> > > > +	 * page selective (address granularity)
> > > > +	 */
> > > > +	{0, 1, 1},
> > > > +	/* PASID based dev TLBs, only support all PASIDs or single
> > > > PASID */
> > > > +	{1, 1, 0},
> > >
> > > Is this combination correct? when single PASID is being specified, it
> > > is essentially a page-selective invalidation since you need provide
> > > Address and Size.
> > >
> > This is for translation between generic UAPI granu to VT-d granu, it
> > has nothing to do with address and size.
> 
> Generic UAPI defines three granularities: domain, pasid and addr.
> from the definition domain applies all entries related to did, pasid
> applies to all entries related to pasid, while addr is specific for a
> range.
> 
> from what we just confirmed internally with VT-d spec owner, our
> PASID based dev TLB invalidation always requires addr and size,
> while current uAPI doesn't support multiple PASIDs based range
> invaliation. It sounds to me that you want to use domain to replace
> multiple PASIDs case (G=1), but it then changes the meaning of
> the domain granularity and easily lead to confusion.
>
> I feel Eric's proposal makes more sense. Here we'd better use {0, 0, 1}
> to indicate only addr range invalidation is allowed, matching the
> spec definition. We may use a special flag in iommu_inv_addr_info
> to indicate G=1 case, if necessary.

I agree. G=1 case should be supported. I think we had a flag for global
as there is GL bit in p_iotlb_inv_dsc (a.k.a ext_iotlb_inv_dsc), but it was
dropped as 3.0 spec dropped GL bit. Let's add it back as for DevTLB
flush case.

> > e.g.
> > If user passes IOMMU_INV_GRANU_PASID for the single PASID case as you
> > mentioned, this map table shows it is valid.
> >
> > Then the lookup result will get VT-d granu:
> > QI_DEV_IOTLB_GRAN_PASID_SEL, which means G=0.
> >
> >
> > > > +	/* PASID cache */
> > >
> > > PASID cache is fully managed by the host. Guest PASID cache
> > > invalidation is interpreted by vIOMMU for bind and unbind operations.
> > > I don't think we should accept any PASID cache invalidation from
> > > userspace or guest.
> > >
> >
> > True for vIOMMU, this is here for completeness. Can be used by virtio
> > IOMMU, since PC flush is inclusive (IOTLB, devTLB), it is more
> > efficient.
> 
> I think it is not correct in concept. We should not allow the userspace or
> guest to request an operation which is beyond its privilege (just because
> doing so may bring some performance benefit). You can always introduce
> new cmd for such purpose.

I guess it was added for the pasid table binding case? Now, our platform
doesn't support it. So I guess we can just make it as unsupported in the
2D table.

Regards,
Yi Liu
