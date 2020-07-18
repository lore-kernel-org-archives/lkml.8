Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90169C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 02:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A6442067D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 02:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rH3hYgt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgGRCsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 22:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGRCsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 22:48:04 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C37C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 19:48:04 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id j11so14818687ljo.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 19:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=69g4nPE3Otz+JRellIeC/1dI29TITxaXt/3H9s7aOow=;
        b=rH3hYgt/3s+S6O+Cz5ncgsFwRaKL8T3/G6hnzl5uosE8cuTh5fdXiU4SPhLOAbax8n
         BTj9O+h4D+MqhFuYJsf0QMecuYTiMQrkIEaVPMg9WNhEH3U/SGcDYiYdEwmupwwxtNXA
         SWhLWpu5g669ObAZexnz/ISxowqSd5559lyxsfyxBbopBa2Yj+GUErO/yvtRe7luF2Pe
         Rw9fY2Y2kDn6ntR5iiGX9vXZqNdsRr7hHJr9S20z2vRBn+KmGBBvy4kNUDfcayPn90U3
         raHk2Cfftos9SRcBWjBuyUQAWogdn3XA+a814szP46Uj4STgCJSmGd6RB8iyF56nR1Vd
         CB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=69g4nPE3Otz+JRellIeC/1dI29TITxaXt/3H9s7aOow=;
        b=E9Q3QCwIOh91HyK0PHgeYB2rT8bh9wJ6yoyX/6zprFmRwGUd/kwdvkscHfPk2YYUTI
         y4VcG0iz4LrbhClf+owJQ0ykvCwiMqnNhaA6wx+t+sMycI3giJFOAPmpCH8bzXAasbcN
         +Jn6E7zvjSs7+LWgcSE8NoOWmMrQPohz7Z6QlbnLH8liKegHJBPa51zWzJhfc5g/hcK4
         8dKgngpGMrA1azthuuHGw8gOy2vmpDL/VypaaSSK1bDYrrNUZAwOyLKKLMYuFydISiQm
         Hwnd3e/7tuc6VyexMkjkUFR2Z1JzC/XqwesudDh92VdQZowZHcOaPCFKTRPMa0ovAhjU
         Qj8A==
X-Gm-Message-State: AOAM530K9dSTN1wg0BmgRulqTQ0oJB/BnX2K8ijPOwOPUsfQSoTnG8WS
        3aEkhynxvfCdWLdzs58Vi8yEg+34asF4y2pRbEPjWQ==
X-Google-Smtp-Source: ABdhPJyKqNn+aGKj+Qro8W/TI07haCK0xc4oedQ/7jcSUcGBE6Frno7u7rNX1HFW6xgkRxbnmqju+nQL381KLetvXyk=
X-Received: by 2002:a2e:8e36:: with SMTP id r22mr5721079ljk.77.1595040482033;
 Fri, 17 Jul 2020 19:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200713084144.4430-1-sjpark@amazon.com> <20200713084144.4430-3-sjpark@amazon.com>
In-Reply-To: <20200713084144.4430-3-sjpark@amazon.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 17 Jul 2020 19:47:50 -0700
Message-ID: <CALvZod7MZaE52408O6eGNpGGW77xFTyr56YK0F7qjNH1HX98MQ@mail.gmail.com>
Subject: Re: [PATCH v18 02/14] mm: Introduce Data Access MONitor (DAMON)
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        Andrea Arcangeli <aarcange@redhat.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        foersleo@amazon.de, Ian Rogers <irogers@google.com>,
        jolsa@redhat.com, "Kirill A. Shutemov" <kirill@shutemov.name>,
        mark.rutland@arm.com, Mel Gorman <mgorman@suse.de>,
        Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, rppt@kernel.org,
        sblbir@amazon.com, shuah@kernel.org, sj38.park@gmail.com,
        snu@amazon.de, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>, linux-damon@amazon.com,
        Linux MM <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 1:43 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> DAMON is a data access monitoring framework subsystem for the Linux
