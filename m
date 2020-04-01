Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCB3C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 21:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CF22054F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 21:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aug+9ANM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbgDAV6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 17:58:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43872 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732357AbgDAV6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 17:58:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id f206so687647pfa.10;
        Wed, 01 Apr 2020 14:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T6l/yr6Cjt15a6YDL3tI21z3eGbnhRLGQpcGGdkH3G0=;
        b=Aug+9ANMwfqMqTPoXflHoLnWAPyOIweS23iswm7clSDXgqDQCTiLRSSoMNZ0io2ytz
         4kmqK7K8TsoX8Oa1qCNIKmfyfFCeASbGk09hbmJT9JzSZOyO7y+qxD+tj+NEFilvfBwD
         Pkv6lnNNptyY6BsU/XB8/PfyksA6Z9Xm2tp++boXtgRMNr0fUMtwTmaeW6aqhqgBxxzh
         T3T/9LrClkN4dUYuEDANTY429B46thKNnNF8CWPF0AWe3YNUzg+3U1nhKB6vWT5uoZ9P
         z8TEIs2da5LgN87NKawCzRGQZ9m5Isbl8/I1AM+wuDNKZL4b1/4vZvFmT2cR6NyhM9bK
         U/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T6l/yr6Cjt15a6YDL3tI21z3eGbnhRLGQpcGGdkH3G0=;
        b=df6LoAgiRkf2y6u0uWKsCCseiMWDkz2wsqOK6BcjZxfyiVQXKkmmHBtcmfZZmji0kD
         4ParHqshKzBzuFaOJMYw5id4scwchzgMFjXWqZfe1YUHU0azDlZ5nmvAC1zh3cVcbT45
         1nZ1euUpAwY5ngPkI3XkHw3iIGQcjOjHj2uDGmTw6iTOZulngHR4r8GEP79VQ3iBh6qT
         WtZLBmSb8NBkTG/UnbHKjXgfTaEiiF/pdegrwfTYohF2qWjqKl9oW5JLm/L5L6itOyyb
         v+lJ0ZpCceuQ5jPB6UmZPvmpaJlwJQwuP0HEoABSJDHZS2CI7nOfrCSSJQEFCO2/8S0O
         eB+Q==
X-Gm-Message-State: AGi0PuYWL1x+bPQR5/tNKybyTfJko1pPk6pG1/a5pecs7jElAx/xPS6w
        cbNLeQGx3n8PJaAD+hxPcok=
X-Google-Smtp-Source: APiQypKQLNXXWccupxCJd6/Wi/Nq14WhOAQB8ADTtsp5VWa5/Aot0+vBabx18lkkpwOAaRkoEYxr3g==
X-Received: by 2002:a63:134e:: with SMTP id 14mr288009pgt.380.1585778314374;
        Wed, 01 Apr 2020 14:58:34 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id q71sm2378551pjb.5.2020.04.01.14.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Apr 2020 14:58:33 -0700 (PDT)
Date:   Wed, 1 Apr 2020 14:58:27 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Subject: Re: [PATCH v3] usb: gadget: aspeed: improve vhub port irq handling
Message-ID: <20200401215826.GA8248@taoren-ubuntu-R90MNF91>
References: <20200315191430.12379-1-rentao.bupt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315191430.12379-1-rentao.bupt@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

Any further comments on the patch?


Cheers,

Tao

On Sun, Mar 15, 2020 at 12:14:30PM -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> This patch evaluates vhub ports' irq mask before going through per-port
> irq handling one by one, which helps to speed up irq handling in case
> there is no port interrupt.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
>  Changes in v3:
>    - assign istat to (unsigned long) bitmap before calling
>      "for_each_set_bit_from".
>  Changes in v2:
>    - use "for_each_set_bit" to speed up port irq handling.
> 
>  drivers/usb/gadget/udc/aspeed-vhub/core.c | 12 +++++++++---
>  drivers/usb/gadget/udc/aspeed-vhub/vhub.h |  8 +++-----
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> index f8d35dd60c34..555e8645fb1e 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> @@ -134,11 +134,15 @@ static irqreturn_t ast_vhub_irq(int irq, void *data)
>  	}
>  
>  	/* Handle device interrupts */
> -	for (i = 0; i < vhub->max_ports; i++) {
> -		u32 dev_mask = VHUB_IRQ_DEVICE1 << i;
> +	if (istat & vhub->port_irq_mask) {
> +		unsigned long bitmap = istat;
> +		int offset = VHUB_IRQ_DEV1_BIT;
> +		int size = VHUB_IRQ_DEV1_BIT + vhub->max_ports;
>  
> -		if (istat & dev_mask)
> +		for_each_set_bit_from(offset, &bitmap, size) {
> +			i = offset - VHUB_IRQ_DEV1_BIT;
>  			ast_vhub_dev_irq(&vhub->ports[i].dev);
> +		}
>  	}
>  
>  	/* Handle top-level vHub EP0 interrupts */
> @@ -332,6 +336,8 @@ static int ast_vhub_probe(struct platform_device *pdev)
>  
>  	spin_lock_init(&vhub->lock);
>  	vhub->pdev = pdev;
> +	vhub->port_irq_mask = GENMASK(VHUB_IRQ_DEV1_BIT + vhub->max_ports - 1,
> +				      VHUB_IRQ_DEV1_BIT);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	vhub->regs = devm_ioremap_resource(&pdev->dev, res);
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
> index fac79ef6d669..23a1ac91f8d2 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
> @@ -51,14 +51,11 @@
>  #define VHUB_CTRL_UPSTREAM_CONNECT		(1 << 0)
>  
>  /* IER & ISR */
> +#define VHUB_IRQ_DEV1_BIT			9
>  #define VHUB_IRQ_USB_CMD_DEADLOCK		(1 << 18)
>  #define VHUB_IRQ_EP_POOL_NAK			(1 << 17)
>  #define VHUB_IRQ_EP_POOL_ACK_STALL		(1 << 16)
> -#define VHUB_IRQ_DEVICE5			(1 << 13)
> -#define VHUB_IRQ_DEVICE4			(1 << 12)
> -#define VHUB_IRQ_DEVICE3			(1 << 11)
> -#define VHUB_IRQ_DEVICE2			(1 << 10)
> -#define VHUB_IRQ_DEVICE1			(1 << 9)
> +#define VHUB_IRQ_DEVICE1			(1 << (VHUB_IRQ_DEV1_BIT))
>  #define VHUB_IRQ_BUS_RESUME			(1 << 8)
>  #define VHUB_IRQ_BUS_SUSPEND 			(1 << 7)
>  #define VHUB_IRQ_BUS_RESET 			(1 << 6)
> @@ -402,6 +399,7 @@ struct ast_vhub {
>  	/* Per-port info */
>  	struct ast_vhub_port		*ports;
>  	u32				max_ports;
> +	u32				port_irq_mask;
>  
>  	/* Generic EP data structures */
>  	struct ast_vhub_ep		*epns;
> -- 
> 2.17.1
> 
