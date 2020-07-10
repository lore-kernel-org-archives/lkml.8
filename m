Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACADDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CBD2206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gxs9tKVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgGJNu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgGJNuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:50:25 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404E0C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:50:25 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id s21so5106158ilk.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/3UnV27QADhQv0SSK2DekSxwBQ7A5c5J8GoAwl8+0Nc=;
        b=Gxs9tKVAuA01c/9RSUxhuNnkHl8mzbiB9hHgi6pWCskdZ9pN27Wh3UVWs2jhyCYSAP
         TrzgS2fRi4EUodskRdDtdNQcRV4zCRkBIEa0NtyfR2KHVpUNQ5f5vnQnaMyhLUU9FK1w
         PxM+3NfRmALiDxm3E3AHHxCPaNSY0DmBCBCUoe0DLsDEMuV3RqFCuUKNyq0+smJblbDy
         hBKPUsL5zUb69gwYlLmpNNCqVu88umP9DnF0UTVdKYR2dWVMqJ4XELNgZdQZeoB41PHF
         qnNMxuG/etfsiFcERwXYyF4hJxudEkkG+RmIH4CFDsEWeSBGdmmzr8JupGAJw4c/4HKb
         3mRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/3UnV27QADhQv0SSK2DekSxwBQ7A5c5J8GoAwl8+0Nc=;
        b=dTkA3cKIFlYmib/vu+RMXkVrOjsGLPdpZKORjoq5LByEqIfCCZtfZwy6qkbxHBx75k
         5EFVOvqNKxA15NoDM+DhOwpyqpIkVX78qL7c1q+lDJNxwII+Kpvf2Nvmxm2L3CEPsli7
         rX5Gn798qHvM8HrsZW8+jHeuqmh9xDNpqGxdRK6xrYEWlFm1Qc7GnThsoup5ecDhLqX5
         aXFVtUG5TuBvfLJF0kL8CLQBCvqTcHD2nzDPqU7SLYSGr7vW+CzKilOcUKNfrVsOLBMc
         SnTE9ZVpaK/FRQXWS8wzuMzd/SSzBFVVr5k8zkBv3zCrIRnjZQzraUruz7e+85ewV1i0
         iNcw==
X-Gm-Message-State: AOAM532aYji0sAZmETRzmtSGeQrXPD14Jk8bG6vvLxhCIaCdCufZRMDZ
        cLP87ALyfzCyNXQdSCUy6cu7TcLRJe11yuLtbf0=
X-Google-Smtp-Source: ABdhPJzM7lPjNbOyPCZgsf8+Pd1yeNO5/Gz2XEbcHgsfDDQIiS1ATNkZu68Vf1RdAjOZ7ADlNCpsAe5lWqnbeDi5cZs=
X-Received: by 2002:a92:52:: with SMTP id 79mr47808521ila.59.1594389024385;
 Fri, 10 Jul 2020 06:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200709140322.131320-1-peron.clem@gmail.com> <20200709140322.131320-14-peron.clem@gmail.com>
 <0A3B73FE-0732-4024-9729-1FCE02006C27@gmail.com>
In-Reply-To: <0A3B73FE-0732-4024-9729-1FCE02006C27@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 10 Jul 2020 15:50:13 +0200
Message-ID: <CAJiuCcfnsFyOzFyNo78Etqv=apN-dnrF+gCOiwe-=d6ips8ZgQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/14] [DO NOT MERGE] arm64: dts: allwinner: h6: Add
 GPU OPP table
