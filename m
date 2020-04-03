Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA2CC2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 06:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B299020757
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 06:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOPWjYg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388902AbgDCGsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 02:48:35 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38739 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388472AbgDCGsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 02:48:35 -0400
Received: by mail-pj1-f65.google.com with SMTP id m15so2540399pje.3;
        Thu, 02 Apr 2020 23:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X8sH17jtDMINv9quf+CHHV/bCIE6kl8S5IdK86F1KQE=;
        b=bOPWjYg7B8DH9QrulXs3F3wHHmfBrRkcoJhncqWc/qjbF/8MADE6iaxFrqrVL7n63C
         c0UEmgkpkxg1YiwlaiwNHAYDYe0x/n2F7krhJFTLeLiDoymAT+IdIJbTXsWSdXrsVGyk
         Yeu8mm9g9ttT7A0fpUbD93zm5tAos+ax/KJHdF8lBbq44zXyYrbUwR3nUWImUJDKtP8o
         L2vEoag+x+xo00ebLKOkqTFsKYY85PmgrbI6j5MDW6xgF+/jU6Mi3U/jCxLjFridKtwE
         uS8sioUYLEi8DnYmzN1WKPq5Pyc+G/BY1ZS7DOA92Md5zp75HnPGx8UVFZbEktKyLlqf
         pvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X8sH17jtDMINv9quf+CHHV/bCIE6kl8S5IdK86F1KQE=;
        b=jI+NbDbYuMMQDJa12nSnWH626zcgJQsmdOL+wo12RfsrPZX0LSWo1AELUmc00gtue3
         VfgA+2+aAdmSyfBi8dFlm33slQernDq4XZT8PA//4tPw4L5HJmxZbWg8c7JYz2PIPwXM
         QxUmQR/7UB7l8rDeg4mDAknC7fhu8ZDwrcgpiVrjiQGj1qdLJw8JWf7er8iiC3FIfmiq
         V4BlCat7NsgCmExGTmAuQt/eIJPvSLLjZQyOQoviwyRr+YBNBB1XqgHg1EHN/D8FvKSs
         XrIIi9B9qiOV59xATHtZMwE0+GZQASVV2fZjeunNnfpn27TNtYBuPKxdwMK6nTEhaLij
         jjcQ==
X-Gm-Message-State: AGi0PuZTiD2jgcONHE+VAi8lCBdKAyGIoyDbfKdhvm/uu83uw1xGKQRJ
        Owyb7Df5lxJPD4ktpABH+R+4kWQyGwg=
X-Google-Smtp-Source: APiQypIgxqh1DBnzx+8YsP5YKSJSTmMCy4ilEK1+IGjU0CJPpK8/Zzl472xC/xJqFtVSDjcQHF5BBQ==
X-Received: by 2002:a17:902:9a45:: with SMTP id x5mr6107549plv.296.1585896514050;
        Thu, 02 Apr 2020 23:48:34 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id x25sm4719713pgc.63.2020.04.02.23.48.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Apr 2020 23:48:33 -0700 (PDT)
Date:   Thu, 2 Apr 2020 23:48:27 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Subject: Re: [PATCH v3] usb: gadget: aspeed: improve vhub port irq handling
Message-ID: <20200403064826.GA10866@taoren-ubuntu-R90MNF91>
References: <20200315191430.12379-1-rentao.bupt@gmail.com>
 <20200401215826.GA8248@taoren-ubuntu-R90MNF91>
 <512d625e45ea953d722bb7ea73c3619730312284.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <512d625e45ea953d722bb7ea73c3619730312284.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 09:45:38PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2020-04-01 at 14:58 -0700, Tao Ren wrote:
> > Hi Ben,
> > 
> > Any further comments on the patch?
> 
> Ah sorry, nope. Did you check the generated assembly to see if it
> looked any better ? :-)
> 
> Otherwise,
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks Ben for the review. Let me see if I can collect some runtime data
on my ast2400 BMC platform. Will update back later.


Cheers,

