Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55102C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2596C2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="IT02dr8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgFKOTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgFKOTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:19:43 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06829C08C5C2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:19:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j198so7075084wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dnKHXPEH1ozj37XOHtlpuuX/tbRfdpMEjZIEpqlLX6M=;
        b=IT02dr8GiskF5HGBwCOY84YSjJ5fu38NZHDoVPW7pUp3oEhZJwUiNVkPodr7wSVMTK
         kkv60uU6Ss3TLFgX8lqs4zDFWnQV0tQ8z7co8MsQb9sDFhmYGg1dvzFmRsGLexWwl3ON
         Cckjui3jfLAUmj6YPXOey9tYqH3IvmrSyQN68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dnKHXPEH1ozj37XOHtlpuuX/tbRfdpMEjZIEpqlLX6M=;
        b=tIDXtqzgrFWr8VSdInjiVhEOFpzo7BOI0lHVlCTjo2CjTRhM3PYXInRRYGoL5tCFJm
         FU5Vi7x6idypx9PJjiZBocs3drugHoJpBy6f2RZ7Wvxr8oNTGqxYJXxqxTheYBrV4dt1
         V4rjC0wbLB1RPM2CuWrWqqruw6/9op+5ZXDdjX6x00tKeM9c+/avuDV/xIgfJvwoEFld
         Z8bV727Vu6/jrURasR7hKSs7YhZ9RqjqwsrKF8d0wrid2hcBPtT3m94Zn0yWC4iItlAM
         S3Azk9GCgE7bscioXbBKOB96Aedwf2GSv8+JF3/woZKiUwGeLSx+LrtXyk/Pp+R1b6Qr
         4L5w==
X-Gm-Message-State: AOAM530Lo0AD9Fv7AGICw3ynlxP/pT+U+d0PtNIGLK+KzCbLi1fcsZmI
        W4RvbNpXVSM2Dk9MbbiU9d25cO9aBCqP7lOb1uGBBw==
X-Google-Smtp-Source: ABdhPJwWn0Zuh4S+EzgrstrMFDmZbJ3qgVEgyY/VvonZ/Q9c/GYK2/Uyvn7J4TIzAvqDdFRozzqzSO4by1SmGPIyD4Y=
X-Received: by 2002:a1c:491:: with SMTP id 139mr7954685wme.99.1591885179520;
 Thu, 11 Jun 2020 07:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191014061617.10296-2-daniel@0x0f.com> <20200610090421.3428945-4-daniel@0x0f.com>
 <bf26822d-acb0-ae40-df7f-80978bd26cfb@suse.de>
In-Reply-To: <bf26822d-acb0-ae40-df7f-80978bd26cfb@suse.de>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Thu, 11 Jun 2020 23:19:23 +0900
Message-ID: <CAFr9PXmp=mZhyRDpx_E0_1Zc5SFrSYUm9jP-k7VCDf9P37sT6g@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ARM: mstar: Add infinity/mercury series dtsi
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Thu, 11 Jun 2020 at 22:39, Andreas F=C3=A4rber <afaerber@suse.de> wrote:

> Can you split this up into three parts for easier review?

Understood. Will do.

> 2019-2020? Check elsewhere.

The patches are originally from 2019. I'll update everything.

> > + * Author: Daniel Palmer <daniel@thingy.jp>
> > + */
> > +
> > +#include "infinity.dtsi"
> > +
> > +/ {
> > +     memory {
> > +             device_type =3D "memory";
> > +             reg =3D <0x20000000 0x4000000>;
>
> The memory node needs to become memory@20000000 then.
>
> > +     };
>
> I take it, this RAM is integrated? Maybe add some explanation of what
> this file is

Yes. The memory is integrated and the size depends on the specific chips
so the memory node is at the chip level dtsi and not the board level.

> > +};
> > diff --git a/arch/arm/boot/dts/infinity.dtsi b/arch/arm/boot/dts/infini=
ty.dtsi
> > new file mode 100644
> > index 000000000000..25d379028689
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/infinity.dtsi
> > @@ -0,0 +1,10 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2019 thingy.jp.
> > + * Author: Daniel Palmer <daniel@thingy.jp>
> > + */
> > +
> > +#include "mstar-v7.dtsi"
> > +
> > +/ {
> > +};
>
> What do you intend to add here? Is it really needed? (same below)

