Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAF5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE74020716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GXv2ZNEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgFVP4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbgFVP4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:56:30 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BF1C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 08:56:28 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a6so15254817wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 08:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kSMspTFGxKNsReoFaFuGJU3LuXpebLrE7bbL0ZZt+X8=;
        b=GXv2ZNEabhbhSf7vXvuVC7lyGiiOvUukOmdBQvekLZ+qdVz/B7mzEhE04wmtCu7H94
         qIYOIUGV8F0dtRgrSLsr5rKqVlXaYQeBBZrf9wZ9PJN6A9Nc0s2NntSKKdDrCaAXsiPO
         gVRzXm592POsuRnrI3XFZcTrUI1TNYtkaMy8bYiGeIXhsa1o9OU7zUjkuC8AWYv5l6UL
         2u2zSVTcVV8UJaFoj1wyD6ulvLAYuXpFag7UrU8M8CwMng4DJf9jLc2eIqyYQHcrX4ki
         7U28cjIKDC29qqaXZxSSwbAS4nbEHpM0OBtChPCL6D+4OID6G3V3HXXXg7paO8R3kaoo
         ZEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kSMspTFGxKNsReoFaFuGJU3LuXpebLrE7bbL0ZZt+X8=;
        b=HVyGw+M3tBcWKhgsk7yMTcPjtvOoDosCXRj4Xfq8vxkLkS3iXhijoZuQZiqyyHEQaf
         sK+5LEORfmiRr0KF8I8e9vgXY/Lkx7gAHvvPp9CE1vIDX+zBERcVZWrl+XrsvOw67Umy
         kX3IiJ99nOGU8HZ4Jc+R8wRdEE5Y5k5szDSdr7Au28Yb/Ho8O6cFU1s7tsXwggq2f8iA
         Es++nBLoCdudvyTmy7Yw8GhDrjdkqsS4Ov4ta4SMAG0FDXAycN4X07Sg2lZ79yRd1bgK
         bMLR3uZofQiBUx7gKGmsPwzhOP31fqFwrjgFa5Uuy0QA1M2vS40J4HaqTNrtbwb1oMVc
         uNKA==
X-Gm-Message-State: AOAM533eSgnfk1+vzFiGVHlPFf8zB8+UxW9ODQQtsayOD9wNyNRAx9WY
        jjuW54nCraJ55StV5AneG6zdxVBPEjI=
X-Google-Smtp-Source: ABdhPJxxJgkt35ckzF3UHxiybAvxxwtheduC5J/trxrNa8yKhlixDpRotx+E7cZGBlOIIJi0HzSYDA==
X-Received: by 2002:adf:f34e:: with SMTP id e14mr19735827wrp.299.1592841387421;
        Mon, 22 Jun 2020 08:56:27 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id n8sm15375134wrj.44.2020.06.22.08.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 08:56:26 -0700 (PDT)
Date:   Mon, 22 Jun 2020 16:56:24 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jason.wessel@windriver.com,
        dianders@chromium.org, jslaby@suse.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] tty: serial: Add poll_get_irq() to the polling
 interface
Message-ID: <20200622155624.he2vs2r3e5yzf3sl@holly.lan>
References: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
 <1592835984-28613-3-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592835984-28613-3-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 07:56:19PM +0530, Sumit Garg wrote:
> From: Daniel Thompson <daniel.thompson@linaro.org>

Sumit, to some extent this mail is me yelling at myself two years ago
although, in my defence, at the time I choose not to post it because I
knew it wasn't right.

I'm a bit concerned to see the TODO: comment critiquing this interface
being removed (from patch 3) without this patch being changed to
address that comment.


> Add new API: poll_get_irq() to the polling interface in order for user
> of polling interface to retrieve allocated IRQ corresponding to
> underlying serial device.
> 
> Although, serial interface still works in polling mode but interrupt
> associated with serial device can be leveraged for special purposes like
> debugger(kgdb) entry.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tty/serial/serial_core.c | 18 ++++++++++++++++++
>  include/linux/serial_core.h      |  1 +
>  include/linux/tty_driver.h       |  1 +
>  3 files changed, 20 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 66a5e2f..1bb033c 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2470,6 +2470,23 @@ static void uart_poll_put_char(struct tty_driver *driver, int line, char ch)
>  	port->ops->poll_put_char(port, ch);
>  	uart_port_deref(port);
>  }
> +
> +static int uart_poll_get_irq(struct tty_driver *driver, int line)
> +{
> +	struct uart_driver *drv = driver->driver_state;
> +	struct uart_state *state = drv->state + line;
> +	struct uart_port *port;
> +	int ret = -ENODEV;
> +
> +	port = uart_port_ref(state);
> +	if (port && port->ops->poll_get_irq) {
> +		ret = port->ops->poll_get_irq(port);
> +		uart_port_deref(port);
> +	}
> +
> +	return ret;
> +}
> +
>  #endif
>  
>  static const struct tty_operations uart_ops = {
> @@ -2505,6 +2522,7 @@ static const struct tty_operations uart_ops = {
>  	.poll_init	= uart_poll_init,
>  	.poll_get_char	= uart_poll_get_char,
>  	.poll_put_char	= uart_poll_put_char,
> +	.poll_get_irq	= uart_poll_get_irq,

The TODO comments claimed this API was bogus because it doesn't permit
a free and that can cause interoperation problems with the real serial
driver. I'll cover some of that in a reply to patch 3 but for now.

Anyhow, for this patch, what are the expected semantics for
uart_poll_get_irq().

In particular how do they ensure correct interlocking with the real
serial driver underlying it (if kgdb_nmi is active on a serial port
then the underlying driver better not be active at the same time).


Daniel.


>  #endif
>  };
>  
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 92f5eba..8b132e6 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -78,6 +78,7 @@ struct uart_ops {
>  	int		(*poll_init)(struct uart_port *);
>  	void		(*poll_put_char)(struct uart_port *, unsigned char);
>  	int		(*poll_get_char)(struct uart_port *);
> +	int		(*poll_get_irq)(struct uart_port *);
>  #endif
>  };
>  
> diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
> index 3584462..d6da5c5 100644
> --- a/include/linux/tty_driver.h
> +++ b/include/linux/tty_driver.h
> @@ -295,6 +295,7 @@ struct tty_operations {
>  	int (*poll_init)(struct tty_driver *driver, int line, char *options);
>  	int (*poll_get_char)(struct tty_driver *driver, int line);
>  	void (*poll_put_char)(struct tty_driver *driver, int line, char ch);
> +	int (*poll_get_irq)(struct tty_driver *driver, int line);
>  #endif
>  	int (*proc_show)(struct seq_file *, void *);
>  } __randomize_layout;
> -- 
> 2.7.4
> 
