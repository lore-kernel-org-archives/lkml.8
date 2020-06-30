Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEB5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 844CE20760
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732448AbgF3KVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:21:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:51598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732246AbgF3KVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:21:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 19937B123;
        Tue, 30 Jun 2020 10:21:43 +0000 (UTC)
Date:   Tue, 30 Jun 2020 12:21:42 +0200
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
Message-ID: <20200630102141.GA11587@alley>
References: <CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com>
 <CAHp75Vd8nTzmZdnhpTDChdc11zyCaSfeigbxaCpOWZ1Lv9ZBMw@mail.gmail.com>
 <20200630035816.GA21591@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630035816.GA21591@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-06-30 12:58:16, Sergey Senozhatsky wrote:
> Cc-ing more people
> 
> https://lore.kernel.org/lkml/CAHp75Vd8nTzmZdnhpTDChdc11zyCaSfeigbxaCpOWZ1Lv9ZBMw@mail.gmail.com
> 
> On (20/06/22 20:37), Andy Shevchenko wrote:
> > > [  279.759811] -> #2 (&irq_desc_lock_class){-.-.}:
> > > [  279.759813]        _raw_spin_lock_irqsave+0x61/0x8d
> > > [  279.759813]        __irq_get_desc_lock+0x65/0x89
> > > [  279.759814]        __disable_irq_nosync+0x3b/0x93
> > > [  279.759814]        serial8250_do_startup+0x451/0x75c
> > > [  279.759815]        uart_startup+0x1b4/0x2ff
> > > [  279.759815]        uart_port_activate+0x73/0xa0
> > > [  279.759815]        tty_port_open+0xae/0x10a
> > > [  279.759816]        uart_open+0x1b/0x26
> > > [  279.759816]        tty_open+0x24d/0x3a0
> > > [  279.759817]        chrdev_open+0xd5/0x1cc
> > > [  279.759817]        do_dentry_open+0x299/0x3c8
> > > [  279.759817]        path_openat+0x434/0x1100
> > > [  279.759818]        do_filp_open+0x9b/0x10a
> > > [  279.759818]        do_sys_open+0x15f/0x3d7
> > > [  279.759819]        kernel_init_freeable+0x157/0x1dd
> > > [  279.759819]        kernel_init+0xe/0x105
> > > [  279.759819]        ret_from_fork+0x27/0x50
> > > [  279.759820]
> > > [  279.759820] -> #1 (&port_lock_key){-.-.}:
> > > [  279.759822]        _raw_spin_lock_irqsave+0x61/0x8d
> > > [  279.759822]        serial8250_console_write+0xa7/0x2a0
> > > [  279.759823]        console_unlock+0x3b7/0x528
> > > [  279.759823]        vprintk_emit+0x111/0x17f
> > > [  279.759823]        printk+0x59/0x73
> > > [  279.759824]        register_console+0x336/0x3a4
> > > [  279.759824]        uart_add_one_port+0x51b/0x5be
> > > [  279.759825]        serial8250_register_8250_port+0x454/0x55e
> > > [  279.759825]        dw8250_probe+0x4dc/0x5b9
> > > [  279.759825]        platform_drv_probe+0x67/0x8b
> > > [  279.759826]        really_probe+0x14a/0x422
> > > [  279.759826]        driver_probe_device+0x66/0x130
> > > [  279.759827]        device_driver_attach+0x42/0x5b
> > > [  279.759827]        __driver_attach+0xca/0x139
> > > [  279.759827]        bus_for_each_dev+0x97/0xc9
> > > [  279.759828]        bus_add_driver+0x12b/0x228
> > > [  279.759828]        driver_register+0x64/0xed
> > > [  279.759829]        do_one_initcall+0x20c/0x4a6
> > > [  279.759829]        do_initcall_level+0xb5/0xc5
> > > [  279.759829]        do_basic_setup+0x4c/0x58
> > > [  279.759830]        kernel_init_freeable+0x13f/0x1dd
> > > [  279.759830]        kernel_init+0xe/0x105
> > > [  279.759831]        ret_from_fork+0x27/0x50
> > > [  279.759831]
> > > [  279.759831] -> #0 (console_owner){-...}:
> > > [  279.759833]        __lock_acquire+0x118d/0x2714
> > > [  279.759833]        lock_acquire+0x203/0x258
> > > [  279.759834]        console_lock_spinning_enable+0x51/0x57
> > > [  279.759834]        console_unlock+0x25d/0x528
> > > [  279.759834]        vprintk_emit+0x111/0x17f
> > > [  279.759835]        printk+0x59/0x73
> > > [  279.759835]        __report_bad_irq+0xa3/0xba
> > > [  279.759836]        note_interrupt+0x19a/0x1d6
> > > [  279.759836]        handle_irq_event_percpu+0x57/0x79
> > > [  279.759836]        handle_irq_event+0x36/0x55
> > > [  279.759837]        handle_fasteoi_irq+0xc2/0x18a
> > > [  279.759837]        do_IRQ+0xb3/0x157
> > > [  279.759838]        ret_from_intr+0x0/0x1d
> > > [  279.759838]        cpuidle_enter_state+0x12f/0x1fd
> > > [  279.759838]        cpuidle_enter+0x2e/0x3d
> > > [  279.759839]        do_idle+0x1ce/0x2ce
> > > [  279.759839]        cpu_startup_entry+0x1d/0x1f
> > > [  279.759840]        start_kernel+0x406/0x46a
> > > [  279.759840]        secondary_startup_64+0xa4/0xb0
> 
> Hmm. So this is uart->port => desc->lock vs desc->lock => uart->port
> 
> chain #1:
> 
>  serial8250_do_startup()
>   spin_lock_irqsave(&port->lock);
>    disable_irq_nosync(port->irq);
>     raw_spin_lock_irqsave(&desc->lock)
> 
> chain #2:
> 
>   __report_bad_irq()
>    raw_spin_lock_irqsave(&desc->lock)
>     for_each_action_of_desc()
>      printk()
>       spin_lock_irqsave(&port->lock);
> 
> 
> Breaking up chain #2 is not an option, I suppose. Those are a rather
> important KERN_ERR messages, printk_deferred() will upset people badly.

