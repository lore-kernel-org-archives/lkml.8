Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46548C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29CF82072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgFKO1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:27:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:49196 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgFKO1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:27:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 810DFAB76;
        Thu, 11 Jun 2020 14:27:33 +0000 (UTC)
Subject: Re: [PATCH v2 2/5] ARM: mstar: Add machine for MStar/Sigmastar
 infinity/mercury family ARMv7 SoCs
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
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
References: <20191014061617.10296-2-daniel@0x0f.com>
 <20200610090421.3428945-3-daniel@0x0f.com>
 <976e789e-edd7-c44d-ea99-840ecb883ff8@suse.de>
 <CAFr9PXkvmZv3_EakxvRR+X522xN-a8epvF0ns10JeYCLn2uUKw@mail.gmail.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <1e8262e0-9b30-0788-446a-5d88c1bb49ea@suse.de>
Date:   Thu, 11 Jun 2020 16:27:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFr9PXkvmZv3_EakxvRR+X522xN-a8epvF0ns10JeYCLn2uUKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Am 11.06.20 um 15:01 schrieb Daniel Palmer:
> On Thu, 11 Jun 2020 at 21:49, Andreas Färber <afaerber@suse.de> wrote:
>>> peripherals and system memory in a single tiny QFN package that
>>> can be hand soldered allowing almost anyone to embed Linux
>>
>> "soldered, allowing"?
> 
> The original reads ok to me. Maybe I can just split that into two sentences?
> Like ".. QFN package that can be hand soldered. This allows almost anyone..".

As non-native speaker I merely wondered whether a comma should better be 
inserted to separate the two parts of the sentence. Splitting it in two 
or leaving as is should be fine, too - I assume you're a native speaker. 
Most people will rather read the bindings document than old git history, 
so you might want to consider adding such a description below its title.

>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2114,6 +2114,7 @@ ARM/MStar/Sigmastar ARMv7 SoC support
>>>    M:  Daniel Palmer <daniel@thingy.jp>
>>>    L:  linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>>    S:  Maintained
>>> +F:   arch/arm/mach-mstar/
>>>    F:  Documentation/devicetree/bindings/arm/mstar.yaml
>>>
>>>    ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
>> [snip]
>>
>> The sort order has recently been changed to case-sensitive, i.e., you
>> should append arch after Documentation.
> 
> Interesting. Checkpatch didn't complain about that although it
> complained about the
> original ordering I had.

I only noticed because someone refactored my Realtek section, causing a 
merge conflict.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3b50142d8528e1efc1c07f69c540f926c58ab3ad

Which reminds me, in 1/5 you should probably add a W: line (after S: 
according to above sort commit) pointing to your 
http://linux-chenxing.org/ website.

And for the community following your project, you may want to set up a 
linux-chenxing mailing list on vger.kernel.org or on infradead.org and 
add it as L:, to allow for error reports and patches to not just go to 
you and crowded LAKML.

Cheers,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
