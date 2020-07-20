Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FECAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09CA1207EA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOXPGIWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgGTEtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 00:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgGTEtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 00:49:03 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD910C0619D2;
        Sun, 19 Jul 2020 21:49:02 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t27so12130927ill.9;
        Sun, 19 Jul 2020 21:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hykuBzcQ6JT3wzEabWJ6sI/goux4rgrhcf0X//gbPRY=;
        b=rOXPGIWdn6zcC4rUUB7g7aKt7IlknEPmZGirbVCRmNoSa/ISlUoxy2qQQJXmjJXFiZ
         SKYcvaBbYwvmTJDG9Wkyj4jN4QTH1419wfnS0uHOowdvdhrOrQmg331XJAKc3k+kTfm8
         W4iIJuNL+Rvg7Kyq+8ZLr7vnztCJ+DCgjola3CNBgIa+l5YD2Lma09yf7btHE9G6RT6l
         5DLeY/Gxai/EuQa2QdAlfwVltgffOwk4Tx22pzrAGEkaSLQ5zTcg4UgYyZv8xGkh01Uv
         EoRD0uv/X8Ra0PV3jqbtae3MBRY9bJ7XMoQrXbNd+H+FVy38uikZSi+PCPgVbPKwQCTB
         VWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hykuBzcQ6JT3wzEabWJ6sI/goux4rgrhcf0X//gbPRY=;
        b=ZOwM5MII57GvY/kFGOIjxP+BiIdHLEjy5DiO+wGwmvdeaTCih/CFkQLXqqk/Q/0i5a
         RwrO1XcssG7aIPPdgX0vsKzWbOWMfRAtdjbjCEf6t6fObfFYyASxCI7+PI9PgJ8vraVN
         rlFt8cCFH9V5v3cPkLPXJr6hHjvPbFJFMR0LcWlowydT6J5b+o2+/SRGULflFNfdW7pd
         Tt8he8FzUEgC/iATYkOgTwlMTmuooQY+2YDJMbL26nARmtjR726TMXydrQkK9X+oBg9d
         AkBbgDXsoYaRjyMyfQXdsC0GW2z8PvGGKC7p3aLAqujotOD5gfiPD6DaF8LH0yfL377k
         IWKg==
X-Gm-Message-State: AOAM531PQ0q7IW6S10TixSO/Yz9uxmLAe7qhqU/Xo80vwExbG5k9nN3T
        +SscVj8TKPhT/0ETPDUNYGSzb3P2HYlpLBWGOEE=
X-Google-Smtp-Source: ABdhPJzhCufX0FYkh/NJ8xIrGFKFZlshKwqWHB0QcwGE6RQ3jDvOM2oYeSZg+1CrugUcYu1S1tNhgdH7OZb+TjHmsyg=
X-Received: by 2002:a92:5b4b:: with SMTP id p72mr21120945ilb.285.1595220542254;
 Sun, 19 Jul 2020 21:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200715212227.26436-1-cphealy@gmail.com> <20200720031534.GJ11560@dragon>
In-Reply-To: <20200720031534.GJ11560@dragon>
From:   Chris Healy <cphealy@gmail.com>
Date:   Sun, 19 Jul 2020 21:48:51 -0700
Message-ID: <CAFXsbZqfC2zq7OFCYYDCMY6YQghjSawAAhm4Hwvc6FVRuwt2wA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: ZII: Disable HW Ethernet switch reset GPIO
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 8:15 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Wed, Jul 15, 2020 at 02:22:27PM -0700, Chris Healy wrote:
> > Disable Ethernet switch reset GPIO with ZII platforms that have it
> > enabled to sync up with existing ZII platforms that already have
> > it disabled.
>
> I do not follow it.  The reset GPIO is part of hardware description.  We
> shouldn't add or remove it for sake of sync-up with other platforms.

