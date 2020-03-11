Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB593C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2BE20734
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="hP0KGGjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbgCKRpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:45:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41213 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730624AbgCKRpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:45:17 -0400
Received: by mail-ed1-f67.google.com with SMTP id m25so3900154edq.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g0bFqwsXkUukHh8ZfDKot08BOWer+gFninhmoUg4N4E=;
        b=hP0KGGjqaMgRA4J7UQgYmOlx7VkzP0/sjYdfJ/2GmHapvrqjnyoyHI8+DQQfzi6xf/
         nNCLkXm17Dfa5oVtbfCkrKT0PvAFyNKjn7Rf9P9jyrorKlGVigawlGZ93mmvCLR1tGpk
         DwwNenl0Av3HBTOa4oVJsOk9fVK1C6sFYAgA5XZR80mOTseCDx47FLomQnGOecrSvwXW
         0tSbUvndpYS30PHYZe4LenZnmzs7CYwSn1Rvw1EmgMdLWkZALLdlD3pVTOV58AEbz9K7
         15L1g4d4KWQUnINWXZ5jmf/zb0MquJw7Ab+Qn0Orfx0JZaJJsp4zOjlNngJFaLSCv+h+
         AJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g0bFqwsXkUukHh8ZfDKot08BOWer+gFninhmoUg4N4E=;
        b=FMQNYGs5Dg58i4ggC4OzRD1SDrNXTOjtIwBhao/4frWIMgpfsXf0+T/wf6nPoZe3vl
         QhgPWaWr3WGVPUGiaaXnX5UbpSa11qiG4HzSBXiySphMQwAzSy+cw948tHK6cnKcPLBp
         nR+cWqwlRZgwT1RLMW2WaniP00l5Aa8YMN3ITRiZh+VL7+3JZ2dlxe35nw+9V3pUPSlr
         yDzLNEjnuecBYY1AZtU3ljlf1MIK8CypiabZ22M1tQ9M7HB6e+mZOroMAH4cxI/vXUDa
         dEZ9B5sNDRzOMDA6l3ICol+5d15vlvNIwCxRqF4KhfGqHJ5P8pYbTWQgkgaz3u3vyj04
         nZOQ==
X-Gm-Message-State: ANhLgQ3CrTW9dcXv/xdsXZNshvnnyg9PK1d+BJ45MTDxdT03Wu/M5zKV
        ZzLR4MO1MU6pNf7r23F5sv4dhgkRXufgXdKcU1cI9A==
X-Google-Smtp-Source: ADFU+vs4v81YY4ntsRiC9uQ5T2bWwhpBnVGb0EQlXIiP8t3Yqxk6E6nEPOpjSBZQv735hW2J0pKr2DfPMLgvPQ49Gc4=
X-Received: by 2002:a05:6402:343:: with SMTP id r3mr2781292edw.85.1583948715601;
 Wed, 11 Mar 2020 10:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200311123848.118638-1-shile.zhang@linux.alibaba.com>
