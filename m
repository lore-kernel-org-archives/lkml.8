Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2163DC35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E138D2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582629793;
	bh=+f4g/T5IKHErTo9a5ryQSpBDCVodA46xILALMOqQ49A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uiA0ljYUm3AtknwqLf/KJBnwgOWJF+xCV71l/M4Y8Zf1y21G5nNgbqvCyiEhMsGL0
	 jq1g4JtKAivli3BeujciLbm/rSf57ba7uRMHVVRLIbrn7HBiV6U97lubFlh1e0Djfd
	 i8sk7mOZXq3EedbOFdDVuxNZgBykfo+qkgIvjnTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgBYLXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 06:23:11 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33947 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbgBYLXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 06:23:11 -0500
Received: by mail-lj1-f193.google.com with SMTP id x7so13615153ljc.1;
        Tue, 25 Feb 2020 03:23:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BBybHQbZxunfP261Xh0zU9VVzFO+eUdpOCtCputXHMk=;
        b=WjpcRN4lU9dsw7y/Sf1PPRyH0UFfO15q2RxGYid0gqIUMl1dcTDu3mtv3MspDcleoy
         GCA/oBNXwQl2QoKNGYNr02rKoyd9A+7NpPkfbE+msSslSkgsp9dPVqHk9n0jtv3ZekPo
         zFyhnSDhrcPmI2hq+yZT2vNBk1UBlsEqwyaSk4imeLw1bK1JMB+KfNnaG/7pYayGRvvc
         4MjcJ4EL0Z3J5dwMHjtTUo0utzVUvJimIAbYPzGRUBxzg8KkshoMnIJ0D4DMlJpmoODU
         wZbi/G0GLMwiL3Oioj5mUc4pFt818yjIs9DbHyFeUEmhNLO36T4fSlMMFv87YftX5424
         IV5w==
X-Gm-Message-State: APjAAAUJNbmHV6vzeGOJTVfh4DVom9ml6SpTytBt/4wT3VoOCn0YLJLA
        Kv+V6EQJHahorVERu8DHUhzW6fnT
X-Google-Smtp-Source: APXvYqyCktwAiQCLpGoeKFr/M+coL3wm1hjmymYWZk83lNREr5QjpgAlM6QzGLRl35/qWdH+wpWPSQ==
X-Received: by 2002:a05:651c:40c:: with SMTP id 12mr33533154lja.147.1582629788499;
        Tue, 25 Feb 2020 03:23:08 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id d26sm3055827lfn.22.2020.02.25.03.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 03:23:07 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1j6YIp-0004dU-Uy; Tue, 25 Feb 2020 12:23:04 +0100
Date:   Tue, 25 Feb 2020 12:23:03 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V3 6/6] USB: serial: f81232: Add generator for F81534A
Message-ID: <20200225112303.GT32540@localhost>
References: <20200130054752.9368-1-hpeter+linux_kernel@gmail.com>
 <20200130054752.9368-7-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130054752.9368-7-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 01:47:52PM +0800, Ji-Ze Hong (Peter Hong) wrote:
> The Fintek F81534A series is contains 1 HUB / 1 GPIO device / n UARTs,
> but the UART is default disable and need enabled by GPIO device(2c42/16F8).
> 
> When F81534A plug to host, we can only see 1 HUB & 1 GPIO device and we
> write 0x8fff to GPIO device register F81534A_CTRL_CMD_ENABLE_PORT(116h)
> to enable all available serial ports.
> 
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
> Changelog:
> v3:
> 	1. Modify some define with prefix F81534A_CTRL_.
> 	2. Use kmemdup() in f81534a_ctrl_set_register().
> 	3. Not accpet with short transfers in f81534a_ctrl_set_register().
> 	4. Add comment in f81534a_ctrl_enable_all_ports() to describe magic
> 	   constants.
> 	5. Remove non-need usb_get_dev()/usb_put_dev().
> 	6. Add F81534A_CTRL_ID in MODULE_DEVICE_TABLE().
> 
> v2:
> 	1: Simplify the generator behavior.
> 	2: Change multiply MODULE_DEVICE_TABLE() to 1 only.
> 
>  drivers/usb/serial/f81232.c | 134 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 133 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
> index 21410a7f3a8b..0303f94b2521 100644
> --- a/drivers/usb/serial/f81232.c
> +++ b/drivers/usb/serial/f81232.c
> @@ -36,6 +36,9 @@
>  	{ USB_DEVICE(0x2c42, 0x1635) },	/* 8 port UART device */ \
>  	{ USB_DEVICE(0x2c42, 0x1636) }	/* 12 port UART device */
>  
> +#define F81534A_CTRL_ID		\
> +	{ USB_DEVICE(0x2c42, 0x16f8) }	/* Global control device */
> +
>  static const struct usb_device_id f81232_id_table[] = {
>  	F81232_ID,
>  	{ }					/* Terminating entry */
> @@ -46,9 +49,15 @@ static const struct usb_device_id f81534a_id_table[] = {
>  	{ }					/* Terminating entry */
>  };
>  
> +static const struct usb_device_id f81534a_ctrl_id_table[] = {
> +	F81534A_CTRL_ID,
> +	{ }					/* Terminating entry */
> +};
> +
>  static const struct usb_device_id combined_id_table[] = {
>  	F81232_ID,
>  	F81534A_SERIES_ID,
> +	F81534A_CTRL_ID,
>  	{ }					/* Terminating entry */
>  };
>  MODULE_DEVICE_TABLE(usb, combined_id_table);
> @@ -61,6 +70,7 @@ MODULE_DEVICE_TABLE(usb, combined_id_table);
>  #define F81232_REGISTER_REQUEST		0xa0
>  #define F81232_GET_REGISTER		0xc0
>  #define F81232_SET_REGISTER		0x40
> +#define F81534A_ACCESS_REG_RETRY	2
>  
>  #define SERIAL_BASE_ADDRESS		0x0120
>  #define RECEIVE_BUFFER_REGISTER		(0x00 + SERIAL_BASE_ADDRESS)
> @@ -92,6 +102,8 @@ MODULE_DEVICE_TABLE(usb, combined_id_table);
>  #define F81534A_TRIGGER_MULTIPLE_4X	BIT(3)
>  #define F81534A_FIFO_128BYTE		(BIT(1) | BIT(0))
>  
> +#define F81534A_MAX_PORT		12
> +

This define isn't used anymore.

>  /* Serial port self GPIO control, 2bytes [control&output data][input data] */
>  #define F81534A_GPIO_REG		0x10e
>  #define F81534A_GPIO_MODE2_DIR		BIT(6) /* 1: input, 0: output */
> @@ -101,6 +113,9 @@ MODULE_DEVICE_TABLE(usb, combined_id_table);
>  #define F81534A_GPIO_MODE1_OUTPUT	BIT(1)
>  #define F81534A_GPIO_MODE0_OUTPUT	BIT(0)
>  
> +#define F81534A_CTRL_CMD_ENABLE_PORT	0x116
> +
> +
>  struct f81232_private {
>  	struct mutex lock;
>  	u8 modem_control;
> @@ -848,6 +863,89 @@ static void f81232_lsr_worker(struct work_struct *work)
>  		dev_warn(&port->dev, "read LSR failed: %d\n", status);
>  }
>  
> +static int f81534a_ctrl_set_register(struct usb_device *dev, u16 reg, u16 size,
> +					void *val)
> +{
> +	int retry = F81534A_ACCESS_REG_RETRY;
> +	int status;
> +	u8 *tmp;
> +
> +	tmp = kmemdup(val, size, GFP_KERNEL);
> +	if (!tmp)
> +		return -ENOMEM;
> +
> +	while (retry--) {
> +		status = usb_control_msg(dev,
> +					usb_sndctrlpipe(dev, 0),
> +					F81232_REGISTER_REQUEST,
> +					F81232_SET_REGISTER,
> +					reg,
> +					0,
> +					tmp,
> +					size,
> +					USB_CTRL_SET_TIMEOUT);
> +		if (status != size) {
> +			status = usb_translate_errors(status);

Please don't use usb_translate_errors() for non-errors (short
transfers). Handle it explicitly instead so that the intent is clear
here (e.g. to retry on short transfers).

> +			if (status == -EIO)
> +				continue;
> +
> +			status = -EIO;
> +		} else {
> +			status = 0;
> +		}
> +
> +		break;
> +	}
> +
> +	if (status) {
> +		dev_err(&dev->dev, "set ctrl reg: %x, failed status: %d\n",
> +				reg, status);
> +	}
> +
> +	kfree(tmp);
> +	return status;
> +}
> +
> +static int f81534a_ctrl_enable_all_ports(struct usb_interface *intf)
> +{
> +	struct usb_device *dev = interface_to_usbdev(intf);
> +	unsigned char enable[2];
> +	int status;
> +
> +	/*
> +	 * Enable all available serial ports, define as following:
> +	 * bit 15	: Reset behavior (when HUB got soft reset)
> +	 *			0: maintain all serial port enabled state.
> +	 *			1: disable all serial port.
> +	 * bit 0~11	: Serial port enable bit.
> +	 */
> +	enable[0] = 0xff;
> +	enable[1] = 0x8f;
> +
> +	status = f81534a_ctrl_set_register(dev, F81534A_CTRL_CMD_ENABLE_PORT,
> +			sizeof(enable), enable);
> +	if (status)
> +		dev_warn(&dev->dev, "set ENABLE_PORT failed: %d\n", status);

Use dev_err() here, and "failed to enable ports" is probably a better
wording.

> +
> +	return status;
> +}
> +
> +static int f81534a_ctrl_probe(struct usb_interface *intf,
> +				const struct usb_device_id *id)
> +{
> +
> +	return f81534a_ctrl_enable_all_ports(intf);
> +}
> +
> +static void f81534a_ctrl_disconnect(struct usb_interface *intf)
> +{
> +}

Shouldn't you disable the ports when unbinding the control driver?

I've applied all the patches in the series up until this one so no need
to resend those.

Johan
