Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA67C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 07:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC96220700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 07:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ccGT/Qtm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgDXHKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 03:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726008AbgDXHKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 03:10:41 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50F6C09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 00:10:39 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id h6so4213469qvz.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 00:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Lj7aW35DO+M7We9UOI+vkxS0Q1SHiDXk8hCy7w5jTmE=;
        b=ccGT/QtmDoSYhFHcVXKb9or5R6EAyfDThNXzsSHmeDZcTQKBQAmXVdW3eLiVs90rlc
         xUxzkGOTWXPsPLHnvszjnsmw82S4nejPZeApqeuOae8yVuMFGQ+Sve6h2W8TpaekXQIh
         FFTBLOmx6t49YyAFzXeAe1CYKgFL6o9NBASHnJ2jqB8gsOIhnqDdueYadlL7RQOjyJjK
         LqZ9Po9TfYAsfffYMgwmhBRQl9SvQvbAJiNdTrXDD3w6UqmAEIG91vC8aLMoYdbQN/UU
         c6S6el/jFIZgWe0h70Gm15CMh+r80GQ2uQhmdlpR0mpNwC7JuG0VFDQbommVq3FQFf57
         AatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Lj7aW35DO+M7We9UOI+vkxS0Q1SHiDXk8hCy7w5jTmE=;
        b=e72NaEp9yjpFY9k5z9xTPLuRyv/yj7JEDLZgeK/3TwEjeeI5b2ttJmXoO57jnNT185
         nL3QOzl66vdkYgN/E3DVCbj7ScIlzG1lh+aB/rLzIf9nl2N5qbHIbcmi77BDmv+l0Psa
         JOc/GnO0ddKhJugIgPSWX3xuHVxhWL0GPTk2L6Dxt8NWbDSqn/97URlk2d/q89dmyq3z
         IvcOvy5igHq2+gn2+xphh1df641e9KVRLhgIV5zxeP7WqSzhOy4p+G+06fMQ7ljEkWSE
         4cJhzrUcSOuHR420ZfTNvLYP838Kfr5Mwhqwz37X9cSVr1gD5mC1urnnhkr7vrUnGRTY
         Q7UQ==
X-Gm-Message-State: AGi0Pua2e/2rggK4OfLRqk+F2AB1xh9/nBRk7/M7mV7UixooKHmeEYDA
        yvHrt/D/yWsRTwVTqTTmivOJFMM9szYOxJt6uq9itfAx
X-Google-Smtp-Source: APiQypJ/L+JCBo+Y35s94v6igCtkuAj1kEPqwIs9Upb+zp6FE6NVUQhbwJTacAl7UGyj8ZjacqY6iPSLgfZFWurtfJs=
X-Received: by 2002:a0c:d7c8:: with SMTP id g8mr7809466qvj.148.1587712239009;
 Fri, 24 Apr 2020 00:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200423203416.133274-1-swboyd@chromium.org>
In-Reply-To: <20200423203416.133274-1-swboyd@chromium.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 24 Apr 2020 09:10:28 +0200
Message-ID: <CAMpxmJUEnpQjPFJUdSKhOwikPqo6NPqFzJf_eT4ju7212x8O9g@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: devprop: Warn if gpio-line-names is too long
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Alexandru M Stan <amstan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 23 kwi 2020 o 22:34 Stephen Boyd <swboyd@chromium.org> napisa=C5=82(a=
):
>
> Some DT authors (including myself) have messed up the length of
> gpio-line-names and made it longer than it should be. Add a warning here
> so that developers can figure out that they've messed up their DT and
> should fix it.
>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/gpio/gpiolib-devprop.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib-devprop.c b/drivers/gpio/gpiolib-devpro=
p.c
> index 53781b253986..26741032fa9e 100644
> --- a/drivers/gpio/gpiolib-devprop.c
> +++ b/drivers/gpio/gpiolib-devprop.c
> @@ -37,8 +37,11 @@ void devprop_gpiochip_set_names(struct gpio_chip *chip=
,
>         if (count < 0)
>                 return;
>
> -       if (count > gdev->ngpio)
> +       if (count > gdev->ngpio) {
> +               dev_warn(&gdev->dev, "gpio-line-names is length %d but sh=
ould be at most length %d",
> +                        count, gdev->ngpio);
>                 count =3D gdev->ngpio;
> +       }
>
>         names =3D kcalloc(count, sizeof(*names), GFP_KERNEL);
>         if (!names)
> --
> Sent by a computer, using git, on the internet
>

Patch applied, thanks!

Bart
