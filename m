Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAB2C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D3124673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgBTSma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:42:30 -0500
Received: from foss.arm.com ([217.140.110.172]:49398 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbgBTSm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:42:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7041E30E;
        Thu, 20 Feb 2020 10:42:29 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E8FD3F6CF;
        Thu, 20 Feb 2020 10:42:28 -0800 (PST)
Subject: Re: [RFC PATCH] iommu/iova: Add a best-fit algorithm
To:     isaacm@codeaurora.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, pratikp@codeaurora.org,
        Liam Mark <lmark@codeaurora.org>
References: <1581721602-17010-1-git-send-email-isaacm@codeaurora.org>
 <b9d31aa9-fb57-ad31-52e4-1a5c21e5e0de@arm.com>
 <7239ddd532e94a4371289f3be23c66a3@codeaurora.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <195d44d1-ff92-06fd-8ce8-75cd12d47c43@arm.com>
Date:   Thu, 20 Feb 2020 18:42:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7239ddd532e94a4371289f3be23c66a3@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2020 6:38 am, isaacm@codeaurora.org wrote:
> On 2020-02-17 08:03, Robin Murphy wrote:
>> On 14/02/2020 11:06 pm, Isaac J. Manjarres wrote:
>>> From: Liam Mark <lmark@codeaurora.org>
>>>
>>> Using the best-fit algorithm, instead of the first-fit
>>> algorithm, may reduce fragmentation when allocating
>>> IOVAs.
>>
>> What kind of pathological allocation patterns make that a serious
>> problem? Is there any scope for simply changing the order of things in
>> the callers? Do these drivers also run under other DMA API backends
>> (e.g. 32-bit Arm)?
>>
> The usecases where the IOVA space has been fragmented have 
> non-deterministic allocation
> patterns, and thus, it's not feasible to change the allocation order to 
> avoid fragmenting
> the IOVA space.

What about combining smaller buffers into larger individual allocations; 
any scope for that sort of thing? Certainly if you're consistently 
allocating small things less than PAGE_SIZE then DMA pools would be 
useful to avoid wanton memory wastage in general.

>  From what we've observed, the usecases involve allocations of two types of
> buffers: one type of buffer between 1 KB to 4 MB in size, and another 
> type of
> buffer between 1 KB to 400 MB in size.
> 
> The pathological scenarios seem to arise when there are
> many (100+) randomly distributed non-power of two allocations, which in 
> some cases leaves
> behind holes of up to 100+ MB in the IOVA space.
> 
> Here are some examples that show the state of the IOVA space under which 
> failure to
> allocate an IOVA was observed:
> 
> Instance 1:
>      Currently mapped total size : ~1.3GB
>      Free space available : ~2GB
>      Map for ~162MB fails.
>          Max contiguous space available : < 162MB
> 
> Instance 2:
>      Currently mapped total size : ~950MB
>      Free space available : ~2.3GB
>      Map for ~320MB fails.
>      Max contiguous space available : ~189MB
> 
> Instance 3:
>      Currently mapped total size : ~1.2GB
>      Free space available : ~2.7GB
>      Map for ~162MB fails.
>      Max contiguous space available : <162MB
> 
> We are still in the process of collecting data with the best-fit 
> algorithm enabled
> to provide some numbers to show that it results in less IOVA space
> fragmentation.

Thanks for those examples, and I'd definitely like to see the 
comparative figures. To dig a bit further, at the point where things 
start failing, where are the cached nodes pointing? IIRC there is still 
a pathological condition where empty space between limit_pfn and 
cached32_node gets 'lost' if nothing in between is freed, so the bigger 
the range of allocation sizes, the worse the effect, e.g.:

(considering an empty domain, pfn 0 *not* reserved, 32-bit limit_pfn)

	alloc 4K, succeeds, cached32_node now at 4G-4K
	alloc 2G, succeeds, cached32_node now at 0
	alloc 4K, fails despite almost 2G contiguous free space within limit_pfn
	(and max32_alloc_size==1 now fast-forwards *any* further allocation 
attempt to failure)

If you're falling foul of this case (I was never sure how realistic a 
problem it would be in practice), there are at least a couple of much 
less invasive tweaks I can think of that would be worth exploring.

> To answer your question about whether if this driver run under other DMA 
> API backends:
> yes, such as 32 bit ARM.

OK, that's what I suspected :)

AFAICS arch/arm's __alloc_iova() is also a first-fit algorithm, so if 
you get better behaviour there then it would suggest that this aspect 
isn't really the most important issue. Certainly, the fact that the 
"best fit" logic here also happens to ignore the cached nodes does start 
drawing me back to the point above.

Robin.
