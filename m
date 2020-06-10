Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505B1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28AF5206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="cVxMfXgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgFJK3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgFJK3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:29:24 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD4FC03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:29:23 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t18so1643328wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2gvb3h72zonJCVPACju41Fbw0tDgnKx5h0TrDtNmZYU=;
        b=cVxMfXgKRNgr+F74+NX6QkCCJWBVbcaIolD7qRiQgmfdoxxyjdPNvQqSVPvDNHyU5b
         zutGY00KZ+V2A6xa7UdrCQ4mbO4KOBSVlbJnEi24sWcxCPzWJkbKuUydpqJuzjNDhXN4
         ztN4nLKUUI+zmTNQ1wipCZvj9rX1uD5inqNhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2gvb3h72zonJCVPACju41Fbw0tDgnKx5h0TrDtNmZYU=;
        b=V4D4HgrDnb0/1WUmkycB+xvyXg9BG3h3mAUVQRo813KDdulN8bgNzVXXzgk+luo6D5
         CDcC7rmilozatKNrAW3s24Xkyzqb6P65UdUZujw4LkM3AgkTZf6Zrl6u3hCQIhlNHzGp
         CzLGlwZm6eAssz9fKob+MlBIXg//35tgtkip5uowGuN+fb/x6aIWFkXUSJ39kM5HI5a3
         +zHsp9hFxGCY3sRgIBMFG+0gnbgUTyyMo5HhrNuoWIMtp+QqDyuLGdlTHTZvWv4NwBdr
         XjYwkaazjQ60kBTrr78sWWpPAuDgLsK597rFxPfphM5DBEY2Jjr945DqUaYB8Ltw83Ye
         5LXg==
X-Gm-Message-State: AOAM531CN9yQfVNjjlNOpt0r+/+Zp5WL19NOW03VAVg28qLcBqYPAOGt
        iuBPxd3hOKuKW+TeQk6h1Qe+oM4M9kUiqzkescakaw==
X-Google-Smtp-Source: ABdhPJykAxEMxc/5PA42qda+imN1iaGFnWE/E5DN0O6oJJrD3srN7KBugNNqszuh2dH7sSY67I4FzMJcwCuoTywbwrw=
X-Received: by 2002:adf:f990:: with SMTP id f16mr2793952wrr.311.1591784962225;
 Wed, 10 Jun 2020 03:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191014061617.10296-2-daniel@0x0f.com> <20200610090421.3428945-2-daniel@0x0f.com>
 <cafee323-841d-92ed-b4ad-a1aaa136864d@suse.de>
In-Reply-To: <cafee323-841d-92ed-b4ad-a1aaa136864d@suse.de>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Wed, 10 Jun 2020 19:29:06 +0900
Message-ID: <CAFr9PXnPPDWg-Jd_1=LgPEYa8Ru7eKm9wE90-DPR-ggv8NzGHA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: arm: Initial MStar vendor prefixes
 and compatible strings
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
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - description: thingy.jp BreadBee
> > +        items:
> > +          - const: thingyjp,breadbee
> > +          - const: mstar,infinity3
> > +
> > +      - description: thingy.jp BreadBee Crust
> > +        items:
> > +          - const: thingyjp,breadbee-crust
> > +          - const: mstar,infinity
> > +
> > +      - description: 70mai midrive d08
> > +        items:
> > +          - const: 70mai,midrived08
> > +          - const: mstar,mercury5
>
> I would advise to restructure these three for forward planning:

That makes a lot of sense. To be honest I basically copied something
that was in-tree to come up with something that would make checkpatch
happy and didn't think too much about it.

> >     # Keep list in alphabetical order.
> > +  "^70mai,.*":
> > +    description: 70mai
>
> "70mai Co., Ltd." please - don't just repeat the prefix.

Understood.

> If you split the vendor prefixes to a preceding patch, they have a
> chance of getting Reviewed-bys more quickly. You can then also CC the
> vendors on the prefixes you're assigning for them.

thingy.jp is the vendor I'm using for the breadbee project. As for
70mai and MStar/Sigmastar I have
tried reaching out to them in the past and they don't respond. In
70mai's case their camera doesn't
run Linux by default so I don't think they will care much.

If it helps I can split them out but I'm not sure if it'll be possible
to ever get the ok from the other vendors.
For what it's worth the "mstar" prefix is what was being used in their
kernels up until very recently when
they switched everything to using "sstar" for SigmaStar. I considered
using the sstar prefix but went
with mstar because SigmaStar is totally unknown whereas MStar is
slightly known, would be more
recognisable, most of the chips still have mstar written on them and so on.

> > +ARM/MStar/Sigmastar ARMv7 SoC support
> > +M:   Daniel Palmer <daniel@thingy.jp>
> > +L:   linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > +S:   Maintained
> > +F:   Documentation/devicetree/bindings/arm/mstar.yaml
> > +
> >   ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
> >   M:  Michael Petchkovsky <mkpetch@internode.on.net>
> >   S:  Maintained
>
> In theory it's spelled Armv7 since 2017, but MAINTAINERS, subject prefix
> conventions and many other places in Linux still use the old upper-case
> spelling, too...

Understood. I'll fix that up.

Thankyou for your input,

Daniel
