Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B2AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FDAD20674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgERNzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgERNzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:55:05 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6279DC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 06:55:05 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 10B08386; Mon, 18 May 2020 15:55:04 +0200 (CEST)
Date:   Mon, 18 May 2020 15:55:02 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <jroedel@suse.de>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2 23/33] iommu/mediatek-v1 Convert to
 probe/release_device() call-backs
Message-ID: <20200518135502.GE18353@8bytes.org>
References: <20200414131542.25608-1-joro@8bytes.org>
 <20200414131542.25608-24-joro@8bytes.org>
 <1589528699.26119.9.camel@mhfsdcap03>
 <20200515100718.GS18353@8bytes.org>
 <1589784680.15083.19.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589784680.15083.19.camel@mhfsdcap03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 18, 2020 at 02:51:20PM +0800, Yong Wu wrote:
> below is my local patch. split "dma_attach" to attach_device and
> probe_finalize. About attach_device, Use the existed
> __iommu_attach_group instead. Then rename from the "dma_attach" to
> "probe_finalize" to do the probe_finalize job. And move it outside of
> the mutex_unlock.
> 
> I'm not sure if it is right. and of course I will test if you have any
> other solution. Thanks.
> 
> 
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1665,26 +1665,20 @@ static void probe_alloc_default_domain(struct
> bus_type *bus,
>  
>  }
>  
> -static int iommu_group_do_dma_attach(struct device *dev, void *data)
> +static int iommu_group_do_probe_finalize(struct device *dev, void
> *data)
>  {
>  	struct iommu_domain *domain = data;
> -	const struct iommu_ops *ops;
> -	int ret;
> -
> -	ret = __iommu_attach_device(domain, dev);
> -
> -	ops = domain->ops;
> +	const struct iommu_ops *ops = domain->ops;
>  
> -	if (ret == 0 && ops->probe_finalize)
> +	if (ops->probe_finalize)
>  		ops->probe_finalize(dev);
> -
> -	return ret;
> +	return 0;
>  }
>  
> -static int __iommu_group_dma_attach(struct iommu_group *group)
> +static int iommu_group_probe_finalize(struct iommu_group *group)
>  {
>  	return __iommu_group_for_each_dev(group, group->default_domain,
> -					  iommu_group_do_dma_attach);
> +					  iommu_group_do_probe_finalize);
>  }
>  
>  static int iommu_do_create_direct_mappings(struct device *dev, void
> *data)
> @@ -1731,12 +1725,14 @@ int bus_iommu_probe(struct bus_type *bus)
>  
>  		iommu_group_create_direct_mappings(group);
>  
> -		ret = __iommu_group_dma_attach(group);
> +		ret = __iommu_attach_group(group->default_domain, group);
>  
>  		mutex_unlock(&group->mutex);
>  
>  		if (ret)
>  			break;
> +
> +		iommu_group_probe_finalize(group);
>  	}
>  
>  	return ret;
> -- 

Yes, I think moving the probe_finalize call out of the group->mutex
section is the right fix for this issue.

Thanks for reporting it and working on a fix.


Regards,

	Joerg
