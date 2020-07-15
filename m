Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CC4C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B75002067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgGOV6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:58:06 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:35375 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgGOV6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:58:06 -0400
Received: from localhost (lfbn-lyo-1-1676-121.w90-65.abo.wanadoo.fr [90.65.108.121])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 5973B100008;
        Wed, 15 Jul 2020 21:58:02 +0000 (UTC)
Date:   Wed, 15 Jul 2020 23:58:01 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Cristian Birsan <cristian.birsan@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Songjun Wu <songjun.wu@atmel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH RESEND 3/3] usb: gadget: udc: atmel: implement .pullup
 callback
Message-ID: <20200715215801.GG23553@piout.net>
References: <cover.1594231056.git.mirq-linux@rere.qmqm.pl>
 <63121e624012996a2f6f5f3763270ad834667a12.1594231056.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63121e624012996a2f6f5f3763270ad834667a12.1594231056.git.mirq-linux@rere.qmqm.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2020 20:04:10+0200, Michał Mirosław wrote:
> Implement udc->pullup callback, so that udc_connect/disconnect work.
> This is needed for composite gadget, as it assumes udc_disconnect()
> actually works and calls its ->disconnect callback.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index 9342a3d24963..c5128c229c52 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -1028,6 +1028,7 @@ usba_udc_set_selfpowered(struct usb_gadget *gadget, int is_selfpowered)
>  	return 0;
>  }
>  
> +static int atmel_usba_pullup(struct usb_gadget *gadget, int is_on);
>  static int atmel_usba_start(struct usb_gadget *gadget,
>  		struct usb_gadget_driver *driver);
>  static int atmel_usba_stop(struct usb_gadget *gadget);
> @@ -1101,6 +1102,7 @@ static const struct usb_gadget_ops usba_udc_ops = {
>  	.get_frame		= usba_udc_get_frame,
>  	.wakeup			= usba_udc_wakeup,
>  	.set_selfpowered	= usba_udc_set_selfpowered,
> +	.pullup			= atmel_usba_pullup,
>  	.udc_start		= atmel_usba_start,
>  	.udc_stop		= atmel_usba_stop,
>  	.match_ep		= atmel_usba_match_ep,
> @@ -1957,6 +1959,24 @@ static irqreturn_t usba_vbus_irq_thread(int irq, void *devid)
>  	return IRQ_HANDLED;
>  }
>  
> +static int atmel_usba_pullup(struct usb_gadget *gadget, int is_on)
> +{
> +	struct usba_udc *udc = container_of(gadget, struct usba_udc, gadget);
> +	unsigned long flags;
> +	u32 ctrl;
> +
> +	spin_lock_irqsave(&udc->lock, flags);
> +	ctrl = usba_readl(udc, CTRL);
> +	if (is_on)
> +		ctrl &= ~USBA_DETACH;
> +	else
> +		ctrl |= USBA_DETACH;
> +	usba_writel(udc, CTRL, ctrl);
> +	spin_unlock_irqrestore(&udc->lock, flags);
> +
> +	return 0;
> +}
> +
>  static int atmel_usba_start(struct usb_gadget *gadget,
>  		struct usb_gadget_driver *driver)
>  {
> -- 
> 2.20.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
