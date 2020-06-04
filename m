Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D1FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D7420835
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgFDNfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:35:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:43498 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728323AbgFDNfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:35:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E74FFAB64;
        Thu,  4 Jun 2020 13:35:32 +0000 (UTC)
Subject: Re: [PATCH 05/14] mm: workingset: let cache workingset challenge anon
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <js1304@gmail.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
References: <20200520232525.798933-1-hannes@cmpxchg.org>
 <20200520232525.798933-6-hannes@cmpxchg.org>
 <CAAmzW4MMLw=4BHRtt=g8BHpQLTaSmhG03Ct6WMjmDxVnOkNQYA@mail.gmail.com>
 <20200527134333.GF6781@cmpxchg.org>
 <CAAmzW4NW+cv7VnNApWKJr4r9=QKaufK3y5apyNXo-M-y=q0dgg@mail.gmail.com>
 <20200528170155.GA69521@cmpxchg.org>
 <CAAmzW4NEPZRWL5PBXEWwg9kBOL9fYUNqTTzh3WRDWbaSPLv=CQ@mail.gmail.com>
 <20200529151228.GA92892@cmpxchg.org>
 <CAAmzW4Pccc4UcBThhKyqbtY=kK83Fz7k4vYR4eJN4te2E25=_A@mail.gmail.com>
 <20200601155615.GA131075@cmpxchg.org> <20200601204424.GA212944@cmpxchg.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <561b79e8-48c7-f2eb-6081-cd82ad7e6010@suse.cz>
Date:   Thu, 4 Jun 2020 15:35:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200601204424.GA212944@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/20 10:44 PM, Johannes Weiner wrote:
> From a8faceabc1454dfd878caee2a8422493d937a394 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Mon, 1 Jun 2020 14:04:09 -0400
> Subject: [PATCH] mm: workingset: let cache workingset challenge anon fix

