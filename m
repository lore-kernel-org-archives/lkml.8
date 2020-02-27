Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB58C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3102624692
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgB0Ngl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:36:41 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42482 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgB0Ngl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:36:41 -0500
Received: by mail-oi1-f193.google.com with SMTP id l12so1945799oil.9;
        Thu, 27 Feb 2020 05:36:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MgPO7ELVuWGwpya2a5yhCTpGcfN6PfsNmhRsLtt669A=;
        b=C1UoMFUDjujRiXfszX/o3PFyFEK8I0mbFj07guffDUyBkInGF97ukKNki+2hOz6V/n
         07YiX10iOanpiqpD9VIoPF7N+gZFNcwlotUIk/Woi1ckxtwNUTUlFDOJa/xOIelDDyLm
         3eg8NDruVq4LS4zm3xv0X5p9iXCoRLkeJP0XY+Ip1Gc2omlY1guh9G9Gyxd14efAQp7o
         RwxEB72d57ozZ5QzNubZiBCbvqMISRccKkNcDkxbZyQdW8jj/A+/W/J0tuu+ZKBIh6oy
         nhsoDo7JHthZT8Pe8GrE8WhCbtD9vB2Hhc81D7CKuzGHX5E350ZUJLj6EN8yHn0iYmXl
         7vCQ==
X-Gm-Message-State: APjAAAWW7tN2i/bXZ5xdW2d21AXh+id9it/kZ1RRON94Ip5w96hW97OD
        xp+Xue6t2JKRJwWxUDh1G/BQVriPK/0qomZk3Iw=
X-Google-Smtp-Source: APXvYqzIYnQiYyviv4vxEN0xt3PJIW3ungOh7jqD4M4TFya2yAyor+8r40KHsX2LrN6OlxEwrnEvFwy6FGg4JA5Qe48=
X-Received: by 2002:aca:1a06:: with SMTP id a6mr3143012oia.148.1582810600115;
 Thu, 27 Feb 2020 05:36:40 -0800 (PST)
MIME-Version: 1.0
References: <68219a85-295d-7b7c-9658-c3045bbcbaeb@free.fr> <e88ca46a-799d-9c86-f2d2-6284eb3c3419@free.fr>
In-Reply-To: <e88ca46a-799d-9c86-f2d2-6284eb3c3419@free.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Feb 2020 14:36:29 +0100
Message-ID: <CAMuHMdUZfR6pYG-hourZCKT-jhh1t+x-ySF4JnEPJjscGAQT+A@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/2] clk: Use devm_add in managed functions
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Thanks for your patch!

On Wed, Feb 26, 2020 at 4:55 PM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
> Using the helper produces simpler code, and smaller object size.
> E.g. with gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu:
>
>     text           data     bss     dec     hex filename
> -   1708             80       0    1788     6fc drivers/clk/clk-devres.o
> +   1524             80       0    1604     644 drivers/clk/clk-devres.o

And the size reduction could have been even more ;-)

> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

> --- a/drivers/clk/clk-devres.c
> +++ b/drivers/clk/clk-devres.c

> @@ -55,25 +51,17 @@ static void devm_clk_bulk_release(struct device *dev, void *res)
>  static int __devm_clk_bulk_get(struct device *dev, int num_clks,
>                                struct clk_bulk_data *clks, bool optional)
>  {
> -       struct clk_bulk_devres *devres;
>         int ret;
>
> -       devres = devres_alloc(devm_clk_bulk_release,
> -                             sizeof(*devres), GFP_KERNEL);
> -       if (!devres)
> -               return -ENOMEM;
> -
>         if (optional)
>                 ret = clk_bulk_get_optional(dev, num_clks, clks);
>         else
>                 ret = clk_bulk_get(dev, num_clks, clks);
> -       if (!ret) {
> -               devres->clks = clks;
> -               devres->num_clks = num_clks;
> -               devres_add(dev, devres);
> -       } else {
> -               devres_free(devres);
> -       }
> +
> +       if (ret)
> +               return ret;
> +
> +       ret = devm_vadd(dev, my_clk_bulk_put, clk_bulk_args, num_clks, clks);
>
>         return ret;

return devm_vadd(...);

>  }

> @@ -128,30 +109,22 @@ static int devm_clk_match(struct device *dev, void *res, void *data)
>
>  void devm_clk_put(struct device *dev, struct clk *clk)
>  {
> -       int ret;
> -
> -       ret = devres_release(dev, devm_clk_release, devm_clk_match, clk);
> -
> -       WARN_ON(ret);
> +       WARN_ON(devres_release(dev, my_clk_put, devm_clk_match, clk));

Getting rid of "ret" is an unrelated change, which actually increases
kernel size, as the WARN_ON() parameter is stringified for the warning
message.

The rest looks good, so with the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
