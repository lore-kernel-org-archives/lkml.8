Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AB1C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FF602074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="omtXSDk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgGPIzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgGPIzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:55:45 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B053BC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 01:55:44 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q4so6306994lji.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 01:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7M6LSSf0rVr+K5b96y/UgiYQSV5TowURquOXTDyM6o=;
        b=omtXSDk8Er1sr32hkwdG2nNFrUrAK7qFYNj6XlTfU8J9JAHiMCTKCP85i1M564oJcz
         LwP3aV8uokshIL+8No+TG/oBSVb9F+srTh/pD0Dduk0NcRblFbcuWWzQ48LdKqAgrw0s
         dZNa8VX92IC4UwnUtyz4G7GPkVifjb3uYS7DGIGgTii8vURWYQiyYkmMOwymUwaPogHr
         4Lxe2YzF2HXAWJSwTVyUv7u+AZJCCPocO9V0g9dM4uwglrTTvQwev/Ug6I7Ns00+JqQL
         26QBMaPwWd5i1aZ1RWqZpYOPqiHYAmPPBVL5KLPdGZBmzVgiqYcJw8MplXP442zvEZZe
         j7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7M6LSSf0rVr+K5b96y/UgiYQSV5TowURquOXTDyM6o=;
        b=LcWp7wCMJBuiI/rDU1BdU0WRl3gIhf5UFYsBrmAG1HOZTs33rBcTjSuZETU/Ts7WLR
         qT5HWlFTlmNI/XQvnvnaZnt5c3Lb8EirwrR1MiiSpP+vaze8XWVO77snZLI3XvYwmgUF
         id5NFaFICTBbL3RcQRjElWMhJUlIgGJFmba4iKIuj8jZ0CkA95f0qWMYLIcg1/1iwtin
         ogIwn3V6TAZprOCXS0/KXbuUY37sbIl0F7+9KOyP7OpuFFuWRKzPkjIAkygzmv6kXyHU
         fKaIHmXaUMKh09PCDosvxe6bRCRZHorI63dwSFMKieN1rDcRYjUhJ9ormS90334gqxro
         yTYw==
X-Gm-Message-State: AOAM532famReOEgJZhKYSWhwcCmAwXwYREG98sU6/PdaoMFDd8QE1g1k
        Q4OUNIhoT6/nKrEmqoTzLyVUcqbIr6MtvLwPjIfmGw==
X-Google-Smtp-Source: ABdhPJx1YAsYA09tD3IivtrjldooNtMmVTSRsu2IDcup6l4pXNo9MjDeGkcmelNvwLuv1u6BQRXBxGIZIg+PMLtBIc8=
X-Received: by 2002:a2e:9a4d:: with SMTP id k13mr1574766ljj.283.1594889743096;
 Thu, 16 Jul 2020 01:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200709171203.12950-1-digetx@gmail.com> <20200709171203.12950-6-digetx@gmail.com>
In-Reply-To: <20200709171203.12950-6-digetx@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Jul 2020 10:55:31 +0200
Message-ID: <CACRpkdbPNRoPGc4UCRZqhE52336d_LxT19A5y2oHK+hW-vn2ng@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] gpio: max77620: Use irqchip template
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-tegra@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 7:12 PM Dmitry Osipenko <digetx@gmail.com> wrote:

> +       mgpio->gpio_chip.irq.chip = &max77620_gpio_irqchip;
> +       mgpio->gpio_chip.irq.default_type = IRQ_TYPE_NONE;
> +       mgpio->gpio_chip.irq.handler = handle_edge_irq;
> +       mgpio->gpio_chip.irq.threaded = true;

And I didn't even realize one could do this.

> -       gpiochip_irqchip_add_nested(&mgpio->gpio_chip, &max77620_gpio_irqchip,
> -                                   0, handle_edge_irq, IRQ_TYPE_NONE);
> -
(...)
> -       gpiochip_set_nested_irqchip(&mgpio->gpio_chip, &max77620_gpio_irqchip,
> -                                   gpio_irq);

And get rid of these two.

I suppose I can just do the same for the remaining users of
gpiochip_irqchip_add_nested() and gpiochip_set_nested_irqchip()
and get rid of these two functions altogether!

Yours,
Linus Walleij
