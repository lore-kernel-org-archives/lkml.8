Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49295C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DD07206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R36hCqx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394055AbgFSPm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394043AbgFSPmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:42:47 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B182C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 08:42:47 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id i27so11979336ljb.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 08:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+OxiSgK8jmZz2s1uxckf0xouDzHKyLtpuiRtqKJ7EQ8=;
        b=R36hCqx/KyfBO82y1A1d2AcuUvZIOyd/m+6nERco+yWBSlC62zyCzuC6JQCZw/lsWT
         ICYZxmrgyhLwyxRYy9VGq+VI+La7uBHspgzX70xRUzh4qenicekyX4S26bA0rjDBIrY5
         dteFrw2trQISJtXI82YXu6t/niartZ6M2ezCPUXfowEBo8RsBlcviR4bmhfGldVnLKc4
         X5ecu1DkZcPSp/6Q75TxgXm7UOLBHWh6MfKh+puHHYq1Rvehyxl5k0E8/MI/uDoIiTyq
         Tfk5VIKeZBPFd1lZ+Mb0j0fEcTZXGKygILF2V9P3Pvb3L2+IE10KqE+PATXCrs2lnRaT
         In+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+OxiSgK8jmZz2s1uxckf0xouDzHKyLtpuiRtqKJ7EQ8=;
        b=It9BvkmOr5tI00cMiJjn54OsCZnS/HkbJ3HI7cepjVuTPd37kdcDgJ5+0KPZWrWlIt
         u2a6UHGdt50Gj/OsQ+/lpjsGZNFCuzGMbEtVwAjRm8/eXYfVnsbKFY+ruK9kivR3ckvw
         8+pDyOmPQjtVNDBp1PM56T10B/jqEbf7nxt2L2XG674ew+v3b4iZKtQ1H9Ce+Qpt/PSq
         ddKP1dSNonU2bQrZFvUfK2gdkY2EEZ+hwsmxIwSV97mjJA9ASboEEE7eF0EBMuTauEhq
         QZNWX472x6CA4/xwpAoBqBu3Rg9EF0Fo1bnvCyA7DJMT1TU8Hoq8idlyKf1sy9aKP4Hx
         nWJA==
X-Gm-Message-State: AOAM530tNXou5kB+HfoKIvzt4ils2NBZ4R1Zncg2sdj/IEJ9KjXxJDWD
        nDkI/0vcYAfYQvhzmClWUeSeLV+M96TpcIZxfCZFVA==
X-Google-Smtp-Source: ABdhPJw5qlicDcl5rwZMxLXOGE9C0Ib5wKYBuaCU6Fk2hLXwzUG+sm80nZDbi9rN+qeXNKgXAtl4GlLWM9qo6FL+H+M=
X-Received: by 2002:a2e:968a:: with SMTP id q10mr2068329lji.192.1592581365152;
 Fri, 19 Jun 2020 08:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-7-guro@fb.com>
In-Reply-To: <20200608230654.828134-7-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 19 Jun 2020 08:42:34 -0700
Message-ID: <CALvZod4hq5moKcb6f5L6VAS+v5+jKf8Hyd0gLotD7bMK7FsKgg@mail.gmail.com>
Subject: Re: [PATCH v6 06/19] mm: memcg/slab: obj_cgroup API
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
> Obj_cgroup API provides an ability to account sub-page sized kernel
> objects, which potentially outlive the original memory cgroup.
>
> The top-level API consists of the following functions:
>   bool obj_cgroup_tryget(struct obj_cgroup *objcg);
>   void obj_cgroup_get(struct obj_cgroup *objcg);
>   void obj_cgroup_put(struct obj_cgroup *objcg);
>
>   int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size);
>   void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
>
>   struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg);
>   struct obj_cgroup *get_obj_cgroup_from_current(void);
>
> Object cgroup is basically a pointer to a memory cgroup with a per-cpu
> reference counter. It substitutes a memory cgroup in places where
> it's necessary to charge a custom amount of bytes instead of pages.
>
> All charged memory rounded down to pages is charged to the
> corresponding memory cgroup using __memcg_kmem_charge().
>
> It implements reparenting: on memcg offlining it's getting reattached
> to the parent memory cgroup. Each online memory cgroup has an
> associated active object cgroup to handle new allocations and the list
> of all attached object cgroups. On offlining of a cgroup this list is
> reparented and for each object cgroup in the list the memcg pointer is
> swapped to the parent memory cgroup. It prevents long-living objects
> from pinning the original memory cgroup in the memory.
>
> The implementation is based on byte-sized per-cpu stocks. A sub-page
> sized leftover is stored in an atomic field, which is a part of
> obj_cgroup object. So on cgroup offlining the leftover is automatically
> reparented.
>
> memcg->objcg is rcu protected.
> objcg->memcg is a raw pointer, which is always pointing at a memory
> cgroup, but can be atomically swapped to the parent memory cgroup. So
> the caller

