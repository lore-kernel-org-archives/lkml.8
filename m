Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E42C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 04:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F312073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 04:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgATETN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 23:19:13 -0500
Received: from foss.arm.com ([217.140.110.172]:55784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729039AbgATETN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 23:19:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6FF531B;
        Sun, 19 Jan 2020 20:19:12 -0800 (PST)
Received: from [10.162.16.78] (p8cg001049571a15.blr.arm.com [10.162.16.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37C7F3F52E;
        Sun, 19 Jan 2020 20:19:10 -0800 (PST)
Subject: Re: [PATCH -mm] mm/page_isolation: fix potential warning from user
To:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org
Cc:     mhocko@kernel.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200120034252.1558-1-cai@lca.pw>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <91ba5997-b227-7ae2-8459-310e18b9bb87@arm.com>
Date:   Mon, 20 Jan 2020 09:50:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200120034252.1558-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Qian,

On 01/20/2020 09:12 AM, Qian Cai wrote:
> It makes sense to call the WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE)
> from the offlining path, but should avoid triggering it from userspace,
> i.e, from is_mem_section_removable().

Could you elaborate why it makes sense not to warn about an unmovable
ZONE_MOVABLE page when an user tries to query about a memory block
device's movability through sysfs ?

> 
> While at it, simplify the code a bit by removing an unnecessary jump
> label and a local variable, so set_migratetype_isolate() could really
> return a bool.
> 
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  mm/page_alloc.c     | 11 ++++-------
>  mm/page_isolation.c | 31 ++++++++++++++++++-------------
>  2 files changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 621716a25639..3c4eb750a199 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8231,7 +8231,7 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  		if (is_migrate_cma(migratetype))
>  			return NULL;
>  
> -		goto unmovable;
> +		return page;
>  	}
>  
>  	for (; iter < pageblock_nr_pages; iter++) {
> @@ -8241,7 +8241,7 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  		page = pfn_to_page(pfn + iter);
>  
>  		if (PageReserved(page))
> -			goto unmovable;
> +			return page;
>  
>  		/*
>  		 * If the zone is movable and we have ruled out all reserved
> @@ -8261,7 +8261,7 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  			unsigned int skip_pages;
>  
>  			if (!hugepage_migration_supported(page_hstate(head)))
> -				goto unmovable;
> +				return page;
>  
>  			skip_pages = compound_nr(head) - (page - head);
>  			iter += skip_pages - 1;
> @@ -8303,12 +8303,9 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  		 * is set to both of a memory hole page and a _used_ kernel
>  		 * page at boot.
>  		 */
> -		goto unmovable;
> +		return page;
>  	}
>  	return NULL;
> -unmovable:
> -	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
> -	return pfn_to_page(pfn + iter);
>  }
>  
>  #ifdef CONFIG_CONTIG_ALLOC
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index e70586523ca3..97f673d5fefa 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -15,12 +15,12 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/page_isolation.h>
>  
> -static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags)
> +static bool set_migratetype_isolate(struct page *page, int migratetype,
> +				    int isol_flags)
>  {
> -	struct page *unmovable = NULL;
> +	struct page *unmovable = ERR_PTR(-EBUSY);
>  	struct zone *zone;
>  	unsigned long flags;
> -	int ret = -EBUSY;
>  
>  	zone = page_zone(page);
>  
> @@ -49,21 +49,26 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>  									NULL);
>  
>  		__mod_zone_freepage_state(zone, -nr_pages, mt);
> -		ret = 0;
>  	}
>  
>  out:
>  	spin_unlock_irqrestore(&zone->lock, flags);
> -	if (!ret)
> +
> +	if (!unmovable) {
>  		drain_all_pages(zone);
> -	else if ((isol_flags & REPORT_FAILURE) && unmovable)
> -		/*
> -		 * printk() with zone->lock held will guarantee to trigger a
> -		 * lockdep splat, so defer it here.
> -		 */
> -		dump_page(unmovable, "unmovable page");
> -
> -	return ret;
> +	} else {
> +		if (isol_flags & MEMORY_OFFLINE)
> +			WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);> +
> +		if ((isol_flags & REPORT_FAILURE) && !IS_ERR(unmovable))
> +			/*
> +			 * printk() with zone->lock held will likely trigger a
> +			 * lockdep splat, so defer it here.
> +			 */
> +			dump_page(unmovable, "unmovable page");
> +	}
> +
> +	return !!unmovable;
>  }
>  
>  static void unset_migratetype_isolate(struct page *page, unsigned migratetype)

set_migratetype_isolate() gets called from CMA as well as HugeTLB
allocation paths, so its not only during offline. Hence the commit
message should be changed to reflect this.

- Anshuman

> 
