Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F307C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B5B32072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nm3IJty4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgHQH7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgHQH7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:59:40 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDF6C061388;
        Mon, 17 Aug 2020 00:59:39 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l23so11518580edv.11;
        Mon, 17 Aug 2020 00:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1cXbBaafW+50dqCculqXKIrD5iW7sKJPiSxkET4AvNE=;
        b=Nm3IJty4q+nOfBiYjAgN2NNT/Ch60U3kFDaPe7ksbAtNDXMRFTodjZ4718jIwWG4at
         NLK4gzt86SR/xlVJyDQRc3XUNMq4tqg/JmJ7lMKJRZFAlaXpECSQE80LNlIaOcdR6V0P
         3iRcOow9jmzhuUjw6ng67yK/ODaJKsFZYsJ/KpxvF+358PHHT/n1uZgdntQMJWWHIDLJ
         lonJkbEj9GGn99RNhTQI3sUYQiw4ERGlX6JHuKjcrxy9Lxze4yM+j3ip0go5+m0Vq7kC
         Fs1S65bJ/vMKUGnv3V1/T9obSPfo9/IE1QMeTkbxrB+QPIX2+mUaGxtR4oZaMk/0NeGi
         DwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1cXbBaafW+50dqCculqXKIrD5iW7sKJPiSxkET4AvNE=;
        b=AmQfwLc3ppg4bCM3kawgUkgDollNJblGIg/o0mlVnlhGffwoLovW2FHraz7lpiLtSa
         8hj6SA9W7251M3/RPGWmiM/Zv5DgMVY6cCWrCWHQQPXZi/+Ic9leL1JpK3sd/gH185vV
         rToapePpj4A8ZW/pqMtuKKeRliYrTVhJzqP3cpd8JXwP+Ck5yw0MvAaqJQDYOW5PWy5P
         ukywT2M2l4Ab6ViX3qEgdUj5rC0R47S5kBTcK9HpYv3p0SEpa7N43rTyyCcG3lV7REeh
         LI9QTK/kOT/YeDV/8alAK+0vAQ/Qg5UCrAB9Z20f4GNPggCFV7+bAJHPv0BajCNmRV7p
         53fw==
X-Gm-Message-State: AOAM530uPYmc7XzdYaMAb3Cd3cOxKA9hw4od2TulTnxHvMuJwgnRLmWc
        DYdGfR7IfXq62cvqPCBsOwQYZL8sxonsL+UENto=
X-Google-Smtp-Source: ABdhPJzqKXF/U+5Ql0v/Df74UZIr4RCMxKWkg92mOvojgyrs0Tdhf8aOjQd4f8MhONWORxA/VMe2Cp0vp5ky014312M=
X-Received: by 2002:aa7:d410:: with SMTP id z16mr13495000edq.287.1597651178388;
 Mon, 17 Aug 2020 00:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com> <1597406966-13740-2-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1597406966-13740-2-git-send-email-abel.vesa@nxp.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Mon, 17 Aug 2020 15:44:32 +0800
Message-ID: <CAA+hA=Qd5BURqbQox1MhXtXcG1fRW6h-pyo2LcH6uukOYi0sKg@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] dt-bindings: clocks: imx8mp: Rename audiomix ids
 clocks to audio_blk_ctrl
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

On Fri, Aug 14, 2020 at 8:14 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> In the reference manual the actual name is Audio BLK_CTRL.
> Lets make it more obvious here by renaming from audiomix to audio_blk_ctrl.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

As there's still no users of the old definitions, it's okay for me to
change it now.
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Aisheng

