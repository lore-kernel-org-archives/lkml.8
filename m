Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC56FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8029120B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="hc72frU2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390826AbgFXMDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:03:17 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:51308 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389387AbgFXMDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1593000193; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VA2AWcxxad/sxNKV1aRnPWhyI//Gmywy6le15GSXRt4=;
        b=hc72frU2egBndDOCOeCljM0eVw5CN6qs/b557/6Bpn7sfHFvTV3MSjWlyDEiHrYNskqXhG
        5pp4x/UYkJyptxDkK2u8hJ4leDYJL2o27l+L8iXhye9dWe6RTb9XVDTvbZafiON91Ucs56
        vrnLR96J/6OJVxl91EOGWKaQs6PmMww=
Date:   Wed, 24 Jun 2020 14:03:03 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] MIPS: ingenic: gcw0: Fix HP detection GPIO.
To:     =?iso-8859-1?b?Sm/jbw==?= "H. Spies" <jhlspies@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-Id: <3TIFCQ.1ZGWWD0PTNQ03@crapouillou.net>
In-Reply-To: <20200623211945.823-1-jhlspies@gmail.com>
References: <20200623211945.823-1-jhlspies@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jo=E3o,

Le mar. 23 juin 2020 =E0 18:19, Jo=E3o H. Spies <jhlspies@gmail.com> a=20
=E9crit :
> Previously marked as active high, but is in reality active low.
>=20
> Cc: stable@vger.kernel.org
> Fixes: b1bfdb660516 ("MIPS: ingenic: DTS: Update GCW0 support")
> Signed-off-by: Jo=E3o H. Spies <jhlspies@gmail.com>

Good catch.

Tested-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  arch/mips/boot/dts/ingenic/gcw0.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/boot/dts/ingenic/gcw0.dts=20
> b/arch/mips/boot/dts/ingenic/gcw0.dts
> index 8d22828787d8..bc72304a2440 100644
> --- a/arch/mips/boot/dts/ingenic/gcw0.dts
> +++ b/arch/mips/boot/dts/ingenic/gcw0.dts
> @@ -92,7 +92,7 @@
>  			"MIC1N", "Built-in Mic";
>  		simple-audio-card,pin-switches =3D "Speaker", "Headphones";
>=20
> -		simple-audio-card,hp-det-gpio =3D <&gpf 21 GPIO_ACTIVE_HIGH>;
> +		simple-audio-card,hp-det-gpio =3D <&gpf 21 GPIO_ACTIVE_LOW>;
>  		simple-audio-card,aux-devs =3D <&speaker_amp>, <&headphones_amp>;
>=20
>  		simple-audio-card,bitclock-master =3D <&dai_codec>;
> --
> 2.17.1
>=20


