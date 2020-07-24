Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75331C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AE802070E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595596206;
	bh=Wx/x32FDLvLCIX8u4/VoyGIFTyiOsSSslHTt4KzamiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K5+7Nf6Cg96XU40sOKpTM54dS4CtmrhVPDagfzJcmB3e/hIhvb3SbKi7jEcavIKaK
	 Q7PRn7aWItJyQ7oLKkSNSgJSc9E0VObEiQZx6cqV8R9AxvKkCl/z7RB+WqWDWPG0k6
	 V5ExXY/UQ7h5X73k17elxHFxidD4Z7YrBBJLBph4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgGXNKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbgGXNKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:10:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C7C62065F;
        Fri, 24 Jul 2020 13:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595596203;
        bh=Wx/x32FDLvLCIX8u4/VoyGIFTyiOsSSslHTt4KzamiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MsoSlgf3Gewt21Nu6RrZO26mtmp3JGYu2lV9SCCFYHrp6CEvk0whL3QebJrDjUIF6
         ZDmkQvLe1dwIjFjJv26KObN3hLPoNcXAkHEV18VPj3162lp6/bL+nBnzzO5AJT5Wz8
         eJvN2T3rDi4kaqOb+uyK1YSf/nrL4ESX04dVreoA=
Date:   Fri, 24 Jul 2020 15:10:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sheng Long Wang <china_shenglong@163.com>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, jan.kiszka@siemens.com,
        Wang Sheng Long <shenglong.wang.ext@siemens.com>
Subject: Re: [PATCH] usb-serial:cp210x: add CP210x support to software flow
 control
Message-ID: <20200724131004.GB314889@kroah.com>
References: <20200724102946.15404-1-china_shenglong@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724102946.15404-1-china_shenglong@163.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 06:29:46PM +0800, Sheng Long Wang wrote:
> From: Wang Sheng Long <shenglong.wang.ext@siemens.com>
> 
>   The cp210x driver lacks soft-flow function,so need and
>   this function.

Why is this indented?

And I do not quite understand this sentance, why is this needed?

