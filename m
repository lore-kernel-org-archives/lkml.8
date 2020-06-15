Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55BAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B01342074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMT//4pi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbgFONuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgFONuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:50:18 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8FBC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:50:18 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u25so3095691lfm.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8yGYtCBYs3Oa7zt+qrhwD1C+XiJCYAsbqKsQMEggm2g=;
        b=hMT//4piUOays49jFvf3O+9KUqXock0C9I9f7pQT2OcYUyCev1RYeePDibvX9+Muu3
         l2SYJ4KaM9T/ufgz8xCVSHYXcbhY/Lh9Pv7h/6oT3sPCsKewXQu4jWWMMtfXg8805dCG
         ObLen+kNgQE5cejvw6eZ0hqmTeYqokcYq09ybvTddg26707oC5enTwoqnIlAlEucRVL2
         TyJc2VSQ7MMLfAC9My0TLX1QqATE3+ougeKPG0q6ZVtQ1/7RxiFp93Anpaa5lvN09/GI
         8ATl6ZFxQw/YXoN7GM+gHsJs28y21IA2DIfYyf0NmlNsCllJITSM7OSKTsSaP/q2rr0A
         QTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8yGYtCBYs3Oa7zt+qrhwD1C+XiJCYAsbqKsQMEggm2g=;
        b=Cs81HXpaOiLerXSH74snb722FoO1np0z+WxQAcrTfjkxsP0R5RjbKZ/VfeCiGYR1Z5
         kq9zzyPBsou6/hxwZHJLRA3QAYqCh6quGM0qmo3QGG3t1zCtG5TJ7rXqEwMyb2++4Mt6
         Sp7eOpUzHpNnlfcDIp0+d4sDEayRaFSH5wcOesTpY4Kdba/PRUMizpe2q3DAqwv7G+oy
         ECrm4UAdiTcuBYIhL+kABUie6+J7ZZlbgsETihhlUjdb82EuT6J6P2MaAXVccwG69W6P
         j4vAwQfjJC3VYn8ULrc8H29+SNsKJPHh1fsVn1Dzr5djOYXfuDdbnqSeMeEEPYOzOQdi
         VUOw==
X-Gm-Message-State: AOAM533e7dc0hwlYXGWga7nE280JtgXddbeIz8EyBje7IVHh386WdPrK
        3Zt7nCfGOSaDVfCE2bfGiZfLZvn4pknQYMuxkkc=
X-Google-Smtp-Source: ABdhPJx2g9IW9lXK1oYFEChxJ4EWx3pE6NyO04m8Wggp0NNFsKX5oMyywn5yRuDswkILGE4a9mmmESNnAwWo5w3+/yo=
X-Received: by 2002:ac2:5b9e:: with SMTP id o30mr13729073lfn.153.1592229016513;
 Mon, 15 Jun 2020 06:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200615032347.10586-1-zhang.lyra@gmail.com>
In-Reply-To: <20200615032347.10586-1-zhang.lyra@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Mon, 15 Jun 2020 21:50:05 +0800
Message-ID: <CADBw62owkztqbA5JLnrHeSbymbfO6PYRQ0DE_=gjHMfrSN1uaA@mail.gmail.com>
Subject: Re: [PATCH] nvmem: sc27xx: add sc2730 efuse support
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Freeman Liu <freeman.liu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 11:23 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Freeman Liu <freeman.liu@unisoc.com>
>
> Add support to the new efuse IP which is integrated in the SC2730
> which includes multiple blocks in a single chip.
>
> Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>

Looks good to me. You can add my reviewed-by tag after fixing the
comment from Srinivas.
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

