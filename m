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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A08C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4029C206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtRztLvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgHRLt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgHRLtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:49:23 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517D2C061389;
        Tue, 18 Aug 2020 04:49:23 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id qc22so21700026ejb.4;
        Tue, 18 Aug 2020 04:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mMxvSNvYN0G9gHfNld2QBfDcMy7NeODVjheMMYfO7t0=;
        b=ZtRztLvX7y/z12SWaalBEyeOEYxXabLjCHi5xVWw90onClwSFm5N82IkLOBLg85oVy
         rI/wo7v8wlnrP9amQdbWl54hsO+LiO1KvL4hZAXrs993duzAg9d7CAC11n4cgZy7CQ3C
         Gwfw62LPLu+BB2BZPBaFtKv7uhcUBYsuhuUTiawxHxTHbFlTywVV+zvU3cOBJHAOnRrN
         o6e9AisnzU3fcRqeftlfZhzb1ODkMT73Tzcw0LYkSLR9kWddRI4xtv3beWBw95OdSrgP
         sBGUKq9P+diHlxTYGsn5/LP9yTNnYLB4hiXTPwf+EHlolkFNcHxgpSCDR0fKx6WTLFx/
         xJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mMxvSNvYN0G9gHfNld2QBfDcMy7NeODVjheMMYfO7t0=;
        b=ABdL6YbImcaDlmTvyfFnMJl6puWkqpcxixfV6YamD7FZSUDAL1bx5USq4SiIxm67DR
         if7Ho6bpVju8RD6wQjZr2sun53RymYf3ouVFx51OuN/SxD/prIj+hi9KT4t29DN+cElg
         UpuyK1WkPKf1LP5nVPvdGJdhku5QrE0pDdJLRo3bk27DkZLPLbpTy/mxg+aoEyDih03m
         wMZluBiPD92ZL+7m+1OAvlCO4KyXg+nrAgRadqk/KWcTVl4MGLM+vV2+hYer1VehWAE+
         TAlPFKizTMgW0HeS8DibR8kpwAUg3POQPXsedN4CflSUlVrADaWzc7QZYb4AuBIzOWtV
         sb7Q==
X-Gm-Message-State: AOAM5316KDxmMoSJSKOi9ZBQhqtwrq2QoNBV5PNcEdCHlKrif4Sx9N6e
        BCS7EkE1ikmNLtDQG2k/jyel7QQeLhWjjBtUW2s=
X-Google-Smtp-Source: ABdhPJwsPOc04kvdKuEfb7mxh740Lfw+l/VTLX1glmpk7RdsbB0R0Zt9vCZhZGNuyNwSG8ObvYtv5oSZ9wzSF1JryNk=
X-Received: by 2002:a17:906:4dd4:: with SMTP id f20mr20883087ejw.170.1597751361674;
 Tue, 18 Aug 2020 04:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com> <1597406966-13740-17-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1597406966-13740-17-git-send-email-abel.vesa@nxp.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 18 Aug 2020 19:34:14 +0800
Message-ID: <CAA+hA=S_wdoZvCPamW2F1Vs73t4fgnQa8LouUwzq2Vfpz3SDCg@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] arm64: dts: imx8mp: Add media_blk_ctrl node
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
> Some of the features of the media_ctrl will be used by some
> different drivers in a way those drivers will know best, so adding the
> syscon compatible we allow those to do just that. Only the resets
> and the clocks are registered bit the clk-blk-ctrl driver.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index dede0ae..2d6d213 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -736,6 +736,22 @@
>                         };
>                 };
>
> +               aips4: bus@32c00000 {
> +                       compatible = "simple-bus";
> +                       reg = <0x32c00000 0x400000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +
> +                       media_blk_ctrl: clock-controller@32ec0000 {

For this combo device, maybe we can directly name it as blk-ctrl@32ec0000.
Rob, do you think if we can do that?

> +                               compatible = "fsl,imx8mp-media-blk-ctrl", "syscon";
> +                               reg = <0x32ec0000 0x10000>;
> +

Remove unnecessary blank line

Otherwise:
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Aisheng

> +                               #clock-cells = <1>;
> +                               #reset-cells = <1>;
> +                       };
> +               };
> +
>                 aips5: bus@30c00000 {
>                         compatible = "fsl,aips-bus", "simple-bus";
>                         reg = <0x30c00000 0x400000>;
> --
> 2.7.4
>
