Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFBAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3821420738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lueoNtOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgHTWmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 18:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgHTWmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 18:42:22 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11AFC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:42:21 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f24so108149ejx.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/kymetnv79xgx6DMRcXD17OGKR/RGTH2RjZ9GgB6T0=;
        b=lueoNtOe7UWPxNGwY43gfs5vFhtUrP9esf/ytEsib2rAtvZhMRKUwLGcOEDNXZEa7l
         wl38uriRZBxeiOkv9JjZzDbQ+JVJXoh/c3/5y+gYWLluBSz0nl177H25ml+bYXI5M62x
         PQo70EgSMYfQUuBzOKROBshTJtvb9NtjMLmrS2Z0v7hIRsTxc2mBSRuSrbKLW89EFsYs
         +U05ZX44SkOSo0/4cX4/Md3cr0qlmUQBpX3VsMSj4u21E5WA6ZNzQ1BqhH64v7E0IfuV
         AQojeCoMsPaksTJ0PS+krcdl5V031K1DAkj9isyb13KdG+surmqU9CpAES4SzSiWyv3I
         sIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/kymetnv79xgx6DMRcXD17OGKR/RGTH2RjZ9GgB6T0=;
        b=ZDfCFsdBc1M2e4nR74+JPjURc6Q/Qe+5m3R39mvJ62aTrWqKf0mqWgQx1nsWrA43l9
         J2o5jYlCm0z9E7MVECjxgN7mFpE7IUU076xXajkXsNfdX6C801InNxXrhpuJUWqRZfdW
         WTCaGftYeVKSjHc6vF4uMTR3uVRGMzLCos7UGPIPFPLNZWgFSQrbAGD5/uFS8ZLYy5Uh
         lgyf1fIhtqOEYP87wuaisM093vRCX6cjAGCpRZsOA2rWmVC82qLj9NkIVMASCl8IexaR
         AWwKrFaTLSzwrAvivZsGERdw+ZyA5fpnumMPn8izn4k/XF0cCYqX0qgPolpbJx8j5aDc
         IbPg==
X-Gm-Message-State: AOAM531ouobZ1KrJG8tGjyGNkE7+8c5owuPrFs4iutfSeAnzcYb6cqqD
        M8PkD0H1fZ/sna+cpCayzPu39Ctawc5wBvbyYWA=
X-Google-Smtp-Source: ABdhPJyqrwc3cefbqkhA0ceuf8kh6KY1ic7/BGYchgOr5LbmbQ5qgeJs6EGdWFOWqs1lmvLiSTJv+zyiRvRGLXATr/0=
X-Received: by 2002:a17:906:84e1:: with SMTP id zp1mr794136ejb.499.1597963340205;
 Thu, 20 Aug 2020 15:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200818184122.29C415DF@viggo.jf.intel.com> <20200818184131.C972AFCC@viggo.jf.intel.com>
