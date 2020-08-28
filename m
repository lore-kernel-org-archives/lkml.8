Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A82C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 18:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89AE92098B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 18:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dqqps0/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgH1SRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 14:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgH1SR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 14:17:29 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84FBC06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 11:17:26 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id j25so327564ejk.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 11:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x4Tkx5cvTIZX2IKIPG2Xun4vWEN6aBBz7OiP1w4AdpE=;
        b=dqqps0/Ht78gHt72hdwH44ctuWKIh0vfLimwd8lmZDLDhybUKNTwcHIrsVXX4g6NpM
         hmeTQJWVVkcdLJzNNryqU6eQIqBorKRjXReEoEqjH0cUbZfs27clSs0vPprnDmwCTKCG
         NJfoyggS/2btQJbU3OWTRQqP86VZwwpBUoWmyaF681lObsE9LJhPtcxc/VVhg2oTBK2G
         VELw6QmLXvaA7ApYO15N/5jhFZYTJdaKh/dRChfEvhYtnVrbaoxAdTLB8MH0SQQWnYXr
         CvV7MDtfeNfu9Ee1N/v5VZ+sMUiC5/tOjijtDtj76/mmEnRDsbOkMaMcm19mVEPkJ7Dd
         DGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x4Tkx5cvTIZX2IKIPG2Xun4vWEN6aBBz7OiP1w4AdpE=;
        b=V4V6KAViG3VsVLdUwDbzc/Q8RstMODlDCcJM0WjzyBS/HLz0HDjQvV1bfJKWae5EuK
         dkVIOR1889o7gtHbxJZrUfPCYGpmH70cNc/om+SBQ2sN0YAALh2olNlP/hbD2ZL8GaCu
         dLDRU0QJphcKt94I4xMdGs0ocR8OduKq7Fo3E+2jC/5nUENNO9NnS70diYHtJgsaW4yt
         i8HL7HJ3ec4Nexi1EuxJWjwypSaEPkMNwxGsvfuqhp9gcABqER1oft9SVSofhRZyfJdY
         mRE1T6KzY/JpXyk831QNpWq3X0AJfHZhd8FqfjCqJteArge9SMAT6oT+RhnczpG5hc46
         b0Zg==
X-Gm-Message-State: AOAM532Go4AvcHbc3r2ieDEhd9X3JLQmpSvs+hXrNl+im3QgTNn+/abG
        I7O7LiC5VRFFlVXa98HS/KWw8ehPpgGlCqAVYH/kvw==
X-Google-Smtp-Source: ABdhPJwimNyQ/vmnIbLQ7RMLnx5UNXL4atJarDdIdwe+1NmMbYKqcl3QjEyT4WW1CDJUei4LJtKw9jcLLDu5k7e5dSw=
X-Received: by 2002:a17:906:d8ca:: with SMTP id re10mr3133999ejb.382.1598638645348;
 Fri, 28 Aug 2020 11:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200827200827.26462-1-krzk@kernel.org>
In-Reply-To: <20200827200827.26462-1-krzk@kernel.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 28 Aug 2020 20:17:14 +0200
Message-ID: <CAMpxmJXbjJMgiTgpWokfeeuXjd-tuns8kq1T+Q+qwcxXvums_g@mail.gmail.com>
Subject: Re: [PATCH 1/6] gpio: bcm-kona: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ray Jui <rjui@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, Keerthy <j-keerthy@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 10:08 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/gpio/gpio-bcm-kona.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
> index cf3687a7925f..1e6b427f2c4a 100644
> --- a/drivers/gpio/gpio-bcm-kona.c
> +++ b/drivers/gpio/gpio-bcm-kona.c
> @@ -590,10 +590,7 @@ static int bcm_kona_gpio_probe(struct platform_device *pdev)
>                 dev_err(dev, "Couldn't determine # GPIO banks\n");
>                 return -ENOENT;
>         } else if (ret < 0) {
> -               if (ret != -EPROBE_DEFER)
> -                       dev_err(dev, "Couldn't determine GPIO banks: (%pe)\n",
> -                               ERR_PTR(ret));
> -               return ret;
> +               return dev_err_probe(dev, ret, "Couldn't determine GPIO banks\n");
>         }
>         kona_gpio->num_bank = ret;
>
> --
> 2.17.1
>

Queued the entire series with all the tags, thanks!

Bartosz
