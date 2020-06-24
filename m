Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C30C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4505206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388693AbgFXHzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:55:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:61205 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388029AbgFXHzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:55:46 -0400
IronPort-SDR: c/cEC14RogX3KyuGq7IREg+oIX7trB8Ag8SUmOhXr70GpbJ1rk2rMjiMjD63BIv+AAbSQAvKTa
 do74Fm13GrjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="162460280"
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; 
   d="scan'208";a="162460280"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 00:55:45 -0700
IronPort-SDR: EcsNTZj/jqa9+tFSh3YHnRBwDnuKdmMgIeF1hhHnglpSR7g3cvh81UKgRbqdDtMS7wnEk1zsPV
 uPq3JRxKRduA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; 
   d="scan'208";a="423287831"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.28.245]) ([10.255.28.245])
  by orsmga004.jf.intel.com with ESMTP; 24 Jun 2020 00:55:41 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 5/5] iommu/uapi: Support both kernel and user unbind
 guest PASID
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <1592931837-58223-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1592931837-58223-6-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <878d1db7-c8aa-0244-5be2-fef07f118f30@linux.intel.com>
Date:   Wed, 24 Jun 2020 15:55:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592931837-58223-6-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 2020/6/24 1:03, Jacob Pan wrote:
> Guest SVA unbind data can come from either kernel and user space, if a

either kernel or user space

> user pointer is passed in, IOMMU driver must copy from data from user.

copy data from user

> If the unbind data is assembled in kernel, data can be trusted and
> directly used. This patch creates a wrapper for unbind gpasid such that
> user pointer can be parsed and sanitized before calling into the kernel
> unbind function. Common user data copy code also consolidated.
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/iommu.c | 70 ++++++++++++++++++++++++++++++++++++++-------------
>   include/linux/iommu.h | 13 ++++++++--
>   2 files changed, 64 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4a025c429b41..595527e4c6b7 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2010,19 +2010,15 @@ int iommu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
>   
> -int iommu_sva_bind_gpasid(struct iommu_domain *domain, struct device *dev,
> -						void __user *udata)
> -{
>   
> -	struct iommu_gpasid_bind_data data;
> +static int iommu_sva_prepare_bind_data(void __user *udata, bool bind,
> +				       struct iommu_gpasid_bind_data *data)
> +{
>   	unsigned long minsz, maxsz;
>   
> -	if (unlikely(!domain->ops->sva_bind_gpasid))
> -		return -ENODEV;
> -
>   	/* Current kernel data size is the max to be copied from user */
>   	maxsz = sizeof(struct iommu_gpasid_bind_data);
> -	memset((void *)&data, 0, maxsz);
> +	memset((void *)data, 0, maxsz);
>   
>   	/*
>   	 * No new spaces can be added before the variable sized union, the
> @@ -2031,11 +2027,11 @@ int iommu_sva_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>   	minsz = offsetof(struct iommu_gpasid_bind_data, vendor);
>   
>   	/* Copy minsz from user to get flags and argsz */
> -	if (copy_from_user(&data, udata, minsz))
> +	if (copy_from_user(data, udata, minsz))
>   		return -EFAULT;
>   
>   	/* Fields before variable size union is mandatory */
> -	if (data.argsz < minsz)
> +	if (data->argsz < minsz)
>   		return -EINVAL;
>   	/*
>   	 * User might be using a newer UAPI header, we shall let IOMMU vendor
> @@ -2043,26 +2039,66 @@ int iommu_sva_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>   	 * can be vendor specific, larger argsz could be the result of extension
>   	 * for one vendor but it should not affect another vendor.
>   	 */
> -	if (data.argsz > maxsz)
> -		data.argsz = maxsz;
> +	if (data->argsz > maxsz)
> +		data->argsz = maxsz;
> +
> +	/*
> +	 * For unbind, we don't need any extra data, host PASID is included in
> +	 * the minsz and that is all we need.
> +	 */
> +	if (!bind)
> +		return 0;
>   
>   	/* Copy the remaining user data _after_ minsz */
> -	if (copy_from_user((void *)&data + minsz, udata + minsz,
> -				data.argsz - minsz))
> +	if (copy_from_user((void *)data + minsz, udata + minsz,
> +				data->argsz - minsz))
>   		return -EFAULT;
>   
> +	return 0;
> +}
> +
> +int iommu_sva_bind_gpasid(struct iommu_domain *domain, struct device *dev,
> +						void __user *udata)
> +{
> +
> +	struct iommu_gpasid_bind_data data;
> +	int ret;
> +
> +	if (unlikely(!domain->ops->sva_bind_gpasid))
> +		return -ENODEV;
> +
> +	ret = iommu_sva_prepare_bind_data(udata, true, &data);
> +	if (ret)
> +		return ret;
>   
>   	return domain->ops->sva_bind_gpasid(domain, dev, &data);
>   }
>   EXPORT_SYMBOL_GPL(iommu_sva_bind_gpasid);
>   
> -int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
> -			     ioasid_t pasid)
> +int __iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
> +			struct iommu_gpasid_bind_data *data)
>   {
>   	if (unlikely(!domain->ops->sva_unbind_gpasid))
>   		return -ENODEV;
>   
> -	return domain->ops->sva_unbind_gpasid(dev, pasid);
> +	return domain->ops->sva_unbind_gpasid(dev, data->hpasid);
How about passing @data to the vendor iommu driver as well?

> +}
> +EXPORT_SYMBOL_GPL(__iommu_sva_unbind_gpasid);
> +
> +int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
> +			void __user *udata)

Keep it aligned.

> +{
> +	struct iommu_gpasid_bind_data data;
> +	int ret;
> +
> +	if (unlikely(!domain->ops->sva_bind_gpasid))
> +		return -ENODEV;
> +
> +	ret = iommu_sva_prepare_bind_data(udata, false, &data);
> +	if (ret)
> +		return ret;
> +
> +	return __iommu_sva_unbind_gpasid(domain, dev, &data);
>   }
>   EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
>   
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index a688fea42ae5..2567c33dc4e8 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -437,7 +437,9 @@ extern int iommu_cache_invalidate(struct iommu_domain *domain,
>   extern int iommu_sva_bind_gpasid(struct iommu_domain *domain,
>   				struct device *dev, void __user *udata);
>   extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> -				struct device *dev, ioasid_t pasid);
> +				struct device *dev, void __user *udata);
> +extern int __iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> +				struct device *dev, struct iommu_gpasid_bind_data *data);
>   extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
>   extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
>   extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
> @@ -1069,7 +1071,14 @@ static inline int iommu_sva_bind_gpasid(struct iommu_domain *domain,
>   }
>   
>   static inline int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> -					   struct device *dev, int pasid)
> +					   struct device *dev, void __user *udata)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int __iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> +					struct device *dev,
> +					struct iommu_gpasid_bind_data *data)
>   {
>   	return -ENODEV;
>   }
> 

Best regards,
baolu
