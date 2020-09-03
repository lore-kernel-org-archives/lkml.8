Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CCFC10DAA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 21:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4AE820678
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 21:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599170329;
	bh=EC6CX/KNbyV5W8h0mO8/qnp463DvcqyLD4Qi+RZkZ3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=D8ElbeeGik5J1C3+AbNfQ2KbPKi4LuAnhU00iUQ+fU8/OfXms4jj17lfCLOf3HyIo
	 o0GQZGTrmwEbL8mUoI+pA8unckLya2M8ZCzT+DUAbAgFExPrHUKCGfEZEt9kwqgsRo
	 AAcLHu2IAtMgtAwv9j2NOLgXZzTeb0vAgnLS04S0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgICV6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:58:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729088AbgICV6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 17:58:45 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CF0C20716;
        Thu,  3 Sep 2020 21:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599170324;
        bh=EC6CX/KNbyV5W8h0mO8/qnp463DvcqyLD4Qi+RZkZ3A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cgMLLtkB0q10Wzr9BigkKgUusENFyE6b3jgBsEBwETtXsJhVWIZ8aTg4F7vcDisgt
         ZM/vym9XXALvf+N5mRSPUgcVn0BnRqvTOFhNxmqHlGJv6L9SD3RdFne2ylBcsXtU6c
         K45oP0eMLmZZjxmr47KwuTSglDNjivNxK5txXizk=
Date:   Thu, 3 Sep 2020 14:58:44 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 03/10] mm/memory_hotplug: simplify page offlining
Message-Id: <20200903145844.2ead558f5bc3ef3d5230d30f@linux-foundation.org>
In-Reply-To: <20200819175957.28465-4-david@redhat.com>
References: <20200819175957.28465-1-david@redhat.com>
        <20200819175957.28465-4-david@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020 19:59:50 +0200 David Hildenbrand <david@redhat.com> wrote:

> We make sure that we cannot have any memory holes right at the beginning
> of offline_pages(). We no longer need walk_system_ram_range() and can
> call test_pages_isolated() and __offline_isolated_pages() directly.
> 
> offlined_pages always corresponds to nr_pages, so we can simplify that.

This patch ran afoul of Pavel's "mm/memory_hotplug: drain per-cpu pages
again during memory offline", here:

