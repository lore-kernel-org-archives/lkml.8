Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00D4C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD5CE20758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kA+rtbfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHQIGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgHQIGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:06:20 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE39C061388;
        Mon, 17 Aug 2020 01:06:20 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o23so16693974ejr.1;
        Mon, 17 Aug 2020 01:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4jd4U95N0spA17gLKz16+RNY1f59D3zn4QBsLmBOxbI=;
        b=kA+rtbfNYTfUJw0d3VKSh93oTBtpGl8D95gctkvMY3/cGWhCUwHboWGCFmds3M522A
         DcL1j3jUNzSiEiLtvcsMlOMGr+9CEW+d8SS6C4+xyf+XOfYXU7GWaplukaleL0MN83M1
         aK4/5PS3AAkOc8nTmYLDK7W0rbQ0zMw6yekrDzupe+IEQnCVX+qNOUczQeJULJqZzFOD
         49FQEmuiGsfygn4XW7EFy+G3osKAhAcIzexibTNyGsXjM93kt4B/H3JzcsAAhdjZu+4j
         Elgvt8nnnUCQSrv2TrjT/rG+0Gxk1Tw0RgoErRqqoy9gnOFD8/gnbKtzU6YHg+RsQFjl
         QZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4jd4U95N0spA17gLKz16+RNY1f59D3zn4QBsLmBOxbI=;
        b=QfJms6zr5y0+wFCpTHbOiqxDaAsU4ZN0PZVu1I6Ny2QBJYA+vCvl6syw3zn4+HsWow
         e7130d7VZ3z0REFCRXAb1gVUUplLJTvrMTNRYWQHzQcRHks6yX/dN41dL1MHhzCtkV4k
         sYlHl/YyRnoy4cevT15wyXk0kHccYZm0RM/9vnJBWWkPvN1l5FPaAwTYMleCA/dapbeq
         1FdYrR2gCxLwDGexR3tNiZrn7PIKlKXvY9AiTkbCJzHBol/TjsjizFmq4kyBwu19Dzi2
         xnv4uAH5mtxo8YN6gfY8mFPXoMIOxuhFVcn0QPQBniuIuaXLj6CtRP8XXu/hcT+fX1Gy
         INVA==
X-Gm-Message-State: AOAM532SIFmONZw1VfzxE6KS2aw+AUcgUH8fqGg8GGs4QsfUf6tAe3fr
        cWuYeedBMt7wGEX9Lfh2lnGC6+0uTQyfCWpECPXG/IlZXl8=
X-Google-Smtp-Source: ABdhPJyjbcn7MdQVsJVZWW0c81jKqfgcPjbzkmU20uXsFTmU0xJ1Q06liCbg/C9H/KmlHwl8o4KUkGJn6zE6x9RzmIo=
X-Received: by 2002:a17:906:2a04:: with SMTP id j4mr14632375eje.440.1597651578806;
 Mon, 17 Aug 2020 01:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com> <1597406966-13740-10-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1597406966-13740-10-git-send-email-abel.vesa@nxp.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Mon, 17 Aug 2020 15:51:13 +0800
Message-ID: <CAA+hA=R+zVeVEX_DcsTWD0FtaEHdeyapa4gR-_8Y=yzZD3ku1w@mail.gmail.com>
Subject: Re: [PATCH v2 09/17] arm64: dts: Remove imx-hdmimix-reset header file
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

On Fri, Aug 14, 2020 at 8:13 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> The hdmi BLK_CTRL ids have been moved to imx8mp-reset.h
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

The change seems do not comply with the patch title?

Regards
Aisheng

> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 9de2aa1..daa1769 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -4,6 +4,7 @@
>   */
>
>  #include <dt-bindings/clock/imx8mp-clock.h>
> +#include <dt-bindings/reset/imx8mp-reset.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> --
> 2.7.4
>
