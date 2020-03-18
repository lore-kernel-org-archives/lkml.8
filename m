Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184BFC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F9920757
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="nlKZMCT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCRSGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:06:43 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:47098 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgCRSGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 14:06:43 -0400
Received: by mail-qv1-f68.google.com with SMTP id m2so13379427qvu.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 11:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NJcNnn0o+YSBpq6FW4tk05aWelvsn8Udpr0Qn8KERXk=;
        b=nlKZMCT6g0xDk9hquAeci9BSbdC/XBlqPwmdhszHMtoT4WMadC+e9ZztEPrt1hcFFG
         GX1dzNeXhp7/cd6msTF0Y7Zbl1DNx6ONGSvr/m86+OYeaGCXZ0hjC8G4Tbn4zQhtP9Lr
         VFMEzZoqUrjtDM9RcNGwuJpj3Iu+e538ZvteSSUyIa3sJgEuf5Vr4+IfbX/8qFMzSG8y
         febMBFCPKoNc6R8AyMkbHT4e0xTruatgp9QU/78AI0kLLRXbCW4MFhtGA7D+M6Nh8y0n
         TrH6jYoc9t9GjjDt/zsfvKRbnVU6abnWbBP1QA8fdZ0LaLzYK7IPE3ry800NqvRXOFv5
         kTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NJcNnn0o+YSBpq6FW4tk05aWelvsn8Udpr0Qn8KERXk=;
        b=F2OpAgw7VyV/bTOFycvGqTRaACvnhI3XpINE2kqfcyleFKQw37wTFybJbDpgF8Qi3Z
         EiMhd9v+TuV+8cCJTpNf1+nKuM/pdYlVIXab7/G3u4tG+uJxxdhd6AtnXucVJgPgYyo5
         HZUvaKLkC4JTMqlCbZ2tYSe1HMWSt571MDM8Yo08AQ92ybxByRz4G4XDWOkXKr0ZJuJZ
         NYwsef+EinDpoq6pEpAVrIb5Ay8ipfw7uL1Su7IxGciOvQeFzTvyYy28SXQLBR8n82lm
         GjyD6EQzhkzv1mQtMy/Xhgwj8TvsizlKQThxZDcGwcZ2y+dPmxRZr7qHBF6YVq6nVCU8
         xXoQ==
X-Gm-Message-State: ANhLgQ1xWr1/xQZcQaTjID45PDFSGnjgNXxT5aSy4ptkhsrMKbOP21wb
        pi/s7oN4gtB02DQBjk3e0CA0og==
X-Google-Smtp-Source: ADFU+vuSWzLvY/WI+ENONeiPUhBIwOQyGC5JFzs4GBMdXVgaoy6XOkD+aT+lpAK2j+JKYvFkRbgxnQ==
X-Received: by 2002:a05:6214:1703:: with SMTP id db3mr5732562qvb.28.1584554801000;
        Wed, 18 Mar 2020 11:06:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a9a9])
        by smtp.gmail.com with ESMTPSA id 128sm4643598qki.103.2020.03.18.11.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 11:06:40 -0700 (PDT)
Date:   Wed, 18 Mar 2020 14:06:38 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v3 3/9] mm/workingset: extend the workingset detection
 for anon LRU
Message-ID: <20200318180638.GC154135@cmpxchg.org>
References: <1584423717-3440-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584423717-3440-4-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584423717-3440-4-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 02:41:51PM +0900, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> In the following patch, workingset detection will be applied to
> anonymous LRU. To prepare it, this patch adds some code to
> distinguish/handle the both LRUs.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

This looks all correct to me, but I would ask for some style
fixes. With those applied, please feel free to add

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

