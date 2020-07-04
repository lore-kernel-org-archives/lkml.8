Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AA4C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726CF208B8
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgGDL7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 07:59:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:63531 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbgGDL7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 07:59:12 -0400
IronPort-SDR: O1b3NB7SBkFbW2qpIn2jpZZGJVSE7kyMzE7unIxxN6WnsStPngWO6VZ/fcVA4+KkvPJLYPKMVi
 v8zeeuumwJnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9671"; a="144762000"
X-IronPort-AV: E=Sophos;i="5.75,311,1589266800"; 
   d="scan'208";a="144762000"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2020 04:59:12 -0700
IronPort-SDR: miEnGm4b7euory5PpdTK2HOjhO4L4K8LtZ1pd60TUjOByRS/jTl6H9qMP+PsP0gvPbJ+Sy5ONB
 IMeQ2+y53aoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,311,1589266800"; 
   d="scan'208";a="313513868"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 04 Jul 2020 04:59:09 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jrgp4-00HYEf-6O; Sat, 04 Jul 2020 14:59:10 +0300
Date:   Sat, 4 Jul 2020 14:59:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>, Petr Mladek <pmladek@suse.com>,
        Raul Rangel <rrangel@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kurt@linutronix.de, "S, Shirish" <Shirish.S@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: UART/TTY console deadlock
Message-ID: <20200704115910.GY3703480@smile.fi.intel.com>
References: <20200630035816.GA21591@jagdpanzerIV.localdomain>
 <20200630102141.GA11587@alley>
 <20200630105512.GA530@jagdpanzerIV.localdomain>
 <20200630122239.GD6173@alley>
 <20200630130534.GB145027@jagdpanzerIV.localdomain>
 <20200630180255.GD37466@atomide.com>
 <20200702051213.GB3450@jagdpanzerIV.localdomain>
 <20200702160514.GK37466@atomide.com>
 <20200703103241.GB182102@jagdpanzerIV.localdomain>
 <CAHp75VdvNi_LWv7QhEsm1vQikeiMpi68qmCwoVttjnp7oq0ahg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdvNi_LWv7QhEsm1vQikeiMpi68qmCwoVttjnp7oq0ahg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 04, 2020 at 02:35:46PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 3, 2020 at 1:32 PM Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com> wrote:
> > On (20/07/02 09:05), Tony Lindgren wrote:
> > > * Sergey Senozhatsky <sergey.senozhatsky@gmail.com> [200702 05:13]:
> > > > On (20/06/30 11:02), Tony Lindgren wrote:

...

> > This is, basically, an equivalent of
> >
> > ---
> >  drivers/tty/serial/8250/8250_port.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > index d64ca77d9cfa..dba7747d2ddd 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -2275,6 +2275,7 @@ int serial8250_do_startup(struct uart_port *port)
> >
> >         if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
> >                 unsigned char iir1;
> > +
> >                 /*
> >                  * Test for UARTs that do not reassert THRE when the
> >                  * transmitter is idle and the interrupt has already
> > @@ -2284,8 +2285,6 @@ int serial8250_do_startup(struct uart_port *port)
> >                  * allow register changes to become visible.
> >                  */
> >                 spin_lock_irqsave(&port->lock, flags);
> > -               if (up->port.irqflags & IRQF_SHARED)
> > -                       disable_irq_nosync(port->irq);
> >
> >                 wait_for_xmitr(up, UART_LSR_THRE);
> >                 serial_port_out_sync(port, UART_IER, UART_IER_THRI);
> > @@ -2297,8 +2296,6 @@ int serial8250_do_startup(struct uart_port *port)
> >                 iir = serial_port_in(port, UART_IIR);
> >                 serial_port_out(port, UART_IER, 0);
> >
> > -               if (port->irqflags & IRQF_SHARED)
> > -                       enable_irq(port->irq);
> >                 spin_unlock_irqrestore(&port->lock, flags);
> >
> >                 /*
> 
> ...which effectively is a revert of
> 
> 768aec0b5bcc ("serial: 8250: fix shared interrupts issues with SMP and
> RT kernels")

(without c389d27b5e64 ("8250.c: port.lock is irq-safe") applied)

-- 
With Best Regards,
Andy Shevchenko