Yes, we should avoid printk_deferred() unless there is another solution.


> So... Do we need to hold uart->port when we disable port->irq? What do we
> race with? Module removal? The function bumps device PM counter (albeit
> for UART_CAP_RPM ports only).

Honestly, I do not see where a PM counter gets incremented.

Anyway, __disable_irq_nosync() does nothing when
irq_get_desc_buslock() returns NULL. And irq_get_desc_buslock()
takes desc->lock when desc exist. This should be enough to
synchronize any calls.

> But, at the same time, we do a whole bunch
> of unprotected port->FOO accesses in serial8250_do_startup(). We even set
> the IRQF_SHARED up->port.irqflags without grabbing the port->lock:
> 
> 	 up->port.irqflags |= IRQF_SHARED;
> 	 spin_lock_irqsave(&port->lock, flags);
> 	 if (up->port.irqflags & IRQF_SHARED)
> 	    disable_irq_nosync(port->irq);

Yup, this looks suspicious. We set a flag in port.irqflags and take the lock
only when the flag was set. Either everything needs to be done under
the lock or the lock is not needed.

Well, I might have missed something. I do not fully understand meaning
and relation of all the structures.

Anyway, I believe that this is a false positive. If I get it correctly
serial8250_do_startup() must be called before the serial port could
be registered as a console. It means that it could not be called
from inside printk().

Sigh, I do not know how to tell lockdep about these false positives.
And I am never 100% sure that we could shuffle locks in the various
the console drivers.


> IOW, can we do something like this?
> 
> ---
>  drivers/tty/serial/8250/8250_port.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index d64ca77d9cfa..ad30991e1b3b 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2275,6 +2275,11 @@ int serial8250_do_startup(struct uart_port *port)
>  
>  	if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
>  		unsigned char iir1;
> +		bool irq_shared = up->port.irqflags & IRQF_SHARED;
> +
> +		if (irq_shared)
> +			disable_irq_nosync(port->irq);
> +
>  		/*
>  		 * Test for UARTs that do not reassert THRE when the
>  		 * transmitter is idle and the interrupt has already
> @@ -2284,8 +2289,6 @@ int serial8250_do_startup(struct uart_port *port)
>  		 * allow register changes to become visible.
>  		 */
>  		spin_lock_irqsave(&port->lock, flags);
> -		if (up->port.irqflags & IRQF_SHARED)
> -			disable_irq_nosync(port->irq);
>  
>  		wait_for_xmitr(up, UART_LSR_THRE);
>  		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
> @@ -2297,9 +2300,9 @@ int serial8250_do_startup(struct uart_port *port)
>  		iir = serial_port_in(port, UART_IIR);
>  		serial_port_out(port, UART_IER, 0);
>  
> -		if (port->irqflags & IRQF_SHARED)
> -			enable_irq(port->irq);
>  		spin_unlock_irqrestore(&port->lock, flags);
> +		if (irq_shared)
> +			enable_irq(port->irq);
>  
>  		/*
>  		 * If the interrupt is not reasserted, or we otherwise

I think that it might be safe but I am not 100% sure, sigh.

Best Regards,
Petr
