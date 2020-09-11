Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E9DC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 01:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 019A4208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 01:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="g/xBwSJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgIKBaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 21:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgIKB3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 21:29:54 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30120C061573;
        Thu, 10 Sep 2020 18:29:54 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id i22so11552123eja.5;
        Thu, 10 Sep 2020 18:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=860n4mA4fmJK3TLitsnsdM8NiH0WMh9mXhf4kfpUrRo=;
        b=g/xBwSJU06VikgstPsQ1YqbACqhwY192BUXwzJOgEb4ovVDqO5QgA3qT6GtnhD6Z9U
         FYzvrh2J8cidKYXpj5yrtYiMFxU0xmqYPtN9SAifwScIbaMvwQsHcz/ve9qUZRs4RPfJ
         fuwelwr2CHHJkNkYTltxlvYj0J8yx1RgCP0QI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=860n4mA4fmJK3TLitsnsdM8NiH0WMh9mXhf4kfpUrRo=;
        b=SIuqoLc7oy0Qz84l/1A+I9+EGS7wEPJEz5YeXE9I9xCWUK6PeHO7Xff3S8w68u66hF
         1xvwZSY+dP5cqEMPZFvMLcyiWlXjRsxTcrbDCrrNREhMoe+hV6mSrthl6fgpALA9LgGe
         H6NC0KKna42vj5+to+vduOeIXzERCKgotV3OaulRoFA0mXnhMxGxaFlsOW0XKR49tS7H
         F/VZmqeGo0s9AMgnD2iYZDgzHZGUcgTxpgFLNzohCxUYYfigKGyDMBDh44GTW6wGLvz6
         yFbXstHhaj/YC8B5vXYTaSrs/73HJdCYVW99Flp/nWK2t2Kkhk9+8slmtvCkkWfGYe4y
         cW1Q==
X-Gm-Message-State: AOAM533+NqYemK6w/ICEusFI9LzM+EPVUyWw4rsigGgMZZooqkfia5o3
        lz85TadgjYnSM9TDC+voS7aCEFASgLEbjMzxBnXqKKghP4U=
X-Google-Smtp-Source: ABdhPJxtk93q54imzDYqdNnaTmNsoq2rU9SDK7jsU/QO73FI+kg85gEVj7kt1TOL1ggmmakC57Q8tt15oZxNW8GZKrc=
X-Received: by 2002:a17:906:7cc6:: with SMTP id h6mr11767561ejp.266.1599787792657;
 Thu, 10 Sep 2020 18:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200910151840.25333-1-eajames@linux.ibm.com> <20200910151840.25333-3-eajames@linux.ibm.com>
In-Reply-To: <20200910151840.25333-3-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 11 Sep 2020 01:29:40 +0000
Message-ID: <CACPK8XeMcf3B+5gt-d=+4dbNindiAHA4XjVdtOOcpU3Fr0191Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] clk: ast2600: Add functionality to the APLL clock
To:     Eddie James <eajames@linux.ibm.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        linux-fsi@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Alistair Popple <alistair@popple.id.au>,
        Jeremy Kerr <jk@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan,

This change adds support for setting the A-PLL in the 2600 so we can
control the FSI frequency. Can your team please review it? If it is
okay please reply with your Reviewed-by.


