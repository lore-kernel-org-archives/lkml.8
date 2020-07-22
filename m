Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAFEC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34C8320787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QoY0E53K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbgGVIwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgGVIwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:52:12 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B8DC0619DE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 01:52:11 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id j186so717935vsd.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 01:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NEeWajGKm67++OZHvKQWCDftAm3bcAVKxtPrqi7rffw=;
        b=QoY0E53KQa71Upiek8hls/OUvj0kY736e/ocwqNkm2YOTtdVNzipKoaZLp97GBkuXo
         Doqx2dWTwA1k9lBGn/7NLerRytfAgT+mjd97SgYacmaoVsYhNezaIIUfQQy3+g+Idt8n
         Bd3KVyo6HEsOuwP1t2w2N/rcxebaONBHw6EFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NEeWajGKm67++OZHvKQWCDftAm3bcAVKxtPrqi7rffw=;
        b=LQASovBHracvbTnVe1fxCIXbCC79y3MePDIa3W2R00LVzXSjv3ivoWb8SwRDm4q7w4
         1x+UWpLpgnVS1MlNFP6jK++sg87fks+zfrUVH1K87Sr6ZOqsgWNZh+iWxzg8k4hxVyud
         r1Qnu6F6yKwqgkdMhMXwME4KsofSg6EXoQ7agwjV6Aon0/Js1r9wPMfk9EZjZzqhL2oq
         N0HdXCyD/jeM2Pd3ANcwIeU+ocfIMhHo5hqXkooELBvPwNDRNxAXA4+yqMvmtJl58SVX
         IOhQatNLu9kYgwqyvdKPcANBrLtLYMvVl8bEyuojjjkpr1lqklMT0jB/inxcdsE2wLba
         d3vw==
X-Gm-Message-State: AOAM532XVDOe0ayCcwg5cAxX0YIxICUaMtbYZbZrH+YZvFb1SNx9mqU+
        TdLqmjauMXFWB/KmUCj+W5B/daudCWBdU/3ggRrU6w==
X-Google-Smtp-Source: ABdhPJwu+0fS9ZykBs/N5sJKhnQyXgH73i6yXfke4Yx2a9+dxmIhOlX9pBc2nAbsMsa/h4RUUc2ZE+/z8zNUIiSYdSo=
X-Received: by 2002:a67:e0c3:: with SMTP id m3mr24201706vsl.1.1595407930888;
 Wed, 22 Jul 2020 01:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <1595400601-26220-1-git-send-email-weiyi.lu@mediatek.com> <1595400601-26220-4-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1595400601-26220-4-git-send-email-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 22 Jul 2020 16:51:59 +0800
Message-ID: <CANMq1KC5i8GU2zMxk+NvY5hF7Qvd-Jx-+pvY2cXfqzb=X-BWRQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] clk: mediatek: Add configurable enable control to mtk_pll_data
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Wendell Lin <wendell.lin@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 2:50 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> In all MediaTek PLL design, bit 0 of CON0 register is always
> the enable bit.
> However, there's a special case of usbpll on MT8192.
> The enable bit of usbpll is moved to bit 2 of other register.
> Add configurable en_reg and base_en_bit for enable control or
> using the default if without setting in pll data.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mtk.h |  2 ++
>  drivers/clk/mediatek/clk-pll.c | 26 ++++++++++++++++++++++----
>  2 files changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> index c3d6756..8bb0b3d 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -233,6 +233,8 @@ struct mtk_pll_data {
>         uint32_t pcw_chg_reg;
>         const struct mtk_pll_div_table *div_table;
>         const char *parent_name;
> +       uint32_t en_reg;
> +       uint8_t base_en_bit;
>  };
>
>  void mtk_clk_register_plls(struct device_node *node,
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> index f440f2cd..b8ccd42 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -44,6 +44,7 @@ struct mtk_clk_pll {
>         void __iomem    *tuner_en_addr;
>         void __iomem    *pcw_addr;
>         void __iomem    *pcw_chg_addr;
> +       void __iomem    *en_addr;
>         const struct mtk_pll_data *data;
>  };
>
> @@ -56,7 +57,10 @@ static int mtk_pll_is_prepared(struct clk_hw *hw)
>  {
>         struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
>
> -       return (readl(pll->base_addr + REG_CON0) & CON0_BASE_EN) != 0;
> +       if (pll->en_addr)
> +               return (readl(pll->en_addr) & BIT(pll->data->base_en_bit)) != 0;
> +       else
> +               return (readl(pll->base_addr + REG_CON0) & CON0_BASE_EN) != 0;
>  }
>
>  static unsigned long __mtk_pll_recalc_rate(struct mtk_clk_pll *pll, u32 fin,
> @@ -251,6 +255,12 @@ static int mtk_pll_prepare(struct clk_hw *hw)
>         r |= pll->data->en_mask;
>         writel(r, pll->base_addr + REG_CON0);
>

This is not a new change, but I'm wondering if the asymmetry is
intentional here, that is, prepare sets bit pll->data->en_mask of
REG_CON0; unprepare clears CON0_BASE_EN of REG_CON0.

With this patch, if pll->en_addr is set, you set both
pll->data->en_mask _and_ pll->data->base_en_bit, and clear only
pll->data->base_en_bit.

> +       if (pll->en_addr) {
> +               r = readl(pll->en_addr);
> +               r |= BIT(pll->data->base_en_bit);
> +               writel(r, pll->en_addr);
> +       }
> +
>         __mtk_pll_tuner_enable(pll);
>
>         udelay(20);
> @@ -277,9 +287,15 @@ static void mtk_pll_unprepare(struct clk_hw *hw)
>
>         __mtk_pll_tuner_disable(pll);
>
> -       r = readl(pll->base_addr + REG_CON0);
> -       r &= ~CON0_BASE_EN;
> -       writel(r, pll->base_addr + REG_CON0);
> +       if (pll->en_addr) {
> +               r = readl(pll->en_addr);
> +               r &= ~BIT(pll->data->base_en_bit);
> +               writel(r, pll->en_addr);
> +       } else {
> +               r = readl(pll->base_addr + REG_CON0);
> +               r &= ~CON0_BASE_EN;
> +               writel(r, pll->base_addr + REG_CON0);
> +       }
>
>         r = readl(pll->pwr_addr) | CON0_ISO_EN;
>         writel(r, pll->pwr_addr);
> @@ -321,6 +337,8 @@ static struct clk *mtk_clk_register_pll(const struct mtk_pll_data *data,
>                 pll->tuner_addr = base + data->tuner_reg;
>         if (data->tuner_en_reg)
>                 pll->tuner_en_addr = base + data->tuner_en_reg;
> +       if (data->en_reg)
> +               pll->en_addr = base + data->en_reg;

If the answer to my question above holds (asymmetry is not
intentional), this patch/the code could be simplified a lot if you
also added a pll->en_bit member, and, here, did this:

if (pll->en_reg) {
   pll->en_addr = base + data->en_reg;
   pll->end_bit = data->en_bit;
} else {
   pll->en_addr = pll->base_addr + REG_CON0;
   pll->en_bit = CON0_BASE_EN;
}

>         pll->hw.init = &init;
>         pll->data = data;
>
> --
> 1.8.1.1.dirty
