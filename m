Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B17FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB912084C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV5PJN1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgGDLgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 07:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgGDLgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 07:36:03 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A07BC061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 04:36:03 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e8so16244882pgc.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 04:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=57n94MhwYLFuD1T6ZycMA1rGCA3SSVPMIKT/pMmwRpo=;
        b=eV5PJN1v9takJBwFWZXZkfYrrTcA8u8LAnErDVFa2WYBNibG+CGc6NtjGRxLJR1ZU8
         7gFQFuA+3f4633Ei84zMDtJvd6QGIAaiDP7tE+Qe/eF44nG3I6cQNEP4+LQSQxM/fAUw
         963BR5ChLguoBP+07TLSZxAMAvYDI/qPADDQXP79pRZLCLsNfN/DGMp66ZgvEuVZ3IUX
         HWy4TpPFKDvP/lBU6AyIdJWdHMOt7Cbk9drRRlHHaFFnY/tUw00GeW/Frsab5PdEMCwV
         mdX3DSH/Q6cshyRylbnB8mo9qT6MyimX8NDIXU9anIkg21x2g2AipriXb8pnbf100iTC
         NVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=57n94MhwYLFuD1T6ZycMA1rGCA3SSVPMIKT/pMmwRpo=;
        b=QUyWge1AWjta5UATPzIYrOfovHMtYG7424HXEGJJqtq6MXWxmXVYGjA2XV5Jis+/oG
         j3c8k07YprU6VpcGV0tiFeRWTGr1X3Z/FtDyQeBwwH6fghIK+ymTFqWVgLhlfATGkCxl
         FhRESe9wqvTxak+touLNYz4HODzJUWuB/SxQufofFMlfImeDM/R/nvzJfQzSUbxd3Z0T
         vshAYzB0jE8y5LZRJpJKPVw5pqBjVbLQPX0FKk8hTC9z/5PNNrl+OZFpdehHNFknEevN
         DZA1xs6uK2KoM4iwzrI6NAiOJkusSNnhR8Qn/U1v2zJWEht/5265o3y4jIa9eHjnaeNA
         VqXA==
X-Gm-Message-State: AOAM531TcW1op/Yeqq2fuqMomeH3gQMPaX7yzSR964Rh+Ur3hJA+tJYz
        bowE/eBavxAbWx7YFJaDMoZEVvTFFIru1SgmWPA=
X-Google-Smtp-Source: ABdhPJzXwaCbRg7QQsQmmnVe5wJAFvWkaOsSYYLS0m1ZSVo7N/Dg+CET7DlJW31u5H4lDci2O2CFAJzCy8qqp5nHfQE=
X-Received: by 2002:a62:7657:: with SMTP id r84mr35690096pfc.130.1593862563045;
 Sat, 04 Jul 2020 04:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com>
 <CAHp75Vd8nTzmZdnhpTDChdc11zyCaSfeigbxaCpOWZ1Lv9ZBMw@mail.gmail.com>
 <20200630035816.GA21591@jagdpanzerIV.localdomain> <20200630102141.GA11587@alley>
 <20200630105512.GA530@jagdpanzerIV.localdomain> <20200630122239.GD6173@alley>
 <20200630130534.GB145027@jagdpanzerIV.localdomain> <20200630180255.GD37466@atomide.com>
 <20200702051213.GB3450@jagdpanzerIV.localdomain> <20200702160514.GK37466@atomide.com>
 <20200703103241.GB182102@jagdpanzerIV.localdomain>
In-Reply-To: <20200703103241.GB182102@jagdpanzerIV.localdomain>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 4 Jul 2020 14:35:46 +0300
Message-ID: <CAHp75VdvNi_LWv7QhEsm1vQikeiMpi68qmCwoVttjnp7oq0ahg@mail.gmail.com>
Subject: Re: UART/TTY console deadlock
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>, Petr Mladek <pmladek@suse.com>,
        Raul Rangel <rrangel@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kurt@linutronix.de, "S, Shirish" <Shirish.S@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 1:32 PM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> On (20/07/02 09:05), Tony Lindgren wrote:
> > * Sergey Senozhatsky <sergey.senozhatsky@gmail.com> [200702 05:13]:
> > > On (20/06/30 11:02), Tony Lindgren wrote:
> > > > This conditional disable for irq_shared does not look nice to me
> > > > from the other device point of view :)
> > > >
> > > > Would it be possible to just set up te dummy interrupt handler
> > > > for the startup, then change it back afterwards? See for example
> > > > omap8250_no_handle_irq().
> > >
> > > I think we can do it. serial8250_do_startup() and irq handler take
> > > port->lock, so they should be synchronized.
> > >
> > > Something like this then?
> >
> > Yeah thanks this should work better for shared irq.
>
> This is, basically, an equivalent of
>
> ---
>  drivers/tty/serial/8250/8250_port.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index d64ca77d9cfa..dba7747d2ddd 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2275,6 +2275,7 @@ int serial8250_do_startup(struct uart_port *port)
>
>         if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
>                 unsigned char iir1;
> +
>                 /*
>                  * Test for UARTs that do not reassert THRE when the
>                  * transmitter is idle and the interrupt has already
> @@ -2284,8 +2285,6 @@ int serial8250_do_startup(struct uart_port *port)
>                  * allow register changes to become visible.
>                  */
>                 spin_lock_irqsave(&port->lock, flags);
> -               if (up->port.irqflags & IRQF_SHARED)
> -                       disable_irq_nosync(port->irq);
>
>                 wait_for_xmitr(up, UART_LSR_THRE);
>                 serial_port_out_sync(port, UART_IER, UART_IER_THRI);
> @@ -2297,8 +2296,6 @@ int serial8250_do_startup(struct uart_port *port)
>                 iir = serial_port_in(port, UART_IIR);
>                 serial_port_out(port, UART_IER, 0);
>
> -               if (port->irqflags & IRQF_SHARED)
> -                       enable_irq(port->irq);
>                 spin_unlock_irqrestore(&port->lock, flags);
>
>                 /*

...which effectively is a revert of

768aec0b5bcc ("serial: 8250: fix shared interrupts issues with SMP and
RT kernels")

-- 
With Best Regards,
Andy Shevchenko
