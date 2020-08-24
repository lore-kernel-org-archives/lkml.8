Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C1AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB872071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598261914;
	bh=K+Apog5r/2QEiTrSvQcq/OAdtQOlc/HHUKIBPiUVl3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hlMfqopuBANacJ0x/etG3XIrs3YFAHb/0c8Cy5QnOUM+gjwCWw3R9eq/H/aS8/OKJ
	 TPMZrFQsT472EKYwOzxWD56FZ5ta7kP924Va1RONTfI/H41chNKQjiOc2f1ZKVSwHO
	 AqM/5xNGerfyT/OeGN6kMegwmKF/6OHDrSzOlGaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbgHXJi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:38:29 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34180 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgHXJiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 05:38:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id d2so4114115lfj.1;
        Mon, 24 Aug 2020 02:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zmf+3AprDgWzkWqt9Q2e2DPDEQNLbc0OI2pQ0EMmwrw=;
        b=E9dla9tI+B9GrYoFiU0L8uIhRlPKSt+HsnItl2UP/uQB0KifXaxNVFQ7Afn4m4s0/a
         cv+H0WmnxDsdLyeqNTaKbwn1/srtNiBgN1p2pBYNu8i1nr/VV8OqJDQi3gLynhWDjjei
         c7UdWzkxaNmDCbUjF20CjLd9/KwfFpdWKLKC3TEw4HwfpVjJelTtzdqBnnZeH0jxaF8C
         E+06M6G42Fl+zTjzZzzI1MOLbF0uqvu7KULupd5OLZ48cKh2/xHEZIIA/N0/JX7wHLus
         MdQi9SNZeLnHnSqWlxG1ly6iWQ+HoSGOArn+QMhtloafE9DXzLHH/SuxnXL44jwZFqzC
         ohKg==
X-Gm-Message-State: AOAM530noZE9Bvwr5unbC+ieRqmeF0sSNlkRIEyKPmnJa7QWuNs5CEkC
        xWwRW5jmLfFJRn9AKm8xkIs=
X-Google-Smtp-Source: ABdhPJzMgAOajqqTzTCavn7kmdtlD6gwb+faFvW9B+S4jc9VB9xHpONGixBKVUqWN1YmiF8OP6te8A==
X-Received: by 2002:ac2:4add:: with SMTP id m29mr2208915lfp.189.1598261898075;
        Mon, 24 Aug 2020 02:38:18 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id s21sm2087909ljs.8.2020.08.24.02.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 02:38:17 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kA8vg-00078V-DI; Mon, 24 Aug 2020 11:38:17 +0200
Date:   Mon, 24 Aug 2020 11:38:16 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Sheng Long Wang <china_shenglong@163.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jan.kiszka@siemens.com,
        Wang Sheng Long <shenglong.wang.ext@siemens.com>
Subject: Re: [PATCH v3] usb-serial:cp210x: add support to software flow
 control
