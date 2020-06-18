Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDA9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 00:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73BC6218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 00:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KszlupuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgFRArf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 20:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgFRAre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 20:47:34 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528F3C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 17:47:34 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q19so5165640lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 17:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UKv1Zp4+yxdPRkyQkwK+sztZAa8HdfQ1Elip3FODnvg=;
        b=KszlupuXXwQyoadmThaxgY8Bq4oZjmpBB6nwuyOeR5WNcjXx+GwWj0IFAJhSxFju4k
         Z7+tstvQcm9K0Rh8g+rRsh3aVVfdjGYKmLqUliOuPJ+WRJ8uiD5ZiR4ZNQOo4ryHsmY5
         iWQI+0t8cr+jLZRs6gcnLN581fD3eQR7pbi+51GLYvvqb0mcHm1vuEgmSfmjzg83UZ5Z
         ltwj8+vxrifmesibdCwU6baexQPsO6I/cr6YXCs9wEl+SpS+8Wt+aKhtKgAqbyjEj4dC
         12SBF3C6IC8kvgC4quRJl+NbxOgumkMu4SDgvs/+IckdGzZ4pGehjc26UZpPpFw9gZXs
         DmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UKv1Zp4+yxdPRkyQkwK+sztZAa8HdfQ1Elip3FODnvg=;
        b=DSFZ58P8dA7iGigXwfy3q2jE0ZOspVnx3vdGbx4qzUAgML0mBg8scX1m9dUImTb2MM
         YfeM/c8urFSCTTh8FGYPbxc58QbEjZ8z7mHXDZ4a9EH/UUEv9pca+GAlHqHMibMEounW
         /pAwmPx9SplBsHVboLWgeDDdHuxtL+IRoV3FXdN/Ow8R0Pk88Ss50HWFt2vlvTSbQfJQ
         Yb+KfJsmq5CwujdVFdMb+IY2hN82Y1ZlcUao23mOw8ghyyIw+QlfgGmKdsrCB1vwDRjr
         tILpjMr5BUQ8RBM005J5ysx5YMgTGtXwNO8nBNkW7UOXTUc5QJPWE8ygMDEXo7lO5i3r
         vtzg==
X-Gm-Message-State: AOAM531+vslSEXCwOYCE7DVx4hk5NNODmlowUEg1h5YmVUSrRHiP3ypy
        98oV3Oahh0M/jeEEU82WK3nUWDhPVcP6CEdGrSSadw==
X-Google-Smtp-Source: ABdhPJwZszToiMUm3ryskTPtLSKel8Tu2EbFYBjVIH8KR7MqzEEAv5D/09s7kKHMfofjHNoQMPw0eQf6YP/CYQkSTiU=
X-Received: by 2002:a2e:9ac4:: with SMTP id p4mr1005494ljj.446.1592441252467;
 Wed, 17 Jun 2020 17:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-6-guro@fb.com>
