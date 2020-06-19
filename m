Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80432C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 11:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67431208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 11:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731731AbgFSLgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 07:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730919AbgFSLgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 07:36:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE6DC0613EE;
        Fri, 19 Jun 2020 04:36:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 00A712A05B8
Received: by earth.universe (Postfix, from userid 1000)
        id B218D3C08CD; Fri, 19 Jun 2020 13:36:07 +0200 (CEST)
Date:   Fri, 19 Jun 2020 13:36:07 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: ARM: dts: motorola-mapphone-common: remove unneeded
 "simple-graph-card"
Message-ID: <20200619113607.6h5qnq26nhxijjhp@earth.universe>
References: <87r1ub39hq.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wshmrvne2pjx6m4t"
Content-Disposition: inline
In-Reply-To: <87r1ub39hq.wl-kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wshmrvne2pjx6m4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 19, 2020 at 02:33:36PM +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Audio Graph Card is using "audio-graph-card" prefix instead of
> "simple-graph-card", and moreover "widgets / routing" doesn't need it.
> This patch removes unsupported "simple-graph-card" prefix from
> motorola-mapphone-common.dtsi and vendor-prefixes.yaml.
>=20
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 +-
>  arch/arm/boot/dts/motorola-mapphone-common.dtsi        | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 9aeab66be85f..147afcfe81fe 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -20,7 +20,7 @@ patternProperties:
>    "^(keypad|m25p|max8952|max8997|max8998|mpmc),.*": true
>    "^(pinctrl-single|#pinctrl-single|PowerPC),.*": true
>    "^(pl022|pxa-mmc|rcar_sound|rotary-encoder|s5m8767|sdhci),.*": true
> -  "^(simple-audio-card|simple-graph-card|st-plgpio|st-spics|ts),.*": true
> +  "^(simple-audio-card|st-plgpio|st-spics|ts),.*": true
> =20
>    # Keep list in alphabetical order.
>    "^abilis,.*":
> diff --git a/arch/arm/boot/dts/motorola-mapphone-common.dtsi b/arch/arm/b=
oot/dts/motorola-mapphone-common.dtsi
> index 06fbffa81636..1990239cc6af 100644
> --- a/arch/arm/boot/dts/motorola-mapphone-common.dtsi
> +++ b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
> @@ -140,13 +140,13 @@ soundcard {
>  		compatible =3D "audio-graph-card";
>  		label =3D "Droid 4 Audio";
> =20
> -		simple-graph-card,widgets =3D
> +		widgets =3D
>  			"Speaker", "Earpiece",
>  			"Speaker", "Loudspeaker",
>  			"Headphone", "Headphone Jack",
>  			"Microphone", "Internal Mic";
> =20
> -		simple-graph-card,routing =3D
> +		routing =3D
>  			"Earpiece", "EP",
>  			"Loudspeaker", "SPKR",
>  			"Headphone Jack", "HSL",
> --=20
> 2.25.1
>=20

--wshmrvne2pjx6m4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7soxUACgkQ2O7X88g7
+poB+w/5AW6f7+XYnn/UX9USobOZ5FfkThmQCtKUg1OcqPJa1Ff8+N/sSm30UP9n
gPc8xMwxkQ2YYUJprc01xgTzyk8kdyU9bOU5ZjCXTAfXfsCqtge3SmqInM45f+Qv
PkTx4MdRQTvZkzQQvC4dLaEcJVbk3wGAoEpNev8WDjqXRJkyfDax6NUIhJ5lQsSG
sfZv0Ly3wwaNwkWLHLjMAGoTlem9VjcwJeaJdjHNeX1xY3CMEHxHAINHLhADnVjc
TTmmaFVXIMwl47b63nGLeGEnAjPSfJIwbokF3MtstcXACUufBuHq38Tvspk9QM9o
A4anzJ/v6tQqUaTyGBfpZeJUPA4K4wWcxri4Ugn3uKsnFhJeYWBfk6Yxb+A86Bm0
9s5hcTVoiPSCe3Pob+HgHo66rf3+Lv+33a+z++n+4Htfrsr4rjvJNv6xS+xJpFa9
7FVO+2cFJNOb+3DIvAr8WVAirkplkJ0EozhhXorA8MHUglEOeQD562GQPCm87CL0
MrgwW+HhevbfIHyXyXFOcgXFxpatNeLOvrTbT++v+VwujjAAUAb56l0zS3GrosaB
GdB6wS+ktMpQ+50JXl/IBqSuBW4C9oU6TCL8Szh9VVoyG36SklGs2MI2vcMCJ5JI
DUuf9rci+KW5g/DK5nTvcpTiI0W+NJ4noCAvW8yAucKSAXZlBqw=
=gyZw
-----END PGP SIGNATURE-----

--wshmrvne2pjx6m4t--
