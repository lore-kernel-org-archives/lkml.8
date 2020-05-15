Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB41C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04E20206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vcmQAMrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgEOKcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbgEOKca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:32:30 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F754C061A0C;
        Fri, 15 May 2020 03:32:29 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id h10so2074784iob.10;
        Fri, 15 May 2020 03:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mp1O72Xdq00O8JgDXWC/mDotxQHEbyc0hg/iAsVvAgY=;
        b=vcmQAMrEzsV4FG1L5QpLXkqBOrQ5OWuYdGlR8+ygcxJg+F5fPgRqdFWYKvqJJgU4mT
         zG2aAW2Aaxx8HmPIlfVGBlGU+Tu3x3HW3wNhOb0imgignadU5yAYy5edOXWWGXi/0Na4
         0SCSsnOjKh6NZ89GJ/Z1th6BYn3bZVjgPzwjCcYTGdFvmRZ+d8292zz6Fa+rLu1nDRVS
         nqtULSE9iytN1Ux/XqwoX0F6IiuTkU6cBgvLoTaXjmrYNhB/2fbpLk/00zSQBHvVF91s
         Hv+b2E+JxXaSCT1p0PXKvweG2iD7xl6BSOXRJs6N8uGBGhhsdZ7fLsuZ6pWRxwXozdGD
         zlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mp1O72Xdq00O8JgDXWC/mDotxQHEbyc0hg/iAsVvAgY=;
        b=tIxLynNDKCBNNubK2SV154a6aqgDs+TLD79/uYoyXwykQBAl08x80bK1Rzbpg09eMf
         Lw0EYB9dGstitqYlA1JgmGr3yuXNnFOW4vm9gV62UYLT1/+/xow9EOje4kT8US1LXB9M
         O5DFGNDpeLtdpx1YAOE1wtcubFaVGjqXKul+aoXG+0LNFmYV2eNTfE4bg+hTL7kS7KAk
         TMAm8pWVN6gkakdyEkBEQ1XVmsgGL+xyzu2yJucpsAYVZgstbT92kGd9b3b8Gx6zV909
         N/g92dAjO6zyeSD6BptW1cxk1zhs4PGMsiW4sSFUGspqMHr60lwFbRhNClYYTrSty+4R
         5SuA==
X-Gm-Message-State: AOAM530dhGc5N3Vtd8zmP2vyWO8UeqfMo+DNxoWhAjTk1k4INdNDbJZC
        TbX4JPAPpbo682l9DibMZt3kL1PJZJmeOLQCkYM=
X-Google-Smtp-Source: ABdhPJySFDwer7KjH89ACOdbQCrAFJYmz3PmcTnEmry2cPWkqSChoUu+TiNgN9tnSrdVOfv81ypAYcyv/WXFLRq7XEE=
X-Received: by 2002:a02:ac1:: with SMTP id 184mr2566280jaw.137.1589538748835;
 Fri, 15 May 2020 03:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <1589267017-17294-1-git-send-email-dillon.minfei@gmail.com>
 <1589267017-17294-5-git-send-email-dillon.minfei@gmail.com> <158949014721.215346.12197373767247910756@swboyd.mtv.corp.google.com>
In-Reply-To: <158949014721.215346.12197373767247910756@swboyd.mtv.corp.google.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Fri, 15 May 2020 18:31:52 +0800
Message-ID: <CAL9mu0J7t5Qbe2VQexn8=ZDbcOiCzc0cSnfZRKTjeM5Uyi_x-A@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] clk: stm32: Fix stm32f429 ltdc driver loading hang
 in clk set rate. keep ltdc clk running after kernel startup
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Dave Airlie <airlied@linux.ie>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, thierry.reding@gmail.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

thanks for reviewing.

On Fri, May 15, 2020 at 5:02 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting dillon.minfei@gmail.com (2020-05-12 00:03:36)
> > From: dillon min <dillon.minfei@gmail.com>
> >
> > as store stm32f4_rcc_register_pll return to the wrong offset of clks,
>
> Use () on functions, i.e. stm32f4_rcc_register_pll().
ok
>
> > so ltdc gate clk is null. need change clks[PLL_VCO_SAI] to clks[PLL_SAI]
>
> And quote variables like 'clks[PLL_VCO_SAI]'
ok
>
> >
> > add CLK_IGNORE_UNUSED for ltdc to make sure clk not be freed by
> > clk_disable_unused
>
> clk_disable_unused() doesn't free anything. Why does ltdc not need to be
> turned off if it isn't used? Is it critical to system operation? Should
> it be marked with the critical clk flag then? The CLK_IGNORE_UNUSED flag
> is almost always wrong to use.

Yes, you are right. thanks. CLK_IGNORE_UNUSED just hide the root
cause. after deeper debugging.
i need to drop the last changes , they are not the root cause.

post diff and analyse here first, i will resubmit clk's changes in
next patchset with gyro and ili9341.

