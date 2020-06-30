Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A65C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE4420672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y91it/l5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgF3NFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgF3NFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:05:38 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3382C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:05:37 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u5so9409505pfn.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mufd44kK17qFivOfQ57M8zO5lo5YkRfS0CDXZTF/ywg=;
        b=Y91it/l5NbOcjxp6l9p+t29xIg4Tr1A4sNjey1SCcwUtHu4K5Ip0GvSYTKocHTzNWI
         EKsyEfhc2vr1taxgHJmezL3HP/PsWyGAs/T+3gYGjezMw1eXltgErcOif2Li8aagFq0k
         bZctCh4NbPG8e8tIlKLmwtd7/9gzPnXsOD8OWc6oVb6KFUA3cEjDBsttXeYH8NhgNPcC
         Try4E8d9eRZ7aiTO7MfUa9GodFFpS5daq7F1cUJskO2sNf1B2iXPLIqsm6Ny7uV8CCjn
         VHn89cBVT7Ie3FFFUHkKqfqIIwMN5OMFHJ4wiVzQ/sevaZCtSlXh6mYlliv/qxKODLmn
         YFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mufd44kK17qFivOfQ57M8zO5lo5YkRfS0CDXZTF/ywg=;
        b=MXlGhHlU9BD/m2CRgQoQGiRXON5zpImG/LuO0Q6dlI3FmsXPPC585oQ1vQ1uddPD45
         oS5gw06ou6/s5ZLqxLM1S/2dIdYmkn04mRX70dP9w4+4T/OVTutv8AWQIDD1BT3yCbjh
         er2MW2MfcAMF/20RKROTBcgLeEbjvLvmGNepmrO9SGjGOrljYPaQEQQU/vojgTx6QypT
         xBdJjoeq5v2lN3kkSupYd/hx6F+F3w3iUPXSoxQuHEGHxywK3/QcOQ+kEwniT7acqTlt
         vgDznuCnwQEY0RQl2kFIWZy3RtAatARm1bgefTXLbo5PxBOo4z5NAVusy8ekD9IrZAi3
         T7Sg==
X-Gm-Message-State: AOAM531W5aZX5aclSpHfyXaRt9PYys7+gGFyVDgAkKrzw/hUyLXrjBvk
        xaQIcUJcC9zfh2PqFrcRDn7DWHKi
X-Google-Smtp-Source: ABdhPJxApFM9BscCEAXQNohFw+pXxYJ4pBBTEK0Y976nJbzWLlZ+LRBEDAb34eKuypdsF/L8XdodtQ==
X-Received: by 2002:a63:db46:: with SMTP id x6mr12336774pgi.265.1593522337263;
        Tue, 30 Jun 2020 06:05:37 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id a3sm2668732pgd.73.2020.06.30.06.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:05:36 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 30 Jun 2020 22:05:34 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
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
Message-ID: <20200630130534.GB145027@jagdpanzerIV.localdomain>
References: <CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com>
 <CAHp75Vd8nTzmZdnhpTDChdc11zyCaSfeigbxaCpOWZ1Lv9ZBMw@mail.gmail.com>
 <20200630035816.GA21591@jagdpanzerIV.localdomain>
 <20200630102141.GA11587@alley>
 <20200630105512.GA530@jagdpanzerIV.localdomain>
 <20200630122239.GD6173@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630122239.GD6173@alley>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/06/30 14:22), Petr Mladek wrote:
> On Tue 2020-06-30 19:55:12, Sergey Senozhatsky wrote:
> > On (20/06/30 12:21), Petr Mladek wrote:
> > > Anyway, I believe that this is a false positive. If I get it correctly
> > > serial8250_do_startup() must be called before the serial port could
> > > be registered as a console. It means that it could not be called
> > > from inside printk().
> > 
> > >From my understanding, I'm afraid we are talking about actual deadlock
> > here, not about false positive report. Quoting the original email:
> 
> IMHO, it is not clear.
>

Yea. Maybe it is, maybe it's not.

Regardless, after lockdep tells us there is something it doesn't like,
it disables itself, so false positives render lockdep useless.

> > > > @@ -2275,6 +2275,11 @@ int serial8250_do_startup(struct uart_port *port)
> > > >  
> > > >  	if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
> > > >  		unsigned char iir1;
> > > > +		bool irq_shared = up->port.irqflags & IRQF_SHARED;
> > > > +
> > > > +		if (irq_shared)
> > > > +			disable_irq_nosync(port->irq);
> > > > +
> > > >  		/*
> > > >  		 * Test for UARTs that do not reassert THRE when the
> > > >  		 * transmitter is idle and the interrupt has already
> > > > @@ -2284,8 +2289,6 @@ int serial8250_do_startup(struct uart_port *port)
> > > >  		 * allow register changes to become visible.
> > > >  		 */
> > > >  		spin_lock_irqsave(&port->lock, flags);
> > > > -		if (up->port.irqflags & IRQF_SHARED)
> > > > -			disable_irq_nosync(port->irq);
> > > >  
> > > >  		wait_for_xmitr(up, UART_LSR_THRE);
> > > >  		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
> > > > @@ -2297,9 +2300,9 @@ int serial8250_do_startup(struct uart_port *port)
> > > >  		iir = serial_port_in(port, UART_IIR);
> > > >  		serial_port_out(port, UART_IER, 0);
> > > >  
> > > > -		if (port->irqflags & IRQF_SHARED)
> > > > -			enable_irq(port->irq);
> > > >  		spin_unlock_irqrestore(&port->lock, flags);
> > > > +		if (irq_shared)
> > > > +			enable_irq(port->irq);
> > > >  
> > > >  		/*
> > > >  		 * If the interrupt is not reasserted, or we otherwise
> > > 
> > > I think that it might be safe but I am not 100% sure, sigh.
> > 
> > Yeah, I'm not 100%, but I'd give it a try.
> 
> I do not feel brave enough to ack it today. But I am all for trying it
> if anyone more familiar with the code is fine with it.

I see. Well, I suppose we need Ack-s from tty/serial/8250 maintainers.
I would not be very happy if _only_ printk people Ack the patch.

	-ss