Looks like the whole series is now in mainline (that was quick!) without this
followup? As such it won't be squashed so perhaps the subject should be more
"standalone" now, description referencing commit 34e58cac6d8f ("mm: workingset:
let cache workingset challenge anon"), possibly with Fixes: tag etc...

> We compare refault distances to active_file + anon. But age of the
> non-resident information is only driven by the file LRU. As a result,
> we may overestimate the recency of any incoming refaults and activate
> them too eagerly, causing unnecessary LRU churn in certain situations.
> 
> Make anon aging drive nonresident age as well to address that.
> 
> Reported-by: Joonsoo Kim <js1304@gmail.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  include/linux/memcontrol.h | 13 +++++++++++
>  include/linux/mmzone.h     |  4 ++--
>  include/linux/swap.h       |  1 +
>  mm/vmscan.c                |  3 +++
>  mm/workingset.c            | 46 ++++++++++++++++++++++----------------
>  5 files changed, 46 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 32a0b4d47540..d982c80da157 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1303,6 +1303,19 @@ static inline void dec_lruvec_page_state(struct page *page,
>  	mod_lruvec_page_state(page, idx, -1);
>  }
>  
> +static inline struct lruvec *parent_lruvec(struct lruvec *lruvec)
> +{
> +	struct mem_cgroup *memcg;
> +
> +	memcg = lruvec_memcg(lruvec);
> +	if (!memcg)
> +		return NULL;
> +	memcg = parent_mem_cgroup(memcg);
> +	if (!memcg)
> +		return NULL;
> +	return mem_cgroup_lruvec(memcg, lruvec_pgdat(lruvec));
> +}
> +
>  #ifdef CONFIG_CGROUP_WRITEBACK
>  
>  struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb);
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index c1fbda9ddd1f..7cccbb8bc2d7 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -262,8 +262,8 @@ enum lruvec_flags {
>  struct lruvec {
>  	struct list_head		lists[NR_LRU_LISTS];
>  	struct zone_reclaim_stat	reclaim_stat;
> -	/* Evictions & activations on the inactive file list */
> -	atomic_long_t			inactive_age;
> +	/* Non-resident age, driven by LRU movement */
> +	atomic_long_t			nonresident_age;
>  	/* Refaults at the time of last reclaim cycle */
>  	unsigned long			refaults;
>  	/* Various lruvec state flags (enum lruvec_flags) */
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 30fd4641890e..f0d2dca28c99 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -312,6 +312,7 @@ struct vma_swap_readahead {
>  };
>  
>  /* linux/mm/workingset.c */
> +void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages);
>  void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg);
>  void workingset_refault(struct page *page, void *shadow);
>  void workingset_activation(struct page *page);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 43f88b1a4f14..3033f1c951cd 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -898,6 +898,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
>  		__delete_from_swap_cache(page, swap);
>  		xa_unlock_irqrestore(&mapping->i_pages, flags);
>  		put_swap_page(page, swap);
> +		workingset_eviction(page, target_memcg);
>  	} else {
>  		void (*freepage)(struct page *);
>  		void *shadow = NULL;
> @@ -1876,6 +1877,8 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  				list_add(&page->lru, &pages_to_free);
>  		} else {
>  			nr_moved += nr_pages;
> +			if (PageActive(page))
> +				workingset_age_nonresident(lruvec, nr_pages);
>  		}
>  	}
>  
> diff --git a/mm/workingset.c b/mm/workingset.c
> index e69865739539..98b91e623b85 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -156,8 +156,8 @@
>   *
>   *		Implementation
>   *
> - * For each node's file LRU lists, a counter for inactive evictions
> - * and activations is maintained (node->inactive_age).
> + * For each node's LRU lists, a counter for inactive evictions and
> + * activations is maintained (node->nonresident_age).
>   *
>   * On eviction, a snapshot of this counter (along with some bits to
>   * identify the node) is stored in the now empty page cache
> @@ -213,7 +213,17 @@ static void unpack_shadow(void *shadow, int *memcgidp, pg_data_t **pgdat,
>  	*workingsetp = workingset;
>  }
>  
> -static void advance_inactive_age(struct mem_cgroup *memcg, pg_data_t *pgdat)
> +/**
> + * workingset_age_nonresident - age non-resident entries as LRU ages
> + * @memcg: the lruvec that was aged
> + * @nr_pages: the number of pages to count
> + *
> + * As in-memory pages are aged, non-resident pages need to be aged as
> + * well, in order for the refault distances later on to be comparable
> + * to the in-memory dimensions. This function allows reclaim and LRU
> + * operations to drive the non-resident aging along in parallel.
> + */
> +void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages)
>  {
>  	/*
>  	 * Reclaiming a cgroup means reclaiming all its children in a
> @@ -227,11 +237,8 @@ static void advance_inactive_age(struct mem_cgroup *memcg, pg_data_t *pgdat)
>  	 * the root cgroup's, age as well.
>  	 */
>  	do {
> -		struct lruvec *lruvec;
> -
> -		lruvec = mem_cgroup_lruvec(memcg, pgdat);
> -		atomic_long_inc(&lruvec->inactive_age);
> -	} while (memcg && (memcg = parent_mem_cgroup(memcg)));
> +		atomic_long_add(nr_pages, &lruvec->nonresident_age);
> +	} while ((lruvec = parent_lruvec(lruvec)));
>  }
>  
>  /**
> @@ -254,12 +261,11 @@ void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg)
>  	VM_BUG_ON_PAGE(page_count(page), page);
>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
>  
> -	advance_inactive_age(page_memcg(page), pgdat);
> -
>  	lruvec = mem_cgroup_lruvec(target_memcg, pgdat);
> +	workingset_age_nonresident(lruvec, hpage_nr_pages(page));
>  	/* XXX: target_memcg can be NULL, go through lruvec */
>  	memcgid = mem_cgroup_id(lruvec_memcg(lruvec));
> -	eviction = atomic_long_read(&lruvec->inactive_age);
> +	eviction = atomic_long_read(&lruvec->nonresident_age);
>  	return pack_shadow(memcgid, pgdat, eviction, PageWorkingset(page));
>  }
>  
> @@ -309,20 +315,20 @@ void workingset_refault(struct page *page, void *shadow)
>  	if (!mem_cgroup_disabled() && !eviction_memcg)
>  		goto out;
>  	eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
> -	refault = atomic_long_read(&eviction_lruvec->inactive_age);
> +	refault = atomic_long_read(&eviction_lruvec->nonresident_age);
>  
>  	/*
>  	 * Calculate the refault distance
>  	 *
>  	 * The unsigned subtraction here gives an accurate distance
> -	 * across inactive_age overflows in most cases. There is a
> +	 * across nonresident_age overflows in most cases. There is a
>  	 * special case: usually, shadow entries have a short lifetime
>  	 * and are either refaulted or reclaimed along with the inode
>  	 * before they get too old.  But it is not impossible for the
> -	 * inactive_age to lap a shadow entry in the field, which can
> -	 * then result in a false small refault distance, leading to a
> -	 * false activation should this old entry actually refault
> -	 * again.  However, earlier kernels used to deactivate
> +	 * nonresident_age to lap a shadow entry in the field, which
> +	 * can then result in a false small refault distance, leading
> +	 * to a false activation should this old entry actually
> +	 * refault again.  However, earlier kernels used to deactivate
>  	 * unconditionally with *every* reclaim invocation for the
>  	 * longest time, so the occasional inappropriate activation
>  	 * leading to pressure on the active list is not a problem.
> @@ -359,7 +365,7 @@ void workingset_refault(struct page *page, void *shadow)
>  		goto out;
>  
>  	SetPageActive(page);
> -	advance_inactive_age(memcg, pgdat);
> +	workingset_age_nonresident(lruvec, hpage_nr_pages(page));
>  	inc_lruvec_state(lruvec, WORKINGSET_ACTIVATE);
>  
>  	/* Page was active prior to eviction */
> @@ -378,6 +384,7 @@ void workingset_refault(struct page *page, void *shadow)
>  void workingset_activation(struct page *page)
>  {
>  	struct mem_cgroup *memcg;
> +	struct lruvec *lruvec;
>  
>  	rcu_read_lock();
>  	/*
> @@ -390,7 +397,8 @@ void workingset_activation(struct page *page)
>  	memcg = page_memcg_rcu(page);
>  	if (!mem_cgroup_disabled() && !memcg)
>  		goto out;
> -	advance_inactive_age(memcg, page_pgdat(page));
> +	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> +	workingset_age_nonresident(lruvec, hpage_nr_pages(page));
>  out:
>  	rcu_read_unlock();
>  }
> 

