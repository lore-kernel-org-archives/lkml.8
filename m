Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAB7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F95F206CB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oKdP/QzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbgGAMcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729959AbgGAMcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:32:08 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A319C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 05:32:07 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id s16so8010104lfp.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NNALhDDhs2zNr8vMR3T3YJfxy589wb+SYPODplCHBog=;
        b=oKdP/QzPyZA2Osej5f3ph3PurNb0VHX+NYlqJU5U3tY0ETNLq3thi+yf3W7xEOwwEh
         EeDwF5/PykCa0Vgy/8wMNGhw+dJrLp7kP9mouFoYHlmvpxiaPzjxadpaXOdgepvGh2i0
         yNJIIbpAo+wjXMqWh9Hoc6vpn39Dxch83kmnTMETL0KcGvvZ2WFMo09h4LDV1H35RFDw
         Lv4KWvaKoeu/2JaJjmCoudCJZ+opGGBsvWJnRw1ylZbYJ40u+f/LcCE952fjED0GpEcY
         ZEW5OE7KzO+7GXYc3ist4dGkhQKVxq4rd2CeZpTs/qmXgQscnj//WwPCTxUnekVew9RH
         dVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NNALhDDhs2zNr8vMR3T3YJfxy589wb+SYPODplCHBog=;
        b=b6IobhPFYqMLH11MbSepmfCESiVqLiwHTZgmB46uL7JjrVcdI/1AIYwI4V0/4YvVmL
         nt79KHHs5k/qhiFCh/3eH7v8iAyNkLDG+1VQ/DF/JJDlj2/6g3u6dXZ1uEeXWukS0OKd
         4CcEYsB4YL4XuXzGQijxaxg4GKRrmcBZdTMM+YrGtbEhH8avJAwKPBGPXOfXLaS7Fplc
         eBRESNVvRVbNkRjbyx9GEmxGi6smtVu7MdkEeWSESPCQvwx08dIb05lEU+RNRBzrJynk
         WjkuwgqC3QDx2HkbpdTp0zc3xFxsk5uyAjajmGOoF89FYafQ0W37+LqV/3NrRcWWut9M
         UuMw==
X-Gm-Message-State: AOAM531g4TgxzwxKy0V6NegzlN7I92+skgHgUbd8fdpssqesXhWOWh7o
        MAS8iyNJ4Jy3lDyONqlHt1XsEBNzGmHVMl8NJGhivXcNgu/DyQ==
X-Google-Smtp-Source: ABdhPJwFQh2NfRYklZgxCl1sJWtgiPaMZUKKVsQOU9rm/kcNixx/R/omjUlgPihgugtLZVAY353tO4L9C1585Ws+N+c=
X-Received: by 2002:a19:4285:: with SMTP id p127mr14252202lfa.74.1593606724713;
 Wed, 01 Jul 2020 05:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYs=3UG3k-2trqQuB-gJh9D1YygkNQ4qWiHtcaRMSWTmrQ@mail.gmail.com>
 <20200701082904.GM2369@dhcp22.suse.cz>
In-Reply-To: <20200701082904.GM2369@dhcp22.suse.cz>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 1 Jul 2020 18:01:52 +0530
Message-ID: <CA+G9fYsOsq9rQf5b73DrKp5Q_CacFXF0x0mq_tWpqmJ5QW8vQQ@mail.gmail.com>
Subject: Re: BUG: Bad page state in process - page dumped because: page still
 charged to cgroup
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>, lkft-triage@lists.linaro.org,
        Chris Down <chris@chrisdown.name>, Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020 at 13:59, Michal Hocko <mhocko@kernel.org> wrote:
>
> Smells like a different observable problem with the same/similar culprit
> as http://lkml.kernel.org/r/CA+G9fYtrgF_EZHi0vi+HyWiXT5LGggDhVXtNspc=OzzFhL=xRQ@mail.gmail.com

Before I start bisecting here I am sharing more details of the problem.

>
> On Wed 01-07-20 13:48:57, Naresh Kamboju wrote:
> > While running LTP mm test suite on x86_64 device the BUG: Bad page
> > state in process
> > noticed on linux-next 20200630 tag.

Bad: next-20200621
Good: next-20200618

> >
> > Steps to reproduce:
> > - boot linux-next 20200630 kernel on x86_64 device
> > - cd /opt/ltp
> > - ./runltp -f mm
> >
> > metadata:
> >   git branch: master
> >   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> >   git commit: f2b92b14533e646e434523abdbafddb727c23898
> >   git describe: next-20200630
> >   kernel-config:
> > https://builds.tuxbuild.com/j60yrp7CUpq3LCmqMB8Wdg/kernel.config
> >
> > Test crash dump:
<trim>
> > [  804.293956] [   3261]     0  3261  4726385  3349389 26939392
> > 0             0 oom01
> > [  804.302129] [   3265]     0  3265     3187       33    73728
> > 0             0 agetty
> > [  804.310397] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/,task=oom01,pid=3261,uid=0
> > [  804.322751] Out of memory: Killed process 3261 (oom01)
> > total-vm:18905540kB, anon-rss:13397556kB, file-rss:0kB, shmem-rss:0kB,
> > UID:0 pgtables:26308kB oom_score_adj:0
> > [  806.652952] oom_reaper: reaped process 3261 (oom01), now
> > anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
> > [  807.579373] BUG: Bad page state in process kworker/u8:12  pfn:374308
> > [  807.579521] BUG: Bad page state in process kworker/u8:13  pfn:4182a4

[  858.236961] ------------[ cut here ]------------
[  858.236963] WARNING: CPU: 1 PID: 5526 at mm/page_counter.c:57
page_counter_cancel+0x3e/0x50
[  858.236963] Modules linked in: x86_pkg_temp_thermal
[  858.236965] CPU: 1 PID: 5526 Comm: (agetty) Tainted: G    B D
    5.8.0-rc1-next-20200621 #1
[  858.236966] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[  858.236967] RIP: 0010:page_counter_cancel+0x3e/0x50
[  858.236969] Code: 6e fe ff 48 89 d8 48 f7 d8 f0 49 0f c1 04 24 48
29 d8 4c 89 e7 48 89 c3 48 89 c6 e8 8c fe ff ff 48 85 db 78 05 5b 41
5c 5d c3 <0f> 0b 5b 41 5c 5d c3 66 66 2e 0f 1f 84 00 00 00 00 00 48 85
ff 74
[  858.236970] RSP: 0018:ffff888226ba7728 EFLAGS: 00010286
[  858.236971] RAX: 0000000000000000 RBX: ffffffffffffffff RCX: ffffffff936f547f
[  858.236972] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: ffff88822fb51601
[  858.236973] RBP: ffff888226ba7738 R08: 1ffff11045f6a2c0 R09: ffffed1045f6a2bd
[  858.236974] R10: ffff88822fb515e0 R11: ffffed1045f6a2bc R12: ffff88822fb515d9
[  858.236975] R13: ffff888226ba7808 R14: 0000000000000000 R15: ffff888226ba7800
[  858.236976] FS:  0000000000000000(0000) GS:ffff888230880000(0000)
knlGS:0000000000000000
[  858.236976] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  858.236977] CR2: 000055a355aff1e8 CR3: 0000000223e8c001 CR4: 00000000003606e0
[  858.236978] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  858.236979] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  858.236979] Call Trace:
[  858.236980]  page_counter_uncharge+0x1d/0x40
[  858.236981]  uncharge_batch+0x126/0x180
[  858.236981]  uncharge_page+0x48/0x190
[  858.236982]  mem_cgroup_uncharge_list+0xd8/0x130
[  858.236983]  ? mem_cgroup_uncharge+0x100/0x100
[  858.236983]  ? _raw_write_lock_irqsave+0xd0/0xd0
[  858.236984]  release_pages+0x56c/0x670
[  858.236984]  ? __put_compound_page+0x50/0x50
[  858.236985]  ? lru_add_drain_cpu+0xce/0x1d0
[  858.236986]  free_pages_and_swap_cache+0x134/0x150
[  858.236986]  tlb_batch_pages_flush+0x25/0x70
[  858.236987]  tlb_finish_mmu+0x68/0x3e0
[  858.236988]  exit_mmap+0x158/0x2b0
[  858.236988]  ? do_munmap+0x10/0x10
[  858.236989]  ? __kasan_check_write+0x14/0x20
[  858.236989]  ? mutex_unlock+0x1d/0x40
[  858.236990]  mmput+0xaf/0x200
[  858.236991]  begin_new_exec+0x737/0x11e7
[  858.236991]  load_elf_binary+0x4c3/0x23a4
[  858.236992]  ? fsnotify+0x5c6/0x5f0
[  858.236992]  ? fsnotify+0x5f0/0x5f0
[  858.236993]  ? __fsnotify_update_child_dentry_flags.part.0+0x180/0x180
[  858.236994]  ? elf_map+0x190/0x190
[  858.236994]  ? __kasan_check_write+0x14/0x20
[  858.236995]  ? load_misc_binary+0x118/0x490
[  858.236996]  __do_execve_file.isra.0+0xa39/0x1240
[  858.236996]  ? open_exec+0x50/0x50
[  858.236997]  ? __kasan_check_write+0x14/0x20
[  858.236997]  ? strncpy_from_user+0xb7/0x1c0
[  858.236998]  ? getname_flags+0x11b/0x2a0
[  858.236999]  __x64_sys_execve+0x54/0x70
[  858.236999]  do_syscall_64+0x43/0x70
[  858.237000]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  858.237001] RIP: 0033:0x7f35029a1877
[  858.237001] Code: Bad RIP value.
[  858.237002] RSP: 002b:00007fff0a4b9fd8 EFLAGS: 00000246 ORIG_RAX:
000000000000003b
[  858.237003] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f35029a1877
[  858.237004] RDX: 000055a355b6b3f0 RSI: 000055a355b46510 RDI: 000055a355ae64d0
[  858.237005] RBP: 00007fff0a4ba280 R08: 0000000000000003 R09: 0000000000000000
[  858.237006] R10: 000055a355acae70 R11: 0000000000000246 R12: 000055a355ac7d18
[  858.237007] R13: 000055a355b46510 R14: 000055a355ac7e08 R15: 000055a355ac7980
[  858.237008] ---[ end trace 0d1e8dbfcac2ad5c ]---
[  858.562327] general protection fault, probably for non-canonical
address 0x80ff880ab2b281ee: 0000 [#2] SMP KASAN PTI
[  858.572850] CPU: 1 PID: 5526 Comm: (agetty) Tainted: G    B D W
    5.8.0-rc1-next-20200621 #1
[  858.581800] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[  858.589193] RIP: 0010:__count_memcg_events+0x38/0x100
[  858.594246] Code: 55 49 89 fd 41 54 41 89 f4 53 48 89 d3 48 83 ec
10 4c 8d b7 18 05 00 00 4c 89 f7 e8 52 1d fe ff 44 89 e6 49 8b 85 18
05 00 00 <65> 48 8b 94 f0 28 01 00 00 48 01 d3 4c 8d 3c f5 28 01 00 00
48 83
[  858.612989] RSP: 0018:ffff888226ba7720 EFLAGS: 00010046
[  858.618209] RAX: 80ffff88822a81e6 RBX: 0000000000000001 RCX: ffffffff936fcaae
[  858.625340] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff88822fb51919
[  858.632464] RBP: ffff888226ba7758 R08: 1ffff11045f6a323 R09: ffffed1045f6a2bd
[  858.639590] R10: ffff88822fb515e0 R11: ffffed1045f6a2bc R12: 0000000000000001
[  858.646721] R13: ffff88822fb51401 R14: ffff88822fb51919 R15: ffff888226ba7800
[  858.653881] FS:  0000000000000000(0000) GS:ffff888230880000(0000)
knlGS:0000000000000000
[  858.661965] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  858.667703] CR2: 000055a355aff1e8 CR3: 0000000223e8c001 CR4: 00000000003606e0
[  858.674826] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  858.681950] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  858.689074] Call Trace:
[  858.691520]  uncharge_batch+0x9c/0x180
[  858.695270]  uncharge_page+0x48/0x190
[  858.698930]  mem_cgroup_uncharge_list+0xd8/0x130
[  858.703548]  ? mem_cgroup_uncharge+0x100/0x100
[  858.707994]  ? _raw_write_lock_irqsave+0xd0/0xd0
[  858.712613]  release_pages+0x56c/0x670
[  858.716367]  ? __put_compound_page+0x50/0x50
[  858.720640]  ? lru_add_drain_cpu+0xce/0x1d0
[  858.724824]  free_pages_and_swap_cache+0x134/0x150
[  858.729609]  tlb_batch_pages_flush+0x25/0x70
[  858.733881]  tlb_finish_mmu+0x68/0x3e0
[  858.737634]  exit_mmap+0x158/0x2b0
[  858.741039]  ? do_munmap+0x10/0x10
[  858.744438]  ? __kasan_check_write+0x14/0x20
[  858.748710]  ? mutex_unlock+0x1d/0x40
[  858.752376]  mmput+0xaf/0x200
[  858.755347]  begin_new_exec+0x737/0x11e7
[  858.759267]  load_elf_binary+0x4c3/0x23a4
[  858.763278]  ? fsnotify+0x5c6/0x5f0
[  858.766783]  ? fsnotify+0x5f0/0x5f0
[  858.770282]  ? __fsnotify_update_child_dentry_flags.part.0+0x180/0x180
[  858.776806]  ? elf_map+0x190/0x190
[  858.780211]  ? __kasan_check_write+0x14/0x20
[  858.784477]  ? load_misc_binary+0x118/0x490
[  858.788662]  __do_execve_file.isra.0+0xa39/0x1240
[  858.793361]  ? open_exec+0x50/0x50
[  858.796778]  ? __kasan_check_write+0x14/0x20
[  858.801054]  ? strncpy_from_user+0xb7/0x1c0
[  858.805232]  ? getname_flags+0x11b/0x2a0
[  858.809149]  __x64_sys_execve+0x54/0x70
[  858.812980]  do_syscall_64+0x43/0x70
[  858.816551]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  858.821596] RIP: 0033:0x7f35029a1877
[  858.825173] Code: Bad RIP value.
[  858.828397] RSP: 002b:00007fff0a4b9fd8 EFLAGS: 00000246 ORIG_RAX:
000000000000003b
[  858.835955] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f35029a1877
[  858.843087] RDX: 000055a355b6b3f0 RSI: 000055a355b46510 RDI: 000055a355ae64d0
[  858.850210] RBP: 00007fff0a4ba280 R08: 0000000000000003 R09: 0000000000000000
[  858.857334] R10: 000055a355acae70 R11: 0000000000000246 R12: 000055a355ac7d18
[  858.864460] R13: 000055a355b46510 R14: 000055a355ac7e08 R15: 000055a355ac7980
[  858.871592] Modules linked in: x86_pkg_temp_thermal
[  858.876471] ---[ end trace 0d1e8dbfcac2ad5d ]---
[  858.881083] RIP: 0010:propagate_protected_usage+0x107/0x140
[  858.886654] Code: 38 48 85 c0 0f 85 59 ff ff ff e9 78 ff ff ff 4c
89 ef e8 ac 92 fe ff 4c 8b 63 28 be 08 00 00 00 49 8d 7c 24 40 e8 29
6f fe ff <f0> 4d 01 74 24 40 e9 52 ff ff ff 4c 89 ef e8 86 92 fe ff 48
8b 5b
[  858.905401] RSP: 0018:ffff8882285df660 EFLAGS: 00010202
[  858.910627] RAX: 0000000000000001 RBX: ffff88822af028f9 RCX: ffffffff936f5567
[  858.917763] RDX: 0000000000000001 RSI: 0000000000000008 RDI: 80ffff88822a8226
[  858.924918] RBP: ffff8882285df688 R08: 0000000000000001 R09: ffffed10455e0528
[  858.932050] R10: 80ffff88822a822e R11: ffffed10455e0527 R12: 80ffff88822a81e6
[  858.939183] R13: ffff88822af02921 R14: 7f0000777dd57e1a R15: ffffffffffffffff
[  858.946314] FS:  0000000000000000(0000) GS:ffff888230880000(0000)
knlGS:0000000000000000
[  858.954390] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  858.960129] CR2: 000055a355aff1e8 CR3: 0000000223e8c001 CR4: 00000000003606e0
[  858.967252] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  858.974376] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  899.073243] BUG: Bad page state: 48 messages suppressed
[  899.078478] BUG: Bad page state in process (agetty)  pfn:22ce97

