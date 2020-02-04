Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F2EC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6831421582
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lE90fGNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgBDKN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 05:13:57 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33504 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgBDKN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 05:13:57 -0500
Received: by mail-qk1-f194.google.com with SMTP id h4so6460707qkm.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 02:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/OmUGIvaQb9Uv8wXS+U/nOoZbtIeQjrWvcPoE8LQKys=;
        b=lE90fGNeNZlYffihiymjp+CIVPE140qXhzVNDlD4CY96NdUDGVla63HH1RTMeVSPOt
         zdGxZy2fYPolO84vJF4pkzKp6qFU8ePFuemyyhHq0eBXtFQTXw3va7tniDmy6WRySrnk
         /J2Ll36rovMpTkJamgbEMjqyR5vjeh2N+tQU3xiMqtqZW68LLdOm/bQSax4VsVuflzxc
         JstrrJqs3ajDW2A4Cwq/73VhrU0SvZyrdxiY9sk+EZhcCd54XkddB8ODe5g5ohcf3SRm
         7N/e2uBo7CAT6b0TGfOIBJ7zjZeS86AKmwyh3FE2V1Q6dRe/XL0GJYqrdG16wiRUpidx
         T8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/OmUGIvaQb9Uv8wXS+U/nOoZbtIeQjrWvcPoE8LQKys=;
        b=fQ3MtRMwUAIcEw8i82w6+CemFRSdYitASE/6dOuuuCKBJHF7hReuDf/NIPJyMCQCab
         O4OhzFAUNcmUrDzxNrlZelSazaxDI19uI7gi20NZY1xcQQSc89dndrjH0S6Bcxb4MgT8
         MO+cXySEerb1w+rNKhggcsor+mAI6EsJzkkhtkOjNu21+qcIjfuljDMOtqyISTNvCv8r
         FMEqM4P62aA2U4swlA1se7LgmbfrmGMPvQJ1HJAf4QEpts3/wmeHviATeUi0aIKH0Pvh
         Z5gJkn2aBu5dis1bhsQoygUVYud8+YlLFoerukjp30QvV2ojzfjc3Nn8dxKJYx0ZOfQf
         8CWg==
X-Gm-Message-State: APjAAAWVSRXkWPxPWtdL8FddEhHnm9ht2a3zvPS8bpsYeZxhZs8HN4iE
        iIj8x/Yfhztv6HwxkCiTwf7QJT6ckeKC3tupQ3o4iQ==
X-Google-Smtp-Source: APXvYqxusDUOGf7EAio/6WaiWOL3Jwf0uUKX6apnrP03VDouhia9JSFw1LetFwos8sSaTee5LhWyUxO1JiXRmzVyW1g=
X-Received: by 2002:a05:620a:11ba:: with SMTP id c26mr27339140qkk.323.1580811235278;
 Tue, 04 Feb 2020 02:13:55 -0800 (PST)
MIME-Version: 1.0
References: <20200128210845.332679-1-lkundrak@v3.sk>
In-Reply-To: <20200128210845.332679-1-lkundrak@v3.sk>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 4 Feb 2020 11:13:44 +0100
Message-ID: <CAMpxmJUPcackGYLfX83TT1V9x2=iHgnw3cZ=KufuHn9FeKOn_A@mail.gmail.com>
Subject: Re: [PATCH] gpio: pxa: Avoid a warning when gpio0 and gpio1 IRQS are
 not there
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 28 sty 2020 o 22:08 Lubomir Rintel <lkundrak@v3.sk> napisa=C5=82(a):
>
> Not all platforms use those. Let's use
> platform_get_irq_byname_optional() instead platform_get_irq_byname() so
> that we avoid a useless warning:
>
>   [    1.359455] pxa-gpio d4019000.gpio: IRQ gpio0 not found
>   [    1.359583] pxa-gpio d4019000.gpio: IRQ gpio1 not found
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/gpio/gpio-pxa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
> index 9888b62f37afb..567742d962aef 100644
> --- a/drivers/gpio/gpio-pxa.c
> +++ b/drivers/gpio/gpio-pxa.c
> @@ -652,8 +652,8 @@ static int pxa_gpio_probe(struct platform_device *pde=
v)
>         if (!pchip->irqdomain)
>                 return -ENOMEM;
>
> -       irq0 =3D platform_get_irq_byname(pdev, "gpio0");
> -       irq1 =3D platform_get_irq_byname(pdev, "gpio1");
> +       irq0 =3D platform_get_irq_byname_optional(pdev, "gpio0");
> +       irq1 =3D platform_get_irq_byname_optional(pdev, "gpio1");
>         irq_mux =3D platform_get_irq_byname(pdev, "gpio_mux");
>         if ((irq0 > 0 && irq1 <=3D 0) || (irq0 <=3D 0 && irq1 > 0)
>                 || (irq_mux <=3D 0))
> --
> 2.24.1
>

Patch applied. Thanks!

Bartosz
