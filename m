Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D70C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6EBE2067D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593599688;
	bh=W29RQrMP8X2oqVEk/EkvexCJXJBbanleqrhqKV9EeZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oVihc8wmeIRwWUSvTFl/sBiGiKmyytD/KgtvJunazqqMgfoNEfQOc34VM7OGhBSAF
	 QTRGErqiZ1Xc8mx5TkftEw5+5mZlU2WmEh+8LNAhM8F6QiI6P5HHgl37xJRVl4WGVl
	 MV6KC30yOFlqyeCeG37UYPTewKdfoR7uQJgnmNGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgGAKer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:34:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44909 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729180AbgGAKeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:34:46 -0400
Received: by mail-lj1-f196.google.com with SMTP id s9so26257721ljm.11;
        Wed, 01 Jul 2020 03:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xUvS9+zuogCU8+9R+PS9Mkaf3k7nIwYJuJ+OmdM0cWg=;
        b=rzI5BpmjjZFnY+Ech1aTg2A+LZGYTpGK3RsJw0drG+uk3tdxORlLs/otFrZ7Nllqcn
         4gy34/DmejzE5UQFAcByVYRSFhJRdtcGfTasZdqhHSUgFlVKt/yt+1tCyoD2VnuiLr3z
         fy+SpVkh2gi0iiA6NbDpiK08/kRFQNzsjzxyhs36GXoR+oTF2gIbUsUR1XfaGekS7Pah
         s/LiHNOlua09mvlmeI3FFslHi6Q5jF9vPA9eO84EdtOH8vdN4OSbnwkbGPG97lBTcYeG
         vybS7D5FEl3U9GDCwfVrMFZJEoSPtoE+cTdCXkTcvdjRGfo9gqT/1oWNqGr24bZFzTm0
         DBog==
X-Gm-Message-State: AOAM532HDzCWSovH7rsLq/xluHHdZXJixY/vTPNRtw8WvNkWBncOmN//
        x4yCDRUdRdWut9Zcr5lcjAo=
X-Google-Smtp-Source: ABdhPJzOpg14C5nnMgxjMYjTl1ffp8xIQ5/dtTDn9WodHD4G3eFmLvfC86dINj1xoMQtIyo9eT9nnQ==
X-Received: by 2002:a2e:9042:: with SMTP id n2mr12198548ljg.208.1593599680315;
        Wed, 01 Jul 2020 03:34:40 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id n25sm1007557lji.28.2020.07.01.03.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 03:34:39 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jqa4X-0006yH-TI; Wed, 01 Jul 2020 12:34:34 +0200
Date:   Wed, 1 Jul 2020 12:34:33 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        patong.mxl@gmail.com, linus.walleij@linaro.org,
        mchehab+huawei@kernel.org
Subject: Re: [RESEND PATCH v4 1/3] usb: serial: Add MaxLinear/Exar USB to
 Serial driver
Message-ID: <20200701103433.GC3334@localhost>
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

You've also copied code from that driver so you need to maintain its
copyright as well.

Probably better you link to lore than patchwork. Do that in the file
header as well.

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
> 
> diff --git a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
> index 25d7e0c36d38..8f6ad9f94735 100644
> --- a/drivers/usb/serial/Kconfig
> +++ b/drivers/usb/serial/Kconfig
> @@ -644,6 +644,15 @@ config USB_SERIAL_UPD78F0730
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called upd78f0730.
>  
> +config USB_SERIAL_XR
> +	tristate "USB MaxLinear/Exar USB to Serial driver"
> +	help
> +	  Say Y here if you want to use MaxLinear/Exar USB to Serial converter
> +	  devices.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called xr_serial.
> +
>  config USB_SERIAL_DEBUG
>  	tristate "USB Debugging Device"
>  	help
> diff --git a/drivers/usb/serial/Makefile b/drivers/usb/serial/Makefile
> index 2d491e434f11..4f69c2a3aff3 100644
> --- a/drivers/usb/serial/Makefile
> +++ b/drivers/usb/serial/Makefile
> @@ -62,4 +62,5 @@ obj-$(CONFIG_USB_SERIAL_VISOR)			+= visor.o
>  obj-$(CONFIG_USB_SERIAL_WISHBONE)		+= wishbone-serial.o
>  obj-$(CONFIG_USB_SERIAL_WHITEHEAT)		+= whiteheat.o
>  obj-$(CONFIG_USB_SERIAL_XIRCOM)			+= keyspan_pda.o
> +obj-$(CONFIG_USB_SERIAL_XR)			+= xr_serial.o
>  obj-$(CONFIG_USB_SERIAL_XSENS_MT)		+= xsens_mt.o
> diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
> new file mode 100644
> index 000000000000..bb7df79cc129
> --- /dev/null
> +++ b/drivers/usb/serial/xr_serial.c
> @@ -0,0 +1,650 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * MaxLinear/Exar USB to Serial driver
> + *
> + * Based on initial driver written by Patong Yang <patong.mxl@gmail.com>

