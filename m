Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E734C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 17:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721032084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 17:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VeZo7J5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgDKRX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 13:23:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43313 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgDKRX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 13:23:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id i10so5629036wrv.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 10:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=IENUKdV3r4iMlcVFVIzU9k/XHXmK+JhwttMkKQCFE4c=;
        b=VeZo7J5EpZU6R34YGYLNdxUW+AIN582hRgGwmK78/Rx5n0tVA0Ze6C7DprSSd9p3zT
         7GR4+oTJaZO9jDCVu82by5wgBSMk0JlpBOXARKtF16e0uVXbDluZ+mNw7SNMkHE0eUdP
         FuIVHrUDd2CgpZ9FPyc1PsSG3GyXSpT16oIzei/WL72ItzEcbPRL0QYlP0hRXqIAqVZP
         aO1zrFfIiTBhX3pAbndCbUQmJPgqJEC+i6cwX6QlhFvWpGYN81M8XxBw/W/EOWWjwtSe
         gf8Ikkqh9Rw69EmQe/r1zXdVTJmf3PAMHBsRGAI+nlhd7Mb4iSZ+dOSnVXx3buxJX3kj
         xzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=IENUKdV3r4iMlcVFVIzU9k/XHXmK+JhwttMkKQCFE4c=;
        b=RJ/BtifL+wkAXbzTMeSVTmulrZ7RJT3dZku4AWkAoHcRvduLEAupdpgd5pE4h1vplx
         +8gOFgr1DQhexJHD1OUFc3VOHGrVGKushIwIub8GMPC5wZ+AOstObVL21PF7HN403Tu2
         6Mea1BufuBMAVZSStQiSoxAtB6TG63lKOlXrOK2baPUubLqjIXp0B2ecZJvBvLgiGxvR
         wrR/GpMBy4ZPz4JIl3MuL8dI2m2LQu7dLsZ6a1tyEDjrAejL5T3TZ2vLWLK/lJMU8fcu
         dOJmu1p+e5CThf4j13d7rRQfDpxgDL00bAzUd8+djuqCsgAE6I38PaF1VOWScSZ0PaSy
         vu0A==
X-Gm-Message-State: AGi0PubmAb4dNilKsehFr8i1eIys0oQZUd9hdycvqjHpnv18U+JnGfCn
        tkmdE5M8ys2f+KIk8YtcaH+4jQ==
X-Google-Smtp-Source: APiQypL+YF6wgk8qzrfgP6hNRy6A41pZ5shD19zczNqw61/jwZy3zmAllz3iK/CauKCOd9eoiEQu4Q==
X-Received: by 2002:adf:fc92:: with SMTP id g18mr1046596wrr.10.1586625808188;
        Sat, 11 Apr 2020 10:23:28 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id a205sm3621474wmh.29.2020.04.11.10.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 10:23:27 -0700 (PDT)
References: <20200411170356.1578031-1-martin.blumenstingl@googlemail.com> <20200411170356.1578031-3-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v1 2/2] pinctrl: meson: wire up the gpio_chip's set_config callback
In-reply-to: <20200411170356.1578031-3-martin.blumenstingl@googlemail.com>
Date:   Sat, 11 Apr 2020 19:23:26 +0200
Message-ID: <1jlfn2szqp.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat 11 Apr 2020 at 19:03, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Use gpiochip_generic_config for the gpio_chip's set_config callback so
> GPIO flags like GPIO_PULL_UP or GPIO_PULL_DOWN can be used in the board
> .dts descriptions.
> This is required for some Meson8m2 boards where GPIO_BSD_EN provides the
> "MUTE" signal and requires enabling the internal pull-up resistor.

I think your addition makes sense but, FYI, there is another solution to
your problem that should already work as it is.

If the platform requires a pull-up, you could set the pinconf 'bias-pull-up'
property in dt in the pinctrl definition passed to the device using the gpio.

There is an example of that in meson-gx-libretech-pc.dtsi with the phy
irq pin.

>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/pinctrl/meson/pinctrl-meson.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
> index 291f3078e7c7..079f8ee8d353 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson.c
> @@ -603,6 +603,7 @@ static int meson_gpiolib_register(struct meson_pinctrl *pc)
>  	pc->chip.parent = pc->dev;
>  	pc->chip.request = gpiochip_generic_request;
>  	pc->chip.free = gpiochip_generic_free;
> +	pc->chip.set_config = gpiochip_generic_config;
>  	pc->chip.get_direction = meson_gpio_get_direction;
>  	pc->chip.direction_input = meson_gpio_direction_input;
>  	pc->chip.direction_output = meson_gpio_direction_output;

