Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA39C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45E382076B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588144842;
	bh=MC7v/B/AUB+89bATTGb3hziKs1OjKTAH6JyUhQGNvPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sA73kT1SFw6ME7zTlqzOyFPOuTjMII4Kn08J7kUqBDDHCmnxT1O/ScPXKrXiM4hSE
	 DMivcRqEAWEGeQc/FprCI5MvuhbpWc86GN5bpjKHh4SnHEHsdI5iAqMfpsAXDEHARJ
	 M0nALRLe/vsXV18RbPQvCs5TqMLUOwTbwSfnjxMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgD2HUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:20:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgD2HUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 03:20:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 884C62076B;
        Wed, 29 Apr 2020 07:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588144839;
        bh=MC7v/B/AUB+89bATTGb3hziKs1OjKTAH6JyUhQGNvPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PkjuO7H3O+1g5LH2lMW2dsDVrHOO7kKFPejUHYQdMR/RVCWUu1Q5uR3jxTV41YQVA
         hr9CwS7A4WPgsZW+Zu3VU4EIdX1PRdNZ4fOufw2vFT2iTQEFzs7lr2PpwIUe4rm69/
         pk650QeRHER3wPv6jTm0tc/KPTTk6cp+YveQTt+I=
Date:   Wed, 29 Apr 2020 09:20:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     mani@kernel.org
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, patong.mxl@gmail.com
Subject: Re: [PATCH 1/2] usb: serial: Add MaxLinear/Exar USB to Serial driver
Message-ID: <20200429072036.GA2045202@kroah.com>
References: <20200428195651.6793-1-mani@kernel.org>
 <20200428195651.6793-2-mani@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428195651.6793-2-mani@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 01:26:50AM +0530, mani@kernel.org wrote:
> From: Manivannan Sadhasivam <mani@kernel.org>
> 
> Add support for MaxLinear/Exar USB to Serial converters. This driver
> only supports XR21V141X series but provision has been made to support
> other series in future.
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

Nice work!

Some comments below:

> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * MaxLinear/Exar USB to Serial driver
> + *
> + * Based on initial driver written by Patong Yang <patong.mxl@gmail.com>
> + *
> + * Copyright (c) 2020 Manivannan Sadhasivam <mani@kernel.org>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/tty.h>
> +#include <linux/usb.h>
> +#include <linux/usb/serial.h>
> +
> +#include "xr_serial.h"

No need for a .h file for a single .c file.

> +static int xr_get_reg(struct usb_serial_port *port, u8 block, u16 reg,
> +		      u16 *val)
> +{
> +	struct usb_serial *serial = port->serial;
> +	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
> +	void *dmabuf;
> +	int ret = -EINVAL;
> +
> +	dmabuf = kmalloc(sizeof(reg), GFP_KERNEL);

So that is 2 bytes?

> +	if (!dmabuf)
> +		return -ENOMEM;
> +
> +	if (port_priv->idProduct == XR21V141X_ID) {
> +		/* XR21V141X uses custom command for reading UART registers */
> +		ret = usb_control_msg(serial->dev,
> +				      usb_rcvctrlpipe(serial->dev, 0),
> +				      XR_GET_XR21V141X,
> +				      USB_DIR_IN | USB_TYPE_VENDOR, 0,
> +				      reg | (block << 8), dmabuf,
> +				      port_priv->reg_width,
> +				      USB_CTRL_SET_TIMEOUT);
> +	}
> +
> +	if (ret == port_priv->reg_width) {
> +		memcpy(val, dmabuf, port_priv->reg_width);

But here you copy ->reg_width bytes in?  How do you know val can hold
that much?  It's only set to be 1, so you copy 1 byte to a 16bit value?
What part of the 16bits did you just copy those 8 bits to (hint, think
cpu endian issues...)

That feels really really odd and a bit broken.

> --- /dev/null
> +++ b/drivers/usb/serial/xr_serial.h
> @@ -0,0 +1,103 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */

Are you sure about the "+"?  I have to ask :)

> +
> +#ifndef __LINUX_USB_SERIAL_XR_SERIAL_H
> +#define __LINUX_USB_SERIAL_XR_SERIAL_H

As you will drop this file, just a general statement, no need for
__LINUX as this is all Linux :)

thanks,

greg k-h
