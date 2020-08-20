Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA78C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E33B22080C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgHTIG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:06:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:6342 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgHTIGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:06:50 -0400
IronPort-SDR: tg5/UWn3GYTP9fMCWsNGhSXejHFePOEXe+t/4OS5tm27ozRKWhEC85/nJ6265v2Axllp0cntsT
 sWEQHHAsQoSA==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="219563394"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="219563394"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 01:06:48 -0700
IronPort-SDR: ofSLQ90hcXgo9+AOSKBWlxm1iZpaVXrMm33vBnHA+mUz2CKr20IvxDVqlNHTn7HJV+DgpCNNRz
 5+wG3IhPChsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="329595076"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.164])
  by fmsmga002.fm.intel.com with ESMTP; 20 Aug 2020 01:06:47 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     <linux-kernel@vger.kernel.org>, <yang.shi@linux.alibaba.com>,
        <rientjes@google.com>, <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH 5/9] mm/migrate: demote pages during reclaim
References: <20200818184122.29C415DF@viggo.jf.intel.com>
        <20200818184131.C972AFCC@viggo.jf.intel.com>
Date:   Thu, 20 Aug 2020 16:06:46 +0800
In-Reply-To: <20200818184131.C972AFCC@viggo.jf.intel.com> (Dave Hansen's
        message of "Tue, 18 Aug 2020 11:41:31 -0700")
Message-ID: <87lfi9wxk9.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dave,

Dave Hansen <dave.hansen@linux.intel.com> writes:

[snip]

> diff -puN mm/vmscan.c~demote-with-migrate_pages mm/vmscan.c
> --- a/mm/vmscan.c~demote-with-migrate_pages	2020-08-18 11:36:52.919583179 -0700
> +++ b/mm/vmscan.c	2020-08-18 11:36:52.924583179 -0700
> @@ -43,6 +43,7 @@
>  #include <linux/kthread.h>
>  #include <linux/freezer.h>
>  #include <linux/memcontrol.h>
> +#include <linux/migrate.h>
>  #include <linux/delayacct.h>
>  #include <linux/sysctl.h>
>  #include <linux/oom.h>
> @@ -1040,6 +1041,24 @@ static enum page_references page_check_r
>  	return PAGEREF_RECLAIM;
>  }
>  
> +bool migrate_demote_page_ok(struct page *page, struct scan_control *sc)
> +{
> +	int next_nid = next_demotion_node(page_to_nid(page));
> +
> +	VM_BUG_ON_PAGE(!PageLocked(page), page);
> +	VM_BUG_ON_PAGE(PageHuge(page), page);
> +	VM_BUG_ON_PAGE(PageLRU(page), page);
> +
> +	if (next_nid == NUMA_NO_NODE)
> +		return false;
> +	if (PageTransHuge(page) && !thp_migration_supported())
> +		return false;
> +
> +	// FIXME: actually enable this later in the series
> +	return false;
> +}
> +
> +
>  /* Check if a page is dirty or under writeback */
>  static void page_check_dirty_writeback(struct page *page,
>  				       bool *dirty, bool *writeback)
> @@ -1070,6 +1089,66 @@ static void page_check_dirty_writeback(s
>  		mapping->a_ops->is_dirty_writeback(page, dirty, writeback);
>  }
>  
> +static struct page *alloc_demote_page(struct page *page, unsigned long node)
> +{
> +	/*
> +	 * Try to fail quickly if memory on the target node is not
> +	 * available.  Leaving out __GFP_IO and __GFP_FS helps with
> +	 * this.  If the desintation node is full, we want kswapd to
> +	 * run there so that its pages will get reclaimed and future
> +	 * migration attempts may succeed.
> +	 */
> +	gfp_t flags = (__GFP_HIGHMEM | __GFP_MOVABLE | __GFP_NORETRY |
> +		       __GFP_NOMEMALLOC | __GFP_NOWARN | __GFP_THISNODE |
> +		       __GFP_KSWAPD_RECLAIM);
> +	/* HugeTLB pages should not be on the LRU */
> +	WARN_ON_ONCE(PageHuge(page));
> +
> +	if (PageTransHuge(page)) {
> +		struct page *thp;
> +
> +		flags |= __GFP_COMP;
> +
> +		thp = alloc_pages_node(node, flags, HPAGE_PMD_ORDER);
> +		if (!thp)
> +			return NULL;
> +		prep_transhuge_page(thp);
> +		return thp;
> +	}
> +
> +	return __alloc_pages_node(node, flags, 0);
> +}
> +
> +/*
> + * Take pages on @demote_list and attempt to demote them to
> + * another node.  Pages which are not demoted are added to
> + * @ret_pages.
> + */
> +static unsigned int demote_page_list(struct list_head *ret_list,
> +				     struct list_head *demote_pages,
> +				     struct pglist_data *pgdat,
> +				     struct scan_control *sc)
> +{
> +	int target_nid = next_demotion_node(pgdat->node_id);
> +	unsigned int nr_succeeded = 0;
> +	int err;
> +
> +	if (list_empty(demote_pages))
> +		return 0;
> +
> +	/* Demotion ignores all cpuset and mempolicy settings */
> +	err = migrate_pages(demote_pages, alloc_demote_page, NULL,
> +			    target_nid, MIGRATE_ASYNC, MR_DEMOTION,
> +			    &nr_succeeded);
> +
> +	if (err) {
> +		putback_movable_pages(demote_pages);
> +		list_splice(ret_list, demote_pages);
> +	}
> +
> +	return nr_succeeded;
> +}
> +
>  /*
>   * shrink_page_list() returns the number of reclaimed pages
>   */
> @@ -1082,6 +1161,7 @@ static unsigned int shrink_page_list(str
>  {
>  	LIST_HEAD(ret_pages);
>  	LIST_HEAD(free_pages);
> +	LIST_HEAD(demote_pages);
>  	unsigned int nr_reclaimed = 0;
>  	unsigned int pgactivate = 0;
>  
> @@ -1237,6 +1317,16 @@ static unsigned int shrink_page_list(str
>  		}
>  
>  		/*
> +		 * Before reclaiming the page, try to relocate
> +		 * its contents to another node.
> +		 */
> +		if (migrate_demote_page_ok(page, sc)) {
> +			list_add(&page->lru, &demote_pages);
> +			unlock_page(page);
> +			continue;
> +		}
> +
> +		/*
>  		 * Anonymous process memory has backing store?
>  		 * Try to allocate it some swap space here.
>  		 * Lazyfree page could be freed directly
> @@ -1484,6 +1574,9 @@ keep:
>  		VM_BUG_ON_PAGE(PageLRU(page) || PageUnevictable(page), page);
>  	}
>  
> +	/* Migrate pages selected for demotion */
> +	nr_reclaimed += demote_page_list(&ret_pages, &demote_pages, pgdat, sc);
> +
>  	pgactivate = stat->nr_activate[0] + stat->nr_activate[1];
>  
>  	mem_cgroup_uncharge_list(&free_pages);
> _

Generally, it's good to batch the page migration.  But one side effect
is that, if the pages are failed to be migrated, they will be placed
back to the LRU list instead of falling back to be reclaimed really.
This may cause some issue in some situation.  For example, if there's no
enough space in the PMEM (slow) node, so the page migration fails, OOM
may be triggered, because the direct reclaiming on the DRAM (fast) node
may make no progress, while it can reclaim some pages really before.

Best Regards,
Huang, Ying
