Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAFCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB0FF20775
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593592152;
	bh=b4CfnvT2d/KmP2F/ch19vnk2QEIiu5wHymaqwJfJ7rU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cFsEh10Ipyw0FXVwFKqJRQNFjzTN8Liw4VFppffbWvysSss8p1asWE2kNOX3SzFj1
	 FhoiivK4ZcQCb0K6Bq8ThW2GT91zBQ2BuX0+MIraWAjeZmqobfZpWP2bpAKqWn6tb5
	 RxMLk1ZobJrEEGzCyAAQbo/1t5ftOC0NLte+y93g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgGAI3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:29:11 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:47040 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbgGAI3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:29:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id dm19so12566947edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X29LAgI4LhCnrN4dbxCECjeFEfsrkr4E/MfSqx41Ik4=;
        b=PppYy5KTKu6/3l/nxnkbJCm9tYEQOGZb9Bb+FJjoFvHkggnyu/gP/FFd6VvBGT/RYL
         QPUIOlV8u08FrNHt1pQNdwoMfCTeUBNoPFslWbrVrl4iRmfLu15XWdoQyypnvF89bI9D
         M7+Nlj4IMXtyXWfSVap7WviCCN1TWbTBOB72h24/tmNAJdEcEZIwP9TgDiC9YvQuIgH+
         dca1y3tnTWPNprSSgQFb592hP8YkZrU64xzx4Y+MYzqPg6vtkZik571L6kBj0Vjuy1q+
         MKT0g6UFrGvFPFxcedQXWp4728jpa6hbDx7EKF9kWzR6yFEwDLcDkT7xD83AnSTemdLx
         c+yg==
X-Gm-Message-State: AOAM533qjEmPtAXQjSyB+m954sFdrHFC1bgqtES/IlreR4glACrImBvW
        Zxtv4XJnFbcbLkHnDNADOmE=
X-Google-Smtp-Source: ABdhPJwWPbYotD/I85Zu8SmVIM8lB0A0NU35Gsnr3ddvHVLSY9vfUx0zzAqK2LfBfx6xC+Vw9rF/Ow==
X-Received: by 2002:aa7:c6d3:: with SMTP id b19mr26745334eds.207.1593592146176;
        Wed, 01 Jul 2020 01:29:06 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id gr15sm4045965ejb.84.2020.07.01.01.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:29:05 -0700 (PDT)
Date:   Wed, 1 Jul 2020 10:29:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>, lkft-triage@lists.linaro.org,
        Chris Down <chris@chrisdown.name>
Subject: Re: BUG: Bad page state in process - page dumped because: page still
 charged to cgroup
Message-ID: <20200701082904.GM2369@dhcp22.suse.cz>
References: <CA+G9fYs=3UG3k-2trqQuB-gJh9D1YygkNQ4qWiHtcaRMSWTmrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYs=3UG3k-2trqQuB-gJh9D1YygkNQ4qWiHtcaRMSWTmrQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smells like a different observable problem with the same/similar culprit
as http://lkml.kernel.org/r/CA+G9fYtrgF_EZHi0vi+HyWiXT5LGggDhVXtNspc=OzzFhL=xRQ@mail.gmail.com

