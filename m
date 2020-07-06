Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E583C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20B0720702
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNvr/6lN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgGFUDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGFUDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 16:03:42 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F35C061755;
        Mon,  6 Jul 2020 13:03:42 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t27so29048660ill.9;
        Mon, 06 Jul 2020 13:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U+sDylXaFSE2sg34x276nx5sDiqa0lgV7+O4OIQJIw4=;
        b=fNvr/6lN8ZCxC6xudGpJIobVDSs6A74y2NubMmE/1C3KnzUJ/HtBKwU2GT60aXoJyg
         kLkQfQmCQwiXKvOPZw0TQ1KUpPB7J9U9UunLoZWM4aWDLHw5+tZ6SCBjlIsC8GkNPQtb
         TkLal2+sPWhQoIbyHpKZIt2CvBzXHe+/1khagy98FPDH1lqskRu73abAL72O3FQqfyUZ
         jX/yhugHsRJE/waawFLgX79GeTR/hi+7kCxzYD3O51r+0Dq2H1wm0gLS4fyiEaXjR+wr
         74V+aBDvIY0QGWtCeghT4HUMYVFX/JElfey6TzWnnd5uDjBVQlNH7g6p94D7rccLCJGp
         sBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+sDylXaFSE2sg34x276nx5sDiqa0lgV7+O4OIQJIw4=;
        b=GSZ8v7tW8e9gs24xq3Od1zatQEyHZEOSRyvCg90UtbXpLVdf0/JFL4up6x1mLWtEUK
         IBlw3MJY+7CJVgHJEkB/WUmEFTW3lbjDqV4fP5TI6ptWjBroQrVv5fKCqaUx9GRw1D8K
         X+eSyVG5beSa4aO3dONaO/EPfrvk+eB51Pw6GbkVYZuM6Md2Go5Pr2zbIWepwFOPVqum
         dK7JFdMB2cITLjR3eL14TsXMCr1q8Myr73hpnF6jTjeuxQD7GEUOSRGSvVnhkpM7Uedc
         wiEipOAczSnJDW5oFpq8pEQ69FQaki4y14iiFUi+FrCsDZ3TKznIf0Z0mEHalApcIf1I
         lNhQ==
X-Gm-Message-State: AOAM530UUQQHYVTIp9rvqDS+Rclp+4fUDV8TvJppMAQz/ywxcfMqtS+T
        h/CaRgaSJooJOsBdmXpHqNNdifZzViJ83JI1k1k=
X-Google-Smtp-Source: ABdhPJynJcd3bkJkIceMB7JqgAd4y2d96M9VHAbRwYa4n23QwCNJHYfNksLSrJfyqrh+Veud561AmImV0syj4/IkkFk=
X-Received: by 2002:a92:77c1:: with SMTP id s184mr32082188ilc.196.1594065821596;
 Mon, 06 Jul 2020 13:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200702212837.10657-1-luca@lucaceresoli.net> <20200702212837.10657-5-luca@lucaceresoli.net>
In-Reply-To: <20200702212837.10657-5-luca@lucaceresoli.net>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 6 Jul 2020 15:03:30 -0500
Message-ID: <CAHCN7xLz-xuHgQRPmqRes7tKjcEjrnqpG9o-3Dee81UkSDfE-Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] clk: vc5: optionally configure the output drive mode
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 5:40 PM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>
> The Versaclock chips can drive the output pins in several modes: LVDS,
> CMOS, LVPECL etc. Allow configuring the output mode from device tree.
>
> The configuration is optional. If not specified, the mode will not be
> configured and the drive mode will be the chip default.
>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

This might be duplicating what's been applied to linux-next already.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/clk/clk-versaclock5.c?h=next-20200706&id=260249f929e81d3d5764117fdd6b9e43eb8fb1d5