In-Reply-To: <20200311123848.118638-1-shile.zhang@linux.alibaba.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 11 Mar 2020 13:45:04 -0400
Message-ID: <CA+CK2bBdim9dEYsRJ+3HNg4+FsTM0185q54PU=gNKGPAWDpcNA@mail.gmail.com>
Subject: Re: [PATCH v3] mm: fix tick timer stall during deferred page init
To:     Shile Zhang <shile.zhang@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 8:39 AM Shile Zhang
<shile.zhang@linux.alibaba.com> wrote:
>
> When 'CONFIG_DEFERRED_STRUCT_PAGE_INIT' is set, 'pgdatinit' kthread will
> initialise the deferred pages with local interrupts disabled. It is
> introduced by commit 3a2d7fa8a3d5 ("mm: disable interrupts while
> initializing deferred pages").
>
> On machine with NCPUS <= 2, the 'pgdatinit' kthread could be bound to
> the boot CPU, which could caused the tick timer long time stall, system
> jiffies not be updated in time.
>
> The dmesg shown that:
>
>     [    0.197975] node 0 initialised, 32170688 pages in 1ms
>
> Obviously, 1ms is unreasonable.
>
> Now, fix it by restore in the pending interrupts for every 32*1204 pages
> (128MB) initialized, give the chance to update the systemd jiffies.
> The reasonable demsg shown likes:
>
>     [    1.069306] node 0 initialised, 32203456 pages in 894ms

Sorry for joining late to this thread. I wonder if we could use
sched_clock() to print this statistics. Or not to print statistics at
all?

==============
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3c4eb750a199..5958f599aced 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1770,7 +1770,7 @@ static int __init deferred_init_memmap(void *data)
        const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
        unsigned long spfn = 0, epfn = 0, nr_pages = 0;
        unsigned long first_init_pfn, flags;
-       unsigned long start = jiffies;
+       unsigned long start = sched_clock();
        struct zone *zone;
        int zid;
        u64 i;
@@ -1817,8 +1817,8 @@ static int __init deferred_init_memmap(void *data)
        /* Sanity check that the next zone really is unpopulated */
        WARN_ON(++zid < MAX_NR_ZONES && populated_zone(++zone));

-       pr_info("node %d initialised, %lu pages in %ums\n",
-               pgdat->node_id, nr_pages, jiffies_to_msecs(jiffies - start));
+       pr_info("node %d initialised, %lu pages in %lldns\n",
+               pgdat->node_id, nr_pages, sched_clock() - start);

        pgdat_init_report_one_done();
        return 0;
==============

[    1.245331] node 0 initialised, 10256176 pages in 373565742ns

Pasha



> Fixes: 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred pages").
>
> Co-developed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
> ---
>  mm/page_alloc.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3c4eb750a199..a3a47845e150 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1763,12 +1763,17 @@ deferred_init_maxorder(u64 *i, struct zone *zone, unsigned long *start_pfn,
>         return nr_pages;
>  }
>
> +/*
> + * Release the pending interrupts for every TICK_PAGE_COUNT pages.
> + */
> +#define TICK_PAGE_COUNT        (32 * 1024)
> +
>  /* Initialise remaining memory on a node */
>  static int __init deferred_init_memmap(void *data)
>  {
>         pg_data_t *pgdat = data;
>         const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
> -       unsigned long spfn = 0, epfn = 0, nr_pages = 0;
> +       unsigned long spfn = 0, epfn = 0, nr_pages = 0, prev_nr_pages = 0;
>         unsigned long first_init_pfn, flags;
>         unsigned long start = jiffies;
>         struct zone *zone;
> @@ -1779,6 +1784,7 @@ static int __init deferred_init_memmap(void *data)
>         if (!cpumask_empty(cpumask))
>                 set_cpus_allowed_ptr(current, cpumask);
>
> +again:
>         pgdat_resize_lock(pgdat, &flags);
>         first_init_pfn = pgdat->first_deferred_pfn;
>         if (first_init_pfn == ULONG_MAX) {
> @@ -1790,7 +1796,6 @@ static int __init deferred_init_memmap(void *data)
>         /* Sanity check boundaries */
>         BUG_ON(pgdat->first_deferred_pfn < pgdat->node_start_pfn);
>         BUG_ON(pgdat->first_deferred_pfn > pgdat_end_pfn(pgdat));
> -       pgdat->first_deferred_pfn = ULONG_MAX;
>
>         /* Only the highest zone is deferred so find it */
>         for (zid = 0; zid < MAX_NR_ZONES; zid++) {
> @@ -1809,9 +1814,23 @@ static int __init deferred_init_memmap(void *data)
>          * that we can avoid introducing any issues with the buddy
>          * allocator.
>          */
> -       while (spfn < epfn)
> +       while (spfn < epfn) {
>                 nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
> +               /*
> +                * Release the interrupts for every TICK_PAGE_COUNT pages
> +                * (128MB) to give tick timer the chance to update the
> +                * system jiffies.
> +                */
> +               if ((nr_pages - prev_nr_pages) > TICK_PAGE_COUNT) {
> +                       prev_nr_pages = nr_pages;
> +                       pgdat->first_deferred_pfn = spfn;
> +                       pgdat_resize_unlock(pgdat, &flags);
> +                       goto again;
> +               }
> +       }
> +
>  zone_empty:
> +       pgdat->first_deferred_pfn = ULONG_MAX;
>         pgdat_resize_unlock(pgdat, &flags);
>
>         /* Sanity check that the next zone really is unpopulated */
> --
> 2.24.0.rc2
>
