Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952A9C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578E72083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKipUAAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgAQIvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 03:51:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38748 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728901AbgAQIvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 03:51:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579251075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=iwSeRcBCNm4koU8WBKWEfIwcsMKMC4OwVi4cqMPyeTk=;
        b=QKipUAAhwVg7AdlDSCE3MyTLppkoWGf9TQ7/PnutMO2JLuQUgXhy5Ujqzuc3ng7IBRvhuh
        FFhZ1PK03S/Dv83xVztL13QZpUNXJQjo6eIZEeZsqynSYD9sMnfTiZrRJG2FPnxs10SNc6
        Orkt87Goo9iMA1zYzwrtmc+K/4JYCWw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-FPKXb6uUMWi38TBV8uA-BQ-1; Fri, 17 Jan 2020 03:51:10 -0500
X-MC-Unique: FPKXb6uUMWi38TBV8uA-BQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAD36185433B;
        Fri, 17 Jan 2020 08:51:08 +0000 (UTC)
Received: from [10.36.116.244] (ovpn-116-244.ams2.redhat.com [10.36.116.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F40B19C5B;
        Fri, 17 Jan 2020 08:51:05 +0000 (UTC)
Subject: Re: [PATCH -next v4] mm/hotplug: silence a lockdep splat with
 printk()
To:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org
Cc:     mhocko@kernel.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
References: <20200117022111.18807-1-cai@lca.pw>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <d7068679-e28a-98a9-f5b8-49ea47f7c092@redhat.com>
Date:   Fri, 17 Jan 2020 09:51:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200117022111.18807-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.01.20 03:21, Qian Cai wrote:
> It is not that hard to trigger lockdep splats by calling printk from
> under zone->lock. Most of them are false positives caused by lock chain=
s
> introduced early in the boot process and they do not cause any real
> problems (although some of the early boot lock dependencies could
> happenn after boot as well). There are some console drivers which do

s/happenn/happen/

> allocate from the printk context as well and those should be fixed. In
> any case false positives are not that trivial to workaround and it is
> far from optimal to lose lockdep functionality for something that is a
> non-issue.
>=20
> So change has_unmovable_pages() so that it no longer calls dump_page()
> itself - instead it returns a "struct page *" of the unmovable page bac=
k
> to the caller so that in the case of a has_unmovable_pages() failure,
> the caller can call dump_page() after releasing zone->lock. Also, make
> dump_page() is able to report a CMA page as well, so the reason string
> from has_unmovable_pages() can be removed.
>=20
> Even though has_unmovable_pages doesn't hold any reference to the
> returned page this should be reasonably safe for the purpose of
> reporting the page (dump_page) because it cannot be hotremoved. The

This is only true in the context of memory unplug, but not in the
context of is_mem_section_removable()-> is_pageblock_removable_nolock().
But well, that function is already racy as hell (and I dislike it very
much) :)

> state of the page might change but that is the case even with the
> existing code as zone->lock only plays role for free pages.
>=20
> While at it, remove a similar but unnecessary debug-only printk() as
> well.
>=20
> WARNING: possible circular locking dependency detected
> ------------------------------------------------------
> test.sh/8653 is trying to acquire lock:
> ffffffff865a4460 (console_owner){-.-.}, at:
> console_unlock+0x207/0x750
>=20
> but task is already holding lock:
> ffff88883fff3c58 (&(&zone->lock)->rlock){-.-.}, at:
> __offline_isolated_pages+0x179/0x3e0
>=20
> which lock already depends on the new lock.
>=20
> the existing dependency chain (in reverse order) is:
>=20
> -> #3 (&(&zone->lock)->rlock){-.-.}:
>        __lock_acquire+0x5b3/0xb40
>        lock_acquire+0x126/0x280
>        _raw_spin_lock+0x2f/0x40
>        rmqueue_bulk.constprop.21+0xb6/0x1160
>        get_page_from_freelist+0x898/0x22c0
>        __alloc_pages_nodemask+0x2f3/0x1cd0
>        alloc_pages_current+0x9c/0x110
>        allocate_slab+0x4c6/0x19c0
>        new_slab+0x46/0x70
>        ___slab_alloc+0x58b/0x960
>        __slab_alloc+0x43/0x70
>        __kmalloc+0x3ad/0x4b0
>        __tty_buffer_request_room+0x100/0x250
>        tty_insert_flip_string_fixed_flag+0x67/0x110
>        pty_write+0xa2/0xf0
>        n_tty_write+0x36b/0x7b0
>        tty_write+0x284/0x4c0
>        __vfs_write+0x50/0xa0
>        vfs_write+0x105/0x290
>        redirected_tty_write+0x6a/0xc0
>        do_iter_write+0x248/0x2a0
>        vfs_writev+0x106/0x1e0
>        do_writev+0xd4/0x180
>        __x64_sys_writev+0x45/0x50
>        do_syscall_64+0xcc/0x76c
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
>=20
> -> #2 (&(&port->lock)->rlock){-.-.}:
>        __lock_acquire+0x5b3/0xb40
>        lock_acquire+0x126/0x280
>        _raw_spin_lock_irqsave+0x3a/0x50
>        tty_port_tty_get+0x20/0x60
>        tty_port_default_wakeup+0xf/0x30
>        tty_port_tty_wakeup+0x39/0x40
>        uart_write_wakeup+0x2a/0x40
>        serial8250_tx_chars+0x22e/0x440
>        serial8250_handle_irq.part.8+0x14a/0x170
>        serial8250_default_handle_irq+0x5c/0x90
>        serial8250_interrupt+0xa6/0x130
>        __handle_irq_event_percpu+0x78/0x4f0
>        handle_irq_event_percpu+0x70/0x100
>        handle_irq_event+0x5a/0x8b
>        handle_edge_irq+0x117/0x370
>        do_IRQ+0x9e/0x1e0
>        ret_from_intr+0x0/0x2a
>        cpuidle_enter_state+0x156/0x8e0
>        cpuidle_enter+0x41/0x70
>        call_cpuidle+0x5e/0x90
>        do_idle+0x333/0x370
>        cpu_startup_entry+0x1d/0x1f
>        start_secondary+0x290/0x330
>        secondary_startup_64+0xb6/0xc0
>=20
> -> #1 (&port_lock_key){-.-.}:
>        __lock_acquire+0x5b3/0xb40
>        lock_acquire+0x126/0x280
>        _raw_spin_lock_irqsave+0x3a/0x50
>        serial8250_console_write+0x3e4/0x450
>        univ8250_console_write+0x4b/0x60
>        console_unlock+0x501/0x750
>        vprintk_emit+0x10d/0x340
>        vprintk_default+0x1f/0x30
>        vprintk_func+0x44/0xd4
>        printk+0x9f/0xc5
>=20
> -> #0 (console_owner){-.-.}:
>        check_prev_add+0x107/0xea0
>        validate_chain+0x8fc/0x1200
>        __lock_acquire+0x5b3/0xb40
>        lock_acquire+0x126/0x280
>        console_unlock+0x269/0x750
>        vprintk_emit+0x10d/0x340
>        vprintk_default+0x1f/0x30
>        vprintk_func+0x44/0xd4
>        printk+0x9f/0xc5
>        __offline_isolated_pages.cold.52+0x2f/0x30a
>        offline_isolated_pages_cb+0x17/0x30
>        walk_system_ram_range+0xda/0x160
>        __offline_pages+0x79c/0xa10
>        offline_pages+0x11/0x20
>        memory_subsys_offline+0x7e/0xc0
>        device_offline+0xd5/0x110
>        state_store+0xc6/0xe0
>        dev_attr_store+0x3f/0x60
>        sysfs_kf_write+0x89/0xb0
>        kernfs_fop_write+0x188/0x240
>        __vfs_write+0x50/0xa0
>        vfs_write+0x105/0x290
>        ksys_write+0xc6/0x160
>        __x64_sys_write+0x43/0x50
>        do_syscall_64+0xcc/0x76c
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
>=20
> other info that might help us debug this:
>=20
> Chain exists of:
>   console_owner --> &(&port->lock)->rlock --> &(&zone->lock)-
>=20
>> rlock
>=20
>  Possible unsafe locking scenario:
>=20
>        CPU0                    CPU1
>        ----                    ----
>   lock(&(&zone->lock)->rlock);
>                                lock(&(&port->lock)->rlock);
>                                lock(&(&zone->lock)->rlock);
>   lock(console_owner);
>=20
>  *** DEADLOCK ***
>=20
> 9 locks held by test.sh/8653:
>  #0: ffff88839ba7d408 (sb_writers#4){.+.+}, at:
> vfs_write+0x25f/0x290
>  #1: ffff888277618880 (&of->mutex){+.+.}, at:
> kernfs_fop_write+0x128/0x240
>  #2: ffff8898131fc218 (kn->count#115){.+.+}, at:
> kernfs_fop_write+0x138/0x240
>  #3: ffffffff86962a80 (device_hotplug_lock){+.+.}, at:
> lock_device_hotplug_sysfs+0x16/0x50
>  #4: ffff8884374f4990 (&dev->mutex){....}, at:
> device_offline+0x70/0x110
>  #5: ffffffff86515250 (cpu_hotplug_lock.rw_sem){++++}, at:
> __offline_pages+0xbf/0xa10
>  #6: ffffffff867405f0 (mem_hotplug_lock.rw_sem){++++}, at:
> percpu_down_write+0x87/0x2f0
>  #7: ffff88883fff3c58 (&(&zone->lock)->rlock){-.-.}, at:
> __offline_isolated_pages+0x179/0x3e0
>  #8: ffffffff865a4920 (console_lock){+.+.}, at:
> vprintk_emit+0x100/0x340
>=20
> stack backtrace:
> Hardware name: HPE ProLiant DL560 Gen10/ProLiant DL560 Gen10,
> BIOS U34 05/21/2019
> Call Trace:
>  dump_stack+0x86/0xca
>  print_circular_bug.cold.31+0x243/0x26e
>  check_noncircular+0x29e/0x2e0
>  check_prev_add+0x107/0xea0
>  validate_chain+0x8fc/0x1200
>  __lock_acquire+0x5b3/0xb40
>  lock_acquire+0x126/0x280
>  console_unlock+0x269/0x750
>  vprintk_emit+0x10d/0x340
>  vprintk_default+0x1f/0x30
>  vprintk_func+0x44/0xd4
>  printk+0x9f/0xc5
>  __offline_isolated_pages.cold.52+0x2f/0x30a
>  offline_isolated_pages_cb+0x17/0x30
>  walk_system_ram_range+0xda/0x160
>  __offline_pages+0x79c/0xa10
>  offline_pages+0x11/0x20
>  memory_subsys_offline+0x7e/0xc0
>  device_offline+0xd5/0x110
>  state_store+0xc6/0xe0
>  dev_attr_store+0x3f/0x60
>  sysfs_kf_write+0x89/0xb0
>  kernfs_fop_write+0x188/0x240
>  __vfs_write+0x50/0xa0
>  vfs_write+0x105/0x290
>  ksys_write+0xc6/0x160
>  __x64_sys_write+0x43/0x50
>  do_syscall_64+0xcc/0x76c
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>=20
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>=20
> v4: Update the commit log again thanks to Michal.
> v3: Rebase to next-20200115 for the mm/debug change and update some
>     comments thanks to Michal.
> v2: Improve the commit log and report CMA in dump_page() per Andrew.
>     has_unmovable_pages() returns a "struct page *" to the caller.
>=20
>  include/linux/page-isolation.h |  4 ++--
>  mm/debug.c                     |  4 +++-
>  mm/memory_hotplug.c            |  6 ++++--
>  mm/page_alloc.c                | 22 +++++++++-------------
>  mm/page_isolation.c            | 11 ++++++++++-
>  5 files changed, 28 insertions(+), 19 deletions(-)
>=20
> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolat=
ion.h
> index 148e65a9c606..da043ae86488 100644
> --- a/include/linux/page-isolation.h
> +++ b/include/linux/page-isolation.h
> @@ -33,8 +33,8 @@ static inline bool is_migrate_isolate(int migratetype=
)
>  #define MEMORY_OFFLINE	0x1
>  #define REPORT_FAILURE	0x2
> =20
> -bool has_unmovable_pages(struct zone *zone, struct page *page, int mig=
ratetype,
> -			 int flags);
> +struct page *has_unmovable_pages(struct zone *zone, struct page *page,=
 int
> +				 migratetype, int flags);
>  void set_pageblock_migratetype(struct page *page, int migratetype);
>  int move_freepages_block(struct zone *zone, struct page *page,
>  				int migratetype, int *num_movable);
> diff --git a/mm/debug.c b/mm/debug.c
> index 6a52316af839..784f9da711b0 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -46,6 +46,7 @@ void __dump_page(struct page *page, const char *reaso=
n)
>  {
>  	struct address_space *mapping;
>  	bool page_poisoned =3D PagePoisoned(page);
> +	bool page_cma =3D is_migrate_cma_page(page);

-> you are accessing the pageblock without the zone lock. It could
change to "isolate" again in the meantime if I am not wrong!

>  	int mapcount;
>  	char *type =3D "";
> =20
> @@ -92,7 +93,8 @@ void __dump_page(struct page *page, const char *reaso=
n)
>  	}
>  	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) !=3D __NR_PAGEFLAGS + 1);
> =20
> -	pr_warn("%sflags: %#lx(%pGp)\n", type, page->flags, &page->flags);
> +	pr_warn("%sflags: %#lx(%pGp)%s", type, page->flags, &page->flags,
> +		page_cma ? " CMA\n" : "\n");

