Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DABFC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FB4A207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JOBHXil0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgGWHwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgGWHwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:52:02 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8309AC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:52:02 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id r63so1501580uar.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z9xX1l7Vei7TNjVZF3Wex9lJJLRz3b9T5V+7MzClC/Y=;
        b=JOBHXil0Q8t2jmxCibCxIZZZYyuw3DVM0slT+REWTKAp/9AOQ28anOa7F6thdWR/py
         j02RkMHNrIZ/nyuvSkrqhp6c9u3cR5DPfkzSDtjExGX7LXeXMzNohAGsnn8FoxLcWTme
         hJF78GsoZ2pTvdTq15H07Cdr3Pnz3vIuCiuhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z9xX1l7Vei7TNjVZF3Wex9lJJLRz3b9T5V+7MzClC/Y=;
        b=gjG4DwsteCVs9gfVG1lZjaeBqMrZoXx97lAdVY4W7fbFBrxDSWM5UPEdCMfWqKCHVG
         Cw24cgOuE2JcoeOD4Uok7mU6XAwFyWBKeSD9JU4tpFy0yH/zX8PnUyW2yTi4vQW9aVFf
         HV96M0fqHNDZy090KwNxh5M1TyLzyp+VPrFoc/Mtikb1SjHo0CB22ap0mjO0a1cmkTGV
         uPks1icFnxPpLXVNmKvKe88wD1keDO+0H6DrsDawrD8K4bF+jHqqqPawq2bcCjU6a22v
         mqP11UcYhjw/PWV8X5Tladl5CKLtf6CIht9MrG6yHWi4dRFJILaXywmvl5urjsJP6M5z
         aOiQ==
X-Gm-Message-State: AOAM531hY7Mfsa96zP979TkLfgncmJkCMM/g7BimIxV5Poo6FrLzr/T6
        0CAnK76z9D2/Lk72YM2ZBzV2uSxjobodjzHRjWQEGA==
X-Google-Smtp-Source: ABdhPJyru1ZxhrdLhgiWdGjkN1uAYJkvsnqlPq22GsPf6iLqWQi/M/gwclh+4l2zaYJKdqz7KszdfCqLPWWLYu+GxC8=
X-Received: by 2002:a9f:3113:: with SMTP id m19mr2930373uab.77.1595490721549;
 Thu, 23 Jul 2020 00:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <1595400601-26220-1-git-send-email-weiyi.lu@mediatek.com>
 <1595400601-26220-4-git-send-email-weiyi.lu@mediatek.com> <CANMq1KC5i8GU2zMxk+NvY5hF7Qvd-Jx-+pvY2cXfqzb=X-BWRQ@mail.gmail.com>
 <1595473043.5077.8.camel@mtksdaap41>
In-Reply-To: <1595473043.5077.8.camel@mtksdaap41>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 23 Jul 2020 15:51:50 +0800
Message-ID: <CANMq1KDzmeMcVQU=i89sa-B4EQbz6OxZP3tDasV-Q__qB_7_9g@mail.gmail.com>
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

