Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF474C2BA15
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 11:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D085120757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 11:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388133AbgDBLgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 07:36:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:54464 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388048AbgDBLgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 07:36:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C93B3AAB8;
        Thu,  2 Apr 2020 11:36:37 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] mm: call touch_nmi_watchdog() on max order
 boundaries in deferred init
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, linux-mm@kvack.org, dan.j.williams@intel.com,
        shile.zhang@linux.alibaba.com, daniel.m.jordan@oracle.com,
        ktkhai@virtuozzo.com, david@redhat.com, jmorris@namei.org,
        sashal@kernel.org
References: <20200401225723.14164-1-pasha.tatashin@soleen.com>
 <20200401225723.14164-2-pasha.tatashin@soleen.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7af01656-e961-8c7b-42e5-432ec0d18d4b@suse.cz>
Date:   Thu, 2 Apr 2020 13:36:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401225723.14164-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/20 12:57 AM, Pavel Tatashin wrote:
> From: Daniel Jordan <daniel.m.jordan@oracle.com>
> 
> deferred_init_memmap() disables interrupts the entire time, so it calls
> touch_nmi_watchdog() periodically to avoid soft lockup splats.  Soon it
> will run with interrupts enabled, at which point cond_resched() should
> be used instead.
> 
> deferred_grow_zone() makes the same watchdog calls through code shared
> with deferred init but will continue to run with interrupts disabled, so
> it can't call cond_resched().
> 
> Pull the watchdog calls up to these two places to allow the first to be
> changed later, independently of the second.  The frequency reduces from
> twice per pageblock (init and free) to once per max order block.
> 
> Fixes: 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred pages")
> Cc: stable@vger.kernel.org # 4.17+
> 
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3c4eb750a199..e8ff6a176164 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1639,7 +1639,6 @@ static void __init deferred_free_pages(unsigned long pfn,
>  		} else if (!(pfn & nr_pgmask)) {
>  			deferred_free_range(pfn - nr_free, nr_free);
>  			nr_free = 1;
> -			touch_nmi_watchdog();
>  		} else {
>  			nr_free++;
>  		}
> @@ -1669,7 +1668,6 @@ static unsigned long  __init deferred_init_pages(struct zone *zone,
>  			continue;
>  		} else if (!page || !(pfn & nr_pgmask)) {
>  			page = pfn_to_page(pfn);
> -			touch_nmi_watchdog();
>  		} else {
>  			page++;
>  		}
> @@ -1809,8 +1807,10 @@ static int __init deferred_init_memmap(void *data)
>  	 * that we can avoid introducing any issues with the buddy
>  	 * allocator.
>  	 */
> -	while (spfn < epfn)
> +	while (spfn < epfn) {
>  		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
> +		touch_nmi_watchdog();
> +	}
>  zone_empty:
>  	pgdat_resize_unlock(pgdat, &flags);
>  
> @@ -1894,6 +1894,7 @@ deferred_grow_zone(struct zone *zone, unsigned int order)
>  		first_deferred_pfn = spfn;
>  
>  		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
> +		touch_nmi_watchdog();
>  
>  		/* We should only stop along section boundaries */
>  		if ((first_deferred_pfn ^ spfn) < PAGES_PER_SECTION)
> 

