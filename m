Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439B6C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E7F206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XGNGhjA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgCLNxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:53:54 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:45466 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCLNxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:53:53 -0400
Received: by mail-vk1-f193.google.com with SMTP id b187so1572703vkh.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 06:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z0oD7i3z8pfficOabLv0M/bTEhjkqPaLssJvmDail5A=;
        b=XGNGhjA+oZakkRthns66kwKdYOczWc44o0f6nmIE+9P+JD1xtV+j+TQ50qbdpOUFhG
         LhyT4hVP5il2+IeqDxSWG3oHssnLUdPhb2QGZW4P26TlOhRD8dymgDTCgY9kLLlave67
         EOEDX43dM2gVE2zCergAuIOl9d6MMb/SBnY1ZRDKJ3xBvK2kkm2gb5PWRaQ9DcD4tZg9
         mUpKzlw1XKWk44ePtVeaoBsP0UoJnqd0Z/8JBJxcEOzk0AX8HhkhiiATM9kFWXsKabCF
         y94ZQxJsgmmo5D/l6kACKs5OsdGvQRdauDOU/rKH67wbbDv2bJBjEYejxlWjKvU2Rc5T
         k4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z0oD7i3z8pfficOabLv0M/bTEhjkqPaLssJvmDail5A=;
        b=SLZaouJMsswQkUJueqIFinK4BibzGYT5xmLJXhPzQivczlWMY54Gw2ljfH0rUy31jp
         iPwRz+GpxHPGNg4SZk8Fm2oC1YY5cVN/pygVE0po71tBdoDEtmxeXbsPr0H0UN/B+fJ7
         yCA7Zo8rf7dR+yOmxK9CD2sEOqT9Q1CoZFf1wZLXc82fXqL0l+qr4tTImvvv7b11KEqy
         kHUNL9lZ128Y1G0rzT6gJ99CHWYYQ8ojZ8IXNt4Zgb9cf+nDQJwihoj0dmIwqEPgZYy+
         MQ8Z8q31kyEbKr1VbwsJU3VjdnyBKk6VJ/QMS28QYj/4ZJklSsj4WeQF2V08KoDYy5kI
         /6xg==
X-Gm-Message-State: ANhLgQ2aSULRlWCsZ1lNaZzHN+VpVaSRM2B6TuZv3Wyr2mpIBMCUxjBA
        XHfMe4DaxNp7yWnJ2/lmOMJA2ZkO3A/HTeVoGTmOfw==
X-Google-Smtp-Source: ADFU+vuVL1NOPuHCBM8iDTziNFNqLXKsqy8CqxibQJF49DVt/3ORdnnpWxWaoXsv8YIsobZn/jaqWBgYY3UZvop6j24=
X-Received: by 2002:a1f:2155:: with SMTP id h82mr5372064vkh.46.1584021231500;
 Thu, 12 Mar 2020 06:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200306132448.13917-1-Sergey.Semin@baikalelectronics.ru> <20200306132516.D45DC8030700@mail.baikalelectronics.ru>
In-Reply-To: <20200306132516.D45DC8030700@mail.baikalelectronics.ru>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Mar 2020 14:53:40 +0100
Message-ID: <CACRpkdZxpa6z0zD+vgEV10NLG_CXOvYYr1BSwr_fEDfc_Pxf-w@mail.gmail.com>
Subject: Re: [PATCH 3/4] gpio: dwapb: Use optional-clocks interface for APB ref-clocks
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Hoan Tran <hoan@os.amperecomputing.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

thanks for your patch!

On Fri, Mar 6, 2020 at 2:25 PM <Sergey.Semin@baikalelectronics.ru> wrote:

>         /* Optional bus clock */
> -       gpio->clk = devm_clk_get(&pdev->dev, "bus");
> -       if (!IS_ERR(gpio->clk)) {
> -               err = clk_prepare_enable(gpio->clk);
> -               if (err) {
> -                       dev_info(&pdev->dev, "Cannot enable clock\n");
> -                       return err;
> -               }
> +       gpio->clk = devm_clk_get_optional(&pdev->dev, "bus");
> +       if (IS_ERR(gpio->clk)) {
> +               dev_info(&pdev->dev, "Cannot get APB clock\n");

Turn this into dev_err() while you're at it.

> +       err = clk_prepare_enable(gpio->clk);
> +       if (err) {
> +               dev_info(&pdev->dev, "Cannot enable APB clock\n");

Also this.

With those changes:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
