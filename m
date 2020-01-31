Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C8AC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6603B20658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgAaNOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:14:36 -0500
Received: from foss.arm.com ([217.140.110.172]:35298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728544AbgAaNOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:14:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E18C106F;
        Fri, 31 Jan 2020 05:14:35 -0800 (PST)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A4A63F67D;
        Fri, 31 Jan 2020 05:14:34 -0800 (PST)
Subject: Re: [PATCH] dma-debug: add a per-cpu cache to avoid lock contention
To:     Eric Dumazet <edumazet@google.com>, Christoph Hellwig <hch@lst.de>,
        Joerg Roedel <jroedel@suse.de>
Cc:     iommu@lists.linux-foundation.org,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200130201451.253115-1-edumazet@google.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <87bde968-0103-c90d-380d-e0793cd39aa5@arm.com>
Date:   Fri, 31 Jan 2020 13:14:36 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200130201451.253115-1-edumazet@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-30 8:14 pm, Eric Dumazet via iommu wrote:
> Networking drivers very often have to replace one page with
> another for their RX ring buffers.
> 
> A multi-queue NIC will severly hit a contention point
> in dma-debug while grabbing free_entries_lock spinlock.
> 
> Adding a one entry per-cpu cache removes the need
> to grab this spinlock twice per page replacement.
> 
> Tested on a 40Gbit mlx4 NIC, with 16 RX queues and about
> 1,000,000 replacements per second.

Looks like a decent benefit for minimal collateral impact - from what 
I've seen, networking appears to be a particularly easy place to run 
into awkward races, so mitigating even a little of the debug-induced 
serialisation for the common case can only be good.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks,
Robin.

> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/debug.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index a310dbb1515e92c081f8f3f9a7290dd5e53fc889..b7221426ef49cf640db5bcb261b0817d714a3033 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -97,6 +97,8 @@ static LIST_HEAD(free_entries);
>   /* Lock for the list above */
>   static DEFINE_SPINLOCK(free_entries_lock);
>   
> +static DEFINE_PER_CPU(struct dma_debug_entry *, dma_debug_entry_cache);
> +
>   /* Global disable flag - will be set in case of an error */
>   static bool global_disable __read_mostly;
>   
> @@ -676,6 +678,10 @@ static struct dma_debug_entry *dma_entry_alloc(void)
>   	struct dma_debug_entry *entry;
>   	unsigned long flags;
>   
> +	entry = this_cpu_xchg(dma_debug_entry_cache, NULL);
> +	if (entry)
> +		goto end;
> +
>   	spin_lock_irqsave(&free_entries_lock, flags);
>   	if (num_free_entries == 0) {
>   		if (dma_debug_create_entries(GFP_ATOMIC)) {
> @@ -690,7 +696,7 @@ static struct dma_debug_entry *dma_entry_alloc(void)
>   	entry = __dma_entry_alloc();
>   
>   	spin_unlock_irqrestore(&free_entries_lock, flags);
> -
> +end:
>   #ifdef CONFIG_STACKTRACE
>   	entry->stack_len = stack_trace_save(entry->stack_entries,
>   					    ARRAY_SIZE(entry->stack_entries),
> @@ -705,6 +711,9 @@ static void dma_entry_free(struct dma_debug_entry *entry)
>   
>   	active_cacheline_remove(entry);
>   
> +	if (!this_cpu_cmpxchg(dma_debug_entry_cache, NULL, entry))
> +		return;
> +
>   	/*
>   	 * add to beginning of the list - this way the entries are
>   	 * more likely cache hot when they are reallocated.
> 
