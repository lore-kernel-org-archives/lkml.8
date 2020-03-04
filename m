Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A0AC3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 23:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E694420870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 23:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388534AbgCDXOn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 18:14:43 -0500
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:25213 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388425AbgCDXOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 18:14:43 -0500
Received: from belgarion ([86.210.245.36])
        by mwinf5d33 with ME
        id APEe220030nqnCN03PEeCk; Thu, 05 Mar 2020 00:14:41 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Thu, 05 Mar 2020 00:14:41 +0100
X-ME-IP: 86.210.245.36
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: Fix SND_SOC_ALL_CODECS imply ac97 fallout
References: <20200224112537.14483-1-geert@linux-m68k.org>
        <20200303143444.GA25683@roeck-us.net>
        <CAMuHMdWZxc5KjHaOhk5xdcjSn54i3ku7b1dW6tXhXbjku1eLww@mail.gmail.com>
X-URL:  http://belgarath.falguerolles.org/
Date:   Thu, 05 Mar 2020 00:14:38 +0100
In-Reply-To: <CAMuHMdWZxc5KjHaOhk5xdcjSn54i3ku7b1dW6tXhXbjku1eLww@mail.gmail.com>
        (Geert Uytterhoeven's message of "Tue, 3 Mar 2020 15:56:25 +0100")
Message-ID: <878skf1zmp.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Günter
>
> On Tue, Mar 3, 2020 at 3:34 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> On Mon, Feb 24, 2020 at 12:25:37PM +0100, Geert Uytterhoeven wrote:
>> > On i386 randconfig:
>> >
>> >     sound/soc/codecs/wm9705.o: In function `wm9705_soc_resume':
>> >     wm9705.c:(.text+0x128): undefined reference to `snd_ac97_reset'
>> >     sound/soc/codecs/wm9712.o: In function `wm9712_soc_resume':
>> >     wm9712.c:(.text+0x2d1): undefined reference to `snd_ac97_reset'
>> >     sound/soc/codecs/wm9713.o: In function `wm9713_soc_resume':
>> >     wm9713.c:(.text+0x820): undefined reference to `snd_ac97_reset'
>> >
>> > Fix this by adding the missing dependencies on SND_SOC_AC97_BUS.
>> >
>>
>> With this patch applied, arm:pxa_defconfig reports a variety of unmet
>> SND_SOC dependencies, and it fails to build.
>>
>> ERROR: "snd_ac97_reset" [sound/soc/codecs/snd-soc-wm9713.ko] undefined!
>> ERROR: "snd_ac97_reset" [sound/soc/codecs/snd-soc-wm9712.ko] undefined!
>> ERROR: "snd_ac97_reset" [sound/soc/codecs/snd-soc-wm9705.ko] undefined!
>>
>> Reverting this patch fixes the problem.
>
> Should SND_PXA2XX_SOC_AC97 in sound/soc/pxa/Kconfig select
> SND_SOC_AC97_BUS instead of SND_SOC_AC97_BUS_NEW?
> The latter does not exist.
Hi Geert,

The answer is no, PXA is now specifically ported to work with the new AC97 bus
implementation, ie. AC97_BUS_NEW=y as in sound/ac97/.

The 2 implementations of AC97 bus, ie. CONFIG_AC97_BUS and CONFIG_AC97_BUS_NEW
are exclusive, they cannot coexist in the same kernel AFAIR.

Sorry for the late reply on this thread, but I moved house lately and I'm quite
busy, so my answers are delayed.

As a side note, I've seen somewhere in the patches this :
SND_SOC_WM971{2,3} depends on SND_SOC_AC97_BUS. This looks wrong to me, as it
implies that a wolfson wm97xx sound driver can only exist with
CONFIG_AC97_BUS=y, which is false, because it can exist with
CONFIG_AC97_BUS_NEW=y.

I also saw someone saying the CONFIG_SND_SOC_AC97_BUS_NEW didn't exist; this is
true, most likely because I forgot it when I created the new AC97 bus. I'd think
the natural fix would be to add CONFIG_SND_SOC_AC97_BUS_NEW just after his twin
definition in sound/soc/Kconfig, but I might be wrong ...

Cheers.

--
Robert
