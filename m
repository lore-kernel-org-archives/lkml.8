Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4126C2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1A120B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585755918;
	bh=FczJopU59L8DhcungXJvxscG4rZP/vl7weRmpFvYzHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UiEIBdaUF4onDAjcTq9pkmU1dN0PIiQM53m/jgD6D9FeMuz7xwMYM61Zt2yu7oqL7
	 2Lp5af+1XfQMdrbrLKNzIqVSZ/T9miksI2+pksyj3gevNBY/Z/7y9WthnCqG2Xpm53
	 aIetQmYKdK+PXD1twYBTUa9/eevxSY+DYFQT8LiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733084AbgDAPpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:45:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52544 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732705AbgDAPpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:45:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id t8so209813wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 08:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7MLCp8s76lSsk+DiQNRqZwGK9qED/+vAz643HBEYdNE=;
        b=lNzNVLI2Nfd2CBrNjO9sTS86rNEfEHux07KUBRgp9gyU7qXhISR2AQJcwHJFZlCYMI
         yD7o5PVyeFeg9V/Soc1k1EB/BuqZrEJJiWqvSUIoelDzilTs7YSGlZ25ITd5Ya1yQmsW
         ZFUabeb3lEUBZQu+c7odeQ4bCkR43ObNB/cCTfu2UN19caE0P6k21f+yxhQJ3/Eq2id/
         ISfyZq+Byci59uL+9HF8qMeXOe+j+T6uCpLDIYJtGoGLNTcO2bGk/3DX39HG3STUNNYg
         QSE1wnjhOWwrbTRgnlZ+7idwbeopB96UDeTKSXdT8SUq3VhQLfIqckwgfAjIc4OoJtrR
         PIfg==
X-Gm-Message-State: AGi0PuZkpD/J/BhHCG9f1NUZisKSwxnjIDqySS8G1GmcioA8a96quRgF
        Ic6EpwE7/iMcYlCUXJyuoQ0=
X-Google-Smtp-Source: APiQypLds04nQ/B6XGjbtMCMeYh3DCAV1tnCm3X254PimhKqhjiFHuQShP50PEAfs/DgIE2hGtyRZg==
X-Received: by 2002:a7b:cfc9:: with SMTP id f9mr5088227wmm.137.1585755915209;
        Wed, 01 Apr 2020 08:45:15 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id m8sm3012913wmc.28.2020.04.01.08.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 08:45:14 -0700 (PDT)
Date:   Wed, 1 Apr 2020 17:45:11 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yiqian Wei <yiwei@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Baoquan He <bhe@redhat.com>, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1 1/2] mm/page_alloc: fix RCU stalls during deferred
 page initialization
Message-ID: <20200401154511.GR22681@dhcp22.suse.cz>
References: <20200401104156.11564-1-david@redhat.com>
 <20200401104156.11564-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401104156.11564-2-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-04-20 12:41:55, David Hildenbrand wrote:
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

I believe the patch you depend on is a wrong way to go so please let's
wait until that settles down. But your cond_resched makes a perfect
sense. Just have it called $FOO pages - e.g. hotplug is once per
section. This is not bound to SPARSEMEM so you would have to use
a differen't constant but something along those lines would work.

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
>  mm/page_alloc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ca1453204e66..084cabffc90d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1877,6 +1877,7 @@ static int __init deferred_init_memmap(void *data)
>  			prev_nr_pages = nr_pages;
>  			pgdat->first_deferred_pfn = spfn;
>  			pgdat_resize_unlock(pgdat, &flags);
> +			cond_resched();
>  			goto again;
>  		}
>  	}
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