> ---
>  drivers/clk/clk-versaclock5.c | 71 +++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
> index 60c7cf9acde3..eec57286fae0 100644
> --- a/drivers/clk/clk-versaclock5.c
> +++ b/drivers/clk/clk-versaclock5.c
> @@ -89,6 +89,8 @@
>
>  /* Clock control register for clock 1,2 */
>  #define VC5_CLK_OUTPUT_CFG(idx, n)     (0x60 + ((idx) * 0x2) + (n))
> +#define VC5_CLK_OUTPUT_CFG0_MODE_SHIFT 5
> +#define VC5_CLK_OUTPUT_CFG0_MODE_MASK  GENMASK(7, 5)
>  #define VC5_CLK_OUTPUT_CFG1_EN_CLKBUF  BIT(0)
>
>  #define VC5_CLK_OE_SHDN                                0x68
> @@ -117,6 +119,23 @@
>  /* chip has PFD requency doubler */
>  #define VC5_HAS_PFD_FREQ_DBL   BIT(1)
>
> +/*
> + * Output modes. Values for VC5_CLK_OUTPUT_CFG(idx,0) bits [7:5].
> + * IDT_VC5_OUT_UNKNOWN = keep the hardware default.
> + */
> +enum vc5_out_mode {
> +       IDT_VC5_OUT_MODE_LVPECL   = 0,
> +       IDT_VC5_OUT_MODE_CMOS     = 1,
> +       IDT_VC5_OUT_MODE_HCSL33   = 2,
> +       IDT_VC5_OUT_MODE_LVDS     = 3,
> +       IDT_VC5_OUT_MODE_CMOS2    = 4,
> +       IDT_VC5_OUT_MODE_CMOSD    = 5,
> +       IDT_VC5_OUT_MODE_HCSL25   = 6,
> +
> +       IDT_VC5_OUT_NUM_MODES,
> +       IDT_VC5_OUT_MODE_UNKNOWN  = 99,
> +};
> +
>  /* Supported IDT VC5 models. */
>  enum vc5_model {
>         IDT_VC5_5P49V5923,
> @@ -149,6 +168,7 @@ struct vc5_out_data {
>         struct clk_hw           hw;
>         struct vc5_driver_data  *vc5;
>         unsigned int            num;
> +       enum vc5_out_mode       mode:8;
>  };
>
>  struct vc5_driver_data {
> @@ -593,6 +613,13 @@ static int vc5_clk_out_prepare(struct clk_hw *hw)
>                         return ret;
>         }
>
> +       /* Set output drive mode */
> +       if (hwdata->mode != IDT_VC5_OUT_MODE_UNKNOWN)
> +               regmap_update_bits(vc5->regmap,
> +                                  VC5_CLK_OUTPUT_CFG(hwdata->num, 0),
> +                                  VC5_CLK_OUTPUT_CFG0_MODE_MASK,
> +                                  (hwdata->mode << VC5_CLK_OUTPUT_CFG0_MODE_SHIFT));
> +
>         /* Enable the clock buffer */
>         regmap_update_bits(vc5->regmap, VC5_CLK_OUTPUT_CFG(hwdata->num, 1),
>                            VC5_CLK_OUTPUT_CFG1_EN_CLKBUF,
> @@ -696,6 +723,46 @@ static int vc5_map_index_to_output(const enum vc5_model model,
>         }
>  }
>
> +static int vc5_parse_dt(struct vc5_driver_data *vc5)
> +{
> +       struct device *dev = &vc5->client->dev;
> +       struct device_node *np = dev->of_node;
> +       struct device_node *child;
> +       u32 val;
> +       int n;
> +
> +       for (n = 1; n < vc5->chip_info->clk_out_cnt; n++)
> +               vc5->clk_out[n].mode = IDT_VC5_OUT_MODE_UNKNOWN;
> +
> +       for_each_child_of_node(np, child) {
> +               if (of_property_read_u32(child, "reg", &n)) {
> +                       dev_err(dev, "%pOF: missing reg property\n", child);
> +                       break;
> +               }
> +
> +               if (n == 0 || n >= vc5->chip_info->clk_out_cnt) {
> +                       dev_err(dev, "%pOF: invalid reg %d\n", child, n);
> +                       break;
> +               }
> +
> +               if (!of_property_read_u32(child, "idt,drive-mode", &val)) {
> +                       if (val >= IDT_VC5_OUT_NUM_MODES) {
> +                               dev_err(dev, "%pOF: invalid idt,drive-mode %u\n",
> +                                       child, val);
> +                               break;
> +                       }
> +                       vc5->clk_out[n].mode = val;
> +               }
> +       }
> +
> +       if (child) {
> +               of_node_put(child);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  static const struct of_device_id clk_vc5_of_match[];
>
>  static int vc5_probe(struct i2c_client *client,
> @@ -723,6 +790,10 @@ static int vc5_probe(struct i2c_client *client,
>         if (PTR_ERR(vc5->pin_clkin) == -EPROBE_DEFER)
>                 return -EPROBE_DEFER;
>
> +       ret = vc5_parse_dt(vc5);
> +       if (ret)
> +               return ret;
> +
>         vc5->regmap = devm_regmap_init_i2c(client, &vc5_regmap_config);
>         if (IS_ERR(vc5->regmap)) {
>                 dev_err(&client->dev, "failed to allocate register map\n");
> --
> 2.27.0
>
