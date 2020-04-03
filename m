Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C857EC2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9283020737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaXKzquQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391110AbgDCS34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:29:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45337 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgDCS34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:29:56 -0400
Received: by mail-ed1-f65.google.com with SMTP id dj7so8523939edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 11:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6e9wS8t2hCYFIL03IsdjDKcyfNg0eWNOAoHax5TvJ5U=;
        b=FaXKzquQ9FH/6mXJ3DXbKgsg7EJ3aR3iah/lMxbr5GaD/LZS0XnsTf+U8hGuoV4ktv
         O85TcxLq6oiP+LuQ5bGwHhs0xVzNTvhjuDKIx6mp9yLYV6u2oX0gC2D48Fj9EcRBSVdX
         9cIhqNmb3/N8B9sv7INmJVvBAwwd5qGjS5mALPomTV5n6KB1/LssPtu2rY3AS5e+abmK
         jFnX07JU7zLAK9/fBbIydycfBrOXsVHGyjsG0YBqh0r1zYpaygQYu4VuW8R3Sg56uEy+
         yTkxJKl8YY6/vwzPQ77RF45syWIypHaSWdJM68/vz2WBJ6VzJZIJoNdHgkNLRMZoyXvJ
         qLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6e9wS8t2hCYFIL03IsdjDKcyfNg0eWNOAoHax5TvJ5U=;
        b=czJHz4hDVd20WAUO7A6hfzzFjlNVhaVgj/m0lKrPsz2kGknhLSc1mJaYBvWzZc9xOs
         WE3RYKOaa4IdYJnSF2R211SMbXLWiDFPA4m+nJJLAgU2PwvxdMnh7sGoADHw1POZ5mUV
         zS30WOZwu3BNFSzaiPRvqwsXq7bPpiUEXfEjhJq08HPa1Dr/mFr+cTa9FruUnwRWmjwb
         3Lt3YyvIT22VZWw3f/GDNVuHxKk59K0wrnT0r/7CCNeakZRBW2VpePPMt93XJwMyupGS
         qJ5WDXxtvckelYGU781YAvJrHNKrnm+7Dcf9Iy360ayj/B/pEfAYEXp2BzuWEU6HQwwH
         MKHw==
X-Gm-Message-State: AGi0PuZb3XRoMLF0ACs6WyZmlTNvw+vlrfznoxgQ4O0JsojgG+7T8nKr
        RSusgnJjYwdPMGWPuAh2SwA7fbzidZKtkGINcjE=
X-Google-Smtp-Source: APiQypKDqIWAB5wvdki3EtQsyq1njBtFpddi2O04oweEZkTN3iFxAZETyRDZPciquHqSVWWb8iPicpeXL42y9lQNtNY=
X-Received: by 2002:a05:6402:b7b:: with SMTP id cb27mr9242647edb.343.1585938592474;
 Fri, 03 Apr 2020 11:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com> <1585892447-32059-6-git-send-email-iamjoonsoo.kim@lge.com>
In-Reply-To: <1585892447-32059-6-git-send-email-iamjoonsoo.kim@lge.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 3 Apr 2020 11:29:40 -0700
Message-ID: <CAHbLzkqdupWUv7vPpqDpOARuYkBiTxmQxNi-zaw_TWVB1FsNjQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] mm/swap: charge the page when adding to the swap cache
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 10:41 PM <js1304@gmail.com> wrote:
>
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Currently, some swapped-in pages are not charged to the memcg until
> actual access to the page happens. I checked the code and found that
> it could cause a problem. In this implementation, even if the memcg
> is enabled, one can consume a lot of memory in the system by exploiting
> this hole. For example, one can make all the pages swapped out and
> then call madvise_willneed() to load the all swapped-out pages without
> pressing the memcg. Although actual access requires charging, it's really
> big benefit to load the swapped-out pages to the memory without pressing
> the memcg.
>
> And, for workingset detection which is implemented on the following patch,
> a memcg should be committed before the workingset detection is executed.
> For this purpose, the best solution, I think, is charging the page when
> adding to the swap cache. Charging there is not that hard. Caller of
> adding the page to the swap cache has enough information about the charged
> memcg. So, what we need to do is just passing this information to
> the right place.
>
> With this patch, specific memcg could be pressured more since readahead
> pages are also charged to it now. This would result in performance
> degradation to that user but it would be fair since that readahead is for
> that user.

