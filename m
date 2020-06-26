Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA690C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 966A220775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593157326;
	bh=JLErr3mk2ZC8rjZw+2EYDQ0NJcWymxgTIUuhqQkBrls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l8cvlJq7dFe+KARwnGy90UrHin9SOsRKEr9t3OjuoWEhgxe7YSoN5wd7SywbbaIRF
	 tdShY6WIkB8ZO8zkoHHtghh2mypN839GwTN9hwL8AmGwxy/0lvEpfVOXWa4OZzvvMW
	 i0vWFL/WBBN16i7rUOEa1tw9mSFnHIlM6I6faNcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgFZHmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:42:05 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36538 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgFZHmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 03:42:04 -0400
Received: by mail-lf1-f68.google.com with SMTP id c21so4623319lfb.3;
        Fri, 26 Jun 2020 00:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mz/Q5xHbOmwCEIDYAnNtu1WbEvpEmmozdU6zt7tewjs=;
        b=ansPmfnjjY1i73OVPV6EwXdBi3KQsHqUFi84Flid0QgrqegXAYPLplcG+SI9oaFHFI
         GwjZL4w+VMtE4dgKiIQu8Ei6WF//mjPGRLD0+cRbr1b3WsFVF0wD46jWhH6k1KMtlUDn
         qHR8Da3dxtyhrAlvGVfgz/WkbLQfTkfILddMYlkLiQ/07SGmM2wGDqhHRnp+R+OFaNDs
         k0SIzyHV/znoMyN8fQLZmbfWGt+V3p+DIJ2XpGrK9nMWQ/FsE/Q2R8/ZMFmYMEkYlkRI
         nMo1mdpRw/JlZEKiOMqxvWErjZmfQX5GHinfDLsILiEiw9ErWu7CjJtuLdtVWW2lo8Tt
         jYXQ==
X-Gm-Message-State: AOAM530I/mtRWvM2xfSqaZt+4l7LUOYIjnLzrKeG+xfu0NaHoYv5+3b8
        9Yn5NUQ9jfeb3NVJ91ge700=
X-Google-Smtp-Source: ABdhPJx/Mub6cbZBQRh5pmIf6JDa6VYSNKLrybxnpwjY7gIu4zfOWe0CddowQEbi5MIfNPpapsnt/Q==
X-Received: by 2002:a19:c744:: with SMTP id x65mr1133435lff.133.1593157322338;
        Fri, 26 Jun 2020 00:42:02 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id f24sm5312749ljk.125.2020.06.26.00.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 00:42:01 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1joizu-0005Fh-Rj; Fri, 26 Jun 2020 09:42:06 +0200
Date:   Fri, 26 Jun 2020 09:42:06 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Phu Luu <Phu.Luu@silabs.com>
Cc:     "johan@kernel.org" <johan@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brant Merryman <Brant.Merryman@silabs.com>,
        Richard Hendricks <Richard.Hendricks@silabs.com>,
        =?utf-8?B?UGjDuiBMxrB1?= An <luuanphu@gmail.com>,
        "hungnd3@fsoft.com.vn" <hungnd3@fsoft.com.vn>
Subject: Re: [PATCH v3 2/2] USB: serial: cp210x: Proper RTS control when
 buffers fill
Message-ID: <20200626074206.GP3334@localhost>
References: <ECCF8E73-91F3-4080-BE17-1714BC8818FB@silabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ECCF8E73-91F3-4080-BE17-1714BC8818FB@silabs.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 04:24:20AM +0000, Phu Luu wrote:
> From: Brant Merryman <brant.merryman@silabs.com>
> 
> CP210x hardware disables auto-RTS but leaves auto-CTS when
> in hardware flow control mode and UART on cp210x hardware
> is disabled. This allows data to flow out, but new data
> will not come into the port. When re-opening the port, if
> auto-CTS is enabled on the cp210x, then auto-RTS must be
> re-enabled in the driver.
> 
> Signed-off-by: Phu Luu <phu.luu@silabs.com>
> Signed-off-by: Brant Merryman <brant.merryman@silabs.com>

Please revisit these tags as well.

> ---
> 06/09/2020: Patch v3 2/2 Modified based on feedback from Johan Hovold <johan@kernel.org>
> 12/18/2019: Patch v2 Broken into two patches and modified based on feedback from Johan Hovold <johan@kernel.org>
> 12/09/2019: Initial submission of patch "Proper RTS control when buffers fill"
> 
>  drivers/usb/serial/cp210x.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index bcceb4ad8be0..091441b1c5b9 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -917,6 +917,7 @@ static void cp210x_get_termios_port(struct usb_serial_port *port,
>  	u32 baud;
>  	u16 bits;
>  	u32 ctl_hs;
> +	u32 flow_repl;
>  
>  	cp210x_read_u32_reg(port, CP210X_GET_BAUDRATE, &baud);
>  
> @@ -1017,6 +1018,23 @@ static void cp210x_get_termios_port(struct usb_serial_port *port,
>  	ctl_hs = le32_to_cpu(flow_ctl.ulControlHandshake);
>  	if (ctl_hs & CP210X_SERIAL_CTS_HANDSHAKE) {
>  		dev_dbg(dev, "%s - flow control = CRTSCTS\n", __func__);
> +		/*
> +		 * When the port is closed, the CP210x hardware disables
> +		 * auto-RTS and RTS is deasserted but it leaves auto-CTS when
> +		 * in hardware flow control mode. This prevents new data from
> +		 * being received by the port. When re-opening the port, if
> +		 * auto-CTS is enabled on the cp210x, then auto-RTS must be
> +		 * re-enabled in the driver.
> +		 */

I already asked this of Brant, but could you please be more specific
about which state the RTS-line end up in when disabling the UART (e.g.
0x00: statically inactive)?

The reason I ask is that after open() returns, the tty layer would raise
RTS, which should again allow data to flow in in contrast to what the
comment and changelog text claims.

We still want to enable auto-RTS of course so the patch is otherwise
correct.

> +		flow_repl = le32_to_cpu(flow_ctl.ulFlowReplace);
> +		flow_repl &= ~CP210X_SERIAL_RTS_MASK;
> +		flow_repl |= CP210X_SERIAL_RTS_SHIFT(CP210X_SERIAL_RTS_FLOW_CTL);
> +		flow_ctl.ulFlowReplace = cpu_to_le32(flow_repl);
> +		cp210x_write_reg_block(port,
> +				CP210X_SET_FLOW,
> +				&flow_ctl,
> +				sizeof(flow_ctl));
> +
>  		cflag |= CRTSCTS;
>  	} else {
>  		dev_dbg(dev, "%s - flow control = NONE\n", __func__);

Johan
