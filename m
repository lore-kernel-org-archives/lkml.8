Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC43C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EFE620758
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgEOPmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:42:25 -0400
Received: from foss.arm.com ([217.140.110.172]:58370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgEOPmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:42:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEA322F;
        Fri, 15 May 2020 08:42:24 -0700 (PDT)
Received: from [10.57.27.64] (unknown [10.57.27.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E26903F71E;
        Fri, 15 May 2020 08:42:23 -0700 (PDT)
Subject: Re: [PATCH] iommu: Implement deferred domain attachment
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, jroedel@suse.de,
        linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>
References: <20200515094519.20338-1-joro@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d4e1cd9e-fc83-d41a-49c0-8f14f44b2701@arm.com>
Date:   Fri, 15 May 2020 16:42:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200515094519.20338-1-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-15 10:45, Joerg Roedel wrote:
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

This raises a red flag, since iommu-dma already has explicit deferred 
attach handling where it should need it, immediately after this is 
called to retrieve the domain. The whole thing smells to me like we 
should have an explicit special-case in iommu_probe_device() rather than 
hooking __iommu_attach_device() in general then having to bodge around 
the fallout elsewhere.

Robin.

> +
> +	return domain;
>   }
>   
>   /*
> 
