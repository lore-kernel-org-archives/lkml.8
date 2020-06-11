Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B680FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E28F20760
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="S/jl+slL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgFKNSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgFKNSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:18:31 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEF2C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 06:18:30 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f185so5024518wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3D40KyYMeXLRFbWmcuYLD5ZmMexI/dbs3uEPHhCTA4U=;
        b=S/jl+slL4mssBKVD02XQnVYrrTOFXjeWo7eAXEftnHakKzcEeJu79b3roxehmDRQLa
         kzmUXI63zJ99Ff+zyFfuphDwSrKVjOOnFmkLlbzMUHsu7x8mz+FO5iQxXm+/R9kv6fCq
         iTV1yBhl6egCeeQ33/ivG+d3xVEOcFFrSJqVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3D40KyYMeXLRFbWmcuYLD5ZmMexI/dbs3uEPHhCTA4U=;
        b=hoGiSRByEud47ilN7EfWOmfMeA3FK0i/0cJ+uvGmU3Qy5PhYxOT72H5KiUcm1iP4pS
         +cM5AzajJ2ylMAoMwmf9jhdlqyLmddexGDlayqdy//J6CzRFcBIhXERJkSpP2G08RBZD
         xTXq1xsFNQ/hbaGb3YFcf4qehuW6FMgr4Ti33wzZv8sM7dtddRLl5ZAwlPsUCUU9Yq7I
         PIuhBYZiCWrVK0eru4OcZLGlkT7RpP/xwra7u23wGp3yMChw4wDYMBubnzJGY4PKIOMf
         9fKXXWjH63nCUwOXejA0/ALAJaSMGXUY/m1uJEWggu3X3sqXjGC7cIksSWd/Lm5LclEC
         DcQQ==
X-Gm-Message-State: AOAM5306SaXf31B9iOopsbf64sIiPQT4ogNh07rhpn7zFY4nFcJsNomo
        nOWLXjBUIN0NSqA8TJKmCyao6Q/1D0SHXexvW67eng==
X-Google-Smtp-Source: ABdhPJyN9QaXL2/nALzV6Wm81/61c10NORZKfBtIvPfa3KPmZdM5dbRmE8hjWi4WODPLxAiHTdkMMTDuDyWSkjv413E=
X-Received: by 2002:a1c:7206:: with SMTP id n6mr8461880wmc.4.1591881509341;
 Thu, 11 Jun 2020 06:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191014061617.10296-2-daniel@0x0f.com> <20200610090421.3428945-3-daniel@0x0f.com>
 <f66978d8-22c5-1883-c6bf-52c0c19d6603@suse.de>
In-Reply-To: <f66978d8-22c5-1883-c6bf-52c0c19d6603@suse.de>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Thu, 11 Jun 2020 22:18:13 +0900
Message-ID: <CAFr9PX=jNE-y++W=PVr=EQTiA4CtTM6xpsy2=pnJGPB_Z-BLqg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] ARM: mstar: Add machine for MStar/Sigmastar
 infinity/mercury family ARMv7 SoCs
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Thu, 11 Jun 2020 at 21:58, Andreas F=C3=A4rber <afaerber@suse.de> wrote:

> You call the dir mach-mstar, but name the Kconfig ARCH_MSTARV7. I had
> previously been asked to just use the vendor name, so this should
> probably be just ARCH_MSTAR. Outside arch/arm/ you can then use ARM &&
> ARCH_MSTAR condition to make things 32-bit only, allowing to reuse
> ARCH_MSTAR for arm64 or whatever.

The ARM9 MStar chips before they switched to a common ARMv7 base aren't dir=
ectly
compatible so I thought there should be some distinction there. I
doubt anyone will do it
but I made the directory mach-mstar so potentially someone could add
machine support
for the older stuff to without having more directories.

> > +     bool "MStar/Sigmastar ARMv7 SoC Support"
> > +     depends on ARCH_MULTI_V7
> > +     select ARM_GIC
> > +     select ARM_HEAVY_MB
> > +     help
> > +       Support for newer MStar/Sigmastar SoC families that are
> > +       based on ARMv7 cores like the Cortex A7 and share the same
> > +       basic hardware like the infinity and mercury series.
> > +
> > +if ARCH_MSTARV7
> > +
> > +config MACH_INFINITY
> > +     bool "MStar/Sigmastar infinity SoC support"
> > +     default ARCH_MSTARV7
> > +     help
> > +       Support for MStar/Sigmastar infinity IP camera SoCs.
> > +
> > +config MACH_MERCURY
> > +     bool "MStar/Sigmastar mercury SoC support"
> > +     default ARCH_MSTARV7
> > +     help
> > +       Support for MStar/Sigmastar mercury dash camera SoCs.
> > +       Note that older Mercury2 SoCs are ARM9 based and not supported.
>
> Is this comment really helpful? This menu item would only seem to come
> up after having selected multi_v7, which kind of rules out ARM9.

The older mercury2 based chips seem to still be available and used in
drive recorders
that are on the market right now. The infinity series is all ARMv7 so
can be supported
but for the mercury series only the newer ones are ARMv7 so I thought
it was worth
mentioning that "mercury SoC support" doesn't mean all of them. I'll
take it out if you
think it's unnecessary.

> Consider adding mercury in a second step?

I'll think about that. I wanted to try to get a machine that isn't one
I'm personally making
into the series.

Cheers,

Daniel
