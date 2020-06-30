Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E257AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA4420702
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387638AbgF3MWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:22:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:32884 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387629AbgF3MWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:22:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B1D1DB020;
        Tue, 30 Jun 2020 12:22:40 +0000 (UTC)
Date:   Tue, 30 Jun 2020 14:22:39 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Raul Rangel <rrangel@google.com>,
        Tony Lindgren <tony@atomide.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kurt@linutronix.de, "S, Shirish" <Shirish.S@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: UART/TTY console deadlock
Message-ID: <20200630122239.GD6173@alley>
References: <CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com>
 <CAHp75Vd8nTzmZdnhpTDChdc11zyCaSfeigbxaCpOWZ1Lv9ZBMw@mail.gmail.com>
 <20200630035816.GA21591@jagdpanzerIV.localdomain>
 <20200630102141.GA11587@alley>
 <20200630105512.GA530@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630105512.GA530@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-06-30 19:55:12, Sergey Senozhatsky wrote:
> On (20/06/30 12:21), Petr Mladek wrote:
> > Anyway, I believe that this is a false positive. If I get it correctly
> > serial8250_do_startup() must be called before the serial port could
> > be registered as a console. It means that it could not be called
> > from inside printk().
> 
> >From my understanding, I'm afraid we are talking about actual deadlock
> here, not about false positive report. Quoting the original email:

IMHO, it is not clear. The log contains lockdep report. It does not mean
the deadlock really happened. The lockdep reports cyclic dependency but it
is not able to say if the related code chains might be called at the
same time in reality.

And this combination has signs of false positives. As I said, I think
that the serial console could not be registered by printk() before
serial8250_do_startup() has finished.

Also there are some unrelated messages after the last backtrace.

Finally. we would be able to see the messages only when panic() was
called and oops_in_progress set. And there is nothing about panic().


>  : We are trying an S3 suspend stress test and occasionally while
>  : entering S3 we get a console deadlock.

Raul, have the system really died or have you just seen the lockdep
report, please?


> [..]
> 
> > >  drivers/tty/serial/8250/8250_port.c | 11 +++++++----
> > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > > index d64ca77d9cfa..ad30991e1b3b 100644
> > > --- a/drivers/tty/serial/8250/8250_port.c
> > > +++ b/drivers/tty/serial/8250/8250_port.c
> > > @@ -2275,6 +2275,11 @@ int serial8250_do_startup(struct uart_port *port)
> > >  
> > >  	if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
> > >  		unsigned char iir1;
> > > +		bool irq_shared = up->port.irqflags & IRQF_SHARED;
> > > +
> > > +		if (irq_shared)
> > > +			disable_irq_nosync(port->irq);
> > > +
> > >  		/*
> > >  		 * Test for UARTs that do not reassert THRE when the
> > >  		 * transmitter is idle and the interrupt has already
> > > @@ -2284,8 +2289,6 @@ int serial8250_do_startup(struct uart_port *port)
> > >  		 * allow register changes to become visible.
> > >  		 */
> > >  		spin_lock_irqsave(&port->lock, flags);
> > > -		if (up->port.irqflags & IRQF_SHARED)
> > > -			disable_irq_nosync(port->irq);
> > >  
> > >  		wait_for_xmitr(up, UART_LSR_THRE);
> > >  		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
> > > @@ -2297,9 +2300,9 @@ int serial8250_do_startup(struct uart_port *port)
> > >  		iir = serial_port_in(port, UART_IIR);
> > >  		serial_port_out(port, UART_IER, 0);
> > >  
> > > -		if (port->irqflags & IRQF_SHARED)
> > > -			enable_irq(port->irq);
> > >  		spin_unlock_irqrestore(&port->lock, flags);
> > > +		if (irq_shared)
> > > +			enable_irq(port->irq);
> > >  
> > >  		/*
> > >  		 * If the interrupt is not reasserted, or we otherwise
> > 
> > I think that it might be safe but I am not 100% sure, sigh.
> 
> Yeah, I'm not 100%, but I'd give it a try.

I do not feel brave enough to ack it today. But I am all for trying it
if anyone more familiar with the code is fine with it.

Best Regards,
Petr
