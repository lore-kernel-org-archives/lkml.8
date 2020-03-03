Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C193FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06A120828
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgCCO4h convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:56:37 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35703 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgCCO4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:56:37 -0500
Received: by mail-oi1-f194.google.com with SMTP id c1so1850087oiy.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 06:56:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x3zNZ7d0/O3piZAKwaRzICowqFDeT12MhX8I85ngdoI=;
        b=YGWLwrKe/VK8lWW+zAnAYSLacQTH6NkaDbIC9PDzeCVkoGrp3FkwZH51ugsROxMlM1
         TMZv7Q8WeDiC1Fo7W2vss94YW6QZTVoyPQHuxUHs448AaHfyW3mE10oleRaJ5SkQCu83
         vnfkuOaAZmXxZARVoKaWWT4mXYWvILfS5R+Yz+2QtCwi2g9+8l6jbogX56ujDXEi5sED
         oia1HcShNxT+x+qPyDfivD6QjjZZt9hIqYOwxFqSKoWWmAlNBkE7u6sMZDI/Oz1jEC/T
         rFe0Niwd6mbVl3OqLu7T39QQT2HhNxkBVrSaGCQy4p0AX0aENyWHvC4R6b6onOhqVnbu
         kLNA==
X-Gm-Message-State: ANhLgQ2Pk4iBTJPzVt5KnqMO4VgP4WL/DsZjDH3LJvt9j8kkzZBlnEnL
        H5nuUeJ+E+vpUymVZ9+PZf8rfp/DtoldyQvwkjg=
X-Google-Smtp-Source: ADFU+vsxyoz8G7LuihX+qLVDCzU7Ls0iBKTkvdUqqQNbf2pr5oeMDXiJ/hb4dyT/P9DEa3JE+h8pPzSts0auW2RHjS4=
X-Received: by 2002:aca:cdd1:: with SMTP id d200mr2565751oig.153.1583247396276;
 Tue, 03 Mar 2020 06:56:36 -0800 (PST)
MIME-Version: 1.0
References: <20200224112537.14483-1-geert@linux-m68k.org> <20200303143444.GA25683@roeck-us.net>
In-Reply-To: <20200303143444.GA25683@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Mar 2020 15:56:25 +0100
Message-ID: <CAMuHMdWZxc5KjHaOhk5xdcjSn54i3ku7b1dW6tXhXbjku1eLww@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Fix SND_SOC_ALL_CODECS imply ac97 fallout
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Günter

On Tue, Mar 3, 2020 at 3:34 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On Mon, Feb 24, 2020 at 12:25:37PM +0100, Geert Uytterhoeven wrote:
> > On i386 randconfig:
> >
> >     sound/soc/codecs/wm9705.o: In function `wm9705_soc_resume':
> >     wm9705.c:(.text+0x128): undefined reference to `snd_ac97_reset'
> >     sound/soc/codecs/wm9712.o: In function `wm9712_soc_resume':
> >     wm9712.c:(.text+0x2d1): undefined reference to `snd_ac97_reset'
> >     sound/soc/codecs/wm9713.o: In function `wm9713_soc_resume':
> >     wm9713.c:(.text+0x820): undefined reference to `snd_ac97_reset'
> >
> > Fix this by adding the missing dependencies on SND_SOC_AC97_BUS.
> >
>
> With this patch applied, arm:pxa_defconfig reports a variety of unmet
> SND_SOC dependencies, and it fails to build.
>
> ERROR: "snd_ac97_reset" [sound/soc/codecs/snd-soc-wm9713.ko] undefined!
> ERROR: "snd_ac97_reset" [sound/soc/codecs/snd-soc-wm9712.ko] undefined!
> ERROR: "snd_ac97_reset" [sound/soc/codecs/snd-soc-wm9705.ko] undefined!
>
> Reverting this patch fixes the problem.

Should SND_PXA2XX_SOC_AC97 in sound/soc/pxa/Kconfig select
SND_SOC_AC97_BUS instead of SND_SOC_AC97_BUS_NEW?
The latter does not exist.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