> 
> Signed-off-by: Wang Sheng Long <shenglong.wang.ext@siemens.com>
> ---
>  drivers/usb/serial/cp210x.c | 110 +++++++++++++++++++++++++++++++++---
>  1 file changed, 103 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index e732949f65..ad5db0e2ae 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -380,6 +380,9 @@ static struct usb_serial_driver * const serial_drivers[] = {
>  #define CP210X_PARTNUM_CP2102N_QFN20	0x22
>  #define CP210X_PARTNUM_UNKNOWN	0xFF
>  
> +#define CP210X_VSTART  0x11
> +#define CP210X_VSTOP   0x13

No tabs?

> +
>  /* CP210X_GET_COMM_STATUS returns these 0x13 bytes */
>  struct cp210x_comm_status {
>  	__le32   ulErrors;
> @@ -391,6 +394,15 @@ struct cp210x_comm_status {
>  	u8       bReserved;
>  } __packed;
>  
> +struct cp210x_chars_respones{
> +	u8       bEofchar;
> +	u8       bErrochar;
> +	u8       bBreakchar;
> +	u8       bEventchar;
> +	u8       bXonchar;
> +	u8       bXoffchar;

Why the 'b' character here?

Is this coming from some public spec somewhere with these specific
fields?

> +} __packed;
> +
>  /*
>   * CP210X_PURGE - 16 bits passed in wValue of USB request.
>   * SiLabs app note AN571 gives a strange description of the 4 bits:
> @@ -624,6 +636,43 @@ static int cp210x_read_vendor_block(struct usb_serial *serial, u8 type, u16 val,
>  	return result;
>  }
>  
> +/*
> + * Read and Write Characrters Respones operate
> + * Register SET_CHARS/GET_CHATS
> + */
> +static int cp210x_operate_chars_block(struct usb_serial_port *port, u8 req, u8 type,
> +		void *buf, int bufsize)
> +{
> +	struct usb_serial *serial = port->serial;
> +	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
> +	void *dmabuf;
> +	int result;
> +
> +	dmabuf = kmemdup(buf, bufsize, GFP_KERNEL);
> +	if (!dmabuf)
> +		return -ENOMEM;
> +
> +	result = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
> +			req, type, 0, port_priv->bInterfaceNumber, dmabuf, bufsize,
> +			USB_CTRL_SET_TIMEOUT);
> +	if (result == bufsize) {
> +		if (type == REQTYPE_DEVICE_TO_HOST)
> +			memcpy(buf, dmabuf, bufsize);
> +
> +		result = 0;
> +	} else {
> +		dev_err(&port->dev, "failed get req 0x%x size %d status: %d\n",
> +				req, bufsize, result);
> +		if (result >= 0)
> +			result = -EIO;
> +
> +	}
> +
> +	kfree(dmabuf);
> +
> +	return result;
> +}
> +
>  /*
>   * Writes any 16-bit CP210X_ register (req) whose value is passed
>   * entirely in the wValue field of the USB request.
> @@ -650,8 +699,8 @@ static int cp210x_write_u16_reg(struct usb_serial_port *port, u8 req, u16 val)
>   * Writes a variable-sized block of CP210X_ registers, identified by req.
>   * Data in buf must be in native USB byte order.
>   */
> -static int cp210x_write_reg_block(struct usb_serial_port *port, u8 req,
> -		void *buf, int bufsize)
> +static int cp210x_write_reg_block(struct usb_serial_port *port,
> +				u8 req, void *buf, int bufsize)
>  {
>  	struct usb_serial *serial = port->serial;
>  	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
> @@ -1134,11 +1183,17 @@ static void cp210x_set_termios(struct tty_struct *tty,
>  		struct usb_serial_port *port, struct ktermios *old_termios)
>  {
>  	struct device *dev = &port->dev;
> -	unsigned int cflag, old_cflag;
> +	struct cp210x_chars_respones CharsRes;
> +	struct cp210x_flow_ctl flow_ctl;
> +	unsigned int cflag, old_cflag, iflag;
>  	u16 bits;
> +	int result;
> +	u32 ctl_hs;
> +	u32 flow_repl;
>  
>  	cflag = tty->termios.c_cflag;
>  	old_cflag = old_termios->c_cflag;
> +	iflag = tty->termios.c_iflag;
>  
>  	if (tty->termios.c_ospeed != old_termios->c_ospeed)
>  		cp210x_change_speed(tty, port, old_termios);
> @@ -1212,10 +1267,6 @@ static void cp210x_set_termios(struct tty_struct *tty,
>  	}
>  
>  	if ((cflag & CRTSCTS) != (old_cflag & CRTSCTS)) {
> -		struct cp210x_flow_ctl flow_ctl;
> -		u32 ctl_hs;
> -		u32 flow_repl;
> -
>  		cp210x_read_reg_block(port, CP210X_GET_FLOW, &flow_ctl,
>  				sizeof(flow_ctl));
>  		ctl_hs = le32_to_cpu(flow_ctl.ulControlHandshake);
> @@ -1252,6 +1303,51 @@ static void cp210x_set_termios(struct tty_struct *tty,
>  				sizeof(flow_ctl));
>  	}
>  
> +	/* Set Software  Flow  Control
> +	 * Xon/Xoff code
> +	 * Check the IXOFF/IXON status in the iflag component of the
> +	 * termios structure.
> +	 *
> +	 */
> +	if  ((iflag & IXOFF) || (iflag & IXON)) {
> +		/*set vstart/vstop chars */
> +		result = cp210x_operate_chars_block(port, CP210X_GET_CHARS,
> +					  REQTYPE_DEVICE_TO_HOST, &CharsRes, sizeof(CharsRes));
> +		dev_dbg(dev, "%s -  bXonchar=0x%x   bXoffchar=0x%x   \n",
> +				__func__, CharsRes.bXonchar, CharsRes.bXoffchar);

Are these dev_dbg() lines still needed now that the code is working?

And you never need a __func__ in a dev_* function, it can always display
that automatically if you need/want it.  But here it's pointless.

thanks,

greg k-h
