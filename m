Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7B6C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AC0B206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="sWE34aPs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hVmCUKbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgD1Nuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:50:46 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:60117 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726871AbgD1Nuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:50:46 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 7C86A68A;
        Tue, 28 Apr 2020 09:50:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 28 Apr 2020 09:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=4iAZAo8TV910VLKndZ5Wk9WKzuI
        ARrXA2SHPPX+ivMs=; b=sWE34aPsKoEhvAvsNx6TDGAHBMXKKikJSzYRGkUHg8w
        mFef2xGfaSY0hLeh4H/1xIVQwjYoPdRlRWZ0vQ8uPesLLytqysvxFiYI+Tyuttoe
        23CjL2YBsWp/9Jz1plx9NH8Q6Iv8cd7Vdnj+7Ra+OgDWhxSDCzL1aWsSbctJoP6e
        8e0ZErOy42owcsjzGEXrWglV7tY2WdKyyqzgoWXk2aXgcjUXUqBufXtRW2Cm2Noo
        cC/uGOjmB77N40IOhlNuQbiEp9/6TU95nj8lOIchTe0xht50om4C1bAt0oEgQazW
        KdgP4pBJYe8ABZmu48I9IIre0ZyOtDAhKpBnwG6XDSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=4iAZAo
        8TV910VLKndZ5Wk9WKzuIARrXA2SHPPX+ivMs=; b=hVmCUKbWPfnl2YIzTa4hEs
        ofc+8FVBBXEeSEArgjnGJTnzcdQDwVFWJB3LPpL65+aJ7sCzN9W7lc2DaPm1Zp2C
        w+AD3pNt65ra32K43ajZSjxhrmNEp1wuqOD5FPq7uDw+dOWEmCD5J3XYqNXVB6Gu
        ZGw1vsPXo9oboaHhpg2HpepA0uKDajAwlzBaDx0D8di60R2KcvMz0VzZUGb0Sz55
        zPVgeBkGLyoQKfiWLYQNrxzG5TRk0kzYR6Karl72zoz8NWrMsLiSIbr6g35mmJEb
        dJx0uWKXvMqEVNv2B1BjsyiiU3OP9yN2TGVmwyLv/RR+f1CvydUtq53LTFFnE3sA
        ==
X-ME-Sender: <xms:szSoXspECv2ZMBzZNr5zIHvZnhS-qfmAQhYWYU5CS2I8MdGcqgSjGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedriedugdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:szSoXucwlkqZ27aA4XRiG9WDDJo4416B0FhhR0PBtfqSHaIZAg5oPg>
    <xmx:szSoXsmVJ-GmWQd__p_Hm7AjNZbiNPnCS3oaWn2L0T71TnYAmrxh0g>
    <xmx:szSoXtaZZwSkglEMDDgagVpkIA2CgKl5lxF6J8umJKpaLCZPWf1UZg>
    <xmx:tDSoXrZfdMeE1aAqgGQE3LInrs5bbZ6VEhqJFj9rVKwZbY3wJQK-HQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D1531328005A;
        Tue, 28 Apr 2020 09:50:42 -0400 (EDT)
Date:   Tue, 28 Apr 2020 15:50:41 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH v2 04/91] firmware: rpi: Only create clocks device if we
 don't have a node for it
Message-ID: <20200428135041.zg5h454fkc5wgxp3@gilmour.lan>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
 <b181d867cb9523e1877a3dfd258bafde2988024f.1587742492.git-series.maxime@cerno.tech>
 <4842d1b72192bb7c461a2d50c8798f178da964e0.camel@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tdisr6odiqdkp6jx"
Content-Disposition: inline
In-Reply-To: <4842d1b72192bb7c461a2d50c8798f178da964e0.camel@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tdisr6odiqdkp6jx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On Mon, Apr 27, 2020 at 01:24:14PM +0200, Nicolas Saenz Julienne wrote:
> Hi Maxime,
>=20
> On Fri, 2020-04-24 at 17:33 +0200, Maxime Ripard wrote:
> > The firmware clocks driver was previously probed through a platform_dev=
ice
> > created by the firmware driver.
> >=20
> > Since we will now have a node for that clocks driver, we need to create=
 the
> > device only in the case where there's no node for it already.
> >=20
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > ---
> >  drivers/firmware/raspberrypi.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberr=
ypi.c
> > index da26a584dca0..1874f41b007c 100644
> > --- a/drivers/firmware/raspberrypi.c
> > +++ b/drivers/firmware/raspberrypi.c
> > @@ -210,6 +210,15 @@ rpi_register_hwmon_driver(struct device *dev, stru=
ct
> > rpi_firmware *fw)
> > =20
> >  static void rpi_register_clk_driver(struct device *dev)
> >  {
> > +	/*
> > +	 * Earlier DTs don't have a node for the firmware clocks but
> > +	 * rely on us creating a platform device by hand. If we do
> > +	 * have a node for the firmware clocks, just bail out here.
> > +	 */
> > +	if (of_get_compatible_child(dev->of_node,
> > +				    "raspberrypi,firmware-clocks"))
> > +		return;
> > +
> >  	rpi_clk =3D platform_device_register_data(dev, "raspberrypi-clk",
> >  						-1, NULL, 0);
> >  }
> > @@ -262,8 +271,12 @@ static int rpi_firmware_remove(struct platform_dev=
ice
> > *pdev)
> > =20
> >  	platform_device_unregister(rpi_hwmon);
> >  	rpi_hwmon =3D NULL;
> > -	platform_device_unregister(rpi_clk);
> > -	rpi_clk =3D NULL;
> > +
> > +	if (rpi_clk) {
>=20
> rpi_clk, being a static global variable, will be zeroed by default. So, i=
f you
> don't register the platform device, rpi_clk is going to be NULL, which yo=
u're
> allowed to feed platform_device_unregister(), so no need to be extra care=
ful.

Indeed, I'll fix that up.

Thanks!
Maxime

--tdisr6odiqdkp6jx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXqg0sQAKCRDj7w1vZxhR
xbQ1AP9u2PkigXhbvMvsCOEqNwJ8D7x0AE8RyRBsAh+1uyg8kgEApwI7mCx3Oyv0
OKLPLIDceoiTcYK3Qs3FCOaUJ+9WKgs=
=W0Du
-----END PGP SIGNATURE-----

--tdisr6odiqdkp6jx--
