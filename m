Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4146DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CD53206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3pmMCMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgGCKco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 06:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgGCKcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 06:32:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2ABDC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 03:32:43 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w19so1825888ply.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 03:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pzSbVsHlCFQpZk8xTOuSpkh1whPCZ1SzpJvQ6Rn1zkg=;
        b=g3pmMCMOJMi5nBAfhKNeRhsdM9IPEcNKjdNl/1GJJdNSlHFuRZmMFj+XBBbX6Oljnb
         R8Sl47GsYbHDLJuA3gIWwzyXhTfBVusAwM/pdWbnX75taKK7bcOFDwXI1sm7cnKDID4u
         KqxrldZfztpG+9LzfLupMMXy46ZiBxOVZbWz3hNlxuZgu+4trbA94M+SW0MK4XEWGZKz
         XVnKeSbdKfI9LNyM4991PeGfzCUb+qqfG8VWNmSxazxHavlQBa4AM1u/Mdz6w9NxwFs0
         b7XjLoYUhIiMUgG6JUGm4hbZAAWy7HTB4ZWbdyLmY/3+Lam4kXG9IjJCx7dC3MHId/gq
         huaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pzSbVsHlCFQpZk8xTOuSpkh1whPCZ1SzpJvQ6Rn1zkg=;
        b=HwjebuDQr3XxbHNPeyaGX7Gln4wYN2ebpJIWamOKZQ3krHHJeqpSyTTO32jQcDzbtq
         BEPLto7QyRWdEbiW+V62qLzk9irzA9aI7DIfGPmcSmyqGuBzKcBSximEgvV/38qNEgE2
         orFA8mL+qO/Az2hLTfpH4FNZLBMeSnZVHwCuG515H/srqRXhpgETNycO26bYDfqREVu8
         zDiwPAb6muZuH3S5JPXMwe7mlYfrmM4Iv2jwz2KwIjKe94zMbldaMO3DT/G3PwFRzM3E
         ylreNPh50C28fsTfd/bS9qhuepbdDo/n/V7Cpad07hj/YJQEMHy90O5uHmG5qC3EnXrQ
         RaIQ==
X-Gm-Message-State: AOAM533soss11Hpisgp4C8rUHgkP6L2/oQ0kwSGwm1kDPtxmlpn7avvO
        xEHr3H03HlLZVNuZCWOf6ww=
X-Google-Smtp-Source: ABdhPJy111pSxySjL/ixdHKmTnldrRQEh14faMo2tb4fslJvCmTslv2FsO7P8dtV3z6tHDp0/OJLvQ==
X-Received: by 2002:a17:90a:ea0f:: with SMTP id w15mr39549618pjy.138.1593772363054;
        Fri, 03 Jul 2020 03:32:43 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id q24sm8451149pfg.34.2020.07.03.03.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 03:32:42 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 3 Jul 2020 19:32:41 +0900
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
Message-ID: <20200703103241.GB182102@jagdpanzerIV.localdomain>
References: <CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com>
 <CAHp75Vd8nTzmZdnhpTDChdc11zyCaSfeigbxaCpOWZ1Lv9ZBMw@mail.gmail.com>
 <20200630035816.GA21591@jagdpanzerIV.localdomain>
 <20200630102141.GA11587@alley>
 <20200630105512.GA530@jagdpanzerIV.localdomain>
 <20200630122239.GD6173@alley>
 <20200630130534.GB145027@jagdpanzerIV.localdomain>
 <20200630180255.GD37466@atomide.com>
 <20200702051213.GB3450@jagdpanzerIV.localdomain>
 <20200702160514.GK37466@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702160514.GK37466@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/02 09:05), Tony Lindgren wrote:
> * Sergey Senozhatsky <sergey.senozhatsky@gmail.com> [200702 05:13]:
> > On (20/06/30 11:02), Tony Lindgren wrote:
> > > This conditional disable for irq_shared does not look nice to me
> > > from the other device point of view :)
> > > 
> > > Would it be possible to just set up te dummy interrupt handler
> > > for the startup, then change it back afterwards? See for example
> > > omap8250_no_handle_irq().
> > 
> > I think we can do it. serial8250_do_startup() and irq handler take
> > port->lock, so they should be synchronized.
> > 
> > Something like this then?
> 
> Yeah thanks this should work better for shared irq.

This is, basically, an equivalent of

---
 drivers/tty/serial/8250/8250_port.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index d64ca77d9cfa..dba7747d2ddd 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2275,6 +2275,7 @@ int serial8250_do_startup(struct uart_port *port)
 
 	if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
 		unsigned char iir1;
+
 		/*
 		 * Test for UARTs that do not reassert THRE when the
 		 * transmitter is idle and the interrupt has already
@@ -2284,8 +2285,6 @@ int serial8250_do_startup(struct uart_port *port)
 		 * allow register changes to become visible.
 		 */
 		spin_lock_irqsave(&port->lock, flags);
-		if (up->port.irqflags & IRQF_SHARED)
-			disable_irq_nosync(port->irq);
 
 		wait_for_xmitr(up, UART_LSR_THRE);
 		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
@@ -2297,8 +2296,6 @@ int serial8250_do_startup(struct uart_port *port)
 		iir = serial_port_in(port, UART_IIR);
 		serial_port_out(port, UART_IER, 0);
 
-		if (port->irqflags & IRQF_SHARED)
-			enable_irq(port->irq);
 		spin_unlock_irqrestore(&port->lock, flags);
 
 		/*
-- 
2.27.0

