Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B14C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 236952082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgG2V7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:59:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:21077 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgG2V7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 17:59:08 -0400
IronPort-SDR: AcklVAT9odfik6WWOqTB1e/jBL5KXtb7YCyTaUt+7nHVF3SS/JdPiRJpG50NvNapsF4kh/GZ/c
 VCD1Slj2sFkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="139510240"
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; 
   d="scan'208";a="139510240"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 14:59:06 -0700
IronPort-SDR: oynncxCjXd7xCyoo1JmTGJDG88Zzao6iMUIb1RnZr9b6KJqEVcvDNLiWfQlrxDH45TLcsHKr9w
 gupyj8kVxr3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; 
   d="scan'208";a="364975841"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 29 Jul 2020 14:59:06 -0700
Date:   Wed, 29 Jul 2020 15:05:56 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v6 5/6] iommu/uapi: Handle data and argsz filled by
 users
Message-ID: <20200729150556.42585972@jacob-builder>
In-Reply-To: <20200728131944.2e38e5fc@x1.home>
References: <1595525140-23899-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1595525140-23899-6-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200728131944.2e38e5fc@x1.home>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 13:19:44 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Thu, 23 Jul 2020 10:25:39 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > IOMMU user APIs are responsible for processing user data. This patch
> > changes the interface such that user pointers can be passed into
> > IOMMU code directly. Separate kernel APIs without user pointers are
> > introduced for in-kernel users of the UAPI functionality.
> > 
> > IOMMU UAPI data has a user filled argsz field which indicates the
> > data length of the structure. User data is not trusted, argsz must
> > be validated based on the current kernel data size, mandatory data
> > size, and feature flags.
> > 
> > User data may also be extended, resulting in possible argsz
> > increase. Backward compatibility is ensured based on size and flags
> > (or the functional equivalent fields) checking.
> > 
> > This patch adds sanity checks in the IOMMU layer. In addition to
> > argsz, reserved/unused fields in padding, flags, and version are
> > also checked. Details are documented in
> > Documentation/userspace-api/iommu.rst
> > 
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/iommu.c | 202
> > ++++++++++++++++++++++++++++++++++++++++++++++++--
> > include/linux/iommu.h |  28 ++++--- 2 files changed, 213
> > insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 3a913ce94a3d..1ce2a61058c6 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1950,33 +1950,219 @@ int iommu_attach_device(struct
> > iommu_domain *domain, struct device *dev) }
> >  EXPORT_SYMBOL_GPL(iommu_attach_device);
> >  
> > +/*
> > + * Check flags and other user provided data for valid
> > combinations. We also
> > + * make sure no reserved fields or unused flags are set. This is
> > to ensure
> > + * not breaking userspace in the future when these fields or flags
> > are used.
> > + */
> > +static int iommu_check_cache_invl_data(struct
> > iommu_cache_invalidate_info *info) +{
> > +	u32 mask;
> > +	int i;
> > +
> > +	if (info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
> > +		return -EINVAL;
> > +
> > +	mask = (1 << IOMMU_CACHE_INV_TYPE_NR) - 1;
> > +	if (info->cache & ~mask)
> > +		return -EINVAL;
> > +
> > +	if (info->granularity >= IOMMU_INV_GRANU_NR)
> > +		return -EINVAL;
> > +
> > +	switch (info->granularity) {
> > +	case IOMMU_INV_GRANU_ADDR:
> > +		if (info->cache & IOMMU_CACHE_INV_TYPE_PASID)
> > +			return -EINVAL;
> > +
> > +		mask = IOMMU_INV_ADDR_FLAGS_PASID |
> > +			IOMMU_INV_ADDR_FLAGS_ARCHID |
> > +			IOMMU_INV_ADDR_FLAGS_LEAF;
> > +
> > +		if (info->granu.addr_info.flags & ~mask)
> > +			return -EINVAL;
> > +		break;
> > +	case IOMMU_INV_GRANU_PASID:
> > +		mask = IOMMU_INV_PASID_FLAGS_PASID |
> > +			IOMMU_INV_PASID_FLAGS_ARCHID;
> > +		if (info->granu.pasid_info.flags & ~mask)
> > +			return -EINVAL;
> > +
> > +		break;
> > +	case IOMMU_INV_GRANU_DOMAIN:
> > +		if (info->cache & IOMMU_CACHE_INV_TYPE_DEV_IOTLB)
> > +			return -EINVAL;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Check reserved padding fields */
> > +	for (i = 0; i < 6; i++) {  
> 
> We could use sizeof(info->padding) here to avoid future issues
> relative to the number of padding bytes.
> 
yes, much better.

> > +		if (info->padding[i])
> > +			return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
> > struct device *dev,
> > -				struct iommu_cache_invalidate_info
> > *inv_info)
> > +				void __user *uinfo)
> >  {
> > +	struct iommu_cache_invalidate_info inv_info = { 0 };
> > +	u32 minsz;
> > +	int ret = 0;
> > +
> >  	if (unlikely(!domain->ops->cache_invalidate))
> >  		return -ENODEV;
> >  
> > -	return domain->ops->cache_invalidate(domain, dev,
> > inv_info);
> > +	/*
> > +	 * No new spaces can be added before the variable sized
> > union, the
> > +	 * minimum size is the offset to the union.
> > +	 */
> > +	minsz = offsetof(struct iommu_cache_invalidate_info,
> > granu); +
> > +	/* Copy minsz from user to get flags and argsz */
> > +	if (copy_from_user(&inv_info, uinfo, minsz))
> > +		return -EFAULT;
> > +
> > +	/* Fields before variable size union is mandatory */
> > +	if (inv_info.argsz < minsz)
> > +		return -EINVAL;
> > +
> > +	/* PASID and address granu require additional info beyond
> > minsz */
> > +	if (inv_info.argsz == minsz &&
> > +	    ((inv_info.granularity == IOMMU_INV_GRANU_PASID) ||
> > +		    (inv_info.granularity ==
> > IOMMU_INV_GRANU_ADDR)))
> > +		return -EINVAL;
> > +
> > +	if (inv_info.granularity == IOMMU_INV_GRANU_PASID &&
> > +	    inv_info.argsz < offsetofend(struct
> > iommu_cache_invalidate_info, granu.pasid_info))
> > +		return -EINVAL;
> > +
> > +	if (inv_info.granularity == IOMMU_INV_GRANU_ADDR &&
> > +	    inv_info.argsz < offsetofend(struct
> > iommu_cache_invalidate_info, granu.addr_info))
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * User might be using a newer UAPI header which has a
> > larger data
> > +	 * size, we shall support the existing flags within the
> > current
> > +	 * size. Copy the remaining user data _after_ minsz but
> > not more
> > +	 * than the current kernel supported size.
> > +	 */
> > +	if (copy_from_user((void *)&inv_info + minsz, uinfo +
> > minsz,
> > +			   min(inv_info.argsz,
> > (u32)sizeof(inv_info)) - minsz))  
> 
> Could use min_t() to cast both args to the specified type.
> 
will do. min_t(u32,

> > +		return -EFAULT;
> > +
> > +	/* Now the argsz is validated, check the content */
> > +	ret = iommu_check_cache_invl_data(&inv_info);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return domain->ops->cache_invalidate(domain, dev,
> > &inv_info); }
> >  EXPORT_SYMBOL_GPL(iommu_uapi_cache_invalidate);
> >  
> > -int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
> > -			       struct device *dev, struct
> > iommu_gpasid_bind_data *data) +static int
> > iommu_check_bind_data(struct iommu_gpasid_bind_data *data) +{
> > +	u32 mask;
> > +	int i;
> > +
> > +	if (data->version != IOMMU_GPASID_BIND_VERSION_1)
> > +		return -EINVAL;
> > +
> > +	/* Check all supported format, for now just VT-d */
> > +	mask = IOMMU_PASID_FORMAT_INTEL_VTD;
> > +	if (data->format & ~mask)  
> 
> data->format is not a bitmask though, it's an index, right?  Should
> defined formats be put into an enum with a last entry place holder for
> this code to test against?  If we end up with holes in the enum, I
> guess we'd need to use special cases, ex:
> 
> switch (data->format) {
> 	case IOMMU_PASID_FORMAT_DEPRECATED0:
> 		return -EINVAL;
> 	case 0 ... IOMMU_PASID_FORMAT_LAST:
> 		break;
> 	default:
> 		return -EINVAL;
> }
> 
> It seems strange and error prone anyway for common code to check
> against a specific vendor format here.
> 
Agreed, will change to enum with a last entry.

> > +		return -EINVAL;
> > +
> > +	/* Check all flags */
> > +	mask = IOMMU_SVA_GPASID_VAL;
> > +	if (data->flags & ~mask)
> > +		return -EINVAL;
> > +
> > +	/* Check reserved padding fields */
> > +	for (i = 0; i < 8; i++) {  
> 
> sizeof(data->padding)
> 
will do.

> > +		if (data->padding[i])
> > +			return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int iommu_sva_prepare_bind_data(void __user *udata,
> > +				       struct
> > iommu_gpasid_bind_data *data) {
> > +	u32 minsz;
> > +
> > +	/*
> > +	 * No new spaces can be added before the variable sized
> > union, the
> > +	 * minimum size is the offset to the union.
> > +	 */
> > +	minsz = offsetof(struct iommu_gpasid_bind_data, vendor);
> > +
> > +	/* Copy minsz from user to get flags and argsz */
> > +	if (copy_from_user(data, udata, minsz))
> > +		return -EFAULT;
> > +
> > +	/* Fields before variable size union is mandatory */
> > +	if (data->argsz < minsz)
> > +		return -EINVAL;
> > +	/*
> > +	 * User might be using a newer UAPI header, we shall let
> > IOMMU vendor
> > +	 * driver decide on what size it needs. Since the guest
> > PASID bind data
> > +	 * can be vendor specific, larger argsz could be the
> > result of extension
> > +	 * for one vendor but it should not affect another vendor.
> > +	 * Copy the remaining user data _after_ minsz
> > +	 */
> > +	if (copy_from_user((void *)data + minsz, udata + minsz,
> > +			   min(data->argsz, (u32)sizeof(*data)) -
> > minsz))  
> 
> min_t() here too.  Thanks,
> 
will do.

Thanks!


> Alex
> 
> > +		return -EFAULT;
> > +
> > +	return iommu_check_bind_data(data);
> > +}
> > +
> > +int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain, struct
> > device *dev,
> > +			       void __user *udata)
> > +{
> > +	struct iommu_gpasid_bind_data data = { 0 };
> > +	int ret;
> > +
> >  	if (unlikely(!domain->ops->sva_bind_gpasid))
> >  		return -ENODEV;
> >  
> > -	return domain->ops->sva_bind_gpasid(domain, dev, data);
> > +	ret = iommu_sva_prepare_bind_data(udata, &data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return domain->ops->sva_bind_gpasid(domain, dev, &data);
> >  }
> >  EXPORT_SYMBOL_GPL(iommu_uapi_sva_bind_gpasid);
> >  
> > -int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
> > struct device *dev,
> > -				 ioasid_t pasid)
> > +int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct
> > device *dev,
> > +			    struct iommu_gpasid_bind_data *data)
> >  {
> >  	if (unlikely(!domain->ops->sva_unbind_gpasid))
> >  		return -ENODEV;
> >  
> > -	return domain->ops->sva_unbind_gpasid(dev, pasid);
> > +	return domain->ops->sva_unbind_gpasid(dev, data->hpasid);
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
> > +
> > +int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
> > struct device *dev,
> > +				 void __user *udata)
> > +{
> > +	struct iommu_gpasid_bind_data data = { 0 };
> > +	int ret;
> > +
> > +	if (unlikely(!domain->ops->sva_bind_gpasid))
> > +		return -ENODEV;
> > +
> > +	ret = iommu_sva_prepare_bind_data(udata, &data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return iommu_sva_unbind_gpasid(domain, dev, &data);
> >  }
> >  EXPORT_SYMBOL_GPL(iommu_uapi_sva_unbind_gpasid);
> >  
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 2dcc1a33f6dc..4a02c9e09048 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -432,11 +432,14 @@ extern void iommu_detach_device(struct
> > iommu_domain *domain, struct device *dev);
> >  extern int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
> >  				       struct device *dev,
> > -				       struct
> > iommu_cache_invalidate_info *inv_info);
> > +				       void __user *uinfo);
> > +
> >  extern int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
> > -				      struct device *dev, struct
> > iommu_gpasid_bind_data *data);
> > +				      struct device *dev, void
> > __user *udata); extern int iommu_uapi_sva_unbind_gpasid(struct
> > iommu_domain *domain,
> > -					struct device *dev,
> > ioasid_t pasid);
> > +					struct device *dev, void
> > __user *udata); +extern int iommu_sva_unbind_gpasid(struct
> > iommu_domain *domain,
> > +				   struct device *dev, struct
> > iommu_gpasid_bind_data *data); extern struct iommu_domain
> > *iommu_get_domain_for_dev(struct device *dev); extern struct
> > iommu_domain *iommu_get_dma_domain(struct device *dev); extern int
> > iommu_map(struct iommu_domain *domain, unsigned long iova, @@
> > -1054,22 +1057,29 @@ static inline int iommu_sva_get_pasid(struct
> > iommu_sva *handle) return IOMMU_PASID_INVALID; }
> >  
> > -static inline int iommu_uapi_cache_invalidate(struct iommu_domain
> > *domain,
> > -					      struct device *dev,
> > -					      struct
> > iommu_cache_invalidate_info *inv_info) +static inline int
> > +iommu_uapi_cache_invalidate(struct iommu_domain *domain,
> > +			    struct device *dev,
> > +			    struct iommu_cache_invalidate_info
> > *inv_info) {
> >  	return -ENODEV;
> >  }
> >  
> >  static inline int iommu_uapi_sva_bind_gpasid(struct iommu_domain
> > *domain,
> > -					     struct device *dev,
> > -					     struct
> > iommu_gpasid_bind_data *data)
> > +					     struct device *dev,
> > void __user *udata) {
> >  	return -ENODEV;
> >  }
> >  
> >  static inline int iommu_uapi_sva_unbind_gpasid(struct iommu_domain
> > *domain,
> > -					       struct device *dev,
> > int pasid)
> > +					       struct device *dev,
> > void __user *udata) +{
> > +	return -ENODEV;
> > +}
> > +
> > +static inline int iommu_sva_unbind_gpasid(struct iommu_domain
> > *domain,
> > +					  struct device *dev,
> > +					  struct
> > iommu_gpasid_bind_data *data) {
> >  	return -ENODEV;
> >  }  
> 

[Jacob Pan]