Reproduce Patong Yang's copyright here as well.

> + *
> + * This driver claims both data and control interfaces but only registers tty
> + * device for data interface.

Not sure this is needed here; this is just the way CDC-ACM works.

> + *
> + * Copyright (c) 2020 Manivannan Sadhasivam <mani@kernel.org>

Not your employer?

> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/tty.h>
> +#include <linux/usb.h>
> +#include <linux/usb/serial.h>
> +
> +static void xr_set_termios(struct tty_struct *tty,
> +			   struct usb_serial_port *port,
> +			   struct ktermios *old_termios);

Move set_termios() before open() so that you don't need this.

> +
> +struct xr_uart_regs {
> +	u8 enable;
> +	u8 format;
> +	u8 flow_ctrl;
> +	u8 xon_char;
> +	u8 xoff_char;
> +	u8 loopback;
> +	u8 tx_break;
> +	u8 rs485_delay;
> +	u8 gpio_mode;
> +	u8 gpio_dir;
> +	u8 gpio_int_mask;
> +	u8 gpio_set;
> +	u8 gpio_clr;
> +	u8 gpio_status;
> +};
> +
> +struct xr_port_privte {
> +	const struct xr_uart_regs *regs;
> +	bool port_open;

No lock? As I pointed out before, you're gonna need one to coordinate
with gpiolib. Better not add the flag until you use it.

> +};
> +
> +struct xr_txrx_clk_mask {
> +	u16 tx;
> +	u16 rx0;
> +	u16 rx1;
> +};
> +
> +#define XR21V141X_ID			0x1410

Not used.

> +#define XR_INT_OSC_HZ			48000000U
> +#define XR21V141X_MIN_SPEED		46U
> +#define XR21V141X_MAX_SPEED		XR_INT_OSC_HZ
> +
> +/* USB Requests */
> +#define XR_SET_XR21V141X		0
> +#define XR_GET_XR21V141X		1

Stick to one style; either use a device-type specific prefix or suffix
for the defines.

> +
> +#define XR21V141X_CLOCK_DIVISOR_0	0x4
> +#define XR21V141X_CLOCK_DIVISOR_1	0x5
> +#define XR21V141X_CLOCK_DIVISOR_2	0x6
> +#define XR21V141X_TX_CLOCK_MASK_0	0x7
> +#define XR21V141X_TX_CLOCK_MASK_1	0x8
> +#define XR21V141X_RX_CLOCK_MASK_0	0x9
> +#define XR21V141X_RX_CLOCK_MASK_1	0xa

Please 0-pad these are they are registers.

> +
> +/* XR21V141X register blocks */
> +#define XR21V141X_UART_REG_BLOCK		0
> +#define XR21V141X_UART_MANAGER_REG_BLOCK	4
> +#define XR21V141X_UART_CUSTOM_BLOCK		0x66
> +
> +/* XR21V141X UART Manager Registers */
> +#define XR21V141X_UART_MANAGER_FIFO_ENABLE_REG	0x10
> +#define XR21V141X_UART_MANAGER_ENABLE_TX_FIFO	0x1
> +#define XR21V141X_UART_MANAGER_ENABLE_RX_FIFO	0x2
> +
> +#define XR21V141X_UART_MANAGER_RX_FIFO_RESET	0x18
> +#define XR21V141X_UART_MANAGER_TX_FIFO_RESET	0x1c

s/UART_MANAGER/UM/ should do fine for the register definitions (it was
just "URM" that was non-obvious).

