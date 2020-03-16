Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD63C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 05:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC1E20724
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 05:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6BdumKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgCPFyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 01:54:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38726 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbgCPFyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 01:54:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id x11so14841297wrv.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Mar 2020 22:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ax5x7e9G6qoupvv/swllosGINAxfHgvPCsa6qdY4DyQ=;
        b=Z6BdumKUQzzaqO4fonExxUsP56ibvfFNQn7haYKxM0oBI8NfIkQPO17NhfPxYHRgJR
         7YdJpH9keBFQUdDZM9v1DlWOwMfc56YC9xy/CdCy/5cekbPObVKeqhTTwiX1CDWBGBWm
         f0ARYFGHwYvG2Jne8RoQUe89EiJRusOHYYQ3SQiI4BO4lbUqqeOazXHl28SkkWyLjMYc
         Gf37rp0RcCJ3RT84FB1cCZrVwR31s9sKmdL4T+RXVXFywDws4UKDGjcDpRWOgMZ1Rp4s
         gFgKsmxezrgq7p2bLCjkQwGy0QMd4Atf4lRQoVpJlHmTaQ3Bl9UGGCbUEJ+9BAOjQlEo
         JDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ax5x7e9G6qoupvv/swllosGINAxfHgvPCsa6qdY4DyQ=;
        b=NSC10pH0ZDI8W6i3amJ5jHQpBigH1spRjV92MYnWkRVzf0P/ApjtRXkaSwdnsg2JHO
         5vOD1s4bfW2/dEgCsV1mWjVGCyggYZJqVXCy3aqKkJwvlcK8oYGEqjt4ova0pQdwx6uS
         Ky7QJRKJfZBvcdAlXFA1Y1ksLu3X7fSDgs1b5o7DmK/nI6sY3Ecg7hvu8uI4pNrUfMSU
         pi1YL0HcFvGtNCKw8P7CS4srXm1aZDVXDPpDDD/Wf+MQ4VVBr2l+J+03TjMCfSPFCXMX
         IkQm5/w1XyMv537ThyXZUc1WdxeIHYy0yssOT47U7yJtrIcxgB6Xbt4jhpGbCPMwf4dX
         3yhw==
X-Gm-Message-State: ANhLgQ3ghicSw/0ou36jzJcooH27L3y8s60XLeGx0Ms5VQgBFl9Goycq
        axq2Gmrd3LeoElGvcvTeJmZmjFqOTPmOp3iHQ+4=
X-Google-Smtp-Source: ADFU+vuwX23GxIqxMh5kYLLQLW/IXkRYaf1Xy6SbrizYcyXQvPulNQf/U+7nclNoA9Xs2CUzlKHwvCwIX2foZpt5jM4=
X-Received: by 2002:a5d:6146:: with SMTP id y6mr34220103wrt.107.1584338059252;
 Sun, 15 Mar 2020 22:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200313090056.2104105-1-ying.huang@intel.com>
