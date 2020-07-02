Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C52FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 03:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 530FE207F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 03:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1rsZUO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgGBDbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 23:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgGBDbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 23:31:08 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44171C08C5C1;
        Wed,  1 Jul 2020 20:31:08 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id by13so12183261edb.11;
        Wed, 01 Jul 2020 20:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V57SYphvjcaqogbiN7WQNBWs0aKifVDv1zSPRDEdp78=;
        b=i1rsZUO2yVRtwHgsfjIVPsSDF6GXGDsiXYZDg+2MxgOurUsnQXYslBdzjsaG5Bgt2J
         GpsEL8KceBFefh6NTMVG8YzuAeK1t2c3L33h+DHROZjuy3o758pj67qf8EYrXHSbpjDI
         3WhNHCXg90PxLKGy7YccwFkT/Rnf9UD+QcnT0CI0jboZWt+vlz3HKM9lsocD038wFjDx
         ySWwXpQr+7TeSfJWKLivvggYsCAeTlI7z7n3vz1ZSh09vGH+Cx5ZQGOLRvrWXfg5Lt9t
         jbzwxp0xm4+MT1DMXoXpHK08tgn/JR2FnGyFKZtUiIxIU5RnM14MLeygLKl8s9avZZtz
         vE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V57SYphvjcaqogbiN7WQNBWs0aKifVDv1zSPRDEdp78=;
        b=XiJPdYFhUbjBA+yhDRGO88Hq+iC9M6RZjd7ceZqIPOERqJbBZRC7O3t4HWUV0hus1G
         qY8M30A9or6LnK9ASv4R9XbmawnjaOVeQSxOj2oPGZPlsejy1ofOmuS7SWTsTeNxyKaO
         Elebxq1qajY1QuE/wQHtJxYcDgMTEyh5uWtrjNlomM3krK6GPueo0rWPsyVnrxzUw5X3
         Jt2Wch95SlWYLaR4UUQZGQsGtXoq+7JplG2YnjiaU0GuMfC4PGAQ/nBzLlGK/1bu+MyR
         cLNhaaPa/BnvfQMR4tQaOGPN3Y0nW17QVfRCmOxTEgxLiTLoPYWgP0pDT03LoVoxZWc6
         3xmQ==
X-Gm-Message-State: AOAM533fz5I4Wk4+EQpAc/GVPQHgduH/a9aLqKTmD0yaB6q8aVWO6/2o
        HsnPWd/anoR7jchOgGLqMexgHCJ/2RjWSlgKzQxMFlLN1jdEdQ==
X-Google-Smtp-Source: ABdhPJzmtrfwWSsDIziJ0KhOscb2mK4ZnRBGcKiB4mMue9BYpAbI+uDCpssdbPPR9sFQeuxDUnF4ZyXQzrIkux+BCwc=
X-Received: by 2002:a50:9b0b:: with SMTP id o11mr33819450edi.22.1593660666999;
 Wed, 01 Jul 2020 20:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <1593656074-10092-1-git-send-email-Anson.Huang@nxp.com> <1593656074-10092-6-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1593656074-10092-6-git-send-email-Anson.Huang@nxp.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Thu, 2 Jul 2020 11:17:05 +0800
