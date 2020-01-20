Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7335C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C7520684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579505500;
	bh=UQRWO6smKOJDtGPgt3F5lm/1dyuJ8LsYsivoJVHsjGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mqWz0zoOYfgm3IZ/OnUUZ4+MZIW/VB3X2RJDIvuQFnuZTHl9f3FDJoLUHZ63vR1Vf
	 bQBnTauPLOtZRu3yjujQR7Qr+QTWzZvtGpVohnX/MFysVduIBmrhikLP9BgaLVbSdA
	 rQ1IQPOTjrJ+6Q+WhjTMY51uUgXs7tli0VlMAVSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgATHbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 02:31:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35636 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgATHbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 02:31:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so28312560wro.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 23:31:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YWKDlfgZe84J2Up5N4P42JxgHrr1hDzMS9SVDFx5zsc=;
        b=gLxTIsAZIBUODjuOQXdBUuCmrOHHGDa6SNTFp6Da1+FfQJaxsyRdyL3fN8ZIGvpWJP
         eCqq1LxgWs4yI8L3TFYc/pOvQpxPSU/a5kp964b18zkpuxu1Wo2KTDyZ+maXLRNTL410
         2/Z3shMzjnHwS+ZIy/JeuvsYwtL51bN6dktQEYEVxiHwuET7sHNuQ6se2mTxmBOOC3XW
         BqifES77Wvw6HAiSImZx8HC6Vr5kGfISnqLqoCZ/08xQaLHPKd7kE6oLpW0eAROYMYNk
         JwUjooveOSrb1T5LGWF2CrxIxUZJhMuW65gb1VUep/cFl5joMP/E0T1mlt5WKQzPBUJq
         h01w==
X-Gm-Message-State: APjAAAXUiMMhiaPv8yQqqdaHFL2Ox6zaC1gG8ODcHIeexeMdDuPI+Mo0
        wCRdRFwaNPlyCV+D2MyUtMM=
X-Google-Smtp-Source: APXvYqzU9vMqKSCy3CTyHpe1Av+ea18iUqB7fHCuGNaxpZ2epyfU9onzW5oiiqAgMoEaIiZzOtzDCw==
X-Received: by 2002:adf:f802:: with SMTP id s2mr17469259wrp.201.1579505497173;
        Sun, 19 Jan 2020 23:31:37 -0800 (PST)
Received: from localhost (ip-37-188-138-155.eurotel.cz. [37.188.138.155])
        by smtp.gmail.com with ESMTPSA id a14sm49249799wrx.81.2020.01.19.23.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 23:31:36 -0800 (PST)
Date:   Mon, 20 Jan 2020 08:31:35 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v6] mm/hotplug: silence a lockdep splat with
 printk()
Message-ID: <20200120073135.GE18451@dhcp22.suse.cz>
References: <20200117181200.20299-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117181200.20299-1-cai@lca.pw>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-01-20 13:12:00, Qian Cai wrote:
> It is not that hard to trigger lockdep splats by calling printk from
> under zone->lock. Most of them are false positives caused by lock chains
> introduced early in the boot process and they do not cause any real
> problems (although most of the early boot lock dependencies could
> happen after boot as well). There are some console drivers which do
> allocate from the printk context as well and those should be fixed. In
> any case, false positives are not that trivial to workaround and it is
> far from optimal to lose lockdep functionality for something that is a
> non-issue.
> 
> So change has_unmovable_pages() so that it no longer calls dump_page()
> itself - instead it returns a "struct page *" of the unmovable page back
> to the caller so that in the case of a has_unmovable_pages() failure,
> the caller can call dump_page() after releasing zone->lock. Also, make
> dump_page() is able to report a CMA page as well, so the reason string
> from has_unmovable_pages() can be removed.
> 
> Even though has_unmovable_pages doesn't hold any reference to the
> returned page this should be reasonably safe for the purpose of
> reporting the page (dump_page) because it cannot be hotremoved in the
> context of memory unplug. The state of the page might change but that is
> the case even with the existing code as zone->lock only plays role for
> free pages.
> 
> While at it, remove a similar but unnecessary debug-only printk() as
> well. A sample of one of those lockdep splats is,
> 
> WARNING: possible circular locking dependency detected
> ------------------------------------------------------
> test.sh/8653 is trying to acquire lock:
> ffffffff865a4460 (console_owner){-.-.}, at:
> console_unlock+0x207/0x750
> 
> but task is already holding lock:
> ffff88883fff3c58 (&(&zone->lock)->rlock){-.-.}, at:
> __offline_isolated_pages+0x179/0x3e0
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
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
> 
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
> 
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
> 
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
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   console_owner --> &(&port->lock)->rlock --> &(&zone->lock)->rlock
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&(&zone->lock)->rlock);
>                                lock(&(&port->lock)->rlock);
>                                lock(&(&zone->lock)->rlock);
>   lock(console_owner);
> 
>  *** DEADLOCK ***
> 
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
> 
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
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
