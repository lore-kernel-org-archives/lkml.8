Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA860C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5D722078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lkupn2ml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgHTV5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 17:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgHTV5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 17:57:38 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422F0C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 14:57:37 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id ba10so2858066edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 14:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5sviuv+X0eAsiZiEmZuhmbloJAvhEyc5WFuO1Rz+TUE=;
        b=Lkupn2ml+C7DdOtGP0lOruDZjCFfwnzZiuPeCknEHAgkiKMiLp80Ja6hMjPtqmGwRg
         TT8F0Wv4g0HogaPz3hrOrlrcVWXhd1IsuC5JePZNOf/kssSmniZdTvwFdRgaGt4YaZ0Q
         rFCWRB0OQPj4jKB7KQ6hJY+o7KyG/cTRE0A4+++Ykt6dzIeMPlNjBtQrsXICMScwq4PL
         j9LUtUltHPypHsbW0emiMMNTs0MTP1rQV21k+kiczIU+SB1vHp9kNDKV8/u23whPDOGK
         r4xKo/s2KKKV37pqz1MX9++vknCXJidYRfJ3BzYN2w4lmxL9z8PwNp2GBhxP3mRPmmjn
         TgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5sviuv+X0eAsiZiEmZuhmbloJAvhEyc5WFuO1Rz+TUE=;
        b=AqP3siNIWENwhuZ3CVERzs1B62Z30BsSVSeQz62zuNcI57Z81AcmxbTkB45Lq3yoBE
         okUuy8OtYz64sUA0VpN5EO3y8WyoPGP8acbT+oN/qaqaCiisEcZbqk800ABA4FYUTNi/
         ViM8xtRSzGHYdlyaIWI5YfcWqri4+On2eQ5fadWCobN2oxGmV3C2VuoXV5awCdLaB8lM
         EIl8zBZQbKxstuOnhhvJ0pHfPjyUBFNFGuO42x6964mSlqfCrkT68knisVrvPXDApYs1
         A6p81aZWgdXoD4Lzfy1nhdgeytjJqcnYqVWHqKmfDX7Wo/8L2Rudpy6Go+jNjGpVSMFF
         Uvlg==
X-Gm-Message-State: AOAM533nr6PgklqRwRUceCyDaK/a/XEkX8PkBwecvLlKaBby24/71AGZ
        GWM98xU5jss+PCcq0Gyn/TkmkmApkXXXRPY6aSA=
X-Google-Smtp-Source: ABdhPJzKrnmPWoJ3402kaH5MO+iUdtgoRHgzZkmiw5vnRW2kpH0g12SVDvfqxXIyPzkglcjdj6Pwl4UAvV9zN8cfV3E=
X-Received: by 2002:aa7:d983:: with SMTP id u3mr657139eds.366.1597960655895;
 Thu, 20 Aug 2020 14:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200818184122.29C415DF@viggo.jf.intel.com> <20200818184126.B8E91F10@viggo.jf.intel.com>
In-Reply-To: <20200818184126.B8E91F10@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 20 Aug 2020 14:57:24 -0700
Message-ID: <CAHbLzkrLwaV1mi0wSU=XQ+mqkaPuP=4tmvwOBe6kiO2qendVdQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/9] mm/numa: automatically generate node migration order
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

