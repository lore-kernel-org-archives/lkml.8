Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C96C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C49C420801
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgFKNpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:45:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:54844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgFKNpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:45:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BCDABADCF;
        Thu, 11 Jun 2020 13:45:34 +0000 (UTC)
Subject: Re: [PATCH v2 4/5] ARM: mstar: Add dts for msc313(e) based BreadBee
 boards
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     k@japko.eu, tim.bird@sony.com, devicetree@vger.kernel.org,
        Daniel Palmer <daniel@thingy.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Maxime Ripard <mripard@kernel.org>,
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
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191014061617.10296-2-daniel@0x0f.com>
 <20200610090421.3428945-5-daniel@0x0f.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <42aa9e03-3fcc-a602-40db-cfbddef36b34@suse.de>
Date:   Thu, 11 Jun 2020 15:45:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200610090421.3428945-5-daniel@0x0f.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 10.06.20 um 11:04 schrieb Daniel Palmer:
> BreadBee is an opensource development board based on the
> MStar msc313(e) SoC.
> 
> Hardware details, schematics and so on can be found at:
> https://github.com/breadbee/breadbee
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>   arch/arm/boot/dts/Makefile                    |  3 +++
>   .../dts/infinity-msc313-breadbee_crust.dts    | 25 +++++++++++++++++++
>   .../boot/dts/infinity3-msc313e-breadbee.dts   | 25 +++++++++++++++++++
>   3 files changed, 53 insertions(+)
>   create mode 100644 arch/arm/boot/dts/infinity-msc313-breadbee_crust.dts
>   create mode 100644 arch/arm/boot/dts/infinity3-msc313e-breadbee.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index e6a1cac0bfc7..4a5f8075a4f6 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1342,6 +1342,9 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
>   	mt8127-moose.dtb \
>   	mt8135-evbp1.dtb
>   dtb-$(CONFIG_ARCH_MILBEAUT) += milbeaut-m10v-evb.dtb
> +dtb-$(CONFIG_ARCH_MSTARV7) += \
> +	infinity-msc313-breadbee_crust.dtb \
> +	infinity3-msc313e-breadbee.dtb
>   dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
>   dtb-$(CONFIG_ARCH_ASPEED) += \
>   	aspeed-ast2500-evb.dtb \
> diff --git a/arch/arm/boot/dts/infinity-msc313-breadbee_crust.dts b/arch/arm/boot/dts/infinity-msc313-breadbee_crust.dts
> new file mode 100644
> index 000000000000..8a827c8fd8b2
> --- /dev/null
> +++ b/arch/arm/boot/dts/infinity-msc313-breadbee_crust.dts
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 thingy.jp.
> + * Author: Daniel Palmer <daniel@thingy.jp>
> + */
> +
> +/dts-v1/;
> +#include "infinity-msc313.dtsi"
> +
> +/ {
> +	model = "breadbee-crust";

This is user-visible text, so "BreadBee Crust" or so?

> +	compatible = "thingyjp,breadbee-crust", "mstar,infinity";
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

Might this be a more suited place for temporary clock-frequency? For 
lack of clk driver it would seem to depend on the board's bootloader 
pre-configuring it rather than being a default of the SoC.

> +};
> diff --git a/arch/arm/boot/dts/infinity3-msc313e-breadbee.dts b/arch/arm/boot/dts/infinity3-msc313e-breadbee.dts
> new file mode 100644
> index 000000000000..423bb32e6b74
> --- /dev/null
> +++ b/arch/arm/boot/dts/infinity3-msc313e-breadbee.dts
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 thingy.jp.
> + * Author: Daniel Palmer <daniel@thingy.jp>
> + */
> +
> +/dts-v1/;
> +#include "infinity3-msc313e.dtsi"
> +
> +/ {
> +	model = "breadbee";

Ditto, "BreadBee"?

> +	compatible = "thingyjp,breadbee", "mstar,infinity3";
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

Ditto, clock-frequency?

> +};

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
