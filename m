Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A017C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A1D92075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594122218;
	bh=aswef8mfZAm9JEEjv1h1Yq84BpZm+Jn4Z9Oo2Me8aog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0UhEJWaNTj/7APd7nsjbpm+1IWiV32NAvDIpg6q+Ea+U8ZDrywSJX3DH9UG86rucf
	 6wcumK6qy9zwxDb+T3zrE3nTt/AYWlGvfRzvKM1pEQLLv72d3oVIKmp5k2aKJEIW7A
	 LHg2R+yrj08KV7sZsNXkXbiwWvaNie68posEqF28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgGGLnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:43:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37901 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGLnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:43:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id z13so44805396wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0iIJx4zFTm/QekOoPGgV77T4u+IczqF22Iq3ukLcga4=;
        b=TGHBisSzy1Pkl6qkEi5wWIKr33eGWMDQrANQhxFDERvrh4o/BzR2p9xS982Do4/PVY
         TbL8zbRQtgMMK9Oy0ImlsK5iI6m6NF+4MsQEV6DcNP/Q+ZO8OoraJdaWqWjbPZztJSJ9
         3/ETkO1gEmCB4zwAOwUhfpOummsUxxTHY9Y6Mf6RKirT5i6uvRVoJwhf7FVYkkeIb1id
         mj7I7R77/JR76ZuUEt+WNkZ9KCv2zAHQf8yuEHerQEFwkIWrwFH9yzfKvJ/q7FqRpvJV
         xNNt6FlSFr2d6ADmCpX88/x3PEna4z95l7XxYxqnwB9C3mPvOrmjujms2/4qywkobOdW
         saDA==
X-Gm-Message-State: AOAM532FrDwBR++HAjz9RiYniGOnELxN7hVScghgS0qgzUG+TJC0LtWH
        S2jcsHIpsA3ExdnB8fsUFTQ=
X-Google-Smtp-Source: ABdhPJyZha0j+WFnGG6K83ocm94LvbUKPuxWqQOfxKv8yuAbsQkgXBnnQn5TsSjkMoJtG+OkcjaxSg==
X-Received: by 2002:a5d:630c:: with SMTP id i12mr58870630wru.158.1594122214582;
        Tue, 07 Jul 2020 04:43:34 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id d13sm706252wrn.61.2020.07.07.04.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 04:43:33 -0700 (PDT)
Date:   Tue, 7 Jul 2020 13:43:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v4 06/11] mm/migrate: make a standard migration target
 allocation function
