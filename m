Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CE2C2BBC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 22:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8496620663
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 22:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="fCDpK/7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389420AbgDMWG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 18:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389421AbgDMWGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 18:06:25 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F82C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 15:06:25 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id x66so11217310qkd.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 15:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mAW0Z9iy5jXuQEUQ85fFt5Phw6cZ235LzZx+czNX0W8=;
        b=fCDpK/7IpFWuk90gDq037a3Qr8kgQJPuy+ycX/T+BmcDIgFKaDLN/3uiBgwhtLl0aU
         XmDai1ltBXL6flbgcHICARZ6DEoek38JcWJzdyLjbBR61gjTBqWJxNflq5RGox++UCXg
         DkKsA7YqS8nYz759FVM4a3emifiYebqfueY43RjksbsWiqISK5hl3YWkQZEic4KdC+N1
         uBZmZ5p6wAOeWKODfTO58AAcdvXyECuPDT21DqpbD0ZP2+X5AODJ/7fp2TOJj6ds3cH7
         xvsQE8R9Rpo7giHO4TcYmMWBD+I66iXSO0olabR386mG7MQCuYNgeDu0gWVhNwEUthrb
         Z/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mAW0Z9iy5jXuQEUQ85fFt5Phw6cZ235LzZx+czNX0W8=;
        b=lAnqKEhAulddBJQsT99vTJKdIziPyTI5J/quM6zx7tgYcIm9b235gZegVM9ceLZRz2
         XgxhnLaOWeLWw8f26g5/6LDlJEeDex8wXtQ5UXjOqXjzMw9de1GLLjlooWADekG5LYX9
         pnc+vjH+pIeIH/6PNB9Kpjjv4wULHwCMoQQ6EmJw4buZzPrq4PIekb4tlSKPfD8Ub6g/
         dGhRdogF1wXI9phF1/1N0FjmQmpG/dSCbv8TviLV0XY3QKP3tiUVNJRLINH69Km6ttiX
         tlfcjU10+/Wru4T0PLM9JoGMtlosJI8AeRwu4q47TRiGdrPh13VRh9PzzSjv6Dl/pZLg
         5e0w==
X-Gm-Message-State: AGi0PubrGydbfYUovcPCfqV1gfdylchPVq5BRH3d/Ct2s1sa24TGzmu7
        jd9w4orncoOYyRB9krD4ZQnx5T/GPh7siA==
X-Google-Smtp-Source: APiQypJ3fYEQHAc9fPVsuemrbblAMZDgJ/dqgk67+7/YyzmKDs63K3MGdD31C1cDMHa/GvY0btxtWQ==
X-Received: by 2002:a37:7846:: with SMTP id t67mr17694923qkc.77.1586815583945;
        Mon, 13 Apr 2020 15:06:23 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 63sm3880719qkl.64.2020.04.13.15.06.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2020 15:06:23 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200410092951.6db32bfe@canb.auug.org.au>
Date:   Mon, 13 Apr 2020 18:06:21 -0400
Cc:     Dmitry Vyukov <dvyukov@google.com>, Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7325374A-6072-44E4-85EE-F97FC7E8565F@lca.pw>
References: <20200408014010.80428-1-peterx@redhat.com>
 <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
 <CACT4Y+bhQVcpSkSh_OZ5ZanfFZUqn2iypLhG_Z-nWKTkaYr1jw@mail.gmail.com>
 <CAHk-=wgjGgfUfVm_DpTay5TS03pLCgUWqRpQS++90fSE2V-e=g@mail.gmail.com>
 <20200410092951.6db32bfe@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 9, 2020, at 7:29 PM, Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Hi Linus,
