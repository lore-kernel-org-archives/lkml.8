Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D845C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EBFB206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fPIuVdan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgHPP6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 11:58:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:47669 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbgHPP6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 11:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597593486;
        bh=7j6qXfPm5EI3jykDMS74HC6S0xyBwhkXpq11cquJsww=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=fPIuVdaniS5SKHac+UUsM6tcYRptyPNJ1EaPOylQ7Hf6WWs1vDa0tau+pf5mUkNEf
         B3zHJmlAn3/WsvAfDWuvaNJ+6JM9vQDIWy3jp5/EHfPnF9hWC6BtZGIz5OB2FC/lOu
         +LT8vkkufsyk0boPb12UGfCNHQWhihqY4QNIocIM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wLZ-1k10Bp1lgx-007SYI; Sun, 16
 Aug 2020 17:58:06 +0200
Date:   Sun, 16 Aug 2020 17:57:51 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, marcel.ziswiler@toradex.com,
        sebastien.szymanski@armadeus.com, rjones@gateworks.com,
        leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH RFC 2/2] ARM: dts: imx: add devicetree for Tolino Shine 2
 HD
Message-ID: <20200816155751.GB103070@latitude>
References: <20200815193336.21598-1-andreas@kemnade.info>
 <20200815193336.21598-3-andreas@kemnade.info>
 <20200816125247.GA103070@latitude>
 <20200816165058.3a17d97a@aktux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline
In-Reply-To: <20200816165058.3a17d97a@aktux>
X-Provags-ID: V03:K1:mT/FQPdide8zSxjSEqchlaAZFDs6iEhlej5xL6GKMHINDQfqMka
 +ZUp7H63mXXEpAunPeJiokUHEdf9lCJAumVPW2U1p4CjEpXOwqHl7Vx4QV6L5bvLnkFfUR5
 Ch2LtONaJELiVauqqbl38zfm81OsbxxMLxctrnwPOpQHsKkWcN6U6nyg/F3XvI8DyishTNy
 NfQrA6TTfDibB/5YzbtHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w3+rXEc45eE=:7zvYNIT0IbAuDMZjIeuNp1
 LbHZsE9dHGw6nNCcGoKN3loSdbLwophUkjfiU0u60+Rt5nVD8kNjePPQ3oLC07YcUyXiLmEdL
 3bwuBPC0eGaX5CBxFMcQmjDzX3wNFZJx294NyCDzOgzoMcO3RAI6Yp3O3Ab37xJy4FyyVs9+T
 0uMhh73kuGZV6VYG12zecd/jSZEPrWUKk5uEX+kzKE5ziHze4jG+VvX5VAqAYXy7TFG/8ZU6e
 sozAdUTtVwwUY3qp9GpbT7b4UYY8jUsrrT5D6+A0HdPnW+e2AN8pttUN/D1ii0U+SIyexGJed
 fpcGQGMjdt2gowL8oB3cPOx/KkxS8z8u7RkYz2jJHlEPJcqFJE9DhsneeEOnvWfXJeh7mKgO5
 D9XYpDGfnuCuJHqjkl6BWafVPZBUYvBSzq34S/ni98YD5tyvsokTaBJjYlUIGRtF7PbRZkAkZ
 Zc7dL1hYIG3bZkBHELOLyqSH/jbJmFZeT27dCKyitEjLyjiLsPDf3NR4CY4LBkrR0P3t18RDs
 6GKQFVIIdx8GlZeX2uLZ+JQommak9BA2LIhHn7WCF2z0v8qi6dyx03vNRJSfoE6XwzcIDflUX
 SANHSqnHffgE/7oI2SfZ4t9Y/D/MbQcy9e+quYDLTzIRO5l7O3HqQ6C5OsDKaXZYexub2moqY
 aVZF9rQ7xcbp2JwaFwTd+Zlrlu/YjDXXefa/aJ+J7YDqgN8n7uRt/Ng1FtU9ZfM1US735SfxB
 AudgktdTvY1uc2k/ic+P3AcK7g0IPbjBFej4Pa5xybaKlpLiyTash5UxXifpTNy1gwINSR/rA
 bBEMkcJAKrSkp5zUSPzuItyR0DDA46Y6rxLlSCJkHT4ysHsF913rwr0PZGYXgMP31qNkiHjuQ
 R+lu2SWK0hjYpY44OPULRGkwpDYHFJxcfjtSJJ7frJc+P0Td3i3GfgRqtq0L+RgVtPOnBAp9e
 J4s1llx5ntfoYB/mOgKqrmff8Qo1NiY/TdvtbbKzo89JWfpFBxWz5FhBmZTmj4flFCYX430BZ
 EWxYnxArSCBctDm2HZO7+laIbjcBHS5KH9AWczuMginfdUEY6NSLPVQnnESShPTwY4n3GGWJ/
 2CK18fsFnxgnmW38ItmAS9ucAQ8CPl8roIcr0ybDR+VlDQ1Sz/swqA5bchuUsDulOEXzBpTJL
 jeFFUGTvi9XMAZbGatYuRN7gLw2jx/L52CKPoxN9qS55zbC3gX6wm9Jkk2XiIcx8eVRPosl14
 x11Vk4hOqgszUz8O9y6iHwIA275czjUukrLvqSQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2020 at 04:50:58PM +0200, Andreas Kemnade wrote:
> Hi,
>=20
> Seems that we have different hardware, so the first question is
> first the most interesting thing: how much does the hw actually differ,
> especially do they require different device trees?
>=20
> Can you provide me a photo of your hardware?
> Or is it a Shine 3?

It is a Shine 2HD

>=20
> Mine is at https://misc.andi.de1.cc/tolino2.jpg

Mine:

https://raw.githubusercontent.com/wiki/neuschaefer/linux/Tolino-Shine2HD.jpg


It appears to be the next PCB revision (+4A3 instead of +4A2), but I
think the PCB layout looks the same. The Realtek-based Wifi module is
exactly where the CyberTan WC121 was.


Jonathan

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl85V3cACgkQCDBEmo7z
X9udTRAAnqYWkdOI8tX0fQFUnKd/EwOkrg7Jrg5utNCvVidT3o0nRwjgEAc551f0
LQSR2+dKjkr7EigcA9YYj0I3v0PJ1CgQuS/xK6mZ/D/YySVg3phF+wlNb8SJ5lcq
9NRetjWtVTlNatzsADLncF/ZqoZlPo4llgjW0kt/+60mc7CPgtpsEE+9GsFnb/k4
dw7aisPgGzoMPbbeTEDkPJl5Bik3WfjMAd002dsu/GnHLfEj+XDmI7CVLfz51bvz
abkkvAYcAIcyPEcGfg714qK9nR1a7HuVGz3dV0A8ZeCTl0IRn1MDpR/6LZJT53y+
HM1cIV1YfLPU4gEImoymX3pDvhE2DctceEzfw84ng/mhxLqzBGFm8qh5reihwva2
TiOxZqcKTIMqqfV1nhRwSeahhX8eLoXkfAQ1jbKNCoLFZuvOsQpKkFetUDYXUYUE
CTwqYrxe67UO3b8lBA82QAfg9fQBnKkczF5euZR3bsFChfoU1QDOGJDt3Si+LNkq
ILFU9thdfyAH5qeRr4gKq7DecEZnGLz3+ql6/ePNrGwslIz2aicqTNW1Q09xwgxQ
KerJAbQn+R+kLkLxkOL5+RgAd0VpZAivt62GkDztYRKAHXPtWv9iZDNRBzMfxEQu
Wzd2yhpQ81slPry7HEM2J4zcy+VraDDvetO/6ZhQzvQXncXG47o=
=ksBD
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
