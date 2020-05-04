Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B48C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51691206A5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgEDSim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:38:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:33938 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgEDSig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:38:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AAEA0ABCC;
        Mon,  4 May 2020 18:38:36 +0000 (UTC)
Date:   Mon, 4 May 2020 20:38:32 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [PATCH] percpu: Sync vmalloc mappings in pcpu_alloc() and
 free_percpu()
Message-ID: <20200504183832.GL8135@suse.de>
References: <20200429082854.6e1796b5@oasis.local.home>
 <20200429100731.201312a9@gandalf.local.home>
 <20200430141120.GA8135@suse.de>
 <20200430121136.6d7aeb22@gandalf.local.home>
 <20200430191434.GC8135@suse.de>
 <20200430211308.74a994dc@oasis.local.home>
 <1902703609.78863.1588300015661.JavaMail.zimbra@efficios.com>
 <20200430223919.50861011@gandalf.local.home>
 <20200504151236.GI8135@suse.de>
 <20200504134042.178409c3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504134042.178409c3@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 01:40:42PM -0400, Steven Rostedt wrote:
> Seems that your patch caused a lockdep splat on my box:
> 
>  ========================================================
>  WARNING: possible irq lock inversion dependency detected
>  5.7.0-rc3-test+ #249 Not tainted
>  --------------------------------------------------------
>  swapper/4/0 just changed the state of lock:
>  ffff9a580fdd75a0 (&ndev->lock){++.-}-{2:2}, at: mld_ifc_timer_expire+0x3c/0x350
>  but this lock took another, SOFTIRQ-unsafe lock in the past:
>   (pgd_lock){+.+.}-{2:2}
>  
>  
>  and interrupts could create inverse lock ordering between them.
>  
>  
>  other info that might help us debug this:
>   Possible interrupt unsafe locking scenario:
>  
>         CPU0                    CPU1
>         ----                    ----
>    lock(pgd_lock);
>                                 local_irq_disable();
>                                 lock(&ndev->lock);
>                                 lock(pgd_lock);
>    <Interrupt>
>      lock(&ndev->lock);
>  
>   *** DEADLOCK ***

Fair point, but this just shows how problematic it is to call something
like vmalloc_sync_mappings() from a lower-level kernel API function.
The obvious fix for this would be to make pgd_lock irq-safe, but this is
getting more and more ridiculous.

I know you don't like to have a vmalloc_sync_mappings() call in the
tracing code, but can you live with it until we get rid of this broken
interface?

My plan for this is to use a small bitmap to track in the vmalloc and
the (x86-)ioremap code at which levels of the page-tables the code made
changes and combine that with an architecture-dependend mask to decide
whether anything needs to be synced.

On x86-64 the sync would be necessary at most 64 times after boot, so I
think this will only have a very small performance impact, even with
VMAP_STACKS. And as a bonus it would also get rid of vmalloc faulting on
x86, fixing the issue with tracing too.

Regards,

	Joerg
