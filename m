Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB779C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1C9920810
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e3JiYK2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgFQC6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 22:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgFQC6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 22:58:08 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FFFC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 19:58:07 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y11so976751ljm.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 19:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w0iLmDwGkwJdY6xXNUfSksH8/GBYhs2+eI9Ld/xQ1Es=;
        b=e3JiYK2+sSY2tORGWVkPE0YcQQR8gcGNAV18A10wNtrgMdf06eEc/seQggIvvg/bqV
         n3amATKjFquRwsWWXIDQRrZ0xM1neyRqlandS8iYxx+1m/h0v3oZ3W+yT8jmPPHaqjq8
         CGGc4IzevDLj0yOV8vEUuAEZmn6vEYIpJurcXbyAQsoEuUFkPtayKfzApxXhgrtUARs6
         GyVWPAj1B8x7zmgVgalRh/A8dfmFarn+ziy1slglVixNl9fNm2jtwq7YF0FrzifgvyTX
         tvHLpmzmXf5Dg6ZyKvKzNM00amfis/CEu2FB1iBh8KxEiEtmy0RBgbRNvmXjuPnaw3d4
         K/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w0iLmDwGkwJdY6xXNUfSksH8/GBYhs2+eI9Ld/xQ1Es=;
        b=OCx2sfvx0lxOIkadEJheURIBI9k0UfrND0u2g7lOdVxxBzmCDNsW3I2Cf51dYfpx1n
         /MQ3zvuRi1iKOXup7I9/hWQDgPdIYLevixXnwHS1vxO7e5ZEc2qitfpPqBFrKdQMrZJG
         HKDu0GFbJ9tGi2jnk5nGSrhHKM0x8TN8tGH1imHexq3btV3hjC1diukxLGT/3+BZvHXI
         FmqGwFqgAFYw6i0KAGLZqZHBcxtwS/Y0J84zTf1aR/syhueMFv13Gf/n8STdz+WttrmT
         aMoDr28jo5Fi+EoiKHkJu2rHKY7t0KUvXgEsabjYFGF9LkDfs5+VGgovOUJAjY7/vvb5
         c0Rw==
X-Gm-Message-State: AOAM530pEk1HWFQs/KyJbW3SduwhfuDxD5hOG9y6fsfvPsg0cJI34Dpv
        NUcMOlfFnJQFjK7et+jue/RLgw+Zu4SRgBdD6wr3ow==
X-Google-Smtp-Source: ABdhPJx9o3orf/QdjPJQGACW46Ai5aYZtCTE+RoEG0L0RrKNoRBOrmlQB+trxEMIxnkADI4icH+AqZjMahEpFJOXVo0=
X-Received: by 2002:a2e:960b:: with SMTP id v11mr2860722ljh.77.1592362685133;
 Tue, 16 Jun 2020 19:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-3-guro@fb.com>
In-Reply-To: <20200608230654.828134-3-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 16 Jun 2020 19:57:54 -0700
Message-ID: <CALvZod7B9NFtAZS_cd8pPt0=BUB0sL4WuDtbOhvfMhroGs9PMg@mail.gmail.com>
Subject: Re: [PATCH v6 02/19] mm: memcg: prepare for byte-sized vmstat items
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
> To implement per-object slab memory accounting, we need to
> convert slab vmstat counters to bytes. Actually, out of
> 4 levels of counters: global, per-node, per-memcg and per-lruvec
> only two last levels will require byte-sized counters.
> It's because global and per-node counters will be counting the
> number of slab pages, and per-memcg and per-lruvec will be
> counting the amount of memory taken by charged slab objects.
>
> Converting all vmstat counters to bytes or even all slab
> counters to bytes would introduce an additional overhead.
> So instead let's store global and per-node counters
> in pages, and memcg and lruvec counters in bytes.
>
> To make the API clean all access helpers (both on the read
> and write sides) are dealing with bytes.
>

The "dealing with bytes" is only for slab stats or all vmstat stats?

