Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D87C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7377207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbgCaUwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 16:52:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:27314 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbgCaUwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:52:20 -0400
IronPort-SDR: SftVGfW6sdgGVdl9+vqUlrXYhLVba7ROnFlq6oD+usVQ0jxgakRy1ggMYa+ne996HhphF3LrKu
 Iq/o/JWcju4g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 13:52:20 -0700
IronPort-SDR: 9t856pZgKTfWBnjHJFtoepGRlVzP9m2xf7nkagQHk9zegQsKXZAXpn2HoV+pDnKfBkXrh+6lmR
 UB9OEnTXfnrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,329,1580803200"; 
   d="scan'208";a="328202815"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 31 Mar 2020 13:52:20 -0700
Date:   Tue, 31 Mar 2020 13:58:07 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Auger Eric <eric.auger@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH V10 08/11] iommu/vt-d: Add svm/sva invalidate function
Message-ID: <20200331135807.4e9976ab@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D800D67@SHSMSX104.ccr.corp.intel.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1584746861-76386-9-git-send-email-jacob.jun.pan@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7FA0AB@SHSMSX104.ccr.corp.intel.com>
        <3215b83c-81f7-a30f-fe82-a51f29d7b874@redhat.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D800D67@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Mar 2020 02:49:21 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Auger Eric <eric.auger@redhat.com>
> > Sent: Sunday, March 29, 2020 11:34 PM
> > 
> > Hi,
> > 
> > On 3/28/20 11:01 AM, Tian, Kevin wrote:  
> > >> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > >> Sent: Saturday, March 21, 2020 7:28 AM
> > >>
> > >> When Shared Virtual Address (SVA) is enabled for a guest OS via
> > >> vIOMMU, we need to provide invalidation support at IOMMU API
> > >> and  
> > driver  
> > >> level. This patch adds Intel VT-d specific function to implement
> > >> iommu passdown invalidate API for shared virtual address.
> > >>
> > >> The use case is for supporting caching structure invalidation
> > >> of assigned SVM capable devices. Emulated IOMMU exposes queue  
>  [...]  
>  [...]  
> > to  
> > >> + * VT-d granularity. Invalidation is typically included in the
> > >> unmap  
> > operation  
> > >> + * as a result of DMA or VFIO unmap. However, for assigned
> > >> devices  
> > guest  
> > >> + * owns the first level page tables. Invalidations of
> > >> translation caches in  
> > the  
>  [...]  
>  [...]  
>  [...]  
> > inv_type_granu_map[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV_GRANU_  
> > >> NR] = {
> > >> +	/*
> > >> +	 * PASID based IOTLB invalidation: PASID selective (per
> > >> PASID),
> > >> +	 * page selective (address granularity)
> > >> +	 */
> > >> +	{0, 1, 1},
> > >> +	/* PASID based dev TLBs, only support all PASIDs or
> > >> single PASID */
> > >> +	{1, 1, 0},  
> > >
> > > Is this combination correct? when single PASID is being
> > > specified, it is essentially a page-selective invalidation since
> > > you need provide Address and Size.  
> > Isn't it the same when G=1? Still the addr/size is used. Doesn't
> > it  
> 
> I thought addr/size is not used when G=1, but it might be wrong. I'm
> checking with our vt-d spec owner.
> 

> > correspond to IOMMU_INV_GRANU_ADDR with
> > IOMMU_INV_ADDR_FLAGS_PASID flag
> > unset?
> > 
> > so {0, 0, 1}?  
> 
I am not sure I got your logic. The three fields correspond to 
	IOMMU_INV_GRANU_DOMAIN,	/* domain-selective invalidation */
	IOMMU_INV_GRANU_PASID,	/* PASID-selective invalidation */
	IOMMU_INV_GRANU_ADDR,	/* page-selective invalidation *

For devTLB, we use domain as global since there is no domain. Then I
came up with {1, 1, 0}, which means we could have global and pasid
granu invalidation for PASID based devTLB.

If the caller also provide addr and S bit, the flush routine will put
that into QI descriptor. I know this is a little odd, but from the
granu translation p.o.v. VT-d spec has no G bit for page selective
invalidation.

> I have one more open:
> 
> How does userspace know which invalidation type/gran is supported?
> I didn't see such capability reporting in Yi's VFIO vSVA patch set.
> Do we want the user/kernel assume the same capability set if they are 
> architectural? However the kernel could also do some optimization
> e.g. hide devtlb invalidation capability given that the kernel
> already invalidate devtlb automatically when serving iotlb
> invalidation...
> 
In general, we are trending to use VFIO capability chain to expose iommu
capabilities.

But for architectural features such as type/granu, we have to assume
the same capability between host & guest. Granu and types are not
enumerated on the host IOMMU either.

For devTLB optimization, I agree we need to expose a capability to
the guest stating that implicit devtlb invalidation is supported.
Otherwise, if Linux guest runs on other OSes may not support implicit
devtlb invalidation.

Right Yi?

> Thanks
> Kevin
> 
> > 
> > Thanks
> > 
> > Eric
> >   
> > >  
> > >> +	/* PASID cache */  
> > >
> > > PASID cache is fully managed by the host. Guest PASID cache
> > > invalidation is interpreted by vIOMMU for bind and unbind
> > > operations. I don't think we should accept any PASID cache
> > > invalidation from userspace or guest. 
>  [...]  
> > inv_type_granu_table[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV_GRANU  
>  [...]  
> > >
> > > btw do we really need both map and table here? Can't we just
> > > use one table with unsupported granularity marked as a special
> > > value?
> > >  
>  [...]  
> > >
> > > -ENOTSUPP?
> > >  
>  [...]  
> > >
> > > granularity == IOMMU_INV_GRANU_ADDR? otherwise it's unclear
> > > why IOMMU_INV_GRANU_DOMAIN also needs size check.
> > >  
>  [...]  
> > >>> addr_info.addr),  
>  [...]  
>  [...]  
> > >> +			if (info->ats_enabled) {
> > >> +				qi_flush_dev_iotlb_pasid(iommu,
> > >> sid, info-  
> > >>> pfsid,  
>  [...]  
> > >>> pfsid,  
> > >> +
> > >> inv_info->addr_info.pasid, info->ats_qdep,
> > >> +
> > >> inv_info->addr_info.addr, size,
> > >> +						granu);  
>  [...]  
>  [...]  
> > >>> pasid_info.pasid);  
> > >> +  
> > >
> > > as earlier comment, we shouldn't allow userspace or guest to
> > > invalidate PASID cache
> > >  
>  [...]  
> > >  
> 

[Jacob Pan]