Message-ID: <20200824093816.GD21288@localhost>
References: <20200820075240.13321-1-china_shenglong@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820075240.13321-1-china_shenglong@163.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 03:52:40PM +0800, Sheng Long Wang wrote:
> From: Wang Sheng Long <shenglong.wang.ext@siemens.com>
> 
> When data is transmitted between two serial ports,
> the phenomenon of data loss often occurs. The two kinds
> of flow control commonly used in serial communication
> are hardware flow control and software flow control.
> 
> In serial communication, If you only use RX/TX/GND Pins, you
> can't do hardware flow. So we often used software flow control
> and prevent data loss. The user sets the software flow control
> through the application program, and the application program
> sets the software flow control mode for the serial port
> chip through the driver.
> 
> For the cp210 serial port chip, its driver lacks the
> software flow control setting code, so the user cannot set
> the software flow control function through the application
> program. This adds the missing software flow control.
> 
> Signed-off-by: Wang Sheng Long <shenglong.wang.ext@siemens.com>
> 
> Changes in v3:
> -fixed code style, It mainly adjusts the code style acccording
>  to kernel specification.
> ---
>  drivers/usb/serial/cp210x.c | 118 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 113 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index e732949f65..c66a0e0fb9 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -380,6 +380,9 @@ static struct usb_serial_driver * const serial_drivers[] = {
>  #define CP210X_PARTNUM_CP2102N_QFN20	0x22
>  #define CP210X_PARTNUM_UNKNOWN	0xFF
>  
> +#define CP210X_VSTART	0x11
> +#define CP210X_VSTOP	0x13

These should come from the termios settings.

> +
>  /* CP210X_GET_COMM_STATUS returns these 0x13 bytes */
>  struct cp210x_comm_status {
>  	__le32   ulErrors;
> @@ -391,6 +394,15 @@ struct cp210x_comm_status {
>  	u8       bReserved;
>  } __packed;
>  
> +struct cp210x_chars_response {

Please rename cp210x_special_chars.

> +	u8	eofchar;
> +	u8	errochar;
> +	u8	breakchar;
> +	u8	eventchar;
> +	u8	xonchar;
> +	u8	xoffchar;

Please revert to using the field names from the spec for consistency.

> +} __packed;

No need for __packed.

> +
>  /*
>   * CP210X_PURGE - 16 bits passed in wValue of USB request.
>   * SiLabs app note AN571 gives a strange description of the 4 bits:
> @@ -624,6 +636,45 @@ static int cp210x_read_vendor_block(struct usb_serial *serial, u8 type, u16 val,
>  	return result;
>  }
>  
> +/*
> + * Read and Write Character Responses operate
> + * Register SET_CHARS/GET_CHATS

This comment makes very little sense to me. Please fix up (including
typos) or drop.

> + */
> +static int cp210x_operate_chars_block(struct usb_serial_port *port,
> +				u8 req, u8 type, void *buf, int bufsize)
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
> +	result = usb_control_msg(serial->dev,
> +				usb_rcvctrlpipe(serial->dev, 0),

This should be usb_sndctrlpipe() when updating the settings.

> +				req, type, 0, port_priv->bInterfaceNumber,
> +				dmabuf, bufsize, USB_CTRL_SET_TIMEOUT);
> +
> +	if (result == bufsize) {
> +		if (type == REQTYPE_DEVICE_TO_HOST)
> +			memcpy(buf, dmabuf, bufsize);
> +
> +		result = 0;
> +	} else {
> +		dev_err(&port->dev, "failed get req 0x%x size %d status: %d\n",
> +			req, bufsize, result);
> +		if (result >= 0)
> +			result = -EIO;
> +

Spurious newline.

> +	}
> +
> +	kfree(dmabuf);
> +
> +	return result;
> +}

Replace this with two dedicated helpers cp210x_get_chars() and
cp210x_set_chars().

> +
>  /*
>   * Writes any 16-bit CP210X_ register (req) whose value is passed
>   * entirely in the wValue field of the USB request.
> @@ -1134,11 +1185,17 @@ static void cp210x_set_termios(struct tty_struct *tty,
>  		struct usb_serial_port *port, struct ktermios *old_termios)
>  {
>  	struct device *dev = &port->dev;
> -	unsigned int cflag, old_cflag;
> +	struct cp210x_chars_response charsres;
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
> @@ -1212,10 +1269,6 @@ static void cp210x_set_termios(struct tty_struct *tty,
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
> @@ -1252,6 +1305,61 @@ static void cp210x_set_termios(struct tty_struct *tty,
>  				sizeof(flow_ctl));
>  	}
>  
> +	/*
> +	 * Set Software  Flow  Control
> +	 * Check the IXOFF/IXON status in the iflag component of the
> +	 * termios structure.
> +	 *
> +	 */

Drop this comment.

> +	if ((iflag & IXOFF) || (iflag & IXON)) {
> +
> +		result = cp210x_operate_chars_block(port,
> +						CP210X_GET_CHARS,
> +						REQTYPE_DEVICE_TO_HOST,
> +						&charsres,
> +						sizeof(charsres));
> +
> +		if (result < 0) {
> +			dev_err(dev, "Read Characrter Responses failed\n");

Please run your patch through a spell checker. And no need for Capital
letters everywhere.

> +			return;

You shouldn't just return here (more important with latest driver).

> +		}
> +		charsres.xonchar  = CP210X_VSTART;
> +		charsres.xoffchar = CP210X_VSTOP;

These should come from termios (see START_CHAR() and STOP_CHAR()).

> +		result = cp210x_operate_chars_block(port,
> +						CP210X_SET_CHARS,
> +						REQTYPE_HOST_TO_INTERFACE,
> +						&charsres,
> +						sizeof(charsres));
> +		if (result < 0) {
> +			memset(&charsres, 0, sizeof(charsres));

Not needed.

> +			dev_err(dev, "Write Characrter Responses failed\n");
> +			return;
> +		}
> +
> +		/*Set  Rx/Tx Flow Contrl  Flag in ulFlowReplace*/

Spaces after and before *. Random spaces mid sentence. Capitalisation...

And generally not useful, please drop it.

> +		cp210x_read_reg_block(port,
> +					CP210X_GET_FLOW,
> +					&flow_ctl,
> +					sizeof(flow_ctl));

Error handling.

> +
> +		flow_repl = le32_to_cpu(flow_ctl.ulFlowReplace);
> +
> +		if (iflag & IXOFF)
> +			flow_repl |= CP210X_SERIAL_AUTO_RECEIVE;
> +		else
> +			flow_repl &= ~CP210X_SERIAL_AUTO_RECEIVE;
> +
> +		if (iflag & IXON)
> +			flow_repl |= CP210X_SERIAL_AUTO_TRANSMIT;
> +		else
> +			flow_repl &= ~CP210X_SERIAL_AUTO_TRANSMIT;
> +
> +		flow_ctl.ulFlowReplace = cpu_to_le32(flow_repl);
> +		cp210x_write_reg_block(port,
> +					CP210X_SET_FLOW,
> +					&flow_ctl,
> +					sizeof(flow_ctl));

Error handling?

> +	}
>  }
>  
>  static int cp210x_tiocmset(struct tty_struct *tty,

Johan
