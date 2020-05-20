Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576A8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CF31207D4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgETMZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:25:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:56438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgETMZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:25:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 66EF5AEA7;
        Wed, 20 May 2020 12:25:26 +0000 (UTC)
Subject: Re: [PATCH v3 03/19] mm: memcg: convert vmstat slab counters to bytes
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-4-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <b72ff85a-22aa-f55d-41ee-2ddee00674a7@suse.cz>
Date:   Wed, 20 May 2020 14:25:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422204708.2176080-4-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 10:46 PM, Roman Gushchin wrote:
> In order to prepare for per-object slab memory accounting, convert
> NR_SLAB_RECLAIMABLE and NR_SLAB_UNRECLAIMABLE vmstat items to bytes.
> 
> To make it obvious, rename them to NR_SLAB_RECLAIMABLE_B and
> NR_SLAB_UNRECLAIMABLE_B (similar to NR_KERNEL_STACK_KB).
> 
> Internally global and per-node counters are stored in pages,
> however memcg and lruvec counters are stored in bytes.
> This scheme may look weird, but only for now. As soon as slab
> pages will be shared between multiple cgroups, global and
> node counters will reflect the total number of slab pages.
> However memcg and lruvec counters will be used for per-memcg
> slab memory tracking, which will take separate kernel objects
> in the account. Keeping global and node counters in pages helps
> to avoid additional overhead.
> 
> The size of slab memory shouldn't exceed 4Gb on 32-bit machines,
> so it will fit into atomic_long_t we use for vmstats.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  drivers/base/node.c     |  4 ++--
>  fs/proc/meminfo.c       |  4 ++--
>  include/linux/mmzone.h  | 16 +++++++++++++---
>  kernel/power/snapshot.c |  2 +-
>  mm/memcontrol.c         | 11 ++++-------
>  mm/oom_kill.c           |  2 +-
>  mm/page_alloc.c         |  8 ++++----
>  mm/slab.h               | 15 ++++++++-------
>  mm/slab_common.c        |  4 ++--
>  mm/slob.c               | 12 ++++++------
>  mm/slub.c               |  8 ++++----
>  mm/vmscan.c             |  3 ++-
>  mm/workingset.c         |  6 ++++--
>  13 files changed, 53 insertions(+), 42 deletions(-)


> @@ -206,7 +206,17 @@ enum node_stat_item {
>  
>  static __always_inline bool vmstat_item_in_bytes(enum node_stat_item item)
>  {
> -	return false;
> +	/*
> +	 * Global and per-node slab counters track slab pages.
> +	 * It's expected that changes are multiples of PAGE_SIZE.
> +	 * Internally values are stored in pages.
> +	 *
> +	 * Per-memcg and per-lruvec counters track memory, consumed
> +	 * by individual slab objects. These counters are actually
> +	 * byte-precise.
> +	 */
> +	return (item == NR_SLAB_RECLAIMABLE_B ||
> +		item == NR_SLAB_UNRECLAIMABLE_B);
>  }

Ok, so this is no longer a no-op, but __always_inline here and inline in
global_node_page_state() should hopefully mean that for all users of
global_node_page_state(<constant>) the compiler will eliminate the branch for
non-slab counters. But there are also functions such as si_mem_available() that
use non-constant item. Maybe compiler is smart enough anyway, but perhaps it's
better to use global_node_page_state_pages() in such callers?

However __mod_node_page_state() and mode_node_state() will now branch always. I
wonder if the "API clean" goal is worth it...

> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1409,9 +1409,8 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>  		       (u64)memcg_page_state(memcg, MEMCG_KERNEL_STACK_KB) *
>  		       1024);
>  	seq_buf_printf(&s, "slab %llu\n",
> -		       (u64)(memcg_page_state(memcg, NR_SLAB_RECLAIMABLE) +
> -			     memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE)) *
> -		       PAGE_SIZE);
> +		       (u64)(memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B) +
> +			     memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B)));
>  	seq_buf_printf(&s, "sock %llu\n",
>  		       (u64)memcg_page_state(memcg, MEMCG_SOCK) *
>  		       PAGE_SIZE);
> @@ -1445,11 +1444,9 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>  			       PAGE_SIZE);
>  
>  	seq_buf_printf(&s, "slab_reclaimable %llu\n",
> -		       (u64)memcg_page_state(memcg, NR_SLAB_RECLAIMABLE) *
> -		       PAGE_SIZE);
> +		       (u64)memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B));
>  	seq_buf_printf(&s, "slab_unreclaimable %llu\n",
> -		       (u64)memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE) *
> -		       PAGE_SIZE);
> +		       (u64)memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B));

So here we are now printing in bytes instead of pages, right? That's fine for
OOM report, but in sysfs aren't we breaking existing users?

