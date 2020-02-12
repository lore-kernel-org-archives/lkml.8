Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF2AC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D891324681
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbgBLUTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:19:50 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:50561 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBLUTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:19:49 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N18MG-1jVDbd21Ws-012cGT for <linux-kernel@vger.kernel.org>; Wed, 12 Feb
 2020 21:19:47 +0100
Received: by mail-qk1-f175.google.com with SMTP id b7so3391237qkl.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 12:19:47 -0800 (PST)
X-Gm-Message-State: APjAAAUoli55+XIYnyfAITTPqkogGPIBWjXGw7e39oJPb7KKMkfjmuCH
        sKMUguk6podGOez5mVT34QCdPa3HowGDZUnYPCE=
X-Google-Smtp-Source: APXvYqwQIOhVnY9bQ1LDgJmsuv+7ni6xH/3BERILwIwIeUDXR88bOYRlBrWjmBW9A4udrXrmXhmIrc8oCdOVs0WJ/I0=
X-Received: by 2002:a37:e409:: with SMTP id y9mr12825473qkf.352.1581538786339;
 Wed, 12 Feb 2020 12:19:46 -0800 (PST)
MIME-Version: 1.0
References: <20200110173425.21895-1-nsaenzjulienne@suse.de>
In-Reply-To: <20200110173425.21895-1-nsaenzjulienne@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Feb 2020 21:19:29 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1tLrkymeJfXvDk_kxPvW_PQy6zNmrmO++dOPCWm71vOA@mail.gmail.com>
Message-ID: <CAK8P3a1tLrkymeJfXvDk_kxPvW_PQy6zNmrmO++dOPCWm71vOA@mail.gmail.com>
Subject: Re: [RFC] ARM: add multi_v7_lpae_defconfig
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Phil Elwell <phil@raspberrypi.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:MtjHKtpjrHMp8UOjU/w7ZJa6qGckOM5XsJ8Zi5jbEGPFfQP/PSi
 ofwGshxzIS8fCAUPAHxgi+rHqZziSmKk7Z3Vq4oClkIO7LzmrSqixLUXPVKNoZOcHBqWewW
 /0dGbBSHadl5py+RI4Q3YgEYbPTAVOOq04o1oCRRTSaojjAKgljjGO4/UdERgqsbSCwP91r
 L3KIRAEp7oHyZ4BY0TVMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:swhXcZalegY=:X2wcjieYivcldfVxJTuJoU
 ZW/jG9nZjvTyMigaCrXOmbN8iehw6ILLnUtMTYyK/l1ig0NLlBRq0TsKb4SiZRty+7CWnqwOM
 ZhLUEhLrLviRIVFEnjG4O/piom7pMQHqwws/eyF+lo+kApwru1W21gt0zgUUJVwTM98hIfwP5
 K/SSo5nAF1ZBt/1AEH//X7FM2KXrmaY1taMPkIDU0+R02WJ4dUW7aQCgnQUGWiggCHq0HFpwn
 U1beUA3faXdqff/yt/Y+LJSETYSlQd6ctWLI1OSAX+aWpBWUMISvPkGPbATBrZon55qsqPHYv
 WVyZBGHLVunW9CgSq7sPlmUPizySVxQlR6DpVuVdGuDTcgp9d4i7VrqAMWK5sMMkSFmqjEAwU
 cmLK751Zrg1c1xlpgnJE/GTORDchfBuohThWleSNk+dUo/jP0OQvafIM8Hdo2PI3zVWqEwqdH
 dFcZ7W2F9FI4Sn/4SBObL39C522nukLH5ugfyWNGQNBWedeXdyuhsYK+b8EgyeQmafj9vF5TE
 78DKfue/DFJ05ahU8aom6CexDtKXxW7GtsIHhHx54OnXK8jOnjCZZpkCOqo5UyfwCVlfkeWPM
 78ZqTJQsf0tmis6nSTy3Anq0+qm1D9/9doDCYqm7utVGaM/t/vV9sI/saINNMYBc+0JcBxNOj
 WqlCUJ069CAsMT0oH+2Ugnqh2yuItzQzrpGfLPknNY/SX27QxZguhSMoBT0QjJ/PH85pU9FJF
 BsH97YlMLHSDi63EMtMSwmvL7KJOBjrfjPaiPgh5lVKc6+EkRThNGUNlF9W2agU9+voQFJ8PD
 UTXGbdk2o+m5ja82GIJJGnXSb+guw8EiStGdtbd+L9jv8ii44I=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 6:35 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> The only missing configuration option preventing us from using
> multi_v7_defconfig with the RPi4 is ARM_LPAE. It's needed as the PCIe
> controller found on the SoC depends on 64bit addressing, yet can't be
> included as not all v7 boards support LPAE.
>
> Introduce multi_v7_lpae_defconfig, built off multi_v7_defconfig, which will
> avoid us having to duplicate and maintain multiple similar configurations.
>
> Note that merge_into_defconfig was taken from arch/powerpc/Makefile.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

I like the idea, but I would note that a lot of platforms enabled in
multi_v7_defconfig do not support LPAE. In particular, the first ARMv7
cores (Cortex-A8, -A9, -A5, and PJ4) don't, but the later ones (Cortex-A7,
-A15, -A17, and PJ4C-MP) do.

Here is a list from the defconfig file

