Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE9BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 07:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D6E12067D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 07:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSaUOWGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgHCHyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 03:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgHCHyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 03:54:18 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A85C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 00:54:17 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c16so18526643ils.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 00:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GQLxqT4ni03eXSRPLJWqfG5xqozbiQOJVTEAEw4Fwy4=;
        b=hSaUOWGI+WEmDxX/T3i7CGQ9FB6urwnshGStOCSUu2SmfQonrsHYlTgdQBbkL5r3Zc
         235A+7Wb4PvOk/+dS5VyS2IB8xxFYlTo0ZLyUDe3ZRkVr0MYpe8WOY5MWjU/WIboSDei
         Z6IcSNUbw317Sbtx9eZYo/Dz6uScHhwcKXr0x62IAFLLW/xcF4d8w7d7/A19hl58M+PH
         8oyP+J9loE+FOAqzvhTMoKwPZY8iF0YbYmuSBc5V0oETi/JBkWJij6vs4oL2QBe9f2eY
         ribLVcU+6dz3L3pJh9p+Rd6dLE3SZoyaG6gpqNGDAXPg9P6QOy9fj3IXp5gRrgl7Cb/n
         KogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GQLxqT4ni03eXSRPLJWqfG5xqozbiQOJVTEAEw4Fwy4=;
        b=FlJKQ1NIbq8LVFllIc4AgpGYF1hK69SZFuoel3qso3LUpyOCrw8izhlkIJuOKRRD3w
         WaU0XYxZTjwvUF2LntOJtm4Ihhrql6GDgDmozML3vxseimfpuX/IYTBPT34qVvJgka61
         EbwBMltQVGawi8KhqBNuhcqQ834QXwDlQRd3Q9DdusWJF9RgXzqbrsNO7eBcZ4iMjQGW
         5ozyfdTQk+vwW/AhkholFwX+C6+Vu3fWn7oxcTxnBxaPEwH6m14yhlYOUiaTNL4fypq5
         LGJxSJQBtsJfeYsYR3LfbEbYRXMdB0mk/Oq+ussrCB3vrKR7ylWMAp712gnaJEX/t1fT
         2Wiw==
X-Gm-Message-State: AOAM530OYltAQyuEIBPNcrwapVASeTcRIpE5PFHokhIPTAdnRQyoaq52
        He5Hc/sg2sf/q48oxRJ8gzteTMZgDjq8C/Z44v8=
X-Google-Smtp-Source: ABdhPJwv61TeQ6BHwfjaACxfXRuJH4GchXif5JWWPN+CXKui0ri/OkxuqfOvaK3WhH3jy4MVrO8q3SkHQYJDZpITGd8=
X-Received: by 2002:a92:da10:: with SMTP id z16mr16256239ilm.293.1596441256892;
 Mon, 03 Aug 2020 00:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200704102535.189647-1-peron.clem@gmail.com> <20200704102535.189647-14-peron.clem@gmail.com>
 <20200704121301.jfd3m3jnlghmddg4@gilmour.lan> <CAJiuCceMS__bNVO54E2OYnqnaOAL9pGkxRo4XAABiyqagaEtmw@mail.gmail.com>
In-Reply-To: <CAJiuCceMS__bNVO54E2OYnqnaOAL9pGkxRo4XAABiyqagaEtmw@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 3 Aug 2020 09:54:05 +0200
Message-ID: <CAJiuCce58Gaxf_Qg2cnMwvOgUqYU__eKb3MDX1Fe_+47htg2bA@mail.gmail.com>
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
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime and All,

On Sat, 4 Jul 2020 at 16:56, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>=
 wrote:
>
> Hi Maxime,
>
> On Sat, 4 Jul 2020 at 14:13, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Hi,
> >
> > On Sat, Jul 04, 2020 at 12:25:34PM +0200, Cl=C3=A9ment P=C3=A9ron wrote=
:
> > > Add an Operating Performance Points table for the GPU to
> > > enable Dynamic Voltage & Frequency Scaling on the H6.
> > >
> > > The voltage range is set with minival voltage set to the target
> > > and the maximal voltage set to 1.2V. This allow DVFS framework to
> > > work properly on board with fixed regulator.
> > >
> > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> >
> > That patch seems reasonable, why shouldn't we merge it?
>
> I didn't test it a lot and last time I did, some frequencies looked unsta=
ble.
> https://lore.kernel.org/patchwork/cover/1239739/
>
> This series adds regulator support to Panfrost devfreq, I will send a
> new one if DVFS on the H6 GPU is stable.
>
> I got this running glmark2 last time
> # glmark2-es2-drm
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>     glmark2 2017.07
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>     OpenGL Information
>     GL_VENDOR:     Panfrost
>     GL_RENDERER:   Mali T720 (Panfrost)
>     GL_VERSION:    OpenGL ES 2.0 Mesa 20.0.5
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> [   93.550063] panfrost 1800000.gpu: GPU Fault 0x00000088 (UNKNOWN) at
> 0x0000000080117100
> [   94.045401] panfrost 1800000.gpu: gpu sched timeout, js=3D0,
> config=3D0x3700, status=3D0x8, head=3D0x21d6c00, tail=3D0x21d6c00,
> sched_job=3D00000000e3c2132f
>
> [  328.871070] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
> 0x0000000000000000
> [  328.871070] Reason: TODO
> [  328.871070] raw fault status: 0xAA0003C2
> [  328.871070] decoded fault status: SLAVE FAULT
> [  328.871070] exception type 0xC2: TRANSLATION_FAULT_LEVEL2
> [  328.871070] access type 0x3: WRITE
> [  328.871070] source id 0xAA00
> [  329.373327] panfrost 1800000.gpu: gpu sched timeout, js=3D1,
> config=3D0x3700, status=3D0x8, head=3D0xa1a4900, tail=3D0xa1a4900,
> sched_job=3D000000007ac31097
> [  329.386527] panfrost 1800000.gpu: js fault, js=3D0,
> status=3DDATA_INVALID_FAULT, head=3D0xa1a4c00, tail=3D0xa1a4c00
> [  329.396293] panfrost 1800000.gpu: gpu sched timeout, js=3D0,
> config=3D0x3700, status=3D0x58, head=3D0xa1a4c00, tail=3D0xa1a4c00,
> sched_job=3D0000000004c90381
> [  329.411521] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
> 0x0000000000000000
> [  329.411521] Reason: TODO
> [  329.411521] raw fault status: 0xAA0003C2
> [  329.411521] decoded fault status: SLAVE FAULT
> [  329.411521] exception type 0xC2: TRANSLATION_FAULT_LEVEL2
> [  329.411521] access type 0x3: WRITE
> [  329.411521] source id 0xAA00

Just to keep a track of this issue.

Piotr Oniszczuk give more test and seems to be software related:
https://www.spinics.net/lists/dri-devel/msg264279.html

Ondrej gave a great explanation about a possible origin of this issue:
https://freenode.irclog.whitequark.org/linux-sunxi/2020-07-11

20:12 <megi> looks like gpu pll on H6 is NKMP clock, and those are
implemented in such a way in mainline that they are prone to
overshooting the frequency during output divider reduction
20:13 <megi> so disabling P divider may help
20:13 <megi> or fixing the dividers
20:14 <megi> and just allowing N to change
20:22 <megi> hmm, I haven't looked at this for quite some time, but H6
BSP way of setting PLL factors actually makes the most sense out of
everything I've seen/tested so far
20:23 <megi> it waits for lock not after setting NK factors, but after
reducing the M factor (pre-divider)
20:24 <megi> I might as well re-run my CPU PLL tester with this
algorithm, to see if it fixes the lockups
20:26 <megi> it makes sense to wait for PLL to stabilize "after"
changing all the factors that actually affect the VCO, and not just
some of them
20:27 <megi> warpme_: ^
20:28 <megi> it may be the same thing that plagues the CPU PLL rate
changes at runtime

Regards,
Clement

>
> Regards,
> Clement
>
> >
> > > ---
> > >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 80 ++++++++++++++++++=
++
> > >  1 file changed, 80 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm6=
4/boot/dts/allwinner/sun50i-h6.dtsi
> > > index 8f514a2169aa..a69f9e09a829 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > @@ -174,6 +174,7 @@ gpu: gpu@1800000 {
> > >                       clocks =3D <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
> > >                       clock-names =3D "core", "bus";
> > >                       resets =3D <&ccu RST_BUS_GPU>;
> > > +                     operating-points-v2 =3D <&gpu_opp_table>;
> > >                       #cooling-cells =3D <2>;
> > >                       status =3D "disabled";
> > >               };
> > > @@ -1036,4 +1037,83 @@ map0 {
> > >                       };
> > >               };
> > >       };
> > > +
> > > +     gpu_opp_table: gpu-opp-table {
> > > +             compatible =3D "operating-points-v2";
> > > +
> > > +             opp@216000000 {
> > > +                     opp-hz =3D /bits/ 64 <216000000>;
> > > +                     opp-microvolt =3D <810000 810000 1200000>;
> > > +             };
> >
> > All those nodes will create DTC warnings though.
> >
> > Maxime
