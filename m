Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDBBC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 15:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5974E206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 15:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595778579;
	bh=O/+4UCmgfHn88SsgdbSl85GrsrHY9DypKyiITn6W7Is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=06ONrrpFYtSu+MenGxqpkaxBJZgxhW1iXqptA5NC2Ur+vBrJe9piAkqi+euW0BziJ
	 pAT18I0AUGJTmAI7xzgGB/fEOlVgkHc0y5L2Qj7d/O+kLfNr/nTlW6eEoHrcw9gpRg
	 P/oW7xdxo5k5goUDey7fE0SoEYqb65mtpAp/r3CE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgGZPth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 11:49:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgGZPth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 11:49:37 -0400
Received: from Mani-XPS-13-9360 (unknown [157.50.161.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1935C206D7;
        Sun, 26 Jul 2020 15:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595778575;
        bh=O/+4UCmgfHn88SsgdbSl85GrsrHY9DypKyiITn6W7Is=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ylG8gYwG09HtbhUlIyTnEzBlRojFkPZJktP2FRqO4HF+ojBkhvuRk1T68SpIha5J9
         uedLxrTPaB90z4RLcviad14TLt7qYLObChKPQyF9/DI8jH41FcBJyhcFOrDjCH2qd4
         pdfI/KeE6I9yOXh1dfQWJp/OE08lYGRAfnklXwfA=
Date:   Sun, 26 Jul 2020 21:19:28 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, patong.mxl@gmail.com,
        linus.walleij@linaro.org, mchehab+huawei@kernel.org
Subject: Re: [RESEND PATCH v4 1/3] usb: serial: Add MaxLinear/Exar USB to
 Serial driver
Message-ID: <20200726154928.GA12036@Mani-XPS-13-9360>
References: <20200607162350.21297-1-mani@kernel.org>
 <20200607162350.21297-2-mani@kernel.org>
 <20200701103433.GC3334@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701103433.GC3334@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for the late reply!

On Wed, Jul 01, 2020 at 12:34:33PM +0200, Johan Hovold wrote:
> On Sun, Jun 07, 2020 at 09:53:48PM +0530, Manivannan Sadhasivam wrote:
> > Add support for MaxLinear/Exar USB to Serial converters. This driver
> > only supports XR21V141X series but it can be extended to other series
> > from Exar as well in future.
> > 
> > This driver is inspired from the initial one submitted by Patong Yang:
> > 
> > https://patchwork.kernel.org/patch/10543261/
> 
> You've also copied code from that driver so you need to maintain its
> copyright as well.
> 
> Probably better you link to lore than patchwork. Do that in the file
> header as well.
> 
> > While the initial driver was a custom tty USB driver exposing whole
> > new serial interface ttyXRUSBn, this version is completely based on USB
> > serial core thus exposing the interfaces as ttyUSBn. This will avoid
> > the overhead of exposing a new USB serial interface which the userspace
> > tools are unaware of.
> > 
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Tested-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> > ---
> >  drivers/usb/serial/Kconfig     |   9 +
> >  drivers/usb/serial/Makefile    |   1 +
> >  drivers/usb/serial/xr_serial.c | 650 +++++++++++++++++++++++++++++++++
> >  3 files changed, 660 insertions(+)
> >  create mode 100644 drivers/usb/serial/xr_serial.c
> > 
> > diff --git a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
> > index 25d7e0c36d38..8f6ad9f94735 100644
> > --- a/drivers/usb/serial/Kconfig
> > +++ b/drivers/usb/serial/Kconfig
> > @@ -644,6 +644,15 @@ config USB_SERIAL_UPD78F0730
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called upd78f0730.
> >  
> > +config USB_SERIAL_XR
> > +	tristate "USB MaxLinear/Exar USB to Serial driver"
> > +	help
> > +	  Say Y here if you want to use MaxLinear/Exar USB to Serial converter
> > +	  devices.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called xr_serial.
> > +
> >  config USB_SERIAL_DEBUG
> >  	tristate "USB Debugging Device"
> >  	help
> > diff --git a/drivers/usb/serial/Makefile b/drivers/usb/serial/Makefile
> > index 2d491e434f11..4f69c2a3aff3 100644
> > --- a/drivers/usb/serial/Makefile
> > +++ b/drivers/usb/serial/Makefile
> > @@ -62,4 +62,5 @@ obj-$(CONFIG_USB_SERIAL_VISOR)			+= visor.o
> >  obj-$(CONFIG_USB_SERIAL_WISHBONE)		+= wishbone-serial.o
> >  obj-$(CONFIG_USB_SERIAL_WHITEHEAT)		+= whiteheat.o
> >  obj-$(CONFIG_USB_SERIAL_XIRCOM)			+= keyspan_pda.o
> > +obj-$(CONFIG_USB_SERIAL_XR)			+= xr_serial.o
> >  obj-$(CONFIG_USB_SERIAL_XSENS_MT)		+= xsens_mt.o
> > diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
> > new file mode 100644
> > index 000000000000..bb7df79cc129
> > --- /dev/null
> > +++ b/drivers/usb/serial/xr_serial.c
> > @@ -0,0 +1,650 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * MaxLinear/Exar USB to Serial driver
> > + *
> > + * Based on initial driver written by Patong Yang <patong.mxl@gmail.com>
> 
> Reproduce Patong Yang's copyright here as well.
> 
> > + *
> > + * This driver claims both data and control interfaces but only registers tty
> > + * device for data interface.
> 
> Not sure this is needed here; this is just the way CDC-ACM works.
> 
> > + *
> > + * Copyright (c) 2020 Manivannan Sadhasivam <mani@kernel.org>
> 
> Not your employer?
> 
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/tty.h>
> > +#include <linux/usb.h>
> > +#include <linux/usb/serial.h>
> > +
> > +static void xr_set_termios(struct tty_struct *tty,
> > +			   struct usb_serial_port *port,
> > +			   struct ktermios *old_termios);
> 
> Move set_termios() before open() so that you don't need this.
> 
> > +
> > +struct xr_uart_regs {
> > +	u8 enable;
> > +	u8 format;
> > +	u8 flow_ctrl;
> > +	u8 xon_char;
> > +	u8 xoff_char;
> > +	u8 loopback;
> > +	u8 tx_break;
> > +	u8 rs485_delay;
> > +	u8 gpio_mode;
> > +	u8 gpio_dir;
> > +	u8 gpio_int_mask;
> > +	u8 gpio_set;
> > +	u8 gpio_clr;
> > +	u8 gpio_status;
> > +};
> > +
> > +struct xr_port_privte {
> > +	const struct xr_uart_regs *regs;
> > +	bool port_open;
> 
> No lock? As I pointed out before, you're gonna need one to coordinate
> with gpiolib. Better not add the flag until you use it.
> 
> > +};
> > +
> > +struct xr_txrx_clk_mask {
> > +	u16 tx;
> > +	u16 rx0;
> > +	u16 rx1;
> > +};
> > +
> > +#define XR21V141X_ID			0x1410
> 
> Not used.
> 
> > +#define XR_INT_OSC_HZ			48000000U
> > +#define XR21V141X_MIN_SPEED		46U
> > +#define XR21V141X_MAX_SPEED		XR_INT_OSC_HZ
> > +
> > +/* USB Requests */
> > +#define XR_SET_XR21V141X		0
> > +#define XR_GET_XR21V141X		1
> 
> Stick to one style; either use a device-type specific prefix or suffix
> for the defines.
> 
> > +
> > +#define XR21V141X_CLOCK_DIVISOR_0	0x4
> > +#define XR21V141X_CLOCK_DIVISOR_1	0x5
> > +#define XR21V141X_CLOCK_DIVISOR_2	0x6
> > +#define XR21V141X_TX_CLOCK_MASK_0	0x7
> > +#define XR21V141X_TX_CLOCK_MASK_1	0x8
> > +#define XR21V141X_RX_CLOCK_MASK_0	0x9
> > +#define XR21V141X_RX_CLOCK_MASK_1	0xa
> 
> Please 0-pad these are they are registers.

You mean adding 0 after 0x?

> 
> > +
> > +/* XR21V141X register blocks */
> > +#define XR21V141X_UART_REG_BLOCK		0
> > +#define XR21V141X_UART_MANAGER_REG_BLOCK	4
> > +#define XR21V141X_UART_CUSTOM_BLOCK		0x66
> > +
> > +/* XR21V141X UART Manager Registers */
> > +#define XR21V141X_UART_MANAGER_FIFO_ENABLE_REG	0x10
> > +#define XR21V141X_UART_MANAGER_ENABLE_TX_FIFO	0x1
> > +#define XR21V141X_UART_MANAGER_ENABLE_RX_FIFO	0x2
> > +
> > +#define XR21V141X_UART_MANAGER_RX_FIFO_RESET	0x18
> > +#define XR21V141X_UART_MANAGER_TX_FIFO_RESET	0x1c
> 
> s/UART_MANAGER/UM/ should do fine for the register definitions (it was
> just "URM" that was non-obvious).

[...]

> > +
> > +static int xr_set_baudrate(struct tty_struct *tty,
> > +			   struct usb_serial_port *port)
> > +{
> > +	u32 divisor, baud, idx;
> > +	u16 tx_mask, rx_mask;
> > +	int ret;
> > +
> > +	baud = clamp(tty->termios.c_ospeed, XR21V141X_MIN_SPEED,
> > +		     XR21V141X_MAX_SPEED);
> 
> You still need to handle B0, which is a valid request and means that
> DTR/RTS should be deasserted.
> 
> > +	divisor = XR_INT_OSC_HZ / baud;
> > +	idx = (32 * divisor) & 0x1f;
> 
> This looks broken as you're throwing away the remainder (cf. datasheet
> 3.3.3 and original implementation).
> 

Ah yes. Will fix it.

[...]

> > +
> > +static int xr_tiocmset_port(struct usb_serial_port *port,
> > +			    unsigned int set, unsigned int clear)
> > +{
> > +	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
> > +	int ret = 0;
> > +	u8 gpio_set = 0;
> > +	u8 gpio_clr = 0;
> > +
> > +	/* Modem control pins are active low, so set & clr are swapped */
> > +	if (set & TIOCM_RTS)
> > +		gpio_clr |= UART_MODE_RTS;
> > +	if (set & TIOCM_DTR)
> > +		gpio_clr |= UART_MODE_DTR;
> > +	if (clear & TIOCM_RTS)
> > +		gpio_set |= UART_MODE_RTS;
> > +	if (clear & TIOCM_DTR)
> > +		gpio_set |= UART_MODE_DTR;
> > +
> > +	/* Writing '0' to gpio_{set/clr} bits has no effect, so no need to do */
> > +	if (gpio_clr) {
> > +		ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
> > +				 port_priv->regs->gpio_clr, gpio_clr);
> > +	}
> > +
> > +	if (gpio_set) {
> > +		ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
> > +				 port_priv->regs->gpio_set, gpio_set);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int xr_tiocmset(struct tty_struct *tty,
> > +		       unsigned int set, unsigned int clear)
> > +{
> > +	struct usb_serial_port *port = tty->driver_data;
> > +
> > +	return xr_tiocmset_port(port, set, clear);
> > +}
> > +
> > +static int xr_attach(struct usb_serial *serial)
> > +{
> > +	/* Do not register tty device for the control interface */
> > +	if (serial->interface->cur_altsetting->desc.bInterfaceNumber == 0)
> > +		return 1;
> 
> Ok, so you went for my first suggestion here instead of explicitly
> claiming the sibling interface.
> 
> I still think you should bind to the data interface and then explicitly
> claim the control interface instead, since that better reflects that
> these interfaces are used together (and allows for unbinding through
> sysfs etc).
> 

How about something like below?

static int xr_probe(struct usb_serial *serial, const struct usb_device_id *id)
{
        struct usb_device *usb_dev = interface_to_usbdev(serial->interface);
        struct usb_driver *driver = serial->type->usb_driver;
        struct usb_interface *control_interface;

        /* Don't bind to control interface */
        if (serial->interface->cur_altsetting->desc.bInterfaceNumber == 0)
                return -ENODEV;

        /* But claim the control interface during data interface probe */
        control_interface = usb_ifnum_to_if(usb_dev, 0);
        if (usb_driver_claim_interface(driver, control_interface, NULL) != 0)
                dev_err(serial->interface->dev, "Can't claim control interface");

        return 0;
}

> > +
> > +	return 0;
> > +}
> > +
> > +static void xr_dtr_rts(struct usb_serial_port *port, int on)
> > +{
> > +	if (on)
> > +		xr_tiocmset_port(port, TIOCM_DTR | TIOCM_RTS, 0);
> > +	else
> > +		xr_tiocmset_port(port, 0, TIOCM_DTR | TIOCM_RTS);
> > +}
> > +
> > +static int xr_tiocmget(struct tty_struct *tty)
> > +{
> > +	struct usb_serial_port *port = tty->driver_data;
> > +	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
> > +	int ret;
> > +	u8 status;
> > +
> > +	ret = xr_get_reg(port, XR21V141X_UART_REG_BLOCK,
> > +			 port_priv->regs->gpio_status, &status);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * Modem control pins are active low, so reading '0' means it is active
> > +	 * and '1' means not active.
> > +	 */
> > +	ret = ((status & UART_MODE_DTR) ? 0 : TIOCM_DTR) |
> > +	      ((status & UART_MODE_RTS) ? 0 : TIOCM_RTS) |
> > +	      ((status & UART_MODE_CTS) ? 0 : TIOCM_CTS) |
> > +	      ((status & UART_MODE_DSR) ? 0 : TIOCM_DSR) |
> > +	      ((status & UART_MODE_RI) ? 0 : TIOCM_RI) |
> > +	      ((status & UART_MODE_CD) ? 0 : TIOCM_CD);
> > +
> > +	return ret;
> > +}
> > +
> > +static void xr_break_ctl(struct tty_struct *tty, int break_state)
> > +{
> > +	struct usb_serial_port *port = tty->driver_data;
> > +	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
> > +	u8 state;
> > +
> > +	if (break_state == 0)
> > +		state = UART_BREAK_OFF;
> > +	else
> > +		state = UART_BREAK_ON;
> > +
> > +	dev_dbg(&port->dev, "Turning break %s\n",
> > +		state == UART_BREAK_OFF ? "off" : "on");
> > +	xr_set_reg(port, XR21V141X_UART_REG_BLOCK, port_priv->regs->tx_break,
> > +		   state);
> > +}
> > +
> > +static int xr_port_probe(struct usb_serial_port *port)
> > +{
> > +	struct xr_port_private *port_priv;
> > +
> > +	port_priv = kzalloc(sizeof(*port_priv), GFP_KERNEL);
> > +	if (!port_priv)
> > +		return -ENOMEM;
> > +
> > +	/* XR21V141X specific settings */
> > +	port_priv->regs = &xr21v141x_regs;
> > +
> > +	usb_set_serial_port_data(port, port_priv);
> > +
> > +	return 0;
> > +}
> > +
> > +static int xr_port_remove(struct usb_serial_port *port)
> > +{
> > +	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
> > +
> > +	kfree(port_priv);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct usb_device_id id_table[] = {
> > +	{ USB_DEVICE(0x04e2, 0x1410) }, /* XR21V141X */
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(usb, id_table);
> > +
> > +static struct usb_serial_driver xr_device = {
> > +	.driver = {
> > +		.owner = THIS_MODULE,
> > +		.name =	"xr_serial",
> > +	},
> > +	.id_table		= id_table,
> > +	.num_ports		= 1,
> > +	.open			= xr_open,
> > +	.close			= xr_close,
> > +	.break_ctl		= xr_break_ctl,
> > +	.set_termios		= xr_set_termios,
> > +	.tiocmget		= xr_tiocmget,
> > +	.tiocmset		= xr_tiocmset,
> > +	.attach			= xr_attach,
> > +	.port_probe		= xr_port_probe,
> > +	.port_remove		= xr_port_remove,
> > +	.dtr_rts		= xr_dtr_rts
> > +};
> > +
> > +static struct usb_serial_driver * const serial_drivers[] = {
> > +	&xr_device, NULL
> > +};
> > +
> > +module_usb_serial_driver(serial_drivers, id_table);
> > +
> > +MODULE_AUTHOR("Manivannan Sadhasivam <mani@kernel.org>");
> > +MODULE_DESCRIPTION("MaxLinear/Exar USB to Serial driver");
> > +MODULE_LICENSE("GPL");
> 
> Johan
