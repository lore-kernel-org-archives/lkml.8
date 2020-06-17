Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019BAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D078E20786
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFQNR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 09:17:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:54196 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbgFQNR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 09:17:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D269EAD11;
        Wed, 17 Jun 2020 13:17:30 +0000 (UTC)
Date:   Wed, 17 Jun 2020 15:17:42 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, ltp@lists.linux.it
Subject: Re: [LTP] [x86/entry] 2bbc68f837: ltp.ptrace08.fail
Message-ID: <20200617131742.GD8389@yuki.lan>
References: <87y2onbdtb.fsf@nanos.tec.linutronix.de>
 <8E41B15F-D567-4C52-94E9-367015480345@amacapital.net>
 <20200616132705.GW2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616132705.GW2531@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > >> FYI, we noticed the following commit (built with gcc-9):
> > >> 
> > >> commit: 2bbc68f8373c0631ebf137f376fbea00e8086be7 ("x86/entry: Convert Debug exception to IDTENTRY_DB")
> > >> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > Is the head of linux.git exposing the same problem or is this an
> > > intermittent failure, which only affects bisectability?
> > 
> > It sure looks deterministic:
> > 
> > ptrace08.c:62: BROK: Cannot find address of kernel symbol "do_debug"
> 
> ROFL

It's nice to have a good laugh, however I would really appreciate if any
of you would help me to fix the test.

The test in question is a regression test for:

commit f67b15037a7a50c57f72e69a6d59941ad90a0f0f
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Mar 26 15:39:07 2018 -1000

    perf/hwbp: Simplify the perf-hwbp code, fix documentation

    Annoyingly, modify_user_hw_breakpoint() unnecessarily complicates the
    modification of a breakpoint - simplify it and remove the pointless
    local variables.

And as far as I can tell it uses ptrace() with PTRACE_POKEUSER in order to
trigger it. But I'm kind of lost on how exactly we trigger the kernel
crash.

What is does is to write:

	(void*)1 to u_debugreg[0]
	(void*)1 to u_debugreg[7]
	do_debug addr to u_debugreg[0]

Looking at the kernel code the write to register 7 enables the breakpoints and
what we attempt here is to change an invalid address to a valid one after we
enabled the breakpoint but that's as far I can go.

So does anyone has an idea how to trigger the bug without the do_debug function
address? Would any valid kernel function address suffice?

-- 
Cyril Hrubis
chrubis@suse.cz
