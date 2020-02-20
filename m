Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0E5C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5495207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="jYZ2RHNb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iKlzhwNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgBTRYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:24:50 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36427 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727979AbgBTRYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:24:50 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 339E821D6E;
        Thu, 20 Feb 2020 12:24:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 20 Feb 2020 12:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=te6hdqtQBQi0OFmy4I46vtfMUfG
        loiIkQJHlJUAw1Po=; b=jYZ2RHNbhZSEidhluJIDU6jVeGxE/iCJM/du3cp/Ae9
        aC4NNCcOaF5a1u04qZeMKjF/fHiD/BikSUcTZwytD6iTqppOcXkJ58ic50VnNNhy
        tP/IJMdwKd9AKmEVi0E6f9qa5eo88DcSggqpz4wU1boO8YxeiUk7CO1MmtHoXyCy
        oFqdEQJ6tf9/kd7YM+bZ+/PDvfQUn/Kc31mrtnryLvWBGrnv3UbE3FCg5s4Miw1D
        d6uoNw0SGFFL+lcArMkzdMEEcBbW5SBnbngpACskbT5QjRvhMQP4uIEuIkUdcAoF
        SddU2/FJtpCtLTMF/Gtiw2ifA3oo1JcFYXOjl694scA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=te6hdq
        tQBQi0OFmy4I46vtfMUfGloiIkQJHlJUAw1Po=; b=iKlzhwNoehwx38inZe86Sp
        MEMG6KRTstc2sT9ZNSGtmbr1E7eP0D7Wlk6tBBR7Vg6HsexHL8EnLv4AW1HSD18K
        jFc4hhQ+1d2MbnG9qWCNHR68jfuxgAUJCoz0vz5FiT6TQt1bE5Iul3hktQmfAAlV
        yyfbiMsQjCeM2ipKCcEkWt/KDRJ4Qd5TZA7TwK0xjJytTrmdJP/7+x+khplgNbeV
        WXKixC2GXYDnwAm8VswRgMGGcRzpVLoa2zJNbVVyWnAn2VxSwqcwDoAUAKawYKWI
        4ml3miuKfjbSmsooTvL1MOvngeQWb21Ih7TY5CG9bucivKaeVQTQ8UJr/8AQ2kwg
        ==
X-ME-Sender: <xms:38BOXsUyNFFHbTkUI4L6lSmEuBpN2to3bnumg5QKeZUwpWa5nK7cQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkedvgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:38BOXtPnDlk2fotdqkIJYqsppoZXUNXEjhVlabcenoCtDlaazpySgQ>
    <xmx:38BOXmysRKSbfQ9lAMIu7F-OMkpWLMdLX4gSC0sTV_i62YKi3muq7Q>
    <xmx:38BOXlMIRB3K6gQeHz6LwzDvEyJ_gJSb0Rb_WfV1HHEj4OKssfzQaQ>
    <xmx:4cBOXprXyGmrPIxveegUBiPvy01hCRzkkJlR9OlNDZ7shuWsZoqYFA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6E60C3060C21;
        Thu, 20 Feb 2020 12:24:47 -0500 (EST)
Date:   Thu, 20 Feb 2020 18:24:46 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andrey Lebedev <andrey.lebedev@gmail.com>
Cc:     wens@csie.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Andrey Lebedev <andrey@lebedev.lt>
Subject: Re: [PATCH 4/5] dt-bindings: display: sun4i: New compatibles for A20
 tcons
Message-ID: <20200220172446.gg746z5efmzwtfdz@gilmour.lan>
References: <20200210195633.GA21832@kedthinkpad>
 <20200219180858.4806-1-andrey.lebedev@gmail.com>
 <20200219180858.4806-5-andrey.lebedev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j2564guncf3jyy2w"
Content-Disposition: inline
In-Reply-To: <20200219180858.4806-5-andrey.lebedev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j2564guncf3jyy2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2020 at 08:08:57PM +0200, Andrey Lebedev wrote:
> From: Andrey Lebedev <andrey@lebedev.lt>
>
> Document new compatibles used to differentiate between timing
> controllers on A20 (sun7i)
>
> Signed-off-by: Andrey Lebedev <andrey@lebedev.lt>
> ---
>  .../bindings/display/allwinner,sun4i-a10-tcon.yaml          | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml b/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
> index 86ad617d2327..c0f6bb16fa34 100644
> --- a/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
> +++ b/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
> @@ -46,6 +46,12 @@ properties:
>            - allwinner,sun50i-h6-tcon-tv
>          - const: allwinner,sun8i-a83t-tcon-tv
>
> +      - items:
> +        - enum:
> +          - allwinner,sun7i-a20-tcon0
> +          - allwinner,sun7i-a20-tcon1
> +        - const: allwinner,sun7i-a20-tcon
> +
>    reg:
>      maxItems: 1

It wasn't ordered propertly, I've fixed it up while applying

Maxime

--j2564guncf3jyy2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXk7A3gAKCRDj7w1vZxhR
xfwVAP9fqMR6S5QNlK723niU/vA0ow7ntEjfO/d+1F6+P/qUHgEA8pTIZG3N0KC4
EDlYflE0dcgyudMkCjaHcAa7PgUxPAY=
=41w8
-----END PGP SIGNATURE-----

--j2564guncf3jyy2w--
