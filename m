Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D82C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 00:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6455A20781
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 00:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zmd4WEQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgGAArh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 20:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgGAArh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 20:47:37 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D6DC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 17:47:36 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j1so10194690pfe.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 17:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=FApsYfidCWF8PUb9YyQNziOfrjjNdEduZb66lKdbc78=;
        b=Zmd4WEQlBlsjWKtE75ycMbKBRu1JDnXqQYurD8IYKJHbytt1oNi2iooVpjaxrZIjJO
         QiOxqGzwegHW+xwf0kS5vn9scMVGq9nwrAlf/bQZTRXV9PXgauEhiwwBPcBg4XOBGkCM
         eLyp+Dalbt7MsG+WFcJbdk50F3v5WM0H+N6Ivb4yTUAWdxsVgU6O5NIidNJbVvUTwcw5
         wIis06r1txEX95i9UW6PrvkeiLIxslqLVsrFzks8QAbY+A5NUu35dmUUxcCrVxdwVP85
         bXy3hOJjvvE838U6eR/9MXdBYUj6tVPSA0GZrkR4LCB1Chc8e7cezKfZOSur+OdinMbU
         64gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=FApsYfidCWF8PUb9YyQNziOfrjjNdEduZb66lKdbc78=;
        b=TWJG7YYPPf9/xrToK8pjwE0A4l/HzQdfIZyyPjXp+pHMN0HNxwdcR+bObOSIMigEjs
         T5SQ2NIvI+uXPbJE+W8K5yCkGed9rmom/KvOHX1hfalQtQCCygx5LU7688mFGst70JGq
         gOl1zilQITdL+n4/e2HFq6ImFDiLDNN3U6T0wswjMA0wF2/vi3a0+5Y2kOOsOKSO/ef3
         rwiCIMiYhLQAYHLDprX1OGpJcvuH82nBlz8w+xNeiu0UUSwNWOSyN0Mcec7uRluZEowt
         R42wyGJXdJNRRptj7zA3jFrO+r1I3XaAFaFrUsaYHHsR70ply0SyS4P7A07CI5UXVGlf
         Mrwg==
X-Gm-Message-State: AOAM5334Hdgt+ynAJ9C9JQzg9ld3HA1Q+hENlKgOLp9v0pQ00McROKKg
        rS7EuZgC/vo88b4X/+Xbqg1gAiuCpr8=
X-Google-Smtp-Source: ABdhPJyCrtSQmP3D0piJX0g6xwWJ54MYBvmA94nVDX6BkKfdovGMEuJnDDbYAAIS88sT2BHLIOfgQg==
X-Received: by 2002:a62:6d03:: with SMTP id i3mr14088228pfc.6.1593564455789;
        Tue, 30 Jun 2020 17:47:35 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id g9sm3525327pfm.151.2020.06.30.17.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 17:47:34 -0700 (PDT)
Date:   Tue, 30 Jun 2020 17:47:34 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Dave Hansen <dave.hansen@linux.intel.com>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kbusch@kernel.org, yang.shi@linux.alibaba.com,
        ying.huang@intel.com, dan.j.williams@intel.com
Subject: Re: [RFC][PATCH 3/8] mm/vmscan: Attempt to migrate page in lieu of
 discard
In-Reply-To: <20200629234509.8F89C4EF@viggo.jf.intel.com>
Message-ID: <alpine.DEB.2.22.394.2006301732010.1644114@chino.kir.corp.google.com>
References: <20200629234503.749E5340@viggo.jf.intel.com> <20200629234509.8F89C4EF@viggo.jf.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020, Dave Hansen wrote:

> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> If a memory node has a preferred migration path to demote cold pages,
> attempt to move those inactive pages to that migration node before
> reclaiming. This will better utilize available memory, provide a faster
> tier than swapping or discarding, and allow such pages to be reused
> immediately without IO to retrieve the data.
> 
> When handling anonymous pages, this will be considered before swap if
> enabled. Should the demotion fail for any reason, the page reclaim
> will proceed as if the demotion feature was not enabled.
> 

Thanks for sharing these patches and kick-starting the conversation, Dave.

Could this cause us to break a user's mbind() or allow a user to 
circumvent their cpuset.mems?

Because we don't have a mapping of the page back to its allocation 
context (or the process context in which it was allocated), it seems like 
both are possible.

So let's assume that migration nodes cannot be other DRAM nodes.  
Otherwise, memory pressure could be intentionally or unintentionally 
induced to migrate these pages to another node.  Do we have such a 
restriction on migration nodes?

