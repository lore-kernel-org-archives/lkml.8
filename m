Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899B4C2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603EA20787
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fP0hurwf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732706AbgDANp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:45:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54137 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732205AbgDANp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:45:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id d77so262915wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 06:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yqP5VhBuCdoyrV7l7vSXHqnqjJ1Em/QDV3tssppfUPY=;
        b=fP0hurwfvhuoMsdjeyIaPoxQ3AagH2HZf5jAZWkXExKAAlYQjR7RLLkVu8/NtMi3c1
         Af8+h0vnqXJ0UajzsoaNPxc/NzfW92/YT65KD7joHMcDo28OMZR8aJID/3fAslk5nlba
         CDyknTpT2nnbvRifkA2N8CtivYFYzK8mm1Ezd+BcS7OEHufdEXrJcH3dxw/VpkqGPTp0
         LivO0ZT+rURPSsyyuzIhtX5/pm10sJvTOS2JCNzHBViH9RX04SspP3ZD28Lgnu1He1Xe
         +coDG5pu3Fqpr/GV//vx9RilhQGZzzjKdfRoqKt0oVZwgYJ6r9emzURNZO1UxC7rQxMr
         msVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yqP5VhBuCdoyrV7l7vSXHqnqjJ1Em/QDV3tssppfUPY=;
        b=RstQlU3CrxTqTrg7F2m+E3bOh0eCnDHGrTkpu3EKsLvClpsDBFlvmfbrqkfu+PWAag
         P6p8YdA+sj58an48Qnj2xyP+NZk8vObZZDDqCgk5WPInMpVHVv4zWkA48ejlAPZ2zzbF
         tzIcqCsQw3ftbRxmhFMSWrZ/lhv8Wj+BLa5i/fDPlgfl61FCzVNqlhRpv47zQhhtKyvG
         oOlsB7BKcBxBcN2YRUtfCfLQG2jSXeKN9MuiWuho8KE7A+aKErhV0xdGiarbQDALiyTO
         M4UAC8/nylIV+T54GB2IL2Q4kO1XViRSt0pZgclLLeqz6SU8pf611fEKJQYw2un3GhUi
         Jrng==
X-Gm-Message-State: AGi0PubMTU1fjST86fnN47vb53wKuZeB/3Cl0VEMOeyL7THSJkD9V2HU
        WkjENCh7TrwpYCieTyypcYSpaUZDe/RcNvmqtFk=
X-Google-Smtp-Source: APiQypI9w98QvANpagF6bmYWjy2QpKyh6ptpLLLG8UYnlpjhqb4hWnkM/dlZ+IsCax6r+Uxm+SENP+gWpQjmtOQmGf4=
X-Received: by 2002:a1c:5506:: with SMTP id j6mr4490157wmb.127.1585748725151;
 Wed, 01 Apr 2020 06:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200401104156.11564-1-david@redhat.com> <20200401104156.11564-3-david@redhat.com>
In-Reply-To: <20200401104156.11564-3-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Wed, 1 Apr 2020 15:45:14 +0200
Message-ID: <CAM9Jb+juo_BhM6ag5xWL5vDqQQn7crtQpm7P2HCt9UUrtmd8cw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mm/page_alloc: fix watchdog soft lockups during set_zone_contiguous()
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Baoquan He <bhe@redhat.com>, Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Without CONFIG_PREEMPT, it can happen that we get soft lockups detected,
> e.g., while booting up.
>
> [  105.608900] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper/0:1]
> [  105.608933] Modules linked in:
> [  105.608933] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.6.0-next-20200331+ #4
> [  105.608933] Hardware name: Red Hat KVM, BIOS 1.11.1-4.module+el8.1.0+4066+0f1aadab 04/01/2014
> [  105.608933] RIP: 0010:__pageblock_pfn_to_page+0x134/0x1c0
> [  105.608933] Code: 85 c0 74 71 4a 8b 04 d0 48 85 c0 74 68 48 01 c1 74 63 f6 01 04 74 5e 48 c1 e7 06 4c 8b 05 cc 991
> [  105.608933] RSP: 0000:ffffb6d94000fe60 EFLAGS: 00010286 ORIG_RAX: ffffffffffffff13
> [  105.608933] RAX: fffff81953250000 RBX: 000000000a4c9600 RCX: ffff8fe9ff7c1990
> [  105.608933] RDX: ffff8fe9ff7dab80 RSI: 000000000a4c95ff RDI: 0000000293250000
> [  105.608933] RBP: ffff8fe9ff7dab80 R08: fffff816c0000000 R09: 0000000000000008
> [  105.608933] R10: 0000000000000014 R11: 0000000000000014 R12: 0000000000000000
> [  105.608933] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  105.608933] FS:  0000000000000000(0000) GS:ffff8fe1ff400000(0000) knlGS:0000000000000000
> [  105.608933] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  105.608933] CR2: 000000000f613000 CR3: 00000088cf20a000 CR4: 00000000000006f0
> [  105.608933] Call Trace:
> [  105.608933]  set_zone_contiguous+0x56/0x70
> [  105.608933]  page_alloc_init_late+0x166/0x176
> [  105.608933]  kernel_init_freeable+0xfa/0x255
> [  105.608933]  ? rest_init+0xaa/0xaa
> [  105.608933]  kernel_init+0xa/0x106
> [  105.608933]  ret_from_fork+0x35/0x40
>
> The issue becomes visible when having a lot of memory (e.g., 4TB)
> assigned to a single NUMA node - a system that can easily be created
> using QEMU. Inside VMs on a hypervisor with quite some memory
> overcommit, this is fairly easy to trigger.
>
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
>  mm/page_alloc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 084cabffc90d..cc4f07d52939 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1607,6 +1607,7 @@ void set_zone_contiguous(struct zone *zone)
>                 if (!__pageblock_pfn_to_page(block_start_pfn,
>                                              block_end_pfn, zone))
>                         return;
> +               cond_resched();
>         }
>
>         /* We confirm that there is no hole */
> --

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

> 2.25.1
>
>
