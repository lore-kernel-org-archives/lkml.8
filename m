Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2EFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5209920842
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgFKNyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:54:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:33436 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgFKNyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:54:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6D067AB76;
        Thu, 11 Jun 2020 13:54:44 +0000 (UTC)
Subject: Re: [PATCH v2 5/5] ARM: mstar: Add dts for 70mai midrive d08
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     k@japko.eu, tim.bird@sony.com, devicetree@vger.kernel.org,
        Daniel Palmer <daniel@thingy.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Maxime Ripard <mripard@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191014061617.10296-2-daniel@0x0f.com>
 <20200610090421.3428945-6-daniel@0x0f.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <a626d8a5-16c2-8f0a-b131-c124c06b0317@suse.de>
Date:   Thu, 11 Jun 2020 15:54:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200610090421.3428945-6-daniel@0x0f.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BTW I think the subject convention has been "ARM: dts: ...", with "ARM: 
mstar: ..." more for mach-mstar.

Am 10.06.20 um 11:04 schrieb Daniel Palmer:
> Adds inital support for the 70mai midrive d08 dash camera.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>   arch/arm/boot/dts/Makefile                    |  3 ++-
>   .../boot/dts/mercury5-ssc8336n-midrive08.dts  | 25 +++++++++++++++++++
>   2 files changed, 27 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/boot/dts/mercury5-ssc8336n-midrive08.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 4a5f8075a4f6..35c7ecc52c60 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1344,7 +1344,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
>   dtb-$(CONFIG_ARCH_MILBEAUT) += milbeaut-m10v-evb.dtb
>   dtb-$(CONFIG_ARCH_MSTARV7) += \
>   	infinity-msc313-breadbee_crust.dtb \
> -	infinity3-msc313e-breadbee.dtb
> +	infinity3-msc313e-breadbee.dtb \
> +	mercury5-ssc8336n-midrive08.dtb
>   dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
>   dtb-$(CONFIG_ARCH_ASPEED) += \
>   	aspeed-ast2500-evb.dtb \
> diff --git a/arch/arm/boot/dts/mercury5-ssc8336n-midrive08.dts b/arch/arm/boot/dts/mercury5-ssc8336n-midrive08.dts
> new file mode 100644
> index 000000000000..4ee50ecf6ab1
> --- /dev/null
> +++ b/arch/arm/boot/dts/mercury5-ssc8336n-midrive08.dts
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 thingy.jp.
> + * Author: Daniel Palmer <daniel@thingy.jp>
> + */
> +
> +/dts-v1/;
> +#include "mercury5-ssc8336n.dtsi"
> +
> +/ {
> +	model = "midrive d08";

Couldn't find this on their website. Should this be "70mai midrive ..." 
or is "midrive" a different brand?

> +	compatible = "70mai,midrived08", "mstar,mercury5";

Have you considered naming it "70mai,midrive-d08" for better 
readability? (affects 1/5)

> +
> +	aliases {
> +		serial0 = &pm_uart;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&pm_uart {
> +	status = "okay";

clock-frequency?

> +};

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
