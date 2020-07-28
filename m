Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56605C433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 300112065E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cIZteSBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgG1HGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgG1HGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 03:06:22 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412C5C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 00:06:22 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id 88so17151172wrh.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 00:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=18JVd05NDt1O4RkEqrurrFak6JROUneo1UMNNJyfark=;
        b=cIZteSBnz5RY94m6zmiu7Ou8N7ExRsgg1A+L0HkR721f3i0LjBRE4Qna4hIMLUC69e
         GdvnDP9MaNS4YgkOQjlTO4Wgjc4xPTObruZAO9ZwUeXUzweZhyjhIIbqNvlyBSdS0L2S
         IpiOzT3KVF92dktX0LWJj9j/19L8g/heNKCH1VGAjy0MgMiyBrzRVOAuCLqglmwG+b8+
         bArdLk8NeI3d2wvSLJ1S3221Roscn5fZQlF0ov2TPZNGC2GHd5sLcx20I8xbS6+jOOOp
         kWawpU8ow2KjMvy77YqmfkEd+MEjcXzdqCyEgHsE7w+5x3Czgg78qy0LhG8ZmbOyNO7g
         6few==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=18JVd05NDt1O4RkEqrurrFak6JROUneo1UMNNJyfark=;
        b=gy8aslrOGkWhwljIHqGeJfFtcXBItpa36SifSLxBm86uM5zI8hUdf6qNZbaj7C6rj1
         r6zo6vw0TZYbqk3Fqn9Y3EbFAnKjrJlOSTvXZhtIUSOdSyi8ziBIKejZM6ZyVoGgDeIa
         KUHsnWNI0qDuTYGicDietksS3N4Xk7Hp521LR1pBcMq5n2pVF2RvSIlGwfhZlWGHeBse
         Wt+Lvn51YEMehUqyCdegWWaywzL/RYIQmWg0V9DviywuOK9hUxFyX6Sh23v1EeWSWCwK
         S2OLnokD8pYqQfvnzh59/uzkmj6jASsy5t8yAINmTBNTYGnRZExXedWV90NVlkiYPOrS
         oEfA==
X-Gm-Message-State: AOAM530e0oqVfmOs5DJ2zF8vAFk7OswPVHp0u47Sy6rrV9UCzEWsDTxZ
        FkO8DMLI+xwinbk0O7aEooz+Pw==
X-Google-Smtp-Source: ABdhPJwdH8Oj6YmPd+gs0q/N5LnhN2gDBm1kpbDMFOrtwFsinnwiR+ovQdJhe0KtDapmlkJ3s/T2OA==
X-Received: by 2002:a5d:4907:: with SMTP id x7mr25415225wrq.166.1595919980947;
        Tue, 28 Jul 2020 00:06:20 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id k1sm7339312wrw.91.2020.07.28.00.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 00:06:20 -0700 (PDT)
Date:   Tue, 28 Jul 2020 08:06:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] mfd: dm355evm_msp: Convert LEDs to GPIO descriptor table
Message-ID: <20200728070618.GD1850026@dell>
References: <20200727072844.195723-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200727072844.195723-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020, Linus Walleij wrote:

> This converts the DaVinci DM355EVM LEDs to use GPIO
> descriptor look-ups.
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mfd/dm355evm_msp.c | 49 ++++++++++++++++++++++++++++----------
>  1 file changed, 37 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mfd/dm355evm_msp.c b/drivers/mfd/dm355evm_msp.c
> index 151c36ce7343..af24712d605e 100644
> --- a/drivers/mfd/dm355evm_msp.c
> +++ b/drivers/mfd/dm355evm_msp.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/err.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio/machine.h>
>  #include <linux/leds.h>
>  #include <linux/i2c.h>
>  #include <linux/mfd/dm355evm_msp.h>
> @@ -260,31 +261,55 @@ static int add_children(struct i2c_client *client)
>  
>  	/* LED output */
>  	if (msp_has_leds()) {
> -#define GPIO_LED(l)	.name = l, .active_low = true
>  		static struct gpio_led evm_leds[] = {
> -			{ GPIO_LED("dm355evm::ds14"),
> +			{ .name = "dm355evm::ds14",
>  				.default_trigger = "heartbeat", },
> -			{ GPIO_LED("dm355evm::ds15"),
> +			{ .name = "dm355evm::ds15",
>  				.default_trigger = "mmc0", },
> -			{ GPIO_LED("dm355evm::ds16"),
> +			{ .name = "dm355evm::ds16",
>  				/* could also be a CE-ATA drive */
>  				.default_trigger = "mmc1", },
> -			{ GPIO_LED("dm355evm::ds17"),
> +			{ .name = "dm355evm::ds17",
>  				.default_trigger = "nand-disk", },
> -			{ GPIO_LED("dm355evm::ds18"), },
> -			{ GPIO_LED("dm355evm::ds19"), },
> -			{ GPIO_LED("dm355evm::ds20"), },
> -			{ GPIO_LED("dm355evm::ds21"), },
> +			{ .name = "dm355evm::ds18", },
> +			{ .name = "dm355evm::ds19", },
> +			{ .name = "dm355evm::ds20", },
> +			{ .name = "dm355evm::ds21", },
>  		};
> -#undef GPIO_LED
>  
>  		struct gpio_led_platform_data evm_led_data = {
>  			.num_leds	= ARRAY_SIZE(evm_leds),
>  			.leds		= evm_leds,
>  		};
>  
> -		for (i = 0; i < ARRAY_SIZE(evm_leds); i++)
> -			evm_leds[i].gpio = i + dm355evm_msp_gpio.base;
> +		static struct gpiod_lookup_table evm_leds_gpio_table = {
> +			.dev_id = "leds-gpio",
> +			.table = {
> +				/*
> +				 * These GPIOs are on the dm355evm_msp
> +				 * GPIO chip at index 0..7
> +				 */
> +				GPIO_LOOKUP_IDX("dm355evm_msp", 0, NULL,
> +						0, GPIO_ACTIVE_LOW),
> +				GPIO_LOOKUP_IDX("dm355evm_msp", 1, NULL,
> +						1, GPIO_ACTIVE_LOW),
> +				GPIO_LOOKUP_IDX("dm355evm_msp", 2, NULL,
> +						2, GPIO_ACTIVE_LOW),
> +				GPIO_LOOKUP_IDX("dm355evm_msp", 3, NULL,
> +						3, GPIO_ACTIVE_LOW),
> +				GPIO_LOOKUP_IDX("dm355evm_msp", 4, NULL,
> +						4, GPIO_ACTIVE_LOW),
> +				GPIO_LOOKUP_IDX("dm355evm_msp", 5, NULL,
> +						5, GPIO_ACTIVE_LOW),
> +				GPIO_LOOKUP_IDX("dm355evm_msp", 6, NULL,
> +						6, GPIO_ACTIVE_LOW),
> +				GPIO_LOOKUP_IDX("dm355evm_msp", 7, NULL,
> +						7, GPIO_ACTIVE_LOW),
> +				{ },
> +			},
> +		};

Horrible.

Can this (and the table above) be placed somewhere else and simply
referenced from here?  Tables are usually placed globally at the top
of the file to prevent this kind of formatting craziness from
appearing inside functions.

> +		gpiod_add_lookup_table(&evm_leds_gpio_table);
>  
>  		/* NOTE:  these are the only fully programmable LEDs
>  		 * on the board, since GPIO-61/ds22 (and many signals

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
