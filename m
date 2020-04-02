Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B147CC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 10:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F950206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 10:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388037AbgDBKqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 06:46:15 -0400
Received: from kernel.crashing.org ([76.164.61.194]:37756 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387610AbgDBKqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 06:46:15 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 032AjeXr028624
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Apr 2020 05:45:44 -0500
Message-ID: <512d625e45ea953d722bb7ea73c3619730312284.camel@kernel.crashing.org>
Subject: Re: [PATCH v3] usb: gadget: aspeed: improve vhub port irq handling
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Tao Ren <rentao.bupt@gmail.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Date:   Thu, 02 Apr 2020 21:45:38 +1100
In-Reply-To: <20200401215826.GA8248@taoren-ubuntu-R90MNF91>
References: <20200315191430.12379-1-rentao.bupt@gmail.com>
         <20200401215826.GA8248@taoren-ubuntu-R90MNF91>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-01 at 14:58 -0700, Tao Ren wrote:
> Hi Ben,
> 
> Any further comments on the patch?

Ah sorry, nope. Did you check the generated assembly to see if it
looked any better ? :-)

Otherwise,

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> 
> Cheers,
> 
> Tao
> 
> On Sun, Mar 15, 2020 at 12:14:30PM -0700, rentao.bupt@gmail.com
> wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > This patch evaluates vhub ports' irq mask before going through per-
> > port
> > irq handling one by one, which helps to speed up irq handling in
> > case
> > there is no port interrupt.
> > 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > ---
> >  Changes in v3:
> >    - assign istat to (unsigned long) bitmap before calling
> >      "for_each_set_bit_from".
> >  Changes in v2:
> >    - use "for_each_set_bit" to speed up port irq handling.
> > 
> >  drivers/usb/gadget/udc/aspeed-vhub/core.c | 12 +++++++++---
> >  drivers/usb/gadget/udc/aspeed-vhub/vhub.h |  8 +++-----
> >  2 files changed, 12 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > index f8d35dd60c34..555e8645fb1e 100644
> > --- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > +++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > @@ -134,11 +134,15 @@ static irqreturn_t ast_vhub_irq(int irq, void
> > *data)
> >  	}
> >  
> >  	/* Handle device interrupts */
> > -	for (i = 0; i < vhub->max_ports; i++) {
> > -		u32 dev_mask = VHUB_IRQ_DEVICE1 << i;
> > +	if (istat & vhub->port_irq_mask) {
> > +		unsigned long bitmap = istat;
> > +		int offset = VHUB_IRQ_DEV1_BIT;
> > +		int size = VHUB_IRQ_DEV1_BIT + vhub->max_ports;
> >  
> > -		if (istat & dev_mask)
> > +		for_each_set_bit_from(offset, &bitmap, size) {
> > +			i = offset - VHUB_IRQ_DEV1_BIT;
> >  			ast_vhub_dev_irq(&vhub->ports[i].dev);
> > +		}
> >  	}
> >  
> >  	/* Handle top-level vHub EP0 interrupts */
> > @@ -332,6 +336,8 @@ static int ast_vhub_probe(struct
> > platform_device *pdev)
> >  
> >  	spin_lock_init(&vhub->lock);
> >  	vhub->pdev = pdev;
> > +	vhub->port_irq_mask = GENMASK(VHUB_IRQ_DEV1_BIT + vhub-
> > >max_ports - 1,
> > +				      VHUB_IRQ_DEV1_BIT);
> >  
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	vhub->regs = devm_ioremap_resource(&pdev->dev, res);
> > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
> > b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
> > index fac79ef6d669..23a1ac91f8d2 100644
> > --- a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
> > +++ b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
> > @@ -51,14 +51,11 @@
> >  #define VHUB_CTRL_UPSTREAM_CONNECT		(1 << 0)
> >  
> >  /* IER & ISR */
> > +#define VHUB_IRQ_DEV1_BIT			9
> >  #define VHUB_IRQ_USB_CMD_DEADLOCK		(1 << 18)
> >  #define VHUB_IRQ_EP_POOL_NAK			(1 << 17)
> >  #define VHUB_IRQ_EP_POOL_ACK_STALL		(1 << 16)
> > -#define VHUB_IRQ_DEVICE5			(1 << 13)
> > -#define VHUB_IRQ_DEVICE4			(1 << 12)
> > -#define VHUB_IRQ_DEVICE3			(1 << 11)
> > -#define VHUB_IRQ_DEVICE2			(1 << 10)
> > -#define VHUB_IRQ_DEVICE1			(1 << 9)
> > +#define VHUB_IRQ_DEVICE1			(1 <<
> > (VHUB_IRQ_DEV1_BIT))
> >  #define VHUB_IRQ_BUS_RESUME			(1 << 8)
> >  #define VHUB_IRQ_BUS_SUSPEND 			(1 << 7)
> >  #define VHUB_IRQ_BUS_RESET 			(1 << 6)
> > @@ -402,6 +399,7 @@ struct ast_vhub {
> >  	/* Per-port info */
> >  	struct ast_vhub_port		*ports;
> >  	u32				max_ports;
> > +	u32				port_irq_mask;
> >  
> >  	/* Generic EP data structures */
> >  	struct ast_vhub_ep		*epns;
> > -- 
> > 2.17.1
> > 

