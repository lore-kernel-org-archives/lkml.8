Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BD5C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BABE20767
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1SNiRdkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgHaQJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 12:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbgHaQJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:09:04 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4499FC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 09:09:04 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id i26so8901766ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 09:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3gkiXp2WVgUqvT9NZ2v6eDB+0cdEA56aJhzKkAT9IKk=;
        b=1SNiRdkBK7DFUK2L4sxcHmNHZNY4XY88yBYrLxKjl36hv8ABeSoz0Z6JrNhzLnizg/
         EntY8zXhCkjOjUl0Ua1m0UsWnnizVwYXhkHaRNxkuC1LOMgNVpqg0JRoMgbiofipNn3q
         r8XZ5856hxL667wCpu2Ae1vGqSZICQzDCZJ5FJ8zehfSyNnhKiYbu+Ah3WMsFhT8ETar
         +GRjmB32VJLE/qU++bAM8dIw77iHseinlnVhqmGZAZRKYuCtjRmsxsX2sicejnB2YCZT
         /hKkvc0r0+Qr7xR1eVe9/NRNAmuQyZP/Np4ikxLJGz4iUeilCoOmBCQOKmMUB8oesFSS
         qXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3gkiXp2WVgUqvT9NZ2v6eDB+0cdEA56aJhzKkAT9IKk=;
        b=WdmEh2YEtSOLLqkaYYNdoq18UErVlhMq/QlntKzSYGFEevcFEXV0YNLllIy9HcGQqc
         0wCcVd7UM1Rg46QQuKUGN0CrvXyGm/2lTYDt7LiL88l+pFswl95jn53ko5u1efGAHkiS
         PKtLNo61aBpCawKeKpy1Ii6AzpIqkKCxD0POVH9Uc5o+kDXRzUgdI5CLOmcL3LKvRz2V
         /DQGgVTzCBwh/+deNvaMKUyozzQnVpcGsSqlpx8SedsZZUJ2ul7gW1aflT4yxW6CFg9C
         l6g0p5oVIR9OZRPO6TgkjOjwmQHcm8mydZk3mnZYOWC469la0KAFjEcSMXdXpA4nfK/a
         9ybw==
X-Gm-Message-State: AOAM531witnjroSJ1sBmZGPZnAZxkxiRIFBBmuz26lfD3S2MOupeCcYc
        xNEsL0BDhywy/8XorQ74ddh5vXP4gY+DaASFnL5Dig==
X-Google-Smtp-Source: ABdhPJz3N3o2PM4LJEHuSD9Rk/l0WVymKDMS79uJcwBtiM/TMTGPL2YBHUHFw7UKGKU9F/bxpVhgmPVafNhLcDIFfQs=
X-Received: by 2002:a17:906:19db:: with SMTP id h27mr1732665ejd.154.1598890142945;
 Mon, 31 Aug 2020 09:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200831090947.18489-1-zhang.lyra@gmail.com>
In-Reply-To: <20200831090947.18489-1-zhang.lyra@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 31 Aug 2020 18:08:52 +0200
Message-ID: <CAMpxmJUwk9b=O4d6PEX_N39Eft1TEc1X2NQpuERQZWyPhz73-g@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: sprd: Clear interrupt when setting the type as edge
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Taiping Lai <taiping.lai@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 11:10 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Taiping Lai <taiping.lai@unisoc.com>
>
> The raw interrupt status of GPIO maybe set before the interrupt is enabled,
> which would trigger the interrupt event once enabled it from user side.
> This is the case for edge interrupts only. Adding a clear operation when
> setting interrupt type can avoid that.
>
> There're a few considerations for the solution:
> 1) This issue is for edge interrupt only; The interrupts requested by users
>    are IRQ_TYPE_LEVEL_HIGH as default, so clearing interrupt when request
>    is useless.
> 2) The interrupt type can be set to edge when request and following up
>    with clearing it though, but the problem is still there once users set
>    the interrupt type to level trggier.
> 3) We can add a clear operation after each time of setting interrupt
>    enable bit, but it is redundant for level trigger interrupt.
>
> Therefore, the solution is this patch seems the best for now.
>
> Fixes: 9a3821c2bb47 ("gpio: Add GPIO driver for Spreadtrum SC9860 platform")
> Signed-off-by: Taiping Lai <taiping.lai@unisoc.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
> * Changes since v1:
> - Rebased on v5.9-rc1.
> ---
>  drivers/gpio/gpio-sprd.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpio/gpio-sprd.c b/drivers/gpio/gpio-sprd.c
> index d7314d39ab65..36ea8a3bd451 100644
> --- a/drivers/gpio/gpio-sprd.c
> +++ b/drivers/gpio/gpio-sprd.c
> @@ -149,17 +149,20 @@ static int sprd_gpio_irq_set_type(struct irq_data *data,
>                 sprd_gpio_update(chip, offset, SPRD_GPIO_IS, 0);
>                 sprd_gpio_update(chip, offset, SPRD_GPIO_IBE, 0);
>                 sprd_gpio_update(chip, offset, SPRD_GPIO_IEV, 1);
> +               sprd_gpio_update(chip, offset, SPRD_GPIO_IC, 1);
>                 irq_set_handler_locked(data, handle_edge_irq);
>                 break;
>         case IRQ_TYPE_EDGE_FALLING:
>                 sprd_gpio_update(chip, offset, SPRD_GPIO_IS, 0);
>                 sprd_gpio_update(chip, offset, SPRD_GPIO_IBE, 0);
>                 sprd_gpio_update(chip, offset, SPRD_GPIO_IEV, 0);
> +               sprd_gpio_update(chip, offset, SPRD_GPIO_IC, 1);
>                 irq_set_handler_locked(data, handle_edge_irq);
>                 break;
>         case IRQ_TYPE_EDGE_BOTH:
>                 sprd_gpio_update(chip, offset, SPRD_GPIO_IS, 0);
>                 sprd_gpio_update(chip, offset, SPRD_GPIO_IBE, 1);
> +               sprd_gpio_update(chip, offset, SPRD_GPIO_IC, 1);
>                 irq_set_handler_locked(data, handle_edge_irq);
>                 break;
>         case IRQ_TYPE_LEVEL_HIGH:
> --
> 2.20.1
>

Queued for fixes, thanks!

Bartosz
