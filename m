Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD74CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE47920706
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnmL9EzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgHRLpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgHRLo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:44:56 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ECEC061389;
        Tue, 18 Aug 2020 04:44:56 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id bs17so14995009edb.1;
        Tue, 18 Aug 2020 04:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnPDYH0KG2cl6CVhyZB6lV6D4FI+0o1avDxmA9yGRAM=;
        b=JnmL9EzEck2XeGoQfpxnpVT63qCtHJtxUSROFBE4ICvi8Xdho6Djsot/5CJLRFEKOX
         uHw7i6oOusuxRpoaVv3nMyfQh6GEb0FD+ELANUx8h0ez66Uhyq9u88gmJ7wGCI9qaq7d
         rfeXZzlCM5ows4dFzBaDAQll2jlonwE+jk40JJdiUt48ynfxz01YuUIkv6nGbOU5VahH
         PA/FrUFXx9MB9DgV9gSyc0a9BvFS2eY6X+AEs8TSw82oOvk97Xle196Mmwh4cIwMiZs0
         5VRWZAfV5JuxI/6MfjBxXU5Bl0/Mt73+0Xgy/bfvWwRwi1tY5r9p1YsA9xwUYNWIfZPM
         nY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnPDYH0KG2cl6CVhyZB6lV6D4FI+0o1avDxmA9yGRAM=;
        b=IesPYDv59ghrSvDEJOSEkcKFD2qMmk+8lZjku+Vza8zY5Yk/5lgFw8wfjAbKg4lgDu
         WPlwWK3aEwTa/5n7Q6q4+x7bLsYd1NkesrLQuTk5e6YS8H+SIrG7voRlCXJTSam7xadd
         G9mUOi2Ns+bCvsHUtlJ4iZrEr7tJdgGACcVgN1WyPTO1ZHk773bPA4/tvj3pN9KsnkSy
         AHrnwif+3KWPtukNSdQwMHxE7z2MzOUd9s9oiZDaA6iiXktF8gzcoTwyVJz7/jQNCwHm
         FKWmssEPrDJTJpCCFZp9nBQcaXF+3oJiPNmQR3kRxLzED8nssawuSSGauBUm3NagjIqK
         uYQw==
X-Gm-Message-State: AOAM532+6QpJM2pU4wy5cs/y1gbB1pJY0Eo6LPnM7flbp9h/5JWrQIey
        O+f2efzkan58Do+YeBHRb23Wa6zCvKgbCIlIx90=
X-Google-Smtp-Source: ABdhPJzQvFs6Gkummerz2i4mxw4oFCcvikIEA5c54i1zCwlMfwfFybT6AEq+FJp0V4yKPWUXJ1I70C2phNN+fVog1xE=
X-Received: by 2002:a05:6402:b45:: with SMTP id bx5mr761837edb.22.1597751094743;
 Tue, 18 Aug 2020 04:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com> <1597406966-13740-13-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1597406966-13740-13-git-send-email-abel.vesa@nxp.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 18 Aug 2020 19:29:47 +0800
Message-ID: <CAA+hA=RPbgNKLx_=tMjNRAqE0393RScMcm_s84zNxEWE3kK2pA@mail.gmail.com>
Subject: Re: [PATCH v2 12/17] clk: imx8mp: Add audio blk_ctrl clocks and resets
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 8:12 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> Add audio blk_ctrl clocks and resets in the i.MX8MP clock
> driver to be picked up by the clk-blk-ctrl driver.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/clk/imx/clk-blk-ctrl.c |   4 ++
>  drivers/clk/imx/clk-imx8mp.c   | 138 +++++++++++++++++++++++++++++++++++++++++

As i mentioned in Patch 11, I wonder we probably better to put blk
ctrl clk data in blk ctrl driver.
Otherwise, i'm okay with the code.

Regards
Aisheng