> kernel.  The core mechanisms of DAMON make it
>
>  - accurate (the monitoring output is useful enough for DRAM level
>    memory management; It might not appropriate for CPU Cache levels,
>    though),
>  - light-weight (the monitoring overhead is low enough to be applied
>    online), and
>  - scalable (the upper-bound of the overhead is in constant range
>    regardless of the size of target workloads).
>
> Using this framework, therefore, the kernel's memory management
> mechanisms can make advanced decisions.  Experimental memory management
> optimization works that incurring high data accesses monitoring overhead
> could implemented again.  In user space, meanwhile, users who have some
> special workloads can write personalized applications for better
> understanding and optimizations of their workloads and systems.
>
> This commit is implementing only the stub for the module load/unload,
> basic data structures, and simple manipulation functions of the
> structures to keep the size of commit small.  The core mechanisms of
> DAMON will be implemented one by one by following commits.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> Reviewed-by: Varad Gautam <vrd@amazon.de>
> ---
>  include/linux/damon.h |  63 ++++++++++++++
>  mm/Kconfig            |  12 +++
>  mm/Makefile           |   1 +
>  mm/damon.c            | 188 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 264 insertions(+)
>  create mode 100644 include/linux/damon.h
>  create mode 100644 mm/damon.c
>
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> new file mode 100644
> index 000000000000..c8f8c1c41a45
> --- /dev/null
> +++ b/include/linux/damon.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * DAMON api
> + *
> + * Copyright 2019-2020 Amazon.com, Inc. or its affiliates.
> + *
> + * Author: SeongJae Park <sjpark@amazon.de>
> + */
> +
> +#ifndef _DAMON_H_
> +#define _DAMON_H_
> +
> +#include <linux/random.h>
> +#include <linux/types.h>
> +
> +/**
> + * struct damon_addr_range - Represents an address region of [@start, @end).
> + * @start:     Start address of the region (inclusive).
> + * @end:       End address of the region (exclusive).
> + */
> +struct damon_addr_range {
> +       unsigned long start;
> +       unsigned long end;
> +};
> +
> +/**
> + * struct damon_region - Represents a monitoring target region.
> + * @ar:                        The address range of the region.
> + * @sampling_addr:     Address of the sample for the next access check.
> + * @nr_accesses:       Access frequency of this region.
> + * @list:              List head for siblings.
> + */
> +struct damon_region {
> +       struct damon_addr_range ar;
> +       unsigned long sampling_addr;
> +       unsigned int nr_accesses;
> +       struct list_head list;
> +};
> +
> +/**
> + * struct damon_task - Represents a monitoring target task.
> + * @pid:               Process id of the task.
> + * @regions_list:      Head of the monitoring target regions of this task.
> + * @list:              List head for siblings.
> + *
> + * If the monitoring target address space is task independent (e.g., physical
> + * memory address space monitoring), @pid should be '-1'.
> + */
> +struct damon_task {
> +       int pid;

Storing and accessing pid like this is racy. Why not save the "struct
pid" after getting the reference? I am still going over the usage,
maybe storing mm_struct would be an even better choice.

> +       struct list_head regions_list;
> +       struct list_head list;
> +};
> +
> +/**
> + * struct damon_ctx - Represents a context for each monitoring.
> + * @tasks_list:                Head of monitoring target tasks (&damon_task) list.
> + */
> +struct damon_ctx {
> +       struct list_head tasks_list;    /* 'damon_task' objects */
> +};
> +
> +#endif
> diff --git a/mm/Kconfig b/mm/Kconfig
> index c1acc34c1c35..464e9594dcec 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -867,4 +867,16 @@ config ARCH_HAS_HUGEPD
>  config MAPPING_DIRTY_HELPERS
>          bool
>
> +config DAMON
> +       tristate "Data Access Monitor"
> +       depends on MMU
> +       help
> +         This feature allows to monitor access frequency of each memory
> +         region. The information can be useful for performance-centric DRAM
> +         level memory management.
> +
> +         See https://damonitor.github.io/doc/html/latest-damon/index.html for
> +         more information.
> +         If unsure, say N.
> +
>  endmenu
> diff --git a/mm/Makefile b/mm/Makefile
> index fccd3756b25f..230e545b6e07 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -112,3 +112,4 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
>  obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
>  obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
>  obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
> +obj-$(CONFIG_DAMON) += damon.o
> diff --git a/mm/damon.c b/mm/damon.c
> new file mode 100644
> index 000000000000..5ab13b1c15cf
> --- /dev/null
> +++ b/mm/damon.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Data Access Monitor
> + *
> + * Copyright 2019-2020 Amazon.com, Inc. or its affiliates.
> + *
> + * Author: SeongJae Park <sjpark@amazon.de>
> + *
> + * This file is constructed in below parts.
> + *
> + * - Functions and macros for DAMON data structures
> + * - Functions for the module loading/unloading
> + *
> + * The core parts are not implemented yet.
> + */
> +
> +#define pr_fmt(fmt) "damon: " fmt
> +
> +#include <linux/damon.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +
> +/*
> + * Functions and macros for DAMON data structures
> + */
> +
> +#define damon_get_task_struct(t) \
> +       (get_pid_task(find_vpid(t->pid), PIDTYPE_PID))

You need at least rcu lock around find_vpid(). Also you need to be
careful about the context. If you accept my previous suggestion then
you just need to do this in the process context which is registering
the pid (no need to worry about the pid namespace).