On Thu, 10 Sep 2020 at 15:18, Eddie James <eajames@linux.ibm.com> wrote:
>
> Register a clock with it's own operations to describe the APLL on
> the AST2600. The clock is controlled by an SCU register containing
> a multiplier and divider of the 25MHz input clock.
> The functionality to change the APLL is necessary to finely control
> the FSI bus frequency.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/clk/clk-ast2600.c | 177 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 165 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
> index 177368cac6dd..a147dffbaccc 100644
> --- a/drivers/clk/clk-ast2600.c
> +++ b/drivers/clk/clk-ast2600.c
> @@ -4,6 +4,7 @@
>
>  #define pr_fmt(fmt) "clk-ast2600: " fmt
>
> +#include <linux/kernel.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
> @@ -15,7 +16,7 @@
>
>  #include "clk-aspeed.h"
>
> -#define ASPEED_G6_NUM_CLKS             71
> +#define ASPEED_G6_NUM_CLKS             72
>
>  #define ASPEED_G6_SILICON_REV          0x004
>
> @@ -31,6 +32,7 @@
>  #define ASPEED_G6_CLK_SELECTION1       0x300
>  #define ASPEED_G6_CLK_SELECTION2       0x304
>  #define ASPEED_G6_CLK_SELECTION4       0x310
> +#define ASPEED_G6_CLK_SELECTION5       0x314
>
>  #define ASPEED_HPLL_PARAM              0x200
>  #define ASPEED_APLL_PARAM              0x210
> @@ -116,7 +118,7 @@ static const struct aspeed_gate_data aspeed_g6_gates[] = {
>         [ASPEED_CLK_GATE_UART11CLK]     = { 59,  -1, "uart11clk-gate",  "uartx", 0 },   /* UART11 */
>         [ASPEED_CLK_GATE_UART12CLK]     = { 60,  -1, "uart12clk-gate",  "uartx", 0 },   /* UART12 */
>         [ASPEED_CLK_GATE_UART13CLK]     = { 61,  -1, "uart13clk-gate",  "uartx", 0 },   /* UART13 */
> -       [ASPEED_CLK_GATE_FSICLK]        = { 62,  59, "fsiclk-gate",     NULL,    0 },   /* FSI */
> +       [ASPEED_CLK_GATE_FSICLK]        = { 62,  59, "fsiclk-gate",     "aplln", CLK_SET_RATE_PARENT }, /* FSI */

Why do we call this apll*n* ?

I believe the apll is also the parent of the sdclk.

Designs that use FSI do not use the sdclk, but it should be added to
the table for completeness.

>  };
>
>  static const struct clk_div_table ast2600_eclk_div_table[] = {
> @@ -187,24 +189,166 @@ static struct clk_hw *ast2600_calc_pll(const char *name, u32 val)
>                         mult, div);
>  };
>
> -static struct clk_hw *ast2600_calc_apll(const char *name, u32 val)
> +/*
> + * APLL Frequency: F = 25MHz * (2 - od) * [(m + 2) / (n + 1)]
> + */
> +static void ast2600_apll_get_params(unsigned int *div, unsigned int *mul)
>  {
> -       unsigned int mult, div;
> +       u32 val = readl(scu_g6_base + ASPEED_APLL_PARAM);
>
>         if (val & BIT(20)) {
>                 /* Pass through mode */
> -               mult = div = 1;
> +               *mul = *div = 1;
>         } else {
> -               /* F = 25Mhz * (2-od) * [(m + 2) / (n + 1)] */
>                 u32 m = (val >> 5) & 0x3f;
>                 u32 od = (val >> 4) & 0x1;
>                 u32 n = val & 0xf;
>
> -               mult = (2 - od) * (m + 2);
> -               div = n + 1;
> +               *mul = (2 - od) * (m + 2);
> +               *div = n + 1;
>         }
> -       return clk_hw_register_fixed_factor(NULL, name, "clkin", 0,
> -                       mult, div);
> +}
> +
> +static long ast2600_apll_best(unsigned long ul_rate, unsigned long ul_prate,
> +                             unsigned int *out_div, unsigned int *out_mul,
> +                             unsigned int *output_divider)
> +{

I look to our clk maintainers for review of this bit. Eddie has done a
good job, but if there's a better way to do this then please let us
know.

In practice we will run the APLL at one of two rates, so doing a
search during every boot seems unnecessary to me.

> +#define min_mult 2ULL
> +#define max_mult 65ULL
> +#define min_div 1ULL
> +#define max_div 16ULL
> +       int i;
> +       unsigned int bod = 0;
> +       unsigned long long rem = 1ULL;
> +       unsigned long long brem = ~(0ULL);
> +       unsigned long long bdiv = 1ULL;
> +       unsigned long long tdiv;
> +       unsigned long long bmul = 16ULL;
> +       unsigned long long tmul;
> +       long brate = -ERANGE;
> +       unsigned long long trate;
> +       unsigned long long rate = ul_rate;
> +       unsigned long long prate = ul_prate;
> +
> +       for (i = 0; i < 2; ++i, prate *= 2ULL) {
> +               for (tdiv = min_div; tdiv <= max_div; ++tdiv) {
> +                       tmul = DIV_ROUND_CLOSEST_ULL(rate * tdiv, prate);
> +                       if (tmul <  min_mult || tmul > max_mult)
> +                               continue;
> +
> +                       trate = DIV_ROUND_CLOSEST_ULL(prate * tmul, tdiv);
> +                       if (trate > rate)
> +                               rem = trate - rate;
> +                       else
> +                               rem = rate - trate;
> +
> +                       if (rem < brem) {
> +                               bod = !i;
> +                               brem = rem;
> +                               bdiv = tdiv;
> +                               bmul = tmul;
> +                               brate = (long)trate;
> +                       }
> +
> +                       if (!rem)
> +                               break;
> +               }
> +
> +               if (!rem)
> +                       break;
> +       }
> +
> +       if (out_div)
> +               *out_div = (unsigned int)bdiv;
> +
> +       if (out_mul)
> +               *out_mul = (unsigned int)bmul;
> +
> +       if (output_divider)
> +               *output_divider = bod;
> +
> +       return brate;
> +#undef min_mult
> +#undef max_mult
> +#undef min_div
> +#undef max_div
> +}
> +
> +static unsigned long ast2600_apll_recalc_rate(struct clk_hw *hw,
> +                                             unsigned long parent_rate)
> +{
> +       unsigned int div;
> +       unsigned int mul;
> +       unsigned long long rate;
> +       unsigned long long prate = (unsigned long long)parent_rate;
> +
> +       ast2600_apll_get_params(&div, &mul);
> +
> +       rate = DIV_ROUND_CLOSEST_ULL(prate * (unsigned long long)mul, div);
> +       return (unsigned long)rate;
> +}
> +
> +static long ast2600_apll_round_rate(struct clk_hw *hw, unsigned long rate,
> +                                   unsigned long *parent_rate)
> +{
> +       return ast2600_apll_best(rate, *parent_rate, NULL, NULL, NULL);
> +}
> +
> +static int ast2600_apll_set_rate(struct clk_hw *hw, unsigned long rate,
> +                                unsigned long parent_rate)
> +{
> +       u32 val;
> +       unsigned int od;
> +       unsigned int div;
> +       unsigned int mul;
> +       long brate = ast2600_apll_best(rate, parent_rate, &div, &mul, &od);
> +
> +       if (brate < 0)
> +               return brate;
> +
> +       val = readl(scu_g6_base + ASPEED_APLL_PARAM);
> +       val &= ~0x7ff;
> +       val |= (div - 1) & 0xf;
> +       val |= ((mul - 2) & 0x3f) << 5;
> +       if (od)
> +               val |= 0x10;
> +       writel(val, scu_g6_base + ASPEED_APLL_PARAM);
> +
> +       return 0;
> +}
> +
> +static const struct clk_ops ast2600_apll_ops = {
> +       .recalc_rate = ast2600_apll_recalc_rate,
> +       .round_rate = ast2600_apll_round_rate,
> +       .set_rate = ast2600_apll_set_rate,
> +};
> +
> +static struct clk_hw *ast2600_create_apll(void)
> +{
> +       int rc;
> +       const char *parent = "clkin";
> +       struct clk_init_data init = {
> +               .name = "apll",
> +               .ops = &ast2600_apll_ops,
> +               .parent_names = &parent,
> +               .parent_data = NULL,
> +               .parent_hws = NULL,
> +               .num_parents = 1,
> +               .flags = 0,
> +       };
> +       struct clk_hw *clk = kzalloc(sizeof(*clk), GFP_KERNEL);
> +
> +       if (!clk)
> +               return ERR_PTR(-ENOMEM);
> +
> +       clk->init = &init;
> +       rc = of_clk_hw_register(NULL, clk);
> +       if (rc) {
> +               kfree(clk);
> +               clk = ERR_PTR(rc);
> +       }
> +
> +       return clk;
>  };
>
>  static u32 get_bit(u8 idx)
> @@ -630,6 +774,16 @@ static int aspeed_g6_clk_probe(struct platform_device *pdev)
>                 return PTR_ERR(hw);
>         aspeed_g6_clk_data->hws[ASPEED_CLK_ECLK] = hw;
>
> +       hw = clk_hw_register_divider_table(dev, "aplln", "apll",
> +                                          CLK_SET_RATE_PARENT,
> +                                          scu_g6_base + ASPEED_G6_CLK_SELECTION5,
> +                                          28, 3, CLK_DIVIDER_READ_ONLY,
> +                                          ast2600_eclk_div_table,
> +                                          &aspeed_g6_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_APLLN] = hw;
> +
>         for (i = 0; i < ARRAY_SIZE(aspeed_g6_gates); i++) {
>                 const struct aspeed_gate_data *gd = &aspeed_g6_gates[i];
>                 u32 gate_flags;
> @@ -710,8 +864,7 @@ static void __init aspeed_g6_cc(struct regmap *map)
>         regmap_read(map, ASPEED_EPLL_PARAM, &val);
>         aspeed_g6_clk_data->hws[ASPEED_CLK_EPLL] = ast2600_calc_pll("epll", val);
>
> -       regmap_read(map, ASPEED_APLL_PARAM, &val);
> -       aspeed_g6_clk_data->hws[ASPEED_CLK_APLL] = ast2600_calc_apll("apll", val);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_APLL] = ast2600_create_apll();
>
>         /* Strap bits 12:11 define the AXI/AHB clock frequency ratio (aka HCLK)*/
>         regmap_read(map, ASPEED_G6_STRAP1, &val);
> --
> 2.26.2
>
