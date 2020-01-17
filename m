Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADF6C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B475E21D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z6i13jfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbgAQWwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 17:52:01 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45746 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgAQWwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 17:52:01 -0500
Received: by mail-oi1-f193.google.com with SMTP id n16so23656545oie.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 14:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bPRY1mht45VkQ0r3COkN8IZorbBTnfRW7uTMCnHTRE0=;
        b=Z6i13jfNRgszkiyaik7lyEAAVG5xeSergpq0jyYAmn09fomUVv6yiq7uAN86DnOPPt
         5IpwyBbL2gNEO1sRGGaytaK3vMyYGHPDANhTUtjk3Kq/trAWPeCsqusygof4adCNpyuP
         GWMr3cO2ljXEwsHCYqTnjhhUncVpepTqUogLniTH3meeC2k/rFljqF1U2LGQSwLK7otI
         TXn4BgO0YMzDxORkpEhBRhIacygXmch95Qc+Ex7GdCrQkRlRJEGcec7s4pSLmCOgRyt+
         ztdHFz9/XiDEO7qwsuprUY2YYngQ0YcxihkvXDruOyoMl1rKAKOrvRrs/VvuJzQ6t1Ox
         /vQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bPRY1mht45VkQ0r3COkN8IZorbBTnfRW7uTMCnHTRE0=;
        b=YuR96SOOXAQgF4rMTQgsqeopbWlilEx43KTUEawL5nMsUpXRi3LmAqbmWogI7IeEmr
         UYOLfbBrO1TDRX0LC5JVb8TrvTmr6QplpXBxXDzWphRAh8+F4xRyQzCv0X4XpkHVT6pf
         qQ32rQneVScwxdOaFBcmXNy+K/ObOfNR5QQjwnim0ft7etYRE0sQLTTnpid0x4Ofew8R
         KzqETJVI+lHxsUT3zcq7JbF8YgAzH4IekgX4uAenyqy9yymDV5fzEcaGxl+VLFmpNoeo
         FunHXYOVo3rEdKNdwamvLsoTDsZHPAsFdCy87Jo6pUBRg7vFNK4nJorD0HHbpXnPJrlG
         c6lw==
X-Gm-Message-State: APjAAAW0M0Pft37jEbt4vI0BoTrKUiSDj6zqb4snnIEuZFWgKpKnTJDb
        t7P0+5d2yiD+7Uo/4guDpKQo+8LETihwst4544+MYQ==
X-Google-Smtp-Source: APXvYqw1nQ5WcChQLMUCNxlulVn4wohCILAMLAOqS6fv5lqjkkAKqK5gq7uqYTHhWtTvtwp3I3GiDp+2QAATZtwedXA=
X-Received: by 2002:aca:d4c1:: with SMTP id l184mr5259065oig.172.1579301520140;
 Fri, 17 Jan 2020 14:52:00 -0800 (PST)