>=20
> On Thu, 9 Apr 2020 09:32:32 -0700 Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>>=20
>> On Thu, Apr 9, 2020 at 5:55 AM Dmitry Vyukov <dvyukov@google.com> =
wrote:
>>>=20
>>> linux-next is boot-broken for more than a month and bugs are piling
>>> onto bugs, I've seen at least 3 different ones.
>>> syzbot can't get any working linux-next build for testing for a very
>>> long time now. =20
>>=20
>> Ouch.
>>=20
>> Ok, that's not good. It means that linux-next has basically only done
>> build-testing this whole cycle.
>=20
> Well, there are other CI's beyond syzbot .. Does syzbot only =
build/test
> a single kernel arch/config?
>=20
>> Stephen, Dmitry - is there some way linux-next could possibly kick =
out
>> trees more aggressively if syzbot can't even boot?
>=20
> Of course that could be done if I knew that there were problems.  From
> memory and my mail archives, I was only cc'd on 3 problems by sysbot
> since last November and they were all responded to by the appropriate
> maintainers/developers.
>=20
> Currently, when I am cc'd on reports, if they are also sent to who
> seem like the appropriate people, I just file the report assuming it
> will be dealt with.
>=20
>> Kicking trees out of linux-next and making noise if they cause syzbot
>> failures might also make some maintainers react more..
>=20
> That may be true, but in some cases I have carried =
fixups/reverts/older
> versions of trees for quite some time before things get fixed.  But at
> least if that happens, I do tend to remind people.

BTW, I=E2=80=99ll be adding fuzzers to my daily linux-next routines =
where it triggers this
io_uring/scheduler bug almost immediately, so hopefully would buy syzbot =
some
time to resume on linux-next.

[67493.516737][T211750] BUG: unable to handle page fault for address: =
ffffffffffffffe8
[67493.557315][T211750] #PF: supervisor read access in kernel mode
[67493.586726][T211750] #PF: error_code(0x0000) - not-present page
[67493.614434][T211750] PGD f96e17067 P4D f96e17067 PUD f96e19067 PMD 0=20=