> +
> +#define UART_ENABLE_TX			0x1
> +#define UART_ENABLE_RX			0x2
> +
> +#define UART_MODE_RI			BIT(0)
> +#define UART_MODE_CD			BIT(1)
> +#define UART_MODE_DSR			BIT(2)
> +#define UART_MODE_DTR			BIT(3)
> +#define UART_MODE_CTS			BIT(4)
> +#define UART_MODE_RTS			BIT(5)
> +
> +#define UART_BREAK_ON			0xff
> +#define UART_BREAK_OFF			0
> +
> +#define UART_DATA_MASK			GENMASK(3, 0)
> +#define UART_DATA_7			0x7
> +#define UART_DATA_8			0x8
> +
> +#define UART_PARITY_MASK		GENMASK(6, 4)
> +#define UART_PARITY_SHIFT		0x4
> +#define UART_PARITY_NONE		0x0
> +#define UART_PARITY_ODD			0x1
> +#define UART_PARITY_EVEN		0x2
> +#define UART_PARITY_MARK		0x3
> +#define UART_PARITY_SPACE		0x4
> +
> +#define UART_STOP_MASK			BIT(7)
> +#define UART_STOP_SHIFT			0x7
> +#define UART_STOP_1			0x0
> +#define UART_STOP_2			0x1
> +
> +#define UART_FLOW_MODE_NONE		0x0
> +#define UART_FLOW_MODE_HW		0x1
> +#define UART_FLOW_MODE_SW		0x2
> +
> +#define UART_MODE_GPIO_MASK		GENMASK(2, 0)
> +#define UART_MODE_RTS_CTS		0x1
> +#define UART_MODE_DTR_DSR		0x2
> +#define UART_MODE_RS485			0x3
> +#define UART_MODE_RS485_ADDR		0x4

Please slap a XR_ prefix (or replace UART_) to the above to avoid any
(future) collisions with the uapi defines.

For the these last defines the registers name is actually GPIO_MODE
which seems more correct that UART_MODE.

> +
> +static const struct xr_uart_regs xr21v141x_regs = {
> +	.enable = 0x03,
> +	.format = 0x0b,
> +	.flow_ctrl = 0x0c,
> +	.xon_char = 0x10,
> +	.xoff_char = 0x11,
> +	.loopback = 0x12,
> +	.tx_break = 0x14,
> +	.rs485_delay = 0x15,
> +	.gpio_mode = 0x1a,
> +	.gpio_dir = 0x1b,
> +	.gpio_int_mask = 0x1c,
> +	.gpio_set = 0x1d,
> +	.gpio_clr = 0x1e,
> +	.gpio_status = 0x1f,
> +};

Please drop this abstraction for now. If you or anyone ever adds support
for another device type, we can add the parts that are actually needed
then. Note that you already have code below which is XR21V141X specific.

