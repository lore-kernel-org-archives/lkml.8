Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D644AC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC252146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583918013;
	bh=EjP3o9Yi+hUnsxTk5SJfKSNSVhbGiQEcuon19wZ6Mfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mZP0Psquau3VHq4/g+ZTwOyx9b4Xly9vKMKe5eA7FnTfO63goXeX6wG8OKbQkY8Ip
	 5+iqCZPDnak+BBeDyh8XYDAYsVmGNC7bTDImktvs4ZunrlBZ/1PvVaIEFN7ZsbTXB2
	 g/KWHmnV7IBWYfWBWOhwLmUpuI1ENA8wRYnZrPL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgCKJNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:13:32 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37905 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgCKJNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:13:32 -0400
Received: by mail-lf1-f68.google.com with SMTP id x22so1035146lff.5;
        Wed, 11 Mar 2020 02:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qhIDi5z+ZT29B7/4ImamXTHxL5IkLJQZ2qWtWxOwngg=;
        b=feWAmBZU6jPMCLJTe4qIBRN5vfcIvDMveyJd6+gV0jN7vrMLNV0wui8EBMGQBPMegH
         2gruLAicQvWedRyGmq7oZDFR8HOhJAXO/jcGmJfaZ9+uuTau0H7cdMQvwmkwWWMceveH
         lUJf7zjRD/jm6d4AHqLUBoHqQc0zN37MSx8Qv5BqPNIyFydjbSQDb+3kLzU9Fw1pKwGc
         oopIc71BJUCX/Gg5e0De+eQoRTIo9NheuaR3fsPw60BxL2JGQfL1yA4tMbcMRJ/DRpjn
         zWXl1h3xauhzJXtORKc7SttCtlQz0hIK8kCpg+FozrSxXae83dLcjOB7vrbVvOWEApfa
         cIdw==
X-Gm-Message-State: ANhLgQ1gojTqkV/3oc39rq+eD/kZit270E5zDc9o9wDRrx0r8lFxUhy9
        WOheximDPR0XLqZidEqUDq6PBdpC
X-Google-Smtp-Source: ADFU+vs+ntekw8VoDZK1u9rzKMuU4M+2SABuMJltW7glq97SpzCU/kTbIOH0xSNS6z18yZMHJ7dctQ==
X-Received: by 2002:a19:cbd5:: with SMTP id b204mr1517318lfg.102.1583918009861;
        Wed, 11 Mar 2020 02:13:29 -0700 (PDT)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id i16sm619685lfl.29.2020.03.11.02.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 02:13:28 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1jBxQS-0004Qy-EU; Wed, 11 Mar 2020 10:13:16 +0100
Date:   Wed, 11 Mar 2020 10:13:16 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V4 1/1] USB: serial: f81232: Add generator for F81534A
Message-ID: <20200311091316.GG14211@localhost>
References: <20200304033751.8662-1-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304033751.8662-1-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 11:37:51AM +0800, Ji-Ze Hong (Peter Hong) wrote:
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
> v4:
> 	1. Remove unused define.
> 	2. Remove usb_translate_errors() in f81534a_ctrl_set_register()
> 	   with short transfer.
> 	3. Replace dev_warn() with dev_err() in f81534a_ctrl_enable_all_ports()
> 	4. Disable & remove all usb serial port device when disconnect().

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
> +			status = -EIO;

You shouldn't discard any error code you get here; only set it to -EIO
if the transfer is short.

Your previous patch didn't retry on -ENOMEM and -ENODEV (e.g. if the
device was disconnected) which seems reasonable.

What errors are you seeing here when you really do need to resend?
Perhaps only retry on those specifically (and short transfers)?

> +			continue;
> +		}
> +
> +		status = 0;
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
> +static int f81534a_ctrl_enable_all_ports(struct usb_interface *intf, bool en)
> +{
> +	struct usb_device *dev = interface_to_usbdev(intf);
> +	unsigned char enable[2] = {0};
> +	int status;
> +
> +	/*
> +	 * Enable all available serial ports, define as following:
> +	 * bit 15	: Reset behavior (when HUB got soft reset)
> +	 *			0: maintain all serial port enabled state.
> +	 *			1: disable all serial port.
> +	 * bit 0~11	: Serial port enable bit.
> +	 */
> +	if (en) {
> +		enable[0] = 0xff;
> +		enable[1] = 0x8f;
> +	}
> +
> +	status = f81534a_ctrl_set_register(dev, F81534A_CTRL_CMD_ENABLE_PORT,
> +			sizeof(enable), enable);
> +	if (status)
> +		dev_err(&dev->dev, "failed to enable ports: %d\n", status);

Please use &intf->dev here and for the dev_err() in
f81534a_ctrl_set_register() as that will include the driver name in the
prefix.

> +
> +	return status;
> +}

Johan
