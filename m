Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AD7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A97A72067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vh3PFwH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732693AbgF3KzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732591AbgF3KzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:55:16 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2C5C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 03:55:16 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cm21so6012pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 03:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yXnWMxu3fBL1VWpPWUGZnbKsrn0ARe4p9+UVSrgyfY4=;
        b=vh3PFwH7OSmUmtaKe75aA33YtX+8ch/+HDJzhzew5U0rRSKZplqUNrNS1PIQvXPu3u
         3oPLI7OLOq7oNkIXDzLc6ggd8qV3BRTyKHFaKF7eo1P+ZkgAGpbii9cWRzqGf5VXWcf1
         NeKQbaT3FFvDr/Hpb+JL2tx9FbqoPfoU5wfR5oMTxFT/O/elpp+jUpdcMst8iK8gujXH
         RJyjzitiuQ+/z0HhZ8dRWUwMZw8HlIS5jfO0GkAbqUPErRRHzVoGnKiC6Xx9eXcbCN/0
         uBIm4ZP6cgM0AS3HDN+kDLB36mJi4rfmsFiTeChyRY/oKcmqygOHUyQjBfGFdhtfud8n
         ZXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yXnWMxu3fBL1VWpPWUGZnbKsrn0ARe4p9+UVSrgyfY4=;
        b=qOHsP7nY/fYM0s3e5aHuy3ehsNuGqiXq5itYrlZCvAdEh5FJuYWS8M+CeasIS2pQG2
         x5RxwcEZtbINSNBF1inkLAhjMAlp2+RGTnDNY97u4qRacb1H2W50o7oXR4ySFaQYIgH1
         pRfswly9Cz57V4iM7saJUsUCEFW5Okrlov03UIj3vSGNDvBrJJPgetWZB4dYHJptrVs4
         ONGkK6NdWuRgd/6EK/1MytxoWtlK2B0wAhsh4hKGKLLa24CyEVV3zVAefgbQGka0QS7z
         EI0WyS9oY9jW93XmYECnAETaKzhvnF8Qo3Lgc6dDgm+1WcGdECe78/Akxoc7cygDbn1f
         +WNg==
X-Gm-Message-State: AOAM5303K41uCnmA30kxqgPIo3I6HQwBIifsLXkx3c2HX8cJOVy5057k
        QvueBWBiMCWRO2eBUMHPvIA=
X-Google-Smtp-Source: ABdhPJyW6mKyhI5+KlOuoOY1WVuAnU00tVxgG1wOguDM/Vo87EmW7OZC00aaW6zJa2HoR4OwoyRk7w==
X-Received: by 2002:a17:90a:4d87:: with SMTP id m7mr20343508pjh.26.1593514515863;
        Tue, 30 Jun 2020 03:55:15 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id i196sm2428213pgc.55.2020.06.30.03.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 03:55:15 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 30 Jun 2020 19:55:12 +0900
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
Message-ID: <20200630105512.GA530@jagdpanzerIV.localdomain>
References: <CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com>
 <CAHp75Vd8nTzmZdnhpTDChdc11zyCaSfeigbxaCpOWZ1Lv9ZBMw@mail.gmail.com>
 <20200630035816.GA21591@jagdpanzerIV.localdomain>
 <20200630102141.GA11587@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630102141.GA11587@alley>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/06/30 12:21), Petr Mladek wrote:
> > So... Do we need to hold uart->port when we disable port->irq? What do we
> > race with? Module removal? The function bumps device PM counter (albeit
> > for UART_CAP_RPM ports only).
> 
> Honestly, I do not see where a PM counter gets incremented.

serial8250_do_startup()
 serial8250_rpm_get()
  pm_runtime_get_sync(p->port.dev)

But this does not happen for all ports, just for UART_CAP_RPM ones.

> Anyway, __disable_irq_nosync() does nothing when
> irq_get_desc_buslock() returns NULL. And irq_get_desc_buslock()
> takes desc->lock when desc exist. This should be enough to
> synchronize any calls.
> 
> > But, at the same time, we do a whole bunch
> > of unprotected port->FOO accesses in serial8250_do_startup(). We even set
> > the IRQF_SHARED up->port.irqflags without grabbing the port->lock:
> > 
> > 	 up->port.irqflags |= IRQF_SHARED;
> > 	 spin_lock_irqsave(&port->lock, flags);
> > 	 if (up->port.irqflags & IRQF_SHARED)
> > 	    disable_irq_nosync(port->irq);
> 
> Yup, this looks suspicious. We set a flag in port.irqflags and take the lock
> only when the flag was set. Either everything needs to be done under
> the lock or the lock is not needed.
> 
> Well, I might have missed something. I do not fully understand meaning
> and relation of all the structures.
> 
> Anyway, I believe that this is a false positive. If I get it correctly
> serial8250_do_startup() must be called before the serial port could
> be registered as a console. It means that it could not be called
> from inside printk().

From my understanding, I'm afraid we are talking about actual deadlock
here, not about false positive report. Quoting the original email:

 : We are trying an S3 suspend stress test and occasionally while
 : entering S3 we get a console deadlock.

[..]

> >  drivers/tty/serial/8250/8250_port.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > index d64ca77d9cfa..ad30991e1b3b 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -2275,6 +2275,11 @@ int serial8250_do_startup(struct uart_port *port)
> >  
> >  	if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
> >  		unsigned char iir1;
> > +		bool irq_shared = up->port.irqflags & IRQF_SHARED;
> > +
> > +		if (irq_shared)
> > +			disable_irq_nosync(port->irq);
> > +
> >  		/*
> >  		 * Test for UARTs that do not reassert THRE when the
> >  		 * transmitter is idle and the interrupt has already
> > @@ -2284,8 +2289,6 @@ int serial8250_do_startup(struct uart_port *port)
> >  		 * allow register changes to become visible.
> >  		 */
> >  		spin_lock_irqsave(&port->lock, flags);
> > -		if (up->port.irqflags & IRQF_SHARED)
> > -			disable_irq_nosync(port->irq);
> >  
> >  		wait_for_xmitr(up, UART_LSR_THRE);
> >  		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
> > @@ -2297,9 +2300,9 @@ int serial8250_do_startup(struct uart_port *port)
> >  		iir = serial_port_in(port, UART_IIR);
> >  		serial_port_out(port, UART_IER, 0);
> >  
> > -		if (port->irqflags & IRQF_SHARED)
> > -			enable_irq(port->irq);
> >  		spin_unlock_irqrestore(&port->lock, flags);
> > +		if (irq_shared)
> > +			enable_irq(port->irq);
> >  
> >  		/*
> >  		 * If the interrupt is not reasserted, or we otherwise
> 
> I think that it might be safe but I am not 100% sure, sigh.

Yeah, I'm not 100%, but I'd give it a try.

	-ss