> +
> +static int xr_set_reg(struct usb_serial_port *port, u8 block, u8 reg,
> +		      u8 val)
> +{
> +	struct usb_serial *serial = port->serial;
> +	int ret;
> +
> +	ret = usb_control_msg(serial->dev,
> +			      usb_sndctrlpipe(serial->dev, 0),
> +			      XR_SET_XR21V141X,
> +			      USB_DIR_OUT | USB_TYPE_VENDOR, val,
> +			      reg | (block << 8), NULL, 0,
> +			      USB_CTRL_SET_TIMEOUT);
> +	if (ret < 0) {
> +		dev_err(&port->dev, "Failed to set reg 0x%02x: %d\n", reg, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int xr_get_reg(struct usb_serial_port *port, u8 block, u8 reg,
> +		      u8 *val)
> +{
> +	struct usb_serial *serial = port->serial;
> +	u8 *dmabuf;
> +	int ret;
> +
> +	dmabuf = kmalloc(1, GFP_KERNEL);
> +	if (!dmabuf)
> +		return -ENOMEM;
> +
> +	ret = usb_control_msg(serial->dev,
> +			      usb_rcvctrlpipe(serial->dev, 0),
> +			      XR_GET_XR21V141X,
> +			      USB_DIR_IN | USB_TYPE_VENDOR, 0,
> +			      reg | (block << 8), dmabuf, 1,
> +			      USB_CTRL_GET_TIMEOUT);
> +	if (ret == 1) {
> +		*val = *dmabuf;
> +		ret = 0;
> +	} else {
> +		dev_err(&port->dev, "Failed to get reg 0x%02x: %d\n", reg, ret);
> +		if (ret >= 0)
> +			ret = -EIO;
> +	}
> +
> +	kfree(dmabuf);
> +
> +	return ret;
> +}

How about adding two xr_[sg]et_uart_reg() wrappers so you don't have to
specify the uart-block number for every register access? Should improve
readability.

Unless you want to follow the original driver with and _ext() version
taking a block number instead.

> +
> +/* Tx and Rx clock mask values obtained from section 3.3.4 of datasheet */
> +static const struct xr_txrx_clk_mask xr21v141x_txrx_clk_masks[] = {
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
> +	{ 0x94a, 0x4a4, 0xa52 },
> +	{ 0x52a, 0xaa4, 0x54a },
> +	{ 0xaaa, 0x954, 0x4aa },
> +	{ 0xaaa, 0x554, 0xaaa },
> +	{ 0x555, 0xad4, 0x5aa },
> +	{ 0xb55, 0xab4, 0x55a },
> +	{ 0x6b5, 0x5ac, 0xb56 },
> +	{ 0x5b5, 0xd6c, 0x6d6 },
> +	{ 0xb6d, 0xb6a, 0xdb6 },
> +	{ 0x76d, 0x6da, 0xbb6 },
> +	{ 0xedd, 0xdda, 0x76e },
> +	{ 0xddd, 0xbba, 0xeee },
> +	{ 0x7bb, 0xf7a, 0xdde },
> +	{ 0xf7b, 0xef6, 0x7de },
> +	{ 0xdf7, 0xbf6, 0xf7e },
> +	{ 0x7f7, 0xfee, 0xefe },
> +	{ 0xfdf, 0xfbe, 0x7fe },
> +	{ 0xf7f, 0xefe, 0xffe },
> +	{ 0xfff, 0xffe, 0xffd },
> +};
> +
> +static int xr_set_baudrate(struct tty_struct *tty,
> +			   struct usb_serial_port *port)
> +{
> +	u32 divisor, baud, idx;
> +	u16 tx_mask, rx_mask;
> +	int ret;
> +
> +	baud = clamp(tty->termios.c_ospeed, XR21V141X_MIN_SPEED,
> +		     XR21V141X_MAX_SPEED);

You still need to handle B0, which is a valid request and means that
DTR/RTS should be deasserted.

> +	divisor = XR_INT_OSC_HZ / baud;
> +	idx = (32 * divisor) & 0x1f;

This looks broken as you're throwing away the remainder (cf. datasheet
3.3.3 and original implementation).

> +	tx_mask = xr21v141x_txrx_clk_masks[idx].tx;
> +
> +	if (divisor & 1)
> +		rx_mask = xr21v141x_txrx_clk_masks[idx].rx1;
> +	else
> +		rx_mask = xr21v141x_txrx_clk_masks[idx].rx0;
> +
> +	dev_dbg(&port->dev, "Setting baud rate: %u\n", baud);
> +	/*
> +	 * XR21V141X uses fractional baud rate generator with 48MHz internal
> +	 * oscillator and 19-bit programmable divisor. So theoretically it can
> +	 * generate most commonly used baud rates with high accuracy.
> +	 */
> +	ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
> +			 XR21V141X_CLOCK_DIVISOR_0, (divisor & 0xff));
> +	if (ret)
> +		return ret;
> +
> +	ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
> +			 XR21V141X_CLOCK_DIVISOR_1, ((divisor >>  8) & 0xff));
> +	if (ret)
> +		return ret;
> +
> +	ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
> +			 XR21V141X_CLOCK_DIVISOR_2, ((divisor >> 16) & 0xff));
> +	if (ret)
> +		return ret;
> +
> +	ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
> +			 XR21V141X_TX_CLOCK_MASK_0, (tx_mask & 0xff));
> +	if (ret)
> +		return ret;
> +
> +	ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
> +			 XR21V141X_TX_CLOCK_MASK_1, ((tx_mask >>  8) & 0xff));
> +	if (ret)
> +		return ret;
> +
> +	ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
> +			 XR21V141X_RX_CLOCK_MASK_0, (rx_mask & 0xff));
> +	if (ret)
> +		return ret;
> +
> +	ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
> +			 XR21V141X_RX_CLOCK_MASK_1, ((rx_mask >>  8) & 0xff));
> +
> +	tty_encode_baud_rate(tty, baud, baud);
> +
> +	return ret;
> +}
> +
> +/*
> + * According to datasheet, below is the recommended sequence for enabling UART
> + * module in XR21V141X:
> + *
> + * Enable Tx FIFO
> + * Enable Tx and Rx
> + * Enable Rx FIFO
> + */
> +static int xr_uart_enable(struct usb_serial_port *port)
> +{
> +	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
> +	int ret;
> +
> +	ret = xr_set_reg(port, XR21V141X_UART_MANAGER_REG_BLOCK,
> +			 XR21V141X_UART_MANAGER_FIFO_ENABLE_REG,
> +			 XR21V141X_UART_MANAGER_ENABLE_TX_FIFO);
> +	if (ret)
> +		return ret;
> +
> +	ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
> +			 port_priv->regs->enable,
> +			 UART_ENABLE_TX | UART_ENABLE_RX);
> +	if (ret)
> +		return ret;
> +
> +	ret = xr_set_reg(port, XR21V141X_UART_MANAGER_REG_BLOCK,
> +			 XR21V141X_UART_MANAGER_FIFO_ENABLE_REG,
> +			 XR21V141X_UART_MANAGER_ENABLE_TX_FIFO |
> +			 XR21V141X_UART_MANAGER_ENABLE_RX_FIFO);
> +
> +	return ret;
> +}