Tao
> 
> > 
> > Cheers,
> > 
> > Tao
> > 
> > On Sun, Mar 15, 2020 at 12:14:30PM -0700, rentao.bupt@gmail.com
> > wrote:
> > > From: Tao Ren <rentao.bupt@gmail.com>
> > > 
> > > This patch evaluates vhub ports' irq mask before going through per-
> > > port
> > > irq handling one by one, which helps to speed up irq handling in
> > > case
> > > there is no port interrupt.
> > > 
> > > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > > ---
> > >  Changes in v3:
> > >    - assign istat to (unsigned long) bitmap before calling
> > >      "for_each_set_bit_from".
> > >  Changes in v2:
> > >    - use "for_each_set_bit" to speed up port irq handling.
> > > 
> > >  drivers/usb/gadget/udc/aspeed-vhub/core.c | 12 +++++++++---
> > >  drivers/usb/gadget/udc/aspeed-vhub/vhub.h |  8 +++-----
> > >  2 files changed, 12 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > > b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > > index f8d35dd60c34..555e8645fb1e 100644
> > > --- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > > +++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > > @@ -134,11 +134,15 @@ static irqreturn_t ast_vhub_irq(int irq, void
> > > *data)
> > >  	}
> > >  
> > >  	/* Handle device interrupts */
> > > -	for (i = 0; i < vhub->max_ports; i++) {
> > > -		u32 dev_mask = VHUB_IRQ_DEVICE1 << i;
> > > +	if (istat & vhub->port_irq_mask) {
> > > +		unsigned long bitmap = istat;
> > > +		int offset = VHUB_IRQ_DEV1_BIT;
> > > +		int size = VHUB_IRQ_DEV1_BIT + vhub->max_ports;
> > >  
> > > -		if (istat & dev_mask)
> > > +		for_each_set_bit_from(offset, &bitmap, size) {
> > > +			i = offset - VHUB_IRQ_DEV1_BIT;
> > >  			ast_vhub_dev_irq(&vhub->ports[i].dev);
> > > +		}
> > >  	}
> > >  
> > >  	/* Handle top-level vHub EP0 interrupts */
> > > @@ -332,6 +336,8 @@ static int ast_vhub_probe(struct
> > > platform_device *pdev)
> > >  
> > >  	spin_lock_init(&vhub->lock);
> > >  	vhub->pdev = pdev;
> > > +	vhub->port_irq_mask = GENMASK(VHUB_IRQ_DEV1_BIT + vhub-
> > > >max_ports - 1,
> > > +				      VHUB_IRQ_DEV1_BIT);
> > >  
> > >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >  	vhub->regs = devm_ioremap_resource(&pdev->dev, res);
> > > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
> > > b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
> > > index fac79ef6d669..23a1ac91f8d2 100644
> > > --- a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
> > > +++ b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
> > > @@ -51,14 +51,11 @@
> > >  #define VHUB_CTRL_UPSTREAM_CONNECT		(1 << 0)
> > >  
> > >  /* IER & ISR */
> > > +#define VHUB_IRQ_DEV1_BIT			9
> > >  #define VHUB_IRQ_USB_CMD_DEADLOCK		(1 << 18)
> > >  #define VHUB_IRQ_EP_POOL_NAK			(1 << 17)
> > >  #define VHUB_IRQ_EP_POOL_ACK_STALL		(1 << 16)
> > > -#define VHUB_IRQ_DEVICE5			(1 << 13)
> > > -#define VHUB_IRQ_DEVICE4			(1 << 12)
> > > -#define VHUB_IRQ_DEVICE3			(1 << 11)
> > > -#define VHUB_IRQ_DEVICE2			(1 << 10)
> > > -#define VHUB_IRQ_DEVICE1			(1 << 9)
> > > +#define VHUB_IRQ_DEVICE1			(1 <<
> > > (VHUB_IRQ_DEV1_BIT))
> > >  #define VHUB_IRQ_BUS_RESUME			(1 << 8)
> > >  #define VHUB_IRQ_BUS_SUSPEND 			(1 << 7)
> > >  #define VHUB_IRQ_BUS_RESET 			(1 << 6)
> > > @@ -402,6 +399,7 @@ struct ast_vhub {
> > >  	/* Per-port info */
> > >  	struct ast_vhub_port		*ports;
> > >  	u32				max_ports;
> > > +	u32				port_irq_mask;
> > >  
> > >  	/* Generic EP data structures */
> > >  	struct ast_vhub_ep		*epns;
> > > -- 
> > > 2.17.1
> > > 
> 
