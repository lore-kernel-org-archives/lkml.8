Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D63C34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107AF21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgBRTkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:40:33 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:40355 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRTkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:40:33 -0500
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id BE37440005;
        Tue, 18 Feb 2020 19:40:24 +0000 (UTC)
Date:   Tue, 18 Feb 2020 20:40:24 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     b-liu@ti.com, balbi@kernel.org, gregkh@linuxfoundation.org,
        ludovic.desroches@microchip.com, mathias.nyman@intel.com,
        nicolas.ferre@microchip.com, slemieux.tyco@gmail.com,
        stern@rowland.harvard.edu, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 04/20] usb: gadget: at91_udc: remove useless cast for
 driver.name
Message-ID: <20200218194024.GD3385@piout.net>
References: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
 <1582054383-35760-5-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582054383-35760-5-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2020 19:32:47+0000, Corentin Labbe wrote:
> device_driver name is const char pointer, so it not useful to cast
> driver_name (which is already const char).
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/usb/gadget/udc/at91_udc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
> index 1b2b548c59a0..eede5cedacb4 100644
> --- a/drivers/usb/gadget/udc/at91_udc.c
> +++ b/drivers/usb/gadget/udc/at91_udc.c
> @@ -2021,7 +2021,7 @@ static struct platform_driver at91_udc_driver = {
>  	.suspend	= at91udc_suspend,
>  	.resume		= at91udc_resume,
>  	.driver		= {
> -		.name	= (char *) driver_name,
> +		.name	= driver_name,
>  		.of_match_table	= at91_udc_dt_ids,
>  	},
>  };
> -- 
> 2.24.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
