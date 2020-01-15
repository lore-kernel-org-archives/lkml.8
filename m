Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D3AC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F87224656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="q7UOGtNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgAORQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:16:24 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39230 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbgAORQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 12:16:23 -0500
Received: by mail-qk1-f196.google.com with SMTP id c16so16351742qko.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 09:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9ykQjr4H0gywq/0E0It7rn6yVNHPcNvVdM9w7udwaMk=;
        b=q7UOGtNBZuPHONhq73klWP2/E9DTbEtE8jIU7rfDvv6w6N3ZpGCGEqVXVItKnSE6Lq
         yrjQPmxU3DiWI+V7ssaLK1x4dlQKHoEn3Wi4pxcDHKSzhNcYweQkkFYceZ1fGzTFhfVQ
         efldBAdi7MjWfqm8S/2ogAJu39WqyNOKZm0XG41SNnjv6rGQdwPASjywupA28lHmNHKG
         Z4TiK5x51X+jCdsnTBNSxWFxMItVVhsbizd9QU1lPUCtFdBxOFkLXOwvHw0q/v/+lmEP
         dUV9ufUq7mKdBxHEjDgjNWaNDMWdVIpIok4bQTcdbfT19/LubfwhpBy9FsCKtAFkW3s9
         A5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9ykQjr4H0gywq/0E0It7rn6yVNHPcNvVdM9w7udwaMk=;
        b=bYDxCvMWfeGWCHzMKI1G68/KnDyHAc0MDL1Mv4QRMTIABPQOKxWz33f+bVbqx2Z5i6
         N+da0kVCu4GicTS0iFCbtuOF9t4sfto7+umnYlfAH7TxwJjO9im2eq8/PExZyQHYf2zR
         wIMv9MKO9Rzl1eHd4Bm27EzGYCerHQgX/1NFCijZdhzjk0Nnl+CpTlnEVi+eB7KKAr9i
         p3YxQI7Ebd5mJuQY57RXnToSDljIbDVabyeM21aN8+vqhX5bGwOYRUUEuc94uJxtNRVc
         YyUfwZaXMK4IrxPseYjqD6bGzFZ+6lYU/5DOwK/cHKDBtquOUnFa3vwpHf9mwR8CGIfA
         Qlpw==
X-Gm-Message-State: APjAAAVHmoytBp2zVdYsbGFsoC19/fEHi9GdTLMbbM0aN6b7MK6gCrNY
        IfNyWvwXGM4irQ++2oHXy5AvgQ==
X-Google-Smtp-Source: APXvYqxmqBnqC5GnRN1dKMHZYx1QACFOF6a+ScwEiDu0v2QWVxitp00kvsrOisPz0e9JYpFBuSxp/Q==
X-Received: by 2002:a37:5f43:: with SMTP id t64mr27858809qkb.68.1579108580147;
        Wed, 15 Jan 2020 09:16:20 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k9sm9673439qtq.75.2020.01.15.09.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jan 2020 09:16:19 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH -next] mm/hotplug: silence a lockdep splat with printk()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200115170235.ph7lrojaktmfikm2@pathway.suse.cz>
Date:   Wed, 15 Jan 2020 12:16:17 -0500
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7CD27FC6-CFFF-4519-A57D-85179E9815FE@lca.pw>
References: <20200115095253.36e5iqn77n4exj3s@pathway.suse.cz>
 <D6F57A74-7608-43BE-B909-4350DE95B68C@lca.pw>
 <20200115170235.ph7lrojaktmfikm2@pathway.suse.cz>
To:     Petr Mladek <pmladek@suse.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 15, 2020, at 12:02 PM, Petr Mladek <pmladek@suse.com> wrote:
>=20
> On Wed 2020-01-15 06:49:03, Qian Cai wrote:
>>=20
>>=20
>>> On Jan 15, 2020, at 4:52 AM, Petr Mladek <pmladek@suse.com> wrote:
>>>=20
>>> I could understand that Michal is against hack in -mm code that
>>> would just hide a false positive warning.
>>=20
>> Well, I don=E2=80=99t have any confidence to say everything this =
patch is
>> trying to fix is false positives.
>=20
> You look at this from a wrong angle. AFAIK, all lockdep reports pasted
> in the below mentioned thread were false positives. Now, this patch
> complicates an already complicated -mm code to hide the warning
> and fix theoretical problems.

What makes you say all of those are false positives?