Message-ID: <CAA+hA=T1+F-oTfWdV22ztUT3Ru-dFPDzhC7aJsdj0R3yP4wzbA@mail.gmail.com>
Subject: Re: [PATCH V4 5/5] clk: imx8qxp: Support building i.MX8QXP clock
 driver as module
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Peng Fan <peng.fan@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 10:20 AM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Change configuration to "tristate", use device_initcall() instead
> of builtin_platform_driver(), add module author, description and
> license to support building i.MX8QXP clock drivers as module.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V3:
>         - use device_initcall() instead of builtin_platform_driver();
>         - add module author/description;
>         - link common scu/lpcg clock driver to i.MX8QXP clock driver, then
>           no need to have exports.
> ---
>  drivers/clk/imx/Kconfig            |  6 +++---
>  drivers/clk/imx/Makefile           |  9 ++++-----
>  drivers/clk/imx/clk-imx8qxp-lpcg.c | 10 +++++++++-
>  drivers/clk/imx/clk-imx8qxp.c      | 11 ++++++++++-
>  4 files changed, 26 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> index 1867111..8340dfe 100644
> --- a/drivers/clk/imx/Kconfig
> +++ b/drivers/clk/imx/Kconfig
> @@ -5,8 +5,8 @@ config MXC_CLK
>         depends on ARCH_MXC
>
>  config MXC_CLK_SCU
> -       bool
> -       depends on IMX_SCU
> +       tristate "IMX SCU clock"
> +       depends on ARCH_MXC && IMX_SCU
>
>  config CLK_IMX1
>           bool "IMX1 CCM Clock Driver"
> @@ -127,7 +127,7 @@ config CLK_IMX8MQ
>             Build the driver for i.MX8MQ CCM Clock Driver
>
>  config CLK_IMX8QXP
> -       bool "IMX8QXP SCU Clock"
> +       tristate "IMX8QXP SCU Clock"
>         depends on ARCH_MXC && IMX_SCU && ARM64
>         select MXC_CLK_SCU
>         help
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index 17f5d12..79e53f2 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -21,15 +21,14 @@ mxc-clk-objs += clk-pll14xx.o
>  mxc-clk-objs += clk-sscg-pll.o
>  obj-$(CONFIG_MXC_CLK) += mxc-clk.o
>
> -obj-$(CONFIG_MXC_CLK_SCU) += \
> -       clk-scu.o \
> -       clk-lpcg-scu.o
> -
>  obj-$(CONFIG_CLK_IMX8MM) += clk-imx8mm.o
>  obj-$(CONFIG_CLK_IMX8MN) += clk-imx8mn.o
>  obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o
>  obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
> -obj-$(CONFIG_CLK_IMX8QXP) += clk-imx8qxp.o clk-imx8qxp-lpcg.o
> +
> +obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o
> +clk-imx-scu-$(CONFIG_CLK_IMX8QXP) += clk-scu.o clk-imx8qxp.o
> +clk-imx-lpcg-scu-$(CONFIG_CLK_IMX8QXP) += clk-lpcg-scu.o clk-imx8qxp-lpcg.o
>
>  obj-$(CONFIG_CLK_IMX1)   += clk-imx1.o
>  obj-$(CONFIG_CLK_IMX21)  += clk-imx21.o
> diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> index 04c8ee3..5b6648e 100644
> --- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
> +++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> @@ -231,4 +231,12 @@ static struct platform_driver imx8qxp_lpcg_clk_driver = {
>         .probe = imx8qxp_lpcg_clk_probe,
>  };
>
> -builtin_platform_driver(imx8qxp_lpcg_clk_driver);
> +static int __init imx8qxp_lpcg_clk_init(void)

Does __init work for module?

> +{
> +       return platform_driver_register(&imx8qxp_lpcg_clk_driver);
> +}
> +device_initcall(imx8qxp_lpcg_clk_init);

Any reason to change to device_initcall which looks a bit strange?
Is it because the following line?
+obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o
But it looks to me they're still two modules. Aren't they?

Regards
Aisheng

> +
> +MODULE_AUTHOR("Aisheng Dong <aisheng.dong@nxp.com>");
> +MODULE_DESCRIPTION("NXP i.MX8QXP LPCG clock driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
> index 5e2903e..9bcf0d1 100644
> --- a/drivers/clk/imx/clk-imx8qxp.c
> +++ b/drivers/clk/imx/clk-imx8qxp.c
> @@ -151,4 +151,13 @@ static struct platform_driver imx8qxp_clk_driver = {
>         },
>         .probe = imx8qxp_clk_probe,
>  };
> -builtin_platform_driver(imx8qxp_clk_driver);
> +
> +static int __init imx8qxp_clk_init(void)
> +{
> +       return platform_driver_register(&imx8qxp_clk_driver);
> +}
> +device_initcall(imx8qxp_clk_init);
> +
> +MODULE_AUTHOR("Aisheng Dong <aisheng.dong@nxp.com>");
> +MODULE_DESCRIPTION("NXP i.MX8QXP clock driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4
>
