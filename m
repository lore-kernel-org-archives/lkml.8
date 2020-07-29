Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6D9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 10:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2CA320663
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 10:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z91/W/q0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgG2Kva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 06:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgG2Kv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 06:51:29 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484F1C0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 03:51:29 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id g4so7471009uaq.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 03:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=karthABgHz/06SSfa3pEHiCH36kVAlZVTNWopP2Sr+s=;
        b=Z91/W/q0YcPwrD4x++arYjKktMes6l4Z/N8wifBp33fUHdgyyGDxnJM2taE9qMtQs8
         0eEn+4O4WvTdQfe6blQzHbc0DxbXu1RlglLZoQjy9Rfa3Y/iZ2GJr7WUTyhAtcOR83fE
         0oGTUXIB1frVGN1xmydOginOpiSlJ1DhApP0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=karthABgHz/06SSfa3pEHiCH36kVAlZVTNWopP2Sr+s=;
        b=Vm8k1QCDieuw5qevGxeJREtnKtmAseEEPJEdGN9G2RsZj0edlERV7jfU+UeWJiXAJ7
         agXEK1Lw/z92McxbydFD+aJdekrGrJDfKesxUm5BtQ1l/YBmBZS2wwdsQoYoXcxuvaSE
         emrNbT517RvEC1fRHPp1vjUYlg/PPVXbbdL4eCb+x4XtKhVouHiBubQVuOKDQRzD4yre
         0qXjRwI5SR6rXGuhw0f2KF7f2yrA0jaIz8TC5TGjAlwIVvl3uL31A70TQKo2jHt5XtiO
         e+cQFXySGDnuWh6Tm6aog9myKsXV1oZEWXvOWXCh8LpkUaBA2MOWlUfosHE54s+AIP8R
         uB5Q==
X-Gm-Message-State: AOAM533eQI/I1JPFmKqDRUpM252mmeNRM3yKv/h+K7qGtFdNZQCGTEwh
        5qS+1dUaCuFahbEDO/qqENDsdEPq/Im/6N0mXpYTPA==
X-Google-Smtp-Source: ABdhPJwumHfNTNKAaOcEPtPgNxU/KU6Z/f7iXMfvX4Ajt2xAO5WFT2V8/KkSd4wRPKDHF16y+VzK80P0x5S9ZQpTyIQ=
X-Received: by 2002:ab0:48:: with SMTP id 66mr24074860uai.40.1596019887636;
 Wed, 29 Jul 2020 03:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <1596012277-8448-1-git-send-email-weiyi.lu@mediatek.com> <1596012277-8448-4-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1596012277-8448-4-git-send-email-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 29 Jul 2020 18:51:16 +0800
Message-ID: <CANMq1KBJ3QgpZ4EuSOWYTpOatsOte5sGkqtSZQs337x3fMFFYw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] clk: mediatek: Fix asymmetrical PLL enable and
 disable control
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
> The en_mask actually is a combination of divider enable mask
> and pll enable bit(bit0).
> Before this patch, we enabled both divider mask and bit0 in prepare(),
> but only cleared the bit0 in unprepare().
> Now, setting the enable register(CON0) in 2 steps: first divider mask,
> then bit0 during prepare(), vice versa.
> Hence, en_mask will only be used as divider enable mask.
> Meanwhile, all the SoC PLL data are updated.

I like this a lot better, most changes look fine, just a few nits.