CONFIG_ARCH_VIRT=y
CONFIG_ARCH_ALPINE=y
CONFIG_ARCH_ARTPEC=y
CONFIG_MACH_ARTPEC6=y

Artpec is A9

CONFIG_ARCH_ASPEED=y
CONFIG_MACH_ASPEED_G6=y
CONFIG_ARCH_AT91=y
CONFIG_SOC_SAMA5D2=y
CONFIG_SOC_SAMA5D3=y
CONFIG_SOC_SAMA5D4=y

AT91/SAMA5 is A5

CONFIG_ARCH_BCM=y
CONFIG_ARCH_BCM_CYGNUS=y
CONFIG_ARCH_BCM_HR2=y
CONFIG_ARCH_BCM_NSP=y
CONFIG_ARCH_BCM_5301X=y
CONFIG_ARCH_BCM_281XX=y
CONFIG_ARCH_BCM_21664=y
CONFIG_ARCH_BCM_63XX=y
CONFIG_ARCH_BRCMSTB=y

I think most of the above are A9, but not sure

CONFIG_ARCH_BCM2835=y
CONFIG_ARCH_BERLIN=y
CONFIG_MACH_BERLIN_BG2CD=y
CONFIG_MACH_BERLIN_BG2Q=y
CONFIG_MACH_BERLIN_BG2=y

These are mixed, I think BG2CD is A7, but the older ones are A9 or PJ4

CONFIG_ARCH_DIGICOLOR=y

CX92755 is an A8

CONFIG_ARCH_EXYNOS=y

exynos is a mix of A9 and A15/A7, so this is fine

CONFIG_ARCH_HIGHBANK=y

A9 and A15, also fine

CONFIG_ARCH_HISI=y
CONFIG_ARCH_HI3xxx=y
CONFIG_ARCH_HIP01=y
CONFIG_ARCH_HIP04=y
CONFIG_ARCH_HIX5HD2=y
CONFIG_ARCH_MXC=y
CONFIG_SOC_IMX50=y
CONFIG_SOC_IMX51=y
CONFIG_SOC_IMX53=y

IMX5 is A8

CONFIG_SOC_IMX6Q=y
CONFIG_SOC_IMX6SL=y
CONFIG_SOC_IMX6SX=y

These older imx6 variants are A9, but the 6UL and 7D are A7.

CONFIG_SOC_IMX6UL=y
CONFIG_SOC_LS1021A=y
CONFIG_SOC_IMX7D=y
CONFIG_SOC_VF610=y

VF610 is an A5

CONFIG_ARCH_KEYSTONE=y
CONFIG_ARCH_MEDIATEK=y

Mediatek is mostly A7, but some A9

CONFIG_ARCH_MESON=y

Mixed

CONFIG_ARCH_MILBEAUT=y
CONFIG_ARCH_MILBEAUT_M10V=y
CONFIG_ARCH_MMP=y
CONFIG_MACH_MMP2_DT=y
CONFIG_MACH_MMP3_DT=y

MMP is a PJ4, I don't think there is LPAE, but not sure

CONFIG_ARCH_MVEBU=y
CONFIG_MACH_ARMADA_370=y
CONFIG_MACH_ARMADA_375=y
CONFIG_MACH_ARMADA_38X=y
CONFIG_MACH_ARMADA_39X=y
CONFIG_MACH_ARMADA_XP=y
CONFIG_MACH_DOVE=y

Fairly sure only Armada XP has LPAE out of these

CONFIG_ARCH_OMAP3=y
CONFIG_ARCH_OMAP4=y
CONFIG_SOC_OMAP5=y
CONFIG_SOC_AM33XX=y
CONFIG_SOC_AM43XX=y
CONFIG_SOC_DRA7XX=y

only OMAP5 and DRA7 use an A15, the others are A8 or A9

CONFIG_ARCH_SIRF=y
CONFIG_ARCH_QCOM=y
CONFIG_ARCH_MSM8X60=y
CONFIG_ARCH_MSM8960=y
CONFIG_ARCH_MSM8974=y

Not sure whether there is LPAE on Qualcomm's custom cores

CONFIG_ARCH_ROCKCHIP=y

Mixed

CONFIG_ARCH_RENESAS=y

Mixed

CONFIG_ARCH_SOCFPGA=y

A9 only

CONFIG_PLAT_SPEAR=y
CONFIG_ARCH_SPEAR13XX=y
CONFIG_MACH_SPEAR1310=y
CONFIG_MACH_SPEAR1340=y

A9 only

CONFIG_ARCH_STI=y
CONFIG_ARCH_STM32=y
CONFIG_ARCH_SUNXI=y

sunxi has A8 and A7 (and one that is A15+A7)

CONFIG_ARCH_TEGRA=y

Mixed

CONFIG_ARCH_UNIPHIER=y

 A9 only so far

CONFIG_ARCH_U8500=y

A9 only

CONFIG_ARCH_VEXPRESS=y

A9 or A15

CONFIG_ARCH_WM8850=y

A9

CONFIG_ARCH_ZYNQ=y

A9

I think it would make sense to either turn off the various A8/A9/A5 platforms
in the fragment, or add a CONFIG_ARCH_MULTI_V7VE option, and then
change the Kconfig dependencies so that the older platforms get turned off
when only V7 but not V7VE is set.

      Arnd
