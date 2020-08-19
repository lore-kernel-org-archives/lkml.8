Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F1DC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 22:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1970A2067C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 22:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxWNqRgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgHSWRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 18:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHSWRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 18:17:05 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D595C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 15:17:04 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id df16so71001edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 15:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z5oYfnvvNgOKzQEdHzTF0gJ2oJXC1K1LiPYrVBa6INo=;
        b=FxWNqRgRfNBd3JnmSgawx8jx2Sl7u9W80bi/iJMlRO3QXrnKPQoz+hBqp5ysqGSeJw
         ljW6J+Hng6tKeaCq1cY5k7YSo19zuCj5WVqXyV2eiWw6WSRjRoWmd/cQ6xlFkMd28cnj
         w5OLYfTdy4huFqN41t5A4BFB7Eke2et5WQQmHm5uRBWnbAzBDPin+6K2fT8eyys5k5xZ
         FYaH/YVHqHMf2oOubqj6ahqwJRqe6B4ycx/lxJJbYG31WkwzP2CuNBpjvfsCdYvh7Qgd
         IoDHwqtBRyLP1QA381RwwnEt6J6RqEWL0inppfi5H+KO3wiDv/mzKQAog4zFDzBiGyX0
         BVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z5oYfnvvNgOKzQEdHzTF0gJ2oJXC1K1LiPYrVBa6INo=;
        b=X7OqUGWNSQaNLMUoloaOYttGfboClIpyYMDTSTTGlKHcz1zzS3wXpbMlGUMuNPuCTj
         lA1Ydx3K5NlKnD0vSv4s/7cOrTQU/rKu0aPZ/pUrpu1liOf7/i46DRXcCOhcgci01tjt
         LmFRAa9GhAJoICBzHhW/Ceh28T9wJi1XK/iFyx2n4UQtxPDFJtWiUNi42dyhOCEDMkA2
         o1vaeWvx+ttq3vjZs+suUUYbYODSdzKePFKSHkE1mEM0/7Tc3KWcbs6uWQYeYzrxnnPn
         EpH+WLXQ20hy4ni1HGx483+6xQqv9cmtGqiXvjNrmz1ZIA0eoaceuxw5x6Rq4OlJO86K
         +HNQ==
X-Gm-Message-State: AOAM530pnaWHvkMp3O4kdUK/CEWaQaX0C5MN6CNcf7984U4cGQheWycQ
        tsyx0qwP5wCiPeHPkFozJH3fFiz1/+r0cncuOvw=
X-Google-Smtp-Source: ABdhPJzLW5c7FEkm5VPOxnh2XWllxfX9yJ8+CA0Yx5IymNKzUh21FK1RKmLUBk/p0raePx4rN1qkz/EWKn+q2pYq7xg=
X-Received: by 2002:a05:6402:2038:: with SMTP id ay24mr172019edb.200.1597875423373;
 Wed, 19 Aug 2020 15:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200818184704.3625199-1-yuzhao@google.com>
In-Reply-To: <20200818184704.3625199-1-yuzhao@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 19 Aug 2020 15:16:51 -0700
Message-ID: <CAHbLzkr4sKNaKnrzE00yFW2WNjYKo7NL0MohQN42a+oqMe6a8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm: remove activate_page() from unuse_pte()
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@suse.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 11:47 AM Yu Zhao <yuzhao@google.com> wrote:
>
> We don't initially add anon pages to active lruvec after
> commit b518154e59aa ("mm/vmscan: protect the workingset on anonymous LRU").
> Remove activate_page() from unuse_pte(), which seems to be missed by
> the commit. And make the function static while we are at it.
>
> Before the commit, we called lru_cache_add_active_or_unevictable() to
> add new ksm pages to active lruvec. Therefore, activate_page() wasn't
> necessary for them in the first place.

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  include/linux/swap.h | 1 -
>  mm/swap.c            | 4 ++--
>  mm/swapfile.c        | 5 -----
>  3 files changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 661046994db4..df6207346078 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -340,7 +340,6 @@ extern void lru_note_cost_page(struct page *);
>  extern void lru_cache_add(struct page *);
>  extern void lru_add_page_tail(struct page *page, struct page *page_tail,
>                          struct lruvec *lruvec, struct list_head *head);
> -extern void activate_page(struct page *);
>  extern void mark_page_accessed(struct page *);
>  extern void lru_add_drain(void);
>  extern void lru_add_drain_cpu(int cpu);
> diff --git a/mm/swap.c b/mm/swap.c
> index d16d65d9b4e0..25c4043491b3 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -348,7 +348,7 @@ static bool need_activate_page_drain(int cpu)
>         return pagevec_count(&per_cpu(lru_pvecs.activate_page, cpu)) != 0;
>  }
>
> -void activate_page(struct page *page)
> +static void activate_page(struct page *page)
>  {
>         page = compound_head(page);
>         if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
> @@ -368,7 +368,7 @@ static inline void activate_page_drain(int cpu)
>  {
>  }
>
> -void activate_page(struct page *page)
> +static void activate_page(struct page *page)
>  {
>         pg_data_t *pgdat = page_pgdat(page);
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 12f59e641b5e..c287c560f96d 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1925,11 +1925,6 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>                 lru_cache_add_inactive_or_unevictable(page, vma);
>         }
>         swap_free(entry);
> -       /*
> -        * Move the page to the active list so it is not
> -        * immediately swapped out again after swapon.
> -        */
> -       activate_page(page);
>  out:
>         pte_unmap_unlock(pte, ptl);
>         if (page != swapcache) {
> --
> 2.28.0.220.ged08abb693-goog
>
>
