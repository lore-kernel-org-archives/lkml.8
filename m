Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB4EC4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD0F821707
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtE5bpBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgD0TAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:00:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25440 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726260AbgD0TAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588014020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I73VP9Xk5l9zmFd2/zcIV/36T4p5TP4/TC/4KQCosK0=;
        b=HtE5bpBWDXRSw7FNir5nmBX+mDhSK7mPY6xYJhE8VeZs1yDdbZvohoZZ5wXbj0Ov1AhRti
        tlrfsQqbrhZ29vmMwWretzJmM4juTF4YJhLInjEvUsKIY8NhP8rSooXcInrnCYSojOe0KA
        leLu3WVS4LD56tx5KUu4+BWxm0+VilE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-W52pAH1lPICPqU7_38sNqg-1; Mon, 27 Apr 2020 15:00:16 -0400
X-MC-Unique: W52pAH1lPICPqU7_38sNqg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 590D3108BD0C;
        Mon, 27 Apr 2020 19:00:13 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-176.rdu2.redhat.com [10.10.112.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DD5928544;
        Mon, 27 Apr 2020 19:00:05 +0000 (UTC)
Subject: Re: [PATCH 2/2] mm/slub: Fix slab_mutex circular locking problem in
 slab_attr_store()
To:     Qian Cai <cai@lca.pw>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>
References: <20200424151225.10966-1-longman@redhat.com>
 <20200424151225.10966-2-longman@redhat.com>
 <29F1A08C-3622-452E-A98C-C952DA6AE681@lca.pw>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <da54d822-b33f-8001-1cbf-a9a66c8f26b2@redhat.com>
Date:   Mon, 27 Apr 2020 15:00:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <29F1A08C-3622-452E-A98C-C952DA6AE681@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/20 3:44 PM, Qian Cai wrote:
>
>> On Apr 24, 2020, at 11:12 AM, Waiman Long <longman@redhat.com> wrote:
>>
>> The following lockdep splat was reported:
>>
>>   [  176.241923] ======================================================
>>   [  176.241924] WARNING: possible circular locking dependency detected
>>   [  176.241926] 4.18.0-172.rt13.29.el8.x86_64+debug #1 Not tainted
>>   [  176.241927] ------------------------------------------------------
>>   [  176.241929] slub_cpu_partia/5371 is trying to acquire lock:
>>   [  176.241930] ffffffffa0b83718 (slab_mutex){+.+.}, at: slab_attr_store+0x6b/0xe0
>>   [  176.241941]
>>                  but task is already holding lock:
>>   [  176.241942] ffff88bb6d8b83c8 (kn->count#103){++++}, at: kernfs_fop_write+0x1cc/0x400
>>   [  176.241947]
>>                  which lock already depends on the new lock.
>>
>>   [  176.241949]
>>                  the existing dependency chain (in reverse order) is:
>>   [  176.241949]
>>                  -> #1 (kn->count#103){++++}:
>>   [  176.241955]        __kernfs_remove+0x616/0x800
>>   [  176.241957]        kernfs_remove_by_name_ns+0x3e/0x80
>>   [  176.241959]        sysfs_slab_add+0x1c6/0x330
>>   [  176.241961]        __kmem_cache_create+0x15f/0x1b0
>>   [  176.241964]        create_cache+0xe1/0x220
>>   [  176.241966]        kmem_cache_create_usercopy+0x1a3/0x260
>>   [  176.241967]        kmem_cache_create+0x12/0x20
>>   [  176.242076]        mlx5_init_fs+0x18d/0x1a00 [mlx5_core]
>>   [  176.242100]        mlx5_load_one+0x3b4/0x1730 [mlx5_core]
>>   [  176.242124]        init_one+0x901/0x11b0 [mlx5_core]
>>   [  176.242127]        local_pci_probe+0xd4/0x180
>>   [  176.242131]        work_for_cpu_fn+0x51/0xa0
>>   [  176.242133]        process_one_work+0x91a/0x1ac0
>>   [  176.242134]        worker_thread+0x536/0xb40
>>   [  176.242136]        kthread+0x30c/0x3d0
>>   [  176.242140]        ret_from_fork+0x27/0x50
>>   [  176.242140]
>>                  -> #0 (slab_mutex){+.+.}:
>>   [  176.242145]        __lock_acquire+0x22cb/0x48c0
>>   [  176.242146]        lock_acquire+0x134/0x4c0
>>   [  176.242148]        _mutex_lock+0x28/0x40
>>   [  176.242150]        slab_attr_store+0x6b/0xe0
>>   [  176.242151]        kernfs_fop_write+0x251/0x400
>>   [  176.242154]        vfs_write+0x157/0x460
>>   [  176.242155]        ksys_write+0xb8/0x170
>>   [  176.242158]        do_syscall_64+0x13c/0x710
>>   [  176.242160]        entry_SYSCALL_64_after_hwframe+0x6a/0xdf
>>   [  176.242161]
>>                  other info that might help us debug this:
>>
>>   [  176.242161]  Possible unsafe locking scenario:
>>
>>   [  176.242162]        CPU0                    CPU1
>>   [  176.242163]        ----                    ----
>>   [  176.242163]   lock(kn->count#103);
>>   [  176.242165]                                lock(slab_mutex);
>>   [  176.242166]                                lock(kn->count#103);
>>   [  176.242167]   lock(slab_mutex);
>>   [  176.242169]
>>                   *** DEADLOCK ***
>>
>>   [  176.242170] 3 locks held by slub_cpu_partia/5371:
>>   [  176.242170]  #0: ffff888705e3a800 (sb_writers#4){.+.+}, at: vfs_write+0x31c/0x460
>>   [  176.242174]  #1: ffff889aeec4d658 (&of->mutex){+.+.}, at: kernfs_fop_write+0x1a9/0x400
>>   [  176.242177]  #2: ffff88bb6d8b83c8 (kn->count#103){++++}, at: kernfs_fop_write+0x1cc/0x400
>>   [  176.242180]
>>                  stack backtrace:
>>   [  176.242183] CPU: 36 PID: 5371 Comm: slub_cpu_partia Not tainted 4.18.0-172.rt13.29.el8.x86_64+debug #1
>>   [  176.242184] Hardware name: AMD Corporation DAYTONA_X/DAYTONA_X, BIOS RDY1005C 11/22/2019
>>   [  176.242185] Call Trace:
>>   [  176.242190]  dump_stack+0x9a/0xf0
>>   [  176.242193]  check_noncircular+0x317/0x3c0
>>   [  176.242195]  ? print_circular_bug+0x1e0/0x1e0
>>   [  176.242199]  ? native_sched_clock+0x32/0x1e0
>>   [  176.242202]  ? sched_clock+0x5/0x10
>>   [  176.242205]  ? sched_clock_cpu+0x238/0x340
>>   [  176.242208]  __lock_acquire+0x22cb/0x48c0
>>   [  176.242213]  ? trace_hardirqs_on+0x10/0x10
>>   [  176.242215]  ? trace_hardirqs_on+0x10/0x10
>>   [  176.242218]  lock_acquire+0x134/0x4c0
>>   [  176.242220]  ? slab_attr_store+0x6b/0xe0
>>   [  176.242223]  _mutex_lock+0x28/0x40
>>   [  176.242225]  ? slab_attr_store+0x6b/0xe0
>>   [  176.242227]  slab_attr_store+0x6b/0xe0
>>   [  176.242229]  ? sysfs_file_ops+0x160/0x160
>>   [  176.242230]  kernfs_fop_write+0x251/0x400
>>   [  176.242232]  ? __sb_start_write+0x26a/0x3f0
>>   [  176.242234]  vfs_write+0x157/0x460
>>   [  176.242237]  ksys_write+0xb8/0x170
>>   [  176.242239]  ? __ia32_sys_read+0xb0/0xb0
>>   [  176.242242]  ? do_syscall_64+0xb9/0x710
>>   [  176.242245]  do_syscall_64+0x13c/0x710
>>   [  176.242247]  entry_SYSCALL_64_after_hwframe+0x6a/0xdf
>>
>> There was another lockdep splat generated by echoing "1" to
>> "/sys/kernel/slab/fs_cache/shrink":
>>
>> [  445.231443] Chain exists of:
>>                  cpu_hotplug_lock --> mem_hotplug_lock --> slab_mutex
>>
>> [  445.242025]  Possible unsafe locking scenario:
>>
>> [  445.247977]        CPU0                    CPU1
>> [  445.252529]        ----                    ----
>> [  445.257082]   lock(slab_mutex);
>> [  445.260239]                                lock(mem_hotplug_lock);
>> [  445.266452]                                lock(slab_mutex);
>> [  445.272141]   lock(cpu_hotplug_lock);
>>
>> So it is problematic to use slab_mutex to iterate the list of
>> child memcgs with for_each_memcg_cache(). Fortunately, there is
>> another way to do child memcg iteration by going through the array
>> entries in memcg_params.memcg_caches while holding a read lock on
>> memcg_cache_ids_sem.
>>
>> To avoid other possible circular locking problems, we only take a
>> reference to the child memcgs and store their addresses while holding
>> memcg_cache_ids_sem. The actual store method is called for each of the
>> child memcgs after releasing the lock.
> Even on x86 where it compiles, this patch is insufficient to prevent a lockdep splat,
> because there are still cpu_hotplug_lock and mem_hotplug_lock in the way.
>
Yes, I was aware of that. Will include additional patch in v2 to address 
that.

Thanks,
Longman