>  2 files changed, 142 insertions(+)
>
> diff --git a/drivers/clk/imx/clk-blk-ctrl.c b/drivers/clk/imx/clk-blk-ctrl.c
> index 1672646..1c2991c 100644
> --- a/drivers/clk/imx/clk-blk-ctrl.c
> +++ b/drivers/clk/imx/clk-blk-ctrl.c
> @@ -312,6 +312,10 @@ static const struct dev_pm_ops imx_blk_ctrl_pm_ops = {
>  };
>
>  static const struct of_device_id imx_blk_ctrl_of_match[] = {
> +       {
> +               .compatible = "fsl,imx8mp-audio-blk-ctrl",
> +               .data = &imx8mp_audio_blk_ctrl_dev_data
> +       },
>         { /* Sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, imx_blk_ctrl_of_match);
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index 462c558..00e7f5e 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -4,6 +4,7 @@
>   */
>
>  #include <dt-bindings/clock/imx8mp-clock.h>
> +#include <dt-bindings/reset/imx8mp-reset.h>
>  #include <linux/clk-provider.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> @@ -14,11 +15,148 @@
>  #include <linux/types.h>
>
>  #include "clk.h"
> +#include "clk-blk-ctrl.h"
> +
> +#define        IMX_AUDIO_BLK_CTRL_CLKEN0               0x0
> +#define        IMX_AUDIO_BLK_CTRL_CLKEN1               0x4
> +#define        IMX_AUDIO_BLK_CTRL_EARC                 0x200
> +#define        IMX_AUDIO_BLK_CTRL_SAI1_MCLK_SEL        0x300
> +#define        IMX_AUDIO_BLK_CTRL_SAI2_MCLK_SEL        0x304
> +#define        IMX_AUDIO_BLK_CTRL_SAI3_MCLK_SEL        0x308
> +#define        IMX_AUDIO_BLK_CTRL_SAI5_MCLK_SEL        0x30C
> +#define        IMX_AUDIO_BLK_CTRL_SAI6_MCLK_SEL        0x310
> +#define        IMX_AUDIO_BLK_CTRL_SAI7_MCLK_SEL        0x314
> +#define        IMX_AUDIO_BLK_CTRL_PDM_CLK              0x318
> +#define        IMX_AUDIO_BLK_CTRL_SAI_PLL_GNRL_CTL     0x400
> +#define        IMX_AUDIO_BLK_CTRL_SAI_PLL_FDIVL_CTL0   0x404
> +#define        IMX_AUDIO_BLK_CTRL_SAI_PLL_FDIVL_CTL1   0x408
> +#define        IMX_AUDIO_BLK_CTRL_SAI_PLL_SSCG_CTL     0x40C
> +#define        IMX_AUDIO_BLK_CTRL_SAI_PLL_MNIT_CTL     0x410
> +#define        IMX_AUDIO_BLK_CTRL_IPG_LP_CTRL          0x504
> +
> +#define IMX_MEDIA_BLK_CTRL_SFT_RSTN            0x0
> +#define IMX_MEDIA_BLK_CTRL_CLK_EN              0x4
>
>  static u32 share_count_nand;
>  static u32 share_count_media;
>  static u32 share_count_audio;
>
> +static int shared_count_pdm;
> +
> +static const struct imx_pll14xx_rate_table imx_blk_ctrl_sai_pll_tbl[] = {
> +       PLL_1443X_RATE(650000000U, 325, 3, 2, 0),
> +};
> +
> +static const struct imx_pll14xx_clk imx_blk_ctrl_sai_pll = {
> +       .type = PLL_1443X,
> +       .rate_table = imx_blk_ctrl_sai_pll_tbl,
> +};
> +
> +static const char * const imx_sai_mclk2_sels[] = {"sai1_root", "sai2_root", "sai3_root", "dummy",
> +                                          "sai5_root", "sai6_root", "sai7_root", "sai1_mclk",
> +                                          "sai2_mclk", "sai3_mclk", "dummy",
> +                                          "sai5_mclk", "sai6_mclk", "sai7_mclk", "spdif1_ext_clk"};
> +static const char * const imx_sai1_mclk1_sels[] = {"sai1_root", "sai1_mclk", };
> +static const char * const imx_sai2_mclk1_sels[] = {"sai2_root", "sai2_mclk", };
> +static const char * const imx_sai3_mclk1_sels[] = {"sai3_root", "sai3_mclk", };
> +static const char * const imx_sai5_mclk1_sels[] = {"sai5_root", "sai5_mclk", };
> +static const char * const imx_sai6_mclk1_sels[] = {"sai6_root", "sai6_mclk", };
> +static const char * const imx_sai7_mclk1_sels[] = {"sai7_root", "sai7_mclk", };
> +static const char * const imx_pdm_sels[] = {"pdm_root", "sai_pll_div2", "dummy", "dummy" };
> +static const char * const imx_sai_pll_ref_sels[] = {"osc_24m", "dummy", "dummy", "dummy", };
> +static const char * const imx_sai_pll_bypass_sels[] = {"sai_pll", "sai_pll_ref_sel", };
> +
> +static struct imx_blk_ctrl_hw imx8mp_audio_blk_ctrl_hws[] = {
> +       /* clocks */
> +       IMX_BLK_CTRL_CLK_MUX("sai_pll_ref_sel", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI_PLL_REF_SEL, 0x400, 0, 2, imx_sai_pll_ref_sels),
> +       IMX_BLK_CTRL_CLK_PLL14XX("sai_pll", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI_PLL, 0x400, "sai_pll_ref_sel", &imx_blk_ctrl_sai_pll),
> +       IMX_BLK_CTRL_CLK_MUX_FLAGS("sai_pll_bypass", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI_PLL_BYPASS, 0x400, 4, 1, imx_sai_pll_bypass_sels, CLK_SET_RATE_PARENT),
> +       IMX_BLK_CTRL_CLK_GATE("sai_pll_out", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI_PLL_OUT, 0x400, 13, "sai_pll_bypass"),
> +       IMX_BLK_CTRL_CLK_MUX_FLAGS("sai1_mclk1_sel", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI1_MCLK1_SEL, 0x300, 0, 1, imx_sai1_mclk1_sels, CLK_SET_RATE_PARENT),
> +       IMX_BLK_CTRL_CLK_MUX("sai1_mclk2_sel", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI1_MCLK2_SEL, 0x300, 1, 4, imx_sai_mclk2_sels),
> +       IMX_BLK_CTRL_CLK_MUX_FLAGS("sai2_mclk1_sel", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI2_MCLK1_SEL, 0x304, 0, 1, imx_sai2_mclk1_sels, CLK_SET_RATE_PARENT),
> +       IMX_BLK_CTRL_CLK_MUX("sai2_mclk2_sel", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI2_MCLK2_SEL, 0x304, 1, 4, imx_sai_mclk2_sels),
> +       IMX_BLK_CTRL_CLK_MUX_FLAGS("sai3_mclk1_sel", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI3_MCLK1_SEL, 0x308, 0, 1, imx_sai3_mclk1_sels, CLK_SET_RATE_PARENT),
> +       IMX_BLK_CTRL_CLK_MUX("sai3_mclk2_sel", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI3_MCLK2_SEL, 0x308, 1, 4, imx_sai_mclk2_sels),
> +       IMX_BLK_CTRL_CLK_MUX("sai5_mclk1_sel", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI5_MCLK1_SEL, 0x30C, 0, 1, imx_sai5_mclk1_sels),
> +       IMX_BLK_CTRL_CLK_MUX("sai5_mclk2_sel", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI5_MCLK2_SEL, 0x30C, 1, 4, imx_sai_mclk2_sels),
> +       IMX_BLK_CTRL_CLK_MUX("sai6_mclk1_sel", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI6_MCLK1_SEL, 0x310, 0, 1, imx_sai6_mclk1_sels),
> +       IMX_BLK_CTRL_CLK_MUX("sai6_mclk2_sel", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI6_MCLK2_SEL, 0x310, 1, 4, imx_sai_mclk2_sels),
> +       IMX_BLK_CTRL_CLK_MUX("sai7_mclk1_sel", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI7_MCLK1_SEL, 0x314, 0, 1, imx_sai7_mclk1_sels),
> +       IMX_BLK_CTRL_CLK_MUX("sai7_mclk2_sel", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI7_MCLK2_SEL, 0x314, 1, 4, imx_sai_mclk2_sels),
> +       IMX_BLK_CTRL_CLK_GATE("sai1_ipg_clk",   IMX8MP_CLK_AUDIO_BLK_CTRL_SAI1_IPG, 0, 0, "audio_ahb_root"),
> +       IMX_BLK_CTRL_CLK_GATE("sai1_mclk1_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI1_MCLK1, 0, 1, "sai1_mclk1_sel"),
> +       IMX_BLK_CTRL_CLK_GATE("sai1_mclk2_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI1_MCLK2, 0, 2, "sai1_mclk2_sel"),
> +       IMX_BLK_CTRL_CLK_GATE("sai1_mclk3_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI1_MCLK3, 0, 3, "sai_pll_out"),
> +       IMX_BLK_CTRL_CLK_GATE("sai2_ipg_clk",   IMX8MP_CLK_AUDIO_BLK_CTRL_SAI2_IPG, 0, 4, "audio_ahb_root"),
> +       IMX_BLK_CTRL_CLK_GATE("sai2_mclk1_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI2_MCLK1, 0, 5, "sai2_mclk1_sel"),
> +       IMX_BLK_CTRL_CLK_GATE("sai2_mclk2_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI2_MCLK2, 0, 6, "sai2_mclk2_sel"),
> +       IMX_BLK_CTRL_CLK_GATE("sai2_mclk3_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI2_MCLK3, 0, 7, "sai_pll_out"),
> +       IMX_BLK_CTRL_CLK_GATE("sai3_ipg_clk",   IMX8MP_CLK_AUDIO_BLK_CTRL_SAI3_IPG, 0, 8, "audio_ahb_root"),
> +       IMX_BLK_CTRL_CLK_GATE("sai3_mclk1_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI3_MCLK1, 0, 9, "sai3_mclk1_sel"),
> +       IMX_BLK_CTRL_CLK_GATE("sai3_mclk2_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI3_MCLK2, 0, 10, "sai3_mclk2_sel"),
> +       IMX_BLK_CTRL_CLK_GATE("sai3_mclk3_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI3_MCLK3, 0, 11, "sai_pll_out"),
> +       IMX_BLK_CTRL_CLK_GATE("sai5_ipg_clk",   IMX8MP_CLK_AUDIO_BLK_CTRL_SAI5_IPG, 0, 12, "audio_ahb_root"),
> +       IMX_BLK_CTRL_CLK_GATE("sai5_mclk1_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI5_MCLK1, 0, 13, "sai5_mclk1_sel"),
> +       IMX_BLK_CTRL_CLK_GATE("sai5_mclk2_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI5_MCLK2, 0, 14, "sai5_mclk2_sel"),
> +       IMX_BLK_CTRL_CLK_GATE("sai5_mclk3_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI5_MCLK3, 0, 15, "sai_pll_out"),
> +       IMX_BLK_CTRL_CLK_GATE("sai6_ipg_clk",   IMX8MP_CLK_AUDIO_BLK_CTRL_SAI6_IPG, 0, 16, "audio_ahb_root"),
> +       IMX_BLK_CTRL_CLK_GATE("sai6_mclk1_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI6_MCLK1, 0, 17, "sai6_mclk1_sel"),
> +       IMX_BLK_CTRL_CLK_GATE("sai6_mclk2_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI6_MCLK2, 0, 18, "sai6_mclk2_sel"),
> +       IMX_BLK_CTRL_CLK_GATE("sai6_mclk3_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI6_MCLK3, 0, 19, "sai_pll_out"),
> +       IMX_BLK_CTRL_CLK_GATE("sai7_ipg_clk",   IMX8MP_CLK_AUDIO_BLK_CTRL_SAI7_IPG, 0, 20, "audio_ahb_root"),
> +       IMX_BLK_CTRL_CLK_GATE("sai7_mclk1_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI7_MCLK1, 0, 21, "sai7_mclk1_sel"),
> +       IMX_BLK_CTRL_CLK_GATE("sai7_mclk2_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI7_MCLK2, 0, 22, "sai7_mclk2_sel"),
> +       IMX_BLK_CTRL_CLK_GATE("sai7_mclk3_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_SAI7_MCLK3, 0, 23, "sai_pll_out"),
> +       IMX_BLK_CTRL_CLK_GATE("asrc_ipg_clk",   IMX8MP_CLK_AUDIO_BLK_CTRL_ASRC_IPG, 0, 24, "audio_ahb_root"),
> +       IMX_BLK_CTRL_CLK_SHARED_GATE("pdm_ipg_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_PDM_IPG, 0, 25, "audio_ahb_root", &shared_count_pdm),
> +       IMX_BLK_CTRL_CLK_SHARED_GATE("pdm_root_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_PDM_ROOT, 0, 25, "pdm_root", &shared_count_pdm),
> +       IMX_BLK_CTRL_CLK_GATE("sdma2_root_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_SDMA2_ROOT, 0, 26, "audio_ahb_root"),
> +       IMX_BLK_CTRL_CLK_GATE("sdma3_root_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_SDMA3_ROOT, 0, 27, "audio_ahb_root"),
> +       IMX_BLK_CTRL_CLK_GATE("spba2_root_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_SPBA2_ROOT, 0, 28, "audio_ahb_root"),
> +       IMX_BLK_CTRL_CLK_GATE("dsp_root_clk",   IMX8MP_CLK_AUDIO_BLK_CTRL_DSP_ROOT, 0, 29, "audio_axi_root"),
> +       IMX_BLK_CTRL_CLK_GATE("dsp_dbg_clk",    IMX8MP_CLK_AUDIO_BLK_CTRL_DSPDBG_ROOT, 0, 30, "audio_axi_root"),
> +       IMX_BLK_CTRL_CLK_GATE("earc_ipg_clk",   IMX8MP_CLK_AUDIO_BLK_CTRL_EARC_IPG, 0, 31, "audio_ahb_root"),
> +       IMX_BLK_CTRL_CLK_GATE("ocram_a_ipg_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_OCRAMA_IPG, 4, 0, "audio_axi_root"),
> +       IMX_BLK_CTRL_CLK_GATE("aud2htx_ipg_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_AUD2HTX_IPG, 4, 1, "audio_ahb_root"),
> +       IMX_BLK_CTRL_CLK_GATE("edma_root_clk",   IMX8MP_CLK_AUDIO_BLK_CTRL_EDMA_ROOT, 4, 2, "audio_ahb_root"),
> +       IMX_BLK_CTRL_CLK_GATE("aud_pll_clk",  IMX8MP_CLK_AUDIO_BLK_CTRL_AUDPLL_ROOT, 4, 3, "osc_24m"),
> +       IMX_BLK_CTRL_CLK_GATE("mu2_root_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_MU2_ROOT, 4, 4, "audio_ahb_root"),
> +       IMX_BLK_CTRL_CLK_GATE("mu3_root_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_MU3_ROOT, 4, 5, "audio_ahb_root"),
> +       IMX_BLK_CTRL_CLK_GATE("earc_phy_clk", IMX8MP_CLK_AUDIO_BLK_CTRL_EARC_PHY, 4, 6, "sai_pll_out"),
> +       IMX_BLK_CTRL_CLK_MUX("pdm_sel", IMX8MP_CLK_AUDIO_BLK_CTRL_PDM_SEL, 0x318, 1, 4, imx_pdm_sels),
> +
> +       /* resets */
> +       IMX_BLK_CTRL_RESET(IMX8MP_AUDIO_BLK_CTRL_EARC_RESET, 0x200, 0),
> +       IMX_BLK_CTRL_RESET(IMX8MP_AUDIO_BLK_CTRL_EARC_PHY_RESET, 0x200, 1),
> +};
> +
> +const struct imx_blk_ctrl_dev_data imx8mp_audio_blk_ctrl_dev_data __initconst = {
> +       .hws = imx8mp_audio_blk_ctrl_hws,
> +       .hws_num = ARRAY_SIZE(imx8mp_audio_blk_ctrl_hws),
> +       .clocks_max = IMX8MP_CLK_AUDIO_BLK_CTRL_END,
> +       .resets_max = IMX8MP_AUDIO_BLK_CTRL_RESET_NUM,
> +       .pm_runtime_saved_regs_num = 16,
> +       .pm_runtime_saved_regs = {
> +               IMX_AUDIO_BLK_CTRL_CLKEN0,
> +               IMX_AUDIO_BLK_CTRL_CLKEN1,
> +               IMX_AUDIO_BLK_CTRL_EARC,
> +               IMX_AUDIO_BLK_CTRL_SAI1_MCLK_SEL,
> +               IMX_AUDIO_BLK_CTRL_SAI2_MCLK_SEL,
> +               IMX_AUDIO_BLK_CTRL_SAI3_MCLK_SEL,
> +               IMX_AUDIO_BLK_CTRL_SAI5_MCLK_SEL,
> +               IMX_AUDIO_BLK_CTRL_SAI6_MCLK_SEL,
> +               IMX_AUDIO_BLK_CTRL_SAI7_MCLK_SEL,
> +               IMX_AUDIO_BLK_CTRL_PDM_CLK,
> +               IMX_AUDIO_BLK_CTRL_SAI_PLL_GNRL_CTL,
> +               IMX_AUDIO_BLK_CTRL_SAI_PLL_FDIVL_CTL0,
> +               IMX_AUDIO_BLK_CTRL_SAI_PLL_FDIVL_CTL1,
> +               IMX_AUDIO_BLK_CTRL_SAI_PLL_SSCG_CTL,
> +               IMX_AUDIO_BLK_CTRL_SAI_PLL_MNIT_CTL,
> +               IMX_AUDIO_BLK_CTRL_IPG_LP_CTRL
> +       },
> +};
> +
>  static const char * const pll_ref_sels[] = { "osc_24m", "dummy", "dummy", "dummy", };
>  static const char * const audio_pll1_bypass_sels[] = {"audio_pll1", "audio_pll1_ref_sel", };
>  static const char * const audio_pll2_bypass_sels[] = {"audio_pll2", "audio_pll2_ref_sel", };
> --
> 2.7.4
>
