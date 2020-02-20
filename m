Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A760C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24CD24672
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgBTRfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:35:41 -0500
Received: from foss.arm.com ([217.140.110.172]:47962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbgBTRfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:35:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC7F831B;
        Thu, 20 Feb 2020 09:35:40 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EFF93F68F;
        Thu, 20 Feb 2020 09:35:39 -0800 (PST)
Subject: Re: [RFC PATCH] iommu/iova: Support limiting IOVA alignment
To:     Liam Mark <lmark@codeaurora.org>, Will Deacon <will@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        iommu@lists.linux-foundation.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org
References: <alpine.DEB.2.10.2002141223510.27047@lmark-linux.qualcomm.com>
 <e9ae618c-58d4-d245-be80-e62fbde4f907@arm.com>
 <20200219123704.GC19400@willie-the-truck>
 <alpine.DEB.2.10.2002191517150.636@lmark-linux.qualcomm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f0d4312b-a451-691a-3fcd-e9c90f6c5308@arm.com>
Date:   Thu, 20 Feb 2020 17:35:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.2002191517150.636@lmark-linux.qualcomm.com>
Content-Type: text/plain; charset=iso-8859-7; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2020 11:22 pm, Liam Mark wrote:
> On Wed, 19 Feb 2020, Will Deacon wrote:
> 
>> On Mon, Feb 17, 2020 at 04:46:14PM +0000, Robin Murphy wrote:
>>> On 14/02/2020 8:30 pm, Liam Mark wrote:
>>>>
>>>> When the IOVA framework applies IOVA alignment it aligns all
>>>> IOVAs to the smallest PAGE_SIZE order which is greater than or
>>>> equal to the requested IOVA size.
>>>>
>>>> We support use cases that requires large buffers (> 64 MB in
>>>> size) to be allocated and mapped in their stage 1 page tables.
>>>> However, with this alignment scheme we find ourselves running
>>>> out of IOVA space for 32 bit devices, so we are proposing this
>>>> config, along the similar vein as CONFIG_CMA_ALIGNMENT for CMA
>>>> allocations.
>>>
>>> As per [1], I'd really like to better understand the allocation patterns
>>> that lead to such a sparsely-occupied address space to begin with, given
>>> that the rbtree allocator is supposed to try to maintain locality as far as
>>> possible, and the rcaches should further improve on that. Are you also
>>> frequently cycling intermediate-sized buffers which are smaller than 64MB
>>> but still too big to be cached?  Are there a lot of non-power-of-two
>>> allocations?
>>
>> Right, information on the allocation pattern would help with this change
>> and also the choice of IOVA allocation algorithm. Without it, we're just
>> shooting in the dark.
>>
> 
> Thanks for the responses.
> 
> I am looking into how much of our allocation pattern details I can share.
> 
> My general understanding is that this issue occurs on a 32bit devices
> which have additional restrictions on the IOVA range they can use within those
> 32bits.
> 
> An example is a use case which involves allocating a lot of buffers ~80MB
> is size, the current algorithm will require an alignment of 128MB for
> those buffers. My understanding is that it simply can't accommodate the number of 80MB
> buffers that are required because the of amount of IOVA space which can't
> be used because of the 128MB alignment requirement.

OK, that's a case I can understand :)

>>>> Add CONFIG_IOMMU_LIMIT_IOVA_ALIGNMENT to limit the alignment of
>>>> IOVAs to some desired PAGE_SIZE order, specified by
>>>> CONFIG_IOMMU_IOVA_ALIGNMENT. This helps reduce the impact of
>>>> fragmentation caused by the current IOVA alignment scheme, and
>>>> gives better IOVA space utilization.
>>>
>>> Even if the general change did prove reasonable, this IOVA allocator is not
>>> owned by the DMA API, so entirely removing the option of strict
>>> size-alignment feels a bit uncomfortable. Personally I'd replace the bool
>>> argument with an actual alignment value to at least hand the authority out
>>> to individual callers.
>>>
>>> Furthermore, even in DMA API terms, is anyone really ever going to bother
>>> tuning that config? Since iommu-dma is supposed to be a transparent layer,
>>> arguably it shouldn't behave unnecessarily differently from CMA, so simply
>>> piggy-backing off CONFIG_CMA_ALIGNMENT would seem logical.
>>
>> Agreed, reusing CONFIG_CMA_ALIGNMENT makes a lot of sense here as callers
>> relying on natural alignment of DMA buffer allocations already have to
>> deal with that limitation. We could fix it as an optional parameter at
>> init time (init_iova_domain()), and have the DMA IOMMU implementation
>> pass it in there.
>>
> 
> My concern with using CONFIG_CMA_ALIGNMENT alignment is that for us this
> would either involve further fragmenting our CMA regions (moving our CMA
> max alignment from 1MB to max 2MB) or losing so of our 2MB IOVA block
> mappings (changing our IOVA max alignment form 2MB to 1MB).
> 
> At least for us CMA allocations are often not DMA mapped into stage 1 page
> tables so moving the CMA max alignment to 2MB in our case would, I think,
> only provide the disadvantage of having to increase the size our CMA
> regions to accommodate this large alignment (which isn¢t optimal for
> memory utilization since CMA regions can't satisfy unmovable page
> allocations).
> 
> As an alternative would it be possible for the dma-iommu layer to use the
> size of the allocation and the domain pgsize_bitmap field to pick a max
> IOVA alignment, which it can pass in for that IOVA allocation, which will
> maximize block mappings but not waste IOVA space?

Given that we already have DMA_ATTR_ALOC_SINGLE_PAGES for video drivers 
and suchlike that know enough to know they want "large buffer" 
allocation behaviour, would it suffice to have a similar attribute that 
says "I'm not too fussed about alignment"? That way there's no visible 
change for anyone who doesn't opt in and might be relying on the 
existing behaviour, intentionally or otherwise.

Then if necessary, the implementation can consider both flags together 
to decide whether to try to round down to the next block size or just 
shove it in anywhere.

Robin.
