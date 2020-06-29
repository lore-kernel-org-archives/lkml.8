Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB82C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51150207E8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgF2UJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:09:58 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:54907 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgF2UJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:09:43 -0400
Received: from mail-qv1-f42.google.com ([209.85.219.42]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MeTwa-1jHcPb2lSG-00aYIt for <linux-kernel@vger.kernel.org>; Mon, 29 Jun
 2020 12:41:59 +0200
Received: by mail-qv1-f42.google.com with SMTP id d12so7406122qvn.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 03:41:59 -0700 (PDT)
X-Gm-Message-State: AOAM531IRWmpD969Z1ecFt2fo+Ss3QMOeHBQjkbNU3Ym+gLRpOjicqJk
        VMOadaFq+TO2h40w2V+3/6qXlG7nAEV5PXMwMLU=
X-Google-Smtp-Source: ABdhPJyXGIgZiGgvN0EsrksSo2lM83Ci2s2TJb1sNWGDAMxwSeFYJKystJ4+IQb407S9hGS8mH8Jabv4FTX43lMIILk=
X-Received: by 2002:a0c:a992:: with SMTP id a18mr5722120qvb.211.1593427318599;
 Mon, 29 Jun 2020 03:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <1593425623-31810-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1593425623-31810-1-git-send-email-Anson.Huang@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Jun 2020 12:41:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1pr8YbZMpSXg6o_UeDvaU=dDqfo45DudTASNcsxeg3kg@mail.gmail.com>
Message-ID: <CAK8P3a1pr8YbZMpSXg6o_UeDvaU=dDqfo45DudTASNcsxeg3kg@mail.gmail.com>
Subject: Re: [PATCH 1/3] reset: imx7: Support module build
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stefan Agner <stefan.agner@toradex.com>,
        oleksandr.suvorov@toradex.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:NAY8EhN6ws1T8Pazpdgrd7VWDeFxjiun8491ZtLnnw6d9VxKLS6
 8DhsBQstA4iN6jv0o/5SRRp03jhV6SdWjyG1/+7nPRFlpPQxXFyZUG9c0dsABx1dN9NHUE7
 6Kwyb9j1hiysI0AZr4d9AtFC0uMX4jt+BHCaAWvPhd3mRjxPDpkipH6/oI91JpkMLGu6m/w
 37TCB8UYsUgDcuf9b40eg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o9rlWcobsXs=:RKRYtyb7Zd9/IfkC2YkpQq
 4UAIsigLxcA7tdPJinfrtehW0L+FE4cfx8LzBLiTEFbbPrwsRgYeJKGoYBLcFvk/zOOzt1R/U
 YMORbeKYrI6yR3hH4ISFevBnvI2VAQr8kvF0tQGlSHUTwpEoRf1dpz9bE8uzNnmAyX0306nJa
 xK7ao7r5tjjpeXklY81NYsLJKa6FR6LftjAaeoKmbuiJ72f4WDJ/hjgW5+9phs78cwZS22aI2
 xaruYZ4XwcOXyF+PulviQw54SM7d2vC/NNLK+rmD9OGvM+LTqEkKxL3eJOmWNF5qzy9J4DHaW
 7Rd1hEfNMUzgpmjbM2Vne9WCF+zb6bCJwbT5ox9XTrxgteJnl8StZZ6Iws/IkEvfooNKj8tXq
 jrmVBbhDiNDekt8fK/9CJOVTV95HIHMPxnfLoaEmOq56P9Jd080nK5nJW9m/ZvVvPJEzIf0Lc
 gOWnzBdQTJHmDZBaT/GEXyJBA2SEU6tX4ro/XoV6E0pUK2Z+PWQ2k6ARWeU6/CMa03vM4iQgs
 u8T1fo+476MA1ImYGQD/c7dzUoTzNnZDqG3+ze6VqWJDde05N66IXJYepGh3UVMR0bNPdV8aE
 4teYiDIlAa+hOmtxLD5eEjS5BBiP06rZdPKJrjB3Myaw3GOH/cPfVAAMgU0nvRLEAT78jyoCl
 j9A9F0AXRf87iUbDOmX/w7W/U/tXvhkgrXewCLHZdCahC9n0YE9cclSTA1eFsjowIxY23GfLo
 lGKAU5XSRkph2xcAwOMrTVHM4p7RBus+0Y3u2IOV4OMi7WulqxCoU8fs1rgl4YM2M4Vchf2Rf
 Dikl0x5HPC78q8zktJu3E3SATVESHsuaBSQIJq9v0/Fqi/zfJZObwpVLIuS7Ug0TGDn0SXW
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 12:25 PM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Add module device table, module license to support module build.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/reset/Kconfig      | 4 ++--
>  drivers/reset/reset-imx7.c | 4 +++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index d9efbfd..033ab60 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -65,9 +65,9 @@ config RESET_HSDK
>           This enables the reset controller driver for HSDK board.
>
>  config RESET_IMX7
> -       bool "i.MX7/8 Reset Driver" if COMPILE_TEST
> +       tristate "i.MX7/8 Reset Driver"
>         depends on HAS_IOMEM
> -       default SOC_IMX7D || (ARM64 && ARCH_MXC)
> +       depends on SOC_IMX7D || (ARM64 && ARCH_MXC) || COMPILE_TEST
>         select MFD_SYSCON

You are dropping the 'default' line, so the driver is now disabled
in a defconfig build, which is not mentioned in the patch description.

Maybe make it 'default m'?

config RESET_IMX7
       tristate "i.MX7/8 Reset Driver"
       depends on HAS_IOMEM
       depends on SOC_IMX7D || (ARM64 && ARCH_MXC) || COMPILE_TEST
       default m if (SOC_IMX7D || (ARM64 && ARCH_MXC))
       select MFD_SYSCON

> @@ -395,3 +396,4 @@ static struct platform_driver imx7_reset_driver = {
>         },
>  };
>  builtin_platform_driver(imx7_reset_driver);
> +MODULE_LICENSE("GPL v2");

Generally speaking: when you add a MODULE_LICENSE tag, please also
add MODULE_AUTHOR and MODULE_DESCRIPTION.

The 'builtin_platform_driver()' should work correctly but prevent unloading the
module. Ideally please changed to 'module_platform_driver()' and add a
.remove function for the platform_driver.


       Arnd
