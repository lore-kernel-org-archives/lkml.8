Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C46C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD58720671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgEONvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:51:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:31614 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgEONvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:51:05 -0400
IronPort-SDR: yYWVSlOq3ZkEdRJl3wwscNCbm5hTnwumSYwJvrlwecQpH6jBelMhmvIoLHQhCtTU28F4fK7gHl
 wSV2Kwu8/OmQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 06:51:05 -0700
IronPort-SDR: HiRFDcklPJUOEKtJdITP/v5pcs/FB32XD6WuiHt534hfwqBnP30FDEEowsD0xUZlBDceKdBcVC
 8Rtsgl1YWUfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="252383003"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.171.19]) ([10.249.171.19])
  by fmsmga007.fm.intel.com with ESMTP; 15 May 2020 06:51:03 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        jroedel@suse.de, linux-kernel@vger.kernel.org,
        Tom Murphy <murphyt7@tcd.ie>
Subject: Re: [PATCH] iommu: Implement deferred domain attachment
To:     Joerg Roedel <joro@8bytes.org>
References: <20200515094519.20338-1-joro@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8ce93a10-2ce0-e5a0-88a0-5d21d7003c0f@linux.intel.com>
Date:   Fri, 15 May 2020 21:51:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200515094519.20338-1-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 2020/5/15 17:45, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The IOMMU core code has support for deferring the attachment of a domain
> to a device. This is needed in kdump kernels where the new domain must
> not be attached to a device before the device driver takes it over.
> 
> But this needs support from the dma-ops code too, to actually do the
> late attachment when there are DMA-API calls for the device. This got
> lost in the AMD IOMMU driver after converting it to the dma-iommu code.
> 
> Do the late attachment in the dma-iommu code-path to fix the issue.
> 
> Cc: Jerry Snitselaar <jsnitsel@redhat.com>
> Cc: Tom Murphy <murphyt7@tcd.ie>
> Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Fixes: be62dbf554c5 ("iommu/amd: Convert AMD iommu driver to the dma-iommu api")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   drivers/iommu/iommu.c | 33 +++++++++++++++++++++++++++------
>   1 file changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4050569188be..f54ebb964271 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1889,13 +1889,19 @@ void iommu_domain_free(struct iommu_domain *domain)
>   }
>   EXPORT_SYMBOL_GPL(iommu_domain_free);
>   
> -static int __iommu_attach_device(struct iommu_domain *domain,
> -				 struct device *dev)
> +static bool __iommu_is_attach_deferred(struct iommu_domain *domain,
> +				       struct device *dev)
> +{
> +	if (!domain->ops->is_attach_deferred)
> +		return false;
> +
> +	return domain->ops->is_attach_deferred(domain, dev);
> +}
> +
> +static int __iommu_attach_device_no_defer(struct iommu_domain *domain,
> +					  struct device *dev)
>   {
>   	int ret;
> -	if ((domain->ops->is_attach_deferred != NULL) &&
> -	    domain->ops->is_attach_deferred(domain, dev))
> -		return 0;
>   
>   	if (unlikely(domain->ops->attach_dev == NULL))
>   		return -ENODEV;
> @@ -1903,9 +1909,19 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>   	ret = domain->ops->attach_dev(domain, dev);
>   	if (!ret)
>   		trace_attach_device_to_domain(dev);
> +
>   	return ret;
>   }
>   
> +static int __iommu_attach_device(struct iommu_domain *domain,
> +				 struct device *dev)
> +{
> +	if (__iommu_is_attach_deferred(domain, dev))
> +		return 0;
> +
> +	return __iommu_attach_device_no_defer(domain, dev);
> +}
> +
>   int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
>   {
>   	struct iommu_group *group;
> @@ -2023,7 +2039,12 @@ EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev);
>    */
>   struct iommu_domain *iommu_get_dma_domain(struct device *dev)
>   {
> -	return dev->iommu_group->default_domain;
> +	struct iommu_domain *domain = dev->iommu_group->default_domain;
> +
> +	if (__iommu_is_attach_deferred(domain, dev))
> +		__iommu_attach_device_no_defer(domain, dev);

It seems that the return value needs to be checked. The default domain
is invalid if attach() failed.

Best regards,
baolu