[12471.671123] WARNING: possible circular locking dependency detected
[12471.677995] 5.4.0-rc6-next-20191111+ #2 Tainted: G        W    L  =20
[12471.684950] ------------------------------------------------------
[12471.691819] read_all/70259 is trying to acquire lock:
[12471.697559] ffff00977b407290 (&(&zone->lock)->rlock){..-.}, at: =
rmqueue+0xf1c/0x2050
[12471.706005]=20
               but task is already holding lock:
[12471.713219] 69ff00082000fd18 (&(&n->list_lock)->rlock){-.-.}, at: =
list_locations+0x104/0x4b4
[12471.722364]=20
               which lock already depends on the new lock.

[12471.732617]=20
               the existing dependency chain (in reverse order) is:
[12471.741480]=20
               -> #4 (&(&n->list_lock)->rlock){-.-.}:
[12471.749150]        lock_acquire+0x320/0x360
[12471.754028]        _raw_spin_lock+0x64/0x80
[12471.758903]        get_partial_node+0x48/0x208
[12471.764037]        ___slab_alloc+0x1b8/0x640
[12471.768997]        __kmalloc+0x3c4/0x490
[12471.773623]        __tty_buffer_request_room+0x118/0x1f8
[12471.779627]        tty_insert_flip_string_fixed_flag+0x6c/0x144
[12471.786240]        pty_write+0x80/0xd0
[12471.790680]        n_tty_write+0x450/0x60c
[12471.795466]        tty_write+0x338/0x474
[12471.800082]        __vfs_write+0x88/0x214
[12471.804780]        vfs_write+0x12c/0x1a4
[12471.809393]        redirected_tty_write+0x90/0xdc
[12471.814790]        do_loop_readv_writev+0x140/0x180
[12471.820357]        do_iter_write+0xe0/0x10c
[12471.825230]        vfs_writev+0x134/0x1cc
[12471.829929]        do_writev+0xbc/0x130
[12471.834455]        __arm64_sys_writev+0x58/0x8c
[12471.839688]        el0_svc_handler+0x170/0x240
[12471.844829]        el0_sync_handler+0x150/0x250
[12471.850049]        el0_sync+0x164/0x180
[12471.854572]=20
               -> #3 (&(&port->lock)->rlock){-.-.}:
[12471.862057]        lock_acquire+0x320/0x360
[12471.866930]        _raw_spin_lock_irqsave+0x7c/0x9c
[12471.872498]        tty_port_tty_get+0x24/0x60
[12471.877545]        tty_port_default_wakeup+0x1c/0x3c
[12471.883199]        tty_port_tty_wakeup+0x34/0x40
[12471.888510]        uart_write_wakeup+0x28/0x44
[12471.893644]        pl011_tx_chars+0x1b8/0x270
[12471.898696]        pl011_start_tx+0x24/0x70
[12471.903570]        __uart_start+0x5c/0x68
[12471.908269]        uart_write+0x164/0x1c8
[12471.912969]        do_output_char+0x33c/0x348
[12471.918016]        n_tty_write+0x4bc/0x60c
[12471.922802]        tty_write+0x338/0x474
[12471.927414]        redirected_tty_write+0xc0/0xdc
[12471.932808]        do_loop_readv_writev+0x140/0x180
[12471.938375]        do_iter_write+0xe0/0x10c
[12471.943248]        vfs_writev+0x134/0x1cc
[12471.947950]        do_writev+0xbc/0x130
[12471.952478]        __arm64_sys_writev+0x58/0x8c
[12471.957700]        el0_svc_handler+0x170/0x240
[12471.962833]        el0_sync_handler+0x150/0x250
[12471.968053]        el0_sync+0x164/0x180
[12471.972576]=20
               -> #2 (&port_lock_key){-.-.}:
