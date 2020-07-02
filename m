Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA486C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AA1A207CD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgGBQFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:05:23 -0400
Received: from muru.com ([72.249.23.125]:60366 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgGBQFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:05:19 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6FA5B8062;
        Thu,  2 Jul 2020 16:06:10 +0000 (UTC)
Date:   Thu, 2 Jul 2020 09:05:14 -0700
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
Message-ID: <20200702160514.GK37466@atomide.com>
References: <CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com>
 <CAHp75Vd8nTzmZdnhpTDChdc11zyCaSfeigbxaCpOWZ1Lv9ZBMw@mail.gmail.com>
 <20200630035816.GA21591@jagdpanzerIV.localdomain>
 <20200630102141.GA11587@alley>
 <20200630105512.GA530@jagdpanzerIV.localdomain>
 <20200630122239.GD6173@alley>
 <20200630130534.GB145027@jagdpanzerIV.localdomain>
 <20200630180255.GD37466@atomide.com>
 <20200702051213.GB3450@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702051213.GB3450@jagdpanzerIV.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sergey Senozhatsky <sergey.senozhatsky@gmail.com> [200702 05:13]:
> On (20/06/30 11:02), Tony Lindgren wrote:
> > This conditional disable for irq_shared does not look nice to me
> > from the other device point of view :)
> > 
> > Would it be possible to just set up te dummy interrupt handler
> > for the startup, then change it back afterwards? See for example
> > omap8250_no_handle_irq().
> 
> I think we can do it. serial8250_do_startup() and irq handler take
> port->lock, so they should be synchronized.
> 
> Something like this then?

Yeah thanks this should work better for shared irq.

Regards,

Tony

> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index f77bf820b7a3..61ad6f5f0f88 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2140,6 +2140,11 @@ static void serial8250_put_poll_char(struct uart_port *port,
>  
>  #endif /* CONFIG_CONSOLE_POLL */
>  
> +static int serial8250_dummy_handle_irq(struct uart_port *port)
> +{
> +	return 0;
> +}
> +
>  int serial8250_do_startup(struct uart_port *port)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(port);
> @@ -2271,6 +2276,9 @@ int serial8250_do_startup(struct uart_port *port)
>  
>  	if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
>  		unsigned char iir1;
> +		int (*handler)(struct uart_port *);
> +
> +		handler = port->handle_irq;
>  		/*
>  		 * Test for UARTs that do not reassert THRE when the
>  		 * transmitter is idle and the interrupt has already
> @@ -2280,8 +2288,7 @@ int serial8250_do_startup(struct uart_port *port)
>  		 * allow register changes to become visible.
>  		 */
>  		spin_lock_irqsave(&port->lock, flags);
> -		if (up->port.irqflags & IRQF_SHARED)
> -			disable_irq_nosync(port->irq);
> +		port->handle_irq = serial8250_dummy_handle_irq;
>  
>  		wait_for_xmitr(up, UART_LSR_THRE);
>  		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
> @@ -2293,8 +2300,7 @@ int serial8250_do_startup(struct uart_port *port)
>  		iir = serial_port_in(port, UART_IIR);
>  		serial_port_out(port, UART_IER, 0);
>  
> -		if (port->irqflags & IRQF_SHARED)
> -			enable_irq(port->irq);
> +		port->handle_irq = handler;
>  		spin_unlock_irqrestore(&port->lock, flags);
>  
>  		/*
