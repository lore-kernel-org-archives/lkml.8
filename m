Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8810FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65C3F207EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgGQOCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:02:21 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:50907 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgGQOCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:02:21 -0400
X-Originating-IP: 90.65.108.121
Received: from localhost (lfbn-lyo-1-1676-121.w90-65.abo.wanadoo.fr [90.65.108.121])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id C50FF1BF20D;
        Fri, 17 Jul 2020 14:02:18 +0000 (UTC)
Date:   Fri, 17 Jul 2020 16:02:18 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH v2 12/14] spi: spi-at91-usart: Remove unused OF table
 'struct of_device_id'
Message-ID: <20200717140218.GR3428@piout.net>
References: <20200717135424.2442271-1-lee.jones@linaro.org>
 <20200717135424.2442271-13-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200717135424.2442271-13-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2020 14:54:22+0100, Lee Jones wrote:
> The only way this driver can be probed by MFD via its parent device.
> 
> No other reference to 'microchip,at91sam9g45-usart-spi' exists in the kernel.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/spi/spi-at91-usart.c:684:34: warning: ‘at91_usart_spi_dt_ids’ defined but not used [-Wunused-const-variable=]
>  684 | static const struct of_device_id at91_usart_spi_dt_ids[] = {
>  | ^~~~~~~~~~~~~~~~~~~~~
> 
> Cc: Radu Pirea <radu_nicolae.pirea@upb.ro>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Suggested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/spi/spi-at91-usart.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
> index 88033422a42ae..8c8352625d232 100644
> --- a/drivers/spi/spi-at91-usart.c
> +++ b/drivers/spi/spi-at91-usart.c
> @@ -681,13 +681,6 @@ static const struct dev_pm_ops at91_usart_spi_pm_ops = {
>  			   at91_usart_spi_runtime_resume, NULL)
>  };
>  
> -static const struct of_device_id at91_usart_spi_dt_ids[] = {
> -	{ .compatible = "microchip,at91sam9g45-usart-spi"},
> -	{ /* sentinel */}
> -};
> -
> -MODULE_DEVICE_TABLE(of, at91_usart_spi_dt_ids);
> -
>  static struct platform_driver at91_usart_spi_driver = {
>  	.driver = {
>  		.name = "at91_usart_spi",
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
