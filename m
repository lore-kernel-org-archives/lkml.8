Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F93BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78FFD20776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590742853;
	bh=O3m1nYEfL/RHymF6G2Kc+ccFVdEcxHD2PLgtvWog9+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zo7UdahnEgw/o3knUIhHoumEwRO3FtjNxlTE6R8VYYocpz8LUKI9TtR2PkIpFWJaw
	 Wr07Qdr+690lHpeZAd891zEyRt5/el4m3iCuRwlf6y3rzhelcUCfxiLqq3MdoP8rri
	 0TVOXiJAR4u0U3iFnEaf9oIWkx0/LInaCwtsauq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgE2JAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 05:00:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40227 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2JAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 05:00:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id z13so1653660ljn.7;
        Fri, 29 May 2020 02:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y51p4aZ2qyhzMgLUjxkLCOTI6Fs3ymZMaOjHD3Nq89o=;
        b=ZU6X9LQqFDHtsn/oxikoklYW8r8rldrlJnJZxQGKvXz6CTNsR/Wvi3tpqiIU7QLcg+
         fQxQ0TP/XqakruNxrxScSNoSPhP6/3xHBy31oJSzXrfAkqZhdAEhlFWN/lTUlHflrZ5J
         5FjHSSaAomxs3r5h/l7hKloP6hjeNpJT9uH6dtHAF9eClu3ccAHX8P0OdjfRB5ICQfk7
         XOMmXgXeZYVZ1L+UD0YbLz0MBf+4/iJZts4uy3SU0DyLceiwXDqQB+RzEj0zULgLs6Sb
         2KWGK3yy0MR9m+kW58uMkhRabbbQY1hKklpSBKNH10UC3g7IRronDBnZU8zG/ViuNZlu
         V2Iw==
X-Gm-Message-State: AOAM5306iTzt+UPXsQ6Dihit06wTtfzIbcT2ToYSO+J9ka6YICWlWUvo
        PjMfBtq3Q6+BUbYdq9xxZkM=
X-Google-Smtp-Source: ABdhPJyNRUpDrqTMDxn+iJysLzipPXtv1y790QMq43k1rXw8OrSuALUMPXKWQUe/Ym3tiSLXju2QtA==
X-Received: by 2002:a2e:9099:: with SMTP id l25mr3687730ljg.82.1590742848764;
        Fri, 29 May 2020 02:00:48 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id k24sm1886447lji.94.2020.05.29.02.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 02:00:47 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jeasd-00042b-L8; Fri, 29 May 2020 11:00:43 +0200
Date:   Fri, 29 May 2020 11:00:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        patong.mxl@gmail.com, Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 2/2] usb: serial: xr_serial: Add gpiochip support
Message-ID: <20200529090043.GB19480@localhost>
References: <20200430184924.31690-1-mani@kernel.org>
 <20200430184924.31690-3-mani@kernel.org>
 <20200519130740.GE27787@localhost>
 <20200527030959.GA6129@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527030959.GA6129@Mani-XPS-13-9360>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 08:39:59AM +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> On Tue, May 19, 2020 at 03:07:40PM +0200, Johan Hovold wrote:
> > On Fri, May 01, 2020 at 12:19:24AM +0530, mani@kernel.org wrote:
> > > From: Manivannan Sadhasivam <mani@kernel.org>
> > > 
> > > Add gpiochip support for Maxlinear/Exar USB to serial converter
> > > for controlling the available gpios.

> > > +static int xr21v141x_gpio_init(struct usb_serial_port *port)
> > > +{
> > > +	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
> > > +	int ret;
> > > +	u8 gpio_mode;
> > > +
> > > +	port_priv->gc.ngpio = 6;
> > > +
> > > +	ret = xr_get_reg(port, XR21V141X_UART_REG_BLOCK,
> > > +			 port_priv->regs->gpio_mode, &gpio_mode);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Mark all pins which are not in GPIO mode */
> > > +	if (gpio_mode & UART_MODE_RTS_CTS)
> > > +		port_priv->gpio_altfunc |= (BIT(4) | BIT(5));
> > > +	else if (gpio_mode & UART_MODE_DTR_DSR)
> > > +		port_priv->gpio_altfunc |= (BIT(2) | BIT(3));
> > > +	else if (gpio_mode & UART_MODE_RS485)
> > > +		port_priv->gpio_altfunc |= BIT(5);
> > > +	else if (gpio_mode & UART_MODE_RS485_ADDR)
> > > +		port_priv->gpio_altfunc |= BIT(5);
> > > +	else
> > > +		port_priv->gpio_altfunc = 0; /* All GPIOs are available */
> > 
> > So this clearly isn't sufficient as the serial driver updates the
> > gpio-mode settings at runtime, which means you may have the two drivers
> > interfering with each other.
> 
> Agree. I was not sure earlier on how to handle this.
> 
> > You probably need to reserve at least CTS/RTS (gpio 4 and 5) for use
> > by the serial driver. But suddenly driving the DSR, RI and CD inputs
> > probably isn't a good idea either.
> > 
> > How would you even what know what these pins are used for generally?
> > 
> > Perhaps refusing all gpio requests while the port is open and making
> > sure that the serial driver never touches a requested pin could work
> > (including indirectly through hardware flow control, etc).
> 
> Is there an API or recommended way to check if the port is open? I
> just see a helper for tty...

You're gonna need to add your own flag and locking as you're
coordinating two distinct drivers.

Johan
