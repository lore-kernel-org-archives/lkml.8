Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1BEC83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 548982063A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2Zm63dU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgD1QtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbgD1QtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:49:24 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B128C03C1AB;
        Tue, 28 Apr 2020 09:49:22 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id y26so13849289ioj.2;
        Tue, 28 Apr 2020 09:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JS/Zae/slzX90tyUKT8r1SH4RG9V4TT4VPt705M4mKg=;
        b=V2Zm63dUiV3TTv4NusICrNtW9C+4hSQl0AvbqXXwN9RUmiI2qh/MP3EwePMMaD6a3H
         kFLvQEXGLfR1WPfk4I0a9Y2RxpET6/nFUP4Ft4xTMJcAII5++HFxk1cCU3ABcP0WGCBv
         nndZMG95rXNmP//mN3kFoluvP77qYaq7X9cyIGn8PEzpTldV/jmN3iYRV7+m55+o0q8V
         q07b1GUUU5enXKzG3nfwrzvw+qOQ73O7dRelONAy1hj+91aCmG8VWR4zYfgXV/fjDWx6
         sMJi9jhhaPpWcMWsBcS3Gue2AI67aQf4styimAP23+ASIOpa5fzTd70raNY04b0R9qT2
         ibjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JS/Zae/slzX90tyUKT8r1SH4RG9V4TT4VPt705M4mKg=;
        b=YMffzJqyuS5od+Xk/+ug7MT+d/vZS9Qn1tgu6R4V3EziTyySu0AsPu/nQpXleo6T0d
         jZdvC5tVDwya41rTKASyZGrdiqfkVgLpePpM5YbUn+iSgriDGy2Z/8Dj2DtnjEdNv7AA
         D/CR47iK5JvL0etdUGguYICB9M5uwom3aHoZ6v5xH9UM5Hu4KvfvoaQ6fM83c5EOj3iZ
         9edEcq5t3rDjTUAyThGfhAd1gTc7GXthY7KMa5pm46yY3NNTGy3X+P6kqr8XflKVRNeN
         iK0nAI1WJ+nk0f40BPPDIDRbhbG1xMB1+ZupWvsEMJYiPTi9KYScYbVBRIs1UO3BAoWG
         MXpg==
X-Gm-Message-State: AGi0Pua8zeMu+4fxq2xt6s3GDsR6ttwzCON1P42OQf/UUD+niZNPtXdJ
        Sk4DHQs2Oh0vc9VEV6lc+20l/kUkz3pzUC7ZOFM=
X-Google-Smtp-Source: APiQypKVVDj4+SrA1Wh3npapyS8is6Ny7tWN7gGRKKd2wbPbADnpfEAZaApyWXCE8Ach3PRxG824Bn1lotSb4OuXfiE=
X-Received: by 2002:a5d:9494:: with SMTP id v20mr26961821ioj.101.1588092561434;
 Tue, 28 Apr 2020 09:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200426120442.11560-1-peron.clem@gmail.com> <20200426120442.11560-5-peron.clem@gmail.com>
 <20200428080020.35qcuylwq2ylmubu@gilmour.lan> <CAJiuCcc2LQ4L36KSfO8iLVFBUO6k+zsZFX+_Ovm_10PoWO4AsA@mail.gmail.com>
 <20200428160417.6q5oab2guaumhhwi@gilmour.lan>
In-Reply-To: <20200428160417.6q5oab2guaumhhwi@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 28 Apr 2020 18:49:10 +0200
Message-ID: <CAJiuCccFFUJJzXwygLQbDK4fGJ61p72Hv7vj3WVP-=z=J1Yj0Q@mail.gmail.com>
Subject: Audio sound card name [was [PATCH 4/7] arm64: dts: allwinner: a64:
 Add HDMI audio]
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Rob,

On Tue, 28 Apr 2020 at 18:04, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Tue, Apr 28, 2020 at 10:54:00AM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Maxime,
> >
> > On Tue, 28 Apr 2020 at 10:00, Maxime Ripard <maxime@cerno.tech> wrote:
> > >
> > > On Sun, Apr 26, 2020 at 02:04:39PM +0200, Cl=C3=A9ment P=C3=A9ron wro=
te:
> > > > From: Marcus Cooper <codekipper@gmail.com>
> > > >
> > > > Add a simple-soundcard to link audio between HDMI and I2S.
> > > >
> > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > > ---
> > > >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 21 +++++++++++++++=
++++
> > > >  1 file changed, 21 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/a=
rm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > > index e56e1e3d4b73..08ab6b5e72a5 100644
> > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > > @@ -102,6 +102,25 @@
> > > >               status =3D "disabled";
> > > >       };
> > > >
> > > > +     hdmi_sound: hdmi-sound {
> > > > +             compatible =3D "simple-audio-card";
> > > > +             simple-audio-card,format =3D "i2s";
> > > > +             simple-audio-card,name =3D "allwinner,hdmi";
> > >
> > > I'm not sure what the usual card name should be like though. I would =
assume that
> > > this should be something specific enough so that you're able to diffe=
rentiate
> > > between boards / SoC so that the userspace can choose a different con=
figuration
> > > based on it?
> >
> > I really don't know what we should use here,
> > I just have a look at other SoC:
> > rk3328: "HDMI"
> > rk3399: "hdmi-sound"
> > r8a774c0-cat874: "CAT874 HDMI sound"
> >
> > But maybe it's time to introduce proper name:
> > What about :
> > pat
> > sun50i-h6-hdmi
>
> It's pretty much what we've been using for the other sound cards we have,=
 so it
> makes sense to me.

I have a question regarding the simple-audio-card,name.
In this patch, I would like to introduce a simple-audio-card for the
Allwinner A64 HDMI.

What should be the preferred name for this sound card?
"sun50i-a64-hdmi" ? "allwinner, sun50i-a64-hdmi" ?

Thanks for your tips,
Clement

>
> > How should we handle this with h3 / h5 ?
> > settings the simple-audio-card,name in each SoC dts?
> > Or using sun50i-h3-hdmi as they are both identical?
>
> Yeah, we can do the latter
>
> Maxime
