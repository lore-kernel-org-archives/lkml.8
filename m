Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFF8C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC6E20678
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgAVNdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:33:42 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42352 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVNdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:33:42 -0500
Received: by mail-ot1-f65.google.com with SMTP id 66so6214562otd.9;
        Wed, 22 Jan 2020 05:33:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iXidiK5tVlkQ0oI63DDPIucIlwGG0gDTXW/wsHE+cj0=;
        b=tUkZompYJI0QfzRh01GeuX4fg4drT4TJ65VKwEZ5C9Eqy2r5ZrQ9x0kbXajoY4w9no
         ouQY2lRCDe+dnZCEam4m3JiilcY5ZjCWa3HK11Hw/A89gsWUEgcOv+k3ZwHqBJuln4FL
         HEZ3ICMW/Rg0w3GARWYGjEoIlh3zAXSA2Z2e3dASMn9bpM2IkztmaGmUvC5k3BtJElCy
         ArjJuEjK5JbFqNfQmqB8mxg/CmB1oXyat2SmN98lDztmyNruDfMPe2xE9/YPYAlgx3vT
         MRdrB5+aP52Qdo8IhUE6Qo0sYLQsGqs7DPuxVD2l/eWj322mav8fR6AjchHzz//216YX
         JJ0A==
X-Gm-Message-State: APjAAAXKCsxzZe2TV+vcTtWNVQXaZjckPSRUYDlQW4FQO7IZqpwTN6TX
        vtxRMfa7624VvDS5nUVWL3twLVeB7kDMPS3vims=
X-Google-Smtp-Source: APXvYqx2WT9miCyQl2CICz4pB+JoTuMEVCoWq80VHJk6RfrccdbBL+sY24/JFlOCh65kdCawS95nHFz2cNnZQK/pJZ4=
X-Received: by 2002:a9d:7984:: with SMTP id h4mr7504494otm.297.1579700021124;
 Wed, 22 Jan 2020 05:33:41 -0800 (PST)
MIME-Version: 1.0
References: <56c7b6d5-1248-15bd-8441-5d80557455b3@free.fr>
In-Reply-To: <56c7b6d5-1248-15bd-8441-5d80557455b3@free.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Jan 2020 14:33:29 +0100
Message-ID: <CAMuHMdX3kZoEfCeGamreeWq0-Tu2+Mw8MYEbRUZV8wBS+e2K=A@mail.gmail.com>
Subject: Re: [RFC PATCH v2] clk: Use a new helper in managed functions
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Wed, Jan 22, 2020 at 2:02 PM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
> Introduce devm_add() to factorize devres_alloc/devres_add calls.
>
> Using that helper produces simpler code and smaller object size:
>
> 1 file changed, 27 insertions(+), 66 deletions(-)
>
>     text           data     bss     dec     hex filename
> -   1708             80       0    1788     6fc drivers/clk/clk-devres.o
> +   1508             80       0    1588     634 drivers/clk/clk-devres.o
>
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Thanks for your patch!

> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -685,6 +685,20 @@ int devres_release_group(struct device *dev, void *id)
>  }
>  EXPORT_SYMBOL_GPL(devres_release_group);
>
> +void *devm_add(struct device *dev, dr_release_t func, void *arg, size_t size)

I there any advantage of using dr_release_t over "void (*action)(void *)",
like devm_add_action() does?  The latter lacks the "device *" parameter.

> +{
> +       void *data = devres_alloc(func, size, GFP_KERNEL);
> +
> +       if (data) {
> +               memcpy(data, arg, size);
> +               devres_add(dev, data);
> +       } else
> +               func(dev, arg);

Both branchs should use { ...}

> +
> +       return data;

Why return data or NULL, instead of 0 or -Efoo, like devm_add_action()?

> +}
> +EXPORT_SYMBOL_GPL(devm_add);
> +
>  /*
>   * Custom devres actions allow inserting a simple function call
>   * into the teadown sequence.
> diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
> index be160764911b..582fda9ad6a6 100644
> --- a/drivers/clk/clk-devres.c
> +++ b/drivers/clk/clk-devres.c

> @@ -33,10 +25,7 @@ struct clk *devm_clk_get_optional(struct device *dev, const char *id)
>  {
>         struct clk *clk = devm_clk_get(dev, id);
>
> -       if (clk == ERR_PTR(-ENOENT))
> -               return NULL;
> -
> -       return clk;
> +       return clk == ERR_PTR(-ENOENT) ? NULL : clk;

Unrelated change (which is less readable than the original, IMHO).

>  }
>  EXPORT_SYMBOL(devm_clk_get_optional);
>
> @@ -45,7 +34,7 @@ struct clk_bulk_devres {
>         int num_clks;
>  };
>
> -static void devm_clk_bulk_release(struct device *dev, void *res)
> +static void wrap_clk_bulk_put(struct device *dev, void *res)
>  {
>         struct clk_bulk_devres *devres = res;
>
> @@ -55,25 +44,17 @@ static void devm_clk_bulk_release(struct device *dev, void *res)
>  static int __devm_clk_bulk_get(struct device *dev, int num_clks,
>                                struct clk_bulk_data *clks, bool optional)
>  {
> -       struct clk_bulk_devres *devres;
>         int ret;
> -
> -       devres = devres_alloc(devm_clk_bulk_release,
> -                             sizeof(*devres), GFP_KERNEL);
> -       if (!devres)
> -               return -ENOMEM;
> +       struct clk_bulk_devres arg = { clks, num_clks };
>
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
> +       if (!ret)
> +               if (!devm_add(dev, wrap_clk_bulk_put, &arg, sizeof(arg)))
> +                       ret = -ENOMEM;

Nested ifs are easier to read when the outer one uses curly braces:

        if (!ret) {
                if (!devm_add(dev, wrap_clk_bulk_put, &arg, sizeof(arg)))
                        ret = -ENOMEM;
        }

Or merge the condition with &&.

>
>         return ret;

But in this case, I would write it as:

        if (ret)
                return ret;

        if (!devm_add(dev, wrap_clk_bulk_put, &arg, sizeof(arg)))
                return -ENOMEM;

        return 0;

(+ consider devm_add() returning the error code instead, cfr. above).

BTW, I'm still wondering if the varargs macro discussed on #armlinux would
help.  I.e.

    devm_add(dev, wrap_clk_bulk_put, struct clk_bulk_devres, clks, num_clks)

would create and populate the temporary arg variable.

That would require defining an argument struct for the use in devm_clk_get(),
though.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
