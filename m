Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A01DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B6D20823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593016235;
	bh=Pfvomw1TLLTzfltrArXaoZtSgfvtwJFjZsI9bAfnSVc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fZep3otN7HtoaHU0rEnKICg1dRDlESzSCoGFcVBEsjlymjsMqNe9VbJ/Lh11nM3fE
	 VC3abSnHptJZzafnnW0ONOpva1A2lQuitxh/u+/ynZVR3uHmRIiG5DmFQ+I51SVFCE
	 MzzbZHuZ/cMioJpSmUhHy1E75BpcFNpbJ+5082rY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405083AbgFXQab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:30:31 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:19226 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405125AbgFXQaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:30:19 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 05OGTfaR005680;
        Thu, 25 Jun 2020 01:29:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 05OGTfaR005680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1593016182;
        bh=c7+M29aF8yRW1Nkcx3gmqJt9IcqAJwKGtRkbRqyOzlI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g/XKpchLT4+QDgFpZ5vxzPNPPd1pneaOQG/HaUF++M/but0/NyVM0OW43RYYL7NXH
         gXc7Rqg3o6pimKVZcv13hX59xry2PZrlcEwIjBithJ5U4jVaMEFoMX3LIqcxWBbVST
         LhdeM91mQng6q7E5JeWgDtUGGde0EzoCA2S5LCP8NEXThj4nqiVGdkr4qfEVJVEcfb
         JKnLAaHhNbd/CUldhH0Qy/30la1zmclXZMrE8XwcGHl9m60W2SnvNBjx0QFtT9xmLx
         1lot417jPjKESVGxFzk1/tZyjvE6SyjtyHAkc0jyWPxA17kh4VcMzdzExLe4S4EEW5
         77FO8SlYaDeIA==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id o15so1723697vsp.12;
        Wed, 24 Jun 2020 09:29:42 -0700 (PDT)
X-Gm-Message-State: AOAM532CgQDUnnymHO1BdB/N7m4SHDAmQFM1glxkcvZWUe0Fgek8L6Eo
        tjY+0mlXSD5XHpNWmYMBNaFcP5OGJS9gIDHBQOg=
X-Google-Smtp-Source: ABdhPJxYmf0AwU89oXZeD9Fz7mOb8pgZwxbLdIcFX447lpPev/jeGL1RUIg6DRLVZaYYRC5jxEGgZi7AC9NNVrmmWQM=
X-Received: by 2002:a67:2d42:: with SMTP id t63mr23107336vst.181.1593016180953;
 Wed, 24 Jun 2020 09:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200623114614.792648-1-yamada.masahiro@socionext.com>
 <20200623114614.792648-4-yamada.masahiro@socionext.com> <20200623122413.GA954398@dell>
In-Reply-To: <20200623122413.GA954398@dell>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 25 Jun 2020 01:29:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR-dm6Zbtt9MsUunn9+qqwTtRCbq4Wzb=8uKLtfaLK6TQ@mail.gmail.com>
Message-ID: <CAK7LNAR-dm6Zbtt9MsUunn9+qqwTtRCbq4Wzb=8uKLtfaLK6TQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: dts: uniphier: change support card to simple-mfd
 from simple-bus
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 9:24 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 23 Jun 2020, Masahiro Yamada wrote:
>
> > 'make ARCH=3Darm dtbs_check' emits the following warning:
> >
> >   support-card@1,1f00000: $nodename:0: 'support-card@1,1f00000' does no=
t match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
> >
> > Maybe, simple-mfd could be a better fit for this device.
>
> The two should be equivalent.

Yes, I know.
That's why I can change "simple-bus" to "simple-mfd"
with no risk.

The difference is schema-check.

The node name for "simple-bus" is checked by 'make dtbs_check'.

See this code:
https://github.com/robherring/dt-schema/blob/v2020.05/schemas/simple-bus.ya=
ml#L17

Even if I rename the node, it does not accept the
unit name '1,1f00000'



>
> What do you mean by "maybe"?  Does this squash the warning?

"maybe" means I am not quite sure
which compatible is a better fit
to describe this device.


As mentioned above, simple-bus and simple-mfd
are interchangeable from a driver point of view.

This add-on board is integrated with various peripherals
such as 16550a serial, smsc9115 ether etc.
The address-decode is implemented in a CPLD device.
It has chip selects and local addresses, which are mapped to
the parent.

It can be either simple-bus or simple-mfd, I think.


dt-schema checks the node name of simple-bus.
Currently, there is no check for simple-mfd.

So, I think this patch is an easy solution
to fix the warning.

Rob is in Cc. Please add comments if any.


>
> Isn't the issue caused by the ','?

Right.

The node name of simple-bus
must meet the regular expression:
"^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$"


Even if I rename the node
"support-card@1,1f00000"
to "bus@1,1f00000", the warning is still
displayed due to ','

"1,1f00000" means
the address 0x01f00000 of chip select 1.


Thanks

>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  arch/arm/boot/dts/uniphier-support-card.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/uniphier-support-card.dtsi b/arch/arm/bo=
ot/dts/uniphier-support-card.dtsi
> > index 11e46e7de7c5..eedc10cbc6e6 100644
> > --- a/arch/arm/boot/dts/uniphier-support-card.dtsi
> > +++ b/arch/arm/boot/dts/uniphier-support-card.dtsi
> > @@ -10,7 +10,7 @@ &system_bus {
> >       ranges =3D <1 0x00000000 0x42000000 0x02000000>;
> >
> >       support_card: support-card@1,1f00000 {
> > -             compatible =3D "simple-bus";
> > +             compatible =3D "simple-mfd";
> >               #address-cells =3D <1>;
> >               #size-cells =3D <1>;
> >               ranges =3D <0x00000000 1 0x01f00000 0x00100000>;
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog



--
Best Regards
Masahiro Yamada