MIME-Version: 1.0
References: <20200117164017.GA21582@paulmck-ThinkPad-P72> <3760F60F-4133-4FE1-9A4C-F335A8230285@lca.pw>
In-Reply-To: <3760F60F-4133-4FE1-9A4C-F335A8230285@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Fri, 17 Jan 2020 23:51:48 +0100
Message-ID: <CANpmjNPdfB=hrcXJbPzdisxnBUZW3JEK9UbTpTy+a20b=6OdJg@mail.gmail.com>
Subject: Re: [PATCH -rcu] kcsan: Make KCSAN compatible with lockdep
To:     Qian Cai <cai@lca.pw>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020 at 17:59, Qian Cai <cai@lca.pw> wrote:
>
>
>
> > On Jan 17, 2020, at 11:40 AM, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > True enough, but even if we reach the nirvana state where there is general
> > agreement on what constitutes a data race in need of fixing and KCSAN
> > faithfully checks based on that data-race definition, we need to handle
> > the case where someone introduces a bug that results in a destructive
> > off-CPU access to a per-CPU variable, which is exactly the sort of thing
> > that KCSAN is supposed to detect.  But suppose that this variable is
> > frequently referenced from functions that are inlined all over the place.
> >
> > Then that one bug might result in huge numbers of data-race reports in
> > a very short period of time, especially on a large system.
>
> It sounds like the case with debug_pagealloc where it prints a spam of those, and then the system is just dead.
>
> [   28.992752][  T394] Reported by Kernel Concurrency Sanitizer on:
> [   28.992752][  T394] CPU: 0 PID: 394 Comm: pgdatinit0 Not tainted 5.5.0-rc6-next-20200115+ #3
> [   28.992752][  T394] Hardware name: HP ProLiant XL230a Gen9/ProLiant XL230a Gen9, BIOS U13 01/22/2018
> [   28.992752][  T394] ===============================================================
> [   28.992752][  T394] ==================================================================
> [   28.992752][  T394] BUG: KCSAN: data-race in __change_page_attr / __change_page_attr
> [   28.992752][  T394]
> [   28.992752][  T394] read to 0xffffffffa01a6de0 of 8 bytes by task 395 on cpu 16:
> [   28.992752][  T394]  __change_page_attr+0xe81/0x1620
> [   28.992752][  T394]  __change_page_attr_set_clr+0xde/0x4c0
> [   28.992752][  T394]  __set_pages_np+0xcc/0x100
> [   28.992752][  T394]  __kernel_map_pages+0xd6/0xdb
> [   28.992752][  T394]  __free_pages_ok+0x1a8/0x730
> [   28.992752][  T394]  __free_pages+0x51/0x90
> [   28.992752][  T394]  __free_pages_core+0x1c7/0x2c0
> [   28.992752][  T394]  deferred_free_range+0x59/0x8f
> [   28.992752][  T394]  deferred_init_max21d
> [   28.992752][  T394]  deferred_init_memmap+0x14a/0x1c1
> [   28.992752][  T394]  kthread+0x1e0/0x200
> [   28.992752][  T394]  ret_from_fork+0x3a/0x50
> [   28.992752][  T394]
> [   28.992752][  T394] write to 0xffffffffa01a6de0 of 8 bytes by task 394 on cpu 0:
> [   28.992752][  T394]  __change_page_attr+0xe9c/0x1620
> [   28.992752][  T394]  __change_page_attr_set_clr+0xde/0x4c0
> [   28.992752][  T394]  __set_pages_np+0xcc/0x100
> [   28.992752][  T394]  __kernel_map_pages+0xd6/0xdb
> [   28.992752][  T394]  __free_pages_ok+0x1a8/0x730
> [   28.992752][  T394]  __free_pages+0x51/0x90
> [   28.992752][  T394]  __free_pages_core+0x1c7/0x2c0
> [   28.992752][  T394]  deferred_free_range+0x59/0x8f
> [   28.992752][  T394]  deferred_init_maxorder+0x1d6/0x21d
> [   28.992752][  T394]  deferred_init_memmap+0x14a/0x1c1
> [   28.992752][  T394]  kthread+0x1e0/0x200
> [   28.992752][  T394]  ret_from_fork+0x3a/0x50
>
> It point out to this,
>
>                 pgprot_val(new_prot) &= ~pgprot_val(cpa->mask_clr);
>                 pgprot_val(new_prot) |= pgprot_val(cpa->mask_set);
>
>                 cpa_inc_4k_install();
>                 /* Hand in lpsize = 0 to enforce the protection mechanism */
>                 new_prot = static_protections(new_prot, address, pfn, 1, 0,
>                                               CPA_PROTECT);
>
> In static_protections(),
>
>         /*
>          * There is no point in checking RW/NX conflicts when the requested
>          * mapping is setting the page !PRESENT.
>          */
>         if (!(pgprot_val(prot) & _PAGE_PRESENT))
>                 return prot;
>
> Is there a data race there?

Yes. I was finally able to reproduce this data race on linux-next (my
system doesn't crash though, maybe not enough cores?). Here is a trace
with line numbers:

read to 0xffffffffaa59a000 of 8 bytes by interrupt on cpu 7:
 cpa_inc_4k_install arch/x86/mm/pat/set_memory.c:131 [inline]
 __change_page_attr+0x10cf/0x1840 arch/x86/mm/pat/set_memory.c:1514
 __change_page_attr_set_clr+0xce/0x490 arch/x86/mm/pat/set_memory.c:1636
 __set_pages_np+0xc4/0xf0 arch/x86/mm/pat/set_memory.c:2148
 __kernel_map_pages+0xb0/0xc8 arch/x86/mm/pat/set_memory.c:2178
 kernel_map_pages include/linux/mm.h:2719 [inline]
<snip>

write to 0xffffffffaa59a000 of 8 bytes by task 1 on cpu 6:
 cpa_inc_4k_install arch/x86/mm/pat/set_memory.c:131 [inline]
 __change_page_attr+0x10ea/0x1840 arch/x86/mm/pat/set_memory.c:1514
 __change_page_attr_set_clr+0xce/0x490 arch/x86/mm/pat/set_memory.c:1636
 __set_pages_p+0xc4/0xf0 arch/x86/mm/pat/set_memory.c:2129
 __kernel_map_pages+0x2e/0xc8 arch/x86/mm/pat/set_memory.c:2176
 kernel_map_pages include/linux/mm.h:2719 [inline]
<snip>

Both accesses are due to the same "cpa_4k_install++" in
cpa_inc_4k_install. Now you can see that a data race here could be
potentially undesirable: depending on compiler optimizations or how
x86 executes a non-LOCK'd increment, you may lose increments, corrupt
the counter, etc. Since this counter only seems to be used for
printing some stats, this data race itself is unlikely to cause harm
to the system though.

Thanks,
-- Marco