If I read the code correctly, the readahead pages may be *not* charged
to it at all but other memcgs since mem_cgroup_try_charge() would
retrieve the target memcg id from the swap entry then charge to it
(generally it is the memcg from who the page is swapped out). So, it
may open a backdoor to let one memcg stress other memcgs?

>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  include/linux/swap.h |  4 ++--
>  mm/shmem.c           | 18 ++++++++++--------
>  mm/swap_state.c      | 25 +++++++++++++++++++++----
>  3 files changed, 33 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 273de48..eea0700 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -409,7 +409,7 @@ extern unsigned long total_swapcache_pages(void);
>  extern void show_swap_cache_info(void);
>  extern int add_to_swap(struct page *page);
>  extern int add_to_swap_cache(struct page *page, swp_entry_t entry,
> -                       gfp_t gfp, void **shadowp);
> +                       struct vm_area_struct *vma, gfp_t gfp, void **shadowp);
>  extern int __add_to_swap_cache(struct page *page, swp_entry_t entry);
>  extern void __delete_from_swap_cache(struct page *page,
>                         swp_entry_t entry, void *shadow);
> @@ -567,7 +567,7 @@ static inline int add_to_swap(struct page *page)
>  }
>
>  static inline int add_to_swap_cache(struct page *page, swp_entry_t entry,
> -                                       gfp_t gfp_mask, void **shadowp)
> +                       struct vm_area_struct *vma, gfp_t gfp, void **shadowp)
>  {
>         return -1;
>  }
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 9e34b4e..8e28c1f 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1369,7 +1369,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
>         if (list_empty(&info->swaplist))
>                 list_add(&info->swaplist, &shmem_swaplist);
>
> -       if (add_to_swap_cache(page, swap,
> +       if (add_to_swap_cache(page, swap, NULL,
>                         __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN,
>                         NULL) == 0) {
>                 spin_lock_irq(&info->lock);
> @@ -1434,10 +1434,11 @@ static inline struct mempolicy *shmem_get_sbmpol(struct shmem_sb_info *sbinfo)
>  #endif
>
>  static void shmem_pseudo_vma_init(struct vm_area_struct *vma,
> -               struct shmem_inode_info *info, pgoff_t index)
> +                       struct mm_struct *mm, struct shmem_inode_info *info,
> +                       pgoff_t index)
>  {
>         /* Create a pseudo vma that just contains the policy */
> -       vma_init(vma, NULL);
> +       vma_init(vma, mm);
>         /* Bias interleave by inode number to distribute better across nodes */
>         vma->vm_pgoff = index + info->vfs_inode.i_ino;
>         vma->vm_policy = mpol_shared_policy_lookup(&info->policy, index);
> @@ -1450,13 +1451,14 @@ static void shmem_pseudo_vma_destroy(struct vm_area_struct *vma)
>  }
>
>  static struct page *shmem_swapin(swp_entry_t swap, gfp_t gfp,
> -                       struct shmem_inode_info *info, pgoff_t index)
> +                       struct mm_struct *mm, struct shmem_inode_info *info,
> +                       pgoff_t index)
>  {
>         struct vm_area_struct pvma;
>         struct page *page;
>         struct vm_fault vmf;
>
> -       shmem_pseudo_vma_init(&pvma, info, index);
> +       shmem_pseudo_vma_init(&pvma, mm, info, index);
>         vmf.vma = &pvma;
>         vmf.address = 0;
>         page = swap_cluster_readahead(swap, gfp, &vmf);
> @@ -1481,7 +1483,7 @@ static struct page *shmem_alloc_hugepage(gfp_t gfp,
>                                                                 XA_PRESENT))
>                 return NULL;
>
> -       shmem_pseudo_vma_init(&pvma, info, hindex);
> +       shmem_pseudo_vma_init(&pvma, NULL, info, hindex);
>         page = alloc_pages_vma(gfp | __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN,
>                         HPAGE_PMD_ORDER, &pvma, 0, numa_node_id(), true);
>         shmem_pseudo_vma_destroy(&pvma);
> @@ -1496,7 +1498,7 @@ static struct page *shmem_alloc_page(gfp_t gfp,
>         struct vm_area_struct pvma;
>         struct page *page;
>
> -       shmem_pseudo_vma_init(&pvma, info, index);
> +       shmem_pseudo_vma_init(&pvma, NULL, info, index);
>         page = alloc_page_vma(gfp, &pvma, 0);
>         shmem_pseudo_vma_destroy(&pvma);
>
> @@ -1652,7 +1654,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>                         count_memcg_event_mm(charge_mm, PGMAJFAULT);
>                 }
>                 /* Here we actually start the io */
> -               page = shmem_swapin(swap, gfp, info, index);
> +               page = shmem_swapin(swap, gfp, charge_mm, info, index);
>                 if (!page) {
>                         error = -ENOMEM;
>                         goto failed;
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index f06af84..1db73a2 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -112,7 +112,7 @@ void show_swap_cache_info(void)
>   * but sets SwapCache flag and private instead of mapping and index.
>   */
>  int add_to_swap_cache(struct page *page, swp_entry_t entry,
> -                       gfp_t gfp, void **shadowp)
> +                       struct vm_area_struct *vma, gfp_t gfp, void **shadowp)
>  {
>         struct address_space *address_space = swap_address_space(entry);
>         pgoff_t idx = swp_offset(entry);
> @@ -120,14 +120,26 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry,
>         unsigned long i, nr = compound_nr(page);
>         unsigned long nrexceptional = 0;
>         void *old;
> +       bool compound = !!compound_order(page);
> +       int error;
> +       struct mm_struct *mm = vma ? vma->vm_mm : current->mm;
> +       struct mem_cgroup *memcg;
>
>         VM_BUG_ON_PAGE(!PageLocked(page), page);
>         VM_BUG_ON_PAGE(PageSwapCache(page), page);
>         VM_BUG_ON_PAGE(!PageSwapBacked(page), page);
>
>         page_ref_add(page, nr);
> +       /* PageSwapCache() prevent the page from being re-charged */
>         SetPageSwapCache(page);
>
> +       error = mem_cgroup_try_charge(page, mm, gfp, &memcg, compound);
> +       if (error) {
> +               ClearPageSwapCache(page);
> +               page_ref_sub(page, nr);
> +               return error;
> +       }
> +
>         do {
>                 xas_lock_irq(&xas);
>                 xas_create_range(&xas);
> @@ -153,11 +165,16 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry,
>                 xas_unlock_irq(&xas);
>         } while (xas_nomem(&xas, gfp));
>
> -       if (!xas_error(&xas))
> +       if (!xas_error(&xas)) {
> +               mem_cgroup_commit_charge(page, memcg, false, compound);
>                 return 0;
> +       }
> +
> +       mem_cgroup_cancel_charge(page, memcg, compound);
>
>         ClearPageSwapCache(page);
>         page_ref_sub(page, nr);
> +
>         return xas_error(&xas);
>  }
>
> @@ -221,7 +238,7 @@ int add_to_swap(struct page *page)
>         /*
>          * Add it to the swap cache.
>          */
> -       err = add_to_swap_cache(page, entry,
> +       err = add_to_swap_cache(page, entry, NULL,
>                         __GFP_HIGH|__GFP_NOMEMALLOC|__GFP_NOWARN, NULL);
>         if (err)
>                 /*
> @@ -431,7 +448,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>                 /* May fail (-ENOMEM) if XArray node allocation failed. */
>                 __SetPageLocked(new_page);
>                 __SetPageSwapBacked(new_page);
> -               err = add_to_swap_cache(new_page, entry,
> +               err = add_to_swap_cache(new_page, entry, vma,
>                                 gfp_mask & GFP_KERNEL, NULL);
>                 if (likely(!err)) {
>                         /* Initiate read into locked page */
> --
> 2.7.4
>
>
