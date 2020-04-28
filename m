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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB84FC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA9CD206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwnL/1+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgD1Ogm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727845AbgD1Ogm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:36:42 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097B0C03C1AB;
        Tue, 28 Apr 2020 07:36:42 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k6so23087033iob.3;
        Tue, 28 Apr 2020 07:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VPA9Kxr39ERnqwIoc2UJSAp5IoBA3dbxr68iA+juyP0=;
        b=FwnL/1+AgacLVrzfCLrLz36o10+EmBtDT+Vx71m9oQ+I8Ep9EruaY8kVJkEYTxwWXr
         9mOoV34Me4r25FtQL4YIVI1WVIVyNTGJK3zSm5wkSCPHE+jnDdwe8NCx9Zz/Iyqozj4x
         Ru/LBFO5YLFEmUqcxt3LPB/c+vkH0Gq2GNhQFwD/3Om8Pufxq/LBJGmYKrJI2cgyygFA
         /KDRbpoVEG3SaE2JJ1Sl/nF5C1H4Disv6rZrIdh6EUgw/R53UwhrWWCzxwA8WJVh/hUy
         JPoJ0VP1t3RZs7VoNBMzXnRTP2nnt1Cw16eNbJ98uAjMlPANVBDzEt5854f2gIwdTT4i
         c67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VPA9Kxr39ERnqwIoc2UJSAp5IoBA3dbxr68iA+juyP0=;
        b=WzRe62VY2fVIL1IhtQvYz6EQVb3prMW0c60WnxpoAr3WvziSBEuwjQ2FNqueVGxnuV
         9snfiGGQOmbJhZbEj6Z3eGX3emZEeobvt/DzYtFfUjOdQ9XWvycrBqj0gsg8RSbfoTyS
         SVj3H8ACgpJbuGT5fy2+4cK+XlzwO2X1liBaJ0rB9XIY11Z/786ED+U5p5rjZ0IkQwpw
         FdIVjgfaoIoj0VWTI93bP1WTak3UOiU6TpAHZ6zvFW81Bj/SK8sNwAh6JIRlz5XC37/p
         2HiNWe+zX8v7pIXO8Ug1X9KLSfvnZ+qN48wU640iPmC7o3jy+7gM0cK6PUtMi79yPeEt
         KoyA==
X-Gm-Message-State: AGi0PuZ/Fjg8nvaHNkZkwoDV1MilUEwbst40VP+a1gEvZvQtiS55RL2J
        G+rh5viAMLZ+DuRTqSBly5BRLEFibuDVpNulMY8=
X-Google-Smtp-Source: APiQypJWKcOZwolIsn7a73yc4aMqWx+mk2KAdEK/HRRLB/AFX92WYN4FJ4pKWxX8TsolxV933sbSRmnXvsBuyeUoSoo=
X-Received: by 2002:a5d:84d4:: with SMTP id z20mr15044943ior.36.1588084601133;
 Tue, 28 Apr 2020 07:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200426104115.22630-1-peron.clem@gmail.com> <20200426104115.22630-8-peron.clem@gmail.com>
 <20200428081444.vddwswsorl5tf7yp@gilmour.lan>
In-Reply-To: <20200428081444.vddwswsorl5tf7yp@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 28 Apr 2020 16:36:30 +0200
Message-ID: <CAJiuCcf6xzB+HhV4GSOuawi3FJDeA4dvHXkKMV36+UF8gLLj7w@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] arm64: dts: sun50i-h6: Add HDMI audio to H6 DTSI
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
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Marcus Cooper <codekipper@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Tue, 28 Apr 2020 at 10:14, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Sun, Apr 26, 2020 at 12:41:15PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > Add a simple-soundcard to link audio between HDMI and I2S.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 31 ++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/=
boot/dts/allwinner/sun50i-h6.dtsi
> > index a5ee68388bd3..558fe63739cb 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > @@ -88,6 +88,24 @@
> >                       (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> >       };
> >
> > +     sound_hdmi: sound {
> > +             compatible =3D "simple-audio-card";
> > +             simple-audio-card,format =3D "i2s";
> > +             simple-audio-card,name =3D "allwinner-hdmi";
>
> It doesn't seem to be on purpose, but the name is different from the othe=
r
> series you sent.

Indeed, I have sent this serie before looking at the other.

I will change this to keep coherency, once we agree on the correct card nam=
e.

Thanks for the review,
Clement

>
> Maxime