In-Reply-To: <20200818184131.C972AFCC@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 20 Aug 2020 15:42:08 -0700
Message-ID: <CAHbLzkqEtLEoMCkiLg8o4aGz2EPDmD_yiaxNrndy2wwcUs4DKA@mail.gmail.com>
Subject: Re: [RFC][PATCH 5/9] mm/migrate: demote pages during reclaim
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 11:51 AM Dave Hansen
<dave.hansen@linux.intel.com> wrote:
>
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> This is mostly derived from a patch from Yang Shi:
>
>         https://lore.kernel.org/linux-mm/1560468577-101178-10-git-send-email-yang.shi@linux.alibaba.com/
>
> Add code to the reclaim path (shrink_page_list()) to "demote" data
> to another NUMA node instead of discarding the data.  This always
> avoids the cost of I/O needed to read the page back in and sometimes
> avoids the writeout cost when the pagee is dirty.
>
> Note: This just adds the start of infratructure for migration. It is
> actually disabled next to the FIXME in migrate_demote_page_ok().
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> ---
>
>  b/include/linux/migrate.h |    2
>  b/mm/vmscan.c             |   93 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 95 insertions(+)
>
> diff -puN include/linux/migrate.h~demote-with-migrate_pages include/linux/migrate.h
> --- a/include/linux/migrate.h~demote-with-migrate_pages 2020-08-18 11:36:52.916583179 -0700
> +++ b/include/linux/migrate.h   2020-08-18 11:36:52.923583179 -0700
> @@ -25,6 +25,7 @@ enum migrate_reason {
>         MR_MEMPOLICY_MBIND,
>         MR_NUMA_MISPLACED,
>         MR_CONTIG_RANGE,
> +       MR_DEMOTION,
>         MR_TYPES
>  };
>
> @@ -210,6 +211,7 @@ struct migrate_vma {
>  int migrate_vma_setup(struct migrate_vma *args);
>  void migrate_vma_pages(struct migrate_vma *migrate);
>  void migrate_vma_finalize(struct migrate_vma *migrate);
> +int next_demotion_node(int node);
>
>  #endif /* CONFIG_MIGRATION */
>
> diff -puN mm/vmscan.c~demote-with-migrate_pages mm/vmscan.c
> --- a/mm/vmscan.c~demote-with-migrate_pages     2020-08-18 11:36:52.919583179 -0700
> +++ b/mm/vmscan.c       2020-08-18 11:36:52.924583179 -0700
> @@ -43,6 +43,7 @@
>  #include <linux/kthread.h>
>  #include <linux/freezer.h>
>  #include <linux/memcontrol.h>
> +#include <linux/migrate.h>
>  #include <linux/delayacct.h>
>  #include <linux/sysctl.h>
>  #include <linux/oom.h>
> @@ -1040,6 +1041,24 @@ static enum page_references page_check_r
>         return PAGEREF_RECLAIM;
>  }
>
> +bool migrate_demote_page_ok(struct page *page, struct scan_control *sc)
> +{
> +       int next_nid = next_demotion_node(page_to_nid(page));
> +
> +       VM_BUG_ON_PAGE(!PageLocked(page), page);
> +       VM_BUG_ON_PAGE(PageHuge(page), page);
> +       VM_BUG_ON_PAGE(PageLRU(page), page);
> +

I think we'd better rule out MADV_FREE pages since it doesn't make too
much sense to migrate MADV_FREE pages, they can be just discarded.

> +       if (next_nid == NUMA_NO_NODE)
> +               return false;
> +       if (PageTransHuge(page) && !thp_migration_supported())
> +               return false;
> +
> +       // FIXME: actually enable this later in the series
> +       return false;
> +}
> +
> +
>  /* Check if a page is dirty or under writeback */
>  static void page_check_dirty_writeback(struct page *page,
>                                        bool *dirty, bool *writeback)
> @@ -1070,6 +1089,66 @@ static void page_check_dirty_writeback(s
>                 mapping->a_ops->is_dirty_writeback(page, dirty, writeback);
>  }
>
> +static struct page *alloc_demote_page(struct page *page, unsigned long node)
> +{
> +       /*
> +        * Try to fail quickly if memory on the target node is not
> +        * available.  Leaving out __GFP_IO and __GFP_FS helps with
> +        * this.  If the desintation node is full, we want kswapd to
> +        * run there so that its pages will get reclaimed and future
> +        * migration attempts may succeed.
> +        */
> +       gfp_t flags = (__GFP_HIGHMEM | __GFP_MOVABLE | __GFP_NORETRY |
> +                      __GFP_NOMEMALLOC | __GFP_NOWARN | __GFP_THISNODE |
> +                      __GFP_KSWAPD_RECLAIM);
> +       /* HugeTLB pages should not be on the LRU */
> +       WARN_ON_ONCE(PageHuge(page));
> +
> +       if (PageTransHuge(page)) {
> +               struct page *thp;
> +
> +               flags |= __GFP_COMP;
> +
> +               thp = alloc_pages_node(node, flags, HPAGE_PMD_ORDER);
> +               if (!thp)
> +                       return NULL;
> +               prep_transhuge_page(thp);
> +               return thp;
> +       }
> +
> +       return __alloc_pages_node(node, flags, 0);
> +}
> +
> +/*
> + * Take pages on @demote_list and attempt to demote them to
> + * another node.  Pages which are not demoted are added to
> + * @ret_pages.
> + */
> +static unsigned int demote_page_list(struct list_head *ret_list,
> +                                    struct list_head *demote_pages,
> +                                    struct pglist_data *pgdat,
> +                                    struct scan_control *sc)
> +{
> +       int target_nid = next_demotion_node(pgdat->node_id);
> +       unsigned int nr_succeeded = 0;
> +       int err;
> +
> +       if (list_empty(demote_pages))
> +               return 0;
> +
> +       /* Demotion ignores all cpuset and mempolicy settings */
> +       err = migrate_pages(demote_pages, alloc_demote_page, NULL,
> +                           target_nid, MIGRATE_ASYNC, MR_DEMOTION,
> +                           &nr_succeeded);
> +
> +       if (err) {
> +               putback_movable_pages(demote_pages);
> +               list_splice(ret_list, demote_pages);
> +       }
> +
> +       return nr_succeeded;
> +}
> +
>  /*
>   * shrink_page_list() returns the number of reclaimed pages
>   */
> @@ -1082,6 +1161,7 @@ static unsigned int shrink_page_list(str
>  {
>         LIST_HEAD(ret_pages);
>         LIST_HEAD(free_pages);
> +       LIST_HEAD(demote_pages);
>         unsigned int nr_reclaimed = 0;
>         unsigned int pgactivate = 0;
>
> @@ -1237,6 +1317,16 @@ static unsigned int shrink_page_list(str
>                 }
>
>                 /*
> +                * Before reclaiming the page, try to relocate
> +                * its contents to another node.
> +                */
> +               if (migrate_demote_page_ok(page, sc)) {
> +                       list_add(&page->lru, &demote_pages);
> +                       unlock_page(page);
> +                       continue;
> +               }
> +
> +               /*
>                  * Anonymous process memory has backing store?
>                  * Try to allocate it some swap space here.
>                  * Lazyfree page could be freed directly
> @@ -1484,6 +1574,9 @@ keep:
>                 VM_BUG_ON_PAGE(PageLRU(page) || PageUnevictable(page), page);
>         }
>
> +       /* Migrate pages selected for demotion */
> +       nr_reclaimed += demote_page_list(&ret_pages, &demote_pages, pgdat, sc);
> +
>         pgactivate = stat->nr_activate[0] + stat->nr_activate[1];
>
>         mem_cgroup_uncharge_list(&free_pages);
> _
