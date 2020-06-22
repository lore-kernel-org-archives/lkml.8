Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EA2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A14D022BEA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592809549;
	bh=B8KgTSCiuvD2DUeXfT07K9LQ3YpjlNpWmmBMHHAftkQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=MZ/F8OwctEuZqUSrIClEkB7t8mPYiKKD1rtZfTQorYQeKoOtb5aP3GtDwqlOCRgCs
	 wbBCz6hTFh9oNgGB8Gdh9vRvFGdedtiHn72OuyjzXbLLAzGEc3f9nyVL+QyD3p9EDt
	 mYldd5czdBzrVNIWylrrWzQtW0bQiv/LS0A8UKwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbgFVHFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:05:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbgFVHFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 03:05:48 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56B73222C3;
        Mon, 22 Jun 2020 07:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592809547;
        bh=B8KgTSCiuvD2DUeXfT07K9LQ3YpjlNpWmmBMHHAftkQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=adw9FyaMkAXyD+TVvO7IZyR8UoBEeIx67hLCJQrDYYx5d2/h/7aaZWKzpgpJ25w+R
         tvn97XK6Qaa08iN2rjR7VT+H7es+ZysPX5S1tldUQL9OQIrIUmHnp6rfbLPurN/Pb1
         mWFdNR9TgHgrE3oGHgopSJ/LQYSqCtDLaId4cmXI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1591687933-19495-5-git-send-email-Anson.Huang@nxp.com>
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com> <1591687933-19495-5-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH V2 4/9] clk: imx: Support building i.MX common clock driver as module
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux-imx@nxp.com
To:     Anson Huang <Anson.Huang@nxp.com>, abel.vesa@nxp.com,
        aisheng.dong@nxp.com, allison@lohutok.net, arnd@arndb.de,
        daniel.baluta@nxp.com, festevam@gmail.com, fugang.duan@nxp.com,
        gregkh@linuxfoundation.org, info@metux.net, kernel@pengutronix.de,
        leonard.crestez@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, mturquette@baylibre.com,
        oleksandr.suvorov@toradex.com, peng.fan@nxp.com,
        s.hauer@pengutronix.de, sfr@canb.auug.org.au, shawnguo@kernel.org,
        stefan.agner@toradex.com, tglx@linutronix.de, yuehaibing@huawei.com
Date:   Mon, 22 Jun 2020 00:05:46 -0700
Message-ID: <159280954666.62212.15832087518734077634@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2020-06-09 00:32:08)
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index 1af8cff..1291f9b 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -1,25 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0
> =20
> -obj-$(CONFIG_MXC_CLK) +=3D \
> -       clk.o \
> -       clk-busy.o \
> -       clk-composite-8m.o \
> -       clk-cpu.o \
> -       clk-composite-7ulp.o \
> -       clk-divider-gate.o \
> -       clk-fixup-div.o \
> -       clk-fixup-mux.o \
> -       clk-frac-pll.o \
> -       clk-gate-exclusive.o \
> -       clk-gate2.o \
> -       clk-pfd.o \
> -       clk-pfdv2.o \
> -       clk-pllv1.o \
> -       clk-pllv2.o \
> -       clk-pllv3.o \
> -       clk-pllv4.o \
> -       clk-sscg-pll.o \
> -       clk-pll14xx.o
> +mxc-clk-objs +=3D clk.o clk-busy.o clk-composite-8m.o clk-cpu.o clk-comp=
osite-7ulp.o \
> +               clk-divider-gate.o clk-fixup-div.o clk-fixup-mux.o clk-fr=
ac-pll.o \
> +               clk-gate-exclusive.o clk-gate2.o clk-pfd.o clk-pfdv2.o cl=
k-pllv1.o \
> +               clk-pllv2.o clk-pllv3.o clk-pllv4.o clk-sscg-pll.o clk-pl=
l14xx.o
> +obj-$(CONFIG_MXC_CLK) +=3D mxc-clk.o

I enjoyed it when the files were all on their own line. Can you keep it
like that and just add mxc-clk-objs +=3D to all the lines and remove the
trailing slash?

> =20
>  mxc-clk-scu-objs +=3D clk-scu.o clk-lpcg-scu.o
>  obj-$(CONFIG_MXC_CLK_SCU) +=3D mxc-clk-scu.o
> diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-com=
posite-8m.c
> index d2b5af8..73e064b 100644
> --- a/drivers/clk/imx/clk-composite-8m.c
> +++ b/drivers/clk/imx/clk-composite-8m.c
> @@ -243,3 +243,4 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const cha=
r *name,
>         kfree(mux);
>         return ERR_CAST(hw);
>  }
> +EXPORT_SYMBOL_GPL(imx8m_clk_hw_composite_flags);

Are all these files including <linux/export.h>? Because they should
unless they're using something from <linux/module.h> like
MODULE_LICENSE().

> diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
> index 87ab8db..cc894b5 100644
> --- a/drivers/clk/imx/clk.c
> +++ b/drivers/clk/imx/clk.c
> @@ -143,16 +148,24 @@ void imx_cscmr1_fixup(u32 *val)
>  static int imx_keep_uart_clocks;
>  static struct clk ** const *imx_uart_clocks;
> =20
> -static int __init imx_keep_uart_clocks_param(char *str)
> +static int __maybe_unused imx_keep_uart_clocks_param(char *str)
>  {
>         imx_keep_uart_clocks =3D 1;
> =20
>         return 0;
>  }
> +
> +#ifdef MODULE
> +__setup_param("earlycon", imx_keep_uart_earlycon,
> +             imx_keep_uart_clocks_param);
> +__setup_param("earlyprintk", imx_keep_uart_earlyprintk,
> +             imx_keep_uart_clocks_param);

Why not fix __setup_param() to take the same number of arguments in
either case? That macro looks broken.

> +#else
>  __setup_param("earlycon", imx_keep_uart_earlycon,
>               imx_keep_uart_clocks_param, 0);
>  __setup_param("earlyprintk", imx_keep_uart_earlyprintk,
>               imx_keep_uart_clocks_param, 0);
> +#endif
> =20
>  void imx_register_uart_clocks(struct clk ** const clks[])
>  {