Message-ID: <20200707114332.GJ5913@dhcp22.suse.cz>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-7-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594107889-32228-7-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-07-20 16:44:44, Joonsoo Kim wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> There are some similar functions for migration target allocation.  Since
> there is no fundamental difference, it's better to keep just one rather
> than keeping all variants.  This patch implements base migration target
> allocation function.  In the following patches, variants will be converted
> to use this function.
> 
> Changes should be mechanical but there are some differences. First, Some
> callers' nodemask is assgined to NULL since NULL nodemask will be
> considered as all available nodes, that is, &node_states[N_MEMORY].
> Second, for hugetlb page allocation, gfp_mask is ORed since a user could
> provide a gfp_mask from now on. Third, if provided node id is NUMA_NO_NODE,
> node id is set up to the node where migration source lives.
> 
> Note that PageHighmem() call in previous function is changed to open-code
> "is_highmem_idx()" since it provides more readability.
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  include/linux/migrate.h |  9 +++++----
>  mm/internal.h           |  7 +++++++
>  mm/memory-failure.c     |  7 +++++--
>  mm/memory_hotplug.c     | 14 +++++++++-----
>  mm/migrate.c            | 27 +++++++++++++++++----------
>  mm/page_isolation.c     |  7 +++++--
>  6 files changed, 48 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 1d70b4a..cc56f0d 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -10,6 +10,8 @@
>  typedef struct page *new_page_t(struct page *page, unsigned long private);
>  typedef void free_page_t(struct page *page, unsigned long private);
>  
> +struct migration_target_control;
> +
>  /*
>   * Return values from addresss_space_operations.migratepage():
>   * - negative errno on page migration failure;
> @@ -39,8 +41,7 @@ extern int migrate_page(struct address_space *mapping,
>  			enum migrate_mode mode);
>  extern int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
>  		unsigned long private, enum migrate_mode mode, int reason);
> -extern struct page *new_page_nodemask(struct page *page,
> -		int preferred_nid, nodemask_t *nodemask);
> +extern struct page *alloc_migration_target(struct page *page, unsigned long private);
>  extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
>  extern void putback_movable_page(struct page *page);
>  
> @@ -59,8 +60,8 @@ static inline int migrate_pages(struct list_head *l, new_page_t new,
>  		free_page_t free, unsigned long private, enum migrate_mode mode,
>  		int reason)
>  	{ return -ENOSYS; }
> -static inline struct page *new_page_nodemask(struct page *page,
> -		int preferred_nid, nodemask_t *nodemask)
> +static inline struct page *alloc_migration_target(struct page *page,
> +		unsigned long private)
>  	{ return NULL; }
>  static inline int isolate_movable_page(struct page *page, isolate_mode_t mode)
>  	{ return -EBUSY; }
> diff --git a/mm/internal.h b/mm/internal.h
> index dd14c53..0beacf3 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -614,4 +614,11 @@ static inline bool is_migrate_highatomic_page(struct page *page)
>  
>  void setup_zone_pageset(struct zone *zone);
>  extern struct page *alloc_new_node_page(struct page *page, unsigned long node);
> +
> +struct migration_target_control {
> +	int nid;		/* preferred node id */
> +	nodemask_t *nmask;
> +	gfp_t gfp_mask;
> +};
> +
>  #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index c5e4cee..609d42b6 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1679,9 +1679,12 @@ EXPORT_SYMBOL(unpoison_memory);
>  
>  static struct page *new_page(struct page *p, unsigned long private)
>  {
> -	int nid = page_to_nid(p);
> +	struct migration_target_control mtc = {
> +		.nid = page_to_nid(p),
> +		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
> +	};
>  
> -	return new_page_nodemask(p, nid, &node_states[N_MEMORY]);
> +	return alloc_migration_target(p, (unsigned long)&mtc);
>  }
>  
>  /*
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index cafe65eb..86bc2ad 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1267,19 +1267,23 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
>  
>  static struct page *new_node_page(struct page *page, unsigned long private)
>  {
> -	int nid = page_to_nid(page);
>  	nodemask_t nmask = node_states[N_MEMORY];
> +	struct migration_target_control mtc = {
> +		.nid = page_to_nid(page),
> +		.nmask = &nmask,
> +		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
> +	};
>  
>  	/*
>  	 * try to allocate from a different node but reuse this node if there
>  	 * are no other online nodes to be used (e.g. we are offlining a part
>  	 * of the only existing node)
>  	 */
> -	node_clear(nid, nmask);
> -	if (nodes_empty(nmask))
> -		node_set(nid, nmask);
> +	node_clear(mtc.nid, *mtc.nmask);
> +	if (nodes_empty(*mtc.nmask))
> +		node_set(mtc.nid, *mtc.nmask);
>  
> -	return new_page_nodemask(page, nid, &nmask);
> +	return alloc_migration_target(page, (unsigned long)&mtc);
>  }
>  
>  static int
> diff --git a/mm/migrate.c b/mm/migrate.c
> index ecd7615..00cd81c 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1531,19 +1531,27 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  	return rc;
>  }
>  
> -struct page *new_page_nodemask(struct page *page,
> -				int preferred_nid, nodemask_t *nodemask)
> +struct page *alloc_migration_target(struct page *page, unsigned long private)
>  {
> -	gfp_t gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL;
> +	struct migration_target_control *mtc;
> +	gfp_t gfp_mask;
>  	unsigned int order = 0;
>  	struct page *new_page = NULL;
> +	int nid;
> +	int zidx;
> +
> +	mtc = (struct migration_target_control *)private;
> +	gfp_mask = mtc->gfp_mask;
> +	nid = mtc->nid;
> +	if (nid == NUMA_NO_NODE)
> +		nid = page_to_nid(page);
>  
>  	if (PageHuge(page)) {
>  		struct hstate *h = page_hstate(compound_head(page));
>  
> -		gfp_mask = htlb_alloc_mask(h);
> -		return alloc_huge_page_nodemask(h, preferred_nid,
> -						nodemask, gfp_mask, false);
> +		gfp_mask |= htlb_alloc_mask(h);
> +		return alloc_huge_page_nodemask(h, nid, mtc->nmask,
> +						gfp_mask, false);
>  	}
>  
>  	if (PageTransHuge(page)) {
> @@ -1555,12 +1563,11 @@ struct page *new_page_nodemask(struct page *page,
>  		gfp_mask |= GFP_TRANSHUGE;
>  		order = HPAGE_PMD_ORDER;
>  	}
> -
> -	if (PageHighMem(page) || (zone_idx(page_zone(page)) == ZONE_MOVABLE))
> +	zidx = zone_idx(page_zone(page));
> +	if (is_highmem_idx(zidx) || zidx == ZONE_MOVABLE)
>  		gfp_mask |= __GFP_HIGHMEM;
>  
> -	new_page = __alloc_pages_nodemask(gfp_mask, order,
> -				preferred_nid, nodemask);
> +	new_page = __alloc_pages_nodemask(gfp_mask, order, nid, mtc->nmask);
>  
>  	if (new_page && PageTransHuge(new_page))
>  		prep_transhuge_page(new_page);
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index aec26d9..f25c66e 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -309,7 +309,10 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
>  
>  struct page *alloc_migrate_target(struct page *page, unsigned long private)
>  {
> -	int nid = page_to_nid(page);
> +	struct migration_target_control mtc = {
> +		.nid = page_to_nid(page),
> +		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
> +	};
>  
> -	return new_page_nodemask(page, nid, &node_states[N_MEMORY]);
> +	return alloc_migration_target(page, (unsigned long)&mtc);
>  }
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