In-Reply-To: <20200608230654.828134-6-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 17 Jun 2020 17:47:21 -0700
Message-ID: <CALvZod5K8gvZnWT-RPJU=VL4OUiDsu6z11Z1WSfYRWDLUOktZQ@mail.gmail.com>
Subject: Re: [PATCH v6 05/19] mm: memcontrol: decouple reference counting from
 page accounting
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
>
> From: Johannes Weiner <hannes@cmpxchg.org>
>
> The reference counting of a memcg is currently coupled directly to how
> many 4k pages are charged to it. This doesn't work well with Roman's
> new slab controller, which maintains pools of objects and doesn't want
> to keep an extra balance sheet for the pages backing those objects.
>
> This unusual refcounting design (reference counts usually track
> pointers to an object) is only for historical reasons: memcg used to
> not take any css references and simply stalled offlining until all
> charges had been reparented and the page counters had dropped to
> zero. When we got rid of the reparenting requirement, the simple
> mechanical translation was to take a reference for every charge.
>
> More historical context can be found in commit e8ea14cc6ead ("mm:
> memcontrol: take a css reference for each charged page"),
> commit 64f219938941 ("mm: memcontrol: remove obsolete kmemcg pinning
> tricks") and commit b2052564e66d ("mm: memcontrol: continue cache
> reclaim from offlined groups").
>
> The new slab controller exposes the limitations in this scheme, so
> let's switch it to a more idiomatic reference counting model based on
> actual kernel pointers to the memcg:
>
> - The per-cpu stock holds a reference to the memcg its caching
>
> - User pages hold a reference for their page->mem_cgroup. Transparent
>   huge pages will no longer acquire tail references in advance, we'll
>   get them if needed during the split.
>
> - Kernel pages hold a reference for their page->mem_cgroup
>
> - Pages allocated in the root cgroup will acquire and release css
>   references for simplicity. css_get() and css_put() optimize that.
>
> - The current memcg_charge_slab() already hacked around the per-charge
>   references; this change gets rid of that as well.
>
> Roman:
> 1) Rebased on top of the current mm tree: added css_get() in
>    mem_cgroup_charge(), dropped mem_cgroup_try_charge() part
> 2) I've reformatted commit references in the commit log to make
>    checkpatch.pl happy.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/memcontrol.c | 37 +++++++++++++++++++++----------------
>  mm/slab.h       |  2 --
>  2 files changed, 21 insertions(+), 18 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d18bf93e0f19..80282b2e8b7f 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2094,13 +2094,17 @@ static void drain_stock(struct memcg_stock_pcp *stock)
>  {
>         struct mem_cgroup *old = stock->cached;
>
> +       if (!old)
> +               return;
> +
>         if (stock->nr_pages) {
>                 page_counter_uncharge(&old->memory, stock->nr_pages);
>                 if (do_memsw_account())
>                         page_counter_uncharge(&old->memsw, stock->nr_pages);
> -               css_put_many(&old->css, stock->nr_pages);
>                 stock->nr_pages = 0;
>         }
> +
> +       css_put(&old->css);
>         stock->cached = NULL;
>  }
>
> @@ -2136,6 +2140,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>         stock = this_cpu_ptr(&memcg_stock);
>         if (stock->cached != memcg) { /* reset if necessary */
>                 drain_stock(stock);
> +               css_get(&memcg->css);
>                 stock->cached = memcg;
>         }
>         stock->nr_pages += nr_pages;
> @@ -2594,12 +2599,10 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>         page_counter_charge(&memcg->memory, nr_pages);
>         if (do_memsw_account())
>                 page_counter_charge(&memcg->memsw, nr_pages);
> -       css_get_many(&memcg->css, nr_pages);
>
>         return 0;
>
>  done_restock:
> -       css_get_many(&memcg->css, batch);
>         if (batch > nr_pages)
>                 refill_stock(memcg, batch - nr_pages);
>
> @@ -2657,8 +2660,6 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
>         page_counter_uncharge(&memcg->memory, nr_pages);
>         if (do_memsw_account())
>                 page_counter_uncharge(&memcg->memsw, nr_pages);
> -
> -       css_put_many(&memcg->css, nr_pages);
>  }
>  #endif
>
> @@ -2964,6 +2965,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
>                 if (!ret) {
>                         page->mem_cgroup = memcg;
>                         __SetPageKmemcg(page);
> +                       return 0;
>                 }
>         }
>         css_put(&memcg->css);
> @@ -2986,12 +2988,11 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
>         VM_BUG_ON_PAGE(mem_cgroup_is_root(memcg), page);
>         __memcg_kmem_uncharge(memcg, nr_pages);
>         page->mem_cgroup = NULL;
> +       css_put(&memcg->css);
>
>         /* slab pages do not have PageKmemcg flag set */
>         if (PageKmemcg(page))
>                 __ClearPageKmemcg(page);
> -
> -       css_put_many(&memcg->css, nr_pages);
>  }
>  #endif /* CONFIG_MEMCG_KMEM */
>
> @@ -3003,13 +3004,16 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
>   */
>  void mem_cgroup_split_huge_fixup(struct page *head)
>  {
> +       struct mem_cgroup *memcg = head->mem_cgroup;
>         int i;
>
>         if (mem_cgroup_disabled())

if (mem_cgroup_disabled() || !memcg)?

>                 return;
>
> -       for (i = 1; i < HPAGE_PMD_NR; i++)
> -               head[i].mem_cgroup = head->mem_cgroup;
> +       for (i = 1; i < HPAGE_PMD_NR; i++) {
> +               css_get(&memcg->css);
> +               head[i].mem_cgroup = memcg;
> +       }
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
> @@ -5454,7 +5458,10 @@ static int mem_cgroup_move_account(struct page *page,
>          */
>         smp_mb();
>
> -       page->mem_cgroup = to;  /* caller should have done css_get */
> +       css_get(&to->css);
> +       css_put(&from->css);
> +
> +       page->mem_cgroup = to;
>
>         __unlock_page_memcg(from);
>
> @@ -6540,6 +6547,7 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
>         if (ret)
>                 goto out_put;
>
> +       css_get(&memcg->css);
>         commit_charge(page, memcg);
>
>         local_irq_disable();
> @@ -6594,9 +6602,6 @@ static void uncharge_batch(const struct uncharge_gather *ug)
>         __this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_pages);
>         memcg_check_events(ug->memcg, ug->dummy_page);
>         local_irq_restore(flags);
> -
> -       if (!mem_cgroup_is_root(ug->memcg))
> -               css_put_many(&ug->memcg->css, ug->nr_pages);
>  }
>
>  static void uncharge_page(struct page *page, struct uncharge_gather *ug)
> @@ -6634,6 +6639,7 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>
>         ug->dummy_page = page;
>         page->mem_cgroup = NULL;
> +       css_put(&ug->memcg->css);
>  }
>
>  static void uncharge_list(struct list_head *page_list)
> @@ -6739,8 +6745,8 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
>         page_counter_charge(&memcg->memory, nr_pages);
>         if (do_memsw_account())
>                 page_counter_charge(&memcg->memsw, nr_pages);
> -       css_get_many(&memcg->css, nr_pages);
>
> +       css_get(&memcg->css);
>         commit_charge(newpage, memcg);
>
>         local_irq_save(flags);
> @@ -6977,8 +6983,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
>         mem_cgroup_charge_statistics(memcg, page, -nr_entries);
>         memcg_check_events(memcg, page);
>
> -       if (!mem_cgroup_is_root(memcg))
> -               css_put_many(&memcg->css, nr_entries);
> +       css_put(&memcg->css);
>  }
>
>  /**
> diff --git a/mm/slab.h b/mm/slab.h
> index 633eedb6bad1..8a574d9361c1 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -373,9 +373,7 @@ static __always_inline int memcg_charge_slab(struct page *page,
>         lruvec = mem_cgroup_lruvec(memcg, page_pgdat(page));
>         mod_lruvec_state(lruvec, cache_vmstat_idx(s), nr_pages << PAGE_SHIFT);
>
> -       /* transer try_charge() page references to kmem_cache */
>         percpu_ref_get_many(&s->memcg_params.refcnt, nr_pages);
> -       css_put_many(&memcg->css, nr_pages);
>  out:
>         css_put(&memcg->css);
>         return ret;
> --
> 2.25.4
>
