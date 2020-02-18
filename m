Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C6AC3404C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B72A21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgBRTlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:41:09 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:49475 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRTlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:41:08 -0500
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A034EE0005;
        Tue, 18 Feb 2020 19:41:02 +0000 (UTC)
Date:   Tue, 18 Feb 2020 20:41:02 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     b-liu@ti.com, balbi@kernel.org, gregkh@linuxfoundation.org,
        ludovic.desroches@microchip.com, mathias.nyman@intel.com,
        nicolas.ferre@microchip.com, slemieux.tyco@gmail.com,
        stern@rowland.harvard.edu, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 09/20] usb: gadget: lpc32xx_udc: remove useless cast for
 driver.name
Message-ID: <20200218194102.GE3385@piout.net>
References: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
 <1582054383-35760-10-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582054383-35760-10-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2020 19:32:52+0000, Corentin Labbe wrote:
> device_driver name is const char pointer, so it not useful to cast
> driver_name (which is already const char).
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/usb/gadget/udc/lpc32xx_udc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
> index d14b2bb3f67c..cb997b82c008 100644
> --- a/drivers/usb/gadget/udc/lpc32xx_udc.c
> +++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
> @@ -3267,7 +3267,7 @@ static struct platform_driver lpc32xx_udc_driver = {
>  	.suspend	= lpc32xx_udc_suspend,
>  	.resume		= lpc32xx_udc_resume,
>  	.driver		= {
> -		.name	= (char *) driver_name,
> +		.name	= driver_name,
>  		.of_match_table = of_match_ptr(lpc32xx_udc_of_match),
>  	},
>  };
> -- 
> 2.24.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
