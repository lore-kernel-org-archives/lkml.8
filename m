Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF45CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4F3C20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgGHJwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:52:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:41084 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728188AbgGHJwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:52:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B9AD1AED9;
        Wed,  8 Jul 2020 09:52:16 +0000 (UTC)
Date:   Wed, 8 Jul 2020 11:52:15 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Kurt Kanzenbach <kurt@linutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Raul Rangel <rrangel@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "S, Shirish" <Shirish.S@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: UART/TTY console deadlock
Message-ID: <20200708095215.GB4751@alley>
References: <20200630130534.GB145027@jagdpanzerIV.localdomain>
 <20200630180255.GD37466@atomide.com>
 <20200702051213.GB3450@jagdpanzerIV.localdomain>
 <20200702160514.GK37466@atomide.com>
 <20200703103241.GB182102@jagdpanzerIV.localdomain>
 <CAHp75VdvNi_LWv7QhEsm1vQikeiMpi68qmCwoVttjnp7oq0ahg@mail.gmail.com>
 <877dvg6ft6.fsf@kurt>
 <20200706144314.GB1485@jagdpanzerIV.localdomain>
 <87o8oqa1zy.fsf@kurt>
 <20200708080712.GC571@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708080712.GC571@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-07-08 17:07:12, Sergey Senozhatsky wrote:
> On (20/07/08 09:40), Kurt Kanzenbach wrote:
> > I'm not sure how this patch will help with the situation. Because at the
> > point of that THRE test the irq handler isn't registered. It's
> > registered a few lines below (up->ops->setup_irq()) meaning the irq line
> > has to be disabled if shared. Otherwise the kernel might detect a
> > spurious irq and disables it. That's at least my understanding of the
> > problem (see commit message from 54e53b2e8081 ("tty: serial: 8250: pass
> > IRQ shared flag to UART ports")).
> 
> So the only remaining approach then is to move
> disable_irq_nosync()/enable_irq() out of port->lock
> scope.

The ultimate solution is the offload of printk console handling to
kthreads. I know that it takes ages to get it in. But it will
also take ages to go around all the cyclic dependencies.

People tend to use printk() anywhere. And any lock taken by
printk() is prone to cause these problems.

We have tried to go around this in the scheduler code by
printk_deferred() and it was never-ending story. I believe
that the port->lock related cycles are another never-ending
story. And attempts to shuffle locks are always complicated
and error-prone. They require deep understanding of the affected
code paths. The approach with printk_deferred() has been pretty
safe at least.

Another approach might be to teach lockdep to remove lock chains
that were taken during the system initialization and will never
happen again. Or something like this.

I still believe that this is a false positive. Console that is being
initialized can't be used by printk() at the same moment. Locks taken
only when the console is being initialized can't cause deadlocks
when the fully initialized console is registered later.

Best Regards,
Petr