[12471.979453]        lock_acquire+0x320/0x360
[12471.984326]        _raw_spin_lock+0x64/0x80
[12471.989200]        pl011_console_write+0xec/0x2cc
[12471.994595]        console_unlock+0x794/0x96c
[12471.999641]        vprintk_emit+0x260/0x31c
[12472.004513]        vprintk_default+0x54/0x7c
[12472.009475]        vprintk_func+0x218/0x254
[12472.014358]        printk+0x7c/0xa4
[12472.018536]        register_console+0x734/0x7b0
[12472.023757]        uart_add_one_port+0x734/0x834
[12472.029065]        pl011_register_port+0x6c/0xac
[12472.034372]        sbsa_uart_probe+0x234/0x2ec
[12472.039508]        platform_drv_probe+0xd4/0x124
[12472.044821]        really_probe+0x250/0x71c
[12472.049694]        driver_probe_device+0xb4/0x200
[12472.055090]        __device_attach_driver+0xd8/0x188
[12472.060744]        bus_for_each_drv+0xbc/0x110
[12472.065878]        __device_attach+0x120/0x220
[12472.071012]        device_initial_probe+0x20/0x2c
[12472.076405]        bus_probe_device+0x54/0x100
[12472.081539]        device_add+0xae8/0xc2c
[12472.086242]        platform_device_add+0x278/0x3b8
[12472.091725]        platform_device_register_full+0x238/0x2ac
[12472.098079]        acpi_create_platform_device+0x2dc/0x3a8
[12472.104263]        acpi_bus_attach+0x390/0x3cc
[12472.109397]        acpi_bus_attach+0x108/0x3cc
[12472.114531]        acpi_bus_attach+0x108/0x3cc
[12472.119664]        acpi_bus_attach+0x108/0x3cc
[12472.124798]        acpi_bus_scan+0x7c/0xb0
[12472.129588]        acpi_scan_init+0xe4/0x304
[12472.134548]        acpi_init+0x100/0x114
[12472.139160]        do_one_initcall+0x348/0x6a0
[12472.144299]        do_initcall_level+0x190/0x1fc
[12472.149606]        do_basic_setup+0x34/0x4c
[12472.154479]        kernel_init_freeable+0x19c/0x260
[12472.160051]        kernel_init+0x18/0x338
[12472.164751]        ret_from_fork+0x10/0x18
[12472.169534]=20
               -> #1 (console_owner){-...}:
[12472.176323]        lock_acquire+0x320/0x360
[12472.181196]        console_lock_spinning_enable+0x6c/0x7c
[12472.187284]        console_unlock+0x4f8/0x96c
[12472.192330]        vprintk_emit+0x260/0x31c
[12472.197202]        vprintk_default+0x54/0x7c
[12472.202162]        vprintk_func+0x218/0x254
[12472.207035]        printk+0x7c/0xa4
[12472.211218]        get_random_u64+0x1c4/0x1dc
[12472.216266]        shuffle_pick_tail+0x40/0xac
[12472.221408]        __free_one_page+0x424/0x710
[12472.226541]        free_one_page+0x70/0x120
[12472.231415]        __free_pages_ok+0x61c/0xa94
[12472.236550]        __free_pages_core+0x1bc/0x294
[12472.241861]        memblock_free_pages+0x38/0x48
[12472.247171]        __free_pages_memory+0xcc/0xfc
[12472.252478]        __free_memory_core+0x70/0x78
[12472.257699]        free_low_memory_core_early+0x148/0x18c
[12472.263787]        memblock_free_all+0x18/0x54
[12472.268921]        mem_init+0xb4/0x17c
[12472.273360]        mm_init+0x14/0x38
[12472.277625]        start_kernel+0x19c/0x530
[12472.282495]=20
               -> #0 (&(&zone->lock)->rlock){..-.}:
[12472.289977]        validate_chain+0xf6c/0x2e2c
[12472.295111]        __lock_acquire+0x868/0xc2c
[12472.300159]        lock_acquire+0x320/0x360
[12472.305032]        _raw_spin_lock_irqsave+0x7c/0x9c
[12472.310599]        rmqueue+0xf1c/0x2050
[12472.315128]        get_page_from_freelist+0x474/0x688
[12472.320869]        __alloc_pages_nodemask+0x3b4/0x18dc
[12472.326707]        alloc_pages_current+0xd0/0xe0
[12472.332014]        __get_free_pages+0x24/0x6c
[12472.337061]        alloc_loc_track+0x38/0x80
[12472.342022]        process_slab+0x228/0x544
[12472.346895]        list_locations+0x158/0x4b4
[12472.351942]        alloc_calls_show+0x38/0x48
[12472.356991]        slab_attr_show+0x38/0x54
[12472.361876]        sysfs_kf_seq_show+0x198/0x2d4
[12472.367184]        kernfs_seq_show+0xa4/0xcc
[12472.372150]        seq_read+0x394/0x918
[12472.376676]        kernfs_fop_read+0xa8/0x334
[12472.381722]        __vfs_read+0x88/0x20c
[12472.386334]        vfs_read+0xdc/0x110
[12472.390773]        ksys_read+0xb0/0x120
[12472.395298]        __arm64_sys_read+0x54/0x88
[12472.400345]        el0_svc_handler+0x170/0x240
[12472.405479]        el0_sync_handler+0x150/0x250
[12472.410699]        el0_sync+0x164/0x180
[12472.415223]=20
               other info that might help us debug this:

[12472.425304] Chain exists of:
                 &(&zone->lock)->rlock --> &(&port->lock)->rlock --> =
&(&n->list_lock)->rlock

[12472.439914]  Possible unsafe locking scenario:

[12472.447216]        CPU0                    CPU1
[12472.452434]        ----                    ----
[12472.457650]   lock(&(&n->list_lock)->rlock);
[12472.462610]                                =
lock(&(&port->lock)->rlock);
[12472.469914]                                =
lock(&(&n->list_lock)->rlock);
[12472.477390]   lock(&(&zone->lock)->rlock);
[12472.482175]=20
                *** DEADLOCK ***

[12472.490172] 4 locks held by read_all/70259:
[12472.495041]  #0: 33ff00947d9881e0 (&p->lock){+.+.}, at: =
seq_read+0x50/0x918
[12472.502701]  #1: f9ff0095cb6e2680 (&of->mutex){+.+.}, at: =
kernfs_seq_start+0x34/0xf0
[12472.511141]  #2: b8ff00083dc2dd08 (kn->count#48){++++}, at: =
kernfs_seq_start+0x44/0xf0
[12472.519756]  #3: 69ff00082000fd18 (&(&n->list_lock)->rlock){-.-.}, =
at: list_locations+0x104/0x4b4
[12472.529325]=20
               stack backtrace:
[12472.535069] CPU: 236 PID: 70259 Comm: read_all Tainted: G        W    =
L    5.4.0-rc6-next-20191111+ #2
[12472.545062] Hardware name: HPE Apollo 70             /C01_APACHE_MB   =
      , BIOS L50_5.13_1.11 06/18/2019
[12472.555489] Call trace:
[12472.558626]  dump_backtrace+0x0/0x248
[12472.562977]  show_stack+0x20/0x2c
[12472.566992]  dump_stack+0xe8/0x150
[12472.571084]  print_circular_bug+0x368/0x380
[12472.575957]  check_noncircular+0x28c/0x294
[12472.580742]  validate_chain+0xf6c/0x2e2c
[12472.585355]  __lock_acquire+0x868/0xc2c
[12472.589882]  lock_acquire+0x320/0x360
[12472.594234]  _raw_spin_lock_irqsave+0x7c/0x9c
[12472.599280]  rmqueue+0xf1c/0x2050
[12472.603286]  get_page_from_freelist+0x474/0x688
[12472.608506]  __alloc_pages_nodemask+0x3b4/0x18dc
[12472.613813]  alloc_pages_current+0xd0/0xe0
[12472.618600]  __get_free_pages+0x24/0x6c
[12472.623126]  alloc_loc_track+0x38/0x80
[12472.627565]  process_slab+0x228/0x544
[12472.631917]  list_locations+0x158/0x4b4
[12472.636444]  alloc_calls_show+0x38/0x48
[12472.640969]  slab_attr_show+0x38/0x54
[12472.645322]  sysfs_kf_seq_show+0x198/0x2d4
[12472.650108]  kernfs_seq_show+0xa4/0xcc
[12472.654547]  seq_read+0x394/0x918
[12472.658552]  kernfs_fop_read+0xa8/0x334
[12472.663078]  __vfs_read+0x88/0x20c
[12472.667169]  vfs_read+0xdc/0x110
[12472.671087]  ksys_read+0xb0/0x120
[12472.675091]  __arm64_sys_read+0x54/0x88
[12472.679618]  el0_svc_handler+0x170/0x240
[12472.684231]  el0_sync_handler+0x150/0x250
[12472.688929]  el0_sync+0x164/0x180


