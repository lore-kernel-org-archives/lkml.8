Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD96C35DF9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F00820714
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582624081;
	bh=XiHuhhRWWcTfantjfm4wWh+2+qU0p61D/4nHYZU6F8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TxhhbxhQponUp779eKEegZ0z+fCA9np1QQNNF+RJQ84g2GKl1PFuA9xgKTlkcoAOm
	 37HEDwNjFQB1QrP+KSqzULKal+e11qB5JgIAKOnVNFK/S7jFhOtFeRCPpAJr5i681y
	 ypuk+lo6mlUAoGg8krOHOK/7J8Mumg3YOwiw4gps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbgBYJr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 04:47:59 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37620 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgBYJr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 04:47:59 -0500
Received: by mail-lj1-f194.google.com with SMTP id q23so13302730ljm.4;
        Tue, 25 Feb 2020 01:47:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qhXDCVR/0HFvg0rxexmKDd40UCW8T/Aqg6KAfMG9Gvg=;
        b=njqR8RIdrorXVyy+sLHvo9v0ZMldf8sRfHBjNn7UlT6rVJuEq4djFy9HIvUlQrhIH5
         zI8d04f2g8HQAuL6czkUol8U+pByLOQA7Kt9NdQRp0VLqoOI556oNpis6bNTv1WPdqEq
         8MmL/vq80EYaxFTXuRcgAMB9MlFcpg9mvJvSv2mQ/YLJtcfkXerPG7HU2hYh/7t866p0
         TdfzheDXfIznwTLa2MVZ8Sv8dZ5WVrvzirgWXYXQ6CdJZ9twV9YFE0jNBs1XjK+N3TIj
         C1kdiPGCwSfa0PTu+IHzm2jmOA9JvmPC0OfgKW/juYFlv9/hOGpuEmi7/wL5dCTrY46N
         3Btw==
X-Gm-Message-State: APjAAAWpYzDdymqFa6JTEjkb++3p9gCM1EN85vYhVUB5odibWN4qatAs
        dZAMNOkMLXCtGCqAWSlS43k=
X-Google-Smtp-Source: APXvYqzRm3Q/DDappLEFGVfwrkQ4Im3idqlHSc3zcc/uUzA4DkPkRC4zAPbTUOvcGjYUMbN3DwfA/w==
X-Received: by 2002:a2e:3214:: with SMTP id y20mr32843328ljy.69.1582624076338;
        Tue, 25 Feb 2020 01:47:56 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id x10sm7472146ljd.68.2020.02.25.01.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 01:47:55 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1j6Woh-0001Sk-Oj; Tue, 25 Feb 2020 10:47:51 +0100
Date:   Tue, 25 Feb 2020 10:47:51 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Carl Karsten <carl@nextdayvideo.com>, Tim Ansell <me@mith.ro>
Subject: Re: [PATCH] USB: serial: Add vizzini driver for Exar USB2 serial
 adapters
Message-ID: <20200225094751.GQ32540@localhost>
References: <20200117044148.263556-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117044148.263556-1-joel@jms.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 02:41:48PM +1000, Joel Stanley wrote:
> From: Ben Hutchings <ben@decadent.org.uk>
> 
> This driver supports the one, two and four port variants of the USB
> serial adapters. These devices are present on the Digilent Atlys FPGA
> board.
> 
> This driver was written by Ben in 2015. Minor cleanups and fixes for the
> 1410 by Joel.
> 
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/usb/serial/Kconfig   |   9 +
>  drivers/usb/serial/Makefile  |   1 +
>  drivers/usb/serial/vizzini.c | 370 +++++++++++++++++++++++++++++++++++
>  3 files changed, 380 insertions(+)
>  create mode 100644 drivers/usb/serial/vizzini.c
> 
> diff --git a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
> index 25d7e0c36d38..167992ad1d05 100644
> --- a/drivers/usb/serial/Kconfig
> +++ b/drivers/usb/serial/Kconfig
> @@ -654,4 +654,13 @@ config USB_SERIAL_DEBUG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called usb-debug.
>  
> +config USB_SERIAL_VIZZINI
> +	tristate "USB Exar XR21V141x 'Vizzini' Serial Driver"
> +	help
> +	  Say Y here if you want to use the Exar XR21V1410/1412/141
> +	  USB 2 serial dapters.

