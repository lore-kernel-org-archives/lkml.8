Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB35C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 216472070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0Dtf4Zo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgGFOnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbgGFOnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:43:17 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6F1C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 07:43:17 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id q17so17047055pfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 07:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w/xkJ3v8XH+wnG618qoOTUsFhQHX2RfiSLhZWKG/vJs=;
        b=B0Dtf4ZoqXYrBmq1DXEp7nFGI2aW5FmmoU6hCSca9gXDbSyAFdZtYJeUadP2gNEsrZ
         CYraeg4BNwcp5kv6VQPlYL3JkusoGlywHUfp3EQ/JsXt6asyrb1CrlL2PgYHdPJ2ugbO
         Cf+B+OMROHpWTzqeIVuh2cLYVLTtHwE9B32usvAcPkKvHlznohrE8mjJYh9d3y/AL936
         Yaj6RQ+U0kQfNHEUpU0p+sybJlfPN0oYOwlfMFG58Mj6rOl3eItBH5dkZaDRXL7vC02I
         78x6FfCk1Mdqz8UOkIhV/26KCzefcm3+eSsEhNVhYD0/vCcIFqkMOXmLugvt8qvw6rUC
         P/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w/xkJ3v8XH+wnG618qoOTUsFhQHX2RfiSLhZWKG/vJs=;
        b=bUrS4z7pqmYoSa+BzpzwSaONfoN313HfgAvhZtkhZFxx6Mh8Q1V+DN2r83TALw/Q01
         /n49Pru2kjGoupj08s2ULSJmrfJOXXj8KomdSnjpstPC7DSk1mXSH5wCQXxGDYBZVDX2
         TNnUQpCb23x1ES5reT+tMLGkzayySCU8EgbnL1RS7hSXG80aRMPVL8ErldvaYOGFP3TV
         AY5rRAl9NXkZE9DgexpGZEiKBo4T9J8EvjsQ/Rugma+Tr7iYf8yD9t0Tj+CJ3r0+c4ko
         m4BrxZBwt0Awlb7X2azGJySQMrip1fMWKsqJ5ZbMsWhj2Ak05pW6MVYMMihK2G0LGD7b
         c8vQ==
X-Gm-Message-State: AOAM531M5nPhXbVoZH+Xo44oGfTZRRViBh4Dz2Fr3qOIj2cO2t+8gguc
        qplKe9rEx+VGLP8xDAEG0CI=
X-Google-Smtp-Source: ABdhPJyTGupJyZGuWcVP3n21TtrG1YvZMNnW4/KcLOoYE4nOZnRVn7KyOWK8K/isnBt/vZ5A0fNW7w==
X-Received: by 2002:a63:9d45:: with SMTP id i66mr41415305pgd.25.1594046596965;
        Mon, 06 Jul 2020 07:43:16 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id r191sm2915291pfr.181.2020.07.06.07.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 07:43:16 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Mon, 6 Jul 2020 23:43:14 +0900
To:     Kurt Kanzenbach <kurt@linutronix.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Petr Mladek <pmladek@suse.com>,
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
Message-ID: <20200706144314.GB1485@jagdpanzerIV.localdomain>
References: <20200630102141.GA11587@alley>
 <20200630105512.GA530@jagdpanzerIV.localdomain>
 <20200630122239.GD6173@alley>
 <20200630130534.GB145027@jagdpanzerIV.localdomain>
 <20200630180255.GD37466@atomide.com>
 <20200702051213.GB3450@jagdpanzerIV.localdomain>
 <20200702160514.GK37466@atomide.com>
 <20200703103241.GB182102@jagdpanzerIV.localdomain>
 <CAHp75VdvNi_LWv7QhEsm1vQikeiMpi68qmCwoVttjnp7oq0ahg@mail.gmail.com>
 <877dvg6ft6.fsf@kurt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dvg6ft6.fsf@kurt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/06 13:31), Kurt Kanzenbach wrote:
> >> @@ -2275,6 +2275,7 @@ int serial8250_do_startup(struct uart_port *port)
> >>
> >>         if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
> >>                 unsigned char iir1;
> >> +
> >>                 /*
> >>                  * Test for UARTs that do not reassert THRE when the
> >>                  * transmitter is idle and the interrupt has already
> >> @@ -2284,8 +2285,6 @@ int serial8250_do_startup(struct uart_port *port)
> >>                  * allow register changes to become visible.
> >>                  */
> >>                 spin_lock_irqsave(&port->lock, flags);
> >> -               if (up->port.irqflags & IRQF_SHARED)
> >> -                       disable_irq_nosync(port->irq);
> >>
> >>                 wait_for_xmitr(up, UART_LSR_THRE);
> >>                 serial_port_out_sync(port, UART_IER, UART_IER_THRI);
> >> @@ -2297,8 +2296,6 @@ int serial8250_do_startup(struct uart_port *port)
> >>                 iir = serial_port_in(port, UART_IIR);
> >>                 serial_port_out(port, UART_IER, 0);
> >>
> >> -               if (port->irqflags & IRQF_SHARED)
> >> -                       enable_irq(port->irq);
> >>                 spin_unlock_irqrestore(&port->lock, flags);
> >>
> >>                 /*
> >
> > ...which effectively is a revert of
> >
> > 768aec0b5bcc ("serial: 8250: fix shared interrupts issues with SMP and
> > RT kernels")
> 
> Please, don't revert that commit. I've faced the same issue as described
> in the commit log. There is hardware available with shared UART
> interrupt lines.

Will this patch break that hardware?
https://lore.kernel.org/lkml/20200702051213.GB3450@jagdpanzerIV.localdomain/

	-ss
