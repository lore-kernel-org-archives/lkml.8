Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6687DC2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B7E206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn+gVHDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgDFI7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 04:59:00 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45468 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgDFI66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 04:58:58 -0400
Received: by mail-io1-f68.google.com with SMTP id y14so14883882iol.12;
        Mon, 06 Apr 2020 01:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UPqDv8CeYx1N0Rja5HT63eK8rvmvj33Sn4Tfxap3WTc=;
        b=Bn+gVHDErL8xA6WvQFL200iyfcEdk15R4pwg/hQTYqbdp4UqOFrBDKJ5VSmq9u6+Rb
         /DeDXlLbydHymHVCAbiurUQlc/aa5I1KkdZN8F1w/r27hlxr8Y+XXn8YY1WNgUt6aKKH
         3TI0b2RGGTqLFpZcVy1vBm006yak8uN/7KFeq1Qx6OMqw5h13Y7pNa1lrTPq1YvGMCCJ
         mqlycyqCwA1qrYb6bqKQeD7+4BE1bpPfWGBOKFb5QI1zlOxGGOxxkm1jc26mL2QWWFDU
         92ng5DI/gdutvOEEHZdUwjA3nBbiLRPEUZYO2k7spgJmJOr8alCTYOeGY0aVi3EdYyXP
         pIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UPqDv8CeYx1N0Rja5HT63eK8rvmvj33Sn4Tfxap3WTc=;
        b=BDBkshVZ1g98rpR+KbcOGYg3eCwlq8APS6mT/u6HRnU6/yGqjlESsnbFRwrqRa3nVL
         cSJE6aBqPvpVlvcgOry6fs4p8kyIy31uEfzrzoFbRj07+LyIRIe2ORrR9OGQRpKZosh6
         5zuYhA6Q6SPvvL4Rjhh3wfye5XByh0OoQTmtKdGGgdCkgjynBAyILtsbx6AiBr86mtpo
         TU9vPqX5GmayiAtZLYuTiPAWnJ4JXQGgmf7re0uDp05mJL9HvMnarKjrommRe1jP0KT7
         HNHXQ/oXzOivjt2/UUhh+f3JSyAnjbZme9gaVuMOr6h05W9lJNGx9sgae51jUsf09vJl
         a1RA==
X-Gm-Message-State: AGi0PuZN6qZb7kKoSl2r6quw9dEpzzGLbVKjzwMLzRk9VtqbBTWICbRf
        wBUzuopKfKJpYTK0hGOqro4XljGQdB5+55W0u58=
X-Google-Smtp-Source: APiQypKzF6+d+kvaHfqUmiZUENYlrMoUP8gCIkosLWjyIQWyWGDfhXe0uF0V+iawQs6++52+4Lv1JVXLmh6NX2xx8IY=
X-Received: by 2002:a05:6638:53:: with SMTP id a19mr19157348jap.144.1586163535745;
 Mon, 06 Apr 2020 01:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200405173601.24331-1-peron.clem@gmail.com> <20200405173601.24331-5-peron.clem@gmail.com>
 <20200406081601.3y6fwb7czr2xdkep@gilmour.lan>
In-Reply-To: <20200406081601.3y6fwb7czr2xdkep@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 6 Apr 2020 10:58:44 +0200
Message-ID: <CAJiuCceK40JVf7SDm5s-JAL1g_bMPuuhF7cc-yCSN7epUV7V=w@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] arm64: dts: allwinner: h6: Add GPU Operating
 Performance Points table
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Mon, 6 Apr 2020 at 10:16, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Sun, Apr 05, 2020 at 07:35:58PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Add an Operating Performance Points table for the GPU to
> > enable Dynamic Voltage & Frequency Scaling on the H6.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  .../boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi | 74 +++++++++++++++++++
> >  1 file changed, 74 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dts=
i
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi b/arc=
h/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
> > new file mode 100644
> > index 000000000000..4a1814844fe0
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
> > @@ -0,0 +1,74 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +// Copyright (C) 2020 Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > +
> > +/ {
> > +     gpu_opp_table: opp_table1 {
>
> A node name is supposed to be a generic description, so what about
> using gpu-opp-table (and cpu-opp-table) instead?
>
> > +             compatible =3D "operating-points-v2";
> > +
> > +             opp@756000000 {
> > +                     opp-hz =3D /bits/ 64 <756000000>;
> > +                     opp-microvolt =3D <1040000>;
> > +             };
> > +             opp@624000000 {
> > +                     opp-hz =3D /bits/ 64 <624000000>;
> > +                     opp-microvolt =3D <950000>;
> > +             };
>
> Ordering by ascending frequency would be great here.
Indeed will fix it.

>
> Also, why did you need to create a new DTSI for it? Is there some
> downside to enabling it for all the users?

I didn't want to enable it for all boards as I can't test them and not all =
board
have a dedicated regulator for VDD-GPU.
Hence my question in the cover,
But with Jernej =C5=A0krabec test on Tanix TX6 I think it can be safely
enable on all boards.

Regards,
Clement

>
> Maxime