> ---
>  drivers/nvmem/sc27xx-efuse.c | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvmem/sc27xx-efuse.c b/drivers/nvmem/sc27xx-efuse.c
> index ab5e7e0bc3d8..7d453c9d80da 100644
> --- a/drivers/nvmem/sc27xx-efuse.c
> +++ b/drivers/nvmem/sc27xx-efuse.c
> @@ -4,12 +4,14 @@
>  #include <linux/hwspinlock.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/nvmem-provider.h>
>
>  /* PMIC global registers definition */
>  #define SC27XX_MODULE_EN               0xc08
> +#define SC2730_MODULE_EN               0x1808
>  #define SC27XX_EFUSE_EN                        BIT(6)
>
>  /* Efuse controller registers definition */
> @@ -49,12 +51,29 @@
>  #define SC27XX_EFUSE_POLL_TIMEOUT      3000000
>  #define SC27XX_EFUSE_POLL_DELAY_US     10000
>
> +/*
> + * Since different PMICs of SC27xx series can have different
> + * address , we should save address in the device data structure.
> + */
> +struct sc27xx_efuse_variant_data {
> +       u32 module_en;
> +};
> +
>  struct sc27xx_efuse {
>         struct device *dev;
>         struct regmap *regmap;
>         struct hwspinlock *hwlock;
>         struct mutex mutex;
>         u32 base;
> +       const struct sc27xx_efuse_variant_data *var_data;
> +};
> +
> +static const struct sc27xx_efuse_variant_data sc2731_edata = {
> +       .module_en = SC27XX_MODULE_EN,
> +};
> +
> +static const struct sc27xx_efuse_variant_data sc2730_edata = {
> +       .module_en = SC2730_MODULE_EN,
>  };
>
>  /*
> @@ -119,7 +138,7 @@ static int sc27xx_efuse_read(void *context, u32 offset, void *val, size_t bytes)
>                 return ret;
>
>         /* Enable the efuse controller. */
> -       ret = regmap_update_bits(efuse->regmap, SC27XX_MODULE_EN,
> +       ret = regmap_update_bits(efuse->regmap, efuse->var_data->module_en,
>                                  SC27XX_EFUSE_EN, SC27XX_EFUSE_EN);
>         if (ret)
>                 goto unlock_efuse;
> @@ -169,7 +188,7 @@ static int sc27xx_efuse_read(void *context, u32 offset, void *val, size_t bytes)
>
>  disable_efuse:
>         /* Disable the efuse controller after reading. */
> -       regmap_update_bits(efuse->regmap, SC27XX_MODULE_EN, SC27XX_EFUSE_EN, 0);
> +       regmap_update_bits(efuse->regmap, efuse->var_data->module_en, SC27XX_EFUSE_EN, 0);
>  unlock_efuse:
>         sc27xx_efuse_unlock(efuse);
>
> @@ -187,8 +206,15 @@ static int sc27xx_efuse_probe(struct platform_device *pdev)
>         struct nvmem_config econfig = { };
>         struct nvmem_device *nvmem;
>         struct sc27xx_efuse *efuse;
> +       const struct sc27xx_efuse_variant_data *pdata;
>         int ret;
>
> +       pdata = of_device_get_match_data(&pdev->dev);
> +       if (!pdata) {
> +               dev_err(&pdev->dev, "No matching driver data found\n");
> +               return -EINVAL;
> +       }
> +
>         efuse = devm_kzalloc(&pdev->dev, sizeof(*efuse), GFP_KERNEL);
>         if (!efuse)
>                 return -ENOMEM;
> @@ -219,6 +245,7 @@ static int sc27xx_efuse_probe(struct platform_device *pdev)
>
>         mutex_init(&efuse->mutex);
>         efuse->dev = &pdev->dev;
> +       efuse->var_data = pdata;
>
>         econfig.stride = 1;
>         econfig.word_size = 1;
> @@ -238,7 +265,8 @@ static int sc27xx_efuse_probe(struct platform_device *pdev)
>  }
>
>  static const struct of_device_id sc27xx_efuse_of_match[] = {
> -       { .compatible = "sprd,sc2731-efuse" },
> +       { .compatible = "sprd,sc2731-efuse", .data = &sc2731_edata},
> +       { .compatible = "sprd,sc2730-efuse", .data = &sc2730_edata},
>         { }
>  };
>
> --
> 2.20.1
>


-- 
Baolin Wang