Full test log link,
https://lkft.validation.linaro.org/scheduler/job/1511979#L14169

List of patches between next-2020618 to next-20200621,
5a94f5bc041e Add linux-next specific files for 20200621
080244d1fc51 Merge branch 'akpm/master'
4a5d2b1ce5e3 sh: add missing EXPORT_SYMBOL() for __delay
ef2d9fc68f0c sh: use generic strncpy()
23719118a8bd sh: remove call to memset after dma_alloc_coherent
25fc94b67589 sh: clkfwk: remove r8/r16/r32
9222aa38acb4 include/asm-generic/vmlinux.lds.h: align ro_after_init
21e74499f57e mm: annotate a data race in page_zonenum()
45a420e030b6 mm/swap.c: annotate data races for lru_rotate_pvecs
c7cfc94b1845 mm/rmap: annotate a data race at tlb_flush_batched
68a49b98a306 mm/mempool: fix a data race in mempool_free()
5f0a11faa764 mm/list_lru: fix a data race in list_lru_count_one
bde5dd228193 mm/memcontrol: fix a data race in scan count
a7821e0d7f12 mm/page_counter: fix various data races at memsw
d69db9e5e83d mm-swapfile-fix-and-annotate-various-data-races-v2
3953a42f9a4f mm/swapfile: fix and annotate various data races
53b66fc7a0eb mm/filemap.c: fix a data race in filemap_fault()
a6b4ec24f77a mm/swap_state: mark various intentional data races
3a00284e066d mm-page_io-mark-various-intentional-data-races-v2
adff23f6e6f1 mm/page_io: mark various intentional data races
076fe7838b0e mm/frontswap: mark various intentional data races
74a952daca93 mm/kmemleak: silence KCSAN splats in checksum
92499683837a s390: fix build error for sys_call_table_emu
e19be697b498 all arch: remove system call sys_sysctl
a05f0b4611aa Revert "drivers/tty/serial/sh-sci.c: suppress
uninitialized var warning"
f19aad5fb52f Merge branch 'akpm-current/current'
f02b8b6b5a45 Revert "fs: Move __scm_install_fd() to __fd_install_received()"
8ae475af1cc7 Revert "fs: Add fd_install_received() wrapper for
__fd_install_received()"
77291e31b475 Revert "pidfd: Replace open-coded partial fd_install_received()"
b7c330ad5e62 Revert "fs: Expand __fd_install_received() to accept fd"
197803739e7d Revert "seccomp: Introduce addfd ioctl to seccomp user notifier"
9f45dd11b589 Revert "selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD"
4fbe81db63c3 Merge remote-tracking branch 'fsinfo/fsinfo-core'
54dc3af3b330 Merge remote-tracking branch
'notifications/notifications-pipe-core'
36fce5f71ba8 Merge remote-tracking branch 'trivial/for-next'
be67a3a73e2b Merge remote-tracking branch 'kunit-next/kunit'
fcf4c670851c Merge remote-tracking branch 'fpga/for-next'
8f9ac2e1bfc9 Merge remote-tracking branch 'pidfd/for-next'
f3c693ffcae7 Merge remote-tracking branch 'auxdisplay/auxdisplay'
999dd3a97a87 Merge remote-tracking branch 'hyperv/hyperv-next'
c5fcc4ec0c18 Merge remote-tracking branch 'xarray/xarray'
50841ac37465 Merge remote-tracking branch 'nvmem/for-next'
15cbc9151341 Merge remote-tracking branch 'fsi/next'
9d0883701e1e Merge remote-tracking branch 'kspp/for-next/kspp'
42058e576330 Merge remote-tracking branch 'nvdimm/libnvdimm-for-next'
f68cba82455d Merge remote-tracking branch 'coresight/next'
d010b60c167d Merge remote-tracking branch 'livepatching/for-next'
6bf1fe8938a3 Merge remote-tracking branch 'userns/for-next'
aeb6d371d739 Merge remote-tracking branch 'pwm/for-next'
77c685136e21 Merge remote-tracking branch 'pinctrl-samsung/for-next'
4c3f6f71602e Merge remote-tracking branch 'pinctrl/for-next'
c0b3eea264d1 Merge remote-tracking branch 'gpio-brgl/gpio/for-next'
72c3f1a61545 Merge remote-tracking branch 'gpio/for-next'
8d548faf56f6 Merge remote-tracking branch 'rpmsg/for-next'
6bdc70ae5ac4 Merge remote-tracking branch 'vhost/linux-next'
050b0c620d07 Merge remote-tracking branch 'scsi-mkp/for-next'
2189eb4d826f Merge remote-tracking branch 'scsi/for-next'
18f88d2eba90 Merge remote-tracking branch 'slave-dma/next'
9a8d419e5056 Merge remote-tracking branch 'icc/icc-next'
1719c37cb8e6 Merge remote-tracking branch 'mux/for-next'
44f8c22d3b2d Merge remote-tracking branch 'staging/staging-next'
8b5345483b1a Merge remote-tracking branch 'thunderbolt/next'
1e7887898ada Merge remote-tracking branch 'usb-chipidea-next/ci-for-usb-next'
e1f19f74f7d9 Merge remote-tracking branch 'usb/usb-next'
ee6c5629ee9c Merge remote-tracking branch 'percpu/for-next'
949f57de4b7f Merge remote-tracking branch 'rcu/rcu/next'
2b12419aa3a4 Merge remote-tracking branch 'irqchip/irq/irqchip-next'
e3a3827fdbe4 Merge remote-tracking branch 'edac/edac-for-next'
03e8e6f04a09 next-20200618/tip
4337f7168a80 Merge remote-tracking branch 'spi/for-next'
9512707cc897 Merge remote-tracking branch 'devicetree/for-next'
2557ce150fa7 Merge remote-tracking branch 'audit/next'
e3597bc47a45 Merge remote-tracking branch 'tpmdd/next'
b71ee8c13186 Merge remote-tracking branch 'safesetid/safesetid-next'
9676924ffb48 Merge remote-tracking branch 'regulator/for-next'
6b378f928a59 Merge remote-tracking branch 'battery/for-next'
3d93dea7ef20 Merge remote-tracking branch 'mmc/next'
fa8ff88017c8 Merge remote-tracking branch 'device-mapper/for-next'
5723bcdbfdc6 Merge remote-tracking branch 'block/for-next'
dfc84c87615f Merge remote-tracking branch 'sound-asoc/for-next'
676ba17f1905 Merge remote-tracking branch 'sound/for-next'
276d96312693 kcov: unconditionally add -fno-stack-protector to compiler options
8118f1cf7878 aio: simplify read_events()
1ca9471f88be lib/Kconfig.debug: fix typo in the help text of
CONFIG_PANIC_TIMEOUT
77c777d9ab7d kernel/panic.c: make oops_may_print() return bool
2258106c2b9a drivers/rapidio/rio-scan.c: use struct_size() helper
556f681e9a5d drivers/rapidio/devices/rio_mport_cdev.c: use struct_size() helper
aaafdf9249d7 kdump: append kernel build-id string to VMCOREINFO
9dcdfb72360a umh: fix refcount underflow in fork_usermode_blob().
c647d3b38f18 exec: move path_noexec() check earlier
6f445658f73d exec: move S_ISREG() check earlier
b7ba800ba7e2 exec: change uselib(2) IS_SREG() failure to EACCES
98e592c5af0f selftests: simplify kmod failure value
d13ef8e10756 umh: fix processed error when UMH_WAIT_PROC is used
e7a4d0d64d3f test_kmod: avoid potential double free in trigger_config_run_type()
0e468fcb5a7a kmod: remove redundant "be an" in the comment
54b5208978d3 selftests: kmod: use variable NAME in kmod_test_0001()
c3f33e282fac fs/signalfd.c: fix inconsistent return codes for signalfd4
a90c7bc63820 scripts/deprecated_terms: recommend denylist/allowlist
instead of blacklist/whitelist
f7281ed53263 checkpatch: support deprecated terms checking
29ecaa26b2f3 checkpatch: add test for possible misuse of IS_ENABLED()
without CONFIG_
37f7d07028d1 lib/test_bits.c: add tests of GENMASK
4731630e2f5d lib: optimize cpumask_local_spread()
c1a5fff84c0a lib/test_bitmap.c: add test for bitmap_cut()
175fd437b7e3 lib/bitmap.c: fix bitmap_cut() for partial overlapping case
b63533aa6f4a kernel/hung_task.c: Monitor killed tasks.
3a7eea3f04ea fs/buffer.c: dump more info for __getblk_gfp() stall problem
c69d5d18b240 fs/buffer.c: add debug print for __getblk_gfp() stall problem
d4f86abd6e35 mm/zswap: move to use crypto_acomp API for hardware acceleration
aca7b118adc5 x86/mm: use max memory block size on bare metal
461751581883 include/linux/sched/mm.h: optimize current_gfp_context()
ce7c19caf5c3 mm: hugetlb: fix the name of hugetlb CMA
e7f0557d7de9 mm: cma: fix the name of CMA areas
a2fcc5a6d06d mm/cma.c: fix NULL pointer dereference when cma could not
be activated
653ee2dfbd9b mm-vmstat-add-events-for-pmd-based-thp-migration-without-split-update
716a9cb6ebfa mm-vmstat-add-events-for-pmd-based-thp-migration-without-split-fix
bfeb40727ccb mm/vmstat: add events for PMD based THP migration without split
4372cbed1c5c mm: thp: remove debug_cow switch
a49eac754e51 hugetlbfs: prevent filesystem stacking of hugetlbfs
87268b23aa72 mm: use unsigned types for fragmentation score
a0e396e6f93c mm: proactive compaction
b160132805c1 mm/vmscan.c: fix typo
3175163860ae mm/page_alloc: remove nr_free_pagecache_pages()
25f58c9d5411 mm: remove vm_total_pages
3453457a03dc mm, page_alloc: skip ->watermark_boost for atomic order-0
allocations-fix
0513905cc9d8 mm, page_alloc: skip ->waternark_boost for atomic order-0
allocations
f7cebcbbdf7a page_alloc: consider highatomic reserve in watermark fast
cbf7c9d86d75 mm: track mmu notifiers in fs_reclaim_acquire/release
aa368ed0ff6a mm, page_alloc: use unlikely() in task_capc()
500cad44ab0f mm/vmalloc: switch to "propagate()" callback
7c681a2c9e6e mm/vmalloc: simplify augment_tree_propagate_check()
f45497173393 mm/vmalloc: simplify merge_or_add_vmap_area()
e951faec5f04 vmalloc: convert to XArray
28ce16b05f8d mm/mmap.c: fix the adjusted length error
0e61d15530fc mm: move p?d_alloc_track to separate header file
40736f7a6b53 mm/memory.c: make remap_pfn_range() reject unaligned addr
a8f5728b9da9 mm: remove redundant check non_swap_entry()
5b9e8dc989fd kselftests: cgroup: add perpcu memory accounting test
07666ee77fb4 mm: memcg: charge memcg percpu memory to the parent cgroup
f0264f283063 mm: memcg/percpu: per-memcg percpu memory statistics
e98c97a4b242 mm-memcg-percpu-account-percpu-memory-to-memory-cgroups-fix-fix
fbcea17c8b9b mm-memcg-percpu-account-percpu-memory-to-memory-cgroups-fix
12b30088eaae mm: memcg/percpu: account percpu memory to memory cgroups
1d60e4b6d40e percpu: return number of released bytes from pcpu_free_area()
ab019d051530 tools/cgroup: add memcg_slabinfo.py tool
53f6f42d19f0 kselftests: cgroup: add kernel memory accounting tests
13dbc24db5d7 mm-memcg-slab-use-a-single-set-of-kmem_caches-for-all-allocations-fix
6625d827c858 mm: memcg/slab: use a single set of kmem_caches for all allocations
f40e021dcfc7 mm: memcg/slab: remove redundant check in
memcg_accumulate_slabinfo()
09d57e608347 mm: memcg/slab: deprecate slab_root_caches
06d26578a4e4 mm: memcg/slab: remove memcg_kmem_get_cache()
9c83812d9ad4 mm: memcg/slab: simplify memcg cache creation
8b946491fdd7 mm: memcg/slab: use a single set of kmem_caches for all
accounted allocations
9ede3d210bb2 mm: memcg/slab: move memcg_kmem_bypass() to memcontrol.h
aa33e371a2d6 mm: memcg/slab: deprecate memory.kmem.slabinfo
548e689106b8 mm: memcg/slab: charge individual slab objects instead of pages
40f4154f066d mm: memcg/slab: save obj_cgroup for non-root slab objects
499d43980709 mm-memcg-slab-allocate-obj_cgroups-for-non-root-slab-pages-fix
745ae860d9c8 mm: memcg/slab: allocate obj_cgroups for non-root slab pages
18dd026d4526 mm-memcg-slab-obj_cgroup-api-fix
5d4e6a0f4ca7 mm: memcg/slab: obj_cgroup API
7afbbdbfdc28 mm: memcontrol: decouple reference counting from page accounting
ad49c6cb68c9 mm: slub: implement SLUB version of obj_to_index()
9b7d0eb6f2f6 mm: memcg: convert vmstat slab counters to bytes
d95b0f6cb447 mm: memcg: prepare for byte-sized vmstat items
a7b9e7704c60 mm: memcg: factor out memcg- and lruvec-level changes out
of __mod_lruvec_state()
05923a2ccacd mm, kcsan: instrument SLAB/SLUB free with "ASSERT_EXCLUSIVE_ACCESS"
0e8bd4e8b7c4 mm/slub.c: drop lockdep_assert_held() from put_map()
7b39adbb1b1d mm, slab/slub: improve error reporting and overhead of
cache_from_obj()
5a2a0a5f0458 mm, slab/slub: move and improve cache_from_obj()
e91e00a73a7d mm, slub: extend checks guarded by slub_debug static key
c91e241f569e mm, slub: introduce kmem_cache_debug_flags()-fix
d5cee500154e mm, slub: introduce kmem_cache_debug_flags()
7427f965084e mm, slub: introduce static key for slub_debug()
3312a073f331 mm, slub: make reclaim_account attribute read-only
956327673939 mm, slub: make remaining slub_debug related attributes read-only
d22bcce10577 mm, slub: remove runtime allocation order changes
2225e28078f7 mm, slub: make some slub_debug related attributes read-only
c0f1f987285d mm, slub: extend slub_debug syntax for multiple blocks
c8890eca5114 mm: ksize() should silently accept a NULL pointer
13b9f92ed464 mm, treewide: rename kzfree() to kfree_sensitive()
09ab611bc069 kernel/watchdog: flush all printk nmi buffers when
hardlockup detected
d3c89f70c117 ramfs: support O_TMPFILE
a1e988dda7bb drivers/tty/serial/sh-sci.c: suppress uninitialized var warning
2117f2a09bbd ocfs2: fix ocfs2 corrupt when iputting an inode
910e6d1323b9 ocfs2: clear links count in ocfs2_mknod() if an error occurs
bb8799143599 scripts/bloat-o-meter: Support comparing library archives
a45c9b225621 scripts/tags.sh: collect compiled source precisely
2fe609d4c7cb checkpatch: test $GIT_DIR changes
17a0169de15e /proc/kpageflags: do not use uninitialized struct pages
bff9c6afdae8 /proc/kpageflags: prevent an integer overflow in
stable_page_flags()
e21eb5850bb8 mm: remove vmalloc_exec
329758313796 arm64: use PAGE_KERNEL_ROX directly in alloc_insn_page
8ed90bf8f95f x86/hyperv: allocate the hypercall page with only read
and execute bits
8bbfc239fe08 mm, slab: fix sign conversion problem in memcg_uncharge_slab()
3d9ed52bd4b4 linux/bits.h: fix unsigned less than zero warnings
eea51d588bd8 lib: fix test_hmm.c reference after free
c824ce1feffa ocfs2: fix value of OCFS2_INVALID_SLOT
55f4b1a05449 ocfs2: fix panic on nfs server over ocfs2
a86d6e9dea49 ocfs2: load global_inode_alloc
2d6241eb4cbe ocfs2: avoid inode removal while nfsd is accessing it
fe76dff54050 kexec: do not verify the signature without the lockdown
or mandatory signature
573840b2a059 mm, compaction: make capture control handling safe wrt interrupts
8f4df40ca903 doc: THP CoW fault no longer allocate THP
bbf59a542afc docs: mm/gup: minor documentation update
ef93261fc434 mm/memory_hotplug.c: fix false softlockup during pfn range removal
fce0ed6224c1 mm/memcontrol.c: prevent missed memory.low load tears
1bb1a2b8d884 mm/memcontrol.c: add missed css_put()
f61a866d8a34 mm: memcontrol: handle div0 crash race condition in memory.low
c95e7b994357 mm/debug_vm_pgtable: fix build failure with powerpc 8xx
955125a48f03 mm/memory.c: properly pte_offset_map_lock/unlock in
vm_insert_pages()
1c35d1bbd926 mm: fix swap cache node allocation mask
c8f8d52df5b3 mm/memory: fix IO cost for anonymous page
ad3a0677256b mm/swap: fix for "mm: workingset: age nonresident
information alongside anonymous pages"
e546c9fd9d66 mm: workingset: age nonresident information alongside
anonymous pages
8dc0fba69e67 slub: cure list_slab_objects() from double fix
088b708234f1 mm/slab: use memzero_explicit() in kzfree()
f103708d907d mm: do_swap_page(): fix up the error code
02317d25edab openrisc: fix boot oops when DEBUG_VM is enabled
45e50181a22f Merge remote-tracking branch 'regmap/for-next'
17ebe068d360 Merge remote-tracking branch 'etnaviv/etnaviv/next'
53dd3a1a5fa5 Merge remote-tracking branch 'imx-drm/imx-drm/next'
7164a0ff0a0d Merge remote-tracking branch 'mali-dp/for-upstream/mali-dp'
34fc83e3f660 Merge remote-tracking branch 'drm-msm/msm-next'
89c5d78b5e3b Merge remote-tracking branch 'drm-misc/for-linux-next'
604c3ba77e72 Merge remote-tracking branch 'drm-tegra/drm/tegra/for-next'
db4fedef1003 Merge remote-tracking branch 'drm-intel/for-linux-next'
fcec20a25e27 next-20200616/amdgpu
2f907ddbff97 Merge remote-tracking branch 'crypto/master'
bdda221cb356 Merge remote-tracking branch 'nand/nand/next'
d66758331596 Merge remote-tracking branch 'gfs2/for-next'
6a21fb721acc Merge remote-tracking branch 'bluetooth/master'
bfd9f0183cd3 Merge remote-tracking branch 'wireless-drivers-next/master'
0da0f227415b Merge remote-tracking branch 'bpf-next/master'
3e836ac66a5d Merge remote-tracking branch 'net-next/master'
3b6c48207c90 Merge remote-tracking branch 'swiotlb/linux-next'
ac097061c0fd Merge remote-tracking branch 'ieee1394/for-next'
e438a26fc9ee Merge remote-tracking branch 'thermal/thermal/linux-next'
0b1a36ee33a6 Merge remote-tracking branch 'cpufreq-arm/cpufreq/arm/linux-next'
031969f73628 Merge remote-tracking branch 'pm/linux-next'
e222c587d78f Merge remote-tracking branch 'jc_docs/docs-next'
66e10514c4c3 Merge remote-tracking branch 'hwmon-staging/hwmon-next'
f559800bedea Merge branch 'dmi/master'
597afcb1d768 Merge remote-tracking branch 'i2c/i2c/for-next'
3f31e4ad2b20 next-20200618/hid
4c7ed9fd1f36 next-20200618/printk
2262a9df93cc Merge remote-tracking branch 'vfs/for-next'
2f21fd3f9848 Merge remote-tracking branch 'file-locks/locks-next'
6ef0bb950323 Merge remote-tracking branch 'ext3/for_next'
deb8de46d804 Merge remote-tracking branch 'exfat/dev'
e2ad3d3d8350 Merge remote-tracking branch 'cifs/for-next'
9a14120d1d0a Merge remote-tracking branch 'btrfs/for-next'
ab1d71b15dec Merge remote-tracking branch 'xtensa/xtensa-for-next'
fad4101356f6 Merge remote-tracking branch 'risc-v/for-next'
5048203cf05e Merge remote-tracking branch 'parisc-hd/for-next'
4ba424fb4c21 Merge remote-tracking branch 'mips/mips-next'
5fd30b7a8724 Merge remote-tracking branch 'm68knommu/for-next'
7680497c80d5 Merge remote-tracking branch 'h8300/h8300-next'
aecf48c78b84 Merge remote-tracking branch 'tegra/for-next'
9bc17686841d Merge remote-tracking branch 'scmi/for-linux-next'
37075d55a174 Merge remote-tracking branch 'samsung-krzk/for-next'
8ff1ccd640da Merge remote-tracking branch 'rockchip/for-next'
63295e35a439 Merge remote-tracking branch 'reset/reset/next'
e26a935ff531 Merge remote-tracking branch 'renesas/next'
ac5022c89301 Merge remote-tracking branch 'realtek/for-next'
e672bd752b38 Merge remote-tracking branch 'qcom/for-next'
9697ec35d2cc Merge remote-tracking branch 'omap/for-next'
8fa23ba28129 Merge remote-tracking branch 'mvebu/for-next'
619de7dc5647 Merge remote-tracking branch 'mediatek/for-next'
e535fde27035 Merge remote-tracking branch 'keystone/next'
24ede46aa0a2 Merge remote-tracking branch 'imx-mxs/for-next'
7d436638da8f Merge remote-tracking branch 'at91/at91-next'
f7eedd954677 Merge remote-tracking branch 'aspeed/for-next'
d53dc81fa68e Merge remote-tracking branch 'amlogic/for-next'
a100c95aa9af Merge remote-tracking branch 'arm-soc/for-next'
cb25f426e8cf Merge remote-tracking branch 'arm/for-next'
6a31438d0d8b Merge remote-tracking branch 'dma-mapping/for-next'
6de53dcd5c17 Merge remote-tracking branch 'drm-misc-fixes/for-linux-next-fixes'
6087ac2687a5 Merge remote-tracking branch 'erofs-fixes/fixes'
4a1ee627697b Merge remote-tracking branch 'fpga-fixes/fixes'
16367f1af155 Merge remote-tracking branch 'pidfd-fixes/fixes'
9bebb4d63a26 Merge remote-tracking branch 'mmc-fixes/fixes'
666b3ef96dc1 Merge remote-tracking branch 'scsi-fixes/fixes'
59189158aae7 Merge remote-tracking branch 'devicetree-fixes/dt/linus'
c6a11e1d9fb9 Merge remote-tracking branch 'btrfs-fixes/next-fixes'
856d7326d51a Merge remote-tracking branch 'hwmon-fixes/hwmon'
850d3d5c12e3 Merge remote-tracking branch 'kvms390-fixes/master'
6e5aacae4045 Merge remote-tracking branch 'omap-fixes/fixes'
e67d74b9f9c6 Merge remote-tracking branch 'mips-fixes/mips-fixes'
d7f2ed39c9bc Merge remote-tracking branch 'mtd-fixes/mtd/fixes'
e0a7faf05a21 Merge remote-tracking branch 'slave-dma-fixes/fixes'
f09a278d6bed Merge remote-tracking branch 'vfio-fixes/for-linus'
d8aa67b8db2d Merge remote-tracking branch 'crypto-current/master'
3644c557a7fb Merge remote-tracking branch 'staging.current/staging-linus'
282c9ccb368c Merge remote-tracking branch 'usb-chipidea-fixes/ci-for-usb-stable'
27da2ed4f38f Merge remote-tracking branch 'usb.current/usb-linus'
a9173d269649 Merge remote-tracking branch 'spi-fixes/for-linus'
9c6324a10459 Merge remote-tracking branch 'regulator-fixes/for-linus'
4ce52110aa56 Merge remote-tracking branch 'regmap-fixes/for-linus'
68c72b72ac25 Merge remote-tracking branch 'sound-asoc-fixes/for-linus'
51b54d8ebd59 Merge remote-tracking branch 'sound-current/for-linus'
c88bb4e3a695 Merge remote-tracking branch 'rdma-fixes/for-rc'
1db080309e9b Merge remote-tracking branch 'net/master'
b34d4bda37ac Merge remote-tracking branch 'powerpc-fixes/fixes'
e0d5fce09ec0 Merge remote-tracking branch 'arc-current/for-curr'
7888a9e5fcb5 Merge remote-tracking branch 'kbuild-current/fixes'
892d919cb88c sched: Fix RANDSTRUCT build fail
c23cc96cd670 Merge remote-tracking branch 'fixes/master'
54eeea0d707d tc-testing: update geneve options match in tunnel_key unit tests
902053f17dbe of: mdio: preserve phy dev_flags in of_phy_connect()
89fbd26cca7e r8169: fix firmware not resetting tp->ocp_base
78e57f152c00 net: Avoid overwriting valid skb->napi_id
8eaf8d994090 Remove redundant condition in qdisc_graft
8b40eb73509f ibmvnic: continue to init in CRQ reset returns H_CLOSED
b59eabd23ee5 ionic: tame the watchdog timer on reconfig
cd3998385712 Merge branch 'Ocelot-Felix-driver-cleanup'
c73b0ad36ea3 net: mscc: ocelot: unexpose ocelot_vcap_policer_{add,del}
aae4e500e106 net: mscc: ocelot: generalize the "ACE/ACL" names
3c83654f246b net: mscc: ocelot: rename ocelot_ace.{c, h} to ocelot_vcap.{c,h}
9c90eea310f8 net: mscc: ocelot: move net_device related functions to
ocelot_net.c
d9feb9049973 net: mscc: ocelot: move ocelot_regs.c into ocelot_vsc7514.c
14addfb6356b net: mscc: ocelot: rename MSCC_OCELOT_SWITCH_OCELOT to
MSCC_OCELOT_SWITCH
f4d0323bae4e net: mscc: ocelot: convert MSCC_OCELOT_SWITCH into a library
56583862b87b net: mscc: ocelot: rename module to mscc_ocelot
589aa6e7c9de net: mscc: ocelot: rename ocelot_board.c to ocelot_vsc7514.c
ff4b0bc62353 net: mscc: ocelot: access EtherType using __be16
7eb5c96a7cae net: mscc: ocelot: use plain int when interacting with TCAM tables
3ab4ceb6e963 net: dsa: felix: make vcap is2 keys and actions static
60cb8d3d715b Merge branch 'Strict-mode-for-VRF'
8735e6eaa438 selftests: add selftest for the VRF strict mode
a59a8ffd4a1b vrf: add l3mdev registration for table to VRF device lookup
33306f1aaf82 vrf: add sysctl parameter for strict mode
c8baec385737 vrf: track associations between VRF devices and tables
49042c220b3a l3mdev: add infrastructure for table to VRF mapping
44fc2d79b547 Merge branch 'devel' into for-next
42ba326cdeff Merge branch 'devel' into for-next
35e6ecf1bc49 Merge branch 'for-5.9/block' into for-next
ea1ab756e354 blk-iocost: Use struct_size() in kzalloc_node()
0e5ee5fb16cc Merge branch 'for-5.9/block' into for-next
05a0f5475689 block: bio: Use struct_size() in kmalloc()
6c736f9f2b5b block: create the request_queue debugfs_dir on registration
1de75b0f88cd blktrace: ensure our debugfs dir exists
de08463407e8 blktrace: fix debugfs use after free
00116c54643f loop: be paranoid on exit and prevent new additions / removals
117eedf00857 blktrace: annotate required lock on do_blk_trace_setup()
a639bfd9086d block: revert back to synchronous request_queue removal
1988203b3524 block: clarify context for refcount increment helpers
add7291177c8 block: add docs for gendisk / request_queue refcount helpers
435fda26d703 Merge branch 'ib-for-each-requested' of
/home/linus/linux-gpio into devel
84651e81ee33 Merge branch 'ib-for-each-requested' into devel
5bae1f08e285 pinctrl: at91: Make use of for_each_requested_gpio()
7796cdc911fc gpio: xra1403: Make use of for_each_requested_gpio()
86661fd7faac gpio: mvebu: Make use of for_each_requested_gpio()
aed8fa12552a ARM/orion/gpio: Make use of for_each_requested_gpio()
b3337eb24831 gpiolib: Introduce for_each_requested_gpio_in_range() macro
b1a05ba9ae8c pinctrl: stm32: add possibility to configure pins individually
d9665bb82269 pinctrl: stm32: return proper error code in pin_config_set
2254e77665d5 pinctrl: stm32: defer probe if reset resource is not yet ready
d888229ef2fb pinctrl: stm32: don't print an error on probe deferral
during clock get
b5fc06a10e7a pinctrl: ingenic: Add ingenic,jz4725b-gpio compatible string
25fae752156d pinctrl: single: fix function name in documentation
925ca36913fc gpiolib: split character device into gpiolib-cdev
8b6ddd10d678 Merge tag 'trace-v5.8-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
1f6bd574e9d5 gpio: max732x: remove redundant check
eede2b9b3fe0 Merge tag 'libnvdimm-for-5.8-rc2' of
git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
7f5f4de83ca3 pinctrl: qcom: ipq6018 Add missing pins in qpic pin group
13f2d25b951f Revert "pinctrl: freescale: imx: Use 'devm_of_iomap()' to
avoid a resource leak in case of error in 'imx_pinctrl_probe()'"
1566feea450c Merge tag 's390-5.8-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
7fdfbe08a2b3 Merge tag 'riscv-for-linus-5.8-rc2' of
git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
27c2760561c0 Merge tag 'linux-kselftest-5.8-rc2' of
git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
5481fc6eb8a7 afs: Fix hang on rmmod due to outstanding timer
f8ea5c7bceeb afs: Fix afs_do_lookup() to call correct fetch-status op variant
b9fe86204b06 drm/bridge: tfp410: Fix setup and hold time calculation
db8f92a5e627 drm/bridge: tfp410: fix de-skew value retrieval from DT
520a994de09e dt-bindings: display: ti, tfp410.yaml: Redefine ti, deskew property
1dd8915291d5 dt-bindings: display: ti,tfp410.txt: convert to yaml
c0e1c8c22beb powerpc/8xx: Provide ptep_get() with 16k pages
481e980a7c19 mm: Allow arches to provide ptep_get()
55ca22633a9f mm/gup: Use huge_ptep_get() in gup_hugepte()
94f07917ebe8 drm/panel-simple: Add missing connector type for some panels
b27ff5c187dd drm/panel: otm8009a: Drop unnessary backlight_device_unregister()
775f43facfe8 Drivers: hv: vmbus: Remove the lock field from the
vmbus_channel struct
21d2052c7afb scsi: storvsc: Introduce the per-storvsc_device spinlock
cf46143fe2c9 drm/i915/gt: Replace manual kmap_atomic() with pin_map
for renderstate
033ef711bbfb drm/i915/gvt: Drop redundant prepare_write/pin_pages
51baf6e50c62 Merge branch 'kspp/uninit/macro' into for-next/kspp
2d0e6f87039d compiler: Remove uninitialized_var() macro
4ee42e96f851 treewide: Remove uninitialized_var() usage
a94ccb5b88df checkpatch: Remove awareness of uninitialized_var() macro
e765f2d0cd7f mm/debug_vm_pgtable: Remove uninitialized_var() usage
ca8826095e4d selftests/net: report etf errors correctly
3145550a7f8b scsi: target: tcmu: Fix crash in tcmu_flush_dcache_range on ARM
3c58f737231e scsi: target: tcmu: Optimize use of flush_dcache_page
5948378b26d8 ibmveth: Fix max MTU limit
c5eb179edd8a net/sched: cls_u32: Use struct_size() in kzalloc()
11a33de2df06 taprio: Use struct_size() in kzalloc()
1075a4744a32 Merge branch 'Clause-45-PHY-probing-improvements'
389a33899987 net: phy: read MMD ID from all present MMDs
320ed3bf9000 net: phy: split devices_in_package
5ba33cf48392 net: phy: set devices_in_package only after validation
c746053d275c net: phy: add support for probing MMDs >= 8 for devices-in-package
439625a7726c net: phy: reword get_phy_device() kerneldoc
ee951005e95e net: phy: clean up get_phy_c22_id() invalid ID handling
48c543887bc5 net: phy: clean up get_phy_c45_ids() failure handling
e63062616df3 net: phy: clean up PHY ID reading
454a78d17845 net: phy: clean up cortina workaround
e034c6d23bc4 tipc: Use struct_size() helper
95dcd89275bc Merge branch 'several-fixes-for-indirect-flow_blocks-offload'
3c005110d408 net/sched: cls_api: fix nooffloaddevcnt warning dmesg log
a1db217861f3 net: flow_offload: fix flow_indr_dev_unregister path
66f1939a1b70 flow_offload: use flow_indr_block_cb_alloc/remove function
26f2eb27d081 flow_offload: add flow_indr_block_cb_alloc/remove function
f51853fc0682 scsi: ufs: docs: Add WriteBooster documentation
4c7b4d63273d scsi: core: Fix formatting errors in scsi_lib.c
71df6fb976c3 scsi: core: Remove scsi_sdb_cache
56c09de347e4 geneve: allow changing DF behavior after creation
9deba33f1b72 enetc: Fix HW_VLAN_CTAG_TX|RX toggling
da3f28da1c27 scsi: target: tcmu: Remove unnecessary bit TCMU_CMD_BIT_INFLIGHT
faa620876b01 net: macb: undo operations in case of failure
2996cbd532a0 Merge tag 'rxrpc-fixes-20200618' of
git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
393403efc360 scsi: ufs: ufs-exynos: Fix spelling mistake
"pa_granularty" -> "pa_granularity"
9a3cd470f8e3 scsi: ufs-mediatek: Make ufs_mtk_wait_link_state static
2a451122a04e Merge branch 'for-next/seccomp' into for-next/kspp
bb8dc2695a7d tools/bpftool: Relicense bpftool's BPF profiler prog as
dual-license GPL/BSD
d56b74b9e1b8 tools/bpf: Add verifier tests for 32bit pointer/scalar arithmetic
6c6935419e2f bpf: Avoid verifier failure for 32bit pointer arithmetic
9df24eaef86f Merge branch 'for-5.8/papr_scm' into libnvdimm-for-next
d3779e78b984 kcsan: Disable branch tracing in core runtime
ea568760cc54 kcsan: Simplify compiler flags
3364e113f32d kcsan: Re-add GCC as a supported compiler
70fc6d9c14e2 net: dsa: sja1105: Use struct_size() in kzalloc()
a422d5ff6def cxgb4: Use struct_size() helper
f362b70bd67a ethernet: ti: am65-cpsw-qos: Use struct_size() in devm_kzalloc()
cc7a21b6fbd9 ipv6: icmp6: avoid indirect call for icmpv6_send()
cc26c9f5ace2 Merge branch 'net-phy-MDIO-bus-scanning-fixes'
b2ffc75e2e99 net: phy: Check harder for errors in get_phy_id()
5a8d7f126c97 of: of_mdio: Correct loop scanning logic
e9f0809fb910 Merge branch 'cxgb4-add-support-for-ethtool-n-tuple-filters'
4dababa232f2 cxgb4: add action to steer flows to specific Rxq
27ee29936443 cxgb4: add support to fetch ethtool n-tuple filters
db43b30cd89c cxgb4: add ethtool n-tuple filter deletion
c8729cac2a11 cxgb4: add ethtool n-tuple filter insertion
d915c299f1da cxgb4: add skeleton for ethtool n-tuple filters
b103c607654e docs: staging: don't use literalinclude
8e2a46a40fa7 docs: move remaining stuff under Documentation/*.txt to
Documentation/staging
4333a9b0b67b Merge tag 'io_uring-5.8-2020-06-19' of
git://git.kernel.dk/linux-block
4fb33953438b drm/i915/gt: Show the culmative runtime as part of the engine info
d2b1c81f5f6c Merge tag 'block-5.8-2020-06-19' of git://git.kernel.dk/linux-block
781885fdf09f docs: sh: convert register-banks.txt to ReST
7539b417626e docs: sh: convert new-machine.txt to ReST
599448d8ca9d docs: powerpc: convert vcpudispatch_stats.txt to ReST
592be758f196 Merge tag 'libata-5.8-2020-06-19' of
git://git.kernel.dk/linux-block
86de78d2c5f4 docs: arm64: convert perf.txt to ReST format
7910b136cbb1 docs: pci: endpoint/function/binding/pci-test.txt convert to ReST
6564cfefb01c net: ethernet: oki-semi: pch_gbe: fix spelling mistake
9f70e48e1f08 docs: misc-devices/apds990x.txt: convert to ReST format
0e7ade47bb6e docs: misc-devices/bh1770glc.txt: convert to ReST
433b1b0d75c7 docs: misc-devices/c2port.txt: convert to ReST format
24f5aa53afbf net: ethernet: neterion: vxge: fix spelling mistake
16a60665cfc0 docs: misc-devices/pci-endpoint-test.txt: convert to ReST
8a05eb89cb84 docs: misc-devices/pci-endpoint-test.txt: convert to ReST
3471b9f7e43d docs: misc-devices/spear-pcie-gadget.txt: convert to ReST
740369c5794b docs: crypto: descore-readme.txt: convert to ReST format
ddc92399cc65 docs: crypto: convert async-tx-api.txt to ReST format
5846551bb147 docs: crypto: convert api-intro.txt to ReST format
0e5f9d50ad96 Merge branch 'master' of
git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
0efaaa86581c docs: crypto: convert asymmetric-keys.txt to ReST
0c12018e0129 docs: thermal: convert cpu-idle-cooling.rst to ReST
24cfbec99647 drm/dp: DRM DP helper for reading Ignore MSA from DPCD
d5ddc6d98d48 docs: fs: proc.rst: fix a warning due to a merge conflict
b29bb87cbb0a selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD
af35c3c6a9a5 seccomp: Introduce addfd ioctl to seccomp user notifier
50ca89d3a4fb fs: Expand __fd_install_received() to accept fd
f533d1758f02 pidfd: Replace open-coded partial fd_install_received()
4ab6bcc3ad3b fs: Add fd_install_received() wrapper for __fd_install_received()
d3868eea5cbc fs: Move __scm_install_fd() to __fd_install_received()
83b4f2c51e82 net/scm: Regularize compat handling of scm_detach_fds()
7b075ad9f496 Merge branch '40GbE' of
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue
4b61d3e8d3da net: qos offload add flow status with dropped count
2253bd848017 Documentation: tee: Document TEE kernel interface
62c91ead977a Merge tag 'drm-fixes-2020-06-19' of
git://anongit.freedesktop.org/drm/drm
cf37fc4a0ce1 Replace HTTP links with HTTPS ones:
Documentation/translations/zh_CN
68e4cd17e218 docs: deprecated.rst: Add zero-length and one-element arrays
67ee6940ae24 docs/zh_CN: update sysfs.txt about show() usage
d8923e96410c doc:it_IT: add symbol-namespace translation
49e66bf74edf seccomp: Use -1 marker for end of mode 1 syscall list
00674c4f10e9 docs: mm/gup: Minor documentation update
672f9255a727 Merge tag 'ceph-for-5.8-rc2' of git://github.com/ceph/ceph-client
e996919b7292 Documentation: fix sysctl/kernel.rst heading format warnings
6cbef2adb730 Documentation: fix filesystems/locking.rst malformed table warnings
723452918eb5 Documentation: remove SH-5 index entries
84bc1993e28b Merge tag 'arm64-fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
10857a01ab81 doc: x86/speculation: length of underlines
c03f739fd023 doc: add novamap to efi kernel command line parameters
7ca8e63c8ed3 mailmap: add entries for Alexander Lobakin
5a15550e56cc drm/i915/gt: Initialise rps timestamp
98b769942c69 Merge tag 'overflow-v5.8-rc2' of
git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
98d7e741a0a3 Merge tag 'perf-tools-fixes-2020-06-02' of
git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux
5d809cb28056 power: supply: max8998_charger: Correct ONLINE and add STATUS props
4e670f43081c dm rq: don't call blk_mq_queue_stopped() in dm_stop_queue()
1a37a0397116 power: supply: bq24190_charger: Fix runtime PM imbalance on error
59a5d883f2cc EXP sched: Alleged fix for v5.8 merge-window scheduler issue
7222bd603dd2 power: supply: sbs-battery: add PEC support
05e043097154 power: supply: sbs-battery: use i2c_smbus_read_block_data()
42137e42c3c7 dm mpath: use double checked locking in fast path
86ff55859d8d dm mpath: rename current_pgpath to pgpath in
multipath_prepare_ioctl
86982edf07f8 dm mpath: rework __map_bio()
de6dfede5fa5 dm mpath: factor out multipath_queue_bio
340d6a203cb9 dm mpath: push locking down to must_push_back_rq()
d04bf2dadcb0 dm mpath: take m->lock spinlock when testing QUEUE_IF_NO_PATH
8b3284e250bc dm mpath: changes from initial m->flags locking audit
d35bd764e689 dm writecache: add cond_resched to loop in
persistent_memory_claim()
f2cd9a5e85dc dm zoned: Fix reclaim zone selection
3ee39573e567 dm zoned: Fix random zone reclaim selection
415c79e13b17 dm: update original bio sector on Zone Append
b38c0ad57f8e dm zoned: Fix metadata zone size check
e0034433a7e4 docs: device-mapper: add dm-ebs.rst to an index file
1d85f6d1b0c1 power: supply: gpio-charger: Make gpios optional
dad980f13243 dt-bindings: power: supply: gpio-charger: convert to yaml
8a99e5013454 Drivers: hv: vmbus: Remove unnecessary channel->lock
critical sections (sc_list updaters)
3eb0ac869c66 Drivers: hv: vmbus: Use channel_mutex in channel_vp_mapping_show()
12d0dd8e728e Drivers: hv: vmbus: Remove unnecessary channel->lock
critical sections (sc_list readers)
0a96820929f0 Drivers: hv: vmbus: Replace cpumask_test_cpu(,
cpu_online_mask) with cpu_online()
458d090fbad5 Drivers: hv: vmbus: Remove the numa_node field from the
vmbus_channel struct
5bf74682118b Drivers: hv: vmbus: Remove the target_vp field from the
vmbus_channel struct
596f4785f498 power: supply: axp20x_usb_power: fix spelling mistake
224941c9424f power: supply: use kobj_to_dev
dbc87e74d022 vfs, fsinfo: Add an RCU safe per-ns mount list
a8dfdba8de7e erofs: fix partially uninitialized misuse in
z_erofs_onlinepage_fixup
0768e6e4934e dt-bindings: power: supply: bq25890: Document required interrupt
307b0d631d13 dt-bindings: power: supply: bq25890: Indent example with tabs
1293806368bc fsinfo: Add an attribute that lists all the visible
mounts in a namespace
8fd52e0d56fc fsinfo: Add support to ext4
66da00c992e2 fsinfo: Add support for AFS
776130e51fa1 fsinfo: Add API documentation
f00f837e704c fsinfo: sample: Mount listing program
a76120c7f361 fsinfo: Provide notification overrun handling support
53eb0052aa9a fsinfo: Allow mount topology and propagation info to be retrieved
1a6b879c8582 Merge remote-tracking branch 'spi/for-5.9' into spi-next
0c5e6b29f27a Merge remote-tracking branch 'spi/for-5.8' into spi-linus
d194a22f504f Merge series "mtd: spi-nor: Move cadence-qaudspi to
spi-mem framework" from Vignesh Raghavendra <vigneshr@ti.com>:
31fb632b5d43 spi: Move cadence-quadspi driver to drivers/spi/
a314f6367787 mtd: spi-nor: Convert cadence-quadspi to use spi-mem framework
41b5ed6e677c mtd: spi-nor: cadence-quadspi: Drop redundant WREN in erase path
935da5e5100f mtd: spi-nor: cadence-quadspi: Handle probe deferral
while requesting DMA channel
c61088d1f993 mtd: spi-nor: cadence-quadspi: Fix error path on failure
to acquire reset lines
48aae57f0f9f mtd: spi-nor: cadence-quadspi: Don't initialize
rx_dma_complete on failure
a99705079a91 mtd: spi-nor: cadence-quadspi: Provide a way to disable DAC mode
834b4e8d3441 mtd: spi-nor: cadence-quadspi: Make driver independent of
flash geometry
28f9f8fb4f40 MAINTAINERS: Add robert and myself as qcom i2c cci maintainers
89835eda8600 fsinfo: Allow mount information to be queried
a7c3f6a618e0 fsinfo: Add a uniquifier ID to struct mount
2421474bbbc8 fsinfo: Allow fsinfo() to look up a mount object by ID
7b5dd70acb6d fsinfo: Allow retrieval of superblock devname, options and stats
e5ba640ad868 fsinfo: Provide a bitmap of supported features
f5e8733f5811 fsinfo: Add fsinfo() syscall to query filesystem information
f2e02f2c84b3 Merge remote-tracking branch 'asoc/for-5.9' into asoc-next
f66aada04ccf Merge remote-tracking branch 'asoc/for-5.8' into asoc-linus
a3944c88a744 Merge series "add regmap & indirect access support" from
Xu Yilun <yilun.xu@intel.com>:
d5fcc710a1dd Merge series "spi: spi-geni-qcom: Fixes / perf
improvements" from Douglas Anderson <dianders@chromium.org>:
0ec544ceb1c1 spi: npcm-fiu: Reuse BITS_PER_BYTE definition
5f368ddea6fe drm/arm: fix unintentional integer overflow on left shift
79ce058032c3 drm: drm_fourcc: Add uncompressed AFBC modifier
94b292b27734 drm: drm_fourcc: add NV15, Q410, Q401 YUV formats
7ba9bdcb91f6 spi: spi-geni-qcom: Don't keep a local state variable
902481a78ee4 spi: spi-geni-qcom: Actually use our FIFO
e191a082d764 spi: spi-geni-qcom: Check for error IRQs
2ee471a1e28e spi: spi-geni-qcom: Mo' betta locking
d9dd0fb0e197 spi: altera: fix size mismatch on 64 bit processors
3820061d3815 spi: altera: support indirect access to the registers
3c6519736eef spi: altera: use regmap-mmio instead of direct mmio register access
3bd057c8219d ASoC: qcom: Kconfig: Tweak dependencies on SND_SOC_SDM845
9cb2b3796e08 ASoC: fsl_spdif: Add pm runtime function
c7440acc8597 Merge branch 'topic/hda-micmute-led' into for-next
f34a4c9dd4ca ALSA: hda: Enable sync-write operation as default for all
controllers
114427b8927a drm/panfrost: Use kvfree() to free bo->sgts
64092598c456 drm/panfrost: Fix runtime PM imbalance on error
b99773ef258e drm/panfrost: Fix inbalance of devfreq record_busy/idle()
54e552c96d30 watch_queue: Add superblock notifications
bf3c50837506 drm/i915/query: Use struct_size() helper
b950460b2486 Merge branch 'for-5.9/selftests-cleanup' into for-next
3fd9bd8b7e41 selftests/livepatch: add test delimiter to dmesg
c401088f0f18 selftests/livepatch: refine dmesg 'taints' in dmesg comparison
2eeb0d457d13 selftests/livepatch: Don't clear dmesg when running tests
a23ff37b32c7 i2c: smbus: Fix spelling mistake in the comments
a5765124e697 Documentation/i2c: SMBus start signal is S not A
390fd0475af5 i2c: remove deprecated i2c_new_device API
bc5a3e44af7e Documentation: media: convert to use i2c_new_client_device()
9e1b93b9f624 video: backlight: tosa_lcd: convert to use i2c_new_client_device()
f04a5ba17525 x86/platform/intel-mid: convert to use i2c_new_client_device()
bb7d93fff62f drm: encoder_slave: use new I2C API
f78d4032de60 drm: encoder_slave: fix refcouting error for modules
f8f02d5c671f USB: OTG: rename product list of devices
19246d273e58 USB: storage: scsi: fix up comment to be more specific
c83a74ed5f22 USB: storage: fix wording in error message
66f092ed3b94 USB: serial: sierra: unify quirk handling logic
4a7375edf29c USB: serial: qcserial: fix up wording in a comment
8adbe334a150 USB: OHCI: remove obsolete FIXME comment
9af54301b643 USB: rename USB OTG hub configuration option
91c7eaa686c3 USB: rename USB quirk to USB_QUIRK_ENDPOINT_IGNORE
ba9e8a1a2c3e dma-mapping: DMA_COHERENT_POOL should select GENERIC_ALLOCATOR
3995ecbabc6f i40e: fix crash when Rx descriptor count is changed
b1d95cc2391f ice: protect ring accesses with WRITE_ONCE
d59e267912cd i40e: protect ring accesses with READ- and WRITE_ONCE
f140ad9fe2ae ixgbe: protect ring accesses with READ- and WRITE_ONCE
7cc373db7ec5 Merge branch 'cxgb4-add-support-to-read-write-flash'
17b332f48074 cxgb4: add support to read serial flash
d5002c9a3d5a cxgb4: add support to flash boot cfg image
550883558f17 cxgb4: add support to flash boot image
4ee339e1e92a cxgb4: add support to flash PHY image
3893c905b557 cxgb4: update set_flash to flash different images
0ad6f6e767ec net: increment xmit_recursion level in dev_direct_xmit()
0fb9fbab4053 Merge branch 'net-tso-expand-to-UDP-support'
3d5b459ba0e3 net: tso: add UDP segmentation support
761b331cb690 net: tso: cache transport header length
504b91215098 net: tso: constify tso_count_descs() and friends
185c3e586022 net: tso: shrink struct tso_t
9c77b803f263 net: tso: double TSO_HEADER_SIZE value
393415203f5c octeontx2-af: change (struct qmem)->entry_sz from u8 to u16
8dbe4c5d5e40 net: dsa: bcm_sf2: Fix node reference count
1b0554090061 Merge branch 'hns3-next'
c2a2e1270a57 net: hns3: streaming dma buffer sync between cpu and device
e99a308da3c1 net: hns3: replace disable_irq by IRQ_NOAUTOEN flag
4d2cad32127e net: hns3: rename buffer-related functions
cb0e3e611575 net: hns3: pointer type of buffer should be void
674a135746aa net: hns3: remove unnecessary devm_kfree
9f66a4557e93 mISDN: hfcsusb: Use struct_size() helper
c90834cd477a lan743x: allow mac address to come from dt
d8d8b23844d6 Merge branch 'r8169-smaller-improvements-again'
51f6291b040a r8169: allow setting irq coalescing if link is down
9f0b54cd1672 r8169: move switching optional clock on/off to pll power functions
a2ee847242b3 r8169: move updating counters to rtl8169_down
0c28a63a47bf r8169: move napi_disable call and rename rtl8169_hw_reset
7190aeece918 r8169: replace synchronize_rcu with synchronize_net
e9882208ae98 r8169: improve setting WoL on runtime-resume
27248d57c88a r8169: remove unused constant RsvdMask
a38b7fbfeaeb r8169: add info for DASH being enabled
eddbf5d0204e net: ethtool: add missing NETIF_F_GSO_FRAGLIST feature string
1260e772dd18 enetc: Use struct_size() helper in kzalloc()
aa56127d9ac5 rcu/trace: Use gp_seq_req in acceleration's
rcu_grace_period tracepoint
63222f379b92 rcu/trace: Print negative GP numbers correctly
3a2656a211ca tg3: driver sleeps indefinitely when EEH errors exceed
eeh_max_freezes
4c98045c9b74 bareudp: Fixed multiproto mode configuration
427d5838e996 net: napi: remove useless stack trace
e807fa3f602e Merge branch 's390-qeth-fixes'
8cebedb64383 s390/qeth: let isolation mode override HW offload restrictions
e2dfcfba00ba s390/qeth: fix error handling for isolation mode cmds
f3c7a6e0e515 Merge branch 'mptcp-cope-with-syncookie-on-MP_JOINs'
9e365ff576b7 mptcp: drop MP_JOIN request sock on syn cookies
8fd4de127558 mptcp: cache msk on MP_JOIN init_req
5eea3a63ff4a net: Fix the arp error in some cases
ad103e03bda7 Merge branch 'sja1105-fixes'
5182a6222dd0 net: dsa: sja1105: fix checks for VLAN state in gate action
c6ae970bcc8e net: dsa: sja1105: fix checks for VLAN state in redirect action
5b3b396c7767 net: dsa: sja1105: remove debugging code in sja1105_vl_gate
4e638025f256 net: stmmac: selftests: Use struct_size() helper in kzalloc()
b64ee4856c10 Merge branch 'act_gate-fixes'
c362a06e96ea net/sched: act_gate: fix configuration of the periodic timer
7024339a1cfa net/sched: act_gate: fix NULL dereference in tcf_gate_init()
ba61539c6ae5 ip_tunnel: fix use-after-free in ip_tunnel_lookup()
dafabb6590cb ip6_gre: fix use-after-free in ip6gre_tunnel_lookup()
fb7861d14c8d net: core: reduce recursion limit value
814152a89ed5 net: fix memleak in register_netdevice()
1a642ca7f389 net: ethernet: mvneta: Add 2500BaseX support for SoCs
without comphy
b4748553f53f net: ethernet: mvneta: Fix Serdes configuration for SoCs
without comphy
0e2c09011d4d RISC-V: Acquire mmap lock before invoking walk_page_range
d3fbd739fc8a fpga: Fix dead store in fpga-bridge.c
88aaab9218f8 fpga: Fix dead store fpga-mgr.c
e1d9ec3af346 fpga: dfl: Use struct_size() in kzalloc()
23f872b6ece6 fpga manager: xilinx-spi: remove unneeded, mistyped variables
d1ddca78f9f6 fpga manager: xilinx-spi: valid for the 7 Series too
9d08b9ecbb2c dt-bindings: fpga: xilinx-slave-serial: valid for the 7 Series too
55dc9b87e4a8 fpga: dfl: afu: convert get_user_pages() --> pin_user_pages()
e0d17c842c0f RISC-V: Don't allow write+exec only page mapping request in mmap
8a7a3d1d0dcf Merge tag 'amd-drm-fixes-5.8-2020-06-17' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
7ac98ff024db Merge tag 'drm-intel-fixes-2020-06-18' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
4b409eb53473 rcutorture: Output number of elapsed grace periods
ec037e1f4380 rcu/segcblist: Prevent useless GP start if no CBs to accelerate
bac61e37848b riscv: Select ARCH_SUPPORTS_ATOMIC_RMW by default
7c7982cbadbb bpf: sk_storage: Prefer to get a free cache_idx
10011f7d95de ARCv2: support loop buffer (LPB) disabling
5e857ce6eae7 Merge branch 'hch' (maccess patches from Christoph Hellwig)
0c389d89abc2 maccess: make get_kernel_nofault() check for minimal type
compatibility
8c31055758bc doc: devicetree: bindings: fix spelling mistake
9e0dc7b9e1cb RDMA/mlx5: Fix integrity enabled QP creation
25f12ae45fc1 maccess: rename probe_kernel_address to get_kernel_nofault
2c0f5292d535 RDMA/mlx5: Remove ECE limitation from the RAW_PACKET QPs
d44335572f76 RDMA/mlx5: Fix remote gid value in query QP
6c41965d647a RDMA/mlx5: Don't access ib_qp fields in internal destroy QP path
d0793c3c6134 docs: dt: minor adjustments at writing-schema.rst
6cb69ea53479 dt: fix reference to olpc,xo1.75-ec.txt
9ac2a6615812 dt: Fix broken references to renamed docs
670d0a4b1070 sparse: use identifiers to define address spaces
5cd2182fdb70 Merge branch 'async-buffered.8' into for-next
ba3ea882d6f1 Merge branch 'for-5.9/block' into for-next
167babb0d405 nvme: use blk_mq_complete_request_remote to avoid an
indirect function call
421147be863b nvme-rdma: factor out a nvme_rdma_end_request helper
d0ee1358bbd2 blk-mq: add a new blk_mq_complete_request_remote API
c520d30b0903 blk-mq: factor out a blk_mq_complete_need_ipi helper
01abef68e38f blk-mq: remove the get_cpu/put_cpu pair in blk_mq_complete_request
616de37fe856 blk-mq: move failure injection out of blk_mq_complete_request
22fe8dc224df blk-mq: merge the softirq vs non-softirq IPI logic
18a445a209e3 blk-mq: short cut the IPI path in blk_mq_force_complete_rq for !SMP
ff356efeca41 blk-mq: complete polled requests directly
6f92ad84da8b rcu: Initialize at declaration time in rcu_exp_handler()
06096cc6c5a8 spi: spidev: fix a potential use-after-free in spidev_release()
abd42781c3d2 spi: spidev: fix a race between spidev_release and spidev_remove
d985becff25f dt: fix broken links due to txt->yaml renames
f2d94b86cdba dt: update a reference for reneases pcar file renamed to yaml
f141a422159a ASoC: rockchip: Fix a reference count leak.
3ad1d68c04bf io_uring: support true async buffered reads, if file provides it
ccfa58ab8ded mm: add kiocb_wait_page_queue_init() helper
ff6840fa8e80 ext4: flag as supporting buffered async reads
eb560f659552 btrfs: flag files as supporting buffered async reads
47939aa0d8d6 xfs: flag files as supporting buffered async reads
d6069ed47e19 block: flag block devices as supporting IOCB_WAITQ
18e3cae049f7 fs: add FMODE_BUF_RASYNC
c931a2087273 mm: support async buffered reads in generic_file_buffered_read()
2b884797ba86 mm: add support for async page locking
6ea69ad6b8ce mm: abstract out wake_page_match() from wake_page_function()
69484d4506bc mm: allow read-ahead with IOCB_NOWAIT set
0f4035179fdb io_uring: re-issue block requests that failed because of resources
3248c49f25a3 io_uring: catch -EIO from buffered issue request failure
5ff6c315bcc0 io_uring: always plug for any number of IOs
88682dd8b250 block: provide plug based way of signaling forced no-wait semantics
932257899d1f Merge branch 'for-5.9/io_uring' into async-buffered.7
664a8989ecfc Merge branch 'io_uring-5.8' into async-buffered.7
9debf3b0c3ac blk-mq: remove raise_blk_irq
3373a3461aa1 block: make function 'kill_bdev' static
f4bd34b139a3 loop: replace kill_bdev with invalidate_bdev
b5292111de9b libata: Use per port sync for detach
bc163c2046c5 partitions/ldm: Replace uuid_copy() with import_uuid()
where it makes sense
33504401a33c watch_queue: Introduce a non-repeating system-unique superblock ID
5341a8c5b745 watch_queue: sample: Display mount tree change notifications
adc241ad364a watch_queue: Implement mount topology and attribute
change notifications
5d7ba045107b blk-mq: factor out a helper to reise the block softirq
e5abe01f8381 blk-mq: merge blk-softirq.c into blk-mq.c
3d0c88d3776b Merge branch 'imx/dt64' into for-next
d8cde9772886 Merge branch 'imx/dt' into for-next
e353b325948d arm64: dts: imx8mm-beacon: Fix voltages on LDO1 and LDO2
3269c178b7a1 arm64: dts: ls1028a: add one more thermal zone support
6f2cc1664db2 io_uring: fix possible race condition against REQ_F_NEED_CLEANUP
6581adb275b9 watch_queue: Add security hooks to rule on setting mount
and sb watches
81c7462883b0 USB: replace hardcode maximum usb string length by definition
8c8cee0fea9d mtd: parsers: bcm63xx: simplify CFE detection
a68b9b567799 mtd: rawnand: brcmnand: ECC error handling on EDU transfers
88252ab21365 mtd: rawnand: brcmnand: Don't default to edu transfer
49ea06fa402a mtd: rawnand: qcom: set BAM mode only if not set already
d9bf62965ad5 mtd: rawnand: qcom: avoid write to unavailable register
d71d825ff912 mtd: rawnand: trivial spelling
7ca351a59494 mtd: rawnand: gpio: Get rid of the legacy interface implementation
3a86601defe2 mtd: rawnand: gpio: Implement exec_op()
18bebb2b1351 mtd: rawnand: gpio: Inherit from nand_controller
335e6e6d60e9 mtd: rawnand: fsl_upm: Get rid of the legacy interface
implementation
6fd201938f16 mtd: rawnand: fsl_upm: Implement exec_op()
f742d10d30fa mtd: rawnand: fsl_upm: Inherit from nand_controller
66dcdfe335e5 mtd: rawnand: fsl_upm: Use gpio descriptors
b86427e0aeff mtd: rawnand: fsl_upm: Use platform_get_resource() +
devm_ioremap_resource()
a3a8d85db90f mtd: rawnand: fsl_upm: Use devm_kasprintf() to allocate
the MTD name
ac886f186d9d mtd: rawnand: fsl_upm: Allocate the fsl_upm_nand object
using devm_kzalloc()
bb1ff912c42f mtd: rawnand: fsl_upm: Get rid of the unused
fsl_upm_nand.parts field
eb75d28b6b49 mtd: rawnand: fsl_upm: Remove unused mtd var
f9c4e50f27e5 mtd: rawnand: Allocate the interface configurations dynamically
cda37dbbf17a usb: xhci: fix spelling mistake in Kconfig "firwmare" -> "firmware"
4121fb0db68e RDMA/core: Check that type_attrs is not NULL prior access
3ec5f54f7a0f RDMA/hns: Fix an cmd queue issue when resetting
98a6151907cb RDMA/hns: Fix a calltrace when registering MR from userspace
6a1515c962b1 perf build: Fix error message when asking for
-fsanitize=address without required libraries
1b20d9491cf9 tools lib traceevent: Add handler for __builtin_expect()
74621d929d94 tools lib traceevent: Handle __attribute__((user)) in field names
27d4d336f287 tools lib traceevent: Add append() function helper for
appending strings
187dc605d288 Merge remote-tracking branch 'regulator/for-5.9' into
regulator-next
539afdf969d6 spi: spi-geni-qcom: No need for irqsave variant of spinlock calls
ab183d460daa RDMA/mlx5: Add missed RST2INIT and INIT2INIT steps during
ECE handshake
730c89124841 RDMA/cma: Protect bind_list and listen_list while finding
matching cm id
9ed84d24de48 regulator: max8997: Constify struct regulator_ops
b08af72d6e53 regulator: max8907: Constify static structs
b37f076d4bfd regulator: ltc3676: Constify ltc3676_regulators
bcf39c1eb1e0 regulator: cpcap: Constify cpcap_regulator_ops
cae62a937912 regulator: anatop: Constify anatop_core_rops
0dfbd5ecf28c RDMA/qedr: Fix KASAN: use-after-free in ucma_event_handler+0x532
0133654d8eb8 RDMA/efa: Set maximum pkeys device attribute
90a239ee25fa RDMA/rvt: Fix potential memory leak caused by rvt_alloc_rq
1ea7c546b8b3 RDMA/core: Annotate CMA unlock helper routine
59f7d71f35c1 m68k: mcfmmu: remove stale part of comment about steal_context
6a5ef3b224c6 drm/etnaviv: Simplify clock enable/disable
a59052d2749b drm/etnaviv: Make the "core" clock mandatory
f76fc5ff9a65 drm/etnaviv: Don't ignore errors on getting clocks
f8794feaf65c drm/etnaviv: Fix error path on failure to enable bus clk
ae9ff0c40457 m68knommu: fix overwriting of bits in ColdFire V3 cache control
64d8a534aa90 m68k: fix ColdFire mmu init compile warning
86824e60b0b1 drm/etnaviv: convert get_user_pages() --> pin_user_pages()
3499f9ad5d78 ASoC: amd: Removing unnecessary instance initialization
9f7041b71a2f ASoC: amd: closing specific instance.
c9e272f9e03d ALSA: hda: Let LED cdev handling suspend/resume
766538ac4af8 ALSA: hda/realtek: Unify LED helper code
d1d37c572cf0 ALSA: hda/sigmatel: Use the new vmaster mute LED helper
929f718cb390 ALSA: hda/conexant: Use the new vmaster mute LED helper
8d3d1ece3118 ALSA: hda/realtek: Use the new vmaster mute LED helper
15509b634472 ALSA: hda: generic: Add vmaster mute LED helper
fe1a162191a5 ALSA: hda: generic: Drop the old mic-mute LED hook
5fc0f6930035 ALSA: hda: generic: Drop unused snd_hda_gen_fixup_micmute_led()
23a2b46966bd ALSA: hda/sigmatel: Convert to cdev-variant of mic-mute
LED controls
e65a2caf3b05 ALSA: hda/conexant: Convert to cdev-variant of mic-mute
LED controls
8a503555be46 ALSA: hda/realtek: Convert to cdev-variant of mic-mute LED controls
7cdf8c49b1df ALSA: hda: generic: Add a helper for mic-mute LED with LED classdev
bf61c42a446f ALSA: hda: generic: Always call led-trigger for mic mute LED
46605a271114 Bluetooth: mgmt: Use command complete on success for set
system config
76b139965575 Bluetooth: Terminate the link if pairing is cancelled
8208f5a9d435 Bluetooth: Update background scan and report device based
on advertisement monitors
cdde92e23071 Bluetooth: Notify adv monitor removed event
b52729f27b1e Bluetooth: Notify adv monitor added event
bd2fbc6cb815 Bluetooth: Add handler of MGMT_OP_REMOVE_ADV_MONITOR
b139553db5cd Bluetooth: Add handler of MGMT_OP_ADD_ADV_PATTERNS_MONITOR
e5e1e7fd470c Bluetooth: Add handler of MGMT_OP_READ_ADV_MONITOR_FEATURES
7fceb17c6b48 Bluetooth: Add definitions for advertisement monitor features
4c54bf2b093b Bluetooth: Add get/set device flags mgmt op
a1fc7535ec34 Bluetooth: Replace wakeable in hci_conn_params
7a92906f841d Bluetooth: Replace wakeable list with flag
8baaa4038edb Bluetooth: Add bdaddr_list_with_flags for classic whitelist
aececa645dc7 Bluetooth: mgmt: Add commands for runtime configuration
24ebec25fb27 arm64: hw_breakpoint: Don't invoke overflow handler on
uaccess watchpoints
bf508ec95ca3 arm64: kexec_file: Use struct_size() in kmalloc()
c8fa5b7c7a7e drm/bridge: ti-sn65dsi86: Check the regmap return value
when setting a GPIO
c42fb724cdf6 drm/bridge: ti-sn65dsi86: Fix kernel-doc typo ln_polr => ln_polrs
f4946b0a3715 drm/bridge: ti-sn65dsi86: Don't use kernel-doc comment
for local array
9e4f35831392 drm/bridge: ti-sn65dsi86: Don't compile GPIO bits if not
CONFIG_OF_GPIO
618e07865b74 arm64: mm: reserve hugetlb CMA after numa_init
e63adeccc0bb drm/panfrost: Reduce the amount of logs on deferred probe
302c570bf36e usb: typec: tcpci_rt1711h: avoid screaming irq causing boot hangs
07c112fb09c8 USB: ohci-sm501: Add missed iounmap() in remove
03894573f291 cdc-acm: Add DISABLE_ECHO quirk for Microchip/SMSC chip
1ddcb71a3edf USB: ehci: reopen solution for Synopsys HC bug
28ebeb8db770 usb: usbtest: fix missing kfree(dev->buf) in usbtest_disconnect
207324a321a8 usb: dwc2: Postponed gadget registration to the udc class driver
5d8021923e8a usb: add USB_QUIRK_DELAY_INIT for Logitech C922
44ed240d6273 usb: host: ehci-exynos: Fix error check in exynos_ehci_probe()
130206a88683 usb: typec: mux: intel_pmc_mux: Fix DP alternate mode entry
3d19946b509c Documentation: ABI: usb: chipidea: Update Li Jun's e-mail
e9ec6cc74e0a USB: sisusbvga: change char to u8 for sisusb_copy_memory
810b7ee3008a drm/i915/gt: Always report the sample time for busy-stats
1b90e4a43b74 drm/i915/selftests: Enable selftesting of busy-stats
41ecdcfce177 usb: xhci: tegra: Remove PLL power supplies
153de2d66e53 usb: sisusb_con: Use array_size() helper in memcpy()
9ffcc3053f3b usb: gadget: u_serial.h: increase MAX_U_SERIAL_PORTS to 8
07d9878fa18f usb: dwc2: use well defined macros for power_down
9f3aedbe98fe drivers: usb: Fix trivial spelling
03cc8353c224 USB: core: additional Device Classes to debug/usb/devices
d50313a5a0d8 ALSA: hda: Intel: add missing PCI IDs for ICL-H, TGL-H and EKL
9bea6eb3f59c staging:rtl8712: avoid skb_clone after skb allocation fail
9e43eed45a48 staging: rts5208: Use array_size() helper in vmalloc() and memset()
21b1f2b3fb2e staging:r8723bs: remove wrappers around skb_clone() and
remove unnecessary in_interrupt() call
aeb4ac7916ce staging: vc04_services: Convert get_user_pages*() -->
pin_user_pages*()
c5a3b1db6af2 staging: qlge: qlge_main.c: fixed spaces coding style issues
6655a352aca1 staging: comedi: fix up missing whitespace in comment
76cd0c7cc20f Staging: comedi: Added blank lines to fix coding style issue
5631feed3932 staging: gasket: Convert get_user_pages*() --> pin_user_pages*()
774911290c58 KVM: s390: reduce number of IO pins to 1
a05b1c150f5b crypto: octeontx - Fix sparse warnings
cfb12c8952f6 arm64: dts: imx8mn-ddr4-evk: correct ldo1/ldo2 voltage range
4fd6b5735c03 arm64: dts: imx8mm-evk: correct ldo1/ldo2 voltage range
6570a35c903a ARM: dts: ls1021a: output PPS signal on FIPER2
864c2d57d691 crypto: caam - Fix argument type in handle_imx6_err005766
a79d471c6510 crypto: qat - update timeout logic in put admin msg
e4e245ad031f crypto: qat - send admin messages to set of AEs
624e62ccb20b crypto: qat - update fw init admin msg
c31b4adee161 crypto: caam/qi2 - remove redundant assignment to ret
29195232fa2f crc-t10dif: clean up some more things
be924e0aaa31 crc-t10dif: use fallback in initial state
57b1aac1b426 crypto: hisilicon - update SEC driver module parameter
3906f640224d crc-t10dif: Fix potential crypto notify dead-lock
07b048f41ac1 crypto: qat - remove packed attribute in etr structs
59c14e5e0174 crypto: qat - replace user types with kernel ABI __u types
2bfd22766d00 crypto: qat - replace user types with kernel u types
060ce5037d5f crypto: caam/qi2 - add support for dpseci_reset()
7f94adf218d8 crypto: hisilicon - allow smaller reads in debugfs
58e5b0157e58 crypto: caam - add clock info for VFxxx SoCs
0289e9be5dc2 hwrng: ba431 - add support for BA431 hwrng
50f362b2d9c4 dt-bindings: rng: document Silex Insight BA431 hwrng
f3c802a1f300 crypto: algif_aead - Only wake up when ctx->more is zero
1532e31f5098 crypto: qat - convert to SPDX License Identifiers
e04ec0de61c1 padata: upgrade smp_mb__after_atomic to smp_mb in padata_do_serial
34c86f4c4a7b crypto: af_alg - fix use-after-free in af_alg_accept()
due to bh_lock_sock()
8cbe23e1c79f dma-direct: add missing set_memory_decrypted() for coherent mapping
73bea31ca345 ARM: dts: imx: Make tempmon node as child of anatop node
ac4af2b12bbe arm64: dts: imx8mp: add i2c aliases
83ae2848520a arm64: dts: imx8mm: sort the aliases
614d88460f28 arm64: dts: imx8mq: Add ethernet alias
e9a8d99639c9 arm64: dts: imx8mq: Add mmc aliases
fe35ec58f0d3 block: update hctx map when use multiple maps
078e8f8ce8ad drm/msm: Fix setup of a6xx create_address_space.
f167989c6730 drm/msm: Fix address space size after refactor.
2cb3e01520e4 lib/test_vmalloc.c: Add test cases for kvfree_rcu()
b2a2c3f78b55 rcu: Introduce single argument kvfree_rcu() interface
a394911f0fa4 rcu: Support reclaim for head-less object
eb9561f9a367 rcu: Introduce 2 arg kvfree_rcu() interface
8ee5ce3426c9 mm/list_lru.c: Rename kvfree_rcu() to local variant
a7f3c5cbe4df rcu: Rename *_kfree_callback/*_kfree_rcu_offset/kfree_call_*
3755bf77c2a9 rcu/tiny: support vmalloc in tiny-RCU
51884dd51f97 rcu/tree: Maintain separate array for vmalloc ptrs
9f48bd767285 rcu/tree: cache specified number of objects
04e5111a0192 rcu/tree: Use static initializer for krc.lock
f62263565dce rcu/tree: Move kfree_rcu_cpu locking/unlocking to
separate functions
0454c261e73a rcu/tree: Simplify KFREE_BULK_MAX_ENTR macro
2818bcaef7a4 rcu/tree: Make debug_objects logic independent of rcu_head
f8e588e456eb rcu/tree: Repeat the monitor if any free channel is busy
b58846d8eae3 rcu/tree: Skip entry into the page allocator for PREEMPT_RT
a6307c6dbb98 rcu/tree: Keep kfree_rcu() awake during lock contention
327eccdcae99 Merge branch 'lkmm-dev.2020.06.17a' into HEAD
9927fdba2116 Merge branch 'kcsan.2020.06.17a' into HEAD
e3be8c671913 Merge branches 'doc.2020.06.17a', 'fixes.2020.06.17a',
'rcu-tasks.2020.06.17a', 'scale.2020.06.17a', 'srcu.2020.06.17a' and
'torture.2020.06.17a' into HEAD
bb278b149df9 of: property: Improve cycle detection when one of the
devices is never added
7d34ca385484 driver core: Add device_is_dependent() to linux/device.h
41dc09d5d550 tools/memory-model: Use "-unroll 0" to keep --hw runs finite
a60a604d7688 tools/memory-model: Make judgelitmus.sh handle scripted Result: tag
bc022201a9f2 tools/memory-model: Add data-race capabilities to judgelitmus.sh
7640c77493b6 tools/memory-model: Add checktheselitmus.sh to run
specified litmus tests
64c209d9bab6 tools/memory-model: Repair parseargs.sh header comment
51b9091ee96c tools/memory-model:  Add "--" to parseargs.sh for
additional arguments
a65ae0799a79 tools/memory-model: Make history-check scripts use mselect7
22418f4f3d10 tools/memory-model: Make checkghlitmus.sh use mselect7
c1b0315a8ca4 tools/memory-model: Fix scripting --jobs argument
c8b997dd1eb3 tools/memory-model: Implement --hw support for checkghlitmus.sh
62f443f56e49 tools/memory-model: Add -v flag to jingle7 runs
49616ee4dc6a tools/memory-model: Make runlitmus.sh check for jingle errors
78809348c99a tools/memory-model: Allow herd to deduce CPU type
d7c6a911fe83 tools/memory-model: Keep assembly-language litmus tests
3676e1741c34 tools/memory-model: Move from .AArch64.litmus.out to
.litmus.AArch.out
2adb517530a3 tools/memory-model: Make runlitmus.sh generate .litmus.out for --hw
00c0ec6b7a0f tools/memory-model: Split runlitmus.sh out of checklitmus.sh
ef8f4106a8b5 tools/memory-model: Make judgelitmus.sh ransack .litmus.out files
b52578d28093 tools/memory-model: Hardware checking for check{,all}litmus.sh
916c593db5ae tools/memory-model: Fix checkalllitmus.sh comment
555fe0e6e998 tools/memory-model: Add simpletest.sh to check locking,
RCU, and SRCU
09525708ec82 tools/memory-model: Make judgelitmus.sh handle hardware
verifications
acbdc02c044f tools/memory-model: Update parseargs.sh for hardware verification
dc1d97a946cb tools/memory-model: Fix paulmck email address on
pre-existing scripts
2542b6bcbd79 tools/memory-model: Make judgelitmus.sh detect hard deadlocks
d829b6b14e78 tools/memory-model: Make judgelitmus.sh identify bad macros
de77fd85c357 tools/memory-model: Make cmplitmushist.sh note timeouts
a6970096437e tools/memory-model: Make judgelitmus.sh note timeouts
3ce5d6935aa2 docs: fix references for DMA*.txt files
843285eb827a tools/memory-model/README: Expand dependency of klitmus7
550b7d13af3e rcutorture: Remove KCSAN stubs
93e04a507eec torture: Remove obsolete "cd $KVM"
94f92c4a0097 torture: Avoid duplicate specification of qemu command
64c791abe2b9 torture: Dump ftrace at shutdown only if requested
6d3f9f3256a7 torture: Add kvm-tranform.sh script for qemu-cmd files
bc79ea1b5694 torture: Add more tracing crib notes to kvm.sh
8be5dd6af55a torture: Improve diagnostic for KCSAN-incapable compilers
02b117daf475 torture: Correctly summarize build-only runs
8ff933eaa217 torture: Pass --kmake-arg to all make invocations
1ca9d04259e8 rcutorture: Check for unwatched readers
f4e87d572574 torture: Abstract out console-log error detection
fa2a01ff473a torture: Add a stop-run capability
9c862fafccd3 torture: Create qemu-cmd in --buildonly runs
0765aaf29ce7 rcu/rcutorture: Replace 0 with false
4f7a65305a42 torture: Add --allcpus argument to the kvm.sh script
09fb5034d5fb torture: Remove whitespace from identify_qemu_vcpus output
4a5ff638eb41 rcutorture: NULL rcu_torture_current earlier in cleanup code
eaf27166c7e5 rcutorture: Handle non-statistic bang-string error messages
92d02fc40433 torture: Set configfile variable to current scenario
33abf0d3f43d rcutorture: Add races with task-exit processing
e9d42e68bf02 locktorture: Use true and false to assign to bool variables
3dd1499666f6 ethtool: ioctl: Use array_size() in copy_to_user()
4a0cd2e323d8 srcu: Remove KCSAN stubs
a6964752eb2b srcu: Avoid local_irq_save() before acquiring spinlock_t
2b6a37db3bcb srcu: Fix a typo in comment "amoritized"->"amortized"
682591f7a6fa liquidio: Replace vmalloc_node + memset with vzalloc_node
and use array_size
6d719a4864fc refscale: Change --torture type from refperf to refscale
b8b61eb95e3f refperf: Rename refperf.c to refscale.c and change internal names
d4b1ec7956f0 refperf: Rename RCU_REF_PERF_TEST to RCU_REF_SCALE_TEST
bbf1e8d66d2f rcu-tasks: Fix synchronize_rcu_tasks_trace() header comment
a7f7a049ff6f refperf: Add test for RCU Tasks readers
15d40055d342 refperf: Add test for RCU Tasks Trace readers.
e97f71b32709 refperf: Change readdelay module parameter to nanoseconds
638d69e56cdf refperf: Work around 64-bit division
7ab8cfca06f3 doc: Document rcuperf's module parameters
04ba56b6e63c refperf: Adjust refperf.loop default value
3ad14b97ade0 refperf: Add read-side delay module parameter
f6c26de97947 refperf: Simplify initialization-time wakeup protocol
8bfaef2c77ba refperf: Output per-experiment data points
1492646840af refperf: Label experiment-number column "Runs"
c1c4d8be6942 refperf: Add warmup and cooldown processing phases
7b8dad0dddb3 refperf: More closely synchronize reader start times
cc4d488e5fca refperf: Convert reader_task structure's "start" field to int
9bb101ac9c9b refperf: Tune reader measurement interval
72f959e674bc refperf: Make functions static
ead9fc73a226 refperf: Dynamically allocate thread-summary output buffer
56fb0732ce45 refperf: Dynamically allocate experiment-summary output buffer
3f0891201f2a refperf: Provide module parameter to specify number of experiments
6c662985be1b refperf: Convert nreaders to a module parameter
7d20b627596f refperf: Allow decimal nanoseconds
72579919359d refperf: Hoist function-pointer calls out of the loop
5a54ea3f7d92 refperf: Add holdoff parameter to allow CPUs to come online
4510145fb878 torture: Add refperf to the rcutorture scripting
1614db175873 rcuperf: Add comments explaining the high reader overhead
fab9fb9f4d8d refperf: Add a test to measure performance of read-side
synchronization
70efb934a76e rcuperf: Remove useless while loops around wait_event
e41382bd5107 rcu-tasks: Fix code-style issues
4ecebd3ea773 rcu-tasks: Conditionally compile show_rcu_tasks_gp_kthreads()
2004c180105d rcu-tasks: Add #include of rcupdate_trace.h to update.c
7f479bbe63f8 rcu-tasks: Make rcu_tasks_postscan() be static
83e10b910201 rcu-tasks: Convert sleeps to idle priority
de496e26415d kcsan: Add jiffies test to test suite
80f5560ccc05 kcsan: Remove existing special atomic rules
83002756de46 kcsan: Rename test.c to selftest.c
9b8ba3fb6f8c kcsan: Silence -Wmissing-prototypes warning with W=1
f6cba5a8e965 kcsan: Prefer '__no_kcsan inline' in test
c73794e6e48f locking/osq_lock: Annotate a data race in osq_lock
0b0f96c05dfb kcsan: Add test suite
6bd7285f0c03 rculist: Add ASSERT_EXCLUSIVE_ACCESS() to __list_splice_init_rcu()
02c28dffb13a rxrpc: Fix afs large storage transmission performance drop
d6d3cb7231bc x86/mm/pat: Mark an intentional data race
31856ae7a0e1 fork: Annotate a data race in vm_area_dup()
a2ad7c21ad8c rxrpc: Fix handling of rwind from an ACK packet
9e08b68a5d1e rcu: Remove KCSAN stubs from update.c
3012ff1b1773 rcu: Remove KCSAN stubs
4390df0a794c rcu: fix some kernel-doc warnings
9b51f41ca0b5 kernel/rcu/tree.c: Fix kernel-doc warnings
088e85fc00cf rcu: grpnum just records group number
a4640dd513c5 rcu: grplo/grphi just records CPU number
51c8555ad7e6 rcu: gp_max is protected by root rcu_node's lock
f11b8485a3dc rcu: Stop shrinker loop
af40ece9bbc6 rcu: Replace 1 with true
4b579d04ab49 lockdep: Complain only once about RCU in extended quiescent state
549131f773f4 rcu: Mark rcu_nmi_enter() call to rcu_cleanup_after_idle() noinstr
70f3526e133b rcu: Remove initialized but unused rnp from check_slow_task()
7e6ff5858e84 rcu: fix some kernel-doc warnings
d0a53566a27e tick/nohz: Narrow down noise while setting current task's
tick dependency
465b9b1eba54 rcu: Update comment from rsp->rcu_gp_seq to rsp->gp_seq
c227b81f5f20 fs/btrfs: Add cond_resched() for
try_release_extent_mapping() stalls
8ee246bb7b87 rcu: Expedited grace-period sleeps to idle priority
fbc7ea1d91b5 rcu: No-CBs-related sleeps to idle priority
c2c8583c0e46 rcu: Priority-boost-related sleeps to idle priority
e11c6510c5c1 rcu: Grace-period-kthread related sleeps to idle priority
9f6487aaf591 trace: events: rcu: Change description of rcu_dyntick trace event
aadf9dcef9d4 rxrpc: Fix trace string
da9cebe16930 drm/amdgpu: fix documentation around busy_percentage
7386f5c9c808 drm/amdgpu/pm: update comment to clarify Overdrive interfaces
99c7b3094727 drm/amdkfd: Use correct major in devcgroup check
915b86431c64 seccomp: Fix ioctl number for SECCOMP_IOCTL_NOTIF_ID_VALID
09ba8837fc28 selftests/seccomp: Rename user_trap_syscall() to
user_notif_syscall()
b0b8f817ec53 selftests/seccomp: Make kcmp() less required
0c82b71446da seccomp: Use pr_fmt
c0bdf5128016 selftests/seccomp: Improve calibration loop
0efde377f003 selftests/seccomp: use 90s as timeout
0e3e72d68112 selftests/seccomp: Expand benchmark to per-filter measurements
e46ac071ac5d selftests/seccomp: Check for EPOLLHUP for user_notif
5371becee3ad seccomp: notify about unused filter
31cf8f693241 seccomp: Lift wait_queue into struct seccomp_filter
7bc54c47e53c seccomp: release filter after task is fully dead
2b7c624061f4 seccomp: rename "usage" to "refs" and document
9a681a3bb4b2 seccomp: Add find_notification helper
026bb845b0ff ftrace: Fix maybe-uninitialized compiler warning
a0cd0eba4d2d rcu: Add comment documenting rcu_callback_map's purpose
eb7b7ae6650b rcu: Add callbacks-invoked counters
6a4c210e134b rcu: Simplify the calculation of rcu_state.ncpus
c0f9239b9b14 mm/mmap.c: Add cond_resched() for exit_mmap() CPU stalls
5f210a50c8f8 rcu: Initialize and destroy rcu_synchronize only when necessary
501bae2df020 doc: Tasks RCU must protect instructions before trampoline
cc0dfc3719fa doc: Timer problems can cause RCU CPU stall warnings
52f7a1f294c1 docs: RCU: Don't duplicate chapter names in rculist_nulls.rst
6c3a3cbb8266 docs: RCU: Convert stallwarn.txt to ReST
a936e47dcb6e docs: RCU: Convert rcuref.txt to ReST
2365cc9d3a3f docs: RCU: Convert torture.txt to ReST
69da1f0d776a docs: RCU: Convert rculist_nulls.txt to ReST
85dd56aa8e4d docs: RCU: Convert lockdep.txt to ReST
c483ddc8bbe8 docs: RCU: Convert lockdep-splat.txt to ReST
256c0302cc4d docs: RCU: Convert checklist.txt to ReST
a5f610c0fa7e ASoC: Intel: broadwell: simplify card names for SOF uses
7bfbddfc9841 ASoC: Intel: cht*: simplify card names for SOF uses
b4ecd58b01fb ASoC: Intel: byt*: simplify card names for SOF uses
c0ee37e85e0e maccess: rename probe_user_{read,write} to
copy_{from,to}_user_nofault
fe557319aa06 maccess: rename probe_kernel_{read,write} to
copy_{from,to}_kernel_nofault
0e093c77c5b0 tools headers UAPI: Sync linux/fs.h with the kernel sources
f64925c1ebac tools include UAPI: Sync linux/vhost.h with the kernel sources
25ca7e5c0b03 tools arch x86: Sync the msr-index.h copy with the kernel sources
08a7c7772b4d Merge remote-tracking branch 'torvalds/master' into perf/urgent
b13b04d93821 perf script: Initialize zstd_data
cad2929dc432 tipc: update a binding service via broadcast
c3dbe541ef77 blktrace: Avoid sparse warnings when assigning q->blk_trace
1b0b28364816 blktrace: break out of blktrace setup on concurrent calls
0ff0fc97d307 drm/i915/selftests: fix spelling mistake "submited" -> "submitted"
5414251aa2e2 tools/bootconfig: Add testcase for show-command and quotes test
f91cb5b7476a tools/bootconfig: Fix to return 0 if succeeded to show
the bootconfig
272da3279df1 tools/bootconfig: Fix to use correct quotes for value
4e264ffd9534 proc/bootconfig: Fix to use correct quotes for value
69243720c093 tracing: Remove unused event variable in tracing_iter_reset
3aa8fdc37d16 tracing/probe: Fix memleak in fetch_op_data operations
48a42f5d1384 trace: Fix typo in allocate_ftrace_ops()'s comment
4649079b9de1 tracing: Make ftrace packed events have align of 1
9fbc01cdba66 sample-trace-array: Remove trace_array 'sample-instance'
e9b7b1c0c103 sample-trace-array: Fix sleeping function called from
invalid context
9b38cc704e84 kretprobe: Prevent triggering kretprobe from within
kprobe_flush_task
75ddf64dd276 kprobes: Remove redundant arch_disarm_kprobe() call
1a0aa991a627 kprobes: Fix to protect kick_kprobe_optimizer() by kprobe_mutex
7e6a71d8e601 kprobes: Use non RCU traversal APIs on kprobe_tables if possible
6743ad432ec9 kprobes: Suppress the suspicious RCU warning on kprobes
4ef57b21d6fb recordmcount: support >64k sections
2d3a8e2dedde block: Fix use-after-free in blkdev_get()
36cebead9f47 arm64: dts: imx8mq: enable Hantro G1/G2 VPU
65461e26b1fe interconnect: Allow inter-provider pairs to be configured
0259a41da323 interconnect: Relax requirement in of_icc_get_from_provider()
8a307d3601bc interconnect: Export of_icc_get_from_provider()
f46fe79ff1b6 pinctrl-single: fix pcs_parse_pinconf() return value
5bcc066c0590 trace/events/block.h: drop kernel-doc for dropped
function parameter
9192ec55e1c8 f2fs: Eliminate usage of uninitialized_var() macro
6348b895be85 media: sur40: Remove uninitialized_var() usage
e3a830641614 KVM: PPC: Book3S PR: Remove uninitialized_var() usage
e79607b93990 clk: spear: Remove uninitialized_var() usage
f7ec2e10aea2 spi: davinci: Remove uninitialized_var() usage
75896ee8d499 clk: st: Remove uninitialized_var() usage
a7635810c7bc ide: Remove uninitialized_var() usage
d465e49a0ffe rtlwifi: rtl8192cu: Remove uninitialized_var() usage
47f7d94c84c7 b43: Remove uninitialized_var() usage
63c3f24440a1 drbd: Remove uninitialized_var() usage
f9e4da0b87fb x86/mm/numa: Remove uninitialized_var() usage
032e6f262cea docs: deprecated.rst: Add uninitialized_var()
6769b275a313 RDMA/siw: Fix pointer-to-int-cast warning in siw_rx_pbl()
0dc63bbee0fa RDMA/hfi1: Fix trivial mis-spelling of 'descriptor'
4f5747cf8e59 RDMA/mlx5: Fix -Wformat warning in check_ucmd_data()
a8a5e383cf41 blk-mq: Remove redundant 'return' statement
2ef5612391f0 RDMA/mlx5: Remove duplicated assignment to resp.response_length
9909bc43a2e2 dt-bindings: MIPS: Document Ingenic SoCs binding.
92314d84b67f torture: Add script to smoke-test commits in a branch
d838f25ee7b6 torture:  Remove qemu dependency on EFI firmware
a08ae995e32f Documentation/litmus-tests: Cite an RCU litmus test
ffd32d4b7ee9 Documentation/litmus-tests: Merge atomic's README into
top-level one
116f054e2939 tools/memory-model: Fix reference to litmus test in recipes.txt
7eecf763778e Documentation/litmus-tests/atomic: Add a test for
smp_mb__after_atomic()
d059e5059004 Documentation/litmus-tests/atomic: Add a test for atomic_set()
dc762571b9eb Documentation/litmus-tests: Introduce atomic directory
05bee9a04c89 tools/memory-model: Add an exception for limitations on
_unless() family
bb2c9387b73c MAINTAINERS: Update maintainers for new Documentation/litmus-tests
47ec95b12107 Documentation: LKMM: Add litmus test for RCU GP guarantee
where reader stores
24dca63e6145 Documentation: LKMM: Add litmus test for RCU GP guarantee
where updater frees object
be1ce3e46670 tools/memory-model: Fix "conflict" definition
ac1a749d92dc tools/memory-model: Add recent references
4b25bbf52a55 bcache: pr_info() format clean up in bcache_device_init()
ee4a36f41461 bcache: use delayed kworker fo asynchronous devices registration
dcacbc1242c7 bcache: check and adjust logical block size for backing devices
be23e837333a bcache: fix potential deadlock problem in btree_gc_coalesce
9ec051bf4470 drm/amd/display: Rework dsc to isolate FPU operations
790243d3bf78 drm/amdgpu: Replace invalid device ID with a valid device ID
43a562774fce drm/amd/display: Use kfree() to free rgb_user in
calculate_user_regamma_ramp()
81921a828b94 drm/amd/display: Use kvfree() to free coeff in build_regamma()
85d0f9ad8212 perf pmu: Remove unused declaration
ffaecd7d1f88 perf parse-events: Fix an old style declaration
c2412fae3f01 perf parse-events: Fix an incompatible pointer
d38c692f160e perf bpf: Fix bpf prologue generation
9256c3031eb9 perf probe: Fix user attribute access in kprobes
c0c652fc705d perf stat: Fix NULL pointer dereference
11b6e5482e17 perf report: Fix NULL pointer dereference in
hists__fprintf_nr_sample_events()
dd76c302955d tools headers UAPI: Sync kvm.h headers with the kernel sources
377cb673cf35 tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
d8e1ef67722b tools headers UAPI: Sync linux/fscrypt.h with the kernel sources
5d33cbfedb51 perf beauty: Add support to STATX_MNT_ID in the 'statx'
syscall 'mask' argument
93dc627f4801 tools headers uapi: Sync linux/stat.h with the kernel sources
7e579f3a074c tools arch x86 uapi: Synch asm/unistd.h with the kernel sources
6c3c184fc420 tools headers API: Update faccessat2 affected files
f650ef61e040 ata/libata: Fix usage of page address by page_address in
ata_scsi_mode_select_xlat function
eea123886720 sata_rcar: handle pm_runtime_get_sync failure cases


- Naresh
