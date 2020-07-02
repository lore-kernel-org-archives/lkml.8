Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9159C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D6F520836
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIDObpBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgGBFkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 01:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgGBFki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 01:40:38 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940C0C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 22:40:38 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e18so12908061pgn.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 22:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=joxvKotI6picrAUcS02GkmtYLqsOXW4f1Zm4dCFSTkM=;
        b=ZIDObpBZEn6qdf4iGXJO9sFOOMqprwvBQx/LmZm1l+NI17ooFzASttkYT4J/BmuTBl
         eeLcLF5Yn0zMKww/p7euG+QSNHgCbxiw2Dsvwu8sHFApxDpvxKdcuMCv6zHxHofz2KLx
         T5sey77dv6SmHBdwozwxPOBuPwYITzgEJy5bvBEt9cNFqkWAwapDz2ogqxfrxcOUV8kl
         uwDV9fWX4S2V8QMuibLNvV3OuiadaWIXo0GuAadCTg7Eqew/3dcM/NzzABgSQzzWCMST
         Nray+KQAF9/tPMlMeB6G1aq/0zhh708PJIQt9pr+Md0kfWU5r7XZiH0FZziB0/69ywlf
         quKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=joxvKotI6picrAUcS02GkmtYLqsOXW4f1Zm4dCFSTkM=;
        b=ESlvW/FoOSbW9wBK7bhab37pGbKbFdwdNRKJaobyUc81DbHC2Zd2xTVBswrfPGjj0o
         5AnDkHVDyP2uwWxH3Dr0F8GrIetHGbtLmwxKmiNXp9ILPfSvndFPgilaG/IhHnf6JSWQ
         38DfnX7H2HS4Hg7NI3szm2S4EbvPDTQlhMGpTg4qCWp+N3YEVgyxkEjlxmeVgB3mjvyR
         y3A7WgWHlJ4WOqNwEPlsJ2C6A47pbiosQ9HeBxvjAfLP9+PIVl9wKmcHcbxkIQJzLaWa
         iWiXYxRQ8qRLjv03hbTEd5rF42SMmqN6BCPUaJSn3gYNzlkSkSDJWK4y/V+dBhNkt5yE
         154g==
X-Gm-Message-State: AOAM530ZxEwqZMbr13sgrE8p5izL4UXd6S663c7jQQ4tCd3i9Wq7rg0r
        pWmilOF8+U8rI7bf1XKnBnY=
X-Google-Smtp-Source: ABdhPJwW+LPezYKBPME+QT/SS3oi5Ex2zMGUpnQ3dLqn4v/c862WuDoAh/rYoC4V1p2CnKnAM13y8Q==
X-Received: by 2002:a63:725c:: with SMTP id c28mr22457908pgn.156.1593668438031;
        Wed, 01 Jul 2020 22:40:38 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id a3sm7275161pgd.73.2020.07.01.22.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 22:40:37 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 2 Jul 2020 14:40:33 +0900
To:     Tony Lindgren <tony@atomide.com>
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
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: UART/TTY console deadlock
Message-ID: <20200702054033.GC3450@jagdpanzerIV.localdomain>
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

On (20/07/02 14:12), Sergey Senozhatsky wrote:
> Date: Thu, 2 Jul 2020 14:12:13 +0900
> From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> To: Tony Lindgren <tony@atomide.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Petr Mladek
>  <pmladek@suse.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Raul
>  Rangel <rrangel@google.com>, Sergey Senozhatsky
>  <sergey.senozhatsky.work@gmail.com>, linux-kernel
>  <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
>  <gregkh@linuxfoundation.org>, Andy Shevchenko
>  <andriy.shevchenko@linux.intel.com>, kurt@linutronix.de, "S, Shirish"
>  <Shirish.S@amd.com>, Peter Zijlstra <peterz@infradead.org>, John Ogness
>  <john.ogness@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>
> Subject: Re: UART/TTY console deadlock
> Message-ID: <20200702051213.GB3450@jagdpanzerIV.localdomain>
> 
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

Hmm, hold on. Why does it disable IRQ in the first place? IRQ handlers
should grab the port->lock. So if there is already running IRQ, then
serial8250_do_startup() will wait until IRQ handler unlocks the port->lock.
If serial8250_do_startup() grabs the port->lock first, then IRQ will wait
for serial8250_do_startup() to unlock it. serial8250_do_startup() does
not release the port->unlock until its done:

		spin_lock_irqsave(&port->lock, flags);

		wait_for_xmitr(up, UART_LSR_THRE);
		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
		udelay(1); /* allow THRE to set */
		iir1 = serial_port_in(port, UART_IIR);
		serial_port_out(port, UART_IER, 0);
		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
		udelay(1); /* allow a working UART time to re-assert THRE */
		iir = serial_port_in(port, UART_IIR);
		serial_port_out(port, UART_IER, 0);

		spin_unlock_irqrestore(&port->lock, flags);

so IRQ will not see the inconsistent device state.

What exactly is the purpose of disable_irq_nosync()? Can we just remove
disable_irq_nosync()/enable_irq() instead? Are there any IRQ handlers
that don't acquire the port->lock?

	-ss
