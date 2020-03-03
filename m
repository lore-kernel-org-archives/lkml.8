Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B9BC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8862D2083E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbgCCQxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:53:01 -0500
Received: from relay.sw.ru ([185.231.240.75]:46376 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729755AbgCCQxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:53:01 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j9Amn-0006yJ-94; Tue, 03 Mar 2020 19:52:49 +0300
Subject: Re: [PATCH v2 1/1] mm: fix interrupt disabled long time inside
 deferred_init_memmap()
To:     Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
References: <20200303161551.132263-1-shile.zhang@linux.alibaba.com>
 <20200303161551.132263-2-shile.zhang@linux.alibaba.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <fc22967d-0803-2e6f-26af-148a24f8f958@virtuozzo.com>
Date:   Tue, 3 Mar 2020 19:52:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303161551.132263-2-shile.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.03.2020 19:15, Shile Zhang wrote:
> When 'CONFIG_DEFERRED_STRUCT_PAGE_INIT' is set, 'pgdatinit' kthread will
> initialise the deferred pages with local interrupts disabled. It is
> introduced by commit 3a2d7fa8a3d5 ("mm: disable interrupts while
> initializing deferred pages").
> 
> The local interrupt will be disabled long time inside
> deferred_init_memmap(), depends on memory size.
> On machine with NCPUS <= 2, the 'pgdatinit' kthread could be pined on
> boot CPU, then the tick timer will stuck long time, which caused the
> system wall time inaccuracy.
> 
> For example, the dmesg shown that:
> 
>   [    0.197975] node 0 initialised, 32170688 pages in 1ms
> 
> Obviously, 1ms is unreasonable.
> Now, fix it by restore in the pending interrupts inside the while loop.
> The reasonable demsg shown likes:
> 
> [    1.069306] node 0 initialised, 32203456 pages in 894ms

The way I understand the original problem, that Pavel fixed:

we need disable irqs in deferred_init_memmap() since this function may be called
in parallel with deferred_grow_zone() called from interrupt handler. So, Pavel
added lock to fix the race.

In case of we temporary unlock the lock, interrupt still be possible,
so my previous proposition returns the problem back.

Now thought again, I think we have to just add:

	pgdat_resize_unlock();
	pgdat_resize_lock();

instead of releasing interrupts, since in case of we just release them with lock held,
a call of interrupt->deferred_grow_zone() bring us to a deadlock.

So, unlock the lock is must.

> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
> ---
>  mm/page_alloc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3c4eb750a199..d3f337f2e089 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1809,8 +1809,12 @@ static int __init deferred_init_memmap(void *data)
>  	 * that we can avoid introducing any issues with the buddy
>  	 * allocator.
>  	 */
> -	while (spfn < epfn)
> +	while (spfn < epfn) {
>  		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
> +		/* let in any pending interrupts */
> +		local_irq_restore(flags);
> +		local_irq_save(flags);
> +	}
>  zone_empty:
>  	pgdat_resize_unlock(pgdat, &flags);

I think we need here something like below (untested):

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 79e950d76ffc..323afa9a4db5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1828,7 +1828,7 @@ static int __init deferred_init_memmap(void *data)
 {
 	pg_data_t *pgdat = data;
 	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
-	unsigned long spfn = 0, epfn = 0, nr_pages = 0;
+	unsigned long spfn = 0, epfn = 0, nr_pages = 0, prev_nr_pages = 0;
 	unsigned long first_init_pfn, flags;
 	unsigned long start = jiffies;
 	struct zone *zone;
@@ -1869,8 +1869,18 @@ static int __init deferred_init_memmap(void *data)
 	 * that we can avoid introducing any issues with the buddy
 	 * allocator.
 	 */
-	while (spfn < epfn)
+	while (spfn < epfn) {
 		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
+		/*
+		 * Release interrupts every 1Gb to give a possibility
+		 * a timer to advance jiffies.
+		 */
+		if (nr_pages - prev_nr_pages > (1UL << (30 - PAGE_SHIFT))) {
+			prev_nr_pages = nr_pages;
+			pgdat_resize_unlock(pgdat, &flags);
+			pgdat_resize_lock(pgdat, &flags);
+		}
+	}
 zone_empty:
 	pgdat_resize_unlock(pgdat, &flags);
 

(I believe the comment may be improved more).
