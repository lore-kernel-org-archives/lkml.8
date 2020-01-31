Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618F4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405E7206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgAaRvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 12:51:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:63451 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727168AbgAaRvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 12:51:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2020 09:51:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,386,1574150400"; 
   d="scan'208";a="377409500"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga004.jf.intel.com with ESMTP; 31 Jan 2020 09:51:06 -0800
Date:   Fri, 31 Jan 2020 09:56:21 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 3/3] iommu/uapi: Add helper function for size lookup
Message-ID: <20200131095621.6acec2fc@jacob-builder>
In-Reply-To: <20200129144046.3f91e4c1@w520.home>
References: <1580277724-66994-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1580277724-66994-4-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200129144046.3f91e4c1@w520.home>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2020 14:40:46 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Tue, 28 Jan 2020 22:02:04 -0800
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > IOMMU UAPI can be extended in the future by adding new
> > fields at the end of each user data structure. Since we use
> > a unified UAPI version for compatibility checking, a lookup
> > function is needed to find the correct user data size to copy
> > from user.
> > 
> > This patch adds a helper function based on a 2D lookup with
> > version and type as input arguments.
> > 
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/iommu.c | 22 ++++++++++++++++++++++
> >  include/linux/iommu.h |  6 ++++++
> >  2 files changed, 28 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 7dd51c5d2ba1..9e5de9abebdf 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1696,6 +1696,28 @@ int iommu_sva_unbind_gpasid(struct
> > iommu_domain *domain, struct device *dev, }
> >  EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
> >  
> > +
> > +/**
> > + * Maintain a UAPI version to user data structure size lookup for
> > each
> > + * API function types we support. e.g. bind guest pasid, cache
> > invalidation.
> > + * As data structures being extended with new members, the
> > offsetofend()
> > + * will identify the new sizes.
> > + */
> > +const static int
> > iommu_uapi_data_size[NR_IOMMU_UAPI_TYPE][IOMMU_UAPI_VERSION] = {
> > +	/* IOMMU_UAPI_BIND_GPASID */
> > +	{offsetofend(struct iommu_gpasid_bind_data, vtd)},
> > +	/* IOMMU_UAPI_CACHE_INVAL */
> > +	{offsetofend(struct iommu_cache_invalidate_info,
> > addr_info)},
> > +	/* IOMMU_UAPI_PAGE_RESP */
> > +	{offsetofend(struct iommu_page_response, code)},
> > +};
> > +
> > +int iommu_uapi_get_data_size(int type, int version)
> > +{  
> 
> Seems like this is asking for a bounds check,
> 
>   if (type >= NR_IOMMU_UAPI_TYPE || version > IOMMU_UAPI_VERSION)
>   	return -EINVAL;
> 
yes, agreed.
> If we add new types in future versions, I assume we'd back fill the
> table with -EINVAL as well (rather than zero).  Thanks,
> 
right, if the array increase due to new types, the older version with
the new type should be filled with -EINVAL.
Let me document this in the rules of extensions.

> Alex
> 
> > +	return iommu_uapi_data_size[type][version - 1];
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_uapi_get_data_size);
> > +
> >  static void __iommu_detach_device(struct iommu_domain *domain,
> >  				  struct device *dev)
> >  {
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 9718c109ea0a..416fe02160ba 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -500,6 +500,7 @@ extern int iommu_report_device_fault(struct
> > device *dev, struct iommu_fault_event *evt);
> >  extern int iommu_page_response(struct device *dev,
> >  			       struct iommu_page_response *msg);
> > +extern int iommu_uapi_get_data_size(int type, int version);
> >  
> >  extern int iommu_group_id(struct iommu_group *group);
> >  extern struct iommu_group *iommu_group_get_for_dev(struct device
> > *dev); @@ -885,6 +886,11 @@ static inline int
> > iommu_page_response(struct device *dev, return -ENODEV;
> >  }
> >  
> > +static int iommu_uapi_get_data_size(int type, int version)
> > +{
> > +	return -ENODEV;
> > +}
> > +
> >  static inline int iommu_group_id(struct iommu_group *group)
> >  {
> >  	return -ENODEV;  
> 

[Jacob Pan]
