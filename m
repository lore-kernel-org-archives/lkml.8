Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B6DC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C78B2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRm2UbJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbgCCQOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:14:46 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41550 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729960AbgCCQOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:14:45 -0500
Received: by mail-pf1-f193.google.com with SMTP id j9so1679778pfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 08:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=W6bZJgA2B8yV92ToUdbhDnWn8Wf8SVbR4fdlo/S3zYg=;
        b=iRm2UbJAX2KPPtw/bXpNYbHTxPhnF9TrWTcUJhwMwBI16gSfrqYYcNgFsgFeeb3pjN
         sMlsweLT6FEy/aGSKQ/hPhiIRuNmFeEb1lAGPiOu+A9QKPb7Q+/kV9PzMwnZ2HfhhAKe
         YR3GUIsL80GB869gdjQ1UXmMYhuBzdqlzlYrFjg2IY8uaW37xHB8Y0KX6ssYmTkfVDIR
         AyQTx0V5o3Df/Eu/eh9rT6kNPFnBvJEHo3X3thcSXE0yY/cT9sAm3PusIP2MduOEGa1g
         rwGJ+lAkLZyW+SAwv/6Fj8dDlOsQpivJVxcE/mrDTzGXB8WzrX2iWc5NPGUuP0dGwBtP
         fy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=W6bZJgA2B8yV92ToUdbhDnWn8Wf8SVbR4fdlo/S3zYg=;
        b=uUWZ7slJP2G6fFXT4RjJuSugZe8Je0mLUIVZZvyGvOV8jKAc5fE4qphKwLK1eJiISq
         wLSF6MnF6aGQTV2iOdFodpntS3/AI9dDMtmblZyj0X/bawRfBQattTLd90Tk1jZCG7Mz
         9zPuud34L4yA9DjM9MWsQH+KGaYBmXOP0fKAznAzp5QniUSG/VfCJuQnUWiMDCIrw/h8
         HMk9qsWV0OOGFx9YBIoTjbuwzUbi+jcu8//W/P8IuoT7/Ke+yxPmA8BoPhlmRAu6Ri/x
         +tWPP+pyGAgTG/FkEViQKAIzN/KsP8AjJi5RxDfqNCOH1tGrFKR65E9X+e68cTALYWoF
         6sdw==
X-Gm-Message-State: ANhLgQ1FOO3bUunV15crezTdQ/p3i5lBsWhf7+v1ovrhiy2DckwWChXV
        Po+77LB/eiEBn0hrsSNA1KM=
X-Google-Smtp-Source: ADFU+vugfk5YAPZd2rPmqKWvu0ze5swsKp4lwvB0qve9j0052KotJHbV2aNn8l27fjDnDSRKs1OPxg==
X-Received: by 2002:a63:d241:: with SMTP id t1mr4545801pgi.283.1583252084874;
        Tue, 03 Mar 2020 08:14:44 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q66sm23071256pgq.50.2020.03.03.08.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Mar 2020 08:14:43 -0800 (PST)
Date:   Tue, 3 Mar 2020 08:14:43 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: Fix SND_SOC_ALL_CODECS imply ac97 fallout
Message-ID: <20200303161443.GA23017@roeck-us.net>
References: <20200224112537.14483-1-geert@linux-m68k.org>
 <20200303143444.GA25683@roeck-us.net>
 <CAMuHMdWZxc5KjHaOhk5xdcjSn54i3ku7b1dW6tXhXbjku1eLww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWZxc5KjHaOhk5xdcjSn54i3ku7b1dW6tXhXbjku1eLww@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 03:56:25PM +0100, Geert Uytterhoeven wrote:
> Hi Günter
> 
> On Tue, Mar 3, 2020 at 3:34 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > On Mon, Feb 24, 2020 at 12:25:37PM +0100, Geert Uytterhoeven wrote:
> > > On i386 randconfig:
> > >
> > >     sound/soc/codecs/wm9705.o: In function `wm9705_soc_resume':
> > >     wm9705.c:(.text+0x128): undefined reference to `snd_ac97_reset'
> > >     sound/soc/codecs/wm9712.o: In function `wm9712_soc_resume':
> > >     wm9712.c:(.text+0x2d1): undefined reference to `snd_ac97_reset'
> > >     sound/soc/codecs/wm9713.o: In function `wm9713_soc_resume':
> > >     wm9713.c:(.text+0x820): undefined reference to `snd_ac97_reset'
> > >
> > > Fix this by adding the missing dependencies on SND_SOC_AC97_BUS.
> > >
> >
> > With this patch applied, arm:pxa_defconfig reports a variety of unmet
> > SND_SOC dependencies, and it fails to build.
> >
> > ERROR: "snd_ac97_reset" [sound/soc/codecs/snd-soc-wm9713.ko] undefined!
> > ERROR: "snd_ac97_reset" [sound/soc/codecs/snd-soc-wm9712.ko] undefined!
> > ERROR: "snd_ac97_reset" [sound/soc/codecs/snd-soc-wm9705.ko] undefined!
> >
> > Reverting this patch fixes the problem.
> 
> Should SND_PXA2XX_SOC_AC97 in sound/soc/pxa/Kconfig select
> SND_SOC_AC97_BUS instead of SND_SOC_AC97_BUS_NEW?
> The latter does not exist.
> 

Doing that results in:

sound/soc/pxa/Kconfig:24:error: recursive dependency detected!
sound/soc/pxa/Kconfig:24:	symbol SND_PXA2XX_SOC_AC97 is selected by SND_PXA2XX_SOC_TOSA
sound/soc/pxa/Kconfig:79:	symbol SND_PXA2XX_SOC_TOSA depends on AC97_BUS
sound/Kconfig:109:	symbol AC97_BUS is selected by SND_SOC_AC97_BUS
sound/soc/Kconfig:26:	symbol SND_SOC_AC97_BUS is selected by SND_PXA2XX_SOC_AC97

Guenter