>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mt2701.c | 26 ++++++++++++------------
>  drivers/clk/mediatek/clk-mt2712.c | 30 ++++++++++++++--------------
>  drivers/clk/mediatek/clk-mt6765.c | 20 +++++++++----------
>  drivers/clk/mediatek/clk-mt6779.c | 24 +++++++++++-----------
>  drivers/clk/mediatek/clk-mt6797.c | 20 +++++++++----------
>  drivers/clk/mediatek/clk-mt7622.c | 18 ++++++++---------
>  drivers/clk/mediatek/clk-mt7629.c | 12 +++++------
>  drivers/clk/mediatek/clk-mt8173.c | 42 ++++++++++++++++++++++++++-------------
>  drivers/clk/mediatek/clk-mt8183.c | 22 ++++++++++----------
>  drivers/clk/mediatek/clk-pll.c    | 10 ++++++++--
>  10 files changed, 122 insertions(+), 102 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
> index 695be0f..10d0b92 100644
> --- a/drivers/clk/mediatek/clk-mt2701.c
> +++ b/drivers/clk/mediatek/clk-mt2701.c
> @@ -934,31 +934,31 @@ static int mtk_pericfg_init(struct platform_device *pdev)
>         }
>
>  static const struct mtk_pll_data apmixed_plls[] = {
> -       PLL(CLK_APMIXED_ARMPLL, "armpll", 0x200, 0x20c, 0x80000001,
> +       PLL(CLK_APMIXED_ARMPLL, "armpll", 0x200, 0x20c, 0x80000000,
>                         PLL_AO, 21, 0x204, 24, 0x0, 0x204, 0),
> -       PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x210, 0x21c, 0xf0000001,
> +       PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x210, 0x21c, 0xf0000000,
>                   HAVE_RST_BAR, 21, 0x210, 4, 0x0, 0x214, 0),
> -       PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x220, 0x22c, 0xf3000001,
> +       PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x220, 0x22c, 0xf3000000,
>                   HAVE_RST_BAR, 7, 0x220, 4, 0x0, 0x224, 14),
> -       PLL(CLK_APMIXED_MMPLL, "mmpll", 0x230, 0x23c, 0x00000001, 0,
> +       PLL(CLK_APMIXED_MMPLL, "mmpll", 0x230, 0x23c, 0x00000000, 0,
>                                 21, 0x230, 4, 0x0, 0x234, 0),
> -       PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x240, 0x24c, 0x00000001, 0,
> +       PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x240, 0x24c, 0x00000000, 0,
>                                 21, 0x240, 4, 0x0, 0x244, 0),
> -       PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x250, 0x25c, 0x00000001, 0,
> +       PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x250, 0x25c, 0x00000000, 0,
>                                 21, 0x250, 4, 0x0, 0x254, 0),
> -       PLL(CLK_APMIXED_AUD1PLL, "aud1pll", 0x270, 0x27c, 0x00000001, 0,
> +       PLL(CLK_APMIXED_AUD1PLL, "aud1pll", 0x270, 0x27c, 0x00000000, 0,
>                                 31, 0x270, 4, 0x0, 0x274, 0),
> -       PLL(CLK_APMIXED_TRGPLL, "trgpll", 0x280, 0x28c, 0x00000001, 0,
> +       PLL(CLK_APMIXED_TRGPLL, "trgpll", 0x280, 0x28c, 0x00000000, 0,
>                                 31, 0x280, 4, 0x0, 0x284, 0),
> -       PLL(CLK_APMIXED_ETHPLL, "ethpll", 0x290, 0x29c, 0x00000001, 0,
> +       PLL(CLK_APMIXED_ETHPLL, "ethpll", 0x290, 0x29c, 0x00000000, 0,
>                                 31, 0x290, 4, 0x0, 0x294, 0),
> -       PLL(CLK_APMIXED_VDECPLL, "vdecpll", 0x2a0, 0x2ac, 0x00000001, 0,
> +       PLL(CLK_APMIXED_VDECPLL, "vdecpll", 0x2a0, 0x2ac, 0x00000000, 0,
>                                 31, 0x2a0, 4, 0x0, 0x2a4, 0),
> -       PLL(CLK_APMIXED_HADDS2PLL, "hadds2pll", 0x2b0, 0x2bc, 0x00000001, 0,
> +       PLL(CLK_APMIXED_HADDS2PLL, "hadds2pll", 0x2b0, 0x2bc, 0x00000000, 0,
>                                 31, 0x2b0, 4, 0x0, 0x2b4, 0),
> -       PLL(CLK_APMIXED_AUD2PLL, "aud2pll", 0x2c0, 0x2cc, 0x00000001, 0,
> +       PLL(CLK_APMIXED_AUD2PLL, "aud2pll", 0x2c0, 0x2cc, 0x00000000, 0,
>                                 31, 0x2c0, 4, 0x0, 0x2c4, 0),
> -       PLL(CLK_APMIXED_TVD2PLL, "tvd2pll", 0x2d0, 0x2dc, 0x00000001, 0,
> +       PLL(CLK_APMIXED_TVD2PLL, "tvd2pll", 0x2d0, 0x2dc, 0x00000000, 0,
>                                 21, 0x2d0, 4, 0x0, 0x2d4, 0),
>  };
>
> diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
> index a3bd9a1..fd81162 100644
> --- a/drivers/clk/mediatek/clk-mt2712.c
> +++ b/drivers/clk/mediatek/clk-mt2712.c
> @@ -1222,38 +1222,38 @@
>  };
>
>  static const struct mtk_pll_data plls[] = {
> -       PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0230, 0x023C, 0xf0000101,
> +       PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0230, 0x023C, 0xf0000100,
>                 HAVE_RST_BAR, 31, 0x0230, 4, 0, 0, 0, 0x0234, 0),
> -       PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x0240, 0x024C, 0xfe000101,
> +       PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x0240, 0x024C, 0xfe000100,
>                 HAVE_RST_BAR, 31, 0x0240, 4, 0, 0, 0, 0x0244, 0),
> -       PLL(CLK_APMIXED_VCODECPLL, "vcodecpll", 0x0320, 0x032C, 0xc0000101,
> +       PLL(CLK_APMIXED_VCODECPLL, "vcodecpll", 0x0320, 0x032C, 0xc0000100,
>                 0, 31, 0x0320, 4, 0, 0, 0, 0x0324, 0),
> -       PLL(CLK_APMIXED_VENCPLL, "vencpll", 0x0280, 0x028C, 0x00000101,
> +       PLL(CLK_APMIXED_VENCPLL, "vencpll", 0x0280, 0x028C, 0x00000100,
>                 0, 31, 0x0280, 4, 0, 0, 0, 0x0284, 0),
> -       PLL(CLK_APMIXED_APLL1, "apll1", 0x0330, 0x0340, 0x00000101,
> +       PLL(CLK_APMIXED_APLL1, "apll1", 0x0330, 0x0340, 0x00000100,
>                 0, 31, 0x0330, 4, 0x0338, 0x0014, 0, 0x0334, 0),
> -       PLL(CLK_APMIXED_APLL2, "apll2", 0x0350, 0x0360, 0x00000101,
> +       PLL(CLK_APMIXED_APLL2, "apll2", 0x0350, 0x0360, 0x00000100,
>                 0, 31, 0x0350, 4, 0x0358, 0x0014, 1, 0x0354, 0),
> -       PLL(CLK_APMIXED_LVDSPLL, "lvdspll", 0x0370, 0x037c, 0x00000101,
> +       PLL(CLK_APMIXED_LVDSPLL, "lvdspll", 0x0370, 0x037c, 0x00000100,
>                 0, 31, 0x0370, 4, 0, 0, 0, 0x0374, 0),
> -       PLL(CLK_APMIXED_LVDSPLL2, "lvdspll2", 0x0390, 0x039C, 0x00000101,
> +       PLL(CLK_APMIXED_LVDSPLL2, "lvdspll2", 0x0390, 0x039C, 0x00000100,
>                 0, 31, 0x0390, 4, 0, 0, 0, 0x0394, 0),
> -       PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0270, 0x027C, 0x00000101,
> +       PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0270, 0x027C, 0x00000100,
>                 0, 31, 0x0270, 4, 0, 0, 0, 0x0274, 0),
> -       PLL(CLK_APMIXED_MSDCPLL2, "msdcpll2", 0x0410, 0x041C, 0x00000101,
> +       PLL(CLK_APMIXED_MSDCPLL2, "msdcpll2", 0x0410, 0x041C, 0x00000100,
>                 0, 31, 0x0410, 4, 0, 0, 0, 0x0414, 0),
> -       PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x0290, 0x029C, 0xc0000101,
> +       PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x0290, 0x029C, 0xc0000100,
>                 0, 31, 0x0290, 4, 0, 0, 0, 0x0294, 0),
> -       PLL_B(CLK_APMIXED_MMPLL, "mmpll", 0x0250, 0x0260, 0x00000101,
> +       PLL_B(CLK_APMIXED_MMPLL, "mmpll", 0x0250, 0x0260, 0x00000100,
>                 0, 31, 0x0250, 4, 0, 0, 0, 0x0254, 0,
>                 mmpll_div_table),
> -       PLL_B(CLK_APMIXED_ARMCA35PLL, "armca35pll", 0x0100, 0x0110, 0xf0000101,
> +       PLL_B(CLK_APMIXED_ARMCA35PLL, "armca35pll", 0x0100, 0x0110, 0xf0000100,
>                 HAVE_RST_BAR, 31, 0x0100, 4, 0, 0, 0, 0x0104, 0,
>                 armca35pll_div_table),
> -       PLL_B(CLK_APMIXED_ARMCA72PLL, "armca72pll", 0x0210, 0x0220, 0x00000101,
> +       PLL_B(CLK_APMIXED_ARMCA72PLL, "armca72pll", 0x0210, 0x0220, 0x00000100,
>                 0, 31, 0x0210, 4, 0, 0, 0, 0x0214, 0,
>                 armca72pll_div_table),
> -       PLL(CLK_APMIXED_ETHERPLL, "etherpll", 0x0300, 0x030C, 0xc0000101,
> +       PLL(CLK_APMIXED_ETHERPLL, "etherpll", 0x0300, 0x030C, 0xc0000100,
>                 0, 31, 0x0300, 4, 0, 0, 0, 0x0304, 0),
>  };
>
> diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
> index db8db1b..097bbc4 100644
> --- a/drivers/clk/mediatek/clk-mt6765.c
> +++ b/drivers/clk/mediatek/clk-mt6765.c
> @@ -747,26 +747,26 @@
>                         _pcw_reg, _pcw_shift, NULL)     \
>
>  static const struct mtk_pll_data plls[] = {
> -       PLL(CLK_APMIXED_ARMPLL_L, "armpll_l", 0x021C, 0x0228, BIT(0),
> +       PLL(CLK_APMIXED_ARMPLL_L, "armpll_l", 0x021C, 0x0228, 0,
>             PLL_AO, 22, 8, 0x0220, 24, 0, 0, 0, 0x0220, 0),
> -       PLL(CLK_APMIXED_ARMPLL, "armpll", 0x020C, 0x0218, BIT(0),
> +       PLL(CLK_APMIXED_ARMPLL, "armpll", 0x020C, 0x0218, 0,
>             PLL_AO, 22, 8, 0x0210, 24, 0, 0, 0, 0x0210, 0),
> -       PLL(CLK_APMIXED_CCIPLL, "ccipll", 0x022C, 0x0238, BIT(0),
> +       PLL(CLK_APMIXED_CCIPLL, "ccipll", 0x022C, 0x0238, 0,
>             PLL_AO, 22, 8, 0x0230, 24, 0, 0, 0, 0x0230, 0),
> -       PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x023C, 0x0248, BIT(0),
> +       PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x023C, 0x0248, 0,
>             (HAVE_RST_BAR | PLL_AO), 22, 8, 0x0240, 24, 0, 0, 0, 0x0240,
>             0),
> -       PLL(CLK_APMIXED_MFGPLL, "mfgpll", 0x024C, 0x0258, BIT(0),
> +       PLL(CLK_APMIXED_MFGPLL, "mfgpll", 0x024C, 0x0258, 0,
>             0, 22, 8, 0x0250, 24, 0, 0, 0, 0x0250, 0),
> -       PLL(CLK_APMIXED_MMPLL, "mmpll", 0x025C, 0x0268, BIT(0),
> +       PLL(CLK_APMIXED_MMPLL, "mmpll", 0x025C, 0x0268, 0,
>             0, 22, 8, 0x0260, 24, 0, 0, 0, 0x0260, 0),
> -       PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x026C, 0x0278, BIT(0),
> +       PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x026C, 0x0278, 0,
>             HAVE_RST_BAR, 22, 8, 0x0270, 24, 0, 0, 0, 0x0270, 0),
> -       PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x027C, 0x0288, BIT(0),
> +       PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x027C, 0x0288, 0,
>             0, 22, 8, 0x0280, 24, 0, 0, 0, 0x0280, 0),
> -       PLL(CLK_APMIXED_APLL1, "apll1", 0x028C, 0x029C, BIT(0),
> +       PLL(CLK_APMIXED_APLL1, "apll1", 0x028C, 0x029C, 0,
>             0, 32, 8, 0x0290, 24, 0x0040, 0x000C, 0, 0x0294, 0),
> -       PLL(CLK_APMIXED_MPLL, "mpll", 0x02A0, 0x02AC, BIT(0),
> +       PLL(CLK_APMIXED_MPLL, "mpll", 0x02A0, 0x02AC, 0,
>             PLL_AO, 22, 8, 0x02A4, 24, 0, 0, 0, 0x02A4, 0),
>  };
>
> diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
> index 9766ccc..d8444ed 100644
> --- a/drivers/clk/mediatek/clk-mt6779.c
> +++ b/drivers/clk/mediatek/clk-mt6779.c
> @@ -1178,33 +1178,33 @@
>                         _pcw_chg_reg, NULL)
>
>  static const struct mtk_pll_data plls[] = {
> -       PLL(CLK_APMIXED_ARMPLL_LL, "armpll_ll", 0x0200, 0x020C, BIT(0),
> +       PLL(CLK_APMIXED_ARMPLL_LL, "armpll_ll", 0x0200, 0x020C, 0,
>             PLL_AO, 0, 22, 8, 0x0204, 24, 0, 0, 0, 0x0204, 0, 0),
> -       PLL(CLK_APMIXED_ARMPLL_BL, "armpll_bl", 0x0210, 0x021C, BIT(0),
> +       PLL(CLK_APMIXED_ARMPLL_BL, "armpll_bl", 0x0210, 0x021C, 0,
>             PLL_AO, 0, 22, 8, 0x0214, 24, 0, 0, 0, 0x0214, 0, 0),
> -       PLL(CLK_APMIXED_CCIPLL, "ccipll", 0x02A0, 0x02AC, BIT(0),
> +       PLL(CLK_APMIXED_CCIPLL, "ccipll", 0x02A0, 0x02AC, 0,
>             PLL_AO, 0, 22, 8, 0x02A4, 24, 0, 0, 0, 0x02A4, 0, 0),
> -       PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0230, 0x023C, BIT(0),
> +       PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0230, 0x023C, 0,
>             (HAVE_RST_BAR), BIT(24), 22, 8, 0x0234, 24, 0, 0, 0,
>             0x0234, 0, 0),
> -       PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x0240, 0x024C, BIT(0),
> +       PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x0240, 0x024C, 0,
>             (HAVE_RST_BAR), BIT(24), 22, 8, 0x0244, 24,
>             0, 0, 0, 0x0244, 0, 0),
> -       PLL(CLK_APMIXED_MFGPLL, "mfgpll", 0x0250, 0x025C, BIT(0),
> +       PLL(CLK_APMIXED_MFGPLL, "mfgpll", 0x0250, 0x025C, 0,
>             0, 0, 22, 8, 0x0254, 24, 0, 0, 0, 0x0254, 0, 0),
> -       PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0260, 0x026C, BIT(0),
> +       PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0260, 0x026C, 0,
>             0, 0, 22, 8, 0x0264, 24, 0, 0, 0, 0x0264, 0, 0),
> -       PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x0270, 0x027C, BIT(0),
> +       PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x0270, 0x027C, 0,
>             0, 0, 22, 8, 0x0274, 24, 0, 0, 0, 0x0274, 0, 0),
> -       PLL(CLK_APMIXED_ADSPPLL, "adsppll", 0x02b0, 0x02bC, BIT(0),
> +       PLL(CLK_APMIXED_ADSPPLL, "adsppll", 0x02b0, 0x02bC, 0,
>             (HAVE_RST_BAR), BIT(23), 22, 8, 0x02b4, 24,
>             0, 0, 0, 0x02b4, 0, 0),
> -       PLL(CLK_APMIXED_MMPLL, "mmpll", 0x0280, 0x028C, BIT(0),
> +       PLL(CLK_APMIXED_MMPLL, "mmpll", 0x0280, 0x028C, 0,
>             (HAVE_RST_BAR), BIT(23), 22, 8, 0x0284, 24,
>             0, 0, 0, 0x0284, 0, 0),
> -       PLL(CLK_APMIXED_APLL1, "apll1", 0x02C0, 0x02D0, BIT(0),
> +       PLL(CLK_APMIXED_APLL1, "apll1", 0x02C0, 0x02D0, 0,
>             0, 0, 32, 8, 0x02C0, 1, 0, 0x14, 0, 0x02C4, 0, 0x2C0),
> -       PLL(CLK_APMIXED_APLL2, "apll2", 0x02D4, 0x02E4, BIT(0),
> +       PLL(CLK_APMIXED_APLL2, "apll2", 0x02D4, 0x02E4, 0,
>             0, 0, 32, 8, 0x02D4, 1, 0, 0x14, 1, 0x02D8, 0, 0x02D4),
>  };
>
> diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
> index f35389a..4395423 100644
> --- a/drivers/clk/mediatek/clk-mt6797.c
> +++ b/drivers/clk/mediatek/clk-mt6797.c
> @@ -638,25 +638,25 @@ static int mtk_infrasys_init(struct platform_device *pdev)
>                         NULL)
>
>  static const struct mtk_pll_data plls[] = {
> -       PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0220, 0x022C, 0xF0000101, PLL_AO,
> +       PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0220, 0x022C, 0xF0000100, PLL_AO,
>             21, 0x220, 4, 0x0, 0x224, 0),
> -       PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x0230, 0x023C, 0xFE000011, 0, 7,
> +       PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x0230, 0x023C, 0xFE000010, 0, 7,
>             0x230, 4, 0x0, 0x234, 14),
> -       PLL(CLK_APMIXED_MFGPLL, "mfgpll", 0x0240, 0x024C, 0x00000101, 0, 21,
> +       PLL(CLK_APMIXED_MFGPLL, "mfgpll", 0x0240, 0x024C, 0x00000100, 0, 21,
>             0x244, 24, 0x0, 0x244, 0),
> -       PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0250, 0x025C, 0x00000121, 0, 21,
> +       PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0250, 0x025C, 0x00000120, 0, 21,
>             0x250, 4, 0x0, 0x254, 0),
> -       PLL(CLK_APMIXED_IMGPLL, "imgpll", 0x0260, 0x026C, 0x00000121, 0, 21,
> +       PLL(CLK_APMIXED_IMGPLL, "imgpll", 0x0260, 0x026C, 0x00000120, 0, 21,
>             0x260, 4, 0x0, 0x264, 0),
> -       PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x0270, 0x027C, 0xC0000121, 0, 21,
> +       PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x0270, 0x027C, 0xC0000120, 0, 21,
>             0x270, 4, 0x0, 0x274, 0),
> -       PLL(CLK_APMIXED_CODECPLL, "codecpll", 0x0290, 0x029C, 0x00000121, 0, 21,
> +       PLL(CLK_APMIXED_CODECPLL, "codecpll", 0x0290, 0x029C, 0x00000120, 0, 21,
>             0x290, 4, 0x0, 0x294, 0),
> -       PLL(CLK_APMIXED_VDECPLL, "vdecpll", 0x02E4, 0x02F0, 0x00000121, 0, 21,
> +       PLL(CLK_APMIXED_VDECPLL, "vdecpll", 0x02E4, 0x02F0, 0x00000120, 0, 21,
>             0x2E4, 4, 0x0, 0x2E8, 0),
> -       PLL(CLK_APMIXED_APLL1, "apll1", 0x02A0, 0x02B0, 0x00000131, 0, 31,
> +       PLL(CLK_APMIXED_APLL1, "apll1", 0x02A0, 0x02B0, 0x00000130, 0, 31,
>             0x2A0, 4, 0x2A8, 0x2A4, 0),
> -       PLL(CLK_APMIXED_APLL2, "apll2", 0x02B4, 0x02C4, 0x00000131, 0, 31,
> +       PLL(CLK_APMIXED_APLL2, "apll2", 0x02B4, 0x02C4, 0x00000130, 0, 31,
>             0x2B4, 4, 0x2BC, 0x2B8, 0),
>  };
>
> diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
> index ef5947e1..3ac222c 100644
> --- a/drivers/clk/mediatek/clk-mt7622.c
> +++ b/drivers/clk/mediatek/clk-mt7622.c
> @@ -328,23 +328,23 @@
>  };
>
>  static const struct mtk_pll_data plls[] = {
> -       PLL(CLK_APMIXED_ARMPLL, "armpll", 0x0200, 0x020C, 0x00000001,
> +       PLL(CLK_APMIXED_ARMPLL, "armpll", 0x0200, 0x020C, 0x00000000,

Or just 0 for consistency with clk-mt6779.c?

>             PLL_AO, 21, 0x0204, 24, 0, 0x0204, 0),
> -       PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0210, 0x021C, 0x00000001,
> +       PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0210, 0x021C, 0x00000000,
>             HAVE_RST_BAR, 21, 0x0214, 24, 0, 0x0214, 0),
> -       PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x0220, 0x022C, 0x00000001,
> +       PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x0220, 0x022C, 0x00000000,
>             HAVE_RST_BAR, 7, 0x0224, 24, 0, 0x0224, 14),
> -       PLL(CLK_APMIXED_ETH1PLL, "eth1pll", 0x0300, 0x0310, 0x00000001,
> +       PLL(CLK_APMIXED_ETH1PLL, "eth1pll", 0x0300, 0x0310, 0x00000000,
>             0, 21, 0x0300, 1, 0, 0x0304, 0),
> -       PLL(CLK_APMIXED_ETH2PLL, "eth2pll", 0x0314, 0x0320, 0x00000001,
> +       PLL(CLK_APMIXED_ETH2PLL, "eth2pll", 0x0314, 0x0320, 0x00000000,
>             0, 21, 0x0314, 1, 0, 0x0318, 0),
> -       PLL(CLK_APMIXED_AUD1PLL, "aud1pll", 0x0324, 0x0330, 0x00000001,
> +       PLL(CLK_APMIXED_AUD1PLL, "aud1pll", 0x0324, 0x0330, 0x00000000,
>             0, 31, 0x0324, 1, 0, 0x0328, 0),
> -       PLL(CLK_APMIXED_AUD2PLL, "aud2pll", 0x0334, 0x0340, 0x00000001,
> +       PLL(CLK_APMIXED_AUD2PLL, "aud2pll", 0x0334, 0x0340, 0x00000000,
>             0, 31, 0x0334, 1, 0, 0x0338, 0),
> -       PLL(CLK_APMIXED_TRGPLL, "trgpll", 0x0344, 0x0354, 0x00000001,
> +       PLL(CLK_APMIXED_TRGPLL, "trgpll", 0x0344, 0x0354, 0x00000000,
>             0, 21, 0x0344, 1, 0, 0x0348, 0),
> -       PLL(CLK_APMIXED_SGMIPLL, "sgmipll", 0x0358, 0x0368, 0x00000001,
> +       PLL(CLK_APMIXED_SGMIPLL, "sgmipll", 0x0358, 0x0368, 0x00000000,
>             0, 21, 0x0358, 1, 0, 0x035C, 0),
>  };
>
> diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
> index b73bdf1..2d434a9 100644
> --- a/drivers/clk/mediatek/clk-mt7629.c
> +++ b/drivers/clk/mediatek/clk-mt7629.c
> @@ -335,17 +335,17 @@
>  };
>
>  static const struct mtk_pll_data plls[] = {
> -       PLL(CLK_APMIXED_ARMPLL, "armpll", 0x0200, 0x020C, 0x00000001,
> +       PLL(CLK_APMIXED_ARMPLL, "armpll", 0x0200, 0x020C, 0x00000000,

ditto

>             0, 21, 0x0204, 24, 0, 0x0204, 0),
> -       PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0210, 0x021C, 0x00000001,
> +       PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0210, 0x021C, 0x00000000,
>             HAVE_RST_BAR, 21, 0x0214, 24, 0, 0x0214, 0),
> -       PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x0220, 0x022C, 0x00000001,
> +       PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x0220, 0x022C, 0x00000000,
>             HAVE_RST_BAR, 7, 0x0224, 24, 0, 0x0224, 14),
> -       PLL(CLK_APMIXED_ETH1PLL, "eth1pll", 0x0300, 0x0310, 0x00000001,
> +       PLL(CLK_APMIXED_ETH1PLL, "eth1pll", 0x0300, 0x0310, 0x00000000,
>             0, 21, 0x0300, 1, 0, 0x0304, 0),
> -       PLL(CLK_APMIXED_ETH2PLL, "eth2pll", 0x0314, 0x0320, 0x00000001,
> +       PLL(CLK_APMIXED_ETH2PLL, "eth2pll", 0x0314, 0x0320, 0x00000000,
>             0, 21, 0x0314, 1, 0, 0x0318, 0),
> -       PLL(CLK_APMIXED_SGMIPLL, "sgmipll", 0x0358, 0x0368, 0x00000001,
> +       PLL(CLK_APMIXED_SGMIPLL, "sgmipll", 0x0358, 0x0368, 0x00000000,
>             0, 21, 0x0358, 1, 0, 0x035C, 0),
>  };
>
> diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
> index 8f898ac..92d8bdd 100644
> --- a/drivers/clk/mediatek/clk-mt8173.c
> +++ b/drivers/clk/mediatek/clk-mt8173.c
> @@ -972,20 +972,34 @@ struct mtk_clk_usb {
>  };
>
>  static const struct mtk_pll_data plls[] = {
> -       PLL(CLK_APMIXED_ARMCA15PLL, "armca15pll", 0x200, 0x20c, 0x00000001, 0, 21, 0x204, 24, 0x0, 0x204, 0),

Why reflow? 100 chars is fine nowadays. (and also it's hard to review now ,-P)

> -       PLL(CLK_APMIXED_ARMCA7PLL, "armca7pll", 0x210, 0x21c, 0x00000001, 0, 21, 0x214, 24, 0x0, 0x214, 0),
> -       PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x220, 0x22c, 0xf0000101, HAVE_RST_BAR, 21, 0x220, 4, 0x0, 0x224, 0),
> -       PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x230, 0x23c, 0xfe000001, HAVE_RST_BAR, 7, 0x230, 4, 0x0, 0x234, 14),
> -       PLL_B(CLK_APMIXED_MMPLL, "mmpll", 0x240, 0x24c, 0x00000001, 0, 21, 0x244, 24, 0x0, 0x244, 0, mmpll_div_table),
> -       PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x250, 0x25c, 0x00000001, 0, 21, 0x250, 4, 0x0, 0x254, 0),
> -       PLL(CLK_APMIXED_VENCPLL, "vencpll", 0x260, 0x26c, 0x00000001, 0, 21, 0x260, 4, 0x0, 0x264, 0),
> -       PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x270, 0x27c, 0x00000001, 0, 21, 0x270, 4, 0x0, 0x274, 0),
> -       PLL(CLK_APMIXED_MPLL, "mpll", 0x280, 0x28c, 0x00000001, 0, 21, 0x280, 4, 0x0, 0x284, 0),
> -       PLL(CLK_APMIXED_VCODECPLL, "vcodecpll", 0x290, 0x29c, 0x00000001, 0, 21, 0x290, 4, 0x0, 0x294, 0),
> -       PLL(CLK_APMIXED_APLL1, "apll1", 0x2a0, 0x2b0, 0x00000001, 0, 31, 0x2a0, 4, 0x2a4, 0x2a4, 0),
> -       PLL(CLK_APMIXED_APLL2, "apll2", 0x2b4, 0x2c4, 0x00000001, 0, 31, 0x2b4, 4, 0x2b8, 0x2b8, 0),
> -       PLL(CLK_APMIXED_LVDSPLL, "lvdspll", 0x2d0, 0x2dc, 0x00000001, 0, 21, 0x2d0, 4, 0x0, 0x2d4, 0),
> -       PLL(CLK_APMIXED_MSDCPLL2, "msdcpll2", 0x2f0, 0x2fc, 0x00000001, 0, 21, 0x2f0, 4, 0x0, 0x2f4, 0),
> +       PLL(CLK_APMIXED_ARMCA15PLL, "armca15pll", 0x200, 0x20c, 0x00000000,
> +               0, 21, 0x204, 24, 0x0, 0x204, 0),
> +       PLL(CLK_APMIXED_ARMCA7PLL, "armca7pll", 0x210, 0x21c, 0x00000000,
> +               0, 21, 0x214, 24, 0x0, 0x214, 0),
> +       PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x220, 0x22c, 0xf0000100,
> +               HAVE_RST_BAR, 21, 0x220, 4, 0x0, 0x224, 0),
> +       PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x230, 0x23c, 0xfe000000,
> +               HAVE_RST_BAR, 7, 0x230, 4, 0x0, 0x234, 14),
> +       PLL_B(CLK_APMIXED_MMPLL, "mmpll", 0x240, 0x24c, 0x00000000,
> +               0, 21, 0x244, 24, 0x0, 0x244, 0, mmpll_div_table),
> +       PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x250, 0x25c, 0x00000000,
> +               0, 21, 0x250, 4, 0x0, 0x254, 0),
> +       PLL(CLK_APMIXED_VENCPLL, "vencpll", 0x260, 0x26c, 0x00000000,
> +               0, 21, 0x260, 4, 0x0, 0x264, 0),
> +       PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x270, 0x27c, 0x00000000,
> +               0, 21, 0x270, 4, 0x0, 0x274, 0),
> +       PLL(CLK_APMIXED_MPLL, "mpll", 0x280, 0x28c, 0x00000000,
> +               0, 21, 0x280, 4, 0x0, 0x284, 0),
> +       PLL(CLK_APMIXED_VCODECPLL, "vcodecpll", 0x290, 0x29c, 0x00000000,
> +               0, 21, 0x290, 4, 0x0, 0x294, 0),
> +       PLL(CLK_APMIXED_APLL1, "apll1", 0x2a0, 0x2b0, 0x00000000,
> +               0, 31, 0x2a0, 4, 0x2a4, 0x2a4, 0),
> +       PLL(CLK_APMIXED_APLL2, "apll2", 0x2b4, 0x2c4, 0x00000000,
> +               0, 31, 0x2b4, 4, 0x2b8, 0x2b8, 0),
> +       PLL(CLK_APMIXED_LVDSPLL, "lvdspll", 0x2d0, 0x2dc, 0x00000000,
> +               0, 21, 0x2d0, 4, 0x0, 0x2d4, 0),
> +       PLL(CLK_APMIXED_MSDCPLL2, "msdcpll2", 0x2f0, 0x2fc, 0x00000000,
> +               0, 21, 0x2f0, 4, 0x0, 0x2f4, 0),
>  };
>
>  static void __init mtk_apmixedsys_init(struct device_node *node)
> diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
> index 5046852..e1b0a13 100644
> --- a/drivers/clk/mediatek/clk-mt8183.c
> +++ b/drivers/clk/mediatek/clk-mt8183.c
> @@ -1121,34 +1121,34 @@
>  };
>
>  static const struct mtk_pll_data plls[] = {
> -       PLL_B(CLK_APMIXED_ARMPLL_LL, "armpll_ll", 0x0200, 0x020C, 0x00000001,
> +       PLL_B(CLK_APMIXED_ARMPLL_LL, "armpll_ll", 0x0200, 0x020C, 0x00000000,
>                 HAVE_RST_BAR | PLL_AO, BIT(24), 22, 8, 0x0204, 24, 0x0, 0x0, 0,
>                 0x0204, 0, 0, armpll_div_table),
> -       PLL_B(CLK_APMIXED_ARMPLL_L, "armpll_l", 0x0210, 0x021C, 0x00000001,
> +       PLL_B(CLK_APMIXED_ARMPLL_L, "armpll_l", 0x0210, 0x021C, 0x00000000,
>                 HAVE_RST_BAR | PLL_AO, BIT(24), 22, 8, 0x0214, 24, 0x0, 0x0, 0,
>                 0x0214, 0, 0, armpll_div_table),
> -       PLL(CLK_APMIXED_CCIPLL, "ccipll", 0x0290, 0x029C, 0x00000001,
> +       PLL(CLK_APMIXED_CCIPLL, "ccipll", 0x0290, 0x029C, 0x00000000,
>                 HAVE_RST_BAR | PLL_AO, BIT(24), 22, 8, 0x0294, 24, 0x0, 0x0, 0,
>                 0x0294, 0, 0),
> -       PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0220, 0x022C, 0x00000001,
> +       PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0220, 0x022C, 0x00000000,
>                 HAVE_RST_BAR, BIT(24), 22, 8, 0x0224, 24, 0x0, 0x0, 0,
>                 0x0224, 0, 0),
> -       PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x0230, 0x023C, 0x00000001,
> +       PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x0230, 0x023C, 0x00000000,
>                 HAVE_RST_BAR, BIT(24), 22, 8, 0x0234, 24, 0x0, 0x0, 0,
>                 0x0234, 0, 0),
> -       PLL_B(CLK_APMIXED_MFGPLL, "mfgpll", 0x0240, 0x024C, 0x00000001,
> +       PLL_B(CLK_APMIXED_MFGPLL, "mfgpll", 0x0240, 0x024C, 0x00000000,
>                 0, 0, 22, 8, 0x0244, 24, 0x0, 0x0, 0, 0x0244, 0, 0,
>                 mfgpll_div_table),
> -       PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0250, 0x025C, 0x00000001,
> +       PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0250, 0x025C, 0x00000000,
>                 0, 0, 22, 8, 0x0254, 24, 0x0, 0x0, 0, 0x0254, 0, 0),
> -       PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x0260, 0x026C, 0x00000001,
> +       PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x0260, 0x026C, 0x00000000,
>                 0, 0, 22, 8, 0x0264, 24, 0x0, 0x0, 0, 0x0264, 0, 0),
> -       PLL(CLK_APMIXED_MMPLL, "mmpll", 0x0270, 0x027C, 0x00000001,
> +       PLL(CLK_APMIXED_MMPLL, "mmpll", 0x0270, 0x027C, 0x00000000,
>                 HAVE_RST_BAR, BIT(23), 22, 8, 0x0274, 24, 0x0, 0x0, 0,
>                 0x0274, 0, 0),
> -       PLL(CLK_APMIXED_APLL1, "apll1", 0x02A0, 0x02B0, 0x00000001,
> +       PLL(CLK_APMIXED_APLL1, "apll1", 0x02A0, 0x02B0, 0x00000000,
>                 0, 0, 32, 8, 0x02A0, 1, 0x02A8, 0x0014, 0, 0x02A4, 0, 0x02A0),
> -       PLL(CLK_APMIXED_APLL2, "apll2", 0x02b4, 0x02c4, 0x00000001,
> +       PLL(CLK_APMIXED_APLL2, "apll2", 0x02b4, 0x02c4, 0x00000000,
>                 0, 0, 32, 8, 0x02B4, 1, 0x02BC, 0x0014, 1, 0x02B8, 0, 0x02B4),
>  };
>
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> index f440f2cd..3c79e1a 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -247,8 +247,10 @@ static int mtk_pll_prepare(struct clk_hw *hw)
>         writel(r, pll->pwr_addr);
>         udelay(1);
>
> -       r = readl(pll->base_addr + REG_CON0);
> -       r |= pll->data->en_mask;
> +       r = readl(pll->base_addr + REG_CON0) | CON0_BASE_EN;
> +       writel(r, pll->base_addr + REG_CON0);
> +
> +       r = readl(pll->base_addr + REG_CON0) | pll->data->en_mask;
>         writel(r, pll->base_addr + REG_CON0);

As a small optimization, you can do:

if (pll->data->en_mask) {
   r = readl(pll->base_addr + REG_CON0) | pll->data->en_mask;
   writel(r, pll->base_addr + REG_CON0);
}

>
>         __mtk_pll_tuner_enable(pll);
> @@ -278,6 +280,10 @@ static void mtk_pll_unprepare(struct clk_hw *hw)
>         __mtk_pll_tuner_disable(pll);
>
>         r = readl(pll->base_addr + REG_CON0);
> +       r &= ~pll->data->en_mask;

Move this to one line? (so that the code looks symmetrical, too?)

> +       writel(r, pll->base_addr + REG_CON0);
> +
> +       r = readl(pll->base_addr + REG_CON0);
>         r &= ~CON0_BASE_EN;

ditto?

>         writel(r, pll->base_addr + REG_CON0);
>
> --
> 1.8.1.1.dirty
