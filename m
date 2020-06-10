Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B205AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BEF5204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgFJJfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:35:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:39338 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbgFJJfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:35:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 930BDAD39;
        Wed, 10 Jun 2020 09:35:37 +0000 (UTC)
Subject: Re: [PATCH v2 1/5] dt-bindings: arm: Initial MStar vendor prefixes
 and compatible strings
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
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191014061617.10296-2-daniel@0x0f.com>
 <20200610090421.3428945-2-daniel@0x0f.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <cafee323-841d-92ed-b4ad-a1aaa136864d@suse.de>
Date:   Wed, 10 Jun 2020 11:35:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200610090421.3428945-2-daniel@0x0f.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Am 10.06.20 um 11:03 schrieb Daniel Palmer:
> Adds a prefixes for MStar, thingy.jp, 70mai and then defines compatible
> strings for the first MStar based boards.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>   .../devicetree/bindings/arm/mstar.yaml        | 30 +++++++++++++++++++
>   .../devicetree/bindings/vendor-prefixes.yaml  |  6 ++++
>   MAINTAINERS                                   |  6 ++++
>   3 files changed, 42 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/arm/mstar.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/mstar.yaml b/Documentation/devicetree/bindings/arm/mstar.yaml
> new file mode 100644
> index 000000000000..09e87cf6d6f0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mstar.yaml
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/mstar.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MStar platforms device tree bindings
> +
> +maintainers:
> +  - Daniel Palmer <daniel@thingy.jp>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: thingy.jp BreadBee
> +        items:
> +          - const: thingyjp,breadbee
> +          - const: mstar,infinity3
> +
> +      - description: thingy.jp BreadBee Crust
> +        items:
> +          - const: thingyjp,breadbee-crust
> +          - const: mstar,infinity
> +
> +      - description: 70mai midrive d08
> +        items:
> +          - const: 70mai,midrived08
> +          - const: mstar,mercury5

I would advise to restructure these three for forward planning:

Use const only for the SoC compatible.

For the boards use an enum with (for now) only the one entry. This 
affects the description, which may mislead people to duplicate these 
blocks for each board rather than just for each SoC family. Take a look 
at other existing files (e.g., my realtek.yaml and actions.yaml, but 
note they don't have the new-style description line yet - I assume it'll 
work the same in enum as in your oneOf).

> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index ef6d75b9113a..1770fc794027 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -23,6 +23,8 @@ patternProperties:
>     "^(simple-audio-card|simple-graph-card|st-plgpio|st-spics|ts),.*": true
>   
>     # Keep list in alphabetical order.
> +  "^70mai,.*":
> +    description: 70mai

"70mai Co., Ltd." please - don't just repeat the prefix.

>     "^abilis,.*":
>       description: Abilis Systems
>     "^abracon,.*":
> @@ -678,6 +680,8 @@ patternProperties:
>       description: Microsemi Corporation
>     "^msi,.*":
>       description: Micro-Star International Co. Ltd.
> +  "^mstar,.*":
> +    description: MStar Semiconductor, Inc.
>     "^mti,.*":
>       description: Imagination Technologies Ltd. (formerly MIPS Technologies Inc.)
>     "^multi-inno,.*":
> @@ -1030,6 +1034,8 @@ patternProperties:
>       description: Three Five Corp
>     "^thine,.*":
>       description: THine Electronics, Inc.
> +  "^thingyjp,.*":
> +    description: thingy.jp
>     "^ti,.*":
>       description: Texas Instruments
>     "^tianma,.*":

If you split the vendor prefixes to a preceding patch, they have a 
chance of getting Reviewed-bys more quickly. You can then also CC the 
vendors on the prefixes you're assigning for them.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 77a3fa5e3edd..1ca77f97b8ee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2110,6 +2110,12 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
>   F:	arch/arm/mach-pxa/mioa701.c
>   
> +ARM/MStar/Sigmastar ARMv7 SoC support
> +M:	Daniel Palmer <daniel@thingy.jp>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/arm/mstar.yaml
> +
>   ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
>   M:	Michael Petchkovsky <mkpetch@internode.on.net>
>   S:	Maintained

In theory it's spelled Armv7 since 2017, but MAINTAINERS, subject prefix 
conventions and many other places in Linux still use the old upper-case 
spelling, too...

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
