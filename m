Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0075FC55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 11:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D02D0217BA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 11:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxAhqJJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgDZLvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 07:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgDZLvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 07:51:31 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13E8C061A0E;
        Sun, 26 Apr 2020 04:51:31 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id o127so15801349iof.0;
        Sun, 26 Apr 2020 04:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zzsgb0bSas/OG7O+OpGibPBYKUg7XSUZ1PjoBegHMxc=;
        b=DxAhqJJ/wQgFg6ol8/V/EbSESD9xxzG/GvqGW5TNxf5CI7dpnx/S2VKRj9wUtueIBV
         3mDmrZBjRzWztKSMmg+fkEVqU63CPy4S13gNdFfhkb8lkOByaay629I6VMGYG9snKt8u
         l5q3vM+e8+mFhbz0EFQQD810W+W7HUO+l9PnDlcXfeHD8pmg5UyrhaRG5rA5uIdErs2U
         d8TbZRSuC93nK0UTrKJbPlNAqcLfL3pJdoGstSmHRcz0qNxh3+RRVs+Cls5dNi1/aaPy
         6GjieOKiHsSoDg111lXJmfV38HDdh0SkvnjaqBxb60YPs4oT648UMCI/KI1EhHtJEwbp
         kTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zzsgb0bSas/OG7O+OpGibPBYKUg7XSUZ1PjoBegHMxc=;
        b=O0t2BiGLKCVF6FMfxuHtuPi1WUzPqMu1GheFtHl9mvhB21vlEwZJT3jo0Sl86TzB8i
         CqFkGDj5yMQBs50HgjaoGwEO5WOPA7yhC1KjIKvsgPIlmg/SLmeML+6btMioZTu4bAhz
         f8T1Mt2gGYIsvLxGsO9hFayz7JB6hIW43cJmxjyIlPE1GngY0O01foEAHtdCb5Hv5/a6
         vafNQ7AYQQcnYvXBVMtE3Z7xuYM885m7H0UMrqCMoBNOXPJCb9nxdyQoKaGRBublSMmK
         y8/Nianrt/li29Eqp1SklEKyq6H16dKXpdK8/D34J746c6IodjpjvC2JtDBp36AT2Yw2
         Wy0g==
X-Gm-Message-State: AGi0PuY+yVswG6eM/dphx99VhA/Vr9AuKQZJ5lq8IyaDV1iOMAaAUOpJ
        P9CY9kRBlzfUQfHLuFpYULyB77LKG7N48nzXch8=
X-Google-Smtp-Source: APiQypKq7oXcr9IeMjM8MZxjatFWiOsSh24aUP+LwC+13d1DBgzun3vwOHINHuAmcSK9qbROS4jgfWwkk4wJsA7yiA0=
X-Received: by 2002:a05:6602:2fcd:: with SMTP id v13mr16297176iow.124.1587901890849;
 Sun, 26 Apr 2020 04:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200426104115.22630-1-peron.clem@gmail.com> <20200426104115.22630-8-peron.clem@gmail.com>
In-Reply-To: <20200426104115.22630-8-peron.clem@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 26 Apr 2020 13:51:19 +0200
Message-ID: <CAJiuCcfkk3huywjBcHqfCimEXzH2iX=MYriWyhfrKWX47C=CvA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] arm64: dts: sun50i-h6: Add HDMI audio to H6 DTSI
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
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

Hi,

On Sun, 26 Apr 2020 at 12:41, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> From: Jernej Skrabec <jernej.skrabec@siol.net>
>
> Add a simple-soundcard to link audio between HDMI and I2S.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 31 ++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/bo=
ot/dts/allwinner/sun50i-h6.dtsi
> index a5ee68388bd3..558fe63739cb 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -88,6 +88,24 @@
>                         (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>         };
>
> +       sound_hdmi: sound {

I will rename this to
hdmi_sound: hdmi-sound {

in the next version

> +               compatible =3D "simple-audio-card";
> +               simple-audio-card,format =3D "i2s";
> +               simple-audio-card,name =3D "allwinner-hdmi";
> +               simple-audio-card,mclk-fs =3D <128>;
> +               simple-audio-card,frame-inversion;

And I will add a status=3D"disabled" here as not all board have an hdmi con=
nector

Regards,
Clement

> +
> +               simple-audio-card,codec {
> +                       sound-dai =3D <&hdmi>;
> +               };
> +
> +               simple-audio-card,cpu {
> +                       sound-dai =3D <&i2s1>;
> +                       dai-tdm-slot-num =3D <2>;
> +                       dai-tdm-slot-width =3D <32>;
> +               };
> +       };
> +
>         soc {
>                 compatible =3D "simple-bus";
>                 #address-cells =3D <1>;
> @@ -581,6 +599,18 @@
>                         };
>                 };
>
> +               i2s1: i2s@5091000 {
> +                       #sound-dai-cells =3D <0>;
> +                       compatible =3D "allwinner,sun50i-h6-i2s";
> +                       reg =3D <0x05091000 0x1000>;
> +                       interrupts =3D <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks =3D <&ccu CLK_BUS_I2S1>, <&ccu CLK_I2S1>;
> +                       clock-names =3D "apb", "mod";
> +                       dmas =3D <&dma 4>, <&dma 4>;
> +                       resets =3D <&ccu RST_BUS_I2S1>;
> +                       dma-names =3D "rx", "tx";
> +               };
> +
>                 spdif: spdif@5093000 {
>                         #sound-dai-cells =3D <0>;
>                         compatible =3D "allwinner,sun50i-h6-spdif";
> @@ -711,6 +741,7 @@
>                 };
>
>                 hdmi: hdmi@6000000 {
> +                       #sound-dai-cells =3D <0>;
>                         compatible =3D "allwinner,sun50i-h6-dw-hdmi";
>                         reg =3D <0x06000000 0x10000>;
>                         reg-io-width =3D <1>;
> --
> 2.20.1
>