On Thu, Jul 23, 2020 at 10:57 AM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> On Wed, 2020-07-22 at 16:51 +0800, Nicolas Boichat wrote:
> > On Wed, Jul 22, 2020 at 2:50 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
> > >
> > > In all MediaTek PLL design, bit 0 of CON0 register is always
> > > the enable bit.
> > > However, there's a special case of usbpll on MT8192.
> > > The enable bit of usbpll is moved to bit 2 of other register.
> > > Add configurable en_reg and base_en_bit for enable control or
> > > using the default if without setting in pll data.
> > >
> > > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > > ---
> > >  drivers/clk/mediatek/clk-mtk.h |  2 ++
> > >  drivers/clk/mediatek/clk-pll.c | 26 ++++++++++++++++++++++----
> > >  2 files changed, 24 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> > > index c3d6756..8bb0b3d 100644
> > > --- a/drivers/clk/mediatek/clk-mtk.h
> > > +++ b/drivers/clk/mediatek/clk-mtk.h
> > > @@ -233,6 +233,8 @@ struct mtk_pll_data {
> > >         uint32_t pcw_chg_reg;
> > >         const struct mtk_pll_div_table *div_table;
> > >         const char *parent_name;
> > > +       uint32_t en_reg;
> > > +       uint8_t base_en_bit;
> > >  };
> > >
> > >  void mtk_clk_register_plls(struct device_node *node,
> > > diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> > > index f440f2cd..b8ccd42 100644
> > > --- a/drivers/clk/mediatek/clk-pll.c
> > > +++ b/drivers/clk/mediatek/clk-pll.c
> > > @@ -44,6 +44,7 @@ struct mtk_clk_pll {
> > >         void __iomem    *tuner_en_addr;
> > >         void __iomem    *pcw_addr;
> > >         void __iomem    *pcw_chg_addr;
> > > +       void __iomem    *en_addr;
> > >         const struct mtk_pll_data *data;
> > >  };
> > >
> > > @@ -56,7 +57,10 @@ static int mtk_pll_is_prepared(struct clk_hw *hw)
> > >  {
> > >         struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
> > >
> > > -       return (readl(pll->base_addr + REG_CON0) & CON0_BASE_EN) != 0;
> > > +       if (pll->en_addr)
> > > +               return (readl(pll->en_addr) & BIT(pll->data->base_en_bit)) != 0;
> > > +       else
> > > +               return (readl(pll->base_addr + REG_CON0) & CON0_BASE_EN) != 0;
> > >  }
> > >
> > >  static unsigned long __mtk_pll_recalc_rate(struct mtk_clk_pll *pll, u32 fin,
> > > @@ -251,6 +255,12 @@ static int mtk_pll_prepare(struct clk_hw *hw)
> > >         r |= pll->data->en_mask;
> > >         writel(r, pll->base_addr + REG_CON0);
> > >
> >
> > This is not a new change, but I'm wondering if the asymmetry is
> > intentional here, that is, prepare sets bit pll->data->en_mask of
> > REG_CON0; unprepare clears CON0_BASE_EN of REG_CON0.
> >
> > With this patch, if pll->en_addr is set, you set both
> > pll->data->en_mask _and_ pll->data->base_en_bit, and clear only
> > pll->data->base_en_bit.
> >
>
> Hi Nicolas,
>
> AFAIK, the asymmetry was intentional.
> en_mask is actually a combination of divider enable mask and the pll
> enable bit(CON0_BASE_EN).
> Even without my patch, it still sets divider enable mask and en_bit, and
> only clears en_bit.
> You could see the pll_data in clk-mt8192.c of patch [4/4]
> Take mainpll as an example,
> the enable mask of mainpll is 0xff000001, where 0xff000000 is the
> divider enable mask and 0x1 is the en_bit
>
> For usbpll in special case, usbpll doesn't have divider enable mask on
> MT8192 so I give nothing(0x00000000) in the en_mask field.
> However, the main reason why I don't skip setting the en_mask of MT8192
> usbpll is that I'd just like to reserve the divider enable mask for any
> special plls with divider enable mask in near future.

Argh, I see, it's a bit of a can of worms, with many special cases...

So I played a bit with 3 examples.

Current situation looks like this:

8183 CLK_APMIXED_ARMPLL_LL
  en_mask = 0x00000001
  en_reg = 0
  base_en_bit = 0

prepare: REG_CON0 |= en_mask
unprepare: REG_CON0 &= ~CON0_BASE_EN (BIT(1))

8192 CLK_APMIXED_UNIVPLL
  en_mask = 0xff000001
  en_reg = 0x039c
  base_en_bit = 0

prepare:
  REG_CON0 |= en_mask
  en_reg |= base_en_bit
unprepare:
  en_reg &= ~base_en_bit

8192 CLK_APMIXED_USBPLL
  en_mask = 0x00000000
  en_reg = 0x03cc
  base_en_bit = 2

prepare:
  REG_CON0 |= en_mask (0)
  en_reg |= base_en_bit
unprepare:
  en_reg &= ~base_en_bit

And I think the logic could still be simplified by _not_ putting
CON0_BASE_EN in en_mask, and updating the CON0 in 2 steps: first all
the bits that are not CON0_BASE_EN, then CON0_BASE_EN. Of course I
assume that's it's fine to do so, but I have no idea.

register_pll() {
   if (!en_addr) {
     en_reg = REG_CON0
     base_en_bit = CON0_BASE_EN
   }
}

prepare() {
    REG_CON0 |= en_mask
    en_reg |= base_en_bit
}

unprepare() {
    en_reg &= ~base_en_bit
}

Then the new clock data:

8183 CLK_APMIXED_ARMPLL_LL
  en_mask = 0x00000000 (CON0_BASE_EN is implicit, but other bits could be set)
  en_reg = 0
  base_en_bit = 0

prepare: {
    REG_CON0 |= en_mask (0x00000000, here, we can skip, but other bits
could be set)
    en_reg |= base_en_bit (REG_CON0 |= CON0_BASE_EN)
}
unprepare: en_reg &= ~base_en_bit (REG_CON0 &= ~CON0_BASE_EN)

8192 CLK_APMIXED_UNIVPLL
  en_mask = 0xff000001 (Note the bit 1 is _not_ dropped here, as it
needs to be set too)
  en_reg = 0x039c
  base_en_bit = 0
(same as above)

8192 CLK_APMIXED_USBPLL
  en_mask = 0x00000000
  en_reg = 0x03cc
  base_en_bit = 2
(same as above)

Now, maybe this is also a bit overcomplicated. Maybe a simpler
solution is just to add a comment in prepare that "r |=
pll->data->en_mask;" is meant to include CON0_BASE_EN in most cases,
and then the code could be ok as-is (just to make sure that the next
person who looks at this code does not think there is a bug...).

>
> > > +       if (pll->en_addr) {
> > > +               r = readl(pll->en_addr);
> > > +               r |= BIT(pll->data->base_en_bit);
> > > +               writel(r, pll->en_addr);
> > > +       }
> > > +
> > >         __mtk_pll_tuner_enable(pll);
> > >
> > >         udelay(20);
> > > @@ -277,9 +287,15 @@ static void mtk_pll_unprepare(struct clk_hw *hw)
> > >
> > >         __mtk_pll_tuner_disable(pll);
> > >
> > > -       r = readl(pll->base_addr + REG_CON0);
> > > -       r &= ~CON0_BASE_EN;
> > > -       writel(r, pll->base_addr + REG_CON0);
> > > +       if (pll->en_addr) {
> > > +               r = readl(pll->en_addr);
> > > +               r &= ~BIT(pll->data->base_en_bit);
> > > +               writel(r, pll->en_addr);
> > > +       } else {
> > > +               r = readl(pll->base_addr + REG_CON0);
> > > +               r &= ~CON0_BASE_EN;
> > > +               writel(r, pll->base_addr + REG_CON0);
> > > +       }
> > >
> > >         r = readl(pll->pwr_addr) | CON0_ISO_EN;
> > >         writel(r, pll->pwr_addr);
> > > @@ -321,6 +337,8 @@ static struct clk *mtk_clk_register_pll(const struct mtk_pll_data *data,
> > >                 pll->tuner_addr = base + data->tuner_reg;
> > >         if (data->tuner_en_reg)
> > >                 pll->tuner_en_addr = base + data->tuner_en_reg;
> > > +       if (data->en_reg)
> > > +               pll->en_addr = base + data->en_reg;
> >
> > If the answer to my question above holds (asymmetry is not
> > intentional), this patch/the code could be simplified a lot if you
> > also added a pll->en_bit member, and, here, did this:
> >
> > if (pll->en_reg) {
> >    pll->en_addr = base + data->en_reg;
> >    pll->end_bit = data->en_bit;
> > } else {
> >    pll->en_addr = pll->base_addr + REG_CON0;
> >    pll->en_bit = CON0_BASE_EN;
> > }
> >
> > >         pll->hw.init = &init;
> > >         pll->data = data;
> > >
> > > --
> > > 1.8.1.1.dirty
>
