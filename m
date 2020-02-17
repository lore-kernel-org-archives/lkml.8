Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB17C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578E920679
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbgBQQqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:46:18 -0500
Received: from foss.arm.com ([217.140.110.172]:38390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728821AbgBQQqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:46:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6FF430E;
        Mon, 17 Feb 2020 08:46:16 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD2853F68F;
        Mon, 17 Feb 2020 08:46:15 -0800 (PST)
Subject: Re: [RFC PATCH] iommu/iova: Support limiting IOVA alignment
To:     Liam Mark <lmark@codeaurora.org>, Joerg Roedel <joro@8bytes.org>
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        iommu@lists.linux-foundation.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org
References: <alpine.DEB.2.10.2002141223510.27047@lmark-linux.qualcomm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e9ae618c-58d4-d245-be80-e62fbde4f907@arm.com>
Date:   Mon, 17 Feb 2020 16:46:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.2002141223510.27047@lmark-linux.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2020 8:30 pm, Liam Mark wrote:
> 
> When the IOVA framework applies IOVA alignment it aligns all
> IOVAs to the smallest PAGE_SIZE order which is greater than or
> equal to the requested IOVA size.
> 
> We support use cases that requires large buffers (> 64 MB in
> size) to be allocated and mapped in their stage 1 page tables.
> However, with this alignment scheme we find ourselves running
> out of IOVA space for 32 bit devices, so we are proposing this
> config, along the similar vein as CONFIG_CMA_ALIGNMENT for CMA
> allocations.

As per [1], I'd really like to better understand the allocation patterns 
that lead to such a sparsely-occupied address space to begin with, given 
that the rbtree allocator is supposed to try to maintain locality as far 
as possible, and the rcaches should further improve on that. Are you 
also frequently cycling intermediate-sized buffers which are smaller 
than 64MB but still too big to be cached?  Are there a lot of 
non-power-of-two allocations?

> Add CONFIG_IOMMU_LIMIT_IOVA_ALIGNMENT to limit the alignment of
> IOVAs to some desired PAGE_SIZE order, specified by
> CONFIG_IOMMU_IOVA_ALIGNMENT. This helps reduce the impact of
> fragmentation caused by the current IOVA alignment scheme, and
> gives better IOVA space utilization.

Even if the general change did prove reasonable, this IOVA allocator is 
not owned by the DMA API, so entirely removing the option of strict 
size-alignment feels a bit uncomfortable. Personally I'd replace the 
bool argument with an actual alignment value to at least hand the 
authority out to individual callers.

Furthermore, even in DMA API terms, is anyone really ever going to 
bother tuning that config? Since iommu-dma is supposed to be a 
transparent layer, arguably it shouldn't behave unnecessarily 
differently from CMA, so simply piggy-backing off CONFIG_CMA_ALIGNMENT 
would seem logical.

Robin.

[1] 
https://lore.kernel.org/linux-iommu/1581721602-17010-1-git-send-email-isaacm@codeaurora.org/

> Signed-off-by: Liam Mark <lmark@codeaurora.org>
> ---
>   drivers/iommu/Kconfig | 31 +++++++++++++++++++++++++++++++
>   drivers/iommu/iova.c  | 20 +++++++++++++++++++-
>   2 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index d2fade984999..9684a153cc72 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -3,6 +3,37 @@
>   config IOMMU_IOVA
>   	tristate
>   
> +if IOMMU_IOVA
> +
> +config IOMMU_LIMIT_IOVA_ALIGNMENT
> +	bool "Limit IOVA alignment"
> +	help
> +	  When the IOVA framework applies IOVA alignment it aligns all
> +	  IOVAs to the smallest PAGE_SIZE order which is greater than or
> +	  equal to the requested IOVA size. This works fine for sizes up
> +	  to several MiB, but for larger sizes it results in address
> +	  space wastage and fragmentation. For example drivers with a 4
> +	  GiB IOVA space might run out of IOVA space when allocating
> +	  buffers great than 64 MiB.
> +
> +	  Enable this option to impose a limit on the alignment of IOVAs.
> +
> +	  If unsure, say N.
> +
> +config IOMMU_IOVA_ALIGNMENT
> +	int "Maximum PAGE_SIZE order of alignment for IOVAs"
> +	depends on IOMMU_LIMIT_IOVA_ALIGNMENT
> +	range 4 9
> +	default 9
> +	help
> +	  With this parameter you can specify the maximum PAGE_SIZE order for
> +	  IOVAs. Larger IOVAs will be aligned only to this specified order.
> +	  The order is expressed a power of two multiplied by the PAGE_SIZE.
> +
> +	  If unsure, leave the default value "9".
> +
> +endif
> +
>   # The IOASID library may also be used by non-IOMMU_API users
>   config IOASID
>   	tristate
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 0e6a9536eca6..259884c8dbd1 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -177,6 +177,24 @@ int init_iova_flush_queue(struct iova_domain *iovad,
>   	rb_insert_color(&iova->node, root);
>   }
>   
> +#ifdef CONFIG_IOMMU_LIMIT_IOVA_ALIGNMENT
> +static unsigned long limit_align_shift(struct iova_domain *iovad,
> +				       unsigned long shift)
> +{
> +	unsigned long max_align_shift;
> +
> +	max_align_shift = CONFIG_IOMMU_IOVA_ALIGNMENT + PAGE_SHIFT
> +			- iova_shift(iovad);
> +	return min_t(unsigned long, max_align_shift, shift);
> +}
> +#else
> +static unsigned long limit_align_shift(struct iova_domain *iovad,
> +				       unsigned long shift)
> +{
> +	return shift;
> +}
> +#endif
> +
>   static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>   		unsigned long size, unsigned long limit_pfn,
>   			struct iova *new, bool size_aligned)
> @@ -188,7 +206,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>   	unsigned long align_mask = ~0UL;
>   
>   	if (size_aligned)
> -		align_mask <<= fls_long(size - 1);
> +		align_mask <<= limit_align_shift(iovad, fls_long(size - 1));
>   
>   	/* Walk the tree backwards */
>   	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> 
