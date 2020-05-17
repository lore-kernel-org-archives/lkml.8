Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46A2C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 00:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78FC420709
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 00:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw+x68Gk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgEQAIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 20:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726670AbgEQAIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 20:08:43 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ED6C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 17:08:42 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id d21so6040663ljg.9
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 17:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4yK6XL3gt0+XVfQIVvQaBK6umA0G1wGRMLl2rxzntKg=;
        b=Rw+x68Gk2KHU/UctJ+dNo0cpBoS4UMhrSzyEuXKw25+eRMQAb/NP5+GLUgjybkerCH
         k9g+onaYPAPx6egNYmUxxirOqXwmrxhmfnqvAJkSNcXht0YVhyfjknDGCQctTBgdPAp/
         duJ1rTm3sqMfmljfgQ1fWA6b+eboSCUlXo8dTs+mS2vms5wN8UsPwDmpmrffD3WaORrP
         mC8QKOXD89xXzoNUvTuWDG/f8Xu6NBHV2rVbabL2RbFeChVid39qXqXM71F5HUrSh5vF
         shTxhe6nwUyx/VeAVZSnSlnQhUW5AzMsS4SYxSzdBxKHEXYBFeEF9531ewGCm5nlXuaM
         xmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4yK6XL3gt0+XVfQIVvQaBK6umA0G1wGRMLl2rxzntKg=;
        b=Dthc/ZeVVZR+uJcn45L+OAFvT6DPSIWpiqKxyohhXgWRpILVtVjw3eTH20tYZq8MrF
         Nypj2fiZop7miyffVm/vRLcEefKHhRMPs6ysOdNFwCjE+j2akVHsxJhmySUlXZXqkZ4f
         3RTkj1qDiBf/fWNSRkuHAL7IzXeZZHGb9oBQ6IPARWs0ectT75nVehQkd3ZWxcdJXKgL
         BVqrIbzpnxJfyyAiettul/YYN2KakyA0+dg5f4UFzeLpxyvToWASAtwMxK0+CmnJyRXE
         mtV+i/NOFrDA6nhEi2MPA2Zr+pg4QBcKT2burUBlC/SNoVPWqPBtIKOe3YsMGLxHk1om
         B7lg==
X-Gm-Message-State: AOAM532+i/RgG1WdLsScRS1WVC7Xyb76aPKsz9AXg2e3I8ibnNGbI6ue
        ZH2W19ZkYrgS0GIaim9ZpVVhQQNVuNOGUzPSG7c=
X-Google-Smtp-Source: ABdhPJy9yhXC+SZCbQ/yx5oHorJEkdjFDe8NuHxiCHu9aO8xa9dp/EE7f2IAsmi/fFlQmck0+ryv/ErPTNHy23p3Mu0=
X-Received: by 2002:a2e:81d5:: with SMTP id s21mr6116080ljg.258.1589674121262;
 Sat, 16 May 2020 17:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589623456.git.baolin.wang7@gmail.com> <db5adf754300bdc89d561ea3fb23afc4b6a3ee87.1589623456.git.baolin.wang7@gmail.com>
In-Reply-To: <db5adf754300bdc89d561ea3fb23afc4b6a3ee87.1589623456.git.baolin.wang7@gmail.com>
From:   Orson Zhai <orsonzhai@gmail.com>
Date:   Sun, 17 May 2020 08:08:29 +0800
Message-ID: <CA+H2tpEJo3a7N5Sq0BzkGrGSrtBY61egZo9Xfc=nOMp2igKGFA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mfd: syscon: Support physical regmap bus
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 6:13 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> Some platforms such as Spreadtrum platform, define a special method to
> update bits of the registers instead of reading and writing, which means
> we should use a physical regmap bus to define the reg_update_bits()
> operation instead of the MMIO regmap bus.
>
> Thus add a a __weak function  for the syscon driver to allow to register

Typo -- duplicated "a".

It seems to be a better idea than before.

-Orson

> a physical regmap bus to support this new requirement.
>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
>  drivers/mfd/syscon.c       |  9 ++++++++-
>  include/linux/mfd/syscon.h | 11 +++++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index 3a97816d0cba..dc92f3177ceb 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -40,6 +40,13 @@ static const struct regmap_config syscon_regmap_config = {
>         .reg_stride = 4,
>  };
>
> +struct regmap * __weak syscon_regmap_init(struct device_node *np,
> +                                         void __iomem *base,
> +                                         struct regmap_config *syscon_config)
> +{
> +       return regmap_init_mmio(NULL, base, syscon_config);
> +}
> +
>  static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  {
>         struct clk *clk;
> @@ -106,7 +113,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>         syscon_config.val_bits = reg_io_width * 8;
>         syscon_config.max_register = resource_size(&res) - reg_io_width;
>
> -       regmap = regmap_init_mmio(NULL, base, &syscon_config);
> +       regmap = syscon_regmap_init(np, base, &syscon_config);
>         if (IS_ERR(regmap)) {
>                 pr_err("regmap init failed\n");
>                 ret = PTR_ERR(regmap);
> diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
> index 7f20e9b502a5..85088e44fe7c 100644
> --- a/include/linux/mfd/syscon.h
> +++ b/include/linux/mfd/syscon.h
> @@ -13,6 +13,7 @@
>
>  #include <linux/err.h>
>  #include <linux/errno.h>
> +#include <linux/regmap.h>
>
>  struct device_node;
>
> @@ -28,6 +29,9 @@ extern struct regmap *syscon_regmap_lookup_by_phandle_args(
>                                         const char *property,
>                                         int arg_count,
>                                         unsigned int *out_args);
> +extern struct regmap *syscon_regmap_init(struct device_node *np,
> +                                        void __iomem *base,
> +                                        struct regmap_config *syscon_config);
>  #else
>  static inline struct regmap *device_node_to_regmap(struct device_node *np)
>  {
> @@ -59,6 +63,13 @@ static inline struct regmap *syscon_regmap_lookup_by_phandle_args(
>  {
>         return ERR_PTR(-ENOTSUPP);
>  }
> +
> +static inline struct regmap *syscon_regmap_init(struct device_node *np,
> +                                               void __iomem *base,
> +                                               struct regmap_config *syscon_config)
> +{
> +       return ERR_PTR(-ENOTSUPP);
> +}
>  #endif
>
>  #endif /* __LINUX_MFD_SYSCON_H__ */
> --
> 2.17.1
>