--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -129,8 +129,6 @@ static const struct stm32f4_gate_data
stm32f429_gates[] __initconst = {
        { STM32F4_RCC_APB2ENR, 20,      "spi5",         "apb2_div" },
        { STM32F4_RCC_APB2ENR, 21,      "spi6",         "apb2_div" },
        { STM32F4_RCC_APB2ENR, 22,      "sai1",         "apb2_div" },
-       { STM32F4_RCC_APB2ENR, 26,      "ltdc",         "apb2_div",
-               CLK_IGNORE_UNUSED },
 };

 static const struct stm32f4_gate_data stm32f469_gates[] __initconst = {
@@ -558,13 +556,13 @@ static const struct clk_div_table post_divr_table[] = {

 #define MAX_POST_DIV 3
 static const struct stm32f4_pll_post_div_data  post_div_data[MAX_POST_DIV] = {
-       { CLK_I2SQ_PDIV, PLL_I2S, "plli2s-q-div", "plli2s-q",
+       { CLK_I2SQ_PDIV, PLL_VCO_I2S, "plli2s-q-div", "plli2s-q",
                CLK_SET_RATE_PARENT, STM32F4_RCC_DCKCFGR, 0, 5, 0, NULL},

-       { CLK_SAIQ_PDIV, PLL_SAI, "pllsai-q-div", "pllsai-q",
+       { CLK_SAIQ_PDIV, PLL_VCO_SAI, "pllsai-q-div", "pllsai-q",
                CLK_SET_RATE_PARENT, STM32F4_RCC_DCKCFGR, 8, 5, 0, NULL },

-       { NO_IDX, PLL_SAI, "pllsai-r-div", "pllsai-r", CLK_SET_RATE_PARENT,
+       { NO_IDX, PLL_VCO_SAI, "pllsai-r-div", "pllsai-r", CLK_SET_RATE_PARENT,
                STM32F4_RCC_DCKCFGR, 16, 2, 0, post_divr_table },
 };

@@ -1758,7 +1756,7 @@ static void __init stm32f4_rcc_init(struct
device_node *np)
        clks[PLL_VCO_I2S] = stm32f4_rcc_register_pll("vco_in",
                        &data->pll_data[1], &stm32f4_clk_lock);

-       clks[PLL_SAI] = stm32f4_rcc_register_pll("vco_in",
+       clks[PLL_VCO_SAI] = stm32f4_rcc_register_pll("vco_in",
                        &data->pll_data[2], &stm32f4_clk_lock);

        for (n = 0; n < MAX_POST_DIV; n++) {

issue 1: ili9341 hang in clk set rate, the root cause should be
PLL_VCO_SAI, PLL_SAI mismatch
for 'clks[]'

1, first at stm32f4_rcc_init() ,
    clks[PLL_VCO_SAI] = stm32f4_rcc_register_pll("vco_in",
                        &data->pll_data[2], &stm32f4_clk_lock);
   the clk_hw from stm32f4_rcc_register_pll() is store to 'clks[7]', defined in
   'include/dt-bindings/clock/stm32fx-clock.h'

2, next
hw = clk_register_pll_div(post_div->name,
                                post_div->parent,
                                post_div->flag,
                                base + post_div->offset,
                                post_div->shift,
                                post_div->width,
                                post_div->flag_div,
                                post_div->div_table,
                                clks[post_div->pll_num],
                                &stm32f4_clk_lock);
the 'clks[post_div->pll_num]', the pll_num is PLL_SAI, the value is 2,
defined at
enum {
        PLL,
        PLL_I2S,
        PLL_SAI,
};
'post_div_data[]'

so 7 != 2 offset of 'clks[]', input the wrong 'clks[]' to
clk_register_pll_div. cause to_clk_gate result is null,
crashed in ltdc driver's loading.

issue 2: clk_disable_unused() turn off ltdc clock.
1, ltdc clk is defined in 'stm32f429_gates[]', register to clk core,
but there is no user to use it.
    ltdc driver use dts binding name "lcd", connect to CLK_LCD, then
aux clk 'lcd-tft '
2, as no one use 'stm32f429_gates[]' s ltdc clock , so the
enable_count is zero, after kernel startup
    it's been turn off by clk_disable_unused() is fine.

my chages for this is remove the ltdc from 'stm32f429_gates[]'
but this modification still need 'clk-stm32f4.c''s maintainer to check
if there is side effect.

>
> >
> > Signed-off-by: dillon min <dillon.minfei@gmail.com>
> > ---
> >  drivers/clk/clk-stm32f4.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
> > index 18117ce..0ba73de 100644
> > --- a/drivers/clk/clk-stm32f4.c
> > +++ b/drivers/clk/clk-stm32f4.c
> > @@ -129,7 +129,8 @@ static const struct stm32f4_gate_data stm32f429_gates[] __initconst = {
> >         { STM32F4_RCC_APB2ENR, 20,      "spi5",         "apb2_div" },
> >         { STM32F4_RCC_APB2ENR, 21,      "spi6",         "apb2_div" },
> >         { STM32F4_RCC_APB2ENR, 22,      "sai1",         "apb2_div" },
> > -       { STM32F4_RCC_APB2ENR, 26,      "ltdc",         "apb2_div" },
> > +       { STM32F4_RCC_APB2ENR, 26,      "ltdc",         "apb2_div",
> > +               CLK_IGNORE_UNUSED },
> >  };
> >
> >  static const struct stm32f4_gate_data stm32f469_gates[] __initconst = {
> > @@ -1757,7 +1758,7 @@ static void __init stm32f4_rcc_init(struct device_node *np)
> >         clks[PLL_VCO_I2S] = stm32f4_rcc_register_pll("vco_in",
> >                         &data->pll_data[1], &stm32f4_clk_lock);
> >
> > -       clks[PLL_VCO_SAI] = stm32f4_rcc_register_pll("vco_in",
> > +       clks[PLL_SAI] = stm32f4_rcc_register_pll("vco_in",
> >                         &data->pll_data[2], &stm32f4_clk_lock);
> >
> >         for (n = 0; n < MAX_POST_DIV; n++) {
