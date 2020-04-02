Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFB4C2BA15
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F7E20757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388217AbgDBMJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 08:09:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:39218 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387958AbgDBMJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 08:09:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 85F2CAA55;
        Thu,  2 Apr 2020 12:09:24 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] mm: initialize deferred pages with interrupts
 enabled
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, linux-mm@kvack.org, dan.j.williams@intel.com,
        shile.zhang@linux.alibaba.com, daniel.m.jordan@oracle.com,
        ktkhai@virtuozzo.com, david@redhat.com, jmorris@namei.org,
        sashal@kernel.org
References: <20200401225723.14164-1-pasha.tatashin@soleen.com>
 <20200401225723.14164-3-pasha.tatashin@soleen.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <8a2fbe6b-c861-9d47-9f02-72d476265359@suse.cz>
Date:   Thu, 2 Apr 2020 14:09:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401225723.14164-3-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/20 12:57 AM, Pavel Tatashin wrote:
> Initializing struct pages is a long task and keeping interrupts disabled
> for the duration of this operation introduces a number of problems.
> 
> 1. jiffies are not updated for long period of time, and thus incorrect time
>    is reported. See proposed solution and discussion here:
>    lkml/20200311123848.118638-1-shile.zhang@linux.alibaba.com
> 2. It prevents farther improving deferred page initialization by allowing
>    intra-node multi-threading.
> 
> We are keeping interrupts disabled to solve a rather theoretical problem
> that was never observed in real world (See 3a2d7fa8a3d5).
> 
> Lets keep interrupts enabled. In case we ever encounter a scenario where
> an interrupt thread wants to allocate large amount of memory this early in
> boot we can deal with that by growing zone (see deferred_grow_zone()) by
> the needed amount before starting deferred_init_memmap() threads.
> 
> Before:
> [    1.232459] node 0 initialised, 12058412 pages in 1ms
> 
> After:
> [    1.632580] node 0 initialised, 12051227 pages in 436ms
> 
> Fixes: 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred pages")
> Cc: stable@vger.kernel.org # 4.17+

TBH I don't remember my concern anymore. Reading my mail now [1] it seems I was
thinking the problem could happen not just in interrupt context, but with other
kthreads as well.
Anyway I agree with the approach of waiting for actual issues being reported and
then eventually pre-growing more.

Acked-by: Vlastimil Babka <vbabka@suse.cz>

[1] https://lore.kernel.org/linux-mm/33e3a3ff-0318-1a07-3c57-6be638046c87@suse.cz/

> Reported-by: Shile Zhang <shile.zhang@linux.alibaba.com>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  include/linux/mmzone.h |  2 ++
>  mm/page_alloc.c        | 22 ++++++++--------------
>  2 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 462f6873905a..c5bdf55da034 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -721,6 +721,8 @@ typedef struct pglist_data {
>  	/*
>  	 * Must be held any time you expect node_start_pfn,
>  	 * node_present_pages, node_spanned_pages or nr_zones to stay constant.
> +	 * Also synchronizes pgdat->first_deferred_pfn during deferred page
> +	 * init.
>  	 *
>  	 * pgdat_resize_lock() and pgdat_resize_unlock() are provided to
>  	 * manipulate node_size_lock without checking for CONFIG_MEMORY_HOTPLUG
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e8ff6a176164..68669d3a5a66 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1790,6 +1790,13 @@ static int __init deferred_init_memmap(void *data)
>  	BUG_ON(pgdat->first_deferred_pfn > pgdat_end_pfn(pgdat));
>  	pgdat->first_deferred_pfn = ULONG_MAX;
>  
> +	/*
> +	 * Once we unlock here, the zone cannot be grown anymore, thus if an
> +	 * interrupt thread must allocate this early in boot, zone must be
> +	 * pre-grown prior to start of deferred page initialization.
> +	 */
> +	pgdat_resize_unlock(pgdat, &flags);
> +
>  	/* Only the highest zone is deferred so find it */
>  	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
>  		zone = pgdat->node_zones + zid;
> @@ -1809,11 +1816,9 @@ static int __init deferred_init_memmap(void *data)
>  	 */
>  	while (spfn < epfn) {
>  		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
> -		touch_nmi_watchdog();
> +		cond_resched();
>  	}
>  zone_empty:
> -	pgdat_resize_unlock(pgdat, &flags);
> -
>  	/* Sanity check that the next zone really is unpopulated */
>  	WARN_ON(++zid < MAX_NR_ZONES && populated_zone(++zone));
>  
> @@ -1855,17 +1860,6 @@ deferred_grow_zone(struct zone *zone, unsigned int order)
>  
>  	pgdat_resize_lock(pgdat, &flags);
>  
> -	/*
> -	 * If deferred pages have been initialized while we were waiting for
> -	 * the lock, return true, as the zone was grown.  The caller will retry
> -	 * this zone.  We won't return to this function since the caller also
> -	 * has this static branch.
> -	 */
> -	if (!static_branch_unlikely(&deferred_pages)) {
> -		pgdat_resize_unlock(pgdat, &flags);
> -		return true;
> -	}
> -
>  	/*
>  	 * If someone grew this zone while we were waiting for spinlock, return
>  	 * true, as there might be enough pages already.
> 