To:     Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 10 Jul 2020 at 15:45, Piotr Oniszczuk <piotr.oniszczuk@gmail.com> w=
rote:
>
>
>
> > Wiadomo=C5=9B=C4=87 napisana przez Cl=C3=A9ment P=C3=A9ron <peron.clem@=
gmail.com> w dniu 09.07.2020, o godz. 16:03:
> >
> > Add an Operating Performance Points table for the GPU to
> > enable Dynamic Voltage & Frequency Scaling on the H6.
> >
> > The voltage range is set with minival voltage set to the target
> > and the maximal voltage set to 1.2V. This allow DVFS framework to
> > work properly on board with fixed regulator.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> > arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 80 ++++++++++++++++++++
> > 1 file changed, 80 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/=
boot/dts/allwinner/sun50i-h6.dtsi
> > index 8f514a2169aa..a69f9e09a829 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > @@ -174,6 +174,7 @@ gpu: gpu@1800000 {
> >                       clocks =3D <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
> >                       clock-names =3D "core", "bus";
> >                       resets =3D <&ccu RST_BUS_GPU>;
> > +                     operating-points-v2 =3D <&gpu_opp_table>;
> >                       #cooling-cells =3D <2>;
> >                       status =3D "disabled";
> >               };
> > @@ -1036,4 +1037,83 @@ map0 {
> >                       };
> >               };
> >       };
> > +
> > +     gpu_opp_table: gpu-opp-table {
> > +             compatible =3D "operating-points-v2";
> > +
> > +             opp@216000000 {
> > +                     opp-hz =3D /bits/ 64 <216000000>;
> > +                     opp-microvolt =3D <810000 810000 1200000>;
> > +             };
> > +
> > +             opp@264000000 {
> > +                     opp-hz =3D /bits/ 64 <264000000>;
> > +                     opp-microvolt =3D <810000 810000 1200000>;
> > +             };
> > +
> > +             opp@312000000 {
> > +                     opp-hz =3D /bits/ 64 <312000000>;
> > +                     opp-microvolt =3D <810000 810000 1200000>;
> > +             };
> > +
> > +             opp@336000000 {
> > +                     opp-hz =3D /bits/ 64 <336000000>;
> > +                     opp-microvolt =3D <810000 810000 1200000>;
> > +             };
> > +
> > +             opp@360000000 {
> > +                     opp-hz =3D /bits/ 64 <360000000>;
> > +                     opp-microvolt =3D <820000 820000 1200000>;
> > +             };
> > +
> > +             opp@384000000 {
> > +                     opp-hz =3D /bits/ 64 <384000000>;
> > +                     opp-microvolt =3D <830000 830000 1200000>;
> > +             };
> > +
> > +             opp@408000000 {
> > +                     opp-hz =3D /bits/ 64 <408000000>;
> > +                     opp-microvolt =3D <840000 840000 1200000>;
> > +             };
> > +
> > +             opp@420000000 {
> > +                     opp-hz =3D /bits/ 64 <420000000>;
> > +                     opp-microvolt =3D <850000 850000 1200000>;
> > +             };
> > +
> > +             opp@432000000 {
> > +                     opp-hz =3D /bits/ 64 <432000000>;
> > +                     opp-microvolt =3D <860000 860000 1200000>;
> > +             };
> > +
> > +             opp@456000000 {
> > +                     opp-hz =3D /bits/ 64 <456000000>;
> > +                     opp-microvolt =3D <870000 870000 1200000>;
> > +             };
> > +
> > +             opp@504000000 {
> > +                     opp-hz =3D /bits/ 64 <504000000>;
> > +                     opp-microvolt =3D <890000 890000 1200000>;
> > +             };
> > +
> > +             opp@540000000 {
> > +                     opp-hz =3D /bits/ 64 <540000000>;
> > +                     opp-microvolt =3D <910000 910000 1200000>;
> > +             };
> > +
> > +             opp@576000000 {
> > +                     opp-hz =3D /bits/ 64 <576000000>;
> > +                     opp-microvolt =3D <930000 930000 1200000>;
> > +             };
> > +
> > +             opp@624000000 {
> > +                     opp-hz =3D /bits/ 64 <624000000>;
> > +                     opp-microvolt =3D <950000 950000 1200000>;
> > +             };
> > +
> > +             opp@756000000 {
> > +                     opp-hz =3D /bits/ 64 <756000000>;
> > +                     opp-microvolt =3D <1040000 1040000 1200000>;
> > +             };
> > +     };
> > };
>
> Clement,
>
> I gave run for v3 on H6 GS1 TVbox and what i discovered:
>
> 1. I have frequent hard hangs if DVFS is enabled (hard reset required),
>
> 2. hangs seems to be related to operating points changing - as limiting O=
PP table to any single entry (tested on 5 highest OPP ) makes my GS1 stable=
 working,
>
> 3. hang seems to be exactly related to OPP changes as having OPP table ev=
en with just 2 entries already gives hangs,
>
> 4. tunings with <regulator-ramp-delay> makes no difference (tested with 0=
, 2500 and 25000). Also increasing <regulator-enable-ramp-delay> 2 times up=
 (to 64000) makes no change.
>
> Now I have 2 hypothesis:
>
> a. issue is SW related: software operations in DVFS are somehow "unsafe" =
at touching hardware (is it possible we have i.e. concurrency issue here?);
>
> b. issue is HW related: i.e. in steep-up OPP, time between sending change=
 Vdd-gpu command to HW for increasing Vdd and sending command to HW for inc=
reasing GPU freq is too short.
>
> To investigate further I done following test: limit OPP table to 4 entrie=
s+all 4 entries have the same Vdd.
>
> If this test will pass the we know issue is b\.
> If it will fail - then issue is a\.
>
> And on my GS1 this test fails....so for me issue is a\ likely=E2=80=A6.
>
> let me know how i can help!

Yes it definitely helps, thanks !

+CC linux-sunxi

If someone wants to have a look at the sunxi-ng clk driver.

Regards,
Clement

>
> br
