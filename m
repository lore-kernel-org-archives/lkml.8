Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D455C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B782206CC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732827AbgDAN6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:58:36 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:37177 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732205AbgDAN6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:58:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0TuJBv59_1585749501;
Received: from ali-6c96cfdd1403.local(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0TuJBv59_1585749501)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 01 Apr 2020 21:58:21 +0800
Subject: Re: [PATCH v1 1/2] mm/page_alloc: fix RCU stalls during deferred page
 initialization
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Yiqian Wei <yiwei@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Baoquan He <bhe@redhat.com>, Oscar Salvador <osalvador@suse.de>
References: <20200401104156.11564-1-david@redhat.com>
 <20200401104156.11564-2-david@redhat.com>
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
Message-ID: <7edfa476-e213-bdfe-88e7-bfc4f771af66@linux.alibaba.com>
Date:   Wed, 1 Apr 2020 21:58:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200401104156.11564-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/4/1 18:41, David Hildenbrand wrote:
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
> ---
>   mm/page_alloc.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ca1453204e66..084cabffc90d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1877,6 +1877,7 @@ static int __init deferred_init_memmap(void *data)
>   			prev_nr_pages = nr_pages;
>   			pgdat->first_deferred_pfn = spfn;
>   			pgdat_resize_unlock(pgdat, &flags);
> +			cond_resched();
>   			goto again;
>   		}
>   	}

Reviewed-by: Shile Zhang<shile.zhang@linux.alibaba.com>


