Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D07C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 676D52075E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="B+Z3WDXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgFKPAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbgFKPAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:00:06 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C973C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 08:00:05 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y17so6486160wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 08:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zn13stpxx1Rl6Xjq5ftH7LM2yq+qpmzz5Dz1MnQNUPM=;
        b=B+Z3WDXPc51flB3UeEUdxOPDGME46i9EtyeRpwFsCr5JvF64iwG4FhswMrTGyj6mGn
         s+USFO0qbs3Cf6fqQBGxT5h1ANuIBWP6Qsj6eVuGckh4r+Gl7BFlG73ifQUcbJ7jzL1n
         PEdc9X0Kw9gtBSFMIj9AYMrDQR2Rs3rAp/Pmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zn13stpxx1Rl6Xjq5ftH7LM2yq+qpmzz5Dz1MnQNUPM=;
        b=eN3AARy71VS7Dz51QUJ02ZZXYdUz5l7I+CFZKwPnnVVMJExiPqbwzZCnO9eY5XR3W2
         T6IgtHGeTIt2v5SPb7mSaNMRMCdtT1h1o6ZE4RoNgSI4MCyLVWC9kc875b4iqX6X56iS
         YexhCiuhqJKL74X12adslN8/ioMPXyIlZkqzeCL/KVKTAxYNnVvmFpqJ9zVqEElVUhSk
         4mgmeqfo1Xidj0VqA0HDQgKhivl73r5w2ew8pnGzr4mYPvwhGDH9ZYwpl2GhhI1Wlvew
         CyNce2oYxrW7bLD3w+FVPfEKTFI2w2I5aDlpDLUBXTh7ZFRK7loksShzk9q4rhPIMiVE
         th9A==
X-Gm-Message-State: AOAM530yXZWguPuFk1Wl4/V8oH4mHZCDF77TO0BhEtiPLYtWZeT7cHBC
        U+vy8Z+iHypNXhrP0ODjLbwD0sqI/aRCxVdMBLDBLg==
X-Google-Smtp-Source: ABdhPJxNJT/spy9XbHA9PU9q8cwSHEyiW4NzMoG2C4D+jtRZjp+QSEyOrmAAr+yM0n32lutR8zkOXLgsoPs/p1NMDZE=
X-Received: by 2002:adf:f003:: with SMTP id j3mr10047392wro.228.1591887603896;
 Thu, 11 Jun 2020 08:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191014061617.10296-2-daniel@0x0f.com> <20200610090421.3428945-3-daniel@0x0f.com>
 <976e789e-edd7-c44d-ea99-840ecb883ff8@suse.de> <CAFr9PXkvmZv3_EakxvRR+X522xN-a8epvF0ns10JeYCLn2uUKw@mail.gmail.com>
 <1e8262e0-9b30-0788-446a-5d88c1bb49ea@suse.de>
In-Reply-To: <1e8262e0-9b30-0788-446a-5d88c1bb49ea@suse.de>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Thu, 11 Jun 2020 23:58:44 +0900
Message-ID: <CAFr9PXkU8jYMx2NBHzNu2Xa7BfC6n9wpgxps9YE2VAcPTwdMiw@mail.gmail.com>
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

On Thu, 11 Jun 2020 at 23:27, Andreas F=C3=A4rber <afaerber@suse.de> wrote:
>
> Hi Daniel,
>
> Am 11.06.20 um 15:01 schrieb Daniel Palmer:
> > On Thu, 11 Jun 2020 at 21:49, Andreas F=C3=A4rber <afaerber@suse.de> wr=
ote:
> >>> peripherals and system memory in a single tiny QFN package that
> >>> can be hand soldered allowing almost anyone to embed Linux
> >>
> >> "soldered, allowing"?
> >
> > The original reads ok to me. Maybe I can just split that into two sente=
nces?
> > Like ".. QFN package that can be hand soldered. This allows almost anyo=
ne..".
>
> As non-native speaker I merely wondered whether a comma should better be
> inserted to separate the two parts of the sentence. Splitting it in two
> or leaving as is should be fine, too - I assume you're a native speaker.

I'm a native speaker but it's not my daily driver anymore so I often mangle=
 it.

> Most people will rather read the bindings document than old git history,
> so you might want to consider adding such a description below its title.

I'll move the blurb and maybe reword it.

> Which reminds me, in 1/5 you should probably add a W: line (after S:
> according to above sort commit) pointing to your
> http://linux-chenxing.org/ website.
>
> And for the community following your project, you may want to set up a
> linux-chenxing mailing list on vger.kernel.org or on infradead.org and
> add it as L:, to allow for error reports and patches to not just go to
> you and crowded LAKML.

Very good points. I was thinking I should probably get this into mainline
before setting up lists etc.

Thanks,

Daniel