Please disable on errors.

> +
> +static int xr_uart_disable(struct usb_serial_port *port)
> +{
> +	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
> +	int ret;
> +
> +	ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
> +			 port_priv->regs->enable, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = xr_set_reg(port, XR21V141X_UART_MANAGER_REG_BLOCK,
> +			 XR21V141X_UART_MANAGER_FIFO_ENABLE_REG, 0);
> +
> +	return ret;
> +}
> +
> +static int xr_open(struct tty_struct *tty, struct usb_serial_port *port)
> +{
> +	int ret;
> +	struct device *dev = &port->dev;
> +	struct xr_port_private *port_priv = usb_get_serial_port_data(port);

Please reverse these (longest first, reverse xmas) as in the rest of the
driver.

> +
> +	ret = xr_uart_enable(port);
> +	if (ret) {
> +		dev_err(&port->dev, "Failed to enable UART\n");
> +		return ret;
> +	}
> +
> +	/* Setup termios */
> +	if (tty)
> +		xr_set_termios(tty, port, NULL);
> +
> +	ret = usb_serial_generic_open(tty, port);
> +	if (ret) {
> +		dev_err(dev, "usb_serial_generic_open failed: %d\n", ret);

No need to log again.

> +		xr_uart_disable(port);
> +		return ret;
> +	}
> +
> +	port_priv->port_open = true;
> +
> +	return ret;

return 0 for clarity.

> +}
> +
> +static void xr_close(struct usb_serial_port *port)
> +{
> +	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
> +
> +	usb_serial_generic_close(port);
> +	port_priv->port_open = false;
> +	xr_uart_disable(port);
> +}
> +
> +static void xr_set_flow_mode(struct tty_struct *tty,
> +			     struct usb_serial_port *port)
> +{
> +	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
> +	unsigned int cflag = tty->termios.c_cflag;
> +	int ret;
> +	u8 flow, gpio_mode;
> +
> +	ret = xr_get_reg(port, XR21V141X_UART_REG_BLOCK,
> +			 port_priv->regs->gpio_mode, &gpio_mode);
> +	if (ret)
> +		return;
> +
> +	/*
> +	 * RTS/CTS is the default flow control mode, so set GPIO mode
> +	 * for controlling the pins manually by default.
> +	 */
> +	gpio_mode &= ~UART_MODE_GPIO_MASK;
> +	if (cflag & CRTSCTS) {
> +		dev_dbg(&port->dev, "Enabling hardware flow ctrl\n");
> +		flow = UART_FLOW_MODE_HW;
> +		gpio_mode |= UART_MODE_RTS_CTS;
> +	} else if (I_IXOFF(tty)) {

This should really be I_IXON() (flow control on output), sorry about
the confusion.

> +		u8 start_char = START_CHAR(tty);
> +		u8 stop_char = STOP_CHAR(tty);
> +
> +		dev_dbg(&port->dev, "Enabling sw flow ctrl\n");
> +		flow = UART_FLOW_MODE_SW;
> +
> +		xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
> +			   port_priv->regs->xon_char, start_char);
> +		xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
> +			   port_priv->regs->xoff_char, stop_char);
> +	} else {
> +		dev_dbg(&port->dev, "No flow ctrl\n");

s/No/Disabling/

> +		flow = UART_FLOW_MODE_NONE;
> +	}
> +
> +	/*
> +	 * As per the datasheet, UART needs to be disabled while writing to
> +	 * FLOW_CONTROL register.
> +	 */
> +	xr_uart_disable(port);
> +	xr_set_reg(port, XR21V141X_UART_REG_BLOCK, port_priv->regs->flow_ctrl,
> +		   flow);
> +	xr_uart_enable(port);
> +
> +	xr_set_reg(port, XR21V141X_UART_REG_BLOCK, port_priv->regs->gpio_mode,
> +		   gpio_mode);
> +}
> +
> +static void xr_set_termios(struct tty_struct *tty,
> +			   struct usb_serial_port *port,
> +			   struct ktermios *old_termios)
> +{
> +	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
> +	struct ktermios *termios = &tty->termios;
> +	int ret;
> +	u8 bits = 0;
> +
> +	if (old_termios &&
> +	    tty->termios.c_ospeed != old_termios->c_ospeed)
> +		xr_set_baudrate(tty, port);

You want to set the baudrate also when no old_termios.

> +
> +	switch (C_CSIZE(tty)) {
> +	case CS5:
> +	/* fall through */

Odd indentation; use "fallthrough;".

> +	case CS6:
> +		dev_warn(&port->dev, "requested CSIZE setting not supported\n");

No need to warn.

> +
> +		/* CS5 and CS6 are not supported, so just restore old setting */
> +		termios->c_cflag &= ~CSIZE;
> +		if (old_termios)
> +			termios->c_cflag |= old_termios->c_cflag & CSIZE;

You need to update bits as well, and set CS8 if no old_termios.

> +		break;
> +	case CS7:
> +		bits |= UART_DATA_7;
> +		break;
> +	case CS8:
> +	/* fall through */

As above.

> +	default:
> +		bits |= UART_DATA_8;
> +		break;
> +	}
> +
> +	if (C_PARENB(tty)) {
> +		if (C_CMSPAR(tty)) {
> +			if (C_PARODD(tty)) {
> +				bits |= (UART_PARITY_MARK <<
> +					 UART_PARITY_SHIFT);
> +			} else {
> +				bits |= (UART_PARITY_SPACE <<
> +					 UART_PARITY_SHIFT);
> +			}
> +		} else {
> +			if (C_PARODD(tty)) {
> +				bits |= (UART_PARITY_ODD <<
> +					 UART_PARITY_SHIFT);
> +			} else {
> +				bits |= (UART_PARITY_EVEN <<
> +					 UART_PARITY_SHIFT);

Just drop the parentheses and line break here and above. And then drop
the (inner) brackets.

> +			}
> +		}
> +	}
> +
> +	if (C_CSTOPB(tty))
> +		bits |= (UART_STOP_2 << UART_STOP_SHIFT);
> +	else
> +		bits |= (UART_STOP_1 << UART_STOP_SHIFT);

Parentheses not needed.

> +
> +	ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
> +			 port_priv->regs->format, bits);
> +	if (ret)
> +		return;
> +
> +	xr_set_flow_mode(tty, port);
> +}
> +
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
> +
> +static int xr_attach(struct usb_serial *serial)
> +{
> +	/* Do not register tty device for the control interface */
> +	if (serial->interface->cur_altsetting->desc.bInterfaceNumber == 0)
> +		return 1;

Ok, so you went for my first suggestion here instead of explicitly
claiming the sibling interface.

I still think you should bind to the data interface and then explicitly
claim the control interface instead, since that better reflects that
these interfaces are used together (and allows for unbinding through
sysfs etc).

> +
> +	return 0;
> +}
> +
> +static void xr_dtr_rts(struct usb_serial_port *port, int on)
> +{
> +	if (on)
> +		xr_tiocmset_port(port, TIOCM_DTR | TIOCM_RTS, 0);
> +	else
> +		xr_tiocmset_port(port, 0, TIOCM_DTR | TIOCM_RTS);
> +}
> +
> +static int xr_tiocmget(struct tty_struct *tty)
> +{
> +	struct usb_serial_port *port = tty->driver_data;
> +	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
> +	int ret;
> +	u8 status;
> +
> +	ret = xr_get_reg(port, XR21V141X_UART_REG_BLOCK,
> +			 port_priv->regs->gpio_status, &status);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Modem control pins are active low, so reading '0' means it is active
> +	 * and '1' means not active.
> +	 */
> +	ret = ((status & UART_MODE_DTR) ? 0 : TIOCM_DTR) |
> +	      ((status & UART_MODE_RTS) ? 0 : TIOCM_RTS) |
> +	      ((status & UART_MODE_CTS) ? 0 : TIOCM_CTS) |
> +	      ((status & UART_MODE_DSR) ? 0 : TIOCM_DSR) |
> +	      ((status & UART_MODE_RI) ? 0 : TIOCM_RI) |
> +	      ((status & UART_MODE_CD) ? 0 : TIOCM_CD);
> +
> +	return ret;
> +}
> +
> +static void xr_break_ctl(struct tty_struct *tty, int break_state)
> +{
> +	struct usb_serial_port *port = tty->driver_data;
> +	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
> +	u8 state;
> +
> +	if (break_state == 0)
> +		state = UART_BREAK_OFF;
> +	else
> +		state = UART_BREAK_ON;
> +
> +	dev_dbg(&port->dev, "Turning break %s\n",
> +		state == UART_BREAK_OFF ? "off" : "on");
> +	xr_set_reg(port, XR21V141X_UART_REG_BLOCK, port_priv->regs->tx_break,
> +		   state);
> +}
> +
> +static int xr_port_probe(struct usb_serial_port *port)
> +{
> +	struct xr_port_private *port_priv;
> +
> +	port_priv = kzalloc(sizeof(*port_priv), GFP_KERNEL);
> +	if (!port_priv)
> +		return -ENOMEM;
> +
> +	/* XR21V141X specific settings */
> +	port_priv->regs = &xr21v141x_regs;
> +
> +	usb_set_serial_port_data(port, port_priv);
> +
> +	return 0;
> +}
> +
> +static int xr_port_remove(struct usb_serial_port *port)
> +{
> +	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
> +
> +	kfree(port_priv);
> +
> +	return 0;
> +}
> +
> +static const struct usb_device_id id_table[] = {
> +	{ USB_DEVICE(0x04e2, 0x1410) }, /* XR21V141X */
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(usb, id_table);
> +
> +static struct usb_serial_driver xr_device = {
> +	.driver = {
> +		.owner = THIS_MODULE,
> +		.name =	"xr_serial",
> +	},
> +	.id_table		= id_table,
> +	.num_ports		= 1,
> +	.open			= xr_open,
> +	.close			= xr_close,
> +	.break_ctl		= xr_break_ctl,
> +	.set_termios		= xr_set_termios,
> +	.tiocmget		= xr_tiocmget,
> +	.tiocmset		= xr_tiocmset,
> +	.attach			= xr_attach,
> +	.port_probe		= xr_port_probe,
> +	.port_remove		= xr_port_remove,
> +	.dtr_rts		= xr_dtr_rts
> +};
> +
> +static struct usb_serial_driver * const serial_drivers[] = {
> +	&xr_device, NULL
> +};
> +
> +module_usb_serial_driver(serial_drivers, id_table);
> +
> +MODULE_AUTHOR("Manivannan Sadhasivam <mani@kernel.org>");
> +MODULE_DESCRIPTION("MaxLinear/Exar USB to Serial driver");
> +MODULE_LICENSE("GPL");

Johan
