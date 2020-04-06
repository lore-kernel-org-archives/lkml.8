Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF18C2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 07:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA682206F8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 07:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rd1wk9r/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgDFHC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 03:02:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40666 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgDFHC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 03:02:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id s8so13905333wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 00:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vqfroo7sRYSBOLw6kf5costaUhuKgoZCaUXjGN0qJ04=;
        b=rd1wk9r/w39Q86DGuCWqlsgvQgDAVOe4F3iTkQksaCY6uPrGOvn/XBaklFaBxektzM
         tMp74mBPJkwT8n7H7xT7484wJ6qE/ajAg15WpgnD2QqabErIOHvpAC+MAotNViUNFcA6
         j5f50ODvlg00G4o3FXpN6fP6qhO9aCy0Ba9llgq3JqU4DGt+2TmO3WH4s6JHrwzt8A5Q
         IiM2f5yXKcFO0kSoatbWiZo8B/vTacAc/NGme6Y8x+gA8Dk69XjY/uZ+RqhQAKmvl5gW
         rdp5SdW4M20uu9+WPgigibIlF5ruw2pRTpFHAgUIcMPe0rsWBewBco10QqA7RgGmb+CL
         oIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vqfroo7sRYSBOLw6kf5costaUhuKgoZCaUXjGN0qJ04=;
        b=J+mtCpTtaCUcx3KMN6wUf3usYNIa9NI2SRQgvc4fwE04NJRHHjJSguwVt0w/jYicup
         ssRqnKwNQ/QoP/ExjNl/8A0HWan7rzBUHzU3EFYOdHFeJQ+PioHwLmdTBWx2BAQdAGyr
         T7TT66iVMSdLGS2gvRlj7kpCiXOJkDcwsG9xmfH1MaHTTTReohL5bVoTORaKzF9QYap1
         Oqq2Yu+K1gihoF79siID720K8mimEjRH4hXmtQVbiunciw/vhWg9O2uDKqzIg4YbCC5M
         u95n/qu8rmgkB9cR9IEmXTnQKj0/G/wR7CarqSmXJgUwosKZQbvBtdXrzJAPQfB69136
         tePw==
X-Gm-Message-State: AGi0PuYnr5IMNcFfGLO3ZRdf6z/H7qnQVCaXWz0aFfY1T77Nd6eB5B9f
        Fvz/l6bDZ8X1cz2Jdem/VCQjrGG8MTJnjIuJmRs=
X-Google-Smtp-Source: APiQypLrVc6Ogyp/boS/D4XzD2hjNkyCS3CVnGYhVP/4tOzreypyRELv25mDHTUISzhfH3TRvA3DslbF0AZuhndRoIM=
X-Received: by 2002:a05:6000:187:: with SMTP id p7mr10071228wrx.196.1586156577367;
 Mon, 06 Apr 2020 00:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200403140952.17177-1-pasha.tatashin@soleen.com> <20200403140952.17177-4-pasha.tatashin@soleen.com>
In-Reply-To: <20200403140952.17177-4-pasha.tatashin@soleen.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Mon, 6 Apr 2020 09:02:46 +0200
Message-ID: <CAM9Jb+jciG8J=Mbejg7PygmFayucGG1DQcFDNvqkxLpAY9aFqA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm: call cond_resched() from deferred_init_memmap()
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        Dan Williams <dan.j.williams@intel.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        David Hildenbrand <david@redhat.com>, jmorris@namei.org,
        sashal@kernel.org, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 5ffa8d7e5545..deacfe575872 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1810,7 +1810,7 @@ static int __init deferred_init_memmap(void *data)
>          */
>         while (spfn < epfn) {
>                 nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
> -               touch_nmi_watchdog();
> +               cond_resched();
>         }
>  zone_empty:
>         /* Sanity check that the next zone really is unpopulated */
> --
> 2.17.1

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

>
>