What type of caller? The allocator?

> must ensure the lifetime of the cgroup, e.g. grab
> rcu_read_lock or css_set_lock.
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  include/linux/memcontrol.h |  51 +++++++
>  mm/memcontrol.c            | 288 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 338 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 93dbc7f9d8b8..c69e66fe4f12 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -23,6 +23,7 @@
>  #include <linux/page-flags.h>
>
>  struct mem_cgroup;
> +struct obj_cgroup;
>  struct page;
>  struct mm_struct;
>  struct kmem_cache;
> @@ -192,6 +193,22 @@ struct memcg_cgwb_frn {
>         struct wb_completion done;      /* tracks in-flight foreign writebacks */
>  };
>
> +/*
> + * Bucket for arbitrarily byte-sized objects charged to a memory
> + * cgroup. The bucket can be reparented in one piece when the cgroup
> + * is destroyed, without having to round up the individual references
> + * of all live memory objects in the wild.
> + */
> +struct obj_cgroup {
> +       struct percpu_ref refcnt;
> +       struct mem_cgroup *memcg;
> +       atomic_t nr_charged_bytes;

So, we still charge the mem page counter in pages but keep the
remaining sub-page slack charge in nr_charge_bytes, right?

> +       union {
> +               struct list_head list;
> +               struct rcu_head rcu;
> +       };
> +};
> +
>  /*
>   * The memory controller data structure. The memory controller controls both
>   * page cache and RSS per cgroup. We would eventually like to provide
> @@ -301,6 +318,8 @@ struct mem_cgroup {
>         int kmemcg_id;
>         enum memcg_kmem_state kmem_state;
>         struct list_head kmem_caches;
> +       struct obj_cgroup __rcu *objcg;
> +       struct list_head objcg_list;
>  #endif
>
[snip]
> +
> +static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
> +                                 struct mem_cgroup *parent)
> +{
> +       struct obj_cgroup *objcg, *iter;
> +
> +       objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
> +
> +       spin_lock_irq(&css_set_lock);
> +
> +       /* Move active objcg to the parent's list */
> +       xchg(&objcg->memcg, parent);
> +       css_get(&parent->css);
> +       list_add(&objcg->list, &parent->objcg_list);

So, memcg->objcs_list will always only contain the offlined
descendants objcgs. I would recommend to rename objcg_list to clearly
show that. Maybe offlined_objcg_list or descendants_objcg_list or
something else.

> +
> +       /* Move already reparented objcgs to the parent's list */
> +       list_for_each_entry(iter, &memcg->objcg_list, list) {
> +               css_get(&parent->css);
> +               xchg(&iter->memcg, parent);
> +               css_put(&memcg->css);
> +       }
> +       list_splice(&memcg->objcg_list, &parent->objcg_list);
> +
> +       spin_unlock_irq(&css_set_lock);
> +
> +       percpu_ref_kill(&objcg->refcnt);
> +}
> +
>  /*
[snip]
>
> +__always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
> +{
> +       struct obj_cgroup *objcg = NULL;
> +       struct mem_cgroup *memcg;
> +
> +       if (unlikely(!current->mm))
> +               return NULL;

I have not seen the users of this function yet but shouldn't the above
check be (!current->mm && !current->active_memcg)?

Do we need a mem_cgroup_disabled() check as well?

> +
> +       rcu_read_lock();
> +       if (unlikely(current->active_memcg))
> +               memcg = rcu_dereference(current->active_memcg);
> +       else
> +               memcg = mem_cgroup_from_task(current);
> +
> +       for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
> +               objcg = rcu_dereference(memcg->objcg);
> +               if (objcg && obj_cgroup_tryget(objcg))
> +                       break;
> +       }
> +       rcu_read_unlock();
> +
> +       return objcg;
> +}
> +
[...]
> +
> +static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
> +{
> +       struct memcg_stock_pcp *stock;
> +       unsigned long flags;
> +
> +       local_irq_save(flags);
> +
> +       stock = this_cpu_ptr(&memcg_stock);
> +       if (stock->cached_objcg != objcg) { /* reset if necessary */
> +               drain_obj_stock(stock);
> +               obj_cgroup_get(objcg);
> +               stock->cached_objcg = objcg;
> +               stock->nr_bytes = atomic_xchg(&objcg->nr_charged_bytes, 0);
> +       }
> +       stock->nr_bytes += nr_bytes;
> +
> +       if (stock->nr_bytes > PAGE_SIZE)
> +               drain_obj_stock(stock);

The normal stock can go to 32*nr_cpus*PAGE_SIZE. I am wondering if
just PAGE_SIZE is too less for obj stock.

> +
> +       local_irq_restore(flags);
> +}
> +
