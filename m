Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71412C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462CB2073B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="QW7sB8g0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbgDANSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:18:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34518 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732651AbgDANSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:18:17 -0400
Received: by mail-ed1-f65.google.com with SMTP id o1so11306986edv.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 06:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KWH9z72+z1R71Nh/in3RjDnuDGIb7FapUsMRnj9HRHw=;
        b=QW7sB8g0O4DVk5CYG0zQnM7h1Jsg+8jn2+hpDAo7TxCXJjAAplvpeGUigFGymPA4Y0
         8kWmXyj7ZEfRQ2N4HKedHyizMeoVTaJIVunu/hFY737+zKuEfHVgc3lamESUPUGgDN42
         3EwnZGhZ0HNcusUAgbiarzNmuPlQ18QohJY6o27x7jadYwZOWa6pbfKewCnIxj8n4C/h
         jhoB9f/69p3h3yqqBK7rit30j+Cc8Idz+JVRuKdp8ajS6Xc1BNvJ5sTp+iY+eK8Q6KLn
         ElF1pq17GZKEH1BlDY/80pPJAwEWKGBKb3kHJsKllJHg2XHEgZ1jssLLfUnStMosX9e4
         hGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KWH9z72+z1R71Nh/in3RjDnuDGIb7FapUsMRnj9HRHw=;
        b=dKch/bdRpX2VLV+7PaBl5GCcYFxnaOV5NOa3T4R5v2oPsIz70XH84sZp7D16fZM1Ay
         KuSm59hmvdLUOgb7SYpb649nwE7mV9gOQeEPHb0qTP86KTVkFS87AnqjJsDC+6YcSIYg
         vamK5izICQ4Z+TTnSoHQNn2Fp4apoVD4P0RmUU6QbciDD5COXug3ZAzIYJ+bH74fAVcz
         RiY6DzWbUZbNcVr1ZZsI2Rgfq5nwbKcJpBicjOlBNIydPVmN72O2b0Wgv6HgKc4VigE4
         hnYFh5cBBNSTTxue72pi8IxuqnAH3IcDWU1RkUwa7Aayd2KlxXaa4kymrpOw+nIbsRUw
         N9OQ==
X-Gm-Message-State: ANhLgQ2nY9B+qU19xRmkxn0CcPVOtMXK9LWsB+SJvHws1HUUwvEW6U7f
        OyQFO5udOt9nscRV43w/LstK975iS/8ShR0pXDcUsA==
X-Google-Smtp-Source: ADFU+vt4zKObf9zLA5ebWaYtoCFwT8BFCVqAallGcjJGUSAKf5mG54aFnSiE0cWiHZZtl9xQtEBU2MjPplgrqHmapqY=
X-Received: by 2002:a17:907:2143:: with SMTP id rk3mr8743750ejb.50.1585747095048;
 Wed, 01 Apr 2020 06:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200401104156.11564-1-david@redhat.com> <20200401104156.11564-2-david@redhat.com>
In-Reply-To: <20200401104156.11564-2-david@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 1 Apr 2020 09:18:04 -0400
Message-ID: <CA+CK2bD=TjuyXz6uXBmBTY2KtLTKZDY3PXMCV-8tsL20tE8pSA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mm/page_alloc: fix RCU stalls during deferred page initialization
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Yiqian Wei <yiwei@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Baoquan He <bhe@redhat.com>, Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 6:42 AM David Hildenbrand <david@redhat.com> wrote:
>
> With CONFIG_DEFERRED_STRUCT_PAGE_INIT and without CONFIG_PREEMPT, it can
> happen that we get RCU stalls detected when booting up.
>
> [   60.474005] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [   60.475000] rcu:  1-...0: (0 ticks this GP) idle=02a/1/0x4000000000000000 softirq=1/1 fqs=15000
> [   60.475000] rcu:  (detected by 0, t=60002 jiffies, g=-1199, q=1)
> [   60.475000] Sending NMI from CPU 0 to CPUs 1:
> [    1.760091] NMI backtrace for cpu 1
> [    1.760091] CPU: 1 PID: 20 Comm: pgdatinit0 Not tainted 4.18.0-147.9.1.el8_1.x86_64 #1
> [    1.760091] Hardware name: Red Hat KVM, BIOS 1.13.0-1.module+el8.2.0+5520+4e5817f3 04/01/2014
> [    1.760091] RIP: 0010:__init_single_page.isra.65+0x10/0x4f
> [    1.760091] Code: 48 83 cf 63 48 89 f8 0f 1f 40 00 48 89 c6 48 89 d7 e8 6b 18 80 ff 66 90 5b c3 31 c0 b9 10 00 00 00 49 89 f8 48 c1 e6 33 f3 ab <b8> 07 00 00 00 48 c1 e2 36 41 c7 40 34 01 00 00 00 48 c1 e0 33 41
> [    1.760091] RSP: 0000:ffffba783123be40 EFLAGS: 00000006
> [    1.760091] RAX: 0000000000000000 RBX: fffffad34405e300 RCX: 0000000000000000
> [    1.760091] RDX: 0000000000000000 RSI: 0010000000000000 RDI: fffffad34405e340
> [    1.760091] RBP: 0000000033f3177e R08: fffffad34405e300 R09: 0000000000000002
> [    1.760091] R10: 000000000000002b R11: ffff98afb691a500 R12: 0000000000000002
> [    1.760091] R13: 0000000000000000 R14: 000000003f03ea00 R15: 000000003e10178c
> [    1.760091] FS:  0000000000000000(0000) GS:ffff9c9ebeb00000(0000) knlGS:0000000000000000
> [    1.760091] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.760091] CR2: 00000000ffffffff CR3: 000000a1cf20a001 CR4: 00000000003606e0
> [    1.760091] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    1.760091] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    1.760091] Call Trace:
> [    1.760091]  deferred_init_pages+0x8f/0xbf
> [    1.760091]  deferred_init_memmap+0x184/0x29d
> [    1.760091]  ? deferred_free_pages.isra.97+0xba/0xba
> [    1.760091]  kthread+0x112/0x130
> [    1.760091]  ? kthread_flush_work_fn+0x10/0x10
> [    1.760091]  ret_from_fork+0x35/0x40
> [   89.123011] node 0 initialised, 1055935372 pages in 88650ms
>
> The issue becomes visible when having a lot of memory (e.g., 4TB)
> assigned to a single NUMA node - a system that can easily be created
> using QEMU. Inside VMs on a hypervisor with quite some memory
> overcommit, this is fairly easy to trigger.
>
> Adding the cond_resched() makes RCU happy.
>
> Reported-by: Yiqian Wei <yiwei@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> Cc: Shile Zhang <shile.zhang@linux.alibaba.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Alexander Duyck <alexander.duyck@gmail.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
