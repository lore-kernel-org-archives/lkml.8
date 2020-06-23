Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806FAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ACDE20738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hVTKgZRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732400AbgFWKwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 06:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732375AbgFWKwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 06:52:09 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5060C061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 03:52:08 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h5so20036879wrc.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 03:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dBzPbPycPoCqD0jxPC/ZRazkaIKgNXR6qz1TtThkFUU=;
        b=hVTKgZRYdrZf8D1hqAyqe0LNbpXqLr2qkyQuORdV5ZQF1n8hpcd2PdufDsxy2KZshW
         f3xFNx1WZb2U5LWD+NgGoZ7RarxK1BfT88GLA/1YuWUZ3l3UTlZO4jGaPBsRqOjOc9R4
         Gz86QuEbWGVO12QL7IcTOXHrAyOjMblCv6w1ADGv4nXP3YZwJVoeFu+dLUbQWZF5KzWn
         e8ajLS9iSB76QXQOfuZlpGZROIkNwTDFhhRsOc/OKvkydOic3Oo/md3dFvCPS5eX6T7Z
         4XuA5j6ku24jRQSOB5wf2TI8xKo1W911B7qq2Y4IPNu7Br70etSZO121Jms9Lll2HL0K
         srEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dBzPbPycPoCqD0jxPC/ZRazkaIKgNXR6qz1TtThkFUU=;
        b=SsmsbrrjjKMSbvOpku8RbOPjw/AACdS4ku9FBm0Ihuvq+Gr2+f5i7yhNu+Dzitecq1
         pHP+bk/B/xTpZFHWicjCjeM5pD6Es0+NtCOgK79ysx7sHr36q5acbA/PZBynuAgFj3DD
         nFRdS4ZDGkh0RL902uNLtJM042tV3dfkXOdUWQF12fvQmVX6cpc/DZa52765I+4nbiLj
         +kWSWOX1bQ+F1v27D5nMIz8mB6SRrcl9wSkYEN89AKb7L3l5TTZBvBt/8mfI19RNXxs8
         RzEO/Jq2Tr4o0BLQ625qPOrirZ/2bTAtNJwUgLyrLFX+QIhDSzU3fXdbbuxxuYb7N9OQ
         9+AA==
X-Gm-Message-State: AOAM530EjKCXRsQOyaEyjUU66Y4hb3o1owgXd91uB5dugNaw22e/DdD7
        U0JefWfH/Xm+wIf1L2hr8x4LUQ==
X-Google-Smtp-Source: ABdhPJxLAPHsxecFBVI1/3n+UdvZKrmvDn4Mcf8d7zg0Xtlmk9Z6ZJ4YUJm4LoASAqM0Kz5pD+MAXA==
X-Received: by 2002:adf:dc42:: with SMTP id m2mr26010430wrj.342.1592909527428;
        Tue, 23 Jun 2020 03:52:07 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id c66sm3471923wma.20.2020.06.23.03.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 03:52:06 -0700 (PDT)
Date:   Tue, 23 Jun 2020 11:52:04 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] tty: serial: Add poll_get_irq() to the polling
 interface
Message-ID: <20200623105204.mj4eax7wq7om4jka@holly.lan>
References: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
 <1592835984-28613-3-git-send-email-sumit.garg@linaro.org>
 <20200622155624.he2vs2r3e5yzf3sl@holly.lan>
 <CAFA6WYPEbLVRSHC0QFcWusUrakmxuEjBMYJQb41htbALeTQRPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPEbLVRSHC0QFcWusUrakmxuEjBMYJQb41htbALeTQRPg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 01:18:25PM +0530, Sumit Garg wrote:
> On Mon, 22 Jun 2020 at 21:26, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Mon, Jun 22, 2020 at 07:56:19PM +0530, Sumit Garg wrote:
> > > From: Daniel Thompson <daniel.thompson@linaro.org>
> >
> > Sumit, to some extent this mail is me yelling at myself two years ago
> > although, in my defence, at the time I choose not to post it because I
> > knew it wasn't right.
> >
> > I'm a bit concerned to see the TODO: comment critiquing this interface
> > being removed (from patch 3) without this patch being changed to
> > address that comment.
> >
> 
> I did consider that comment but I couldn't think of a normal scenario
> where request_irq() should fail. And in case it fails as well, I did
> put in "WARN_ON(res);" so that the user is notified of that particular
> error scenario.
> 
> >
> > > Add new API: poll_get_irq() to the polling interface in order for user
> > > of polling interface to retrieve allocated IRQ corresponding to
> > > underlying serial device.
> > >
> > > Although, serial interface still works in polling mode but interrupt
> > > associated with serial device can be leveraged for special purposes like
> > > debugger(kgdb) entry.
> > >
> > > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  drivers/tty/serial/serial_core.c | 18 ++++++++++++++++++
> > >  include/linux/serial_core.h      |  1 +
> > >  include/linux/tty_driver.h       |  1 +
> > >  3 files changed, 20 insertions(+)
> > >
> > > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> > > index 66a5e2f..1bb033c 100644
> > > --- a/drivers/tty/serial/serial_core.c
> > > +++ b/drivers/tty/serial/serial_core.c
> > > @@ -2470,6 +2470,23 @@ static void uart_poll_put_char(struct tty_driver *driver, int line, char ch)
> > >       port->ops->poll_put_char(port, ch);
> > >       uart_port_deref(port);
> > >  }
> > > +
> > > +static int uart_poll_get_irq(struct tty_driver *driver, int line)
> > > +{
> > > +     struct uart_driver *drv = driver->driver_state;
> > > +     struct uart_state *state = drv->state + line;
> > > +     struct uart_port *port;
> > > +     int ret = -ENODEV;
> > > +
> > > +     port = uart_port_ref(state);
> > > +     if (port && port->ops->poll_get_irq) {
> > > +             ret = port->ops->poll_get_irq(port);
> > > +             uart_port_deref(port);
> > > +     }
> > > +
> > > +     return ret;
> > > +}
> > > +
> > >  #endif
> > >
> > >  static const struct tty_operations uart_ops = {
> > > @@ -2505,6 +2522,7 @@ static const struct tty_operations uart_ops = {
> > >       .poll_init      = uart_poll_init,
> > >       .poll_get_char  = uart_poll_get_char,
> > >       .poll_put_char  = uart_poll_put_char,
> > > +     .poll_get_irq   = uart_poll_get_irq,
> >
> > The TODO comments claimed this API was bogus because it doesn't permit
> > a free and that can cause interoperation problems with the real serial
> > driver. I'll cover some of that in a reply to patch 3 but for now.
> >
> > Anyhow, for this patch, what are the expected semantics for
> > uart_poll_get_irq().
> 
> Currently, the expected use for this API is to enable uart RX
> interrupts and return corresponding IRQ id.
> 
> Although, we can make this interface modular as follows:
> 
> .poll_get_irq
> .poll_enable_rx_int
> .poll_disable_rx_int
> 
> Your views?

A direct reply is to ask what the purpose of poll_enable_rx_int()
is? It appears to be making something modular without any reason to do
so.

More generally lets ask some more questions:

1. What serial hardware and/or driver state change happens when we call
   poll_get_irq()

2. After a call to poll_get_irq() are there any new restrictions on
   the underlying serial driver?

3. Does implementing poll_get_irq() create an implied change of
   contract to any other polling function (I think yes, because
   poll_read_char() will now have to acknowledge an interrupt if
   the interrupt flags are edge triggered)?

4. To what extent, if any, do we have to support disconnection of
   kgdb_nmi?

5. Is the API matched with how it will be used by the layers above?
   (top level uses a request_irq approach, low level is using a
   let me have the irq number approach)

An interesting idea to explore is using a different verb for
poll_get_irq(). Perhaps poll_borrow_irq()? It is now much clearer that
we are stealing the IRQ and making it unusable by the underlying serial
driver.


> > In particular how do they ensure correct interlocking with the real
> > serial driver underlying it (if kgdb_nmi is active on a serial port
> > then the underlying driver better not be active at the same time).
> >
> 
> AFAIU kgdb_nmi feature, it registers a new tty driver (ttyNMI0) which
> is expected to work alongside underlying tty driver (eg. ttyAMA0 with
> amba-pl011). So ttyAMA0 will only become active if user-space tries to
> interact with /dev/ttyAMA0 like:
> 
> # echo "Hello World!" > /dev/ttyAMA0
> 
> So I would like to understand the downsides of having both of them
> active at the same time using shared IRQ (although that won't be
> possible with NMI as that doesn't support shared mode)?

It is likely that one of the interrupt handlers will become unreachable
since the first handler to execute will clear the interrupt flags. This
will result in anything waiting for the broken driver getting stuck and
not reporting an error code.

That isn't acceptable.


Daniel.
