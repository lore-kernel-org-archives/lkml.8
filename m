Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA242C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B16212075F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgFKOjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:39:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:54154 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728059AbgFKOjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:39:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1256DAC12;
        Thu, 11 Jun 2020 14:39:32 +0000 (UTC)
Subject: Re: [PATCH v2 3/5] ARM: mstar: Add infinity/mercury series dtsi
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Krzysztof Adamski <k@japko.eu>, tim.bird@sony.com,
        devicetree@vger.kernel.org, Daniel Palmer <daniel@thingy.jp>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
References: <20191014061617.10296-2-daniel@0x0f.com>
 <20200610090421.3428945-4-daniel@0x0f.com>
 <bf26822d-acb0-ae40-df7f-80978bd26cfb@suse.de>
 <CAFr9PXmp=mZhyRDpx_E0_1Zc5SFrSYUm9jP-k7VCDf9P37sT6g@mail.gmail.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <3d933b03-9757-f659-d19a-ce6d0fccebea@suse.de>
Date:   Thu, 11 Jun 2020 16:39:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFr9PXmp=mZhyRDpx_E0_1Zc5SFrSYUm9jP-k7VCDf9P37sT6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 11.06.20 um 16:19 schrieb Daniel Palmer:
> On Thu, 11 Jun 2020 at 22:39, Andreas Färber <afaerber@suse.de> wrote:
>>> diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
>>> new file mode 100644
>>> index 000000000000..0fccc4ca52a4
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/mstar-v7.dtsi
>>
>> So this is the only file starting with mstar. Have you thought about
>> prefixing infinity/mercury, so that they're grouped together?
> 
> I have been thinking about that. I didn't see any other dts in arm that had
> the vendor as a prefix though. With arm64 everything is in per vendor
> subdirectories
> to achieve the same thing.

qcom- and arm- are examples. Admittedly outliers, but for a new target 
you don't have all the historical backwards-compatibility baggage.

The downside would be if someone wanted to add newer sstar chips under 
the new name later, then they wouldn't be grouped with predecessor 
families. Right now it seems like mercury and infinity are not that 
different, so I figured it might be useful for people contributing 
patches to see that changes in one might require review of the other.

Cheers,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