> @@ -1481,7 +1459,7 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
>  int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  {
>  	const unsigned long end_pfn = start_pfn + nr_pages;
> -	unsigned long pfn, system_ram_pages = 0, offlined_pages = 0;
> +	unsigned long pfn, system_ram_pages = 0;
>  	int ret, node, nr_isolate_pageblock;
>  	unsigned long flags;
>  	struct zone *zone;
> @@ -1579,16 +1557,12 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  			reason = "failure to dissolve huge pages";
>  			goto failed_removal_isolated;
>  		}
> -		/* check again */
> -		ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
> -					    NULL, check_pages_isolated_cb);
> -	} while (ret);
> -
> -	/* Ok, all of our target is isolated.
> -	   We cannot do rollback at this point. */
> -	walk_system_ram_range(start_pfn, end_pfn - start_pfn,
> -			      &offlined_pages, offline_isolated_pages_cb);
> -	pr_info("Offlined Pages %ld\n", offlined_pages);
> +	} while (test_pages_isolated(start_pfn, end_pfn, MEMORY_OFFLINE));
> +
> +	/* Mark all sections offline and remove free pages from the buddy. */
> +	__offline_isolated_pages(start_pfn, end_pfn);
> +	pr_info("Offlined Pages %ld\n", nr_pages);
> +
>  	/*
>  	 * Onlining will reset pagetype flags and makes migrate type

I did this.  Looks OK?

From: David Hildenbrand <david@redhat.com>
Subject: mm/memory_hotplug: simplify page offlining

We make sure that we cannot have any memory holes right at the beginning
of offline_pages().  We no longer need walk_system_ram_range() and can
call test_pages_isolated() and __offline_isolated_pages() directly.

offlined_pages always corresponds to nr_pages, so we can simplify that.

Link: https://lkml.kernel.org/r/20200819175957.28465-4-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Charan Teja Reddy <charante@codeaurora.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michel Lespinasse <walken@google.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/memory_hotplug.c |   61 +++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 36 deletions(-)

--- a/mm/memory_hotplug.c~mm-memory_hotplug-simplify-page-offlining
+++ a/mm/memory_hotplug.c
@@ -1383,28 +1383,6 @@ do_migrate_range(unsigned long start_pfn
 	return ret;
 }
 
-/* Mark all sections offline and remove all free pages from the buddy. */
-static int
-offline_isolated_pages_cb(unsigned long start, unsigned long nr_pages,
-			void *data)
-{
-	unsigned long *offlined_pages = (unsigned long *)data;
-
-	*offlined_pages += __offline_isolated_pages(start, start + nr_pages);
-	return 0;
-}
-
-/*
- * Check all pages in range, recorded as memory resource, are isolated.
- */
-static int
-check_pages_isolated_cb(unsigned long start_pfn, unsigned long nr_pages,
-			void *data)
-{
-	return test_pages_isolated(start_pfn, start_pfn + nr_pages,
-				   MEMORY_OFFLINE);
-}
-
 static int __init cmdline_parse_movable_node(char *p)
 {
 	movable_node_enabled = true;
@@ -1491,7 +1469,7 @@ static int count_system_ram_pages_cb(uns
 int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 {
 	const unsigned long end_pfn = start_pfn + nr_pages;
-	unsigned long pfn, system_ram_pages = 0, offlined_pages = 0;
+	unsigned long pfn, system_ram_pages = 0;
 	int ret, node, nr_isolate_pageblock;
 	unsigned long flags;
 	struct zone *zone;
@@ -1589,16 +1567,27 @@ int __ref offline_pages(unsigned long st
 			reason = "failure to dissolve huge pages";
 			goto failed_removal_isolated;
 		}
-		/* check again */
-		ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
-					    NULL, check_pages_isolated_cb);
-	} while (ret);
-
-	/* Ok, all of our target is isolated.
-	   We cannot do rollback at this point. */
-	walk_system_ram_range(start_pfn, end_pfn - start_pfn,
-			      &offlined_pages, offline_isolated_pages_cb);
-	pr_info("Offlined Pages %ld\n", offlined_pages);
+
+		/*
+		 * per-cpu pages are drained in start_isolate_page_range, but if
+		 * there are still pages that are not free, make sure that we
+		 * drain again, because when we isolated range we might
+		 * have raced with another thread that was adding pages to pcp
+		 * list.
+		 *
+		 * Forward progress should be still guaranteed because
+		 * pages on the pcp list can only belong to MOVABLE_ZONE
+		 * because has_unmovable_pages explicitly checks for
+		 * PageBuddy on freed pages on other zones.
+		 */
+		if (ret)
+			drain_all_pages(zone);
+	} while (test_pages_isolated(start_pfn, end_pfn, MEMORY_OFFLINE));
+
+	/* Mark all sections offline and remove free pages from the buddy. */
+	__offline_isolated_pages(start_pfn, end_pfn);
+	pr_info("Offlined Pages %ld\n", nr_pages);
+
 	/*
 	 * Onlining will reset pagetype flags and makes migrate type
 	 * MOVABLE, so just need to decrease the number of isolated
@@ -1609,11 +1598,11 @@ int __ref offline_pages(unsigned long st
 	spin_unlock_irqrestore(&zone->lock, flags);
 
 	/* removal success */
-	adjust_managed_page_count(pfn_to_page(start_pfn), -offlined_pages);
-	zone->present_pages -= offlined_pages;
+	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
+	zone->present_pages -= nr_pages;
 
 	pgdat_resize_lock(zone->zone_pgdat, &flags);
-	zone->zone_pgdat->node_present_pages -= offlined_pages;
+	zone->zone_pgdat->node_present_pages -= nr_pages;
 	pgdat_resize_unlock(zone->zone_pgdat, &flags);
 
 	init_per_zone_wmark_min();
_