I'd do a

pr_warn("%sflags: %#lx(%pGp)%s\n", type, page->flags, &page->flags,
	page_cma ? " CMA" : "");

> =20
>  hex_only:
>  	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 7a6de9b0dcab..06e7dd3eb9a9 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1148,8 +1148,10 @@ static bool is_pageblock_removable_nolock(unsign=
ed long pfn)
>  	if (!zone_spans_pfn(zone, pfn))
>  		return false;
> =20
> -	return !has_unmovable_pages(zone, page, MIGRATE_MOVABLE,
> -				    MEMORY_OFFLINE);
> +	if (has_unmovable_pages(zone, page, MIGRATE_MOVABLE, MEMORY_OFFLINE))
> +		return false;
> +
> +	return true;

if it returns NULL, !NULL converts it to "true"
if it returns PTR, !PTR converts it to "false"

Is this change really necessary?


>  }
> =20
>  /* Checks if this range of memory is likely to be hot-removable. */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e56cd1f33242..e90140e879e6 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8202,13 +8202,16 @@ void *__init alloc_large_system_hash(const char=
 *tablename,
>   * MIGRATE_MOVABLE block might include unmovable pages. And __PageMova=
ble
>   * check without lock_page also may miss some movable non-lru pages at
>   * race condition. So you can't expect this function should be exact.
> + *
> + * It returns a page without holding a reference. It should be safe he=
re
> + * because the page cannot go away because it is unmovable, but it mus=
t not to
> + * be used for anything else rather than dumping its state.

I think something like this would be better:

"Returns a page without holding a reference. If the caller wants to
dereference that page (e.g., dumping), it has to make sure that that it
cannot get removed (e.g., via memory unplug) concurrently."


>   */
> -bool has_unmovable_pages(struct zone *zone, struct page *page, int mig=
ratetype,
> -			 int flags)
> +struct page *has_unmovable_pages(struct zone *zone, struct page *page,
> +				 int migratetype, int flags)
>  {
>  	unsigned long iter =3D 0;
>  	unsigned long pfn =3D page_to_pfn(page);
> -	const char *reason =3D "unmovable page";
> =20
>  	/*
>  	 * TODO we could make this much more efficient by not checking every
> @@ -8225,9 +8228,8 @@ bool has_unmovable_pages(struct zone *zone, struc=
t page *page, int migratetype,
>  		 * so consider them movable here.
>  		 */
>  		if (is_migrate_cma(migratetype))
> -			return false;
> +			return NULL;
> =20
> -		reason =3D "CMA page";
>  		goto unmovable;
>  	}
> =20
> @@ -8302,12 +8304,10 @@ bool has_unmovable_pages(struct zone *zone, str=
uct page *page, int migratetype,
>  		 */
>  		goto unmovable;
>  	}
> -	return false;
> +	return NULL;
>  unmovable:
>  	WARN_ON_ONCE(zone_idx(zone) =3D=3D ZONE_MOVABLE);
> -	if (flags & REPORT_FAILURE)
> -		dump_page(pfn_to_page(pfn + iter), reason);
> -	return true;
> +	return pfn_to_page(pfn + iter);
>  }
> =20
>  #ifdef CONFIG_CONTIG_ALLOC
> @@ -8711,10 +8711,6 @@ __offline_isolated_pages(unsigned long start_pfn=
, unsigned long end_pfn)
>  		BUG_ON(!PageBuddy(page));
>  		order =3D page_order(page);
>  		offlined_pages +=3D 1 << order;
> -#ifdef CONFIG_DEBUG_VM
> -		pr_info("remove from free list %lx %d %lx\n",
> -			pfn, 1 << order, end_pfn);
> -#endif
>  		del_page_from_free_area(page, &zone->free_area[order]);
>  		pfn +=3D (1 << order);
>  	}
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 1f8b9dfecbe8..f3af65bac1e0 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -20,6 +20,7 @@ static int set_migratetype_isolate(struct page *page,=
 int migratetype, int isol_
>  	struct zone *zone;
>  	unsigned long flags;
>  	int ret =3D -EBUSY;
> +	struct page *unmovable =3D NULL;

nit: reverse christmas tree please :) (move it to the top)

> =20
>  	zone =3D page_zone(page);
> =20
> @@ -37,7 +38,8 @@ static int set_migratetype_isolate(struct page *page,=
 int migratetype, int isol_
>  	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
>  	 * We just check MOVABLE pages.
>  	 */
> -	if (!has_unmovable_pages(zone, page, migratetype, isol_flags)) {
> +	unmovable =3D has_unmovable_pages(zone, page, migratetype, isol_flags=
);
> +	if (!unmovable) {
>  		unsigned long nr_pages;
>  		int mt =3D get_pageblock_migratetype(page);
> =20
> @@ -54,6 +56,13 @@ static int set_migratetype_isolate(struct page *page=
, int migratetype, int isol_
>  	spin_unlock_irqrestore(&zone->lock, flags);
>  	if (!ret)
>  		drain_all_pages(zone);
> +	else if (isol_flags & REPORT_FAILURE && unmovable)

(isol_flags & REPORT_FAILURE) please for readability

> +		/*
> +		 * printk() with zone->lock held will guarantee to trigger a
> +		 * lockdep splat, so defer it here.
> +		 */
> +		dump_page(unmovable, "unmovable page");
> +
>  	return ret;
>  }


--=20
Thanks,

David / dhildenb

