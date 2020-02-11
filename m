Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C9AC3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 08:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245F320714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 08:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="mOhmXSeH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FTWAl0a3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgBKIfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 03:35:43 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56291 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727264AbgBKIfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 03:35:42 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id EC04C21FBC;
        Tue, 11 Feb 2020 03:35:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 11 Feb 2020 03:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=hFJPLcnX8s+3qIibRSJBHtz36o0
        Xcn/sOE9MnHdM2nc=; b=mOhmXSeHq26+QkB6NNaPcF7iJe+NUrPjcs9h1UM6HxE
        1v4f1t/E8wrLAIyGQ6+4xpAw6/ClNPhfwZ8JJtz8eZEZ56cv2hrEoen6A/KU2P+6
        9cZyEMTTkNacGdzqHakFT2uVb67N7EQIAX5dcagKxOab2+MPjcAhFKvxtzOUyCCr
        DrnNckO8RO9Y47OamqAz2Dcf2U83fLVYffzN8DVFZXdz+6Vp4cpQQfGetn36bj/m
        4r30osjF+/3S6HVkgJasOOhRRE38JOv6+P7eN8ZmQH003lRpUJ2k8q3wiUiNU5N8
        Rnd/BJmZamIC4Eg+gGpq2EoEmynSbgHmL3mIIEn2HDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=hFJPLc
        nX8s+3qIibRSJBHtz36o0Xcn/sOE9MnHdM2nc=; b=FTWAl0a3DGQCpyOaobOCBY
        ldmAheX1HeEtYFHQtS5RklwF6RtaAcle/jG/0TqpmSAhZwzbPKl/g+fL6OMJFbpx
        PQ3DqTA992mPk93syf2j2zKRRM1yh/oBMvALa56U9kC4ayH3YZTKlwrnkLsbOL4P
        c0oDJ/MJza5snqrRyAvi/Jp+wL7v46KpmF5ixZNdv5OJAFpAEE/7ZGsAtHlPYzmo
        hsJ/Bx3Rzbglb4iKGpzefXu0eC/kjQMvKIvAqOcip3eV/G8tk9xO2rwbawn2H6Oq
        YiXQkqv4awjVLAOQK3ADsV6P7gWj23H+vv0BKVyxlxEuTF2obzBoy2ukqlVxTYeg
        ==
X-ME-Sender: <xms:XWdCXpZogL5KTOSweHyx6aZx_aDEzRF__be1i8TpE611rjsVJu-3xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedriedvgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:XWdCXty0q4wMncxGba1tOZQp_hv4opMhLG0T0vqlX4drutiF74HOUA>
    <xmx:XWdCXle6226wyAmAowvxW7zI-oYNboOYdO1mjvowJ0VcUBJx-FrDZg>
    <xmx:XWdCXi5Dp2A7YN6SFIRW_xiXIwj2MeLfFa0bpj3tPZnKK5kwXRbBqw>
    <xmx:XWdCXhg_vFke7fRwPoFxzH-xhpZpfMTdNuxnI1RwFZtBzRP7JOfdtA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1EDF3328005A;
        Tue, 11 Feb 2020 03:35:41 -0500 (EST)
Date:   Tue, 11 Feb 2020 09:35:39 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2] arm64: dts: allwinner: h6: orangepi-3: Add eMMC node
Message-ID: <20200211083539.wciujb6zgjxnwkio@gilmour.lan>
References: <20200210174007.118575-1-jernej.skrabec@siol.net>
 <20200211065141.2kn2gsg5kvzu7kl6@gilmour.lan>
 <5325319.DvuYhMxLoT@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gz5taobraj7y6ke5"
Content-Disposition: inline
In-Reply-To: <5325319.DvuYhMxLoT@jernej-laptop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gz5taobraj7y6ke5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2020 at 08:09:57AM +0100, Jernej =C5=A0krabec wrote:
> Hi!
>
> Dne torek, 11. februar 2020 ob 07:51:41 CET je Maxime Ripard napisal(a):
> > On Mon, Feb 10, 2020 at 06:40:07PM +0100, Jernej Skrabec wrote:
> > > OrangePi 3 can optionally have 8 GiB eMMC (soldered on board). Because
> > > those pins are dedicated to eMMC exclusively, node can be added for b=
oth
> > > variants (with and without eMMC). Kernel will then scan bus for prese=
nce
> > > of eMMC and act accordingly.
> > >
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > ---
> > > Changes since v1:
> > > - don't make separate DT just for -emmc variant - add node to existing
> > >
> > >   orangepi 3 DT
> > >
> > >  arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> > > b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts index
> > > c311eee52a35..1e0abd9d047f 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> > > @@ -144,6 +144,15 @@ brcm: sdio-wifi@1 {
> > >
> > >  	};
> > >
> > >  };
> > >
> > > +&mmc2 {
> > > +	vmmc-supply =3D <&reg_cldo1>;
> > > +	vqmmc-supply =3D <&reg_bldo2>;
> > > +	cap-mmc-hw-reset;
> > > +	non-removable;
> >
> > Given that non-removable is documented as "Non-removable slot (like
> > eMMC); assume always present.", we should probably get rid of that
> > property?
>
> I checked mmc core code and this property means that bus will be scanned =
only
> once. In this form, node doesn't tell what kind of device is connected, so
> core has to scan it no matter if "non-removable" property is present or n=
ot. I
> maybe missed something though, so it would be great if someone can check =
it
> again.

It looks like it does indeed :)

I've applied that patch, thanks!
Maxime

--gz5taobraj7y6ke5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXkJnWwAKCRDj7w1vZxhR
xQ9DAPwKsJ5NfkwTvuzamY+OX8zTm78ylv/XrhL2Zjagyt1lSAEAiV+LhGVcTzyw
qAB87cY7DepYjwV8j3ucYDyOZ57UYgM=
=UejU
-----END PGP SIGNATURE-----

--gz5taobraj7y6ke5--