I see that my description is not very good.  What I should have said
is that we don't want to use the HW reset GPIO as it results in things
being done that we do not want done.  Specifically, when the switch is
hit with the HW reset GPIO, it results in the switch's copper PHYs
being HW reset which we want to avoid as this results in unnecessary
network downtime on a soft reboot of the processor.  With the HW reset
GPIO not in the devicetree description, the switch driver resorts to
doing a SW reset which resets the switch core but not the switch's
copper PHYs.  This results in a much shorter network downtime on a
soft reboot of the processor.

I can do a v2 of the patch with the description updated if you think
it would be appropriate.

>
> Shawn
>
> >
> > Signed-off-by: Chris Healy <cphealy@gmail.com>
> > ---
> >  arch/arm/boot/dts/vf610-zii-cfu1.dts      | 2 --
> >  arch/arm/boot/dts/vf610-zii-spb4.dts      | 2 --
> >  arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts  | 2 --
> >  arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 2 --
> >  4 files changed, 8 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts b/arch/arm/boot/dts/vf610-zii-cfu1.dts
> > index ce1920c052fc..c2668230a4c0 100644
> > --- a/arch/arm/boot/dts/vf610-zii-cfu1.dts
> > +++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
> > @@ -170,7 +170,6 @@
> >                       interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
> >                       interrupt-controller;
> >                       #interrupt-cells = <2>;
> > -                     reset-gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
> >
> >                       ports {
> >                               #address-cells = <1>;
> > @@ -354,7 +353,6 @@
> >       pinctrl_switch: switch-grp {
> >               fsl,pins = <
> >                       VF610_PAD_PTB28__GPIO_98                0x3061
> > -                     VF610_PAD_PTE2__GPIO_107                0x1042
> >               >;
> >       };
> >
> > diff --git a/arch/arm/boot/dts/vf610-zii-spb4.dts b/arch/arm/boot/dts/vf610-zii-spb4.dts
> > index 55b4201e27f6..261317340189 100644
> > --- a/arch/arm/boot/dts/vf610-zii-spb4.dts
> > +++ b/arch/arm/boot/dts/vf610-zii-spb4.dts
> > @@ -127,7 +127,6 @@
> >                       pinctrl-names = "default";
> >                       reg = <0>;
> >                       eeprom-length = <65536>;
> > -                     reset-gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
> >                       interrupt-parent = <&gpio3>;
> >                       interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
> >                       interrupt-controller;
> > @@ -312,7 +311,6 @@
> >
> >       pinctrl_gpio_switch0: pinctrl-gpio-switch0 {
> >               fsl,pins = <
> > -                     VF610_PAD_PTE2__GPIO_107                0x31c2
> >                       VF610_PAD_PTB28__GPIO_98                0x219d
> >               >;
> >       };
> > diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
> > index a6c22a79779e..e37b9643269b 100644
> > --- a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
> > +++ b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
> > @@ -113,7 +113,6 @@
> >                       pinctrl-names = "default";
> >                       reg = <0>;
> >                       eeprom-length = <65536>;
> > -                     reset-gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
> >                       interrupt-parent = <&gpio3>;
> >                       interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
> >                       interrupt-controller;
> > @@ -288,7 +287,6 @@
> >
> >       pinctrl_gpio_switch0: pinctrl-gpio-switch0 {
> >               fsl,pins = <
> > -                     VF610_PAD_PTE2__GPIO_107                0x31c2
> >                       VF610_PAD_PTB28__GPIO_98                0x219d
> >               >;
> >       };
> > diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
> > index 3d05c894bdc0..b3d6d4b9fa9c 100644
> > --- a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
> > +++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
> > @@ -141,7 +141,6 @@
> >                       pinctrl-names = "default";
> >                       reg = <0>;
> >                       eeprom-length = <65536>;
> > -                     reset-gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
> >                       interrupt-parent = <&gpio3>;
> >                       interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
> >                       interrupt-controller;
> > @@ -319,7 +318,6 @@
> >
> >       pinctrl_gpio_switch0: pinctrl-gpio-switch0 {
> >               fsl,pins = <
> > -                     VF610_PAD_PTE2__GPIO_107                0x31c2
> >                       VF610_PAD_PTB28__GPIO_98                0x219d
> >               >;
> >       };
> > --
> > 2.21.3
> >
