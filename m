Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AC7C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 14:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28D7B2158C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 14:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+DSm09D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgGDO44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 10:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgGDO4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 10:56:55 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC90BC061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 07:56:55 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id h16so6156304ilj.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 07:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xot0KZ1EhWhfJq9HViGtN+bjZ+WybGEZJy8V2k8H9TI=;
        b=L+DSm09D9IOs8fQMjRPagxmF/LrDsnvEidAHM5GlNEaZpGydFRJxhRnCVJ6Bb7WH6S
         wVWExwHDrG+zZpuoS0PMpd54HCnUOaoN5Zuo1w/1oGzNNn2250lFWFx9033HIeYa1W9M
         Usimdpt6GaSUGN3MRZJdX8bVuYNRS8K0aIxrSZwoiwch0IdJdJvhf4xpDGYdB32JzoCb
         Q8DZtKOyK/PPqBsFMxWPp6stlDrMaXt3OvFOaM1LyQaTHFVqJFRsqIQU2G3UvlY+u2GZ
         /UKe30xKzAQNaZgSCTTbPnFLmb+oGzTC+PvPN29jlXf9glwG7knBaK0MWnIsE3Uv0k1r
         gt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xot0KZ1EhWhfJq9HViGtN+bjZ+WybGEZJy8V2k8H9TI=;
        b=nBAoWB/80gOrC+2SGBWgejVnliCBzFjDkQLnrm7+9X1cYSPSPFHkGq+EHX3Otnbozu
         fKPZ4b1fqQJO2IuHkY7Upa2lK9oSlfLNytS5g9leYGC3q2b5bNxtvfRNcpmvaCZH+6wm
         GawERQG5RvRuwB241/R9WhR1hx0/zu3qIDseRLIQQqCHhMLh3hMn43cExP4CrXKsUdxk
         1+GyC4Q6T2OM15g9pOUBI/iObVmyl3e+nRDf3Lmsc+dHBWHa36JyDJ6Bai27eW7LUirx
         szL1g5eAec82S4CTuoQtkm7gIrbsPj88SDOtQW5q12pnLu7Nl9z/yHgIY0qkZdeAMTtr
         7WDw==
X-Gm-Message-State: AOAM5316PYcmcUb8JK8pXnJRu0JWCczr74EUwURCHqhy42+B+3R7nWBX
        YSLQIDRFWzA9ScUkDWfAf0BF7Xu+TREFWqXLqMg=
X-Google-Smtp-Source: ABdhPJzZI6M2X2Py25VI8P/xoBsFbu293qqnEY1FZx4xraT+OgFvgXhjvPq2ppWX6qK158wzfmgJldJ1NM4LwmqYN0I=
X-Received: by 2002:a05:6e02:1250:: with SMTP id j16mr22791618ilq.293.1593874614973;
 Sat, 04 Jul 2020 07:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200704102535.189647-1-peron.clem@gmail.com> <20200704102535.189647-14-peron.clem@gmail.com>
 <20200704121301.jfd3m3jnlghmddg4@gilmour.lan>
In-Reply-To: <20200704121301.jfd3m3jnlghmddg4@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sat, 4 Jul 2020 16:56:44 +0200
Message-ID: <CAJiuCceMS__bNVO54E2OYnqnaOAL9pGkxRo4XAABiyqagaEtmw@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] [DO NOT MERGE] arm64: dts: allwinner: h6: Add
 GPU OPP table
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Sat, 4 Jul 2020 at 14:13, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> On Sat, Jul 04, 2020 at 12:25:34PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Add an Operating Performance Points table for the GPU to
> > enable Dynamic Voltage & Frequency Scaling on the H6.
> >
> > The voltage range is set with minival voltage set to the target
> > and the maximal voltage set to 1.2V. This allow DVFS framework to
> > work properly on board with fixed regulator.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
>
> That patch seems reasonable, why shouldn't we merge it?

I didn't test it a lot and last time I did, some frequencies looked unstabl=
e.
https://lore.kernel.org/patchwork/cover/1239739/

This series adds regulator support to Panfrost devfreq, I will send a
new one if DVFS on the H6 GPU is stable.

I got this running glmark2 last time
# glmark2-es2-drm
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
    glmark2 2017.07
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
    OpenGL Information
    GL_VENDOR:     Panfrost
    GL_RENDERER:   Mali T720 (Panfrost)
    GL_VERSION:    OpenGL ES 2.0 Mesa 20.0.5
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

[   93.550063] panfrost 1800000.gpu: GPU Fault 0x00000088 (UNKNOWN) at
0x0000000080117100
[   94.045401] panfrost 1800000.gpu: gpu sched timeout, js=3D0,
config=3D0x3700, status=3D0x8, head=3D0x21d6c00, tail=3D0x21d6c00,
sched_job=3D00000000e3c2132f

[  328.871070] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
0x0000000000000000
[  328.871070] Reason: TODO
[  328.871070] raw fault status: 0xAA0003C2
[  328.871070] decoded fault status: SLAVE FAULT
[  328.871070] exception type 0xC2: TRANSLATION_FAULT_LEVEL2
[  328.871070] access type 0x3: WRITE
[  328.871070] source id 0xAA00
[  329.373327] panfrost 1800000.gpu: gpu sched timeout, js=3D1,
config=3D0x3700, status=3D0x8, head=3D0xa1a4900, tail=3D0xa1a4900,
sched_job=3D000000007ac31097
[  329.386527] panfrost 1800000.gpu: js fault, js=3D0,
status=3DDATA_INVALID_FAULT, head=3D0xa1a4c00, tail=3D0xa1a4c00
[  329.396293] panfrost 1800000.gpu: gpu sched timeout, js=3D0,
config=3D0x3700, status=3D0x58, head=3D0xa1a4c00, tail=3D0xa1a4c00,
sched_job=3D0000000004c90381
[  329.411521] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
0x0000000000000000
[  329.411521] Reason: TODO
[  329.411521] raw fault status: 0xAA0003C2
[  329.411521] decoded fault status: SLAVE FAULT
[  329.411521] exception type 0xC2: TRANSLATION_FAULT_LEVEL2
[  329.411521] access type 0x3: WRITE
[  329.411521] source id 0xAA00

Regards,
Clement

>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 80 ++++++++++++++++++++
> >  1 file changed, 80 insertions(+)
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
>
> All those nodes will create DTC warnings though.
>
> Maxime
