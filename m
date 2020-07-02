Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26610C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 03:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02B7420720
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 03:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uzRG0fKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgGBDFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 23:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgGBDFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 23:05:44 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C500C08C5C1;
        Wed,  1 Jul 2020 20:05:44 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id w16so27344923ejj.5;
        Wed, 01 Jul 2020 20:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3toVj+DlYr/al+g77Ybu/jA4DumzzFaY/FqwBfqkKUw=;
        b=uzRG0fKqaSrG4lCeUzuXy8WkSg/PflMKlj7rtx/8MN1MXQIfr+iwBoXVVJxKKuKWBs
         1itRhEBg3gqcwSf8WGAz6PboKGkvrBHLGQhMq9n/Oh/iChFK6E2qnwIulIm24PauOmtf
         0WOTycX+ubYZb8AeavCPpxf8Gt5+OZBIbNz4PWy7h3kEh9Q45XJLMoHVYWcVqF6boItd
         OlYi3ow4vcM7mR/9KigpWgBlVgObEARbtIc3f9N2PcrkgJG6pQ0eHR7o1r0/jz7JmcxN
         cb4evG2UO9A1gmYZbkh/IvVHxBy+UuzGS389bqGctB7QH48KQTXjQ+Zf6j7X0HLWDrpJ
         fXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3toVj+DlYr/al+g77Ybu/jA4DumzzFaY/FqwBfqkKUw=;
        b=reG7x0C46CHx6ilIt1mfZRO/loAhhJF4DUHD+YOmkPW1Ki60yXD5VlKuMpQTg4JAgC
         5edAH9Wf3O0aPrul8UROwNTb8hHpstSzN2+bKqE93x3HycBCpRSa76DYZZOubsc+yJ+e
         YriBikRCn937ghFahr1l8i4Ro/8L1/5V2qdM8G6RbGbdCKpQ6+XGDuUm8Da9saMZPjt2
         sC/+phOfBh1QvG2MYkRBmpV2NPMe0QvXtVTDRxb4BcyVn/fs8+JZlVZIkDEXrtjdTkYK
         ZZoFxmzvFcRY4zzb5a49+T6Jj6kx4TWMxa7D+f8vrrZUVq+dPROn2vzheVmbNG4aqfn/
         v/5w==
X-Gm-Message-State: AOAM530CwDY5F5dysm8zkhh+bCSb8skEbko+wlc+5JKzH0LqJYdpzKYP
        suF+UNvkCvQ3Kch5C3pu0IhhH62eBv1ZxkMrato=
X-Google-Smtp-Source: ABdhPJxshktT8feA1SIFEmYAeOiSAZFugeimNy2vMslgB+EVq2O9eGpSJCBNAKyF/dSAGDvyzHgC1bB5h6XpIabh+bo=
X-Received: by 2002:a17:906:4dd4:: with SMTP id f20mr26899001ejw.170.1593659143151;
 Wed, 01 Jul 2020 20:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <1593656074-10092-1-git-send-email-Anson.Huang@nxp.com> <1593656074-10092-5-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1593656074-10092-5-git-send-email-Anson.Huang@nxp.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Thu, 2 Jul 2020 10:51:41 +0800
Message-ID: <CAA+hA=R2fL3tF-LPpkxWnJqbM_GOM+89h73oJ5rB_otQDmZwig@mail.gmail.com>
Subject: Re: [PATCH V4 4/5] clk: imx8m: Support module build
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

On Thu, Jul 2, 2020 at 10:18 AM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Change configuration to "tristate", add module author, description
> and license to support building i.MX8M SoCs clock driver as module.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Aisheng

> ---
> Changes since V3:
>         - add module author/description, and merge all i.MX8M SoCs patch into
>           one patch.
> ---
>  drivers/clk/imx/Kconfig      | 8 ++++----
>  drivers/clk/imx/clk-imx8mm.c | 4 ++++
>  drivers/clk/imx/clk-imx8mn.c | 4 ++++
>  drivers/clk/imx/clk-imx8mp.c | 4 ++++
>  drivers/clk/imx/clk-imx8mq.c | 4 ++++
>  5 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> index f6ddf76..1867111 100644
> --- a/drivers/clk/imx/Kconfig
> +++ b/drivers/clk/imx/Kconfig
> @@ -99,28 +99,28 @@ config CLK_VF610
>           select MXC_CLK
>
>  config CLK_IMX8MM
> -       bool "IMX8MM CCM Clock Driver"
> +       tristate "IMX8MM CCM Clock Driver"
>         depends on ARCH_MXC
>         select MXC_CLK
>         help
>             Build the driver for i.MX8MM CCM Clock Driver
>
>  config CLK_IMX8MN
> -       bool "IMX8MN CCM Clock Driver"
> +       tristate "IMX8MN CCM Clock Driver"
>         depends on ARCH_MXC
>         select MXC_CLK
>         help
>             Build the driver for i.MX8MN CCM Clock Driver
>
>  config CLK_IMX8MP
> -       bool "IMX8MP CCM Clock Driver"
> +       tristate "IMX8MP CCM Clock Driver"
>         depends on ARCH_MXC
>         select MXC_CLK
>         help
>             Build the driver for i.MX8MP CCM Clock Driver
>
>  config CLK_IMX8MQ
> -       bool "IMX8MQ CCM Clock Driver"
> +       tristate "IMX8MQ CCM Clock Driver"
>         depends on ARCH_MXC
>         select MXC_CLK
>         help
> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
> index b793264..0de0be0 100644
> --- a/drivers/clk/imx/clk-imx8mm.c
> +++ b/drivers/clk/imx/clk-imx8mm.c
> @@ -657,3 +657,7 @@ static struct platform_driver imx8mm_clk_driver = {
>         },
>  };
>  module_platform_driver(imx8mm_clk_driver);
> +
> +MODULE_AUTHOR("Bai Ping <ping.bai@nxp.com>");
> +MODULE_DESCRIPTION("NXP i.MX8MM clock driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index 213cc37..e984de5 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -608,3 +608,7 @@ static struct platform_driver imx8mn_clk_driver = {
>         },
>  };
>  module_platform_driver(imx8mn_clk_driver);
> +
> +MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
> +MODULE_DESCRIPTION("NXP i.MX8MN clock driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index ca74771..f3cedf2 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -773,3 +773,7 @@ static struct platform_driver imx8mp_clk_driver = {
>         },
>  };
>  module_platform_driver(imx8mp_clk_driver);
> +
> +MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
> +MODULE_DESCRIPTION("NXP i.MX8MP clock driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> index a64aace..a06cc21 100644
> --- a/drivers/clk/imx/clk-imx8mq.c
> +++ b/drivers/clk/imx/clk-imx8mq.c
> @@ -643,3 +643,7 @@ static struct platform_driver imx8mq_clk_driver = {
>         },
>  };
>  module_platform_driver(imx8mq_clk_driver);
> +
> +MODULE_AUTHOR("Abel Vesa <abel.vesa@nxp.com>");
> +MODULE_DESCRIPTION("NXP i.MX8MQ clock driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4
>
