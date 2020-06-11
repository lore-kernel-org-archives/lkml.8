Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04923C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEA6C2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgFKPBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:01:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:34064 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728059AbgFKPBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:01:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AE830AEB1;
        Thu, 11 Jun 2020 15:00:59 +0000 (UTC)
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
References: <20191014061617.10296-2-daniel@0x0f.com>
 <20200610090421.3428945-2-daniel@0x0f.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <c4493f49-2ce8-ad23-0777-9812a1573782@suse.de>
Date:   Thu, 11 Jun 2020 17:00:14 +0200
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

+ linux-mediatek

Am 10.06.20 um 11:03 schrieb Daniel Palmer:
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index ef6d75b9113a..1770fc794027 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
[...]
> @@ -678,6 +680,8 @@ patternProperties:
>       description: Microsemi Corporation
>     "^msi,.*":
>       description: Micro-Star International Co. Ltd.
> +  "^mstar,.*":
> +    description: MStar Semiconductor, Inc.

Depending on what exactly its legal status is these days 
(https://en.wikipedia.org/wiki/MStar), you might either follow the below 
MIPS example of describing it as

"MediaTek Inc. (formerly MStar Semiconductor, Inc.)",

or you might extend above description as
"MStar Semiconductor, Inc. (acquired by MediaTek Inc.)" if it still exists.

Or accordingly "Xiamen Xingchen Technology Co., Ltd. (formerly MStar 
Semiconductor, Inc.)" if it was renamed to Sigmastar (in which case you 
might additionally reserve sstar prefix for Sigmastar while at it).

http://www.sigmastarsemi.com/en/enterprisenews/info.aspx?itemid=441

>     "^mti,.*":
>       description: Imagination Technologies Ltd. (formerly MIPS Technologies Inc.)
>     "^multi-inno,.*":
[...]
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 77a3fa5e3edd..1ca77f97b8ee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2110,6 +2110,12 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
>   F:	arch/arm/mach-pxa/mioa701.c
>   
> +ARM/MStar/Sigmastar ARMv7 SoC support

Here you do mention Sigmastar.

> +M:	Daniel Palmer <daniel@thingy.jp>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/arm/mstar.yaml
> +
>   ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
>   M:	Michael Petchkovsky <mkpetch@internode.on.net>
>   S:	Maintained

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
