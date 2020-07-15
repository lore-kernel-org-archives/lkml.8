Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A76C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD98D206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgGOVom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:44:42 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:49211 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgGOVol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:44:41 -0400
X-Originating-IP: 90.65.108.121
Received: from localhost (lfbn-lyo-1-1676-121.w90-65.abo.wanadoo.fr [90.65.108.121])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 1CA45E0005;
        Wed, 15 Jul 2020 21:44:38 +0000 (UTC)
Date:   Wed, 15 Jul 2020 23:44:38 +0200
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
Subject: Re: [PATCH RESEND 1/3] usb: gadget: udc: atmel: remove outdated
 comment in usba_ep_disable()
Message-ID: <20200715214438.GE23553@piout.net>
References: <cover.1594231056.git.mirq-linux@rere.qmqm.pl>
 <ab8ef3e2bf15fa75572f9ad51d6e7b10c67cb494.1594231056.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab8ef3e2bf15fa75572f9ad51d6e7b10c67cb494.1594231056.git.mirq-linux@rere.qmqm.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2020 20:04:09+0200, Michał Mirosław wrote:
> Fixed commit removed the offending behaviour from the driver, but missed
> the comment and associated test. Remove them now.
> 
> Fixes: 38e58986e6fc ("usb: gadget: udc: atmel: don't disable enpdoints we don't own")
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index d69f61ff0181..9153e220848d 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -676,13 +676,7 @@ static int usba_ep_disable(struct usb_ep *_ep)
>  
>  	if (!ep->ep.desc) {
>  		spin_unlock_irqrestore(&udc->lock, flags);
> -		/* REVISIT because this driver disables endpoints in
> -		 * reset_all_endpoints() before calling disconnect(),
> -		 * most gadget drivers would trigger this non-error ...
> -		 */
> -		if (udc->gadget.speed != USB_SPEED_UNKNOWN)
> -			DBG(DBG_ERR, "ep_disable: %s not enabled\n",
> -					ep->ep.name);
> +		DBG(DBG_ERR, "ep_disable: %s not enabled\n", ep->ep.name);
>  		return -EINVAL;
>  	}
>  	ep->ep.desc = NULL;
> -- 
> 2.20.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
