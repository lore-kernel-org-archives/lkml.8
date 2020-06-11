Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00131C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAEE320801
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgFKMtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:49:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:49308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727922AbgFKMtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 08:49:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E4BD1ACAE;
        Thu, 11 Jun 2020 12:49:12 +0000 (UTC)
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
Message-ID: <976e789e-edd7-c44d-ea99-840ecb883ff8@suse.de>
Date:   Thu, 11 Jun 2020 14:49:05 +0200
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
> Initial support for the MStar/Sigmastar infinity/mercury series of ARMv7
> based IP camera and dashcam SoCs.
> 
> These chips are interesting in that they contain a Cortex A7,

"Cortex-A7"

> peripherals and system memory in a single tiny QFN package that
> can be hand soldered allowing almost anyone to embed Linux

"soldered, allowing"?

> in their projects.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>   MAINTAINERS                   |  1 +
>   arch/arm/Kconfig              |  2 +
>   arch/arm/Makefile             |  1 +
>   arch/arm/mach-mstar/Kconfig   | 26 +++++++++++++
>   arch/arm/mach-mstar/Makefile  |  1 +
>   arch/arm/mach-mstar/mstarv7.c | 72 +++++++++++++++++++++++++++++++++++
>   6 files changed, 103 insertions(+)
>   create mode 100644 arch/arm/mach-mstar/Kconfig
>   create mode 100644 arch/arm/mach-mstar/Makefile
>   create mode 100644 arch/arm/mach-mstar/mstarv7.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1ca77f97b8ee..754521938303 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2114,6 +2114,7 @@ ARM/MStar/Sigmastar ARMv7 SoC support
>   M:	Daniel Palmer <daniel@thingy.jp>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
> +F:	arch/arm/mach-mstar/
>   F:	Documentation/devicetree/bindings/arm/mstar.yaml
>   
>   ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
[snip]

The sort order has recently been changed to case-sensitive, i.e., you 
should append arch after Documentation.

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
