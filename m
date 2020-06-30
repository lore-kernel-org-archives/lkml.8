Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49BAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA34520724
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389635AbgF3SDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:03:03 -0400
Received: from muru.com ([72.249.23.125]:60048 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729105AbgF3SDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 14:03:01 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 829668164;
        Tue, 30 Jun 2020 18:03:50 +0000 (UTC)
Date:   Tue, 30 Jun 2020 11:02:55 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Raul Rangel <rrangel@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kurt@linutronix.de, "S, Shirish" <Shirish.S@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: UART/TTY console deadlock
Message-ID: <20200630180255.GD37466@atomide.com>
References: <CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com>
 <CAHp75Vd8nTzmZdnhpTDChdc11zyCaSfeigbxaCpOWZ1Lv9ZBMw@mail.gmail.com>
 <20200630035816.GA21591@jagdpanzerIV.localdomain>
 <20200630102141.GA11587@alley>
 <20200630105512.GA530@jagdpanzerIV.localdomain>
 <20200630122239.GD6173@alley>
 <20200630130534.GB145027@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630130534.GB145027@jagdpanzerIV.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sergey Senozhatsky <sergey.senozhatsky@gmail.com> [200630 13:06]:
> On (20/06/30 14:22), Petr Mladek wrote:
...

> > > > > @@ -2284,8 +2289,6 @@ int serial8250_do_startup(struct uart_port *port)
> > > > >  		 * allow register changes to become visible.
> > > > >  		 */
> > > > >  		spin_lock_irqsave(&port->lock, flags);
> > > > > -		if (up->port.irqflags & IRQF_SHARED)
> > > > > -			disable_irq_nosync(port->irq);
> > > > >  
> > > > >  		wait_for_xmitr(up, UART_LSR_THRE);
> > > > >  		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
> > > > > @@ -2297,9 +2300,9 @@ int serial8250_do_startup(struct uart_port *port)
> > > > >  		iir = serial_port_in(port, UART_IIR);
> > > > >  		serial_port_out(port, UART_IER, 0);
> > > > >  
> > > > > -		if (port->irqflags & IRQF_SHARED)
> > > > > -			enable_irq(port->irq);
> > > > >  		spin_unlock_irqrestore(&port->lock, flags);
> > > > > +		if (irq_shared)
> > > > > +			enable_irq(port->irq);
> > > > >  
> > > > >  		/*
> > > > >  		 * If the interrupt is not reasserted, or we otherwise
> > > > 
> > > > I think that it might be safe but I am not 100% sure, sigh.
> > > 
> > > Yeah, I'm not 100%, but I'd give it a try.
> > 
> > I do not feel brave enough to ack it today. But I am all for trying it
> > if anyone more familiar with the code is fine with it.
> 
> I see. Well, I suppose we need Ack-s from tty/serial/8250 maintainers.
> I would not be very happy if _only_ printk people Ack the patch.

This conditional disable for irq_shared does not look nice to me
from the other device point of view :)

Would it be possible to just set up te dummy interrupt handler
for the startup, then change it back afterwards? See for example
omap8250_no_handle_irq().

The other device for irq_shared should be capable of dealing
with spurious interrupts if it's shared.

Regards,

Tony
