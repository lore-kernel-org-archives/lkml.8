Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED357C433E3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7791207F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593608975;
	bh=hcco6lOrPytOSbQ6kYXDpnj5JhfN/daGwHHgc5FTX60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cW3NAp5aRsF+9F8gIvOiXNTfC+iKXSy+QW7rFTVLnc0cXq23zSml82U/Yarny2vtK
	 kNVFXS8Qp91MH42+SwD2tfUpu5VbjMWh0tHsoWdrPx6SZDxLU07CjZpthUNns0vKmt
	 U3vEu4yX9Hwt36IXq/Opj8yjJzKlH+JdFY7D/5hU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbgGANJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:09:34 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38677 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbgGANJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:09:32 -0400
Received: by mail-lf1-f65.google.com with SMTP id t9so13537481lfl.5;
        Wed, 01 Jul 2020 06:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=COivOHfOocZwA37NPyRxnZREf917pes6hqCRF+dIcV4=;
        b=t9lLcwTs0aM805no82txbKBtvbxqo1+q29NXY2JZ/7w5GAh0CUyJcm7dlZQmUCMnZk
         PbmMmfKEMIjql3qF7iDnYJ7GEUTr0w4HpOco//7fw+rQFrbYoi1W1Ph3KgwwjYMAiESL
         UucoXcKrW6Dr+VsuKarQYOD2fhdjPdPi4rmiZPGz9880ZwMvZdPy8aZ28H9d1L+z1bJ8
         OY+l6uUmt3tW27BXUjHOJhq4rFo+u5HxH06lA4NNErdoRpRdKkbZn91lI28KvjYV+d1e
         /GbivsAnDDKciAYi7nHBLcbjvc9o2uclmaMXiY3PbGVVYBfO0x14KtQCxfKizChNkR+7
         zOwA==
X-Gm-Message-State: AOAM5321jZ4q/QQmnxOCsm7HXk8Ace54UeQqPlPmJRxo6TUEoWCcjhSV
        qqo0gv1SmWhQzCWOk3gsJPY=
X-Google-Smtp-Source: ABdhPJwx42aReoFcxz2SU6ldQfkiBMixkdgzhIE0bt3elb89uv84Hv4kF3wLV76q/lOLuFga7griMw==
X-Received: by 2002:a19:64c:: with SMTP id 73mr15464054lfg.0.1593608969420;
        Wed, 01 Jul 2020 06:09:29 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id v24sm2035542lfo.4.2020.07.01.06.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 06:09:28 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jqcUO-0007YY-7N; Wed, 01 Jul 2020 15:09:24 +0200
Date:   Wed, 1 Jul 2020 15:09:24 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        patong.mxl@gmail.com, linus.walleij@linaro.org,
        mchehab+huawei@kernel.org
Subject: Re: [RESEND PATCH v4 1/3] usb: serial: Add MaxLinear/Exar USB to
 Serial driver
Message-ID: <20200701130924.GE3334@localhost>
References: <20200607162350.21297-1-mani@kernel.org>
 <20200607162350.21297-2-mani@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607162350.21297-2-mani@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 07, 2020 at 09:53:48PM +0530, Manivannan Sadhasivam wrote:
> Add support for MaxLinear/Exar USB to Serial converters. This driver
> only supports XR21V141X series but it can be extended to other series
> from Exar as well in future.
> 
> This driver is inspired from the initial one submitted by Patong Yang:
> 
> https://patchwork.kernel.org/patch/10543261/
> 
> While the initial driver was a custom tty USB driver exposing whole
> new serial interface ttyXRUSBn, this version is completely based on USB
> serial core thus exposing the interfaces as ttyUSBn. This will avoid
> the overhead of exposing a new USB serial interface which the userspace
> tools are unaware of.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Tested-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  drivers/usb/serial/Kconfig     |   9 +
>  drivers/usb/serial/Makefile    |   1 +
>  drivers/usb/serial/xr_serial.c | 650 +++++++++++++++++++++++++++++++++
>  3 files changed, 660 insertions(+)
>  create mode 100644 drivers/usb/serial/xr_serial.c

> +static int xr_tiocmset_port(struct usb_serial_port *port,
> +			    unsigned int set, unsigned int clear)
> +{
> +	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
> +	int ret = 0;
> +	u8 gpio_set = 0;
> +	u8 gpio_clr = 0;
> +
> +	/* Modem control pins are active low, so set & clr are swapped */
> +	if (set & TIOCM_RTS)
> +		gpio_clr |= UART_MODE_RTS;
> +	if (set & TIOCM_DTR)
> +		gpio_clr |= UART_MODE_DTR;
> +	if (clear & TIOCM_RTS)
> +		gpio_set |= UART_MODE_RTS;
> +	if (clear & TIOCM_DTR)
> +		gpio_set |= UART_MODE_DTR;
> +
> +	/* Writing '0' to gpio_{set/clr} bits has no effect, so no need to do */
> +	if (gpio_clr) {
> +		ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
> +				 port_priv->regs->gpio_clr, gpio_clr);
> +	}
> +
> +	if (gpio_set) {
> +		ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
> +				 port_priv->regs->gpio_set, gpio_set);
> +	}
> +
> +	return ret;
> +}
> +
> +static int xr_tiocmset(struct tty_struct *tty,
> +		       unsigned int set, unsigned int clear)
> +{
> +	struct usb_serial_port *port = tty->driver_data;
> +
> +	return xr_tiocmset_port(port, set, clear);
> +}

> +static void xr_dtr_rts(struct usb_serial_port *port, int on)
> +{
> +	if (on)
> +		xr_tiocmset_port(port, TIOCM_DTR | TIOCM_RTS, 0);
> +	else
> +		xr_tiocmset_port(port, 0, TIOCM_DTR | TIOCM_RTS);
> +}

By the way, don't you need to configure the DTR and RTS pins as outputs
for the serial driver as well?

According to the datasheet they are both configured as inputs by default
(or at least RTS is).

In any case, you'll need to reconfigure each pin after they are released
by gpiolib.

Johan
