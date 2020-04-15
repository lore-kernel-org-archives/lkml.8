Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D02C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B47072074F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yIAMMnZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408831AbgDOKkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408571AbgDOKis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:38:48 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA26C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 03:38:48 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id d17so11595261wrg.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 03:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IrPL0bBBQDeF29Z4aLgq8ImOYXP6kd9vk4rNs7ZTqws=;
        b=yIAMMnZu4/5XkjVkCq32hl9Pn9SikmiyUmlKUEu7u/JAwTn5UxxsMyK4Mz2TFYtBJK
         8bK9XO32DspPZRUWcNCWbt434F5d59Z8Gp6+JI7VNiygAxfdd+dK18ew602ZlIrASmTB
         f+O8iv9zsJpKyROuS7I6KJHsds1z/or0RLiYq85eCFBcyejyW54bjjsycwzLwCGj81jO
         M5mgoA6CFO2R78EETs8ZwxWQ497GCVAIWtench+iCvLlMVYhQVf+KEUmYIFf/OsCqb7E
         u+lhG72eBlNLj5HqiKBPiX6FLhcupVCkG3ru861qNkNNR30/I6gDKk8HUXt2PeCOnnOi
         NGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IrPL0bBBQDeF29Z4aLgq8ImOYXP6kd9vk4rNs7ZTqws=;
        b=n03Bpvh/KjbWLtXTD4k+nWTaBvmr12BYdPycUB5z9n4zY/AOA0imI5xGCzBYX2ZD6o
         sD+9YMNcKB7NSB4eTgL90nOUuUb3Zq0kTBYoCRp3yTBnuInPdm8XMNPDSL27Jh9g2uQR
         9wDSeOpiyWrsRmzd31c9CxPNJbqtn2Ugofed7YRW30jfeCF6/SSKRWdJfbcf8Tvd7Nlz
         0cYnLINJu+CVMA0hI6wPlPUoI2t1Q6cvUJb2bN3oHBCdhcN6CV8T3S6vrNteMdp67JO9
         1eTHUF4n+bjkZUdBUA6v17TMrJqfFXMpOrLSuE6cx21MIA3sMAd0EG5vOfxl7EvCQu01
         ukyA==
X-Gm-Message-State: AGi0PuY2vsvvfUfxzB1/0FCd3xHXuMtwRdUxsmJ+DaE8opbL1tiJQwHu
        1objFcdYYl4SCivbfkW0sJI9fg==
X-Google-Smtp-Source: APiQypJfhW8S65Wxra9t0NaoxN8IlVd9vyp0bk8pl+XOImR8b/3RISiU1lKFKzoqVOuvy3de4k5SGA==
X-Received: by 2002:adf:e54c:: with SMTP id z12mr17403476wrm.276.1586947126830;
        Wed, 15 Apr 2020 03:38:46 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id z15sm10599204wrs.47.2020.04.15.03.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 03:38:46 -0700 (PDT)
Date:   Wed, 15 Apr 2020 11:38:44 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] video: backlight: tosa_lcd: convert to use
 i2c_new_client_device()
Message-ID: <20200415103844.vnjccybvy5wtnrq6@holly.lan>
References: <20200326210959.13111-1-wsa+renesas@sang-engineering.com>
 <20200326210959.13111-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326210959.13111-2-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 10:09:59PM +0100, Wolfram Sang wrote:
> Move away from the deprecated API and return the shiny new ERRPTR where
> useful.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/tosa_lcd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/tosa_lcd.c b/drivers/video/backlight/tosa_lcd.c
> index e8ab583e5098..113116d3585c 100644
> --- a/drivers/video/backlight/tosa_lcd.c
> +++ b/drivers/video/backlight/tosa_lcd.c
> @@ -107,7 +107,7 @@ static void tosa_lcd_tg_on(struct tosa_lcd_data *data)
>  	/* TG LCD GVSS */
>  	tosa_tg_send(spi, TG_PINICTL, 0x0);
>  
> -	if (!data->i2c) {
> +	if (IS_ERR_OR_NULL(data->i2c)) {
>  		/*
>  		 * after the pannel is powered up the first time,
>  		 * we can access the i2c bus so probe for the DAC
> @@ -119,7 +119,7 @@ static void tosa_lcd_tg_on(struct tosa_lcd_data *data)
>  			.addr	= DAC_BASE,
>  			.platform_data = data->spi,
>  		};
> -		data->i2c = i2c_new_device(adap, &info);
> +		data->i2c = i2c_new_client_device(adap, &info);
>  	}
>  }
>  
> -- 
> 2.20.1
> 
