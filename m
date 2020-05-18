Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE71C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C34C920787
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgERJVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:21:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:36902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgERJVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:21:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7A7F2AF57;
        Mon, 18 May 2020 09:21:44 +0000 (UTC)
Date:   Mon, 18 May 2020 11:21:39 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] printk/kdb: Redirect printk messages into kdb in any
 context
Message-ID: <20200518092139.GK7340@linux-b0ei>
References: <1589273314-12060-1-git-send-email-sumit.garg@linaro.org>
 <20200512142533.ta4uejwmq5gchtlx@holly.lan>
 <CAFA6WYOV7oPbYE=9fXueYMacb5wv0r9T6F8tmECt-Eafe-fctw@mail.gmail.com>
 <20200514084230.GO17734@linux-b0ei>
 <CAFA6WYPSsgdAB-wJC0e2YkVkW0XsqQsu5wrn4iB4M-cwvS7z2g@mail.gmail.com>
 <20200515085021.GS17734@linux-b0ei>
 <20200515103308.GD42471@jagdpanzerIV.localdomain>
 <20200515134806.5cw4xxnxw7k3223l@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515134806.5cw4xxnxw7k3223l@holly.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-05-15 14:48:06, Daniel Thompson wrote:
> On Fri, May 15, 2020 at 07:33:08PM +0900, Sergey Senozhatsky wrote:
> > On (20/05/15 10:50), Petr Mladek wrote:
> > > kdb is able to stop kernel even in NMI context where printk() is redirected
> > > to the printk_safe() lockless variant. Move the check and redirect to kdb
> > > even in this case.
> > 
> > Can I please have some context what problem does this solve?
> > I can see that vkdb_printf() calls into console drivers:
> > 
> > 	for_each_console(c) {
> > 		c->write(c, cp, retlen - (cp - kdb_buffer));
> > 		touch_nmi_watchdog();
> > 	}
> > 
> > Is this guaranteed that we never execute this path from NMI?

Good question!

> Absolutely not.
> 
> The execution context for kdb is pretty much unique... we are running a
> debug mode with all CPUs parked in a holding loop with interrupts
> disabled. One CPU is at an unknown exception state and the others are
> either handling an IRQ or NMI depending on architecture[1].

This is similar to the situation in panic() when other CPUs are
stopped. It is more safe when the CPUs are stopped using IRQ.
There is higher danger of a deadlock when NMI is used.

bust_spinlock() is used in panic() to increase the chance to go over
the deadlock and actually see the messages. It is not enough when
more locks are used by the console (VT/TTY is good example). And
it is not guaranteed that the console will still work after
the hack is disabled by bust_spinlocks(0).


> However there are a number of factors that IMHO weigh in favour of
> allowing kdb to intercept here.
> 
> 1. kgdb/kdb are designed to work from NMI, modulo the bugs that are
>    undoubtedly present.

There is definitely a risk of deadlock when console drivers are called
by KDB. There are plans to create some lockless console drivers to
handle panic(). It might be usable in KDB as well.

The question is what are the expectations of KDB users. How often does
it happen that KDB does not work or that the system does not longer
work when continue is called in KDB?


> 2. A synchronous breakpoint (including an implicit breakpoint-on-oops)
>    from any code that executes with irqs disabled will exhibit most of
>    the same problems as an NMI but without waking up all the NMI logic.

Makes sense.


> 3. kdb_trap_printk is only set for *very* narrow time intervals by the
>    debug master (the single CPU in the system that is *not* in a
>    holding loop). Thus in all cases the system has already successfully
>    executed kdb_printf() several times before we ever call the printk()
>    interception code.
>
>    Or put another way, even if we did tickle a bug speculated about in
>    #1, it won't be the call to printk() that triggers it; we'd never
>    get that far!

Good point. I would say that this patch will not make the situation
worse. The code is called when KDB already uses consoles. It is just
a trick how to use existing code to print even more messages in
KDB context.

> 
> > If so, can this please be added to the commit message? A more
> > detailed commit message will help a lot.

What about?

"KDB has to get messages on consoles even when the system is stopped.
It uses kdb_printf() internally and calls console drivers on its own.

It uses a hack to reuse an existing code. It sets "kdb_trap_printk"
global variable to redirect even the normal printk() into the
kdb_printf() variant.

The variable "kdb_trap_printk" is checked in printk_default() and
it is ignored when printk is redirected to printk_safe in NMI context.
Solve this by moving the check into printk_func().

It is obvious that it is not fully safe. But it does not make things
worse. The console drivers are already called in this context by
kdb_printf() direct calls."

> I suspect Petr might prefer any future flames about kdb_printf() to be
> pointed at me rather than him ;-) so if adding anything to the commit
> message then I'd suggest it be based on the reasoning in #3 above.

This is fair :-)

Best Regards,
Petr
