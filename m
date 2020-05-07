Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEFFC4724C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13BDB208DB
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="UVP//zg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgEGDB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 23:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727095AbgEGDB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 23:01:57 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196E6C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 20:01:57 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s9so4565869qkm.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 20:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mvG2/ro0fLAecrusqs/x41lerTr3Wg9O5pbf09qQPz0=;
        b=UVP//zg9hei0L/x7oxhqP5j1Ggyf9dMV0VKIOd5kBE52u+O5vdOaS9gKL558fqgsr4
         FL+Ki/lmJbKcRVnDoeoQc7MrGEuGY4xADcftp25xoVHvRRtNSg8u9Ggar+fL4EEB/NBc
         UeJa0/dAf8YkZOLreR21vFVyNIgqg6/pArzRBXZjaKBxGk8Bwo7Y8vkdK7go0xL/znjD
         CBdpSUOy2jW27QlBLMmkmJl7B4Kq1yawmSAgUyUS9iPHokT5u7pSgUsUdvPtEAirJ4RP
         xx2VxsZYmPCyUP5pT8eygVDKp6FvYG7N7aHrMB0gLcGKvEBy+Jh+7OUrYmYMe8+WnHTk
         Z+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mvG2/ro0fLAecrusqs/x41lerTr3Wg9O5pbf09qQPz0=;
        b=VRAPyn/1FEjZisObY9JTwdX8+IGWNfFI+Z5/igbfwDlcTk64vew2MAtSMs1DUST+yB
         PE6qzJ1Fiwa2kSx6INRfSq9cQrZtSJG7xSzdiuFuZsQSU/Kpm3XqUSpf9X5pwzKuBQhl
         yBJRdBM/u1hrJQZVEL58pSdJSaz3s4XKFCV4niZvFqbfnIxjXCvl7t5WYuOQVdJYzirB
         xVuJnQtL5U4QKFTQx9HfnnhD03cVVyietsksC9IqXNIDP4etk5PUoegyX1m1at6xobc/
         RVY+ECe4/9RM+pRoyi+uSIjp9YhGvEKDRNceLy+mAz34Mi95kfDnhB6rbUsmU9jBw+JD
         H0Ew==
X-Gm-Message-State: AGi0PuYwGT5jPnZL3AHThLx52UceDHgYFrQ76vyQxIa/hU+2VOJ8Ktda
        TZOWu314H4jPYwhfsB0lFKpAiQ==
X-Google-Smtp-Source: APiQypIhE9SmtdXVA3X3g1U8j3Y2Uco3FS+ksydVXdls+Yh1EA6Narfrv/wJQDa0m2qS+MQvD4t6vA==
X-Received: by 2002:a37:a7c8:: with SMTP id q191mr10803578qke.214.1588820516146;
        Wed, 06 May 2020 20:01:56 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j25sm3053315qtn.21.2020.05.06.20.01.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2020 20:01:55 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] slub: limit count of partial slabs scanned to gather
 statistics
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <5BAA0D82-555E-4E72-966A-A147472271D0@lca.pw>
Date:   Wed, 6 May 2020 23:01:54 -0400
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Content-Transfer-Encoding: quoted-printable
Message-Id: <39E953F3-BBA4-43BF-AA0D-B1BED21F9A4D@lca.pw>
References: <158860845968.33385.4165926113074799048.stgit@buzz>
 <5BAA0D82-555E-4E72-966A-A147472271D0@lca.pw>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 6, 2020, at 3:06 PM, Qian Cai <cai@lca.pw> wrote:
>=20
>=20
>=20
>> On May 4, 2020, at 12:07 PM, Konstantin Khlebnikov =
<khlebnikov@yandex-team.ru> wrote:
>>=20
>> To get exact count of free and used objects slub have to scan list of
>> partial slabs. This may take at long time. Scanning holds spinlock =
and
>> blocks allocations which move partial slabs to per-cpu lists and =
back.
>>=20
>> Example found in the wild:
>>=20
>> # cat /sys/kernel/slab/dentry/partial
>> 14478538 N0=3D7329569 N1=3D7148969
>> # time cat /sys/kernel/slab/dentry/objects
>> 286225471 N0=3D136967768 N1=3D149257703
>>=20
>> real	0m1.722s
>> user	0m0.001s
>> sys	0m1.721s
>>=20
>> The same problem in slab was addressed in commit f728b0a5d72a ("mm, =
slab:
>> faster active and free stats") by adding more kmem cache statistics.
>> For slub same approach requires atomic op on fast path when object =
frees.
>>=20
>> Let's simply limit count of scanned slabs and print warning.
>> Limit set in /sys/module/slub/parameters/max_partial_to_count.
>> Default is 10000 which should be enough for most sane cases.
>>=20
>> Return linear approximation if list of partials is longer than limit.
>> Nobody should notice difference.
>>=20
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>=20
> This patch will trigger the warning under memory pressure, and then =
makes lockdep unhappy. Also,  it is almost impossible tell how many =
max_partial_to_count is sufficient from user perspective.

Andrew, Stephen, can you remove this patch from linux-next?

Even read some procfs files would trigger the warning and lockdep on a =
debug kernel probably due to kmemleak and debugobjects that would =
require more partial slabs objects. Thus, it would be problematic to =
break testing bots on linux-next like this.

>=20
> [ 6371.600511] SLUB: too much partial slabs to count all objects, =
increase max_partial_to_count.
> [ 6371.601399] irq event stamp: 8132599
>=20
> [ 6371.611415] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ 6371.611417] WARNING: possible circular locking dependency detected
> [ 6371.611419] 5.7.0-rc4-mm1+ #1 Not tainted
> [ 6371.611421] ------------------------------------------------------
> [ 6371.611423] oom02/43515 is trying to acquire lock:
> [ 6371.611425] ffffffff893b8980 (console_owner){-.-.}-{0:0}, at: =
console_unlock+0x240/0x750
>=20
> [ 6371.611433] but task is already holding lock:
> [ 6371.611434] ffff8886456fcb98 (&n->list_lock){-.-.}-{2:2}, at: =
count_partial+0x29/0xe0
>=20
> [ 6371.611441] which lock already depends on the new lock.
>=20
>=20
> [ 6371.611445] the existing dependency chain (in reverse order) is:
>=20
> [ 6371.611446] -> #3 (&n->list_lock){-.-.}-{2:2}:
> [ 6371.611452]        _raw_spin_lock+0x2f/0x40
> [ 6371.611453]        deactivate_slab+0x37a/0x690
> [ 6371.611455]        ___slab_alloc+0x65d/0x810
> [ 6371.611456]        __slab_alloc+0x43/0x70
> [ 6371.611457]        __kmalloc+0x2b2/0x430
> [ 6371.611459]        __tty_buffer_request_room+0x100/0x250
> [ 6371.611460]        tty_insert_flip_string_fixed_flag+0x67/0x130
> [ 6371.611462]        pty_write+0xa2/0xf0
> [ 6371.611463]        n_tty_write+0x36b/0x7c0
> [ 6371.611464]        tty_write+0x275/0x500
> [ 6371.611466]        __vfs_write+0x50/0xa0
> [ 6371.611467]        vfs_write+0x10b/0x290
> [ 6371.611468]        redirected_tty_write+0x6a/0xc0
> [ 6371.611470]        do_iter_write+0x253/0x2b0
> [ 6371.611471]        vfs_writev+0x152/0x1f0
> [ 6371.611472]        do_writev+0xda/0x180
> [ 6371.611474]        __x64_sys_writev+0x45/0x50
> [ 6371.611475]        do_syscall_64+0xcc/0xaf0
> [ 6371.611477]        entry_SYSCALL_64_after_hwframe+0x49/0xb3
>=20
> [ 6371.611478] -> #2 (&port->lock#2){-.-.}-{2:2}:
> [ 6371.611484]        _raw_spin_lock_irqsave+0x3a/0x50
> [ 6371.611486]        tty_port_tty_get+0x22/0xa0
> [ 6371.611487]        tty_port_default_wakeup+0xf/0x30
> [ 6371.611489]        tty_port_tty_wakeup+0x39/0x40
> [ 6371.611490]        uart_write_wakeup+0x2a/0x40
> [ 6371.611492]        serial8250_tx_chars+0x22e/0x410
> [ 6371.611493]        serial8250_handle_irq.part.21+0x17c/0x180
> [ 6371.611495]        serial8250_default_handle_irq+0x5c/0x90
> [ 6371.611496]        serial8250_interrupt+0xa6/0x130
> [ 6371.611498]        __handle_irq_event_percpu+0x81/0x550
> [ 6371.611499]        handle_irq_event_percpu+0x70/0x100
> [ 6371.611501]        handle_irq_event+0x5a/0x8b
> [ 6371.611502]        handle_edge_irq+0x10c/0x370
> [ 6371.611503]        do_IRQ+0x9e/0x1d0
> [ 6371.611505]        ret_from_intr+0x0/0x37
> [ 6371.611506]        cpuidle_enter_state+0x148/0x910
> [ 6371.611507]        cpuidle_enter+0x41/0x70
> [ 6371.611509]        do_idle+0x3cf/0x440
> [ 6371.611510]        cpu_startup_entry+0x1d/0x1f
> [ 6371.611511]        start_secondary+0x29a/0x340
> [ 6371.611513]        secondary_startup_64+0xb6/0xc0
>=20
> [ 6371.611516] -> #1 (&port->lock){-.-.}-{2:2}:
> [ 6371.611522]        _raw_spin_lock_irqsave+0x3a/0x50
> [ 6371.611525]        serial8250_console_write+0x113/0x560
> [ 6371.611527]        univ8250_console_write+0x4b/0x60
> [ 6371.611529]        console_unlock+0x4e3/0x750
> [ 6371.611530]        vprintk_emit+0x10d/0x340
> [ 6371.611532]        vprintk_default+0x1f/0x30
> [ 6371.611533]        vprintk_func+0x44/0xd4
> [ 6371.611535]        printk+0x9f/0xc5
> [ 6371.611537]        register_console+0x262/0x3e0
> [ 6371.611538]        univ8250_console_init+0x23/0x2d
> [ 6371.611540]        console_init+0x268/0x395
> [ 6371.611542]        start_kernel+0x6c3/0x8b9
> [ 6371.611544]        x86_64_start_reservations+0x24/0x26
> [ 6371.611546]        x86_64_start_kernel+0xf4/0xfb
> [ 6371.611548]        secondary_startup_64+0xb6/0xc0
>=20
> [ 6371.611551] -> #0 (console_owner){-.-.}-{0:0}:
> [ 6371.611558]        __lock_acquire+0x21f8/0x3260
> [ 6371.611560]        lock_acquire+0x1a2/0x680
> [ 6371.611562]        console_unlock+0x2a2/0x750
> [ 6371.611564]        vprintk_emit+0x10d/0x340
> [ 6371.611566]        vprintk_default+0x1f/0x30
> [ 6371.611568]        vprintk_func+0x44/0xd4
> [ 6371.611569]        printk+0x9f/0xc5
> [ 6371.611571]        count_partial.cold.50+0x4d/0x52
> [ 6371.611573]        get_slabinfo+0x5c/0xb0
> [ 6371.611575]        dump_unreclaimable_slab.cold.35+0x97/0xe2
> [ 6371.611577]        dump_header+0x45a/0x510
> [ 6371.611579]        oom_kill_process+0xd0/0x280
> [ 6371.611581]        out_of_memory+0x478/0xa50
> [ 6371.611583]        =
__alloc_pages_slowpath.constprop.61+0x1680/0x1850
> [ 6371.611585]        __alloc_pages_nodemask+0x57c/0x6f0
> [ 6371.611587]        alloc_pages_vma+0x81/0x310
> [ 6371.611589]        do_anonymous_page+0x1bb/0x7a0
> [ 6371.611591]        __handle_mm_fault+0xbb0/0xbe0
> [ 6371.611593]        handle_mm_fault+0xdc/0x2e0
> [ 6371.611595]        do_page_fault+0x2cb/0x9d7
> [ 6371.611597]        page_fault+0x34/0x40
>=20
> [ 6371.611600] other info that might help us debug this:
>=20
> [ 6371.611603] Chain exists of:
> [ 6371.611604]   console_owner --> &port->lock#2 --> &n->list_lock
>=20
> [ 6371.611615]  Possible unsafe locking scenario:
>=20
> [ 6371.611618]        CPU0                    CPU1
> [ 6371.611619]        ----                    ----
> [ 6371.611621]   lock(&n->list_lock);
> [ 6371.611625]                                lock(&port->lock#2);
> [ 6371.611630]                                lock(&n->list_lock);
> [ 6371.611634]   lock(console_owner);
>=20
> [ 6371.611639]  *** DEADLOCK ***
>=20
> [ 6371.611641] 5 locks held by oom02/43515:
> [ 6371.611642]  #0: ffff888ef72b4158 (&mm->mmap_sem#2){++++}-{3:3}, =
at: do_page_fault+0x1d6/0x9d7
> [ 6371.611649]  #1: ffffffff894dd268 (oom_lock){+.+.}-{3:3}, at: =
__alloc_pages_slowpath.constprop.61+0x90a/0x1850
> [ 6371.611656]  #2: ffffffff89520aa8 (slab_mutex){+.+.}-{3:3}, at: =
dump_unreclaimable_slab+0x2b/0x40
> [ 6371.611661]  #3: ffff8886456fcb98 (&n->list_lock){-.-.}-{2:2}, at: =
count_partial+0x29/0xe0
> [ 6371.611668]  #4: ffffffff893b8e60 (console_lock){+.+.}-{0:0}, at: =
vprintk_emit+0x100/0x340
>=20
> [ 6371.611675] stack backtrace:
> [ 6371.611676] CPU: 1 PID: 43515 Comm: oom02 Not tainted =
5.7.0-rc4-mm1+ #1
> [ 6371.611679] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 =
Gen10, BIOS A40 07/10/2019
> [ 6371.611680] Call Trace:
> [ 6371.611681]  dump_stack+0xa7/0xea
> [ 6371.611682]  print_circular_bug.cold.54+0x147/0x14c
> [ 6371.611684]  check_noncircular+0x295/0x2d0
> [ 6371.611685]  ? print_circular_bug+0x1d0/0x1d0
> [ 6371.611686]  ? __kasan_check_read+0x11/0x20
> [ 6371.611688]  ? mark_lock+0x160/0xfe0
> [ 6371.611689]  __lock_acquire+0x21f8/0x3260
> [ 6371.611690]  ? register_lock_class+0xb90/0xb90
> [ 6371.611691]  ? snprintf+0xc0/0xc0
> [ 6371.611693]  ? __kasan_check_read+0x11/0x20
> [ 6371.611694]  ? check_chain_key+0x1df/0x2e0
> [ 6371.611695]  lock_acquire+0x1a2/0x680
> [ 6371.611697]  ? console_unlock+0x240/0x750
> [ 6371.611698]  ? lock_downgrade+0x3e0/0x3e0
> [ 6371.611699]  ? check_flags.part.28+0x220/0x220
> [ 6371.611701]  ? rwlock_bug.part.1+0x60/0x60
> [ 6371.611702]  ? __kasan_check_read+0x11/0x20
> [ 6371.611703]  console_unlock+0x2a2/0x750
> [ 6371.611705]  ? console_unlock+0x240/0x750
> [ 6371.611706]  vprintk_emit+0x10d/0x340
> [ 6371.611707]  ? kernel_poison_pages.cold.3+0x86/0x86
> [ 6371.611709]  vprintk_default+0x1f/0x30
> [ 6371.611710]  vprintk_func+0x44/0xd4
> [ 6371.611711]  ? do_raw_spin_lock+0x11e/0x1e0
> [ 6371.611712]  printk+0x9f/0xc5
> [ 6371.611714]  ? log_store.cold.31+0x11/0x11
> [ 6371.611715]  ? count_partial+0x29/0xe0
> [ 6371.611717]  ? do_raw_spin_lock+0x11e/0x1e0
> [ 6371.611718]  count_partial.cold.50+0x4d/0x52
> [ 6371.611719]  get_slabinfo+0x5c/0xb0
> [ 6371.611721]  dump_unreclaimable_slab.cold.35+0x97/0xe2
> [ 6371.611722]  ? show_mem+0x10b/0x11c
> [ 6371.611723]  dump_header+0x45a/0x510
> [ 6371.611724]  oom_kill_process+0xd0/0x280
> [ 6371.611726]  out_of_memory+0x478/0xa50
> [ 6371.611727]  ? oom_killer_disable+0x230/0x230
> [ 6371.611728]  ? mutex_trylock+0x17a/0x190
> [ 6371.611730]  __alloc_pages_slowpath.constprop.61+0x1680/0x1850
> [ 6371.611731]  ? warn_alloc+0x120/0x120
> [ 6371.611733]  ? check_flags.part.28+0x220/0x220
> [ 6371.611734]  ? ___might_sleep+0x178/0x210
> [ 6371.611735]  ? __kasan_check_read+0x11/0x20
> [ 6371.611737]  __alloc_pages_nodemask+0x57c/0x6f0
> [ 6371.611738]  ? __alloc_pages_slowpath.constprop.61+0x1850/0x1850
> [ 6371.611740]  alloc_pages_vma+0x81/0x310
> [ 6371.611741]  do_anonymous_page+0x1bb/0x7a0
> [ 6371.611742]  ? __pte_alloc+0x170/0x170
> [ 6371.611743]  ? match_held_lock+0x35/0x270
> [ 6371.611745]  __handle_mm_fault+0xbb0/0xbe0
> [ 6371.611746]  ? copy_page_range+0x420/0x420
> [ 6371.611747]  ? sync_mm_rss+0x7f/0x190
> [ 6371.611749]  handle_mm_fault+0xdc/0x2e0
> [ 6371.611750]  do_page_fault+0x2cb/0x9d7
> [ 6371.611751]  page_fault+0x34/0x40
>=20
>=20
>> ---
>> mm/slub.c |   15 ++++++++++++++-
>> 1 file changed, 14 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 9bf44955c4f1..86a366f7acb6 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2407,16 +2407,29 @@ static inline unsigned long =
node_nr_objs(struct kmem_cache_node *n)
>> #endif /* CONFIG_SLUB_DEBUG */
>>=20
>> #if defined(CONFIG_SLUB_DEBUG) || defined(CONFIG_SYSFS)
>> +
>> +static unsigned long max_partial_to_count __read_mostly =3D 10000;
>> +module_param(max_partial_to_count, ulong, 0644);
>> +
>> static unsigned long count_partial(struct kmem_cache_node *n,
>> 					int (*get_count)(struct page *))
>> {
>> +	unsigned long counted =3D 0;
>> 	unsigned long flags;
>> 	unsigned long x =3D 0;
>> 	struct page *page;
>>=20
>> 	spin_lock_irqsave(&n->list_lock, flags);
>> -	list_for_each_entry(page, &n->partial, slab_list)
>> +	list_for_each_entry(page, &n->partial, slab_list) {
>> 		x +=3D get_count(page);
>> +
>> +		if (++counted > max_partial_to_count) {
>> +			pr_warn_once("SLUB: too much partial slabs to =
count all objects, increase max_partial_to_count.\n");
>> +			/* Approximate total count of objects */
>> +			x =3D mult_frac(x, n->nr_partial, counted);
>> +			break;
>> +		}
>> +	}
>> 	spin_unlock_irqrestore(&n->list_lock, flags);
>> 	return x;
>> }