> ---
>  include/dt-bindings/clock/imx8mp-clock.h | 120 +++++++++++++++----------------
>  1 file changed, 60 insertions(+), 60 deletions(-)
>
> diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
> index 7a23f28..6008f32 100644
> --- a/include/dt-bindings/clock/imx8mp-clock.h
> +++ b/include/dt-bindings/clock/imx8mp-clock.h
> @@ -324,66 +324,66 @@
>
>  #define IMX8MP_CLK_END                         313
>
> -#define IMX8MP_CLK_AUDIOMIX_SAI1_IPG           0
> -#define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK1         1
> -#define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK2         2
> -#define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK3         3
> -#define IMX8MP_CLK_AUDIOMIX_SAI2_IPG           4
> -#define IMX8MP_CLK_AUDIOMIX_SAI2_MCLK1         5
> -#define IMX8MP_CLK_AUDIOMIX_SAI2_MCLK2         6
> -#define IMX8MP_CLK_AUDIOMIX_SAI2_MCLK3         7
> -#define IMX8MP_CLK_AUDIOMIX_SAI3_IPG           8
> -#define IMX8MP_CLK_AUDIOMIX_SAI3_MCLK1         9
> -#define IMX8MP_CLK_AUDIOMIX_SAI3_MCLK2         10
> -#define IMX8MP_CLK_AUDIOMIX_SAI3_MCLK3         11
> -#define IMX8MP_CLK_AUDIOMIX_SAI5_IPG           12
> -#define IMX8MP_CLK_AUDIOMIX_SAI5_MCLK1         13
> -#define IMX8MP_CLK_AUDIOMIX_SAI5_MCLK2         14
> -#define IMX8MP_CLK_AUDIOMIX_SAI5_MCLK3         15
> -#define IMX8MP_CLK_AUDIOMIX_SAI6_IPG           16
> -#define IMX8MP_CLK_AUDIOMIX_SAI6_MCLK1         17
> -#define IMX8MP_CLK_AUDIOMIX_SAI6_MCLK2         18
> -#define IMX8MP_CLK_AUDIOMIX_SAI6_MCLK3         19
> -#define IMX8MP_CLK_AUDIOMIX_SAI7_IPG           20
> -#define IMX8MP_CLK_AUDIOMIX_SAI7_MCLK1         21
> -#define IMX8MP_CLK_AUDIOMIX_SAI7_MCLK2         22
> -#define IMX8MP_CLK_AUDIOMIX_SAI7_MCLK3         23
> -#define IMX8MP_CLK_AUDIOMIX_ASRC_IPG           24
> -#define IMX8MP_CLK_AUDIOMIX_PDM_IPG            25
> -#define IMX8MP_CLK_AUDIOMIX_SDMA2_ROOT         26
> -#define IMX8MP_CLK_AUDIOMIX_SDMA3_ROOT         27
> -#define IMX8MP_CLK_AUDIOMIX_SPBA2_ROOT         28
> -#define IMX8MP_CLK_AUDIOMIX_DSP_ROOT           29
> -#define IMX8MP_CLK_AUDIOMIX_DSPDBG_ROOT                30
> -#define IMX8MP_CLK_AUDIOMIX_EARC_IPG           31
> -#define IMX8MP_CLK_AUDIOMIX_OCRAMA_IPG         32
> -#define IMX8MP_CLK_AUDIOMIX_AUD2HTX_IPG                33
> -#define IMX8MP_CLK_AUDIOMIX_EDMA_ROOT          34
> -#define IMX8MP_CLK_AUDIOMIX_AUDPLL_ROOT                35
> -#define IMX8MP_CLK_AUDIOMIX_MU2_ROOT           36
> -#define IMX8MP_CLK_AUDIOMIX_MU3_ROOT           37
> -#define IMX8MP_CLK_AUDIOMIX_EARC_PHY           38
> -#define IMX8MP_CLK_AUDIOMIX_PDM_ROOT           39
> -#define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK1_SEL     40
> -#define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK2_SEL     41
> -#define IMX8MP_CLK_AUDIOMIX_SAI2_MCLK1_SEL     42
> -#define IMX8MP_CLK_AUDIOMIX_SAI2_MCLK2_SEL     43
> -#define IMX8MP_CLK_AUDIOMIX_SAI3_MCLK1_SEL     44
> -#define IMX8MP_CLK_AUDIOMIX_SAI3_MCLK2_SEL     45
> -#define IMX8MP_CLK_AUDIOMIX_SAI4_MCLK1_SEL     46
> -#define IMX8MP_CLK_AUDIOMIX_SAI4_MCLK2_SEL     47
> -#define IMX8MP_CLK_AUDIOMIX_SAI5_MCLK1_SEL     48
> -#define IMX8MP_CLK_AUDIOMIX_SAI5_MCLK2_SEL     49
> -#define IMX8MP_CLK_AUDIOMIX_SAI6_MCLK1_SEL     50
> -#define IMX8MP_CLK_AUDIOMIX_SAI6_MCLK2_SEL     51
> -#define IMX8MP_CLK_AUDIOMIX_SAI7_MCLK1_SEL     52
> -#define IMX8MP_CLK_AUDIOMIX_SAI7_MCLK2_SEL     53
> -#define IMX8MP_CLK_AUDIOMIX_PDM_SEL            54
> -#define IMX8MP_CLK_AUDIOMIX_SAI_PLL_REF_SEL    55
> -#define IMX8MP_CLK_AUDIOMIX_SAI_PLL            56
> -#define IMX8MP_CLK_AUDIOMIX_SAI_PLL_BYPASS     57
> -#define IMX8MP_CLK_AUDIOMIX_SAI_PLL_OUT                58
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI1_IPG             0
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI1_MCLK1           1
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI1_MCLK2           2
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI1_MCLK3           3
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI2_IPG             4
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI2_MCLK1           5
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI2_MCLK2           6
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI2_MCLK3           7
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI3_IPG             8
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI3_MCLK1           9
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI3_MCLK2           10
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI3_MCLK3           11
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI5_IPG             12
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI5_MCLK1           13
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI5_MCLK2           14
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI5_MCLK3           15
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI6_IPG             16
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI6_MCLK1           17
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI6_MCLK2           18
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI6_MCLK3           19
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI7_IPG             20
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI7_MCLK1           21
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI7_MCLK2           22
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI7_MCLK3           23
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_ASRC_IPG             24
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_PDM_IPG              25
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SDMA2_ROOT           26
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SDMA3_ROOT           27
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SPBA2_ROOT           28
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_DSP_ROOT             29
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_DSPDBG_ROOT          30
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_EARC_IPG             31
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_OCRAMA_IPG           32
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_AUD2HTX_IPG          33
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_EDMA_ROOT            34
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_AUDPLL_ROOT          35
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_MU2_ROOT             36
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_MU3_ROOT             37
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_EARC_PHY             38
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_PDM_ROOT             39
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI1_MCLK1_SEL       40
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI1_MCLK2_SEL       41
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI2_MCLK1_SEL       42
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI2_MCLK2_SEL       43
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI3_MCLK1_SEL       44
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI3_MCLK2_SEL       45
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI4_MCLK1_SEL       46
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI4_MCLK2_SEL       47
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI5_MCLK1_SEL       48
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI5_MCLK2_SEL       49
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI6_MCLK1_SEL       50
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI6_MCLK2_SEL       51
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI7_MCLK1_SEL       52
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI7_MCLK2_SEL       53
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_PDM_SEL              54
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI_PLL_REF_SEL      55
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI_PLL              56
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI_PLL_BYPASS       57
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_SAI_PLL_OUT          58
>
> -#define IMX8MP_CLK_AUDIOMIX_END                        59
> +#define IMX8MP_CLK_AUDIO_BLK_CTRL_END                  59
>
>  #endif
> --
> 2.7.4
>