> Some places we would like to see this used:
> 
>   1. Persistent memory being as a slower, cheaper DRAM replacement
>   2. Remote memory-only "expansion" NUMA nodes
>   3. Resolving memory imbalances where one NUMA node is seeing more
>      allocation activity than another.  This helps keep more recent
>      allocations closer to the CPUs on the node doing the allocating.
> 

(3) is the concerning one given the above if we are to use 
migrate_demote_mapping() for DRAM node balancing.

> Yang Shi's patches used an alternative approach where to-be-discarded
> pages were collected on a separate discard list and then discarded
> as a batch with migrate_pages().  This results in simpler code and
> has all the performance advantages of batching, but has the
> disadvantage that pages which fail to migrate never get swapped.
> 
> #Signed-off-by: Keith Busch <keith.busch@intel.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> ---
> 
>  b/include/linux/migrate.h        |    6 ++++
>  b/include/trace/events/migrate.h |    3 +-
>  b/mm/debug.c                     |    1 
>  b/mm/migrate.c                   |   52 +++++++++++++++++++++++++++++++++++++++
>  b/mm/vmscan.c                    |   25 ++++++++++++++++++
>  5 files changed, 86 insertions(+), 1 deletion(-)
> 
> diff -puN include/linux/migrate.h~0008-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard include/linux/migrate.h
> --- a/include/linux/migrate.h~0008-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard	2020-06-29 16:34:38.950312604 -0700
> +++ b/include/linux/migrate.h	2020-06-29 16:34:38.963312604 -0700
> @@ -25,6 +25,7 @@ enum migrate_reason {
>  	MR_MEMPOLICY_MBIND,
>  	MR_NUMA_MISPLACED,
>  	MR_CONTIG_RANGE,
> +	MR_DEMOTION,
>  	MR_TYPES
>  };
>  
> @@ -78,6 +79,7 @@ extern int migrate_huge_page_move_mappin
>  				  struct page *newpage, struct page *page);
>  extern int migrate_page_move_mapping(struct address_space *mapping,
>  		struct page *newpage, struct page *page, int extra_count);
> +extern int migrate_demote_mapping(struct page *page);
>  #else
>  
>  static inline void putback_movable_pages(struct list_head *l) {}
> @@ -104,6 +106,10 @@ static inline int migrate_huge_page_move
>  	return -ENOSYS;
>  }
>  
> +static inline int migrate_demote_mapping(struct page *page)
> +{
> +	return -ENOSYS;
> +}
>  #endif /* CONFIG_MIGRATION */
>  
>  #ifdef CONFIG_COMPACTION
> diff -puN include/trace/events/migrate.h~0008-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard include/trace/events/migrate.h
> --- a/include/trace/events/migrate.h~0008-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard	2020-06-29 16:34:38.952312604 -0700
> +++ b/include/trace/events/migrate.h	2020-06-29 16:34:38.963312604 -0700
> @@ -20,7 +20,8 @@
>  	EM( MR_SYSCALL,		"syscall_or_cpuset")		\
>  	EM( MR_MEMPOLICY_MBIND,	"mempolicy_mbind")		\
>  	EM( MR_NUMA_MISPLACED,	"numa_misplaced")		\
> -	EMe(MR_CONTIG_RANGE,	"contig_range")
> +	EM( MR_CONTIG_RANGE,	"contig_range")			\
> +	EMe(MR_DEMOTION,	"demotion")
>  
>  /*
>   * First define the enums in the above macros to be exported to userspace
> diff -puN mm/debug.c~0008-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard mm/debug.c
> --- a/mm/debug.c~0008-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard	2020-06-29 16:34:38.954312604 -0700
> +++ b/mm/debug.c	2020-06-29 16:34:38.963312604 -0700
> @@ -25,6 +25,7 @@ const char *migrate_reason_names[MR_TYPE
>  	"mempolicy_mbind",
>  	"numa_misplaced",
>  	"cma",
> +	"demotion",
>  };
>  
>  const struct trace_print_flags pageflag_names[] = {
> diff -puN mm/migrate.c~0008-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard mm/migrate.c
> --- a/mm/migrate.c~0008-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard	2020-06-29 16:34:38.956312604 -0700
> +++ b/mm/migrate.c	2020-06-29 16:34:38.964312604 -0700
> @@ -1151,6 +1151,58 @@ int next_demotion_node(int node)
>  	return node;
>  }
>  
> +static struct page *alloc_demote_node_page(struct page *page, unsigned long node)
> +{
> +	/*
> +	 * 'mask' targets allocation only to the desired node in the
> +	 * migration path, and fails fast if the allocation can not be
> +	 * immediately satisfied.  Reclaim is already active and heroic
> +	 * allocation efforts are unwanted.
> +	 */
> +	gfp_t mask = GFP_NOWAIT | __GFP_NOWARN | __GFP_NORETRY |
> +			__GFP_NOMEMALLOC | __GFP_THISNODE | __GFP_HIGHMEM |
> +			__GFP_MOVABLE;

