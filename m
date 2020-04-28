Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A248C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE1EF206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsFvHtQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgD1IyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726346AbgD1IyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:54:12 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA301C03C1A9;
        Tue, 28 Apr 2020 01:54:12 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id b18so19512326ilf.2;
        Tue, 28 Apr 2020 01:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dDgulWnHGZo56l/rwtjNPISMYmw8h8PKUdGgHUf/qbQ=;
        b=bsFvHtQgLA9U5xzZknhx5MWq1lav+iBhrlYLLy/RFrIxJCCZYXtPdiI9CYGPsOpUb4
         PbUMU8veALBn6Ielw6gMIuf1TIhd+jknAnEWCaC+XToSiri5IjsszZMqLqnfSZxLFzgI
         FOg+4Rn9cs6ReBn8ouy2wMpXsv0fr7I6z6ppQCOidhy3SVghFEXyjZMh2gJyeNSCpXdi
         g/9/6GDL4+DD6aLVJr82+aCYgGlY3ewCkCeOA3qhN8HGEPrQkDAsp+xEguvzAzqjBVzr
         48nhVLmXLA6gqeccxuLl+oSLxT6fxlwaXxMCwsZodpX/bN/8W+tkxYVFuSU0WBBIu7hn
         WeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dDgulWnHGZo56l/rwtjNPISMYmw8h8PKUdGgHUf/qbQ=;
        b=ZNJeTdY6xpQDihxHXf7SHlhZaaV7stw4OLB79rM0Xf8c7xJC+LIVVw5+v14WbeOtFQ
         RAQoyNa/kDFojwcRHEPCzaLUvfzZn4hO3giUtXz4qurJKYNqVJOXG3oKtXvnBVPVIhCx
         lJRdr28CYPafThHSxXIC1ZH1EDc2oeUJdwczAZOEwFS3fnI8pdNl10mrk0isWC/HtCy3
         DrO3tDzAezjEZaKw31wy39KFxbKqrQHOkhCYw45QoY3wtz8yqE2M2HV1juuTONSoC5VK
         cWgl3cvSkQwUc00Kebrhtxli+byW2JK64bZt7C6/DgvYPPd7DPQCK6Vy0oUjZJwvFV4l
         H9Ag==
X-Gm-Message-State: AGi0PuY9bc+HuvV1EFeraA7ZObUQBFPQmxPI48nbijENbQILU/hoMWJ+
        1zZ701oUSe8dbMxdqSpbvD2NOMU1t/7Rt4/zi78=
X-Google-Smtp-Source: APiQypLjn+quin05VpI7eccg9aPBvq4rkesUHFhJvzeuZEXRWkfxI9E/S60HRrWJ9MxsyWnLP/SFJNPDcKrdHUSAbTY=
X-Received: by 2002:a92:d151:: with SMTP id t17mr3585764ilg.35.1588064051274;
 Tue, 28 Apr 2020 01:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200426120442.11560-1-peron.clem@gmail.com> <20200426120442.11560-5-peron.clem@gmail.com>
 <20200428080020.35qcuylwq2ylmubu@gilmour.lan>
In-Reply-To: <20200428080020.35qcuylwq2ylmubu@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 28 Apr 2020 10:54:00 +0200
Message-ID: <CAJiuCcc2LQ4L36KSfO8iLVFBUO6k+zsZFX+_Ovm_10PoWO4AsA@mail.gmail.com>
Subject: Re: [PATCH 4/7] arm64: dts: allwinner: a64: Add HDMI audio
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
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

Hi Maxime,

On Tue, 28 Apr 2020 at 10:00, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Sun, Apr 26, 2020 at 02:04:39PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > Add a simple-soundcard to link audio between HDMI and I2S.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 21 +++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64=
/boot/dts/allwinner/sun50i-a64.dtsi
> > index e56e1e3d4b73..08ab6b5e72a5 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > @@ -102,6 +102,25 @@
> >               status =3D "disabled";
> >       };
> >
> > +     hdmi_sound: hdmi-sound {
> > +             compatible =3D "simple-audio-card";
> > +             simple-audio-card,format =3D "i2s";
> > +             simple-audio-card,name =3D "allwinner,hdmi";
>
> I'm not sure what the usual card name should be like though. I would assu=
me that
> this should be something specific enough so that you're able to different=
iate
> between boards / SoC so that the userspace can choose a different configu=
ration
> based on it?

I really don't know what we should use here,
I just have a look at other SoC:
rk3328: "HDMI"
rk3399: "hdmi-sound"
r8a774c0-cat874: "CAT874 HDMI sound"

But maybe it's time to introduce proper name:
What about :
sun50i-a64-hdmi
sun50i-h6-hdmi
How should we handle this with h3 / h5 ?
settings the simple-audio-card,name in each SoC dts?
Or using sun50i-h3-hdmi as they are both identical?

Regards,
Clement


>
> If so, it's really too generic.
>
> Maxime