[67493.644846][T211750] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
[67493.674127][T211750] CPU: 55 PID: 211750 Comm: trinity-c127 Tainted: =
G    B        L    5.7.0-rc1-next-20200413 #4
[67493.722516][T211750] Hardware name: HP ProLiant DL380 Gen9/ProLiant =
DL380 Gen9, BIOS P89 04/12/2017
[67493.764925][T211750] RIP: 0010:__wake_up_common+0x98/0x290
__wake_up_common at kernel/sched/wait.c:87
[67493.790675][T211750] Code: 40 4d 8d 78 e8 49 8d 7f 18 49 39 fd 0f 84 =
80 00 00 00 e8 6b bd 2b 00 49 8b 5f 18 45 31 e4 48 83 eb 18 4c 89 ff e8 =
08 bc 2b 00 <45> 8b 37 41 f6 c6 04 75 71 49 8d 7f 10 e8 46 bd 2b 00 49 =
8b 47 10
[67493.881650][T211750] RSP: 0018:ffffc9000adbfaf0 EFLAGS: 00010046
[67493.909854][T211750] RAX: 0000000000000000 RBX: ffffffffffffffe8 RCX: =
ffffffffaa9636b8
[67493.947131][T211750] RDX: 0000000000000003 RSI: dffffc0000000000 RDI: =
ffffffffffffffe8
[67493.983829][T211750] RBP: ffffc9000adbfb40 R08: fffffbfff582c5fd R09: =
fffffbfff582c5fd
[67494.020861][T211750] R10: ffffffffac162fe3 R11: fffffbfff582c5fc R12: =
0000000000000000
[67494.059249][T211750] R13: ffff888ef82b0960 R14: ffffc9000adbfb80 R15: =
ffffffffffffffe8
[67494.099699][T211750] FS:  00007fdcba4c4740(0000) =
GS:ffff889033780000(0000) knlGS:0000000000000000
[67494.141858][T211750] CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033
[67494.172660][T211750] CR2: ffffffffffffffe8 CR3: 0000000f776a0004 CR4: =
00000000001606e0
[67494.209760][T211750] Call Trace:
[67494.224720][T211750]  __wake_up_common_lock+0xea/0x150
(inlined by) __wake_up_common_lock at kernel/sched/wait.c:124
[67494.248753][T211750]  ? __wake_up_common+0x290/0x290
[67494.272014][T211750]  ? lockdep_hardirqs_on+0x16/0x2c0
[67494.296139][T211750]  __wake_up+0x13/0x20
[67494.314946][T211750]  io_cqring_ev_posted+0x75/0xe0
(inlined by) io_cqring_ev_posted at fs/io_uring.c:1160
[67494.337726][T211750]  io_ring_ctx_wait_and_kill+0x1c0/0x2f0
io_ring_ctx_wait_and_kill at fs/io_uring.c:7305
[67494.363840][T211750]  io_uring_create+0xa8d/0x13b0
[67494.386526][T211750]  ? io_req_defer_prep+0x990/0x990
[67494.410119][T211750]  ? __kasan_check_write+0x14/0x20
[67494.433646][T211750]  io_uring_setup+0xb8/0x130
[67494.454870][T211750]  ? io_uring_create+0x13b0/0x13b0
[67494.478342][T211750]  ? check_flags.part.28+0x220/0x220
[67494.502947][T211750]  ? lockdep_hardirqs_on+0x16/0x2c0
[67494.526965][T211750]  __x64_sys_io_uring_setup+0x31/0x40
[67494.551820][T211750]  do_syscall_64+0xcc/0xaf0
[67494.574829][T211750]  ? syscall_return_slowpath+0x580/0x580
[67494.604591][T211750]  ? lockdep_hardirqs_off+0x1f/0x140
[67494.628901][T211750]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xb3
[67494.657616][T211750]  ? trace_hardirqs_off_caller+0x3a/0x150
[67494.683999][T211750]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[67494.709982][T211750]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[67494.737167][T211750] RIP: 0033:0x7fdcb9dd76ed
[67494.757698][T211750] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 =
0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c =
24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6b 57 2c 00 f7 d8 64 =
89 01 48
[67494.849485][T211750] RSP: 002b:00007ffe7fd4e4f8 EFLAGS: 00000246 =
ORIG_RAX: 00000000000001a9
[67494.887906][T211750] RAX: ffffffffffffffda RBX: 00000000000001a9 RCX: =
00007fdcb9dd76ed
[67494.924754][T211750] RDX: fffffffffffffffc RSI: 0000000000000000 RDI: =
0000000000005d54
[67494.961516][T211750] RBP: 00000000000001a9 R08: 0000000e31d3caa7 R09: =
0082400004004000
[67494.998485][T211750] R10: ffffffffffffffff R11: 0000000000000246 R12: =
0000000000000002
[67495.035510][T211750] R13: 00007fdcb842e058 R14: 00007fdcba4c46c0 R15: =
00007fdcb842e000
[67495.072679][T211750] Modules linked in: bridge stp llc nfnetlink cn =
brd vfat fat ext4 crc16 mbcache jbd2 loop kvm_intel kvm irqbypass =
intel_cstate intel_uncore dax_pmem intel_rapl_perf dax_pmem_core =
ip_tables x_tables xfs sd_mod tg3 firmware_class libphy hpsa =
scsi_transport_sas dm_mirror dm_region_hash dm_log dm_mod [last =
unloaded: binfmt_misc]
[67495.221120][T211750] CR2: ffffffffffffffe8
[67495.240237][T211750] ---[ end trace f9502383d57e0e22 ]---
[67495.265301][T211750] RIP: 0010:__wake_up_common+0x98/0x290
[67495.290903][T211750] Code: 40 4d 8d 78 e8 49 8d 7f 18 49 39 fd 0f 84 =
80 00 00 00 e8 6b bd 2b 00 49 8b 5f 18 45 31 e4 48 83 eb 18 4c 89 ff e8 =
08 bc 2b 00 <45> 8b 37 41 f6 c6 04 75 71 49 8d 7f 10 e8 46 bd 2b 00 49 =
8b 47 10
[67495.382302][T211750] RSP: 0018:ffffc9000adbfaf0 EFLAGS: 00010046
[67495.410551][T211750] RAX: 0000000000000000 RBX: ffffffffffffffe8 RCX: =
ffffffffaa9636b8
[67495.447570][T211750] RDX: 0000000000000003 RSI: dffffc0000000000 RDI: =
ffffffffffffffe8
[67495.484252][T211750] RBP: ffffc9000adbfb40 R08: fffffbfff582c5fd R09: =
fffffbfff582c5fd
[67495.521068][T211750] R10: ffffffffac162fe3 R11: fffffbfff582c5fc R12: =
0000000000000000
[67495.557461][T211750] R13: ffff888ef82b0960 R14: ffffc9000adbfb80 R15: =
ffffffffffffffe8
[67495.594607][T211750] FS:  00007fdcba4c4740(0000) =
GS:ffff889033780000(0000) knlGS:0000000000000000
[67495.639332][T211750] CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033
[67495.669033][T211750] CR2: ffffffffffffffe8 CR3: 0000000f776a0004 CR4: =
00000000001606e0
[67495.704569][T211750] Kernel panic - not syncing: Fatal exception
[67495.731758][T211750] Kernel Offset: 0x29800000 from =
0xffffffff81000000 (relocation range: =
0xffffffff80000000-0xffffffffbfffffff)
[67495.784988][T211750] ---[ end Kernel panic - not syncing: Fatal =
exception ]=E2=80=94