GFP_NOWAIT has the side-effect that it does __GFP_KSWAPD_RECLAIM: do we 
actually want to kick kswapd on the pmem node?

If not, GFP_TRANSHUGE_LIGHT does a trick where it does 
GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM.  You could probably do the same 
here although the __GFP_IO and __GFP_FS would be unnecessary (but not 
harmful).

> +	struct page *newpage;
> +
> +	if (PageTransHuge(page)) {
> +		mask |= __GFP_COMP;
> +		newpage = alloc_pages_node(node, mask, HPAGE_PMD_ORDER);
> +		if (newpage)
> +			prep_transhuge_page(newpage);
> +	} else
> +		newpage = alloc_pages_node(node, mask, 0);
> +
> +	return newpage;
> +}
> +
> +/**
> + * migrate_demote_mapping() - Migrate this page and its mappings to its
> + *                            demotion node.
> + * @page: A locked, isolated, non-huge page that should migrate to its current
> + *        node's demotion target, if available. Since this is intended to be
> + *        called during memory reclaim, all flag options are set to fail fast.
> + *
> + * @returns: MIGRATEPAGE_SUCCESS if successful, -errno otherwise.
> + */
> +int migrate_demote_mapping(struct page *page)
> +{
> +	int next_nid = next_demotion_node(page_to_nid(page));
> +
> +	VM_BUG_ON_PAGE(!PageLocked(page), page);
> +	VM_BUG_ON_PAGE(PageHuge(page), page);
> +	VM_BUG_ON_PAGE(PageLRU(page), page);
> +
> +	if (next_nid == NUMA_NO_NODE)
> +		return -ENOSYS;
> +	if (PageTransHuge(page) && !thp_migration_supported())
> +		return -ENOMEM;
> +
> +	/* MIGRATE_ASYNC is the most light weight and never blocks.*/
> +	return __unmap_and_move(alloc_demote_node_page, NULL, next_nid,
> +				page, MIGRATE_ASYNC, MR_DEMOTION);
> +}
> +
> +
>  /*
>   * gcc 4.7 and 4.8 on arm get an ICEs when inlining unmap_and_move().  Work
>   * around it.
> diff -puN mm/vmscan.c~0008-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard mm/vmscan.c
> --- a/mm/vmscan.c~0008-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard	2020-06-29 16:34:38.959312604 -0700
> +++ b/mm/vmscan.c	2020-06-29 16:34:38.965312604 -0700
> @@ -1077,6 +1077,7 @@ static unsigned long shrink_page_list(st
>  	LIST_HEAD(free_pages);
>  	unsigned nr_reclaimed = 0;
>  	unsigned pgactivate = 0;
> +	int rc;
>  
>  	memset(stat, 0, sizeof(*stat));
>  	cond_resched();
> @@ -1229,6 +1230,30 @@ static unsigned long shrink_page_list(st
>  			; /* try to reclaim the page below */
>  		}
>  
> +		rc = migrate_demote_mapping(page);
> +		/*
> +		 * -ENOMEM on a THP may indicate either migration is
> +		 * unsupported or there was not enough contiguous
> +		 * space. Split the THP into base pages and retry the
> +		 * head immediately. The tail pages will be considered
> +		 * individually within the current loop's page list.
> +		 */
> +		if (rc == -ENOMEM && PageTransHuge(page) &&
> +		    !split_huge_page_to_list(page, page_list))
> +			rc = migrate_demote_mapping(page);
> +
> +		if (rc == MIGRATEPAGE_SUCCESS) {
> +			unlock_page(page);
> +			if (likely(put_page_testzero(page)))
> +				goto free_it;
> +			/*
> +			 * Speculative reference will free this page,
> +			 * so leave it off the LRU.
> +			 */
> +			nr_reclaimed++;

nr_reclaimed += nr_pages instead?

> +			continue;
> +		}
> +
>  		/*
>  		 * Anonymous process memory has backing store?
>  		 * Try to allocate it some swap space here.
