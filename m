Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F78C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4F2D20756
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m7hNB/ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbgEUV2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 17:28:51 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53276 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgEUV2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 17:28:50 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04LLSifI072910;
        Thu, 21 May 2020 16:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590096524;
        bh=BvGJnRgL/UeD+bvIGte9QTG7iAx7BnhTCAOJYfMIVX0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=m7hNB/tyLXeljfvFdl8ryTNttbPj4hUOQS07BdtenJIFiNyftV/2q+gFHmuiqKazK
         thLxAq8YvpDRzoq0cte/nTs5/PebmiyTmYjr0qifYB76f54W+zincnZRBy8BpAZsYo
         U04RikBdRvuoz6CtmwJ+xL73nko+rzqupvKdGJ0E=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04LLSiC9039673
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 16:28:44 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 May 2020 16:28:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 May 2020 16:28:43 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04LLShWJ073711;
        Thu, 21 May 2020 16:28:43 -0500
Date:   Thu, 21 May 2020 16:28:43 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <od@zcrc.me>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] usb: musb: jz4740: Prevent lockup when CONFIG_SMP is set
Message-ID: <20200521212843.GD5684@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
References: <20200520150111.76658-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200520150111.76658-1-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, May 20, 2020 at 05:01:11PM +0200, Paul Cercueil wrote:
> The function dma_controller_irq() locks up the exact same spinlock we
> locked before calling it, which obviously resulted in a deadlock when
> CONFIG_SMP was enabled. This flew under the radar as none of the boards
> supported by this driver needs SMP.
> 
> Fixes: 57aadb46bd63 ("usb: musb: jz4740: Add support for DMA")
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Is it too late if you directly take this patch for v5.7-rc7? The bug is
introduced in v5.7-rc1. If so, here is my Acked-by:

Acked-by: Bin Liu <b-liu@ti.com>

Thanks,
-Bin.

> ---
>  drivers/usb/musb/jz4740.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
> index 54e7b30acc69..42c1e8bfc4be 100644
> --- a/drivers/usb/musb/jz4740.c
> +++ b/drivers/usb/musb/jz4740.c
> @@ -69,11 +69,11 @@ static irqreturn_t jz4740_musb_interrupt(int irq, void *__hci)
>  	irqreturn_t	retval = IRQ_NONE, retval_dma = IRQ_NONE;
>  	struct musb	*musb = __hci;
>  
> -	spin_lock_irqsave(&musb->lock, flags);
> -
>  	if (IS_ENABLED(CONFIG_USB_INVENTRA_DMA) && musb->dma_controller)
>  		retval_dma = dma_controller_irq(irq, musb->dma_controller);
>  
> +	spin_lock_irqsave(&musb->lock, flags);
> +
>  	musb->int_usb = musb_readb(musb->mregs, MUSB_INTRUSB);
>  	musb->int_tx = musb_readw(musb->mregs, MUSB_INTRTX);
>  	musb->int_rx = musb_readw(musb->mregs, MUSB_INTRRX);
> -- 
> 2.26.2
> 
