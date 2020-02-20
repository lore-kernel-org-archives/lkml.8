Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74695C761A1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3736624654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Tk9Eey1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgBTGi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:38:28 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:55238 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726759AbgBTGi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:38:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582180706; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Izr/vsm9x+ObsGmkOF8JwUW+2DRyGOYwxwFKyWQAf60=;
 b=Tk9Eey1v8MOtezX2F9xmfrv3V5VpcljrTfsWUOV+pQSOYmbwRotAJ3PV2GD73APxE4QTEt0n
 eF14kTqrKH/O5wnVwL95siS9bkOmH769eychuxw64DCl0WFD4ZoQyPOYj5mUGEI46AYja7ID
 Q2f7S4yhHIWy7qe+F0exd8BZlGY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4e2961.7fafa2534f48-smtp-out-n01;
 Thu, 20 Feb 2020 06:38:25 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BA093C4479C; Thu, 20 Feb 2020 06:38:25 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA7DAC43383;
        Thu, 20 Feb 2020 06:38:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Feb 2020 22:38:24 -0800
From:   isaacm@codeaurora.org
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, pratikp@codeaurora.org,
        Liam Mark <lmark@codeaurora.org>
Subject: Re: [RFC PATCH] iommu/iova: Add a best-fit algorithm
In-Reply-To: <b9d31aa9-fb57-ad31-52e4-1a5c21e5e0de@arm.com>
References: <1581721602-17010-1-git-send-email-isaacm@codeaurora.org>
 <b9d31aa9-fb57-ad31-52e4-1a5c21e5e0de@arm.com>
Message-ID: <7239ddd532e94a4371289f3be23c66a3@codeaurora.org>
X-Sender: isaacm@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-17 08:03, Robin Murphy wrote:
> On 14/02/2020 11:06 pm, Isaac J. Manjarres wrote:
>> From: Liam Mark <lmark@codeaurora.org>
>> 
>> Using the best-fit algorithm, instead of the first-fit
>> algorithm, may reduce fragmentation when allocating
>> IOVAs.
> 
> What kind of pathological allocation patterns make that a serious
> problem? Is there any scope for simply changing the order of things in
> the callers? Do these drivers also run under other DMA API backends
> (e.g. 32-bit Arm)?
> 
The usecases where the IOVA space has been fragmented have 
non-deterministic allocation
patterns, and thus, it's not feasible to change the allocation order to 
avoid fragmenting
the IOVA space.

 From what we've observed, the usecases involve allocations of two types 
of
buffers: one type of buffer between 1 KB to 4 MB in size, and another 
type of
buffer between 1 KB to 400 MB in size.

The pathological scenarios seem to arise when there are
many (100+) randomly distributed non-power of two allocations, which in 
some cases leaves
behind holes of up to 100+ MB in the IOVA space.

Here are some examples that show the state of the IOVA space under which 
failure to
allocate an IOVA was observed:

Instance 1:
	Currently mapped total size : ~1.3GB
	Free space available : ~2GB
	Map for ~162MB fails.
         Max contiguous space available : < 162MB

Instance 2:
	Currently mapped total size : ~950MB
	Free space available : ~2.3GB
	Map for ~320MB fails.
	Max contiguous space available : ~189MB

Instance 3:
	Currently mapped total size : ~1.2GB
	Free space available : ~2.7GB
	Map for ~162MB fails.
	Max contiguous space available : <162MB

We are still in the process of collecting data with the best-fit 
algorithm enabled
to provide some numbers to show that it results in less IOVA space
fragmentation.

