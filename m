Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC01C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AE0820716
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WYg5PiNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbgFWIuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731691AbgFWIug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:50:36 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A199C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 01:50:36 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e12so3902054qtr.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 01:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y/cIlmiQGFW7vkgx22yAxQ6q0R1TKH8fVp3Z9jLtHCE=;
        b=WYg5PiNkGFNFNcFvVRGdTJteyILQn2nptS9bCOYMnwE+WtWJ007MM1aFQO5500+ZCf
         k7XDFyKgKx4wc55k9QRa5D1IGH+MO2wZujCH0FfNqhPnIIn+Y524vvxGmjWsKiCdNPGl
         gFkZ7Qx0TWQ3lZa89N4Iu0YJ+yEb1t0xAvS94np3zk16yFcxagwGXpPpIphYB+tnQfi9
         VSYvT4mpIxHaJaibpUkPlRDBtR6Plnlb4w5zHz6/Z/4dH2lPohIrTnnfUe1bL081QhED
         Ki8Od93dXAvzZQGRA4gGEL6oks9aSa7YJCZHc02GqNxgrBrC1kcJaGab9HgwUZbpc0wM
         ezUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y/cIlmiQGFW7vkgx22yAxQ6q0R1TKH8fVp3Z9jLtHCE=;
        b=CeR2Nqw6BG9AGWW+lM5E2PMq8pLyHz81LP3g0h0MIQhjK34j/q+V7IQ2ffk2Goo4ln
         lMFdYwrBnJ8w10dTsnJ9P9qiO2lqXKaiAEQ5LAWvvzcQoPFhlHkBmGheV94paekXGSf1
         ozJAxKpphZy7/IuYw5sQ0yDCg6hdThEURzCiTxG7x+d7KyhnyhEsdaEHF5eVnPl5CvD1
         cdQJeTvLSkYa6Xl7D80IxZeirPxUNRJQ15+yMoFcPCw4JGu5Bk+e3xdlE3JlX1luBxEm
         eEhi1d+4IkO8W4sVj8qBKj/xCp2uo80ekelmbujPL7SAGELiHm+jIUtLC64ESO8K0NDd
         WmXg==
X-Gm-Message-State: AOAM530/TMvuiU6C4/4G8eZHPL4R4SgxgP3F+AphWgHbqdbWs+jgNljm
        uKMZEaRJ/eC4T6ABRud+ZRpY5MRbDp9P8SYTMnSjaA==
X-Google-Smtp-Source: ABdhPJw1r9LEA0YmrFF1idC8wdMqocEjVAPAvtCZnLuEUcAdEm/je/CsSdEV+zck3yFnkB/bicE7kTCPgWTMliYEBb8=
X-Received: by 2002:aed:2a75:: with SMTP id k50mr4736033qtf.27.1592902235814;
 Tue, 23 Jun 2020 01:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200605024919.56177-1-navid.emamdoost@gmail.com>
In-Reply-To: <20200605024919.56177-1-navid.emamdoost@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 23 Jun 2020 10:50:24 +0200
Message-ID: <CAMpxmJU3aivxkjpWQDExnnW_AOF4Unefrb6xgF2fqrzaw-hi0w@mail.gmail.com>
Subject: Re: [PATCH] gpio: rcar: handle pm_runtime_get_sync failure case
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        smccaman@umn.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 5 cze 2020 o 04:49 Navid Emamdoost <navid.emamdoost@gmail.com> napisa=
=C5=82(a):
>
> Calling pm_runtime_get_sync increments the counter even in case of
> failure, causing incorrect ref count. Call pm_runtime_put if
> pm_runtime_get_sync fails.
>
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/gpio/gpio-rcar.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
> index 7284473c9fe3..eac1582c70da 100644
> --- a/drivers/gpio/gpio-rcar.c
> +++ b/drivers/gpio/gpio-rcar.c
> @@ -250,8 +250,10 @@ static int gpio_rcar_request(struct gpio_chip *chip,=
 unsigned offset)
>         int error;
>
>         error =3D pm_runtime_get_sync(p->dev);
> -       if (error < 0)
> +       if (error < 0) {
> +               pm_runtime_put(p->dev);
>                 return error;
> +       }
>
>         error =3D pinctrl_gpio_request(chip->base + offset);
>         if (error)
> --
> 2.17.1
>

Hi Navid!

This doesn't apply to current master. I think the previous version got
applied. Could you please rebase?

Bart
