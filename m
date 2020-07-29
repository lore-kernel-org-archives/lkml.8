Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A70C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 10:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 640DE20663
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 10:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z/BzFjbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgG2K6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 06:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgG2K6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 06:58:18 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD089C0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 03:58:17 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id p8so4384117vsm.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 03:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nK5MzAuxnrLLTf1gFEuoiVLFsvF02S3WxqXWXquN7Zw=;
        b=Z/BzFjbga5ANtMEPLZ2KnCs7/NeG8UpIu2B8jQ8M2BL0O49bwh+OGBKxiTBzvwRNAA
         Gu6iVk9KOm5SBXE87ZiZmuR38DNVckxKp14bYzW1Am45cJsNBJhhg/AI7yhmIUdyoQWc
         XB2y/fTb3h4oLCRiPk7KWHhDzSy0cxwtDE9Gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nK5MzAuxnrLLTf1gFEuoiVLFsvF02S3WxqXWXquN7Zw=;
        b=NDUhJ91PghKYfAbx+/pnMG17GXZloQRAM0jQNMkXRM9YYLUrIWrvDJBA25baJkVNQq
         UVffUgwurKENFnysphbqSDZFAB53f46MotyjbgyJXnivjaxauYbFiDsmn7jI+XmMqzjp
         2RkyY8A4m6Rdnrmu29Ik2AScm21OD+DUJZ4tjy4Z2NcDdKH1/GflbIub43a3FECSySWe
         AHHVZx6gkN9PSZTGzlJXffBWFWvw+zv+eUEo0tKic207VHefFghmdNy4zIXhFCp6d3Dt
         rt3JPPV7dcyDAa08S0FdF4AMu+XIkX9ZW8YbackEY57x7XA+Sh3QuFkf9M0Kp8w49kKR
         1bmA==
X-Gm-Message-State: AOAM531yEJJ52VbeNuJLs7MPD1YvdCxhkjuGn3IkPVmse5UY8t1xdy9M
        Ej8/A5Q6wOQBkRGOhtL/IZZFC1t9+lQRPriTEZjqpQ==
X-Google-Smtp-Source: ABdhPJwOl8wWWEJIksoM3K8/EzRJs6oF3zTk24wYXwhjl29tUYjlMWaOxLC3GKFiBqP0wzf6UBSOc0KsyP4t1xltRDg=
X-Received: by 2002:a67:2602:: with SMTP id m2mr8867667vsm.1.1596020296942;
 Wed, 29 Jul 2020 03:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <1596012277-8448-1-git-send-email-weiyi.lu@mediatek.com> <1596012277-8448-5-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1596012277-8448-5-git-send-email-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 29 Jul 2020 18:58:06 +0800
Message-ID: <CANMq1KCG1xUan5-=DBZewvTqmUH=p7=nxy0Va=pdYBhAfYhhjQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] clk: mediatek: Add configurable enable control to mtk_pll_data
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Wendell Lin <wendell.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 4:44 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> In all MediaTek PLL design, bit0 of CON0 register is always
> the enable bit.
> However, there's a special case of usbpll on MT8192.
> The enable bit of usbpll is moved to bit2 of other register.
> Add configurable en_reg and pll_en_bit for enable control or
> default 0 where pll data are static variables.
> Hence, CON0_BASE_EN could also be removed.
> And there might have another special case on other chips,
> the enable bit is still on CON0 register but not at bit0.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mtk.h |  2 ++
>  drivers/clk/mediatek/clk-pll.c | 18 +++++++++++-------
>  2 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> index c3d6756..810eb97 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -233,6 +233,8 @@ struct mtk_pll_data {
>         uint32_t pcw_chg_reg;
>         const struct mtk_pll_div_table *div_table;
>         const char *parent_name;
> +       uint32_t en_reg;
> +       uint8_t pll_en_bit;
>  };
>
>  void mtk_clk_register_plls(struct device_node *node,
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> index 3c79e1a..1434e99 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -16,7 +16,6 @@
>  #define REG_CON0               0
>  #define REG_CON1               4
>
> -#define CON0_BASE_EN           BIT(0)
>  #define CON0_PWR_ON            BIT(0)
>  #define CON0_ISO_EN            BIT(1)
>  #define PCW_CHG_MASK           BIT(31)
> @@ -44,6 +43,7 @@ struct mtk_clk_pll {
>         void __iomem    *tuner_en_addr;
>         void __iomem    *pcw_addr;
>         void __iomem    *pcw_chg_addr;
> +       void __iomem    *en_addr;
>         const struct mtk_pll_data *data;
>  };
>
> @@ -56,7 +56,7 @@ static int mtk_pll_is_prepared(struct clk_hw *hw)
>  {
>         struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
>
> -       return (readl(pll->base_addr + REG_CON0) & CON0_BASE_EN) != 0;
> +       return (readl(pll->en_addr) & BIT(pll->data->pll_en_bit)) != 0;
>  }
>
>  static unsigned long __mtk_pll_recalc_rate(struct mtk_clk_pll *pll, u32 fin,
> @@ -247,8 +247,8 @@ static int mtk_pll_prepare(struct clk_hw *hw)
>         writel(r, pll->pwr_addr);
>         udelay(1);
>
> -       r = readl(pll->base_addr + REG_CON0) | CON0_BASE_EN;
> -       writel(r, pll->base_addr + REG_CON0);
> +       r = readl(pll->en_addr) | BIT(pll->data->pll_en_bit);
> +       writel(r, pll->en_addr);
>
>         r = readl(pll->base_addr + REG_CON0) | pll->data->en_mask;
>         writel(r, pll->base_addr + REG_CON0);
> @@ -283,9 +283,9 @@ static void mtk_pll_unprepare(struct clk_hw *hw)
>         r &= ~pll->data->en_mask;
>         writel(r, pll->base_addr + REG_CON0);
>
> -       r = readl(pll->base_addr + REG_CON0);
> -       r &= ~CON0_BASE_EN;
> -       writel(r, pll->base_addr + REG_CON0);
> +       r = readl(pll->en_addr);
> +       r &= ~BIT(pll->data->pll_en_bit);

1 line, but that'll come naturally from the change I requested in the
previous patch.

> +       writel(r, pll->en_addr);
>
>         r = readl(pll->pwr_addr) | CON0_ISO_EN;
>         writel(r, pll->pwr_addr);
> @@ -327,6 +327,10 @@ static struct clk *mtk_clk_register_pll(const struct mtk_pll_data *data,
>                 pll->tuner_addr = base + data->tuner_reg;
>         if (data->tuner_en_reg)
>                 pll->tuner_en_addr = base + data->tuner_en_reg;
> +       if (data->en_reg)
> +               pll->en_addr = base + data->en_reg;
> +       else
> +               pll->en_addr = pll->base_addr + REG_CON0;

Don't you need to set pll->data->pll_en_bit to CON0_BASE_EN here?
(which probably means that you need to add a pll->en_bit field to
struct mtk_clk_pll)

>         pll->hw.init = &init;
>         pll->data = data;
>
> --
> 1.8.1.1.dirty