> @@ -304,10 +308,10 @@ enum lruvec_flags {
>  struct lruvec {
>  	struct list_head		lists[NR_LRU_LISTS];
>  	struct zone_reclaim_stat	reclaim_stat;
> -	/* Evictions & activations on the inactive file list */
> -	atomic_long_t			inactive_age;
> +	/* Evictions & activations on the inactive list */
> +	atomic_long_t			inactive_age[2];

Can you please add anon=0, file=1 to the comment?

> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1431,10 +1431,14 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>  	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGMAJFAULT),
>  		       memcg_events(memcg, PGMAJFAULT));
>  
> -	seq_buf_printf(&s, "workingset_refault %lu\n",
> -		       memcg_page_state(memcg, WORKINGSET_REFAULT));
> -	seq_buf_printf(&s, "workingset_activate %lu\n",
> -		       memcg_page_state(memcg, WORKINGSET_ACTIVATE));
> +	seq_buf_printf(&s, "workingset_refault_anon %lu\n",
> +		       memcg_page_state(memcg, WORKINGSET_REFAULT_ANON));
> +	seq_buf_printf(&s, "workingset_refault_file %lu\n",
> +		       memcg_page_state(memcg, WORKINGSET_REFAULT_FILE));
> +	seq_buf_printf(&s, "workingset_activate_anon %lu\n",
> +		       memcg_page_state(memcg, WORKINGSET_ACTIVATE_ANON));
> +	seq_buf_printf(&s, "workingset_activate_file %lu\n",
> +		       memcg_page_state(memcg, WORKINGSET_ACTIVATE_FILE));
>  	seq_buf_printf(&s, "workingset_nodereclaim %lu\n",
>  		       memcg_page_state(memcg, WORKINGSET_NODERECLAIM));
>  
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c932141..0493c25 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2716,7 +2716,10 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  	if (!sc->force_deactivate) {
>  		unsigned long refaults;
>  
> -		if (inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
> +		refaults = lruvec_page_state(target_lruvec,
> +				WORKINGSET_ACTIVATE_ANON);
> +		if (refaults != target_lruvec->refaults[0] ||
> +			inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
>  			sc->may_deactivate |= DEACTIVATE_ANON;
>  		else
>  			sc->may_deactivate &= ~DEACTIVATE_ANON;
> @@ -2727,8 +2730,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  		 * rid of any stale active pages quickly.
>  		 */
>  		refaults = lruvec_page_state(target_lruvec,
> -					     WORKINGSET_ACTIVATE);
> -		if (refaults != target_lruvec->refaults ||
> +				WORKINGSET_ACTIVATE_FILE);
> +		if (refaults != target_lruvec->refaults[1] ||
>  		    inactive_is_low(target_lruvec, LRU_INACTIVE_FILE))
>  			sc->may_deactivate |= DEACTIVATE_FILE;
>  		else
> @@ -3007,8 +3010,10 @@ static void snapshot_refaults(struct mem_cgroup *target_memcg, pg_data_t *pgdat)
>  	unsigned long refaults;
>  
>  	target_lruvec = mem_cgroup_lruvec(target_memcg, pgdat);
> -	refaults = lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE);
> -	target_lruvec->refaults = refaults;
> +	refaults = lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE_ANON);
> +	target_lruvec->refaults[0] = refaults;
> +	refaults = lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE_FILE);
> +	target_lruvec->refaults[1] = refaults;
>  }
>  
>  /*
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 78d5337..3cdf8e9 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1146,8 +1146,10 @@ const char * const vmstat_text[] = {
>  	"nr_isolated_anon",
>  	"nr_isolated_file",
>  	"workingset_nodes",
> -	"workingset_refault",
> -	"workingset_activate",
> +	"workingset_refault_anon",
> +	"workingset_refault_file",
> +	"workingset_activate_anon",
> +	"workingset_activate_file",
>  	"workingset_restore",
>  	"workingset_nodereclaim",
>  	"nr_anon_pages",
> diff --git a/mm/workingset.c b/mm/workingset.c
> index 474186b..5fb8f85 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -15,6 +15,7 @@
>  #include <linux/dax.h>
>  #include <linux/fs.h>
>  #include <linux/mm.h>
> +#include <linux/mm_inline.h>

Please keep the line-length sorting of the includes intact. If that's
not possible, please separate the mm_inline.h include with an empty
line into its own section.

This makes it much easier to scan for specific headers, helps avoid
duplicate includes, and is generally just easier on the eyes.

> @@ -156,7 +157,7 @@
>   *
>   *		Implementation
>   *
> - * For each node's file LRU lists, a counter for inactive evictions
> + * For each node's anon/file LRU lists, a counter for inactive evictions
>   * and activations is maintained (node->inactive_age).
>   *
>   * On eviction, a snapshot of this counter (along with some bits to
> @@ -213,7 +214,8 @@ static void unpack_shadow(void *shadow, int *memcgidp, pg_data_t **pgdat,
>  	*workingsetp = workingset;
>  }
>  
> -static void advance_inactive_age(struct mem_cgroup *memcg, pg_data_t *pgdat)
> +static void advance_inactive_age(struct mem_cgroup *memcg, pg_data_t *pgdat,
> +				int is_file)

bool file, please.

>  {
>  	/*
>  	 * Reclaiming a cgroup means reclaiming all its children in a
> @@ -230,7 +232,7 @@ static void advance_inactive_age(struct mem_cgroup *memcg, pg_data_t *pgdat)
>  		struct lruvec *lruvec;
>  
>  		lruvec = mem_cgroup_lruvec(memcg, pgdat);
> -		atomic_long_inc(&lruvec->inactive_age);
> +		atomic_long_inc(&lruvec->inactive_age[is_file]);
>  	} while (memcg && (memcg = parent_mem_cgroup(memcg)));
>  }
>  
> @@ -248,18 +250,19 @@ void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg)
>  	unsigned long eviction;
>  	struct lruvec *lruvec;
>  	int memcgid;
> +	int is_file = page_is_file_cache(page);

Please keep the line-length ordering intact here as well.

>  	/* Page is fully exclusive and pins page->mem_cgroup */
>  	VM_BUG_ON_PAGE(PageLRU(page), page);
>  	VM_BUG_ON_PAGE(page_count(page), page);
>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
>  
> -	advance_inactive_age(page_memcg(page), pgdat);
> +	advance_inactive_age(page_memcg(page), pgdat, is_file);
>  
>  	lruvec = mem_cgroup_lruvec(target_memcg, pgdat);
>  	/* XXX: target_memcg can be NULL, go through lruvec */
>  	memcgid = mem_cgroup_id(lruvec_memcg(lruvec));
> -	eviction = atomic_long_read(&lruvec->inactive_age);
> +	eviction = atomic_long_read(&lruvec->inactive_age[is_file]);
>  	return pack_shadow(memcgid, pgdat, eviction, PageWorkingset(page));
>  }
>  
> @@ -278,13 +281,16 @@ void workingset_refault(struct page *page, void *shadow)
>  	struct lruvec *eviction_lruvec;
>  	unsigned long refault_distance;
>  	struct pglist_data *pgdat;
> -	unsigned long active_file;
> +	unsigned long active;
>  	struct mem_cgroup *memcg;
>  	unsigned long eviction;
>  	struct lruvec *lruvec;
>  	unsigned long refault;
>  	bool workingset;
>  	int memcgid;
> +	int is_file = page_is_file_cache(page);
> +	enum lru_list active_lru = page_lru_base_type(page) + LRU_ACTIVE;
> +	enum node_stat_item workingset_stat;