To answer your question about whether if this driver run under other DMA 
API backends:
yes, such as 32 bit ARM.
> More generally, if a driver knows enough to want to second-guess a
> generic DMA API allocator, that's a reasonable argument that it should
> perhaps be properly IOMMU-aware and managing its own address space
> anyway. Perhaps this effort might be better spent finishing off the
> DMA ops bypass stuff to make that approach more robust and welcoming.
> 
> Robin.
> 
>> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
>> ---
>>   drivers/iommu/dma-iommu.c | 17 +++++++++++
>>   drivers/iommu/iova.c      | 73 
>> +++++++++++++++++++++++++++++++++++++++++++++--
>>   include/linux/dma-iommu.h |  7 +++++
>>   include/linux/iova.h      |  1 +
>>   4 files changed, 96 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index a2e96a5..af08770 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -364,9 +364,26 @@ static int iommu_dma_deferred_attach(struct 
>> device *dev,
>>   	if (unlikely(ops->is_attach_deferred &&
>>   			ops->is_attach_deferred(domain, dev)))
>>   		return iommu_attach_device(domain, dev);
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Should be called prior to using dma-apis.
>> + */
>> +int iommu_dma_enable_best_fit_algo(struct device *dev)
>> +{
>> +	struct iommu_domain *domain;
>> +	struct iova_domain *iovad;
>> +
>> +	domain = iommu_get_domain_for_dev(dev);
>> +	if (!domain || !domain->iova_cookie)
>> +		return -EINVAL;
>>   +	iovad = &((struct iommu_dma_cookie *)domain->iova_cookie)->iovad;
>> +	iovad->best_fit = true;
>>   	return 0;
>>   }
>> +EXPORT_SYMBOL(iommu_dma_enable_best_fit_algo);
>>     /**
>>    * dma_info_to_prot - Translate DMA API directions and attributes to 
>> IOMMU API
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index 0e6a953..716b05f 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -50,6 +50,7 @@ static unsigned long iova_rcache_get(struct 
>> iova_domain *iovad,
>>   	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
>>   	rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
>>   	rb_insert_color(&iovad->anchor.node, &iovad->rbroot);
>> +	iovad->best_fit = false;
>>   	init_iova_rcaches(iovad);
>>   }
>>   EXPORT_SYMBOL_GPL(init_iova_domain);
>> @@ -227,6 +228,69 @@ static int __alloc_and_insert_iova_range(struct 
>> iova_domain *iovad,
>>   	return -ENOMEM;
>>   }
>>   +static int __alloc_and_insert_iova_best_fit(struct iova_domain 
>> *iovad,
>> +		unsigned long size, unsigned long limit_pfn,
>> +			struct iova *new, bool size_aligned)
>> +{
>> +	struct rb_node *curr, *prev;
>> +	struct iova *curr_iova, *prev_iova;
>> +	unsigned long flags;
>> +	unsigned long align_mask = ~0UL;
>> +	struct rb_node *candidate_rb_parent;
>> +	unsigned long new_pfn, candidate_pfn = ~0UL;
>> +	unsigned long gap, candidate_gap = ~0UL;
>> +
>> +	if (size_aligned)
>> +		align_mask <<= limit_align(iovad, fls_long(size - 1));
>> +
>> +	/* Walk the tree backwards */
>> +	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
>> +	curr = &iovad->anchor.node;
>> +	prev = rb_prev(curr);
>> +	for (; prev; curr = prev, prev = rb_prev(curr)) {
>> +		curr_iova = rb_entry(curr, struct iova, node);
>> +		prev_iova = rb_entry(prev, struct iova, node);
>> +
>> +		limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
>> +		new_pfn = (limit_pfn - size) & align_mask;
>> +		gap = curr_iova->pfn_lo - prev_iova->pfn_hi - 1;
>> +		if ((limit_pfn >= size) && (new_pfn > prev_iova->pfn_hi)
>> +				&& (gap < candidate_gap)) {
>> +			candidate_gap = gap;
>> +			candidate_pfn = new_pfn;
>> +			candidate_rb_parent = curr;
>> +			if (gap == size)
>> +				goto insert;
>> +		}
>> +	}
>> +
>> +	curr_iova = rb_entry(curr, struct iova, node);
>> +	limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
>> +	new_pfn = (limit_pfn - size) & align_mask;
>> +	gap = curr_iova->pfn_lo - iovad->start_pfn;
>> +	if (limit_pfn >= size && new_pfn >= iovad->start_pfn &&
>> +			gap < candidate_gap) {
>> +		candidate_gap = gap;
>> +		candidate_pfn = new_pfn;
>> +		candidate_rb_parent = curr;
>> +	}
>> +
>> +insert:
>> +	if (candidate_pfn == ~0UL) {
>> +		spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	/* pfn_lo will point to size aligned address if size_aligned is set 
>> */
>> +	new->pfn_lo = candidate_pfn;
>> +	new->pfn_hi = new->pfn_lo + size - 1;
>> +
>> +	/* If we have 'prev', it's a valid place to start the insertion. */
>> +	iova_insert_rbtree(&iovad->rbroot, new, candidate_rb_parent);
>> +	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
>> +	return 0;
>> +}
>> +
>>   static struct kmem_cache *iova_cache;
>>   static unsigned int iova_cache_users;
>>   static DEFINE_MUTEX(iova_cache_mutex);
>> @@ -302,8 +366,13 @@ struct iova *
>>   	if (!new_iova)
>>   		return NULL;
>>   -	ret = __alloc_and_insert_iova_range(iovad, size, limit_pfn + 1,
>> -			new_iova, size_aligned);
>> +	if (iovad->best_fit) {
>> +		ret = __alloc_and_insert_iova_best_fit(iovad, size,
>> +				limit_pfn + 1, new_iova, size_aligned);
>> +	} else {
>> +		ret = __alloc_and_insert_iova_range(iovad, size, limit_pfn + 1,
>> +				new_iova, size_aligned);
>> +	}
>>     	if (ret) {
>>   		free_iova_mem(new_iova);
>> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
>> index 2112f21..b01a31a 100644
>> --- a/include/linux/dma-iommu.h
>> +++ b/include/linux/dma-iommu.h
>> @@ -37,6 +37,8 @@ void iommu_dma_compose_msi_msg(struct msi_desc 
>> *desc,
>>     void iommu_dma_get_resv_regions(struct device *dev, struct 
>> list_head *list);
>>   +int iommu_dma_enable_best_fit_algo(struct device *dev);
>> +
>>   #else /* CONFIG_IOMMU_DMA */
>>     struct iommu_domain;
>> @@ -78,5 +80,10 @@ static inline void 
>> iommu_dma_get_resv_regions(struct device *dev, struct list_he
>>   {
>>   }
>>   +static inline int iommu_dma_enable_best_fit_algo(struct device 
>> *dev)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>>   #endif	/* CONFIG_IOMMU_DMA */
>>   #endif	/* __DMA_IOMMU_H */
>> diff --git a/include/linux/iova.h b/include/linux/iova.h
>> index a0637ab..58713bb 100644
>> --- a/include/linux/iova.h
>> +++ b/include/linux/iova.h
>> @@ -95,6 +95,7 @@ struct iova_domain {
>>   						   flush-queues */
>>   	atomic_t fq_timer_on;			/* 1 when timer is active, 0
>>   						   when not */
>> +	bool best_fit;
>>   };
>>     static inline unsigned long iova_size(struct iova *iova)
>> 