the existing dependency chain (in reverse order) is:

 -> #4 (&pool->lock/1){-.-.}:
      lock_acquire+0x320/0x360
      _raw_spin_lock+0x64/0x80
      __queue_work+0x4b4/0xa10
      queue_work_on+0xac/0x11c
      tty_schedule_flip+0x84/0xbc
      tty_flip_buffer_push+0x1c/0x28
      pty_write+0x98/0xd0
      n_tty_write+0x450/0x60c
      tty_write+0x338/0x474
      __vfs_write+0x88/0x214
      vfs_write+0x12c/0x1a4
      redirected_tty_write+0x90/0xdc
      do_loop_readv_writev+0x140/0x180
      do_iter_write+0xe0/0x10c
      vfs_writev+0x134/0x1cc
      do_writev+0xbc/0x130
      __arm64_sys_writev+0x58/0x8c
      el0_svc_handler+0x170/0x240
      el0_sync_handler+0x150/0x250
      el0_sync+0x164/0x180

 -> #3 (&(&port->lock)->rlock){-.-.}:
      lock_acquire+0x320/0x360
      _raw_spin_lock_irqsave+0x7c/0x9c
      tty_port_tty_get+0x24/0x60
      tty_port_default_wakeup+0x1c/0x3c
      tty_port_tty_wakeup+0x34/0x40
      uart_write_wakeup+0x28/0x44
      pl011_tx_chars+0x1b8/0x270
      pl011_start_tx+0x24/0x70
      __uart_start+0x5c/0x68
      uart_write+0x164/0x1c8
      do_output_char+0x33c/0x348
      n_tty_write+0x4bc/0x60c
      tty_write+0x338/0x474
      redirected_tty_write+0xc0/0xdc
      do_loop_readv_writev+0x140/0x180
      do_iter_write+0xe0/0x10c
      vfs_writev+0x134/0x1cc
      do_writev+0xbc/0x130
      __arm64_sys_writev+0x58/0x8c
      el0_svc_handler+0x170/0x240
      el0_sync_handler+0x150/0x250
      el0_sync+0x164/0x180

 -> #2 (&port_lock_key){-.-.}:
      lock_acquire+0x320/0x360
      _raw_spin_lock+0x64/0x80
      pl011_console_write+0xec/0x2cc
      console_unlock+0x794/0x96c
      vprintk_emit+0x260/0x31c
      vprintk_default+0x54/0x7c
      vprintk_func+0x218/0x254
      printk+0x7c/0xa4
      register_console+0x734/0x7b0
      uart_add_one_port+0x734/0x834
      pl011_register_port+0x6c/0xac
      sbsa_uart_probe+0x234/0x2ec
      platform_drv_probe+0xd4/0x124
      really_probe+0x250/0x71c
      driver_probe_device+0xb4/0x200
      __device_attach_driver+0xd8/0x188
      bus_for_each_drv+0xbc/0x110
      __device_attach+0x120/0x220
      device_initial_probe+0x20/0x2c
      bus_probe_device+0x54/0x100
      device_add+0xae8/0xc2c
      platform_device_add+0x278/0x3b8
      platform_device_register_full+0x238/0x2ac
      acpi_create_platform_device+0x2dc/0x3a8
      acpi_bus_attach+0x390/0x3cc
      acpi_bus_attach+0x108/0x3cc
      acpi_bus_attach+0x108/0x3cc
      acpi_bus_attach+0x108/0x3cc
      acpi_bus_scan+0x7c/0xb0
      acpi_scan_init+0xe4/0x304
      acpi_init+0x100/0x114
      do_one_initcall+0x348/0x6a0
      do_initcall_level+0x190/0x1fc
      do_basic_setup+0x34/0x4c
      kernel_init_freeable+0x19c/0x260
      kernel_init+0x18/0x338
      ret_from_fork+0x10/0x18

 -> #1 (console_owner){-...}:
      lock_acquire+0x320/0x360
      console_lock_spinning_enable+0x6c/0x7c
      console_unlock+0x4f8/0x96c
      vprintk_emit+0x260/0x31c
      vprintk_default+0x54/0x7c
      vprintk_func+0x218/0x254
      printk+0x7c/0xa4
      get_random_u64+0x1c4/0x1dc
      shuffle_pick_tail+0x40/0xac
      __free_one_page+0x424/0x710
      free_one_page+0x70/0x120
      __free_pages_ok+0x61c/0xa94
      __free_pages_core+0x1bc/0x294
      memblock_free_pages+0x38/0x48
      __free_pages_memory+0xcc/0xfc
      __free_memory_core+0x70/0x78
      free_low_memory_core_early+0x148/0x18c
      memblock_free_all+0x18/0x54
      mem_init+0xb4/0x17c
      mm_init+0x14/0x38
      start_kernel+0x19c/0x530

 -> #0 (&(&zone->lock)->rlock){..-.}:
      validate_chain+0xf6c/0x2e2c
      __lock_acquire+0x868/0xc2c
      lock_acquire+0x320/0x360
      _raw_spin_lock+0x64/0x80
      rmqueue+0x138/0x2050
      get_page_from_freelist+0x474/0x688
      __alloc_pages_nodemask+0x3b4/0x18dc
      alloc_pages_current+0xd0/0xe0
      alloc_slab_page+0x2b4/0x5e0
      new_slab+0xc8/0x6bc
      ___slab_alloc+0x3b8/0x640
      kmem_cache_alloc+0x4b4/0x588
      __debug_object_init+0x778/0x8b4
      debug_object_init_on_stack+0x40/0x50
      start_flush_work+0x16c/0x3f0
      __flush_work+0xb8/0x124
      flush_work+0x20/0x30
      xlog_cil_force_lsn+0x88/0x204 [xfs]
      xfs_log_force_lsn+0x128/0x1b8 [xfs]
      xfs_file_fsync+0x3c4/0x488 [xfs]
      vfs_fsync_range+0xb0/0xd0
      generic_write_sync+0x80/0xa0 [xfs]
      xfs_file_buffered_aio_write+0x66c/0x6e4 [xfs]
      xfs_file_write_iter+0x1a0/0x218 [xfs]
      __vfs_write+0x1cc/0x214
      vfs_write+0x12c/0x1a4
      ksys_write+0xb0/0x120
      __arm64_sys_write+0x54/0x88
      el0_svc_handler+0x170/0x240
      el0_sync_handler+0x150/0x250
      el0_sync+0x164/0x180

      other info that might help us debug this:

Chain exists of:
  &(&zone->lock)->rlock --> &(&port->lock)->rlock --> &pool->lock/1

Possible unsafe locking scenario:

      CPU0                    CPU1
      ----                    ----
 lock(&pool->lock/1);
                              lock(&(&port->lock)->rlock);
                              lock(&pool->lock/1);
 lock(&(&zone->lock)->rlock);

               *** DEADLOCK ***

4 locks held by doio/49441:
#0: a0ff00886fc27408 (sb_writers#8){.+.+}, at: vfs_write+0x118/0x1a4
#1: 8fff00080810dfe0 (&xfs_nondir_ilock_class){++++}, at:
xfs_ilock+0x2a8/0x300 [xfs]
#2: ffff9000129f2390 (rcu_read_lock){....}, at:
rcu_lock_acquire+0x8/0x38
#3: 60ff000822352818 (&pool->lock/1){-.-.}, at:
start_flush_work+0xd8/0x3f0

              stack backtrace:
CPU: 48 PID: 49441 Comm: doio Tainted: G        W
Hardware name: HPE Apollo 70             /C01_APACHE_MB         , BIOS
L50_5.13_1.11 06/18/2019
Call trace:
dump_backtrace+0x0/0x248
show_stack+0x20/0x2c
dump_stack+0xe8/0x150
print_circular_bug+0x368/0x380
check_noncircular+0x28c/0x294
validate_chain+0xf6c/0x2e2c
__lock_acquire+0x868/0xc2c
lock_acquire+0x320/0x360
_raw_spin_lock+0x64/0x80
rmqueue+0x138/0x2050
get_page_from_freelist+0x474/0x688
__alloc_pages_nodemask+0x3b4/0x18dc
alloc_pages_current+0xd0/0xe0
alloc_slab_page+0x2b4/0x5e0
new_slab+0xc8/0x6bc
___slab_alloc+0x3b8/0x640
kmem_cache_alloc+0x4b4/0x588
__debug_object_init+0x778/0x8b4
debug_object_init_on_stack+0x40/0x50
start_flush_work+0x16c/0x3f0
__flush_work+0xb8/0x124
flush_work+0x20/0x30
xlog_cil_force_lsn+0x88/0x204 [xfs]
xfs_log_force_lsn+0x128/0x1b8 [xfs]
xfs_file_fsync+0x3c4/0x488 [xfs]
vfs_fsync_range+0xb0/0xd0
generic_write_sync+0x80/0xa0 [xfs]
xfs_file_buffered_aio_write+0x66c/0x6e4 [xfs]
xfs_file_write_iter+0x1a0/0x218 [xfs]
__vfs_write+0x1cc/0x214
vfs_write+0x12c/0x1a4
ksys_write+0xb0/0x120
__arm64_sys_write+0x54/0x88
el0_svc_handler+0x170/0x240
el0_sync_handler+0x150/0x250
el0_sync+0x164/0x180