Please use bool file and keep line-length ordering.

The workingset_stat variable doesn't seem helpful, see below:

>  	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, &workingset);
>  
> @@ -309,8 +315,8 @@ void workingset_refault(struct page *page, void *shadow)
>  	if (!mem_cgroup_disabled() && !eviction_memcg)
>  		goto out;
>  	eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
> -	refault = atomic_long_read(&eviction_lruvec->inactive_age);
> -	active_file = lruvec_page_state(eviction_lruvec, NR_ACTIVE_FILE);
> +	refault = atomic_long_read(&eviction_lruvec->inactive_age[is_file]);
> +	active = lruvec_page_state(eviction_lruvec, active_lru);
>  
>  	/*
>  	 * Calculate the refault distance
> @@ -341,19 +347,21 @@ void workingset_refault(struct page *page, void *shadow)
>  	memcg = page_memcg(page);
>  	lruvec = mem_cgroup_lruvec(memcg, pgdat);
>  
> -	inc_lruvec_state(lruvec, WORKINGSET_REFAULT);
> +	workingset_stat = WORKINGSET_REFAULT_BASE + is_file;
> +	inc_lruvec_state(lruvec, workingset_stat);

	inc_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file);

>  	/*
>  	 * Compare the distance to the existing workingset size. We
>  	 * don't act on pages that couldn't stay resident even if all
>  	 * the memory was available to the page cache.
>  	 */
> -	if (refault_distance > active_file)
> +	if (refault_distance > active)
>  		goto out;
>  
>  	SetPageActive(page);
> -	advance_inactive_age(memcg, pgdat);
> -	inc_lruvec_state(lruvec, WORKINGSET_ACTIVATE);
> +	advance_inactive_age(memcg, pgdat, is_file);
> +	workingset_stat = WORKINGSET_ACTIVATE_BASE + is_file;
> +	inc_lruvec_state(lruvec, workingset_stat);

	inc_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + file);

>  	/* Page was active prior to eviction */
>  	if (workingset) {
> @@ -371,6 +379,7 @@ void workingset_refault(struct page *page, void *shadow)
>  void workingset_activation(struct page *page)
>  {
>  	struct mem_cgroup *memcg;
> +	int is_file = page_is_file_cache(page);

bool file & length-ordering
