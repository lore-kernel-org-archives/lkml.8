Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4262C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 03:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B089620716
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 03:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgCEDfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 22:35:52 -0500
Received: from kernel.crashing.org ([76.164.61.194]:43620 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgCEDfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 22:35:52 -0500
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 0253Z9YA032350
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 4 Mar 2020 21:35:13 -0600
Message-ID: <8a9033d5e76951f5bec39531c5d0e0d6ef963ee5.camel@kernel.crashing.org>
Subject: Re: [PATCH] usb: gadget: aspeed: improve vhub port irq handling
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     rentao.bupt@gmail.com, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Date:   Thu, 05 Mar 2020 14:35:08 +1100
In-Reply-To: <20200305023859.21057-1-rentao.bupt@gmail.com>
References: <20200305023859.21057-1-rentao.bupt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-04 at 18:38 -0800, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> This patch evaluates vhub ports' irq mask before going through per-
> port
> irq handling one by one, which helps to speed up irq handling in case
> there is no port interrupt.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>

Looks reasonable, but did you try a find_next_bit() loop and whether
that's faster ?

> ---
>  drivers/usb/gadget/udc/aspeed-vhub/core.c | 11 ++++++-----
>  drivers/usb/gadget/udc/aspeed-vhub/vhub.h |  8 ++++----
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> index f8d35dd60c34..a03e4e4ea401 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> @@ -134,11 +134,11 @@ static irqreturn_t ast_vhub_irq(int irq, void
> *data)
>  	}
>  
>  	/* Handle device interrupts */
> -	for (i = 0; i < vhub->max_ports; i++) {
> -		u32 dev_mask = VHUB_IRQ_DEVICE1 << i;
> -
> -		if (istat & dev_mask)
> -			ast_vhub_dev_irq(&vhub->ports[i].dev);
> +	if (istat & vhub->port_irq_mask) {
> +		for (i = 0; i < vhub->max_ports; i++) {
> +			if (istat & VHUB_DEV_IRQ(i))
> +				ast_vhub_dev_irq(&vhub->ports[i].dev);
> +		}
>  	}
>  
>  	/* Handle top-level vHub EP0 interrupts */
> @@ -332,6 +332,7 @@ static int ast_vhub_probe(struct platform_device
> *pdev)
>  
>  	spin_lock_init(&vhub->lock);
>  	vhub->pdev = pdev;
> +	vhub->port_irq_mask = GENMASK(vhub->max_ports + 8, 9);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	vhub->regs = devm_ioremap_resource(&pdev->dev, res);
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
> b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
> index fac79ef6d669..e49924ec7e58 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
> @@ -54,10 +54,6 @@
>  #define VHUB_IRQ_USB_CMD_DEADLOCK		(1 << 18)
>  #define VHUB_IRQ_EP_POOL_NAK			(1 << 17)
>  #define VHUB_IRQ_EP_POOL_ACK_STALL		(1 << 16)
> -#define VHUB_IRQ_DEVICE5			(1 << 13)
> -#define VHUB_IRQ_DEVICE4			(1 << 12)
> -#define VHUB_IRQ_DEVICE3			(1 << 11)
> -#define VHUB_IRQ_DEVICE2			(1 << 10)
>  #define VHUB_IRQ_DEVICE1			(1 << 9)
>  #define VHUB_IRQ_BUS_RESUME			(1 << 8)
>  #define VHUB_IRQ_BUS_SUSPEND 			(1 << 7)
> @@ -70,6 +66,9 @@
>  #define VHUB_IRQ_HUB_EP0_SETUP			(1 << 0)
>  #define VHUB_IRQ_ACK_ALL			0x1ff
>  
> +/* Downstream device IRQ mask. */
> +#define VHUB_DEV_IRQ(n)				(VHUB_IRQ_DEVIC
> E1 << (n))
> +
>  /* SW reset reg */
>  #define VHUB_SW_RESET_EP_POOL			(1 << 9)
>  #define VHUB_SW_RESET_DMA_CONTROLLER		(1 << 8)
> @@ -402,6 +401,7 @@ struct ast_vhub {
>  	/* Per-port info */
>  	struct ast_vhub_port		*ports;
>  	u32				max_ports;
> +	u32				port_irq_mask;
>  
>  	/* Generic EP data structures */
>  	struct ast_vhub_ep		*epns;