typo: adapters

> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called vizzini.
> +
>  endif # USB_SERIAL
> diff --git a/drivers/usb/serial/Makefile b/drivers/usb/serial/Makefile
> index 2d491e434f11..9f65a4863f1d 100644
> --- a/drivers/usb/serial/Makefile
> +++ b/drivers/usb/serial/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_USB_SERIAL_WWAN)			+= usb_wwan.o
>  obj-$(CONFIG_USB_SERIAL_TI)			+= ti_usb_3410_5052.o
>  obj-$(CONFIG_USB_SERIAL_UPD78F0730)		+= upd78f0730.o
>  obj-$(CONFIG_USB_SERIAL_VISOR)			+= visor.o
> +obj-$(CONFIG_USB_SERIAL_VIZZINI)		+= vizzini.o
>  obj-$(CONFIG_USB_SERIAL_WISHBONE)		+= wishbone-serial.o
>  obj-$(CONFIG_USB_SERIAL_WHITEHEAT)		+= whiteheat.o
>  obj-$(CONFIG_USB_SERIAL_XIRCOM)			+= keyspan_pda.o
> diff --git a/drivers/usb/serial/vizzini.c b/drivers/usb/serial/vizzini.c
> new file mode 100644
> index 000000000000..f4d1b9a75d8a
> --- /dev/null
> +++ b/drivers/usb/serial/vizzini.c
> @@ -0,0 +1,370 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Based on vizzini driver:
> + *
> + * Copyright (c) 2013 Exar Corporation, Inc.
> + *
> + * Based on USB Serial "Simple" driver
> + *
> + * Copyright (C) 2001-2006,2008,2013 Greg Kroah-Hartman <greg@kroah.com>
> + * Copyright (C) 2005 Arthur Huillet (ahuillet@users.sf.net)
> + * Copyright (C) 2005 Thomas Hergenhahn <thomas.hergenhahn@suse.de>
> + * Copyright (C) 2009 Outpost Embedded, LLC
> + * Copyright (C) 2010 Zilogic Systems <code@zilogic.com>
> + * Copyright (C) 2013 Wei Shuai <cpuwolf@gmail.com>
> + * Copyright (C) 2013 Linux Foundation

This looked weird, but I understand where it comes from now. With a
calc_num_ports() callback, you can drop this bit (see below).

> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/tty.h>
> +#include <linux/module.h>
> +#include <linux/usb.h>
> +#include <linux/usb/serial.h>
> +
> +#define XR_SET_REG			0
> +
> +#define URM_REG_BLOCK			4
> +#define EPLOCALS_REG_BLOCK		0x66
> +
> +#define MEM_EP_LOCALS_SIZE_S		3
> +#define MEM_EP_LOCALS_SIZE		(1 << MEM_EP_LOCALS_SIZE_S)
> +
> +#define EP_WIDE_MODE			0x03
> +
> +#define UART_GPIO_MODE			0x01a
> +
> +#define UART_GPIO_MODE_SEL_M		0x7
> +#define UART_GPIO_MODE_SEL_S		0
> +#define UART_GPIO_MODE_SEL		0x007
> +
> +#define UART_GPIO_MODE_SEL_GPIO		(0x0 << UART_GPIO_MODE_SEL_S)
> +#define UART_GPIO_MODE_SEL_RTS_CTS	(0x1 << UART_GPIO_MODE_SEL_S)
> +#define UART_GPIO_MODE_SEL_DTR_DSR	(0x2 << UART_GPIO_MODE_SEL_S)
> +
> +#define UART_ENABLE			0x003
> +#define UART_ENABLE_TX_M		0x1
> +#define UART_ENABLE_TX_S		0

Looks like several of these mask/shift defines are unused.