I am wondering if there should be an interface to register processes
with DAMON using pidfd instead of integer pid.

> +
> +#define damon_next_region(r) \
> +       (container_of(r->list.next, struct damon_region, list))
> +
> +#define damon_prev_region(r) \
> +       (container_of(r->list.prev, struct damon_region, list))
> +
> +#define damon_for_each_region(r, t) \
> +       list_for_each_entry(r, &t->regions_list, list)
> +
> +#define damon_for_each_region_safe(r, next, t) \
> +       list_for_each_entry_safe(r, next, &t->regions_list, list)
> +
> +#define damon_for_each_task(t, ctx) \
> +       list_for_each_entry(t, &(ctx)->tasks_list, list)
> +
> +#define damon_for_each_task_safe(t, next, ctx) \
> +       list_for_each_entry_safe(t, next, &(ctx)->tasks_list, list)
> +
> +/* Get a random number in [l, r) */
> +#define damon_rand(l, r) (l + prandom_u32() % (r - l))
> +
> +/*
> + * Construct a damon_region struct
> + *
> + * Returns the pointer to the new struct if success, or NULL otherwise
> + */
> +static struct damon_region *damon_new_region(unsigned long start,
> +                                            unsigned long end)
> +{
> +       struct damon_region *region;
> +
> +       region = kmalloc(sizeof(*region), GFP_KERNEL);
> +       if (!region)
> +               return NULL;
> +
> +       region->ar.start = start;
> +       region->ar.end = end;
> +       region->nr_accesses = 0;
> +       INIT_LIST_HEAD(&region->list);
> +
> +       return region;
> +}
> +
> +/*
> + * Add a region between two other regions
> + */
> +static inline void damon_insert_region(struct damon_region *r,
> +               struct damon_region *prev, struct damon_region *next)
> +{
> +       __list_add(&r->list, &prev->list, &next->list);
> +}
> +
> +static void damon_add_region(struct damon_region *r, struct damon_task *t)
> +{
> +       list_add_tail(&r->list, &t->regions_list);
> +}
> +
> +static void damon_del_region(struct damon_region *r)
> +{
> +       list_del(&r->list);
> +}
> +
> +static void damon_free_region(struct damon_region *r)
> +{
> +       kfree(r);
> +}
> +
> +static void damon_destroy_region(struct damon_region *r)
> +{
> +       damon_del_region(r);
> +       damon_free_region(r);
> +}
> +
> +/*
> + * Construct a damon_task struct
> + *
> + * Returns the pointer to the new struct if success, or NULL otherwise
> + */
> +static struct damon_task *damon_new_task(int pid)
> +{
> +       struct damon_task *t;
> +
> +       t = kmalloc(sizeof(*t), GFP_KERNEL);
> +       if (!t)
> +               return NULL;
> +
> +       t->pid = pid;
> +       INIT_LIST_HEAD(&t->regions_list);
> +
> +       return t;
> +}
> +
> +static void damon_add_task(struct damon_ctx *ctx, struct damon_task *t)
> +{
> +       list_add_tail(&t->list, &ctx->tasks_list);
> +}
> +
> +static void damon_del_task(struct damon_task *t)
> +{
> +       list_del(&t->list);
> +}
> +
> +static void damon_free_task(struct damon_task *t)
> +{
> +       struct damon_region *r, *next;
> +
> +       damon_for_each_region_safe(r, next, t)
> +               damon_free_region(r);
> +       kfree(t);
> +}
> +
> +static void damon_destroy_task(struct damon_task *t)
> +{
> +       damon_del_task(t);
> +       damon_free_task(t);
> +}
> +
> +static unsigned int nr_damon_tasks(struct damon_ctx *ctx)
> +{
> +       struct damon_task *t;
> +       unsigned int nr_tasks = 0;
> +
> +       damon_for_each_task(t, ctx)
> +               nr_tasks++;
> +
> +       return nr_tasks;
> +}
> +
> +static unsigned int nr_damon_regions(struct damon_task *t)
> +{
> +       struct damon_region *r;
> +       unsigned int nr_regions = 0;
> +
> +       damon_for_each_region(r, t)
> +               nr_regions++;
> +
> +       return nr_regions;
> +}
> +
> +/*
> + * Functions for the module loading/unloading
> + */
> +
> +static int __init damon_init(void)
> +{
> +       return 0;
> +}
> +
> +static void __exit damon_exit(void)
> +{
> +}
> +
> +module_init(damon_init);
> +module_exit(damon_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("SeongJae Park <sjpark@amazon.de>");
> +MODULE_DESCRIPTION("DAMON: Data Access MONitor");
> --
> 2.17.1
>