The specific nodes will go into there. This is mostly an artefact of splitt=
ing
the device trees out of a more developed tree.

> > new file mode 100644
> > index 000000000000..cf5f18a07835
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/infinity3.dtsi
> > @@ -0,0 +1,10 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2019 thingy.jp.
> > + * Author: Daniel Palmer <daniel@thingy.jp>
> > + */
> > +
> > +#include "infinity.dtsi"
> > +
> > +/ {
> > +};
>
> Don't you anticipate incompatibilities between infinity and infinity3,
> i.e., things you don't want to inherit? Seems a bit optimistic. You can
> of course overwrite properties, but deleting is more difficult.

In my tree with drivers for the rest of the hardware it hasn't been a probl=
em.
So far I've found infinity, infinity2, infinity3, infinity5 and
infinity6 chips. The memory
map for them is almost identical and the changes are adding in more
copies of things
like DMA controllers, extra clock blocks etc.

Having infinity.dtsi as the base for the newer versions should avoid
having duplication
of nodes that aren't common on the mstar armv7 level but are common to
the infinity subtypes.

There are two good examples of this:
For infinity? the USB and SD controllers are at the same place for all
of the chips I've
found so far. Unfortunately, despite using the same IP block and the
same driver those
blocks are in different places in the mercury5. At the moment with all
of the infinity chips
pulling in infinity.dtsi those nodes are only in infinity.dtsi and
mercury5.dtsi.
If infinity?.dtsi are all stacked on top of the mstarv7.dtsi base then
there will be a number of
copies of the same nodes.

> > diff --git a/arch/arm/boot/dts/mercury5.dtsi b/arch/arm/boot/dts/mercur=
y5.dtsi
> > new file mode 100644
> > index 000000000000..25d379028689
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/mercury5.dtsi
> > @@ -0,0 +1,10 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2019 thingy.jp.
> > + * Author: Daniel Palmer <daniel@thingy.jp>
> > + */
> > +
> > +#include "mstar-v7.dtsi"
> > +
> > +/ {
> > +};
> > diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-=
v7.dtsi
> > new file mode 100644
> > index 000000000000..0fccc4ca52a4
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/mstar-v7.dtsi
>
> So this is the only file starting with mstar. Have you thought about
> prefixing infinity/mercury, so that they're grouped together?

I have been thinking about that. I didn't see any other dts in arm that had
the vendor as a prefix though. With arm64 everything is in per vendor
subdirectories
to achieve the same thing.

> > +             };
> > +
> > +             pm_uart: uart@1f221000 {
> > +                     compatible =3D "ns16550a";
> > +                     reg =3D <0x1f221000 0x100>;
> > +                     reg-shift =3D <3>;
> > +                     clock-frequency =3D <172000000>;
> > +                     status =3D "disabled";
> > +             };
>
> If you have any decent manuals for these SoCs,

Everything so far has been reverse engineered from an old 3.18
kernel, poking with a multimeter etc. I wish I had a decent manual.

> I suggest to check whether there are any internal buses that you may
> want to model as simple-bus for grouping. In-tree examples include meson
> and recently merged rtd1195 - it affects the reg addresses and unit addre=
sses via
> suitable ranges mappings.

There is a bridge that is between the CPU and the peripheral registers
that doesn't quite fit simple-bus (from what I remember it needs a clk).
My plan was to introduce the thin driver for that bus (it just consumes the=
 clks
it needs so they don't get disabled at the moment) after introducing
the clk support.

Thanks,

Daniel