On Wed 01-07-20 13:48:57, Naresh Kamboju wrote:
> While running LTP mm test suite on x86_64 device the BUG: Bad page
> state in process
> noticed on linux-next 20200630 tag.
> 
> Steps to reproduce:
> - boot linux-next 20200630 kernel on x86_64 device
> - cd /opt/ltp
> - ./runltp -f mm
> 
> metadata:
>   git branch: master
>   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   git commit: f2b92b14533e646e434523abdbafddb727c23898
>   git describe: next-20200630
>   kernel-config:
> https://builds.tuxbuild.com/j60yrp7CUpq3LCmqMB8Wdg/kernel.config
> 
> Test crash dump:
> [  803.905169] Node 0 Normal: 2608*4kB (UMEH) 1380*8kB (UMEH) 64*16kB
> (MEH) 28*32kB (MEH) 13*64kB (UMEH) 164*128kB (UMEH) 39*256kB (UE)
> 1*512kB (M) 1*1024kB (M) 1*2048kB (M) 1*4096kB (M) = 62880kB
> [  803.922375] Node 0 hugepages_total=0 hugepages_free=0
> hugepages_surp=0 hugepages_size=2048kB
> [  803.930806] 2418 total pagecache pages
> [  803.934559] 0 pages in swap cache
> [  803.937878] Swap cache stats: add 0, delete 0, find 0/0
> [  803.943108] Free swap  = 0kB
> [  803.945997] Total swap = 0kB
> [  803.948885] 4181245 pages RAM
> [  803.951857] 0 pages HighMem/MovableOnly
> [  803.955695] 626062 pages reserved
> [  803.959016] Tasks state (memory values in pages):
> [  803.963722] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes
> swapents oom_score_adj name
> [  803.972336] [    332]     0   332     8529      507   106496
> 0             0 systemd-journal
> [  803.981387] [    349]     0   349    10730      508   118784
> 0         -1000 systemd-udevd
> [  803.990262] [    371]   993   371     8666      108   118784
> 0             0 systemd-network
> [  803.999306] [    379]   992   379     9529       99   110592
> 0             0 systemd-resolve
> [  804.008347] [    388]     0   388     2112       19    61440
> 0             0 syslogd
> [  804.016709] [    389]   995   389     9308      108   122880
> 0             0 avahi-daemon
> [  804.025517] [    391]     0   391     1075       21    57344
> 0             0 acpid
> [  804.033695] [    394]   995   394     9277       68   114688
> 0             0 avahi-daemon
> [  804.042476] [    396]   996   396     7241      154   102400
> 0          -900 dbus-daemon
> [  804.051170] [    397]     0   397     2313       72    65536
> 0             0 crond
> [  804.059349] [    399]     0   399    34025      161   167936
> 0             0 thermald
> [  804.067783] [    400]     0   400     8615      115   110592
> 0             0 systemd-logind
> [  804.076734] [    401]     0   401     2112       32    57344
> 0             0 klogd
> [  804.084907] [    449] 65534   449     3245       39    69632
> 0             0 dnsmasq
> [  804.093254] [    450]     0   450     3187       33    73728
> 0             0 agetty
> [  804.101541] [    452]     0   452     3187       33    73728
> 0             0 agetty
> [  804.109826] [    453]     0   453    14707      107   159744
> 0             0 login
> [  804.118007] [    463]     0   463     9532      163   122880
> 0             0 systemd
> [  804.126362] [    464]     0   464    16132      424   172032
> 0             0 (sd-pam)
> [  804.134803] [    468]     0   468     4538      105    81920
> 0             0 sh
> [  804.142741] [    472]     0   472    11102       83   131072
> 0             0 su
> [  804.150680] [    473]     0   473     4538       99    81920
> 0             0 sh
> [  804.158637] [    519]     0   519     2396       57    61440
> 0             0 lava-test-runne
> [  804.167700] [   1220]     0  1220     2396       52    61440
> 0             0 lava-test-shell
> [  804.176738] [   1221]     0  1221     2396       55    61440
> 0             0 sh
> [  804.184680] [   1223]     0  1223     2462      135    61440
> 0             0 ltp.sh
> [  804.192946] [   1242]     0  1242     2462      134    61440
> 0             0 ltp.sh
> [  804.201207] [   1243]     0  1243     2462      134    61440
> 0             0 ltp.sh
> [  804.209475] [   1244]     0  1244     2462      134    61440
> 0             0 ltp.sh
> [  804.217742] [   1245]     0  1245     2561      229    65536
> 0             0 runltp
> [  804.226010] [   1246]     0  1246     1072       15    53248
> 0             0 tee
> [  804.234012] [   1313]     0  1313     1070       29    53248
> 0             0 ltp-pan
> [  804.242374] [   3216]     0  3216     1613       20    53248
> 0             0 oom01
> [  804.250554] [   3217]     0  3217     1646       31    57344
> 0             0 oom01
> [  804.258728] [   3245]     0  3245    81271      469   266240
> 0             0 NetworkManager
> [  804.267688] [   3249]     0  3249     6422       54    98304
> 0             0 systemd-hostnam
> [  804.276734] [   3250]     0  3250    52976      178   172032
> 0             0 nm-dispatcher
> [  804.285603] [   3254]   998  3254   131113      828   245760
> 0             0 polkitd
> [  804.293956] [   3261]     0  3261  4726385  3349389 26939392
> 0             0 oom01
> [  804.302129] [   3265]     0  3265     3187       33    73728
> 0             0 agetty
> [  804.310397] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/,task=oom01,pid=3261,uid=0
> [  804.322751] Out of memory: Killed process 3261 (oom01)
> total-vm:18905540kB, anon-rss:13397556kB, file-rss:0kB, shmem-rss:0kB,
> UID:0 pgtables:26308kB oom_score_adj:0
> [  806.652952] oom_reaper: reaped process 3261 (oom01), now
> anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
> [  807.579373] BUG: Bad page state in process kworker/u8:12  pfn:374308
> [  807.579521] BUG: Bad page state in process kworker/u8:13  pfn:4182a4
> [  807.585734] page:ffffea000dd0c200 refcount:0 mapcount:0
> mapping:0000000000000000 index:0xffff88837430e000
> head:ffffea000dd0c200 order:3 compound_mapcount:0 compound_pincount:0
> [  807.585736] flags: 0x200000000010000(head)
> [  807.585740] raw: 0200000000010000 ffffea000dce6e00 0000000200000002
> 0000000000000000
> [  807.592099] page:ffffea001060a900 refcount:0 mapcount:0
> mapping:0000000000000000 index:0xffff8884182a5e00
> head:ffffea001060a900 order:1 compound_mapcount:0
> [  807.607719] raw: ffff88837430e000 0000000000040000 00000000ffffffff
> ffff8883bda6cac1
> [  807.607720] page dumped because: page still charged to cgroup
> [  807.607720] page->mem_cgroup:ffff8883bda6cac1
> [  807.607721] Modules linked in: x86_pkg_temp_thermal
> [  807.607725] CPU: 0 PID: 3242 Comm: kworker/u8:12 Not tainted
> 5.8.0-rc3-next-20200630 #1
> [  807.607727] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.0b 07/27/2017
> [  807.607731] Workqueue: rpciod rpc_async_schedule
> [  807.611836] flags: 0x200000000010000(head)
> [  807.619563] Call Trace:
> [  807.619567]  dump_stack+0x84/0xba
> [  807.619569]  bad_page.cold+0x7b/0xac
> [  807.619573]  __free_pages_ok+0x95b/0xab0
> [  807.633461] raw: 0200000000010000 dead000000000100 dead000000000122
> 0000000000000000
> [  807.641189]  __free_pages+0x42/0x50
> [  807.641191]  __free_slab+0xcd/0x1f0
> [  807.641195]  ? stack_trace_save+0x8f/0xc0
> [  807.646938] raw: ffff8884182a5e00 0000000000190000 00000000ffffffff
> ffff88841963e401
> [  807.651285]  discard_slab+0x33/0x50
> [  807.651288]  unfreeze_partials.isra.0+0x11f/0x150
> [  807.651291]  ? __free_pages+0x31/0x50
> [  807.656167] page dumped because: page still charged to cgroup
> [  807.664154]  put_cpu_partial+0x8e/0xe0
> [  807.664156]  __slab_free+0x222/0x340
> [  807.664160]  ? qlist_free_all+0x25/0xc0
> [  807.671636] page->mem_cgroup:ffff88841963e401
> [  807.676243]  ___cache_free+0x1a7/0x1f0
> [  807.676246]  qlist_free_all+0x3e/0xc0
> [  807.676248]  quarantine_reduce+0x11b/0x150
> [  807.676250]  __kasan_kmalloc.constprop.0+0xa3/0xe0
> [  807.680345] Modules linked in: x86_pkg_temp_thermal
> [  807.682788]  ? xprt_alloc_slot+0x1ff/0x260
> [  807.682790]  kasan_slab_alloc+0xe/0x10
> [  807.682792]  kmem_cache_alloc_trace+0xc8/0x4d0
> [  807.682795]  xprt_alloc_slot+0x1ff/0x260
> [  807.790462]  xprt_do_reserve+0x3c/0x380
> [  807.794303]  xprt_reserve+0x94/0x100
> [  807.797881]  ? rpc_set_connect_timeout+0x90/0x90
> [  807.802492]  call_reserve+0x36/0x40
> [  807.805985]  __rpc_execute+0x137/0x680
> [  807.809738]  ? set_next_entity+0xa7/0x3a0
> [  807.813750]  ? rpc_sleep_on_priority_timeout+0x60/0x60
> [  807.818881]  ? __kasan_check_write+0x14/0x20
> [  807.823153]  ? finish_task_switch+0x9b/0x380
> [  807.827419]  rpc_async_schedule+0x48/0x80
> [  807.831430]  process_one_work+0x474/0x7b0
> [  807.835441]  worker_thread+0x7b/0x6a0
> [  807.839113]  ? wake_up_process+0x10/0x20
> [  807.843043]  ? process_one_work+0x7b0/0x7b0
> [  807.847230]  kthread+0x1aa/0x200
> [  807.850462]  ? kthread_create_on_node+0xd0/0xd0
> [  807.854996]  ret_from_fork+0x22/0x30
> [  807.858573] Disabling lock debugging due to kernel taint
> [  807.858576] CPU: 3 PID: 3243 Comm: kworker/u8:13 Not tainted
> 5.8.0-rc3-next-20200630 #1
> [  807.858578] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.0b 07/27/2017
> [  807.863888] BUG: Bad page state in process kworker/u8:12  pfn:3739b8
> [  807.871887] Workqueue: rpciod rpc_async_schedule
> [  807.879358] page:ffffea000dce6e00 refcount:0 mapcount:0
> mapping:0000000000000000 index:0xffff8883739be000
> head:ffffea000dce6e00 order:3 compound_mapcount:0 compound_pincount:0
> [  807.885699] Call Trace:
> [  807.885702]  dump_stack+0x84/0xba
> [  807.890309] flags: 0x200000000010000(head)
> [  807.890312] raw: 0200000000010000 0000000000000000 0000000300000003
> 0000000000000000
> [  807.905929]  bad_page.cold+0x7b/0xac
> [  807.908374] raw: ffff8883739be000 0000000000040000 00000000ffffffff
> ffff8883bda6c841
> [  807.911683]  __free_pages_ok+0x95b/0xab0
> [  807.915772] page dumped because: page still charged to cgroup
> [  807.923506]  ? _raw_read_lock_irq+0x40/0x40
> [  807.927089] page->mem_cgroup:ffff8883bda6c841
> [  807.927105] Modules linked in: x86_pkg_temp_thermal
> [  807.934850]  ? __free_slab+0xcd/0x1f0
> [  807.961559]  __free_pages+0x42/0x50
> [  807.965045]  __free_slab+0xcd/0x1f0
> [  807.968537]  discard_slab+0x33/0x50
> [  807.972030]  __slab_free+0x309/0x340
> [  807.975607]  ? __slab_free+0x309/0x340
> [  807.979352]  ? qlist_free_all+0x25/0xc0
> [  807.983182]  ___cache_free+0x1a7/0x1f0
> [  807.986927]  qlist_free_all+0x3e/0xc0
> [  807.990593]  quarantine_reduce+0x11b/0x150
> [  807.994692]  __kasan_kmalloc.constprop.0+0xa3/0xe0
> [  807.999484]  kasan_slab_alloc+0xe/0x10
> [  808.003238]  __kmalloc_node_track_caller+0xfa/0x580
> [  808.008123]  ? __alloc_skb+0xd7/0x310
> [  808.011783]  __kmalloc_reserve.isra.0+0x2c/0x90
> [  808.016316]  __alloc_skb+0xd7/0x310
> [  808.019808]  ? __kmalloc_reserve.isra.0+0x90/0x90
> [  808.024515]  ? sk_reset_timer+0x15/0x70
> [  808.028354]  sk_stream_alloc_skb+0x96/0x4a0
> [  808.032539]  tcp_sendmsg_locked+0x657/0x1740
> [  808.036811]  ? tcp_rcv_established+0x44a/0xbe0
> [  808.041259]  ? tcp_data_queue+0x1c00/0x1c00
> [  808.045445]  ? tcp_sendpage+0x50/0x50
> [  808.049119]  ? __kasan_check_write+0x14/0x20
> [  808.053390]  ? _raw_spin_lock_bh+0x81/0xd0
> [  808.057481]  ? tcp_release_cb+0x46/0x1f0
> [  808.061399]  tcp_sendmsg+0x28/0x40
> [  808.064804]  inet_sendmsg+0x5f/0x90
> [  808.068290]  ? inet_send_prepare+0x110/0x110
> [  808.072562]  sock_sendmsg+0x92/0xa0
> [  808.076073]  xprt_sock_sendmsg+0x1d9/0x410
> [  808.080197]  ? csum_partial_copy_to_xdr+0x2f0/0x2f0
> [  808.085090]  ? __kasan_check_write+0x14/0x20
> [  808.089384]  ? _raw_spin_lock_irqsave+0x7c/0xd0
> [  808.093915]  ? quarantine_reduce+0x133/0x150
> [  808.098179]  ? kasan_unpoison_shadow+0x38/0x50
> [  808.102620]  ? recalibrate_cpu_khz+0x10/0x10
> [  808.106892]  xs_tcp_send_request+0x203/0x400
> [  808.111164]  ? xs_tcp_set_socket_timeouts.isra.0+0x150/0x150
> [  808.116823]  ? _raw_read_lock_irq+0x40/0x40
> [  808.121010]  ? _raw_read_lock_irq+0x40/0x40
> [  808.125196]  xprt_transmit+0x23f/0x770
> [  808.128947]  call_transmit+0xec/0x130
> [  808.132612]  ? call_bind+0x100/0x100
> [  808.136183]  __rpc_execute+0x137/0x680
> [  808.139937]  ? set_next_entity+0xa7/0x3a0
> [  808.143949]  ? rpc_sleep_on_priority_timeout+0x60/0x60
> [  808.149092]  ? __kasan_check_write+0x14/0x20
> [  808.153388]  ? finish_task_switch+0x9b/0x380
> [  808.157659]  ? __kasan_check_write+0x14/0x20
> [  808.161931]  rpc_async_schedule+0x48/0x80
> [  808.165936]  process_one_work+0x474/0x7b0
> [  808.169949]  worker_thread+0x7b/0x6a0
> [  808.173616]  ? wake_up_process+0x10/0x20
> [  808.177542]  ? process_one_work+0x7b0/0x7b0
> [  808.181725]  kthread+0x1aa/0x200
> [  808.184949]  ? kthread_create_on_node+0xd0/0xd0
> [  808.189476]  ret_from_fork+0x22/0x30
> [  808.193054] CPU: 0 PID: 3242 Comm: kworker/u8:12 Tainted: G    B
>          5.8.0-rc3-next-20200630 #1
> [  808.200915] BUG: Bad page state in process systemd-journal  pfn:4002fa
> [  808.202464] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.0b 07/27/2017
> [  808.202467] Workqueue: rpciod rpc_async_schedule
> [  808.208986] page:ffffea001000be80 refcount:0 mapcount:0
> mapping:0000000000000000 index:0x1
> [  808.216461] Call Trace:
> [  808.216464]  dump_stack+0x84/0xba
> [  808.221072] flags: 0x200000000000000()
> [  808.229326]  bad_page.cold+0x7b/0xac
> [  808.231769] raw: 0200000000000000 dead000000000100 dead000000000122
> 0000000000000000
> [  808.235079]  __free_pages_ok+0x95b/0xab0
> mem.c:147: PASS:[  808.238823] raw: 0000000000000001 0000000000100000
> 00000000ffffffff ffff88841cc82901
> [  808.242401]  __free_pages+0x42/0x50
> [  808.250131] page dumped because: page still charged to cgroup
> [  808.250132] page->mem_cgroup:ffff88841cc82901
> [  808.254058]  __free_slab+0xcd/0x1f0
> [  808.263174] Modules linked in: x86_pkg_temp_thermal
> [  808.266661]  ? stack_trace_save+0x8f/0xc0
> [  808.289125]  discard_slab+0x33/0x50
> [  808.292616]  unfreeze_partials.isra.0+0x11f/0x150
> [  808.297323]  ? __free_pages+0x31/0x50
> [  808.300989]  put_cpu_partial+0x8e/0xe0
> [  808.304741]  __slab_free+0x222/0x340
> [  808.308319]  ? qlist_free_all+0x25/0xc0
> [  808.312150]  ___cache_free+0x1a7/0x1f0
> [  808.315894]  qlist_free_all+0x3e/0xc0
> [  808.319553]  quarantine_reduce+0x11b/0x150
> [  808.323652]  __kasan_kmalloc.constprop.0+0xa3/0xe0
> [  808.328443]  ? xprt_alloc_slot+0x1ff/0x260
> [  808.332534]  kasan_slab_alloc+0xe/0x10
> [  808.336278]  kmem_cache_alloc_trace+0xc8/0x4d0
> [  808.340715]  xprt_alloc_slot+0x1ff/0x260
> [  808.344634]  xprt_do_reserve+0x3c/0x380
> [  808.348473]  xprt_reserve+0x94/0x100
> [  808.352073]  ? rpc_set_connect_timeout+0x90/0x90
> [  808.356688]  call_reserve+0x36/0x40
> [  808.360172]  __rpc_execute+0x137/0x680
> [  808.363915]  ? set_next_entity+0xa7/0x3a0
> [  808.367920]  ? rpc_sleep_on_priority_timeout+0x60/0x60
> [  808.373075]  ? __kasan_check_write+0x14/0x20
> [  808.377341]  ? finish_task_switch+0x9b/0x380
> [  808.381613]  rpc_async_schedule+0x48/0x80
> [  808.385619]  process_one_work+0x474/0x7b0
> [  808.389632]  worker_thread+0x7b/0x6a0
> [  808.393297]  ? wake_up_process+0x10/0x20
> [  808.397223]  ? process_one_work+0x7b0/0x7b0
> [  808.401408]  kthread+0x1aa/0x200
> [  808.404632]  ? kthread_create_on_node+0xd0/0xd0
> [  808.409156]  ret_from_fork+0x22/0x30
> [  808.412737] CPU: 1 PID: 332 Comm: systemd-journal Tainted: G    B
>           5.8.0-rc3-next-20200630 #1
> [  808.422232] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.0b 07/27/2017
> [  808.429703] Call Trace:
> [  808.432151]  dump_stack+0x84/0xba
> [  808.435494]  bad_page.cold+0x7b/0xac
> [  808.439081]  free_pcppages_bulk+0x33a/0xaa0
> [  808.443286]  ? free_pcp_prepare+0x180/0x180
> [  808.447473]  free_unref_page_commit.isra.0+0x143/0x160
> [  808.452612]  free_unref_page+0x4a/0x60
> [  808.456364]  __free_pages+0x31/0x50
> [  808.459856]  __free_slab+0xcd/0x1f0
> [  808.463341]  discard_slab+0x33/0x50
> [  808.466834]  unfreeze_partials.isra.0+0x11f/0x150
> [  808.471540]  ? __free_pages+0x42/0x50
> [  808.475207]  put_cpu_partial+0x8e/0xe0
> [  808.478959]  __slab_free+0x222/0x340
> [  808.482538]  ? qlist_free_all+0x25/0xc0
> [  808.486377]  ___cache_free+0x1a7/0x1f0
> [  808.490128]  qlist_free_all+0x3e/0xc0
> [  808.493788]  quarantine_reduce+0x11b/0x150
> [  808.497886]  __kasan_kmalloc.constprop.0+0xa3/0xe0
> [  808.502678]  ? prepare_creds+0x24/0x330
> [  808.506518]  kasan_slab_alloc+0xe/0x10
> [  808.510271]  kmem_cache_alloc+0xc6/0x4b0
> [  808.514197]  prepare_creds+0x24/0x330
> [  808.517863]  do_faccessat+0x247/0x3d0
> [  808.521527]  ? __ia32_sys_fallocate+0x60/0x60
> [  808.525880]  ? fpregs_assert_state_consistent+0x55/0x60
> [  808.531108]  ? __prepare_exit_to_usermode+0x77/0x1a0
> [  808.536077]  __x64_sys_access+0x33/0x40
> [  808.539929]  do_syscall_64+0x43/0x70
> [  808.543508]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  808.548557] RIP: 0033:0x7efdea32e237
> [  808.552128] Code: Bad RIP value.
> [  808.555353] RSP: 002b:00007ffd76bbfa58 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000015
> [  808.562909] RAX: ffffffffffffffda RBX: 00007ffd76bc2560 RCX: 00007efdea32e237
> [  808.570034] RDX: 00007efdea975be8 RSI: 0000000000000000 RDI: 00005633af888580
> [  808.577157] RBP: 00007ffd76bbfaa0 R08: 0000000000000000 R09: 0000000000000000
> [  808.584281] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> [  808.591406] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000009
> [  808.598532] BUG: Bad page state in process systemd-journal  pfn:418192
> [  808.605075] page:ffffea0010606480 refcount:0 mapcount:0
> mapping:0000000000000000 index:0x1
> [  808.613367] flags: 0x200000000000000()
> [  808.617115] raw: 0200000000000000 dead000000000100 dead000000000122
> 0000000000000000
> [  808.624851] raw: 0000000000000001 0000000000100000 00000000ffffffff
> ffff88841cc82601
> [  808.632580] page dumped because: page still charged to cgroup
> [  808.638318] page->mem_cgroup:ffff88841cc82601
> [  808.642668] Modules linked in: x86_pkg_temp_thermal
> [  808.647543] CPU: 1 PID: 332 Comm: systemd-journal Tainted: G    B
>           5.8.0-rc3-next-20200630 #1
> [  808.657013] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.0b 07/27/2017
> 
> 
> Full test log link,
> https://lkft.validation.linaro.org/scheduler/job/1535880#L11102
> 
> -- 
> Linaro LKFT
> https://lkft.linaro.org

-- 
Michal Hocko
SUSE Labs
