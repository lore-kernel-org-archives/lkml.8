Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142C3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1D6920760
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgFKM6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:58:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:54212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbgFKM6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 08:58:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C0874AF32;
        Thu, 11 Jun 2020 12:58:55 +0000 (UTC)
Subject: Re: [PATCH v2 2/5] ARM: mstar: Add machine for MStar/Sigmastar
 infinity/mercury family ARMv7 SoCs
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     k@japko.eu, tim.bird@sony.com, devicetree@vger.kernel.org,
        Daniel Palmer <daniel@thingy.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Maxime Ripard <mripard@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Christian Lamparter <chunkeey@gmail.com>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191014061617.10296-2-daniel@0x0f.com>
 <20200610090421.3428945-3-daniel@0x0f.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <f66978d8-22c5-1883-c6bf-52c0c19d6603@suse.de>
Date:   Thu, 11 Jun 2020 14:58:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200610090421.3428945-3-daniel@0x0f.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 10.06.20 um 11:04 schrieb Daniel Palmer:
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 59fde2d598d8..e7f4ca060c0f 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -197,6 +197,7 @@ machine-$(CONFIG_ARCH_MXC)		+= imx
>   machine-$(CONFIG_ARCH_MEDIATEK)		+= mediatek
>   machine-$(CONFIG_ARCH_MILBEAUT)		+= milbeaut
>   machine-$(CONFIG_ARCH_MXS)		+= mxs
> +machine-$(CONFIG_ARCH_MSTARV7)		+= mstar
>   machine-$(CONFIG_ARCH_NOMADIK)		+= nomadik
>   machine-$(CONFIG_ARCH_NPCM)		+= npcm
>   machine-$(CONFIG_ARCH_NSPIRE)		+= nspire
> diff --git a/arch/arm/mach-mstar/Kconfig b/arch/arm/mach-mstar/Kconfig
> new file mode 100644
> index 000000000000..6235d0a7860a
> --- /dev/null
> +++ b/arch/arm/mach-mstar/Kconfig
> @@ -0,0 +1,26 @@
> +menuconfig ARCH_MSTARV7

You call the dir mach-mstar, but name the Kconfig ARCH_MSTARV7. I had 
previously been asked to just use the vendor name, so this should 
probably be just ARCH_MSTAR. Outside arch/arm/ you can then use ARM && 
ARCH_MSTAR condition to make things 32-bit only, allowing to reuse 
ARCH_MSTAR for arm64 or whatever.

> +	bool "MStar/Sigmastar ARMv7 SoC Support"
> +	depends on ARCH_MULTI_V7
> +	select ARM_GIC
> +	select ARM_HEAVY_MB
> +	help
> +	  Support for newer MStar/Sigmastar SoC families that are
> +	  based on ARMv7 cores like the Cortex A7 and share the same
> +	  basic hardware like the infinity and mercury series.
> +
> +if ARCH_MSTARV7
> +
> +config MACH_INFINITY
> +	bool "MStar/Sigmastar infinity SoC support"
> +	default ARCH_MSTARV7
> +	help
> +	  Support for MStar/Sigmastar infinity IP camera SoCs.
> +
> +config MACH_MERCURY
> +	bool "MStar/Sigmastar mercury SoC support"
> +	default ARCH_MSTARV7
> +	help
> +	  Support for MStar/Sigmastar mercury dash camera SoCs.
> +	  Note that older Mercury2 SoCs are ARM9 based and not supported.

Is this comment really helpful? This menu item would only seem to come 
up after having selected multi_v7, which kind of rules out ARM9.

Consider adding mercury in a second step?

> +
> +endif

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