WARNING: possible circular locking dependency detected
5.3.0-next-20190917 #8 Not tainted
------------------------------------------------------
test.sh/8653 is trying to acquire lock:
ffffffff865a4460 (console_owner){-.-.}, at:
console_unlock+0x207/0x750

but task is already holding lock:
ffff88883fff3c58 (&(&zone->lock)->rlock){-.-.}, at:
__offline_isolated_pages+0x179/0x3e0

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&(&zone->lock)->rlock){-.-.}:
       __lock_acquire+0x5b3/0xb40
       lock_acquire+0x126/0x280
       _raw_spin_lock+0x2f/0x40
       rmqueue_bulk.constprop.21+0xb6/0x1160
       get_page_from_freelist+0x898/0x22c0
       __alloc_pages_nodemask+0x2f3/0x1cd0
       alloc_pages_current+0x9c/0x110
       allocate_slab+0x4c6/0x19c0
       new_slab+0x46/0x70
       ___slab_alloc+0x58b/0x960
       __slab_alloc+0x43/0x70
       __kmalloc+0x3ad/0x4b0
       __tty_buffer_request_room+0x100/0x250
       tty_insert_flip_string_fixed_flag+0x67/0x110
       pty_write+0xa2/0xf0
       n_tty_write+0x36b/0x7b0
       tty_write+0x284/0x4c0
       __vfs_write+0x50/0xa0
       vfs_write+0x105/0x290
       redirected_tty_write+0x6a/0xc0
       do_iter_write+0x248/0x2a0
       vfs_writev+0x106/0x1e0
       do_writev+0xd4/0x180
       __x64_sys_writev+0x45/0x50
       do_syscall_64+0xcc/0x76c
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #2 (&(&port->lock)->rlock){-.-.}:
       __lock_acquire+0x5b3/0xb40
       lock_acquire+0x126/0x280
       _raw_spin_lock_irqsave+0x3a/0x50
       tty_port_tty_get+0x20/0x60
       tty_port_default_wakeup+0xf/0x30
       tty_port_tty_wakeup+0x39/0x40
       uart_write_wakeup+0x2a/0x40
       serial8250_tx_chars+0x22e/0x440
       serial8250_handle_irq.part.8+0x14a/0x170
       serial8250_default_handle_irq+0x5c/0x90
       serial8250_interrupt+0xa6/0x130
       __handle_irq_event_percpu+0x78/0x4f0
       handle_irq_event_percpu+0x70/0x100
       handle_irq_event+0x5a/0x8b
       handle_edge_irq+0x117/0x370
       do_IRQ+0x9e/0x1e0
       ret_from_intr+0x0/0x2a
       cpuidle_enter_state+0x156/0x8e0
       cpuidle_enter+0x41/0x70
       call_cpuidle+0x5e/0x90
       do_idle+0x333/0x370
       cpu_startup_entry+0x1d/0x1f
       start_secondary+0x290/0x330
       secondary_startup_64+0xb6/0xc0

-> #1 (&port_lock_key){-.-.}:
       __lock_acquire+0x5b3/0xb40
       lock_acquire+0x126/0x280
       _raw_spin_lock_irqsave+0x3a/0x50
       serial8250_console_write+0x3e4/0x450
       univ8250_console_write+0x4b/0x60
       console_unlock+0x501/0x750
       vprintk_emit+0x10d/0x340
       vprintk_default+0x1f/0x30
       vprintk_func+0x44/0xd4
       printk+0x9f/0xc5

-> #0 (console_owner){-.-.}:
       check_prev_add+0x107/0xea0
       validate_chain+0x8fc/0x1200
       __lock_acquire+0x5b3/0xb40
       lock_acquire+0x126/0x280
       console_unlock+0x269/0x750
       vprintk_emit+0x10d/0x340
       vprintk_default+0x1f/0x30
       vprintk_func+0x44/0xd4
       printk+0x9f/0xc5
       __offline_isolated_pages.cold.52+0x2f/0x30a
       offline_isolated_pages_cb+0x17/0x30
       walk_system_ram_range+0xda/0x160
       __offline_pages+0x79c/0xa10
       offline_pages+0x11/0x20
       memory_subsys_offline+0x7e/0xc0
       device_offline+0xd5/0x110
       state_store+0xc6/0xe0
       dev_attr_store+0x3f/0x60
       sysfs_kf_write+0x89/0xb0
       kernfs_fop_write+0x188/0x240
       __vfs_write+0x50/0xa0
       vfs_write+0x105/0x290
       ksys_write+0xc6/0x160
       __x64_sys_write+0x43/0x50
       do_syscall_64+0xcc/0x76c
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
  console_owner --> &(&port->lock)->rlock --> &(&zone->lock)-

