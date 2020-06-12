Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5D5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA9BA20578
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BG27RaLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgFLIA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 04:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgFLIA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 04:00:26 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0E2C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 01:00:25 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e16so6526193qtg.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 01:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xYHnyazKvcx6oiktPL+KRZOzioT3qEIvMI6fjShgXbs=;
        b=BG27RaLl7FuvmC5qU5wo4ULsee1aMeqmd1sslVReRMtYPxsWHNUm5OoERRNwakoEzm
         709bwkfolIi6KCsVjA3qsZO+nCd1OUyh5rZQX8Cji3wYlvwi9hDo/WNQhpQpJIP7QhVl
         x+JF95YyyQuzmDBorBxn5M84Xi/aPS2P3H+/xNBbL2aUhEZQRdMIA+qR28Vo3BoBbOyk
         94YxGuprV2rGTnhMWpNxb2xHOkhGnpb9OCf0nWyUsdBcNUxqji94F+f/KTBazXuUIIwT
         EKFj00jyu7zKFEVrD9fgUw5Hv9w83a2BuC++knBLuhnGBUXg4QIk7Gs2fZitZXhS3r68
         1Zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xYHnyazKvcx6oiktPL+KRZOzioT3qEIvMI6fjShgXbs=;
        b=r5vPIzaAVYsRBUvnklKOHeFck4UlxhFmsVfXzEhMzWqqcR+LkrevyR+cmnrog3TI7E
         DztLaBZg8xC9wYRbRVhYbSS/WAs2yYn1CMllIvlXeUhrdzHbyeIkAMT7X6/Z6LYFUONn
         aJiLb2BHXtspkleC3JOfVPe024T76jT0/g6Ppn6sS3iyaRGP8psIK95zwkLu/njeFbXy
         oAJIJYaj5Uy22ioOCgWrdZqk0Q7OxQE0/vFuCzVhc7rRPXH0lzr3ysgr4p8qyE7GX7nK
         cO1prin/1vi8UqAnABHFGY10vWJTHk90elxqZZvf7oRdK/gcT9uqHRubsimCsaoqlT7e
         dHhA==
X-Gm-Message-State: AOAM533E33QFL1hruGb0cWdvLz8LW5tyOPV8brpHy06o02brhDKQ60cm
        mVnTGCuuaQEpHbepcdXn5rO1DZSJ7yXuaEteA+9UEA==
X-Google-Smtp-Source: ABdhPJwJ3Spmc+G/ols3thU5v7DezP+CeZxDjbS74NAReXP2ceQRu6iqs8rn4ci7iLABCMQCd0ppK3jldKhvR/2HMqo=
X-Received: by 2002:ac8:23fb:: with SMTP id r56mr1812691qtr.197.1591948823593;
 Fri, 12 Jun 2020 01:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200612045034.27425-1-warthog618@gmail.com> <20200612045034.27425-3-warthog618@gmail.com>
In-Reply-To: <20200612045034.27425-3-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 12 Jun 2020 10:00:12 +0200
Message-ID: <CAMpxmJUUd2+1A-3UJF+UOU5PYs33t7E3otYaO9GUTcXAT+VoNQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpiolib: cdev: fix file comment
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 12 cze 2020 o 06:51 Kent Gibson <warthog618@gmail.com> napisa=C5=82(a)=
:
>
> Replace file comment carried over from gpiolib.c with one more
> appropriate for gpiolib-cdev.c.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index 58011ba88a1d..17d5541d76a0 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -25,11 +25,10 @@
>  #include "gpiolib.h"
>  #include "gpiolib-cdev.h"
>
> -/* Implementation infrastructure for GPIO interfaces.
> +/* Character device interface to GPIO.
>   *
> - * The GPIO programming interface allows for inlining speed-critical
> - * get/set operations for common cases, so that access to SOC-integrated
> - * GPIOs can sometimes cost only an instruction or two per bit.
> + * The GPIO character device, /dev/gpiochipN, provides userspace an
> + * interface to gpiolib GPIOs via ioctl()s.
>   */
>
>  /*
> --
> 2.27.0
>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
