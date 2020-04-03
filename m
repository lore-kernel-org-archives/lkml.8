Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7600FC2BA18
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C77E207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585923154;
	bh=iRmggb+taiBXgUFGXmbCvZ+oVSA6i14EAX1CgaRRrTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B1RJCExA028+K6mGj1uTOWQdq2cbl9HiP+Lk05NGF8ZhEGt65HK9dIxVh0ZM0mDSj
	 XnWhJqwmPRRa8C9xMpcqKbylaLFMfoc2TMQ6/xze7F1EM+UN9i8sbufZ5/FON8yDqT
	 E1DnOkaLiyoiN0LSXZknuONzsMCHfb5Kl+NBqYxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390867AbgDCOMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:12:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40180 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgDCOMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:12:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id a81so7844919wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 07:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1IqBfN0RcaylL/K9nsfpXvuyM6HU2luRLwUIxShGPkI=;
        b=GFPi76+uRer8QD8ebK1PfCxpW+pG2AliMrRG+LpPgoP4rBL+5jGUOk6CWosVI4ssCh
         LcpTigBMZ/YI/TZXMJnIW2nayOyZhE0SObO2uoV6XydtINH8Ov8Mr+01JPRDCPN7t+y/
         9c9p66Ju7KwiTxEakY1r8GH9PGKBK8p93EqxZ0BobOgTzDtPoH9FDZNK6JZ+96N90/Wu
         Ol9u1LMKlcphBvaru1QTh9AVoh/o4n1+9Atv3GKEHYazpBKB3PCgagiCY5nB4tu+F3m4
         0RSgwADoto24nJkxGVQ9/dAdhw6/T0PgYdiyO9EVnkwNsq1uW9UmUUdJGaznR4rlKm8o
         R0xw==
X-Gm-Message-State: AGi0Puaemt3TUYpSTjr8OND+2UvSoR+l0xZ7sxICrxOfoPuXl0XtH0Ez
        WeZHBymuTHplj/ufmAS6aww=
X-Google-Smtp-Source: APiQypKZ502RN6wMfpZLASt/CYdVxzgaXmEtanfoZfqElqChVUZvSXHDaWa3lTuqu3hf+EnXdwDOMg==
X-Received: by 2002:a05:600c:552:: with SMTP id k18mr9447909wmc.180.1585923150789;
        Fri, 03 Apr 2020 07:12:30 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id a2sm12141202wrp.13.2020.04.03.07.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 07:12:29 -0700 (PDT)
Date:   Fri, 3 Apr 2020 16:12:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, dan.j.williams@intel.com,
        shile.zhang@linux.alibaba.com, daniel.m.jordan@oracle.com,
        ktkhai@virtuozzo.com, david@redhat.com, jmorris@namei.org,
        sashal@kernel.org, vbabka@suse.cz
Subject: Re: [PATCH v4 3/3] mm: call cond_resched() from
 deferred_init_memmap()
Message-ID: <20200403141228.GF22681@dhcp22.suse.cz>
References: <20200403140952.17177-1-pasha.tatashin@soleen.com>
 <20200403140952.17177-4-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403140952.17177-4-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 03-04-20 10:09:52, Pavel Tatashin wrote:
> Now that deferred pages are initialized with interrupts enabled we can
> replace touch_nmi_watchdog() with cond_resched(), as it was before
> 3a2d7fa8a3d5.
> 
> For now, we cannot do the same in deferred_grow_zone() as it is still
> initializes pages with interrupts disabled.
> 
> This change fixes RCU problem described:
> linux-mm/20200401104156.11564-2-david@redhat.com
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
> Fixes: 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred pages")
> Cc: stable@vger.kernel.org # 4.17+
> 
> Reported-by: Yiqian Wei <yiwei@redhat.com>
> Tested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 5ffa8d7e5545..deacfe575872 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1810,7 +1810,7 @@ static int __init deferred_init_memmap(void *data)
>  	 */
>  	while (spfn < epfn) {
>  		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
> -		touch_nmi_watchdog();
> +		cond_resched();
>  	}
>  zone_empty:
>  	/* Sanity check that the next zone really is unpopulated */
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
