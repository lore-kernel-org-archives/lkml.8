Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2019BC2BA1B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDD420672
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMTvMFo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgDEOfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 10:35:32 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:35740 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgDEOfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 10:35:31 -0400
Received: by mail-il1-f193.google.com with SMTP id 7so12208194ill.2;
        Sun, 05 Apr 2020 07:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=eIa5OXN+GU8882Nm85v7a3u1PKrSDsLkq30H7Ge5ZMI=;
        b=kMTvMFo2igFa3Yfngiw4vT9uZJyOGd+GKOkHy+dWFvRpCnjD7ldQWQBhCtVC8Qt8mz
         hGiHQ0H1HvfZ853MGHR/f5rSJteH4MUrzvwa9j/TBkUa9Acp/WD9573FcKBoHABhLpuz
         07IY8nIsQ/VvXEYcLISomI5GvupfPsyUJKrbWe9pVw+Idj1Uwgcf+GYVw658emhdcGD1
         Ohqdodso04v7q44mIZ3JfSzTgd7OMN24ua3gpVn0vcKKhYlCKh2ciaegVwm/iIN+jVj9
         /3ugE/Bg/CraZxJRrN2qTRzD09s2Pm8l/VAXoMiLdSyMMgyinUHX5L8CB2ESuzuTGFW8
         xSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=eIa5OXN+GU8882Nm85v7a3u1PKrSDsLkq30H7Ge5ZMI=;
        b=l47VN1rjEsGbD3M7RFoBcQgkyaDKYSkMkHsGTyzakydqGJU8ED+jTA/yN+qe3CAuuT
         CBCZwhkC4wgsI/n1tq//9dnuWAUiWRSfOw9Tr8NrQYFlT03XJaDgQv8v5AAo/NrI3Uez
         uAROAGx/fbN7rNFq9R0fzNVoVflSvR4b/iSEDI5fQc2Y715K2sULofagCE8iNkK4RNxC
         PDUQKFFlDfAp4PVJwW/Q5TQok7FwqbOfO72sEK0PP8u3i+VCGM6eeAzhN+CzgfHSPo8L
         E28pSRfYRpJFu+77qFmqpyX2MGZF4Pp33FMZDpbC71/wg5kRd0yrTseQTIvoAB3Ql1E5
         QaOQ==
X-Gm-Message-State: AGi0PubfMvZVCj5lJDYcfFQ7r6O9fEIIPJ5uXWvTcQOlmEwdCyy45+do
        DI1YHs9b6mJWFsyaADty0KHLxSkPNBZ9oq5pKnY=
X-Google-Smtp-Source: APiQypJCVYiZqX3tf9uVCh7hRBUtTx4SZ68jWnxQH/O0xJlkACZXgXzhvPqBd+IZBJ6CicEobh+rvmsFjxfN/PLl6b8=
X-Received: by 2002:a92:5ccd:: with SMTP id d74mr16131414ilg.59.1586097330558;
 Sun, 05 Apr 2020 07:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200405104913.22806-1-peron.clem@gmail.com> <20200405104913.22806-4-peron.clem@gmail.com>
 <20200405112409.gl6kn7cjakwludf6@core.my.home>
In-Reply-To: <20200405112409.gl6kn7cjakwludf6@core.my.home>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 5 Apr 2020 16:35:19 +0200
Message-ID: <CAJiuCceZ=MGWqv4LF9CJpJyGmgq+uTirxXAFoACiqt0Mz76A-g@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 3/7] arm64: dts: allwinner: h6: set thermal
 polling time
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
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

Hi Ond=C5=99ej,

On Sun, 5 Apr 2020 at 13:24, Ond=C5=99ej Jirman <megous@megous.com> wrote:
>
> Hello,
>
> On Sun, Apr 05, 2020 at 12:49:09PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Add reasonable thermal polling time for Allwinner H6.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/=
boot/dts/allwinner/sun50i-h6.dtsi
> > index d4d3963705f5..c3e4f09f60ce 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > @@ -905,8 +905,8 @@
> >
> >       thermal-zones {
> >               cpu-thermal {
> > -                     polling-delay-passive =3D <0>;
> > -                     polling-delay =3D <0>;
> > +                     polling-delay-passive =3D <100>;
> > +                     polling-delay =3D <1000>;
> >                       thermal-sensors =3D <&ths 0>;
>
> This is not necessary, and will not do anything useful, since the driver
> uses interrupts to update the thermal zone's temperature. Please keep the
> values at 0.
>
> With your settings the thermal zone would just add a polling timer in add=
ition
> to being updated every 250ms via THS interrupt. The real thermal measurem=
ents
> are available every 250ms anyway, so setting a smaller period here will n=
ot do
> anything useful, and 1s period will not lead to slower updates either.
>
> Values of 0 mean tell the thermal zone to rely on thermal driver to updat=
e
> the thermal zone by itself (via interrupt) and to not poll.

Thanks for the explanations,
I will drop this patch.

Regards,
Cl=C3=A9ment
>
> regards,
>         o.
>
> >                       trips {
> > @@ -935,8 +935,8 @@
> >               };
> >
> >               gpu-thermal {
> > -                     polling-delay-passive =3D <0>;
> > -                     polling-delay =3D <0>;
> > +                     polling-delay-passive =3D <100>;
> > +                     polling-delay =3D <1000>;
> >                       thermal-sensors =3D <&ths 1>;
> >               };
> >       };
> > --
> > 2.20.1
> >
> > --
> > You received this message because you are subscribed to the Google Grou=
ps "linux-sunxi" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to linux-sunxi+unsubscribe@googlegroups.com.
> > To view this discussion on the web, visit https://groups.google.com/d/m=
sgid/linux-sunxi/20200405104913.22806-4-peron.clem%40gmail.com.
