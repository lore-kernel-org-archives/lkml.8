Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17F4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC34C2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595850821;
	bh=pmx7r4So4ltU9GFLtyowT8sGCWQ3CPndiOgHKn5MH2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cucpGlDzVy3mf63VPBqXIO2nhcG5hcH8mtN8TtDXQaqnKhzvB+5zs9qFOSXlawzb4
	 XELMS+8S2dUYeVJs51GAlfkwuGtWjQgaJGfKEEm1v8jksRvXsoDibJomxqSD50jhJe
	 SFnwPF6zbz/C0rGdzttjErKTmYcJDp9eXoatrAtw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgG0Lxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 07:53:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgG0Lxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 07:53:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A227E206E7;
        Mon, 27 Jul 2020 11:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595850819;
        bh=pmx7r4So4ltU9GFLtyowT8sGCWQ3CPndiOgHKn5MH2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G1ACx5gLsKOlLnHUq7TxrmlaoSuUj35QO83mZgX22J+x2NolUsEZLVhjOUT0Duu2X
         UBU8N1plsG6Qtp1WieL6u0koBH+1NAhNq5ckcoQiUhlW12aQ+nQzPDHVpbAGDiZ+1d
         LpaP1h91USoBeicfxQp8fugF1xEmm13NGV/cXHe4=
Date:   Mon, 27 Jul 2020 12:53:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        balbi@kernel.org, gregkh@linuxfoundation.org, lgirdwood@gmail.com
Subject: Re: [PATCH v3] usb: dwc3: Add support for VBUS power control
Message-ID: <20200727115321.GC6275@sirena.org.uk>
References: <20200619142512.19824-1-mike.looijmans@topic.nl>
 <20200723075612.tn5dbkhes2chohwh@axis.com>
 <20200723110523.GA4759@sirena.org.uk>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.2698920d-90ba-4c46-abda-83e18e2093c8@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.ac9c2a67-d7df-4f70-81b3-db983bbfb4db@emailsignatures365.codetwo.com>
 <e63ee918-c9e3-a8ee-e7c5-577b5a3e09be@topic.nl>
 <20200727102317.GA6275@sirena.org.uk>
 <be4013b6-01c6-7f67-35ad-5c398b85c066@topic.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
Content-Disposition: inline
In-Reply-To: <be4013b6-01c6-7f67-35ad-5c398b85c066@topic.nl>
X-Cookie: Doing gets it done.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2020 at 01:50:26PM +0200, Mike Looijmans wrote:
>=20
> Met vriendelijke groet / kind regards,
>=20
> Mike Looijmans
> System Expert

You probably want to remove your signature when replying to the list...

> On 27-07-2020 12:23, Mark Brown wrote:
> > On Sun, Jul 26, 2020 at 09:10:39AM +0200, Mike Looijmans wrote:

> > > It's the 5V VBUS power for the USB "plug" that's being controlled her=
e. It
> > > must turned on when the controller is in "host" mode. Some boards arr=
ange
> > > this in hardware through the PHY, and some just don't have any contro=
l at
> > > all and have it permanently on or off. On a board where the 5V is con=
trolled
> > > using a GPIO line or an I2C chip, this patch is required to make it w=
ork.

> > That sounds like the driver should not be using _get_optional() then.

> Making it mandatory would break most (read: all except Topic's) existing
> boards as they won't have it in their devicetree. I'm perfectly okay with
> that, but others might disagree.

No, it wouldn't break them at all - they'd get a dummy regulator
provided.

--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8ewDEACgkQJNaLcl1U
h9AOeAf/Q3uCuO9POLkFE4AFLM60fwOW/cXI1NJMegOuZ91RhQk4TF2WaZlMWHIf
b8SYB4gvI151gQYg2UPgf52UpWEbVUZN6GoM/wyk1dOAm6ulrMx248Upv3gQkpHi
RBRynDGfnTgOdn6GPde9XO24zF9zCpL6HyN1AHbp9y9zuC3nVg23Pi+Usyw3MyiG
RWRyQ3lKAqssLAh+6CYQQBVQ2mEp6ubHxH9UuGoKYfgDDqo7gff1b4Ibfkv9QT3G
wjVCthn7ZcgpKyFalB1cZ6MJcsnvEvtWcdz/lMAYT6YXpha0UvuVs5xj0LFYw6pc
u9fo8pNhRClmGM+PizicmWsAcQ6aBg==
=yKtV
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--