Also, I=E2=80=99ll need to deal with this slub sysfs and memcg lockdep =
splat first, so lockdep would still be functioning during the fuzzing.

[ 8137.254287][T53013] WARNING: possible circular locking dependency =
detected
[ 8137.261231][T53013] 5.7.0-rc1-next-20200413+ #2 Not tainted
[ 8137.266981][T53013] =
------------------------------------------------------
[ 8137.274016][T53013] trinity-c10/53013 is trying to acquire lock:
[ 8137.280127][T53013] ffffffff89ad2968 (slab_mutex){+.+.}-{3:3}, at: =
slab_attr_store+0x79/0xf0
[ 8137.288660][T53013]=20
[ 8137.288660][T53013] but task is already holding lock:
[ 8137.295944][T53013] ffff9ea421940dd8 (kn->count#88){++++}-{0:0}, at: =
kernfs_fop_write+0x10e/0x280
[ 8137.305004][T53013]=20
[ 8137.305004][T53013] which lock already depends on the new lock.
[ 8137.305004][T53013]=20
[ 8137.315347][T53013]=20
[ 8137.315347][T53013] the existing dependency chain (in reverse order) =
is:
[ 8137.324470][T53013]=20
[ 8137.324470][T53013] -> #1 (kn->count#88){++++}-{0:0}:
[ 8137.331774][T53013]        __kernfs_remove+0x3bb/0x420
[ 8137.336977][T53013]        kernfs_remove+0x2c/0x40
[ 8137.341829][T53013]        sysfs_remove_dir+0x7e/0x90
[ 8137.346988][T53013]        kobject_del+0x60/0xb0
[ 8137.351663][T53013]        sysfs_slab_unlink+0x1c/0x20
[ 8137.356853][T53013]        shutdown_cache+0x155/0x1c0
[ 8137.361958][T53013]        kmemcg_cache_shutdown_fn+0xe/0x20
[ 8137.367756][T53013]        kmemcg_workfn+0x35/0x50
[ 8137.372705][T53013]        process_one_work+0x560/0xba0
[ 8137.377985][T53013]        worker_thread+0x80/0x5f0
[ 8137.382920][T53013]        kthread+0x1db/0x200
[ 8137.387467][T53013]        ret_from_fork+0x27/0x50
[ 8137.392296][T53013]=20
[ 8137.392296][T53013] -> #0 (slab_mutex){+.+.}-{3:3}:
[ 8137.399587][T53013]        __lock_acquire+0x1673/0x23a0
[ 8137.404865][T53013]        lock_acquire+0xcd/0x410
[ 8137.409710][T53013]        __mutex_lock+0xc9/0xbf0
[ 8137.414561][T53013]        mutex_lock_nested+0x31/0x40
[ 8137.419823][T53013]        slab_attr_store+0x79/0xf0
[ 8137.424991][T53013]        sysfs_kf_write+0x9a/0xb0
[ 8137.429919][T53013]        kernfs_fop_write+0x15e/0x280
[ 8137.435272][T53013]        do_iter_write+0x261/0x2c0
[ 8137.440291][T53013]        vfs_writev+0xe6/0x170
[ 8137.444995][T53013]        do_pwritev+0xab/0xd0
[ 8137.449731][T53013]        __x64_sys_pwritev+0x61/0x80
[ 8137.455079][T53013]        do_syscall_64+0x91/0xb10
[ 8137.460010][T53013]        entry_SYSCALL_64_after_hwframe+0x49/0xb3
[ 8137.466330][T53013]=20
[ 8137.466330][T53013] other info that might help us debug this:
[ 8137.466330][T53013]=20
[ 8137.476695][T53013]  Possible unsafe locking scenario:
[ 8137.476695][T53013]=20
[ 8137.484067][T53013]        CPU0                    CPU1
[ 8137.489337][T53013]        ----                    ----
[ 8137.494609][T53013]   lock(kn->count#88);
[ 8137.498718][T53013]                                lock(slab_mutex);
[ 8137.505130][T53013]                                =
lock(kn->count#88);
[ 8137.511718][T53013]   lock(slab_mutex);
[ 8137.515594][T53013]=20
[ 8137.515594][T53013]  *** DEADLOCK ***
[ 8137.515594][T53013]=20
[ 8137.523780][T53013] 3 locks held by trinity-c10/53013:
[ 8137.528967][T53013]  #0: ffff9ea42c841430 (sb_writers#3){.+.+}-{0:0}, =
at: vfs_writev+0x13f/0x170
[ 8137.537847][T53013]  #1: ffff9ea3c2c9c288 (&of->mutex){+.+.}-{3:3}, =
at: kernfs_fop_write+0xfe/0x280
[ 8137.547149][T53013]  #2: ffff9ea421940dd8 (kn->count#88){++++}-{0:0}, =
at: kernfs_fop_write+0x10e/0x280
[ 8137.556554][T53013]=20
[ 8137.556554][T53013] stack backtrace:
[ 8137.562360][T53013] CPU: 22 PID: 53013 Comm: trinity-c10 Not tainted =
5.7.0-rc1-next-20200413+ #2
[ 8137.571216][T53013] Hardware name: HPE ProLiant DL385 Gen10/ProLiant =
DL385 Gen10, BIOS A40 03/09/2018
[ 8137.580670][T53013] Call Trace:
[ 8137.583865][T53013]  dump_stack+0xa4/0x100
[ 8137.588105][T53013]  print_circular_bug.cold.49+0x13c/0x141
[ 8137.593746][T53013]  check_noncircular+0x183/0x1a0
[ 8137.598818][T53013]  ? do_raw_spin_unlock+0x10b/0x1c0
[ 8137.603971][T53013]  __lock_acquire+0x1673/0x23a0
[ 8137.608732][T53013]  ? print_unreferenced+0x224/0x230
[ 8137.613846][T53013]  lock_acquire+0xcd/0x410
[ 8137.618169][T53013]  ? slab_attr_store+0x79/0xf0
[ 8137.619804][T52801] VFS: "mand" mount option not supported
[ 8137.623085][T53013]  __mutex_lock+0xc9/0xbf0
[ 8137.632939][T53013]  ? slab_attr_store+0x79/0xf0
[ 8137.637679][T53013]  ? _find_next_bit.constprop.1+0xd0/0x100
[ 8137.643477][T53013]  ? slab_attr_store+0x79/0xf0
[ 8137.648252][T53013]  ? find_next_bit+0x36/0x40
[ 8137.652748][T53013]  ? cpumask_next+0x46/0x60
[ 8137.657155][T53013]  mutex_lock_nested+0x31/0x40
[ 8137.661897][T53013]  ? slab_attr_show+0x30/0x30
[ 8137.666476][T53013]  ? mutex_lock_nested+0x31/0x40
[ 8137.671373][T53013]  slab_attr_store+0x79/0xf0
[ 8137.676035][T53013]  ? slab_attr_show+0x30/0x30
[ 8137.680672][T53013]  sysfs_kf_write+0x9a/0xb0
[ 8137.685085][T53013]  ? sysfs_file_ops+0xb0/0xb0
[ 8137.689673][T53013]  kernfs_fop_write+0x15e/0x280
[ 8137.694433][T53013]  do_iter_write+0x261/0x2c0
[ 8137.698997][T53013]  vfs_writev+0xe6/0x170
[ 8137.703142][T53013]  ? lock_acquire+0xcd/0x410
[ 8137.707696][T53013]  ? find_held_lock+0x35/0xa0
[ 8137.712279][T53013]  ? __fget_light+0xa3/0x170
[ 8137.716897][T53013]  do_pwritev+0xab/0xd0
[ 8137.720960][T53013]  __x64_sys_pwritev+0x61/0x80
[ 8137.725808][T53013]  do_syscall_64+0x91/0xb10
[ 8137.730274][T53013]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[ 8137.735733][T53013]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[ 8137.741588][T53013] RIP: 0033:0x7f54d0a386ed=
