Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4638C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B693E207CD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDsTSnXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgGBFMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 01:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgGBFMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 01:12:18 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93AEC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 22:12:18 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id m9so1747834pfh.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 22:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LunmkpyZTHjgvSZKdw92/F6exJ7yKjpP4k5iFcGt28Q=;
        b=dDsTSnXPiEBlNGdlw746l9Jhs+Cj1VfEbbIqgnDKkr3kny+xfAsdKYTA4A+5kxbPTD
         p3ARECQsBHl/fijxFyKq03lfamgW7IUVTczcVRtH/OvH5xQA6etzZd1ty3SID0f9UldF
         PoxzH+ZPbtHNRbrY6mHEcd90FgcRX/4ZRyZVHuoO1rChK+ubmF+N+U+u5kIkwKKYzwFt
         cxHsi5K2DRhhylaE//qPr6gOOQPy1xQ1KLFJOlnZeClscdafeihrfIZAZaJBLlLS8tbA
         aAcaH08GXbcTXA6RXyDqYSTkbbkL0IBerQLFkKsHmnttoAc/SLHoUGYuFPXVywEvCJst
         5y0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LunmkpyZTHjgvSZKdw92/F6exJ7yKjpP4k5iFcGt28Q=;
        b=mpW3iB25eaLjYtPj+KBHn3pvSN7YXmIkrr47ynjCgxHvta+NLTDt4FQveS7jg4IGv6
         tMbzAQ4t733IXirp1XjLWvgEdGcayoUDl62/V2HMsKRnhWt/pnVpaYtroZjr0tP8+UMG
         PPuMEfW9NUxM5THfm2yVQgLpHc3pPjNJxch+zvrWbs+3MIdUDa+14VP60wWbAPNZlXxE
         az+eQgqeMf8YMj8R0BApxuuCkf+LtcZiMR5JeeP/D1yXJ1KUdab+Gz/AzBSwNpU0k3hs
         koaEpCzFF4sCXbQqE0y1EfCa2ORZwymyT6/1SVUTdEkIqpUWJfsNN++RHc6VHLWWgova
         4daw==
X-Gm-Message-State: AOAM5334/S9TzgFMMY+ICokVo+Sl2WAmtNpY3T8gbxO6KKbprduE9gwQ
        UT4nTN9xYbo1lHPK1q3USoo=
X-Google-Smtp-Source: ABdhPJxMZdJq5xnjLSHUgz2b3jwE/YnUT1m7sRTojshV5EHUamLHjmCJU/utJPHm/i8ACTRpWrWYrw==
X-Received: by 2002:a63:8ec7:: with SMTP id k190mr17165652pge.261.1593666737980;
        Wed, 01 Jul 2020 22:12:17 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id z3sm7258006pfz.38.2020.07.01.22.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 22:12:17 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 2 Jul 2020 14:12:13 +0900
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
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
Message-ID: <20200702051213.GB3450@jagdpanzerIV.localdomain>
References: <CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com>
 <CAHp75Vd8nTzmZdnhpTDChdc11zyCaSfeigbxaCpOWZ1Lv9ZBMw@mail.gmail.com>
 <20200630035816.GA21591@jagdpanzerIV.localdomain>
 <20200630102141.GA11587@alley>
 <20200630105512.GA530@jagdpanzerIV.localdomain>
 <20200630122239.GD6173@alley>
 <20200630130534.GB145027@jagdpanzerIV.localdomain>
 <20200630180255.GD37466@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630180255.GD37466@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/06/30 11:02), Tony Lindgren wrote:
> This conditional disable for irq_shared does not look nice to me
> from the other device point of view :)
> 
> Would it be possible to just set up te dummy interrupt handler
> for the startup, then change it back afterwards? See for example
> omap8250_no_handle_irq().

I think we can do it. serial8250_do_startup() and irq handler take
port->lock, so they should be synchronized.

Something like this then?

---

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index f77bf820b7a3..61ad6f5f0f88 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2140,6 +2140,11 @@ static void serial8250_put_poll_char(struct uart_port *port,
 
 #endif /* CONFIG_CONSOLE_POLL */
 
+static int serial8250_dummy_handle_irq(struct uart_port *port)
+{
+	return 0;
+}
+
 int serial8250_do_startup(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
@@ -2271,6 +2276,9 @@ int serial8250_do_startup(struct uart_port *port)
 
 	if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
 		unsigned char iir1;
+		int (*handler)(struct uart_port *);
+
+		handler = port->handle_irq;
 		/*
 		 * Test for UARTs that do not reassert THRE when the
 		 * transmitter is idle and the interrupt has already
@@ -2280,8 +2288,7 @@ int serial8250_do_startup(struct uart_port *port)
 		 * allow register changes to become visible.
 		 */
 		spin_lock_irqsave(&port->lock, flags);
-		if (up->port.irqflags & IRQF_SHARED)
-			disable_irq_nosync(port->irq);
+		port->handle_irq = serial8250_dummy_handle_irq;
 
 		wait_for_xmitr(up, UART_LSR_THRE);
 		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
@@ -2293,8 +2300,7 @@ int serial8250_do_startup(struct uart_port *port)
 		iir = serial_port_in(port, UART_IIR);
 		serial_port_out(port, UART_IER, 0);
 
-		if (port->irqflags & IRQF_SHARED)
-			enable_irq(port->irq);
+		port->handle_irq = handler;
 		spin_unlock_irqrestore(&port->lock, flags);
 
 		/*