On Tue, Aug 18, 2020 at 11:50 AM Dave Hansen
<dave.hansen@linux.intel.com> wrote:
>
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> When memory fills up on a node, memory contents can be
> automatically migrated to another node.  The biggest problems are
> knowing when to migrate and to where the migration should be
> targeted.
>
> The most straightforward way to generate the "to where" list
> would be to follow the page allocator fallback lists.  Those
> lists already tell us if memory is full where to look next.  It
> would also be logical to move memory in that order.
>
> But, the allocator fallback lists have a fatal flaw: most nodes
> appear in all the lists.  This would potentially lead to
> migration cycles (A->B, B->A, A->B, ...).
>
> Instead of using the allocator fallback lists directly, keep a
> separate node migration ordering.  But, reuse the same data used
> to generate page allocator fallback in the first place:
> find_next_best_node().
>
> This means that the firmware data used to populate node distances
> essentially dictates the ordering for now.  It should also be
> architecture-neutral since all NUMA architectures have a working
> find_next_best_node().
>
> The protocol for node_demotion[] access and writing is not
> standard.  It has no specific locking and is intended to be read
> locklessly.  Readers must take care to avoid observing changes
> that appear incoherent.  This was done so that node_demotion[]
> locking has no chance of becoming a bottleneck on large systems
> with lots of CPUs in direct reclaim.
>
> This code is unused for now.  It will be called later in the
> series.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> ---
>
>  b/mm/internal.h   |    1
>  b/mm/migrate.c    |  137 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  b/mm/page_alloc.c |    2
>  3 files changed, 138 insertions(+), 2 deletions(-)
>
> diff -puN mm/internal.h~auto-setup-default-migration-path-from-firmware mm/internal.h
> --- a/mm/internal.h~auto-setup-default-migration-path-from-firmware     2020-08-18 11:36:48.960583188 -0700
> +++ b/mm/internal.h     2020-08-18 11:36:48.968583188 -0700
> @@ -203,6 +203,7 @@ extern int user_min_free_kbytes;
>
>  extern void zone_pcp_update(struct zone *zone);
>  extern void zone_pcp_reset(struct zone *zone);
> +extern int find_next_best_node(int node, nodemask_t *used_node_mask);
>
>  #if defined CONFIG_COMPACTION || defined CONFIG_CMA
>
> diff -puN mm/migrate.c~auto-setup-default-migration-path-from-firmware mm/migrate.c
> --- a/mm/migrate.c~auto-setup-default-migration-path-from-firmware      2020-08-18 11:36:48.962583188 -0700
> +++ b/mm/migrate.c      2020-08-18 11:36:48.970583188 -0700
> @@ -1160,6 +1160,10 @@ out:
>         return rc;
>  }
>
> +/*
> + * Writes to this array occur without locking.  READ_ONCE()
> + * is recommended for readers to ensure consistent reads.
> + */
>  static int node_demotion[MAX_NUMNODES] = {[0 ...  MAX_NUMNODES - 1] = NUMA_NO_NODE};
>
>  /**
> @@ -1173,7 +1177,13 @@ static int node_demotion[MAX_NUMNODES] =
>   */
>  int next_demotion_node(int node)
>  {
> -       return node_demotion[node];
> +       /*
> +        * node_demotion[] is updated without excluding
> +        * this function from running.  READ_ONCE() avoids
> +        * reading multiple, inconsistent 'node' values
> +        * during an update.
> +        */
> +       return READ_ONCE(node_demotion[node]);
>  }
>
>  /*
> @@ -3001,3 +3011,128 @@ void migrate_vma_finalize(struct migrate
>  }
>  EXPORT_SYMBOL(migrate_vma_finalize);
>  #endif /* CONFIG_DEVICE_PRIVATE */
> +
> +/* Disable reclaim-based migration. */
> +static void disable_all_migrate_targets(void)
> +{
> +       int node;
> +
> +       for_each_online_node(node)
> +               node_demotion[node] = NUMA_NO_NODE;
> +}
> +
> +/*
> + * Find an automatic demotion target for 'node'.
> + * Failing here is OK.  It might just indicate
> + * being at the end of a chain.
> + */
> +static int establish_migrate_target(int node, nodemask_t *used)
> +{
> +       int migration_target;
> +
> +       /*
> +        * Can not set a migration target on a
> +        * node with it already set.
> +        *
> +        * No need for READ_ONCE() here since this
> +        * in the write path for node_demotion[].
> +        * This should be the only thread writing.
> +        */
> +       if (node_demotion[node] != NUMA_NO_NODE)
> +               return NUMA_NO_NODE;
> +
> +       migration_target = find_next_best_node(node, used);
> +       if (migration_target == NUMA_NO_NODE)
> +               return NUMA_NO_NODE;
> +
> +       node_demotion[node] = migration_target;
> +
> +       return migration_target;
> +}
> +
> +/*
> + * When memory fills up on a node, memory contents can be
> + * automatically migrated to another node instead of
> + * discarded at reclaim.
> + *
> + * Establish a "migration path" which will start at nodes
> + * with CPUs and will follow the priorities used to build the
> + * page allocator zonelists.
> + *
> + * The difference here is that cycles must be avoided.  If
> + * node0 migrates to node1, then neither node1, nor anything
> + * node1 migrates to can migrate to node0.
> + *
> + * This function can run simultaneously with readers of
> + * node_demotion[].  However, it can not run simultaneously
> + * with itself.  Exclusion is provided by memory hotplug events
> + * being single-threaded.
> + */
> +void __set_migration_target_nodes(void)
> +{
> +       nodemask_t next_pass    = NODE_MASK_NONE;
> +       nodemask_t this_pass    = NODE_MASK_NONE;
> +       nodemask_t used_targets = NODE_MASK_NONE;
> +       int node;
> +
> +       /*
> +        * Avoid any oddities like cycles that could occur
> +        * from changes in the topology.  This will leave
> +        * a momentary gap when migration is disabled.
> +        */
> +       disable_all_migrate_targets();
> +
> +       /*
> +        * Ensure that the "disable" is visible across the system.
> +        * Readers will see either a combination of before+disable
> +        * state or disable+after.  They will never see before and
> +        * after state together.
> +        *
> +        * The before+after state together might have cycles and
> +        * could cause readers to do things like loop until this
> +        * function finishes.  This ensures they can only see a
> +        * single "bad" read and would, for instance, only loop
> +        * once.
> +        */
> +       smp_wmb();

Sounds better to move sp_wmb() into disable_all_migrate_targets()? I
thought we need the barrier everytime disable_all_migrate_targets() is
called, if so why not put them together to avoid overlooking?

> +
> +       /*
> +        * Allocations go close to CPUs, first.  Assume that
> +        * the migration path starts at the nodes with CPUs.
> +        */
> +       next_pass = node_states[N_CPU];
> +again:
> +       this_pass = next_pass;
> +       next_pass = NODE_MASK_NONE;
> +       /*
> +        * To avoid cycles in the migration "graph", ensure
> +        * that migration sources are not future targets by
> +        * setting them in 'used_targets'.  Do this only
> +        * once per pass so that multiple source nodes can
> +        * share a target node.
> +        *
> +        * 'used_targets' will become unavailable in future
> +        * passes.  This limits some opportunities for
> +        * multiple source nodes to share a desintation.
> +        */
> +       nodes_or(used_targets, used_targets, this_pass);
> +       for_each_node_mask(node, this_pass) {
> +               int target_node = establish_migrate_target(node, &used_targets);
> +
> +               if (target_node == NUMA_NO_NODE)
> +                       continue;
> +
> +               /* Visit targets from this pass in the next pass: */
> +               node_set(target_node, next_pass);
> +       }
> +       /* Is another pass necessary? */
> +       if (!nodes_empty(next_pass))
> +               goto again;
> +}
> +
> +void set_migration_target_nodes(void)
> +{
> +       get_online_mems();
> +       __set_migration_target_nodes();
> +       put_online_mems();
> +}
> diff -puN mm/page_alloc.c~auto-setup-default-migration-path-from-firmware mm/page_alloc.c
> --- a/mm/page_alloc.c~auto-setup-default-migration-path-from-firmware   2020-08-18 11:36:48.964583188 -0700
> +++ b/mm/page_alloc.c   2020-08-18 11:36:48.972583188 -0700
> @@ -5607,7 +5607,7 @@ static int node_load[MAX_NUMNODES];
>   *
>   * Return: node id of the found node or %NUMA_NO_NODE if no node is found.
>   */
> -static int find_next_best_node(int node, nodemask_t *used_node_mask)
> +int find_next_best_node(int node, nodemask_t *used_node_mask)
>  {
>         int n, val;
>         int min_val = INT_MAX;
> _
