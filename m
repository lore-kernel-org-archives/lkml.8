Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1D2CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7676220643
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387603AbgEMN15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:27:57 -0400
Received: from foss.arm.com ([217.140.110.172]:46022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728341AbgEMN15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:27:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D01F230E;
        Wed, 13 May 2020 06:27:56 -0700 (PDT)
Received: from [10.57.36.85] (unknown [10.57.36.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 101FC3F71E;
        Wed, 13 May 2020 06:27:54 -0700 (PDT)
Subject: Re: [PATCH v4 03/38] iommu: add generic helper for mapping sgtable
 objects
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>
References: <20200512085710.14688-1-m.szyprowski@samsung.com>
 <20200512090058.14910-1-m.szyprowski@samsung.com>
 <CGME20200512090108eucas1p2168167ab5e1de09df0d5def83f64dbfe@eucas1p2.samsung.com>
 <20200512090058.14910-3-m.szyprowski@samsung.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a5f6922a-686e-d36d-e706-e36d02bff141@arm.com>
Date:   Wed, 13 May 2020 14:27:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200512090058.14910-3-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-12 10:00 am, Marek Szyprowski wrote:
> struct sg_table is a common structure used for describing a memory
> buffer. It consists of a scatterlist with memory pages and DMA addresses
> (sgl entry), as well as the number of scatterlist entries: CPU pages
> (orig_nents entry) and DMA mapped pages (nents entry).
> 
> It turned out that it was a common mistake to misuse nents and orig_nents
> entries, calling mapping functions with a wrong number of entries.
> 
> To avoid such issues, lets introduce a common wrapper operating directly
> on the struct sg_table objects, which take care of the proper use of
> the nents and orig_nents entries.

Modulo Joerg's comments,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> For more information, see '[PATCH v4 00/38] DRM: fix struct sg_table nents
> vs. orig_nents misuse' thread:
> https://lore.kernel.org/dri-devel/20200512085710.14688-1-m.szyprowski@samsung.com/T/
> ---
>   include/linux/iommu.h | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 7cfd2dd..ba662ba 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -478,6 +478,22 @@ extern size_t iommu_map_sg_atomic(struct iommu_domain *domain,
>   extern void iommu_set_fault_handler(struct iommu_domain *domain,
>   			iommu_fault_handler_t handler, void *token);
>   
> +/**
> + * iommu_map_sgtable - Map the given buffer to the IOMMU domain
> + * @domain:	The IOMMU domain to perfor
> + * @iova:	The start addrees to map the buffer
> + * @sgt:	The sg_table object describing the buffer
> + * @prot:	IOMMU protection bits
> + *
> + * Create a mapping at @iova for the buffer described by a scatterlist
> + * stored in the given sg_table object in the provided IOMMU domain.
> + */
> +static inline size_t iommu_map_sgtable(struct iommu_domain *domain,
> +			unsigned long iova, struct sg_table *sgt, int prot)
> +{
> +	return iommu_map_sg(domain, iova, sgt->sgl, sgt->orig_nents, prot);
> +}
> +
>   extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
>   extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
>   extern void generic_iommu_put_resv_regions(struct device *dev,
> 
