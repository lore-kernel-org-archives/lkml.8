Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50066C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 209432168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="CSFmH9lO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgDXTo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 15:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDXTo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:44:28 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBFEC09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 12:44:28 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id o10so8957172qtr.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 12:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=V+YrkwGxBVUkcv9bbfweZUInmDzrb7+mG0m25f6D9ug=;
        b=CSFmH9lOfScIOUgW5JLLn8d9F7LJ0opYyUoGS0/dM1iDdM9qz99RLHgBmOvmaFn5kZ
         kW7GloYyM9/h5Mrs2KfqoiweGHGAESbSxDec4WA5ALb4/UWbBQKWCfQz2BKdV1xvmEDp
         yXIsJ0HdSEV8FfA1SvHEO0tVYOaxwaGLhU+SnO6ejjhrpAbWyjZbgpPRsDLgNu0IhfEr
         RIFWCmnv+IInq9KsDvRuscp9EIwIvARHjWI//kC6KytrJlFVWZl7tLppaU5YP3U+/Ldo
         AZ6O8j7QlapS8InB9Tfpnz68oqrkr2DeJtse64xCubWM9vqykpUkd7PV3XJNkqSA/g6R
         ZKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=V+YrkwGxBVUkcv9bbfweZUInmDzrb7+mG0m25f6D9ug=;
        b=EjAUxk4eBaxTaPr0jgpHk/3FWkisPBXUTiaESVt4iUAz6GJGcynmN6/VmEcNn7ue/C
         nVO9TjYx0pEFUpSRlCgZF+01tkSJ8sKugy9s4kBPeEavNHeVpILmvF944kCB+3IQrhui
         scUmd2h660VJ2oGOfpFblw2Em8mkRKKVwrLHhXo6qWomkxNvIvEw8cR+u0203aNeqC79
         S9E1kOUQBSxI4kjaBDyAePDnu2TJYEFr/XK1+O07LT50XrqqnN9Fj4gAl32X7fzdvS9U
         gvTP12s9FNjSWuqCZVnhhZUCHsStAxBu8s3bW3yzcoz8AbXRThCLAwLizLZAysVMvYfH
         Z60w==
X-Gm-Message-State: AGi0PuYrCcET0vH5uYQHCYCWepQXaI+VDvXieqa30K/T9EjOLxRdWP6y
        SQiLl9WPxG/tGIvlHa2SUV58LQ==
X-Google-Smtp-Source: APiQypJiYwDE8GGvaMMTzVxBui9oc0BSaRy343SsrcrFRS3Ql48NpQlNAAqlON7kd4rm125Q8XLjfA==
X-Received: by 2002:ac8:46d0:: with SMTP id h16mr11541714qto.242.1587757467178;
        Fri, 24 Apr 2020 12:44:27 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e16sm4607732qtc.92.2020.04.24.12.44.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 12:44:26 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 2/2] mm/slub: Fix slab_mutex circular locking problem in
 slab_attr_store()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200424151225.10966-2-longman@redhat.com>
Date:   Fri, 24 Apr 2020 15:44:25 -0400
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <29F1A08C-3622-452E-A98C-C952DA6AE681@lca.pw>
References: <20200424151225.10966-1-longman@redhat.com>
 <20200424151225.10966-2-longman@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 24, 2020, at 11:12 AM, Waiman Long <longman@redhat.com> wrote:
>=20
> The following lockdep splat was reported:
>=20
>  [  176.241923] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  [  176.241924] WARNING: possible circular locking dependency detected
>  [  176.241926] 4.18.0-172.rt13.29.el8.x86_64+debug #1 Not tainted
>  [  176.241927] ------------------------------------------------------
>  [  176.241929] slub_cpu_partia/5371 is trying to acquire lock:
>  [  176.241930] ffffffffa0b83718 (slab_mutex){+.+.}, at: =
slab_attr_store+0x6b/0xe0
>  [  176.241941]
>                 but task is already holding lock:
>  [  176.241942] ffff88bb6d8b83c8 (kn->count#103){++++}, at: =
kernfs_fop_write+0x1cc/0x400
>  [  176.241947]
>                 which lock already depends on the new lock.
>=20
>  [  176.241949]
>                 the existing dependency chain (in reverse order) is:
>  [  176.241949]
>                 -> #1 (kn->count#103){++++}:
>  [  176.241955]        __kernfs_remove+0x616/0x800
>  [  176.241957]        kernfs_remove_by_name_ns+0x3e/0x80
>  [  176.241959]        sysfs_slab_add+0x1c6/0x330
>  [  176.241961]        __kmem_cache_create+0x15f/0x1b0
>  [  176.241964]        create_cache+0xe1/0x220
>  [  176.241966]        kmem_cache_create_usercopy+0x1a3/0x260
>  [  176.241967]        kmem_cache_create+0x12/0x20
>  [  176.242076]        mlx5_init_fs+0x18d/0x1a00 [mlx5_core]
>  [  176.242100]        mlx5_load_one+0x3b4/0x1730 [mlx5_core]
>  [  176.242124]        init_one+0x901/0x11b0 [mlx5_core]
>  [  176.242127]        local_pci_probe+0xd4/0x180
>  [  176.242131]        work_for_cpu_fn+0x51/0xa0
>  [  176.242133]        process_one_work+0x91a/0x1ac0
>  [  176.242134]        worker_thread+0x536/0xb40
>  [  176.242136]        kthread+0x30c/0x3d0
>  [  176.242140]        ret_from_fork+0x27/0x50
>  [  176.242140]
>                 -> #0 (slab_mutex){+.+.}:
>  [  176.242145]        __lock_acquire+0x22cb/0x48c0
>  [  176.242146]        lock_acquire+0x134/0x4c0
>  [  176.242148]        _mutex_lock+0x28/0x40
>  [  176.242150]        slab_attr_store+0x6b/0xe0
>  [  176.242151]        kernfs_fop_write+0x251/0x400
>  [  176.242154]        vfs_write+0x157/0x460
>  [  176.242155]        ksys_write+0xb8/0x170
>  [  176.242158]        do_syscall_64+0x13c/0x710
>  [  176.242160]        entry_SYSCALL_64_after_hwframe+0x6a/0xdf
>  [  176.242161]
>                 other info that might help us debug this:
>=20
>  [  176.242161]  Possible unsafe locking scenario:
>=20
>  [  176.242162]        CPU0                    CPU1
>  [  176.242163]        ----                    ----
>  [  176.242163]   lock(kn->count#103);
>  [  176.242165]                                lock(slab_mutex);
>  [  176.242166]                                lock(kn->count#103);
>  [  176.242167]   lock(slab_mutex);
>  [  176.242169]
>                  *** DEADLOCK ***
>=20
>  [  176.242170] 3 locks held by slub_cpu_partia/5371:
>  [  176.242170]  #0: ffff888705e3a800 (sb_writers#4){.+.+}, at: =
vfs_write+0x31c/0x460
>  [  176.242174]  #1: ffff889aeec4d658 (&of->mutex){+.+.}, at: =
kernfs_fop_write+0x1a9/0x400
>  [  176.242177]  #2: ffff88bb6d8b83c8 (kn->count#103){++++}, at: =
kernfs_fop_write+0x1cc/0x400
>  [  176.242180]
>                 stack backtrace:
>  [  176.242183] CPU: 36 PID: 5371 Comm: slub_cpu_partia Not tainted =
4.18.0-172.rt13.29.el8.x86_64+debug #1
>  [  176.242184] Hardware name: AMD Corporation DAYTONA_X/DAYTONA_X, =
BIOS RDY1005C 11/22/2019
>  [  176.242185] Call Trace:
>  [  176.242190]  dump_stack+0x9a/0xf0
>  [  176.242193]  check_noncircular+0x317/0x3c0
>  [  176.242195]  ? print_circular_bug+0x1e0/0x1e0
>  [  176.242199]  ? native_sched_clock+0x32/0x1e0
>  [  176.242202]  ? sched_clock+0x5/0x10
>  [  176.242205]  ? sched_clock_cpu+0x238/0x340
>  [  176.242208]  __lock_acquire+0x22cb/0x48c0
>  [  176.242213]  ? trace_hardirqs_on+0x10/0x10
>  [  176.242215]  ? trace_hardirqs_on+0x10/0x10
>  [  176.242218]  lock_acquire+0x134/0x4c0
>  [  176.242220]  ? slab_attr_store+0x6b/0xe0
>  [  176.242223]  _mutex_lock+0x28/0x40
>  [  176.242225]  ? slab_attr_store+0x6b/0xe0
>  [  176.242227]  slab_attr_store+0x6b/0xe0
>  [  176.242229]  ? sysfs_file_ops+0x160/0x160
>  [  176.242230]  kernfs_fop_write+0x251/0x400
>  [  176.242232]  ? __sb_start_write+0x26a/0x3f0
>  [  176.242234]  vfs_write+0x157/0x460
>  [  176.242237]  ksys_write+0xb8/0x170
>  [  176.242239]  ? __ia32_sys_read+0xb0/0xb0
>  [  176.242242]  ? do_syscall_64+0xb9/0x710
>  [  176.242245]  do_syscall_64+0x13c/0x710
>  [  176.242247]  entry_SYSCALL_64_after_hwframe+0x6a/0xdf
>=20
> There was another lockdep splat generated by echoing "1" to
> "/sys/kernel/slab/fs_cache/shrink":
>=20
> [  445.231443] Chain exists of:
>                 cpu_hotplug_lock --> mem_hotplug_lock --> slab_mutex
>=20
> [  445.242025]  Possible unsafe locking scenario:
>=20
> [  445.247977]        CPU0                    CPU1
> [  445.252529]        ----                    ----
> [  445.257082]   lock(slab_mutex);
> [  445.260239]                                lock(mem_hotplug_lock);
> [  445.266452]                                lock(slab_mutex);
> [  445.272141]   lock(cpu_hotplug_lock);
>=20
> So it is problematic to use slab_mutex to iterate the list of
> child memcgs with for_each_memcg_cache(). Fortunately, there is
> another way to do child memcg iteration by going through the array
> entries in memcg_params.memcg_caches while holding a read lock on
> memcg_cache_ids_sem.
>=20
> To avoid other possible circular locking problems, we only take a
> reference to the child memcgs and store their addresses while holding
> memcg_cache_ids_sem. The actual store method is called for each of the
> child memcgs after releasing the lock.

Even on x86 where it compiles, this patch is insufficient to prevent a =
lockdep splat,
because there are still cpu_hotplug_lock and mem_hotplug_lock in the =
way.

[  290.738690] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  290.744908] WARNING: possible circular locking dependency detected
[  290.751134] 5.7.0-rc2-next-20200424+ #12 Not tainted
[  290.756132] ------------------------------------------------------
[  290.762611] bash/1798 is trying to acquire lock:
[  290.767262] ffffffff89917890 (cpu_hotplug_lock){++++}-{0:0}, at: =
kmem_cache_shrink+0x12/0x40
[  290.775770]=20
[  290.775770] but task is already holding lock:
[  290.781641] ffff8887f2fbc830 (kn->count#86){++++}-{0:0}, at: =
kernfs_fop_write+0x105/0x250
[  290.790061]=20
[  290.790061] which lock already depends on the new lock.
[  290.790061]=20
[  290.798289]=20
[  290.798289] the existing dependency chain (in reverse order) is:
[  290.805818]=20
[  290.805818] -> #3 (kn->count#86){++++}-{0:0}:
[  290.811954]        __kernfs_remove+0x455/0x4c0
[  290.816428]        kernfs_remove+0x23/0x40
[  290.820554]        sysfs_remove_dir+0x74/0x80
[  290.824947]        kobject_del+0x57/0xa0
[  290.828905]        sysfs_slab_unlink+0x1c/0x20
[  290.833377]        shutdown_cache+0x15d/0x1c0
[  290.837964]        kmemcg_cache_shutdown_fn+0xe/0x20
[  290.842963]        kmemcg_workfn+0x35/0x50
[  290.847095]        process_one_work+0x57e/0xb90
[  290.851658]        worker_thread+0x63/0x5b0
[  290.855872]        kthread+0x1f7/0x220
[  290.859653]        ret_from_fork+0x27/0x50
[  290.864042]=20
[  290.864042] -> #2 (slab_mutex){+.+.}-{3:3}:
[  290.869747]        __mutex_lock+0x12f/0xca0
[  290.873960]        mutex_lock_nested+0x1b/0x20
[  290.878434]        memcg_create_kmem_cache+0x2e/0x190
[  290.883523]        memcg_kmem_cache_create_func+0x38/0x190
[  290.889274]        process_one_work+0x57e/0xb90
[  290.893838]        worker_thread+0x63/0x5b0
[  290.898050]        kthread+0x1f7/0x220
[  290.901828]        ret_from_fork+0x27/0x50
[  290.905953]=20
[  290.905953] -> #1 (mem_hotplug_lock){++++}-{0:0}:
[  290.912384]        get_online_mems+0x3e/0xc0
[  290.916682]        kmem_cache_create_usercopy+0x32/0x270
[  290.922030]        kmem_cache_create+0x16/0x20
[  290.926507]        kmemleak_init+0x4a/0xf4
[  290.930640]        start_kernel+0x52a/0x8bb
[  290.935109]        x86_64_start_reservations+0x24/0x26
[  290.940291]        x86_64_start_kernel+0xf4/0xfb
[  290.944942]        secondary_startup_64+0xb6/0xc0
[  290.949677]=20
[  290.949677] -> #0 (cpu_hotplug_lock){++++}-{0:0}:
[  290.955906]        __lock_acquire+0x21f8/0x3260
[  290.960751]        lock_acquire+0x1a2/0x680
[  290.964966]        cpus_read_lock+0x3e/0xc0
[  290.969176]        kmem_cache_shrink+0x12/0x40
[  290.973650]        shrink_store+0x17/0x30
[  290.977687]        slab_attr_store+0x4d/0x3c0
[  290.982076]        sysfs_kf_write+0x89/0xb0
[  290.986473]        kernfs_fop_write+0x155/0x250
[  290.991041]        __vfs_write+0x50/0xa0
[  290.994990]        vfs_write+0x10b/0x290
[  290.998942]        ksys_write+0xcc/0x170
[  291.002893]        __x64_sys_write+0x43/0x50
[  291.007193]        do_syscall_64+0xcc/0xaf0
[  291.011600]        entry_SYSCALL_64_after_hwframe+0x49/0xb3
[  291.017208]=20
[  291.017208] other info that might help us debug this:
[  291.017208]=20
[  291.025262] Chain exists of:
[  291.025262]   cpu_hotplug_lock --> slab_mutex --> kn->count#86
[  291.025262]=20
[  291.035683]  Possible unsafe locking scenario:
[  291.035683]=20
[  291.041639]        CPU0                    CPU1
[  291.046200]        ----                    ----
[  291.050762]   lock(kn->count#86);
[  291.054101]                                lock(slab_mutex);
[  291.060132]                                lock(kn->count#86);
[  291.066018]   lock(cpu_hotplug_lock);
[  291.069707]=20
[  291.069707]  *** DEADLOCK ***
[  291.069707]=20
[  291.075666] 3 locks held by bash/1798:
[  291.079443]  #0: ffff88832e091430 (sb_writers#4){.+.+}-{0:0}, at: =
vfs_write+0x262/0x290
[  291.087711]  #1: ffff888784670288 (&of->mutex){+.+.}-{3:3}, at: =
kernfs_fop_write+0xf5/0x250
[  291.096119]  #2: ffff8887f2fbc830 (kn->count#86){++++}-{0:0}, at: =
kernfs_fop_write+0x105/0x250
[  291.104788]=20
[  291.104788] stack backtrace:
[  291.109181] CPU: 14 PID: 1798 Comm: bash Not tainted =
5.7.0-rc2-next-20200424+ #12
[  291.116940] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 =
Gen10, BIOS A40 03/09/2018
[  291.125517] Call Trace:
[  291.127990]  dump_stack+0xa7/0xea
[  291.131328]  print_circular_bug.cold.54+0x147/0x14c
[  291.136463]  check_noncircular+0x295/0x2d0
[  291.140586]  ? print_circular_bug+0x1d0/0x1d0
[  291.144974]  ? __kasan_check_read+0x11/0x20
[  291.149188]  ? mark_lock+0x160/0xfe0
[  291.152792]  __lock_acquire+0x21f8/0x3260
[  291.156830]  ? register_lock_class+0xb90/0xb90
[  291.161534]  ? register_lock_class+0xb90/0xb90
[  291.166012]  ? check_flags.part.28+0x220/0x220
[  291.170489]  lock_acquire+0x1a2/0x680
[  291.174178]  ? kmem_cache_shrink+0x12/0x40
[  291.178306]  ? check_flags.part.28+0x220/0x220
[  291.182784]  ? ___might_sleep+0x178/0x210
[  291.187021]  cpus_read_lock+0x3e/0xc0
[  291.190709]  ? kmem_cache_shrink+0x12/0x40
[  291.194832]  kmem_cache_shrink+0x12/0x40
[  291.198781]  shrink_store+0x17/0x30
[  291.202294]  slab_attr_store+0x4d/0x3c0
[  291.206159]  ? kernfs_get_active+0x136/0x150
[  291.210663]  ? objects_show+0x20/0x20
[  291.214349]  sysfs_kf_write+0x89/0xb0
[  291.218038]  ? sysfs_file_ops+0xa0/0xa0
[  291.221898]  kernfs_fop_write+0x155/0x250
[  291.225936]  __vfs_write+0x50/0xa0
[  291.229364]  vfs_write+0x10b/0x290
[  291.232790]  ksys_write+0xcc/0x170
[  291.236405]  ? __x64_sys_read+0x50/0x50
[  291.240270]  ? do_syscall_64+0x79/0xaf0
[  291.244132]  ? do_syscall_64+0x79/0xaf0
[  291.247998]  __x64_sys_write+0x43/0x50
[  291.251776]  do_syscall_64+0xcc/0xaf0
[  291.255464]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[  291.260396]  ? syscall_return_slowpath+0x580/0x580
[  291.265223]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xb3
[  291.270491]  ? trace_hardirqs_off_caller+0x3a/0x150
[  291.275400]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  291.280137]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[  291.285443] RIP: 0033:0x7f2c0d9adb28
[  291.289046] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 =
00 f3 0f 1e fa 48 8d 05 35 4b 2d 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f =
05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4 55
[  291.307931] RSP: 002b:00007ffccc6e3898 EFLAGS: 00000246 ORIG_RAX: =
0000000000000001
[  291.315804] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: =
00007f2c0d9adb28
[  291.322985] RDX: 0000000000000002 RSI: 000055d97c790de0 RDI: =
0000000000000001
[  291.330164] RBP: 000055d97c790de0 R08: 000000000000000a R09: =
00007f2c0da3ec80
[  291.337537] R10: 000000000000000a R11: 0000000000000246 R12: =
00007f2c0dc7e6c0
[  291.344718] R13: 0000000000000002 R14: 00007f2c0dc79880 R15: =
0000000000000002


>=20
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
> mm/slub.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++--------
> 1 file changed, 48 insertions(+), 8 deletions(-)
>=20
> diff --git a/mm/slub.c b/mm/slub.c
> index 183ccc364ccf..255981180489 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5567,13 +5567,30 @@ static ssize_t slab_attr_store(struct kobject =
*kobj,
> 		return -EIO;
>=20
> 	err =3D attribute->store(s, buf, len);
> -#ifdef CONFIG_MEMCG
> -	if (slab_state >=3D FULL && err >=3D 0 && is_root_cache(s)) {
> -		struct kmem_cache *c;
> +#ifdef CONFIG_MEMCG_KMEM
> +	if (slab_state >=3D FULL && err >=3D 0 && is_root_cache(s) &&
> +	    !list_empty(&s->memcg_params.children)) {
> +		struct kmem_cache *c, **pcaches;
> +		int idx, max, cnt =3D 0;
> +		size_t size =3D s->max_attr_size;
> +		struct memcg_cache_array *arr;
> +
> +		/*
> +		 * Make atomic update to s->max_attr_size.
> +		 */
> +		do {
> +			if (len <=3D size)
> +				break;
> +		} while (!try_cmpxchg(&s->max_attr_size, &size, len));
>=20
> -		mutex_lock(&slab_mutex);
> -		if (s->max_attr_size < len)
> -			s->max_attr_size =3D len;
> +		memcg_get_cache_ids();
> +		max =3D memcg_nr_cache_ids;
> +
> +		pcaches =3D kmalloc_array(max, sizeof(void *), =
GFP_KERNEL);
> +		if (!pcaches) {
> +			memcg_put_cache_ids();
> +			return -ENOMEM;
> +		}
>=20
> 		/*
> 		 * This is a best effort propagation, so this function's =
return
> @@ -5591,10 +5608,33 @@ static ssize_t slab_attr_store(struct kobject =
*kobj,
> 		 * has well defined semantics. The cache being written =
to
> 		 * directly either failed or succeeded, in which case we =
loop
> 		 * through the descendants with best-effort propagation.
> +		 *
> +		 * To avoid potential circular lock dependency problems, =
we
> +		 * just get a reference and store child cache pointers =
while
> +		 * holding the memcg_cache_ids_sem read lock. The store
> +		 * method is then called for each child cache after =
releasing
> +		 * the lock. Code sequence partly borrowed from
> +		 * memcg_kmem_get_cache().
> 		 */
> -		for_each_memcg_cache(c, s)
> +		rcu_read_lock();
> +		arr =3D rcu_dereference(s->memcg_params.memcg_caches);
> +		for (idx =3D 0; idx < max; idx++) {
> +			c =3D READ_ONCE(arr->entries[idx]);
> +			if (!c)
> +				continue;
> +			if (!percpu_ref_tryget(&c->memcg_params.refcnt))
> +				continue;
> +			pcaches[cnt++] =3D c;
> +		}
> +		rcu_read_unlock();
> +		memcg_put_cache_ids();
> +
> +		for (idx =3D 0; idx < cnt; idx++) {
> +			c =3D pcaches[idx];
> 			attribute->store(c, buf, len);
> -		mutex_unlock(&slab_mutex);
> +			percpu_ref_put(&c->memcg_params.refcnt);
> +		}
> +		kfree(pcaches);
> 	}
> #endif
> 	return err;
> --=20
> 2.18.1
>=20
>=20