> To avoid back-and-forth conversions a new flavor of read-side
> helpers is introduced, which always returns values in pages:
> node_page_state_pages() and global_node_page_state_pages().
>
> Actually new helpers are just reading raw values. Old helpers are
> simple wrappers, which will complain on an attempt to read
> byte value, because at the moment no one actually needs bytes.
>
> Thanks to Johannes Weiner for the idea of having the byte-sized API
> on top of the page-sized internal storage.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  drivers/base/node.c    |  2 +-
>  include/linux/mmzone.h | 10 ++++++++++
>  include/linux/vmstat.h | 14 +++++++++++++-
>  mm/memcontrol.c        | 14 ++++++++++----
>  mm/vmstat.c            | 30 ++++++++++++++++++++++++++----
>  5 files changed, 60 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 5b02f69769e8..e21e31359297 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -513,7 +513,7 @@ static ssize_t node_read_vmstat(struct device *dev,
>
>         for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
>                 n += sprintf(buf+n, "%s %lu\n", node_stat_name(i),
> -                            node_page_state(pgdat, i));
> +                            node_page_state_pages(pgdat, i));
>
>         return n;
>  }
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index c4c37fd12104..fa8eb49d9898 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -206,6 +206,16 @@ enum node_stat_item {
>         NR_VM_NODE_STAT_ITEMS
>  };
>
> +/*
> + * Returns true if the value is measured in bytes (most vmstat values are
> + * measured in pages). This defines the API part, the internal representation
> + * might be different.
> + */
> +static __always_inline bool vmstat_item_in_bytes(enum node_stat_item item)
> +{
> +       return false;
> +}
> +
>  /*
>   * We do arithmetic on the LRU lists in various places in the code,
>   * so it is important to keep the active lists LRU_ACTIVE higher in
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index aa961088c551..91220ace31da 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -8,6 +8,7 @@
>  #include <linux/vm_event_item.h>
>  #include <linux/atomic.h>
>  #include <linux/static_key.h>
> +#include <linux/mmdebug.h>
>
>  extern int sysctl_stat_interval;
>
> @@ -192,7 +193,8 @@ static inline unsigned long global_zone_page_state(enum zone_stat_item item)
>         return x;
>  }
>
> -static inline unsigned long global_node_page_state(enum node_stat_item item)
> +static inline
> +unsigned long global_node_page_state_pages(enum node_stat_item item)
>  {
>         long x = atomic_long_read(&vm_node_stat[item]);
>  #ifdef CONFIG_SMP
> @@ -202,6 +204,13 @@ static inline unsigned long global_node_page_state(enum node_stat_item item)
>         return x;
>  }
>
> +static inline unsigned long global_node_page_state(enum node_stat_item item)
> +{
> +       VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
> +
> +       return global_node_page_state_pages(item);
> +}
> +
>  static inline unsigned long zone_page_state(struct zone *zone,
>                                         enum zone_stat_item item)
>  {
> @@ -242,9 +251,12 @@ extern unsigned long sum_zone_node_page_state(int node,
>  extern unsigned long sum_zone_numa_state(int node, enum numa_stat_item item);
>  extern unsigned long node_page_state(struct pglist_data *pgdat,
>                                                 enum node_stat_item item);
> +extern unsigned long node_page_state_pages(struct pglist_data *pgdat,
> +                                          enum node_stat_item item);
>  #else
>  #define sum_zone_node_page_state(node, item) global_zone_page_state(item)
>  #define node_page_state(node, item) global_node_page_state(item)
> +#define node_page_state_pages(node, item) global_node_page_state_pages(item)
>  #endif /* CONFIG_NUMA */
>
>  #ifdef CONFIG_SMP
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e8a91e98556b..07d02e61a73e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -681,13 +681,16 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
>   */
>  void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
>  {
> -       long x;
> +       long x, threshold = MEMCG_CHARGE_BATCH;
>
>         if (mem_cgroup_disabled())
>                 return;
>
> +       if (vmstat_item_in_bytes(idx))
> +               threshold <<= PAGE_SHIFT;
> +

From the above am I understanding correctly that even after moving to
byte-level accounting, we can still see stats with potential error
limited by (BATCH-1)*PAGE_SIZE*nr_cpus?

>         x = val + __this_cpu_read(memcg->vmstats_percpu->stat[idx]);
> -       if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
> +       if (unlikely(abs(x) > threshold)) {
>                 struct mem_cgroup *mi;
>
>                 /*
> @@ -718,7 +721,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  {
>         struct mem_cgroup_per_node *pn;
>         struct mem_cgroup *memcg;
> -       long x;
> +       long x, threshold = MEMCG_CHARGE_BATCH;
>
>         pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
>         memcg = pn->memcg;
> @@ -729,8 +732,11 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>         /* Update lruvec */
>         __this_cpu_add(pn->lruvec_stat_local->count[idx], val);
>
> +       if (vmstat_item_in_bytes(idx))
> +               threshold <<= PAGE_SHIFT;
> +
>         x = val + __this_cpu_read(pn->lruvec_stat_cpu->count[idx]);
> -       if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
> +       if (unlikely(abs(x) > threshold)) {
>                 pg_data_t *pgdat = lruvec_pgdat(lruvec);
>                 struct mem_cgroup_per_node *pi;
>
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 80c9b6221535..f1c321e1d6d3 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -341,6 +341,11 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
>         long x;
>         long t;
>
> +       if (vmstat_item_in_bytes(item)) {
> +               VM_WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
> +               delta >>= PAGE_SHIFT;
> +       }
> +
>         x = delta + __this_cpu_read(*p);
>
>         t = __this_cpu_read(pcp->stat_threshold);
> @@ -398,6 +403,8 @@ void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
>         s8 __percpu *p = pcp->vm_node_stat_diff + item;
>         s8 v, t;
>
> +       VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
> +
>         v = __this_cpu_inc_return(*p);
>         t = __this_cpu_read(pcp->stat_threshold);
>         if (unlikely(v > t)) {
> @@ -442,6 +449,8 @@ void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
>         s8 __percpu *p = pcp->vm_node_stat_diff + item;
>         s8 v, t;
>
> +       VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
> +
>         v = __this_cpu_dec_return(*p);
>         t = __this_cpu_read(pcp->stat_threshold);
>         if (unlikely(v < - t)) {
> @@ -541,6 +550,11 @@ static inline void mod_node_state(struct pglist_data *pgdat,
>         s8 __percpu *p = pcp->vm_node_stat_diff + item;
>         long o, n, t, z;
>
> +       if (vmstat_item_in_bytes(item)) {
> +               VM_WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
> +               delta >>= PAGE_SHIFT;
> +       }
> +
>         do {
>                 z = 0;  /* overflow to node counters */
>
> @@ -989,8 +1003,8 @@ unsigned long sum_zone_numa_state(int node,
>  /*
>   * Determine the per node value of a stat item.
>   */
> -unsigned long node_page_state(struct pglist_data *pgdat,
> -                               enum node_stat_item item)
> +unsigned long node_page_state_pages(struct pglist_data *pgdat,
> +                                   enum node_stat_item item)
>  {
>         long x = atomic_long_read(&pgdat->vm_stat[item]);
>  #ifdef CONFIG_SMP
> @@ -999,6 +1013,14 @@ unsigned long node_page_state(struct pglist_data *pgdat,
>  #endif
>         return x;
>  }
> +
> +unsigned long node_page_state(struct pglist_data *pgdat,
> +                             enum node_stat_item item)
> +{
> +       VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
> +
> +       return node_page_state_pages(pgdat, item);
> +}

So, for non-slab, node_page_state and node_page_state_pages will be
the same but different for slab vmstats. However we should not be
calling node_page_state with slab vmstats because we don't need it,
right?

>  #endif
>
>  #ifdef CONFIG_COMPACTION
> @@ -1581,7 +1603,7 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
>                 seq_printf(m, "\n  per-node stats");
>                 for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
>                         seq_printf(m, "\n      %-12s %lu", node_stat_name(i),
> -                                  node_page_state(pgdat, i));
> +                                  node_page_state_pages(pgdat, i));
>                 }
>         }
>         seq_printf(m,
> @@ -1702,7 +1724,7 @@ static void *vmstat_start(struct seq_file *m, loff_t *pos)
>  #endif
>
>         for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> -               v[i] = global_node_page_state(i);
> +               v[i] = global_node_page_state_pages(i);
>         v += NR_VM_NODE_STAT_ITEMS;
>
>         global_dirty_limits(v + NR_DIRTY_BG_THRESHOLD,
> --
> 2.25.4
>