In-Reply-To: <20200313090056.2104105-1-ying.huang@intel.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Mon, 16 Mar 2020 06:54:08 +0100
Message-ID: <CAM9Jb+iTSUGB7UEf_RK0wMhRDPgi-HT0sM5yaK0X2ev7gcqmww@mail.gmail.com>
Subject: Re: [PATCH] mm: Code cleanup for MADV_FREE
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> From: Huang Ying <ying.huang@intel.com>
>
> Some comments for MADV_FREE is revised and added to help people understand the
> MADV_FREE code, especially the page flag, PG_swapbacked.  This makes
> page_is_file_cache() isn't consistent with its comments.  So the function is
> renamed to page_is_file_lru() to make them consistent again.  All these are put
> in one patch as one logical change.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Suggested-by: David Rientjes <rientjes@google.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Rik van Riel <riel@surriel.com>
> ---
>  include/linux/mm_inline.h     | 15 ++++++++-------
>  include/linux/page-flags.h    |  4 ++++
>  include/trace/events/vmscan.h |  2 +-
>  mm/compaction.c               |  2 +-
>  mm/gup.c                      |  2 +-
>  mm/khugepaged.c               |  4 ++--
>  mm/memory-failure.c           |  2 +-
>  mm/memory_hotplug.c           |  2 +-
>  mm/mempolicy.c                |  2 +-
>  mm/migrate.c                  | 16 ++++++++--------
>  mm/mprotect.c                 |  2 +-
>  mm/swap.c                     | 16 ++++++++--------
>  mm/vmscan.c                   | 12 ++++++------
>  13 files changed, 43 insertions(+), 38 deletions(-)
>
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 6f2fef7b0784..9aea990069a2 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -6,19 +6,20 @@
>  #include <linux/swap.h>
>
>  /**
> - * page_is_file_cache - should the page be on a file LRU or anon LRU?
> + * page_is_file_lru - should the page be on a file LRU or anon LRU?
>   * @page: the page to test
>   *
> - * Returns 1 if @page is page cache page backed by a regular filesystem,
> - * or 0 if @page is anonymous, tmpfs or otherwise ram or swap backed.
> - * Used by functions that manipulate the LRU lists, to sort a page
> - * onto the right LRU list.
> + * Returns 1 if @page is page cache page backed by a regular filesystem or
> + * anonymous page lazily freed (e.g. via MADV_FREE).  Returns 0 if @page is
> + * normal anonymous page, tmpfs or otherwise ram or swap backed.  Used by
> + * functions that manipulate the LRU lists, to sort a page onto the right LRU
> + * list.
>   *
>   * We would like to get this info without a page flag, but the state
>   * needs to survive until the page is last deleted from the LRU, which
>   * could be as far down as __page_cache_release.
>   */
> -static inline int page_is_file_cache(struct page *page)
> +static inline int page_is_file_lru(struct page *page)
>  {
>         return !PageSwapBacked(page);
>  }
> @@ -75,7 +76,7 @@ static __always_inline void del_page_from_lru_list(struct page *page,
>   */
>  static inline enum lru_list page_lru_base_type(struct page *page)
>  {
> -       if (page_is_file_cache(page))
> +       if (page_is_file_lru(page))
>                 return LRU_INACTIVE_FILE;
>         return LRU_INACTIVE_ANON;
>  }
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index d4771b1a1232..d7a8255d6b03 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -63,6 +63,10 @@
>   * page_waitqueue(page) is a wait queue of all tasks waiting for the page
>   * to become unlocked.
>   *
> + * PG_swapbacked is cleared if the page is page cache page backed by a regular
> + * file system or anonymous page lazily freed (e.g. via MADV_FREE).  It is set
> + * if the page is normal anonymous page, tmpfs or otherwise RAM or swap backed.
> + *
>   * PG_uptodate tells whether the page's contents is valid.  When a read
>   * completes, the page becomes uptodate, unless a disk I/O error happened.
>   *
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> index a5ab2973e8dc..74bb594ccb25 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -323,7 +323,7 @@ TRACE_EVENT(mm_vmscan_writepage,
>         TP_fast_assign(
>                 __entry->pfn = page_to_pfn(page);
>                 __entry->reclaim_flags = trace_reclaim_flags(
> -                                               page_is_file_cache(page));
> +                                               page_is_file_lru(page));
>         ),
>
>         TP_printk("page=%p pfn=%lu flags=%s",
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 827d8a2b3164..e8c84c6d4267 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -990,7 +990,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>                 /* Successfully isolated */
>                 del_page_from_lru_list(page, lruvec, page_lru(page));
>                 mod_node_page_state(page_pgdat(page),
> -                               NR_ISOLATED_ANON + page_is_file_cache(page),
> +                               NR_ISOLATED_ANON + page_is_file_lru(page),
>                                 hpage_nr_pages(page));
>
>  isolate_success:
> diff --git a/mm/gup.c b/mm/gup.c
> index e8aaa40c35ea..411cb09b4be3 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1691,7 +1691,7 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
>                                         list_add_tail(&head->lru, &cma_page_list);
>                                         mod_node_page_state(page_pgdat(head),
>                                                             NR_ISOLATED_ANON +
> -                                                           page_is_file_cache(head),
> +                                                           page_is_file_lru(head),
>                                                             hpage_nr_pages(head));
>                                 }
>                         }
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index d0ce22fb58d2..e8709e19beea 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -514,7 +514,7 @@ void __khugepaged_exit(struct mm_struct *mm)
>
>  static void release_pte_page(struct page *page)
>  {
> -       dec_node_page_state(page, NR_ISOLATED_ANON + page_is_file_cache(page));
> +       dec_node_page_state(page, NR_ISOLATED_ANON + page_is_file_lru(page));
>         unlock_page(page);
>         putback_lru_page(page);
>  }
> @@ -614,7 +614,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>                         goto out;
>                 }
>                 inc_node_page_state(page,
> -                               NR_ISOLATED_ANON + page_is_file_cache(page));
> +                               NR_ISOLATED_ANON + page_is_file_lru(page));
>                 VM_BUG_ON_PAGE(!PageLocked(page), page);
>                 VM_BUG_ON_PAGE(PageLRU(page), page);
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 1c961cd26c0b..a96364be8ab4 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1810,7 +1810,7 @@ static int __soft_offline_page(struct page *page, int flags)
>                  */
>                 if (!__PageMovable(page))
>                         inc_node_page_state(page, NR_ISOLATED_ANON +
> -                                               page_is_file_cache(page));
> +                                               page_is_file_lru(page));
>                 list_add(&page->lru, &pagelist);
>                 ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
>                                         MIGRATE_SYNC, MR_MEMORY_FAILURE);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 8bdf484241de..e3b2074ef30c 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1324,7 +1324,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>                         list_add_tail(&page->lru, &source);
>                         if (!__PageMovable(page))
>                                 inc_node_page_state(page, NR_ISOLATED_ANON +
> -                                                   page_is_file_cache(page));
> +                                                   page_is_file_lru(page));
>
>                 } else {
>                         pr_warn("failed to isolate pfn %lx\n", pfn);
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 0c6fbee1ea5a..2c41923892f7 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1048,7 +1048,7 @@ static int migrate_page_add(struct page *page, struct list_head *pagelist,
>                 if (!isolate_lru_page(head)) {
>                         list_add_tail(&head->lru, pagelist);
>                         mod_node_page_state(page_pgdat(head),
> -                               NR_ISOLATED_ANON + page_is_file_cache(head),
> +                               NR_ISOLATED_ANON + page_is_file_lru(head),
>                                 hpage_nr_pages(head));
>                 } else if (flags & MPOL_MF_STRICT) {
>                         /*
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 8f62089126ad..de23507f5c68 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -193,7 +193,7 @@ void putback_movable_pages(struct list_head *l)
>                         put_page(page);
>                 } else {
>                         mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
> -                                       page_is_file_cache(page), -hpage_nr_pages(page));
> +                                       page_is_file_lru(page), -hpage_nr_pages(page));
>                         putback_lru_page(page);
>                 }
>         }
> @@ -1223,7 +1223,7 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
>                  */
>                 if (likely(!__PageMovable(page)))
>                         mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
> -                                       page_is_file_cache(page), -hpage_nr_pages(page));
> +                                       page_is_file_lru(page), -hpage_nr_pages(page));
>         }
>
>         /*
> @@ -1595,7 +1595,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>                 err = 1;
>                 list_add_tail(&head->lru, pagelist);
>                 mod_node_page_state(page_pgdat(head),
> -                       NR_ISOLATED_ANON + page_is_file_cache(head),
> +                       NR_ISOLATED_ANON + page_is_file_lru(head),
>                         hpage_nr_pages(head));
>         }
>  out_putpage:
> @@ -1958,7 +1958,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>                 return 0;
>         }
>
> -       page_lru = page_is_file_cache(page);
> +       page_lru = page_is_file_lru(page);
>         mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_lru,
>                                 hpage_nr_pages(page));
>
> @@ -1994,7 +1994,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>          * Don't migrate file pages that are mapped in multiple processes
>          * with execute permissions as they are probably shared libraries.
>          */
> -       if (page_mapcount(page) != 1 && page_is_file_cache(page) &&
> +       if (page_mapcount(page) != 1 && page_is_file_lru(page) &&
>             (vma->vm_flags & VM_EXEC))
>                 goto out;
>
> @@ -2002,7 +2002,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>          * Also do not migrate dirty pages as not all filesystems can move
>          * dirty pages in MIGRATE_ASYNC mode which is a waste of cycles.
>          */
> -       if (page_is_file_cache(page) && PageDirty(page))
> +       if (page_is_file_lru(page) && PageDirty(page))
>                 goto out;
>
>         isolated = numamigrate_isolate_page(pgdat, page);
> @@ -2017,7 +2017,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>                 if (!list_empty(&migratepages)) {
>                         list_del(&page->lru);
>                         dec_node_page_state(page, NR_ISOLATED_ANON +
> -                                       page_is_file_cache(page));
> +                                       page_is_file_lru(page));
>                         putback_lru_page(page);
>                 }
>                 isolated = 0;
> @@ -2047,7 +2047,7 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
>         pg_data_t *pgdat = NODE_DATA(node);
>         int isolated = 0;
>         struct page *new_page = NULL;
> -       int page_lru = page_is_file_cache(page);
> +       int page_lru = page_is_file_lru(page);
>         unsigned long start = address & HPAGE_PMD_MASK;
>
>         new_page = alloc_pages_node(node,
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 4d30c4b549e1..494192ca954b 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -102,7 +102,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>                                  * it cannot move them all from MIGRATE_ASYNC
>                                  * context.
>                                  */
> -                               if (page_is_file_cache(page) && PageDirty(page))
> +                               if (page_is_file_lru(page) && PageDirty(page))
>                                         continue;
>
>                                 /*
> diff --git a/mm/swap.c b/mm/swap.c
> index 6a8be910b14d..f70e8b0b7319 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -276,7 +276,7 @@ static void __activate_page(struct page *page, struct lruvec *lruvec,
>                             void *arg)
>  {
>         if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
> -               int file = page_is_file_cache(page);
> +               int file = page_is_file_lru(page);
>                 int lru = page_lru_base_type(page);
>
>                 del_page_from_lru_list(page, lruvec, lru);
> @@ -394,7 +394,7 @@ void mark_page_accessed(struct page *page)
>                 else
>                         __lru_cache_activate_page(page);
>                 ClearPageReferenced(page);
> -               if (page_is_file_cache(page))
> +               if (page_is_file_lru(page))
>                         workingset_activation(page);
>         }
>         if (page_is_idle(page))
> @@ -515,7 +515,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
>                 return;
>
>         active = PageActive(page);
> -       file = page_is_file_cache(page);
> +       file = page_is_file_lru(page);
>         lru = page_lru_base_type(page);
>
>         del_page_from_lru_list(page, lruvec, lru + active);
> @@ -548,7 +548,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
>                             void *arg)
>  {
>         if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
> -               int file = page_is_file_cache(page);
> +               int file = page_is_file_lru(page);
>                 int lru = page_lru_base_type(page);
>
>                 del_page_from_lru_list(page, lruvec, lru + LRU_ACTIVE);
> @@ -573,9 +573,9 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
>                 ClearPageActive(page);
>                 ClearPageReferenced(page);
>                 /*
> -                * lazyfree pages are clean anonymous pages. They have
> -                * SwapBacked flag cleared to distinguish normal anonymous
> -                * pages
> +                * Lazyfree pages are clean anonymous pages.  They have
> +                * PG_swapbacked flag cleared, to distinguish them from normal
> +                * anonymous pages
>                  */
>                 ClearPageSwapBacked(page);
>                 add_page_to_lru_list(page, lruvec, LRU_INACTIVE_FILE);
> @@ -963,7 +963,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
>
>         if (page_evictable(page)) {
>                 lru = page_lru(page);
> -               update_page_reclaim_stat(lruvec, page_is_file_cache(page),
> +               update_page_reclaim_stat(lruvec, page_is_file_lru(page),
>                                          PageActive(page));
>                 if (was_unevictable)
>                         count_vm_event(UNEVICTABLE_PGRESCUED);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d9fb680884b8..d290a268dd68 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -919,7 +919,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
>                  * exceptional entries and shadow exceptional entries in the
>                  * same address_space.
>                  */
> -               if (reclaimed && page_is_file_cache(page) &&
> +               if (reclaimed && page_is_file_lru(page) &&
>                     !mapping_exiting(mapping) && !dax_mapping(mapping))
>                         shadow = workingset_eviction(page, target_memcg);
>                 __delete_from_page_cache(page, shadow);
> @@ -1043,7 +1043,7 @@ static void page_check_dirty_writeback(struct page *page,
>          * Anonymous pages are not handled by flushers and must be written
>          * from reclaim context. Do not stall reclaim based on them
>          */
> -       if (!page_is_file_cache(page) ||
> +       if (!page_is_file_lru(page) ||
>             (PageAnon(page) && !PageSwapBacked(page))) {
>                 *dirty = false;
>                 *writeback = false;
> @@ -1316,7 +1316,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>                          * the rest of the LRU for clean pages and see
>                          * the same dirty pages again (PageReclaim).
>                          */
> -                       if (page_is_file_cache(page) &&
> +                       if (page_is_file_lru(page) &&
>                             (!current_is_kswapd() || !PageReclaim(page) ||
>                              !test_bit(PGDAT_DIRTY, &pgdat->flags))) {
>                                 /*
> @@ -1460,7 +1460,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>                         try_to_free_swap(page);
>                 VM_BUG_ON_PAGE(PageActive(page), page);
>                 if (!PageMlocked(page)) {
> -                       int type = page_is_file_cache(page);
> +                       int type = page_is_file_lru(page);
>                         SetPageActive(page);
>                         stat->nr_activate[type] += nr_pages;
>                         count_memcg_page_event(page, PGACTIVATE);
> @@ -1498,7 +1498,7 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
>         LIST_HEAD(clean_pages);
>
>         list_for_each_entry_safe(page, next, page_list, lru) {
> -               if (page_is_file_cache(page) && !PageDirty(page) &&
> +               if (page_is_file_lru(page) && !PageDirty(page) &&
>                     !__PageMovable(page) && !PageUnevictable(page)) {
>                         ClearPageActive(page);
>                         list_move(&page->lru, &clean_pages);
> @@ -2054,7 +2054,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
>                          * IO, plus JVM can create lots of anon VM_EXEC pages,
>                          * so we ignore them here.
>                          */
> -                       if ((vm_flags & VM_EXEC) && page_is_file_cache(page)) {
> +                       if ((vm_flags & VM_EXEC) && page_is_file_lru(page)) {
>                                 list_add(&page->lru, &l_active);
>                                 continue;
>                         }
> --
> 2.25.0

Nice cleanup. With Michal's updated comment.

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

>
>