>rlock


 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&(&zone->lock)->rlock);
                               lock(&(&port->lock)->rlock);
                               lock(&(&zone->lock)->rlock);
  lock(console_owner);

 *** DEADLOCK ***

9 locks held by test.sh/8653:
 #0: ffff88839ba7d408 (sb_writers#4){.+.+}, at:
vfs_write+0x25f/0x290
 #1: ffff888277618880 (&of->mutex){+.+.}, at:
kernfs_fop_write+0x128/0x240
 #2: ffff8898131fc218 (kn->count#115){.+.+}, at:
kernfs_fop_write+0x138/0x240
 #3: ffffffff86962a80 (device_hotplug_lock){+.+.}, at:
lock_device_hotplug_sysfs+0x16/0x50
 #4: ffff8884374f4990 (&dev->mutex){....}, at:
device_offline+0x70/0x110
 #5: ffffffff86515250 (cpu_hotplug_lock.rw_sem){++++}, at:
__offline_pages+0xbf/0xa10
 #6: ffffffff867405f0 (mem_hotplug_lock.rw_sem){++++}, at:
percpu_down_write+0x87/0x2f0
 #7: ffff88883fff3c58 (&(&zone->lock)->rlock){-.-.}, at:
__offline_isolated_pages+0x179/0x3e0
 #8: ffffffff865a4920 (console_lock){+.+.}, at:
vprintk_emit+0x100/0x340

stack backtrace:
CPU: 1 PID: 8653 Comm: test.sh Not tainted 5.3.0-next-20190917 #8
Hardware name: HPE ProLiant DL560 Gen10/ProLiant DL560 Gen10,
BIOS U34 05/21/2019
Call Trace:
 dump_stack+0x86/0xca
 print_circular_bug.cold.31+0x243/0x26e
 check_noncircular+0x29e/0x2e0
 check_prev_add+0x107/0xea0
 validate_chain+0x8fc/0x1200
 __lock_acquire+0x5b3/0xb40
 lock_acquire+0x126/0x280
 console_unlock+0x269/0x750
 vprintk_emit+0x10d/0x340
 vprintk_default+0x1f/0x30
 vprintk_func+0x44/0xd4
 printk+0x9f/0xc5
 __offline_isolated_pages.cold.52+0x2f/0x30a
 offline_isolated_pages_cb+0x17/0x30
 walk_system_ram_range+0xda/0x160
 __offline_pages+0x79c/0xa10
 offline_pages+0x11/0x20
 memory_subsys_offline+0x7e/0xc0
 device_offline+0xd5/0x110
 state_store+0xc6/0xe0
 dev_attr_store+0x3f/0x60
 sysfs_kf_write+0x89/0xb0
 kernfs_fop_write+0x188/0x240
 __vfs_write+0x50/0xa0
 vfs_write+0x105/0x290
 ksys_write+0xc6/0x160
 __x64_sys_write+0x43/0x50
 do_syscall_64+0xcc/0x76c
 entry_SYSCALL_64_after_hwframe+0x49/0xbe


>=20
> I suggest to disable lockdep around the safe allocation in the console
> initialization code. Then we will see if there are other locations
> that trigger this lockdep warning. It is trivial and will not
> complicate the code because of false positives.
>=20
>=20
>> I have been spent the last a few months to research this, so
>> I don=E2=80=99t feel like to do this again.
>>=20
>> https://lore.kernel.org/linux-mm/1570633715.5937.10.camel@lca.pw/
>=20
> Have you tried to disable lockdep around the problematic allocation?
>=20
> Have you seen other lockdep reports caused by exactly this printk()
> in the allocator code?
>=20
> My big problem with this patch is that the commit message does not
> contain any lockdep report. It will complicate removing the hack
> when it is not longer needed. Nobody will know what was the exact
> problem and if it is safe to get removed. I believe that printk()
> will offload console handling rather sooner than later and this
> extra logic will not be necessary.
>=20
> Best Regards,
> Petr

