Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00780C2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBBCB20768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TiFg00+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896939AbgDOLZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896922AbgDOLYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:24:06 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D19C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 04:24:03 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id l13so10084675qtr.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 04:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wOmETXgpnR0UiiTfkrMXsqOFBsXGlBK6YD0CLMuo+FM=;
        b=TiFg00+LOB+J3ECZHXf1hg6toq17QIQNzCBw5JV2NofPJ4885HzqlLS011N8RRjqry
         JHrm5gPSFF43Kf55r43lWDgtWNHGhz9ongDMeQzmAitEb5B50AVgeeJwZveyL8rTyHH8
         GHmnSqOgREGSdTq1E+fj8JqySTyiyxhUvKuxDn5T0sBne4FdayoiEvawk3KmttWfTNq6
         CxxY5tgKjqBw/x2S6ihccX8mwsEheruVwN57zisJ+krwhxnKKLnECu/MHxFf9r8D4iAB
         RXpEAa5k7KSEyE4W4CnbwLmkccYFkHGzGgNa2FY9e6UCHHBwqve49mz1yGxapotc1APH
         3YpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wOmETXgpnR0UiiTfkrMXsqOFBsXGlBK6YD0CLMuo+FM=;
        b=YG9dKJJ58NcxRKkgtb8/l02TFWSsz0ZdRPsFeCNfSwmoiRmqlHfNIGpdlHnbdhTrBw
         fVAtvTiu9vel6Qx0OQelsjey3/3+u2ZdSPVkL6IMS46cpkWjFZowggo3grIK+sFLxRZR
         JP5W5fNogYlqRleQ0w0xEmzZYDpSBFvjZfdkAer6375+DynRxEfDTmmMh7HcVOIJwPXi
         y8zVZ6kMb+fiuq6JRRAM8ZJ67mi6mqfdB/ViB92t9j0mIxcy5NlrC8LNq/WA/Qa5E+zp
         p6BLWAFL8Ek9amZs1gc7SI7dFFkrlTmYL3o5It+Nw73xHn0OCpBJalJx5CjtN2DGMUHx
         yqdQ==
X-Gm-Message-State: AGi0PubQ1SSpmq23FFH6atWJGSuIS0asObYw5FM7sVJtpfLqnSEmDh46
        TgYKDZ9T4H6tZ1Y3Zox2zlwZC5SnUljXdZaBpBBNig==
X-Google-Smtp-Source: APiQypKw5qKWyWpvpifJcGdPqJqI988H/LRkhuc2ciFW8lVP5XCznLWbP0ZtwGPp5jnBySczmuJgdev5KDtZyuuRKJo=
X-Received: by 2002:ac8:5209:: with SMTP id r9mr2900056qtn.57.1586949843116;
 Wed, 15 Apr 2020 04:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200412013352.674506-1-aford173@gmail.com> <20200412013352.674506-2-aford173@gmail.com>
In-Reply-To: <20200412013352.674506-2-aford173@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 15 Apr 2020 13:23:52 +0200
Message-ID: <CAMpxmJU0sSDPTa-YHTEsYCzX3Vpv5YJAKhOhfhf73_rbL4jYSg@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: pca953x: Fix pca953x_gpio_set_config
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>, aford@beaconembedded.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niedz., 12 kwi 2020 o 03:34 Adam Ford <aford173@gmail.com> napisa=C5=82(a):
>
> pca953x_gpio_set_config is setup to support pull-up/down
> bias.  Currently the driver uses a variable called 'config' to
> determine which options to use.  Unfortunately, this is incorrect.
>
> This patch uses function pinconf_to_config_param(config), which
> converts this 'config' parameter back to pinconfig to determine
> which option to use.
>
> Fixes: 15add06841a3 ("gpio: pca953x: add ->set_config implementation")
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
>
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index 5638b4e5355f..4269ea9a817e 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -531,7 +531,7 @@ static int pca953x_gpio_set_config(struct gpio_chip *=
gc, unsigned int offset,
>  {
>         struct pca953x_chip *chip =3D gpiochip_get_data(gc);
>
> -       switch (config) {
> +       switch (pinconf_to_config_param(config)) {
>         case PIN_CONFIG_BIAS_PULL_UP:
>         case PIN_CONFIG_BIAS_PULL_DOWN:
>                 return pca953x_gpio_set_pull_up_down(chip, offset, config=
);
> --
> 2.25.1
>

Patch applied for fixes, thanks!

Bart
