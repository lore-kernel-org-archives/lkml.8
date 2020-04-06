Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D0DC2BA1B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04E3206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DviDx6kc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgDFSDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:03:47 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37745 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDFSDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:03:47 -0400
Received: by mail-il1-f196.google.com with SMTP id a6so387076ilr.4;
        Mon, 06 Apr 2020 11:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3LY5VeGYnWEgSR/Pz3b1gospRiVVwkBxzjMdAq8KEH0=;
        b=DviDx6kcod6zhCYaVgHB68jWRCIHmauXkn0qel17bCPlzhf3b069PYzbAfgJV4kPpQ
         EW3e0/VaO2c59Rq4n2C378XEL324cIV80rb3hlugm+X55/5FFpKWg+esg/JTC73dNGz7
         PAcKnnbx1dOCBhI+vC24KOH+JJBhBSiwtQaH5cVm5RkkKf4NyDQ48U0Y1lKnW1B5lrfb
         xyZzR5cUIJ5n/v2wUajvD2ZiwGDSwWlASB1gyhL9i+qQm1OOBKKLHHOC0SxvPAgjr0G2
         XwJmlvwdryhWyBmFPexZszn1zLi1sLH7YAEyVn5Luqhyd5dBTveUMVg+vPt1R5zqR49k
         6gjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3LY5VeGYnWEgSR/Pz3b1gospRiVVwkBxzjMdAq8KEH0=;
        b=B3FFlyWDLS6Jd0qN3yEJZZKasMPa4+xikqCsr8ZLRVC08zaLQgBqefnDzNb1/0rPNf
         Vq6qtICkBGHTP5SIJWiVu2JFUZXh/KP3gXB3ptd62y7bkebJXIJvDv7CaSRWFv/8EDZp
         E7cirNreWp6Vx0ZhBzS6nRwuQpvDo2HfJH7V5ObN0D8PpcfGTrt0FHFsSeahYGIGUGCy
         a6ozeN2EXQQcxvLzp2Q4knZs++ShZw28YSV+qPF/6cu7/RYIfGXsCTcJAPDYJtb4TFou
         CBhdnDShWH8JY/9j93pj+v1pBTNKr49K18wxYrxvB3E0h3Gf/LeZafDSsHpmD0pZShBS
         bFJQ==
X-Gm-Message-State: AGi0PuYwM5Vkq78VvgRPWkSze4igItIzkS0IVaOuu5brXV69rFq4fiom
        tnDuJtzhC+Et+w2q+KgKjp+yCKlrbER/WimyumgDNFEyL1o=
X-Google-Smtp-Source: APiQypLVNaXxCOgsWF52COqW2pQQQ3sR2dVnqs5kVI6zorVvktZclg6R2CBTYUFEywvnTHs3vVkCUYJZ0wrUdjKBx7I=
X-Received: by 2002:a05:6e02:c8f:: with SMTP id b15mr504343ile.35.1586196225471;
 Mon, 06 Apr 2020 11:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200405173601.24331-1-peron.clem@gmail.com> <20200405173601.24331-4-peron.clem@gmail.com>
 <20200406081412.ubdogkjknlofynei@gilmour.lan>