> +#define UART_ENABLE_TX			0x001
> +#define UART_ENABLE_RX_M		0x1
> +#define UART_ENABLE_RX_S		1
> +#define UART_ENABLE_RX			0x002
> +
> +#define UART_CLOCK_DIVISOR_0		0x004
> +#define UART_CLOCK_DIVISOR_1		0x005
> +#define UART_CLOCK_DIVISOR_2		0x006
> +
> +#define UART_TX_CLOCK_MASK_0		0x007
> +#define UART_TX_CLOCK_MASK_1		0x008
> +
> +#define UART_RX_CLOCK_MASK_0		0x009
> +#define UART_RX_CLOCK_MASK_1		0x00a
> +
> +#define UART_FORMAT			0x00b
> +
> +#define UART_FORMAT_SIZE_M		0xf
> +#define UART_FORMAT_SIZE_S		0
> +#define UART_FORMAT_SIZE		0x00f

Same here.

> +#define UART_FORMAT_SIZE_7		(0x7 << UART_FORMAT_SIZE_S)
> +#define UART_FORMAT_SIZE_8		(0x8 << UART_FORMAT_SIZE_S)
> +#define UART_FORMAT_SIZE_9		(0x9 << UART_FORMAT_SIZE_S)
> +
> +#define UART_FORMAT_PARITY_M		0x7
> +#define UART_FORMAT_PARITY_S		4
> +#define UART_FORMAT_PARITY		0x070
> +
> +#define UART_FORMAT_PARITY_NONE		(0x0 << UART_FORMAT_PARITY_S)
> +#define UART_FORMAT_PARITY_ODD		(0x1 << UART_FORMAT_PARITY_S)
> +#define UART_FORMAT_PARITY_EVEN		(0x2 << UART_FORMAT_PARITY_S)
> +#define UART_FORMAT_PARITY_1		(0x3 << UART_FORMAT_PARITY_S)
> +#define UART_FORMAT_PARITY_0		(0x4 << UART_FORMAT_PARITY_S)
> +
> +#define UART_FORMAT_STOP_M		0x1
> +#define UART_FORMAT_STOP_S		7
> +#define UART_FORMAT_STOP		0x080
> +
> +#define UART_FORMAT_STOP_1		(0x0 << UART_FORMAT_STOP_S)
> +#define UART_FORMAT_STOP_2		(0x1 << UART_FORMAT_STOP_S)
> +
> +#define UART_FLOW			0x00c
> +
> +#define UART_FLOW_MODE_M		0x7
> +#define UART_FLOW_MODE_S		0
> +#define UART_FLOW_MODE			0x007
> +
> +#define UART_FLOW_MODE_NONE		(0x0 << UART_FLOW_MODE_S)
> +#define UART_FLOW_MODE_HW		(0x1 << UART_FLOW_MODE_S)
> +#define UART_FLOW_MODE_SW		(0x2 << UART_FLOW_MODE_S)
> +
> +#define UART_XON_CHAR			0x010
> +#define UART_XOFF_CHAR			0x011
> +
> +#define URM_ENABLE_BASE			0x010
> +#define URM_ENABLE_0			0x010
> +#define URM_ENABLE_0_TX			0x001
> +#define URM_ENABLE_0_RX			0x002
> +
> +struct vizzini_baud_rate {
> +	unsigned int tx;
> +	unsigned int rx0;
> +	unsigned int rx1;
> +};
> +
> +static const struct vizzini_baud_rate vizzini_baud_rates[] = {
> +	{ 0x000, 0x000, 0x000 },
> +	{ 0x000, 0x000, 0x000 },
> +	{ 0x100, 0x000, 0x100 },
> +	{ 0x020, 0x400, 0x020 },
> +	{ 0x010, 0x100, 0x010 },
> +	{ 0x208, 0x040, 0x208 },
> +	{ 0x104, 0x820, 0x108 },
> +	{ 0x844, 0x210, 0x884 },
> +	{ 0x444, 0x110, 0x444 },
> +	{ 0x122, 0x888, 0x224 },
> +	{ 0x912, 0x448, 0x924 },
> +	{ 0x492, 0x248, 0x492 },
> +	{ 0x252, 0x928, 0x292 },
> +	{ 0x94A, 0x4A4, 0xA52 },
> +	{ 0x52A, 0xAA4, 0x54A },
> +	{ 0xAAA, 0x954, 0x4AA },
> +	{ 0xAAA, 0x554, 0xAAA },
> +	{ 0x555, 0xAD4, 0x5AA },
> +	{ 0xB55, 0xAB4, 0x55A },
> +	{ 0x6B5, 0x5AC, 0xB56 },
> +	{ 0x5B5, 0xD6C, 0x6D6 },
> +	{ 0xB6D, 0xB6A, 0xDB6 },
> +	{ 0x76D, 0x6DA, 0xBB6 },
> +	{ 0xEDD, 0xDDA, 0x76E },
> +	{ 0xDDD, 0xBBA, 0xEEE },
> +	{ 0x7BB, 0xF7A, 0xDDE },
> +	{ 0xF7B, 0xEF6, 0x7DE },
> +	{ 0xDF7, 0xBF6, 0xF7E },
> +	{ 0x7F7, 0xFEE, 0xEFE },
> +	{ 0xFDF, 0xFBE, 0x7FE },
> +	{ 0xF7F, 0xEFE, 0xFFE },
> +	{ 0xFFF, 0xFFE, 0xFFD },
> +};
> +
> +static int vizzini_set_reg(struct usb_serial_port *port,
> +			   unsigned int block, unsigned int regnum,
> +			   unsigned int value)
> +{
> +	dev_dbg(&port->serial->dev->dev, "%s 0x%02x:0x%02x = 0x%02x\n",
> +		__func__, block, regnum, value);

Use &port->dev instead.

> +
> +	return usb_control_msg(port->serial->dev,
> +			       usb_sndctrlpipe(port->serial->dev, 0),
> +			       XR_SET_REG,
> +			       USB_DIR_OUT | USB_TYPE_VENDOR,
> +			       value, regnum | (block << 8),
> +			       NULL, 0,
> +			       5000);

Use USB_CTRL_SET_TIMEOUT

Report errors?

> +}
> +
> +static void vizzini_disable(struct usb_serial_port *port)
> +{
> +	unsigned int block = port->bulk_out_endpointAddress - 1;

You should probably use port->port_number instead of relying on fixed
endpoint addresses which you never verify.

> +
> +	vizzini_set_reg(port, block, UART_ENABLE, 0);
> +	vizzini_set_reg(port, URM_REG_BLOCK, URM_ENABLE_BASE + block, 0);
> +}
> +
> +static void vizzini_enable(struct usb_serial_port *port)
> +{
> +	unsigned int block = port->bulk_out_endpointAddress - 1;
>
> +	vizzini_set_reg(port, URM_REG_BLOCK, URM_ENABLE_BASE + block,
> +			URM_ENABLE_0_TX);

Could you add comment about why this sequence is necessary, if it really
is?

> +	vizzini_set_reg(port, block, UART_ENABLE,
> +			UART_ENABLE_TX | UART_ENABLE_RX);
> +	vizzini_set_reg(port, URM_REG_BLOCK, URM_ENABLE_BASE + block,
> +			URM_ENABLE_0_TX | URM_ENABLE_0_RX);

No error handling?

> +}
> +
> +static void vizzini_set_baud_rate(struct usb_serial_port *port,
> +				  unsigned int rate)
> +{
> +	int		block	= port->bulk_out_endpointAddress - 1;
> +	unsigned int	divisor = 48000000 / rate;

Use a define for the clock frequency?

> +	unsigned int	i	= ((32 * 48000000) / rate) & 0x1f;
> +	unsigned int	tx_mask = vizzini_baud_rates[i].tx;
> +	unsigned int	rx_mask = ((divisor & 1) ? vizzini_baud_rates[i].rx1 :
> +				   vizzini_baud_rates[i].rx0);

Don't do non-trivial initialisations at declaration. And please avoid
the ternary operator.

> +
> +	dev_dbg(&port->serial->dev->dev,
> +		"Setting baud rate to %d: i=%u div=%u tx=%03x rx=%03x\n",
> +		rate, i, divisor, tx_mask, rx_mask);
> +
> +	vizzini_set_reg(port, block, UART_CLOCK_DIVISOR_0,
> +			(divisor >>  0) & 0xff);
> +	vizzini_set_reg(port, block, UART_CLOCK_DIVISOR_1,
> +			(divisor >>  8) & 0xff);
> +	vizzini_set_reg(port, block, UART_CLOCK_DIVISOR_2,
> +			(divisor >> 16) & 0xff);
> +
> +	vizzini_set_reg(port, block, UART_TX_CLOCK_MASK_0,
> +			(tx_mask >>  0) & 0xff);
> +	vizzini_set_reg(port, block, UART_TX_CLOCK_MASK_1,
> +			(tx_mask >>  8) & 0xff);
> +
> +	vizzini_set_reg(port, block, UART_RX_CLOCK_MASK_0,
> +			(rx_mask >>  0) & 0xff);
> +	vizzini_set_reg(port, block, UART_RX_CLOCK_MASK_1,
> +			(rx_mask >>  8) & 0xff);

Error handling?

Can you add some comment about how the masks are used?

> +}
> +
> +static void vizzini_set_termios(struct tty_struct *tty,
> +				struct usb_serial_port *port,
> +				struct ktermios *termios_old)
> +{
> +	unsigned int             cflag, block;
> +	speed_t                  rate;
> +	unsigned int             format_size, format_parity, format_stop, flow, gpio_mode;

One declaration per line please, at least unless they are clearly
related (and stay under 80 cols).

Looks like you can get away with just a fmt variable.

> +
> +	cflag = tty->termios.c_cflag;
> +
> +	block = port->bulk_out_endpointAddress - 1;
> +
> +	vizzini_disable(port);

Do you really need to disable the port?

> +
> +	if ((cflag & CSIZE) == CS7)

Use C_CSIZE() and friends.

> +		format_size = UART_FORMAT_SIZE_7;
> +	else if ((cflag & CSIZE) == CS5)
> +		/* Enabling 5-bit mode is really 9-bit mode! */

What does this mean? That you have redefined CS5?

> +		format_size = UART_FORMAT_SIZE_9;
> +	else
> +		format_size = UART_FORMAT_SIZE_8;

You need to report back the settings actually used (update termios).

> +
> +	if (cflag & PARENB) {

C_PARENB() etc.

> +		if (cflag & PARODD) {
> +			if (cflag & CMSPAR)
> +				format_parity = UART_FORMAT_PARITY_1;
> +			else
> +				format_parity = UART_FORMAT_PARITY_ODD;
> +		} else {
> +			if (cflag & CMSPAR)
> +				format_parity = UART_FORMAT_PARITY_0;
> +			else
> +				format_parity = UART_FORMAT_PARITY_EVEN;
> +		}
> +	} else {
> +		format_parity = UART_FORMAT_PARITY_NONE;
> +	}
> +
> +	if (cflag & CSTOPB)
> +		format_stop = UART_FORMAT_STOP_2;
> +	else
> +		format_stop = UART_FORMAT_STOP_1;
> +
> +	vizzini_set_reg(port, block, UART_FORMAT,
> +			format_size | format_parity | format_stop);

Error handling.

> +
> +	if (cflag & CRTSCTS) {
> +		flow      = UART_FLOW_MODE_HW;
> +		gpio_mode = UART_GPIO_MODE_SEL_RTS_CTS;
> +	} else if (I_IXOFF(tty) || I_IXON(tty)) {
> +		unsigned char   start_char = START_CHAR(tty);
> +		unsigned char   stop_char  = STOP_CHAR(tty);
> +
> +		flow      = UART_FLOW_MODE_SW;
> +		gpio_mode = UART_GPIO_MODE_SEL_GPIO;
> +
> +		vizzini_set_reg(port, block, UART_XON_CHAR, start_char);
> +		vizzini_set_reg(port, block, UART_XOFF_CHAR, stop_char);
> +	} else {
> +		flow      = UART_FLOW_MODE_NONE;
> +		gpio_mode = UART_GPIO_MODE_SEL_GPIO;
> +	}
> +
> +	vizzini_set_reg(port, block, UART_FLOW, flow);
> +	vizzini_set_reg(port, block, UART_GPIO_MODE, gpio_mode);
> +
> +	vizzini_set_reg(port, EPLOCALS_REG_BLOCK,
> +			(block * MEM_EP_LOCALS_SIZE) + EP_WIDE_MODE,
> +			format_size == UART_FORMAT_SIZE_9);

What's this about?

> +
> +	rate = tty_get_baud_rate(tty);
> +	if (rate)
> +		vizzini_set_baud_rate(port, rate);
> +
> +	vizzini_enable(port);
> +}
> +
> +static int vizzini_probe(struct usb_serial *serial,
> +			 const struct usb_device_id *id)
> +{
> +	struct usb_host_interface *iface = serial->interface->cur_altsetting;
> +	int i;
> +
> +	for (i = 0; i < iface->desc.bNumEndpoints; i++) {
> +		if (usb_endpoint_is_bulk_out(&iface->endpoint[i].desc))
> +			return 0;
> +	}

Set num_bulk_out (and num_bulk_in?) in struct usb_serial_driver and let
core handle this for you, and you can drop probe() altogether.

> +
> +	/* No bulk interfaces found */
> +	dev_dbg(&serial->dev->dev, "Invalid interface, discarding\n");
> +
> +	return -ENODEV;
> +}
> +
> +static const struct usb_device_id id_table[] = {
> +	{ USB_DEVICE(0x04e2, 0x1410), },
> +	{ USB_DEVICE(0x04e2, 0x1412), },
> +	{ USB_DEVICE(0x04e2, 0x1414), },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(usb, id_table);
> +
> +static const struct usb_device_id vizzini_1410_id_table[] = {
> +	{ USB_DEVICE(0x04e2, 0x1410), },
> +	{ },
> +};
> +static struct usb_serial_driver vizzini_1410_device = {
> +	.driver = {
> +		.owner =	THIS_MODULE,
> +		.name =		"vizzini_1410",
> +	},
> +	.id_table =		vizzini_1410_id_table,
> +	.num_ports =		1,
> +	.set_termios =		vizzini_set_termios,
> +	.probe =		vizzini_probe,
> +};
> +
> +static const struct usb_device_id vizzini_1412_id_table[] = {
> +	{ USB_DEVICE(0x04e2, 0x1412), },
> +	{ },
> +};
> +static struct usb_serial_driver vizzini_1412_device = {
> +	.driver = {
> +		.owner =	THIS_MODULE,
> +		.name =		"vizzini_1412",
> +	},
> +	.id_table =		vizzini_1412_id_table,
> +	.num_ports =		2,
> +	.set_termios =		vizzini_set_termios,
> +};
> +
> +static const struct usb_device_id vizzini_1414_id_table[] = {
> +	{ USB_DEVICE(0x04e2, 0x1414), },
> +	{ },
> +};
> +static struct usb_serial_driver vizzini_1414_device = {
> +	.driver = {
> +		.owner =	THIS_MODULE,
> +		.name =		"vizzini_1414",
> +	},
> +	.id_table =		vizzini_1414_id_table,
> +	.num_ports =		4,
> +	.set_termios =		vizzini_set_termios,
> +};
> +
> +static struct usb_serial_driver * const serial_drivers[] = {
> +	&vizzini_1410_device,
> +	&vizzini_1412_device,
> +	&vizzini_1414_device,
> +	NULL
> +};

I think you should use a single struct usb_serial_driver for all three
models and implement the calc_num_ports() callback instead.

If you cannot determine the number of ports at runtime, you can encode
it in the device-id table (driver_info).

> +
> +module_usb_serial_driver(serial_drivers, id_table);
> +
> +MODULE_LICENSE("GPL");

Johan