In-Reply-To: <20200406081412.ubdogkjknlofynei@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 6 Apr 2020 20:03:34 +0200
Message-ID: <CAJiuCcdTQHGhZ=7Z_Du-zcZ_OWdGO1iEpYOBD4z=eNDYzMA5tg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] arm64: dts: allwinner: h6: Add CPU Operating
 Performance Points table
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Ondrej Jirman <megous@megous.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 6 Apr 2020 at 10:14, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Sun, Apr 05, 2020 at 07:35:57PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Ondrej Jirman <megous@megous.com>
> >
> > Add an Operating Performance Points table for the CPU cores to
> > enable Dynamic Voltage & Frequency Scaling on the H6.
> >
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  .../boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi | 121 ++++++++++++++++++
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |   4 +
> >  2 files changed, 125 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dts=
i
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi b/arc=
h/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi
> > new file mode 100644
> > index 000000000000..8c1e413c6af9
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi
> > @@ -0,0 +1,121 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +// Copyright (C) 2020 Ondrej Jirman <megous@megous.com>
> > +// Copyright (C) 2020 Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > +
> > +/ {
> > +     cpu0_opp_table: opp_table0 {
>
> Node names shouldn't have an underscore, this will trigger a DTC
> warning.
>
> > +             compatible =3D "allwinner,sun50i-h6-operating-points";
> > +             nvmem-cells =3D <&speedbin_efuse>;
> > +             opp-shared;
> > +
> > +             opp@480000000 {
> > +                     clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> > +                     opp-hz =3D /bits/ 64 <480000000>;
> > +
> > +                     opp-microvolt-speed0 =3D <880000>;
> > +                     opp-microvolt-speed1 =3D <820000>;
> > +                     opp-microvolt-speed2 =3D <820000>;
> > +             };
>
> And similarly, if you have a unit-address (the part after @), you
> should have a matching reg property. You should use a dash instead.
>
> > +             opp@720000000 {
> > +                     clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> > +                     opp-hz =3D /bits/ 64 <720000000>;
> > +
> > +                     opp-microvolt-speed0 =3D <880000>;
> > +                     opp-microvolt-speed1 =3D <820000>;
> > +                     opp-microvolt-speed2 =3D <820000>;
> > +             };
> > +
> > +             opp@816000000 {
> > +                     clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> > +                     opp-hz =3D /bits/ 64 <816000000>;
> > +
> > +                     opp-microvolt-speed0 =3D <880000>;
> > +                     opp-microvolt-speed1 =3D <820000>;
> > +                     opp-microvolt-speed2 =3D <820000>;
> > +             };
> > +
> > +             opp@888000000 {
> > +                     clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> > +                     opp-hz =3D /bits/ 64 <888000000>;
> > +
> > +                     opp-microvolt-speed0 =3D <880000>;
> > +                     opp-microvolt-speed1 =3D <820000>;
> > +                     opp-microvolt-speed2 =3D <820000>;
> > +             };
> > +
> > +             opp@1080000000 {
> > +                     clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> > +                     opp-hz =3D /bits/ 64 <1080000000>;
> > +
> > +                     opp-microvolt-speed0 =3D <940000>;
> > +                     opp-microvolt-speed1 =3D <880000>;
> > +                     opp-microvolt-speed2 =3D <880000>;
> > +             };
> > +
> > +             opp@1320000000 {
> > +                     clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> > +                     opp-hz =3D /bits/ 64 <1320000000>;
> > +
> > +                     opp-microvolt-speed0 =3D <1000000>;
> > +                     opp-microvolt-speed1 =3D <940000>;
> > +                     opp-microvolt-speed2 =3D <940000>;
> > +             };
> > +
> > +             opp@1488000000 {
> > +                     clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> > +                     opp-hz =3D /bits/ 64 <1488000000>;
> > +
> > +                     opp-microvolt-speed0 =3D <1060000>;
> > +                     opp-microvolt-speed1 =3D <1000000>;
> > +                     opp-microvolt-speed2 =3D <1000000>;
> > +             };
> > +
> > +             opp@1608000000 {
> > +                     clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> > +                     opp-hz =3D /bits/ 64 <1608000000>;
> > +
> > +                     opp-microvolt-speed0 =3D <1090000>;
> > +                     opp-microvolt-speed1 =3D <1030000>;
> > +                     opp-microvolt-speed2 =3D <1030000>;
> > +             };
> > +
> > +             opp@1704000000 {
> > +                     clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> > +                     opp-hz =3D /bits/ 64 <1704000000>;
> > +
> > +                     opp-microvolt-speed0 =3D <1120000>;
> > +                     opp-microvolt-speed1 =3D <1060000>;
> > +                     opp-microvolt-speed2 =3D <1060000>;
> > +             };
> > +
> > +             opp@1800000000 {
> > +                     clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> > +                     opp-hz =3D /bits/ 64 <1800000000>;
> > +
> > +                     opp-microvolt-speed0 =3D <1160000>;
> > +                     opp-microvolt-speed1 =3D <1100000>;
> > +                     opp-microvolt-speed2 =3D <1100000>;
> > +             };
> > +     };
> > +};
> > +
> > +&cpu0 {
> > +     operating-points-v2 =3D <&cpu0_opp_table>;
> > +     #cooling-cells =3D <2>;
> > +};
> > +
> > +&cpu1 {
> > +     operating-points-v2 =3D <&cpu0_opp_table>;
> > +     #cooling-cells =3D <2>;
> > +};
> > +
> > +&cpu2 {
> > +     operating-points-v2 =3D <&cpu0_opp_table>;
> > +     #cooling-cells =3D <2>;
> > +};
> > +
> > +&cpu3 {
> > +     operating-points-v2 =3D <&cpu0_opp_table>;
> > +     #cooling-cells =3D <2>;
> > +};
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/=
boot/dts/allwinner/sun50i-h6.dtsi
> > index e0dd0757be0b..6b7af858614a 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > @@ -253,6 +253,10 @@
> >                       #address-cells =3D <1>;
> >                       #size-cells =3D <1>;
> >
> > +                     speedbin_efuse: speed@1c {
> > +                             reg =3D <0x1c 0x4>;
> > +                     };
> > +
>
> You should order this by address, so after the THS calibration. Also,
> using a less generic node name than "speed" would be great. What about
> soc-bin ?

Indeed it's too generic.
I will keep coherency with i.MX8 and use "cpu_speed_grade"

Thanks for the review,
Clement

>
> Maxime
