Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D08EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 10:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 406E520706
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 10:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390281AbgFXK0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 06:26:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:45022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387962AbgFXK0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 06:26:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 164E5ADB5;
        Wed, 24 Jun 2020 10:26:28 +0000 (UTC)
Message-ID: <307f381cbe4976c200dbcdf0670f79a6a55bf726.camel@suse.de>
Subject: Re: [PATCH 03/50] staging: mmal-vchiq: Avoid use of bool in
 structures
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Jacopo Mondi <jacopo@jmondi.org>
Date:   Wed, 24 Jun 2020 12:26:21 +0200
In-Reply-To: <25a963df43bfa4a1099b6813bb35d9c5a6184578.camel@perches.com>
References: <20200623164235.29566-1-nsaenzjulienne@suse.de>
         <20200623164235.29566-4-nsaenzjulienne@suse.de>
         <25a963df43bfa4a1099b6813bb35d9c5a6184578.camel@perches.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-FOp+GqeSI2bnqbVaozq5"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FOp+GqeSI2bnqbVaozq5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-06-23 at 15:11 -0700, Joe Perches wrote:
> On Tue, 2020-06-23 at 18:41 +0200, Nicolas Saenz Julienne wrote:
> > From: Dave Stevenson <dave.stevenson@raspberrypi.org>
> >=20
> > Fixes up a checkpatch error "Avoid using bool structure members
> > because of possible alignment issues".
> []
> > diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> > b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> []
> > @@ -1754,7 +1754,7 @@ int vchiq_mmal_component_enable(struct
> > vchiq_mmal_instance *instance,
> > =20
> >  	ret =3D enable_component(instance, component);
> >  	if (ret =3D=3D 0)
> > -		component->enabled =3D true;
> > +		component->enabled =3D 1;
>=20
> This change does not match the commit description.
>=20
> Also, checkpatch does not emit a warning here.

Fair enough I'll drop it for v2.

Regards,
Nicolas


--=-FOp+GqeSI2bnqbVaozq5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7zKk0ACgkQlfZmHno8
x/6Zegf/eT/eppMsIFinxWFgrJmWBBu9iC3muOwrgv74O+kaKnIBS5woWnRQcq6O
dDXD3an0w5+W3ii/d+2xvRfk22sX/GPMYzxyeoKpIY8xvt813ZAq+g28Z8zYTmQi
t+7TIcvSVonEdlEE3gY3E7VNlGplzl8SB+mlnPyApt1y0yGf4ZNyY3s8mLfSSkon
740q+B+2IjMpqo9/JsTffvhWko7qdcxAxf80FpaAPHXEqgh3uuLanTILk0evUQNw
R0reYZeMVJP1CQ8Dh+wcZgFdVBYyeYHTi4+b1q2Y0XJE0CbRdERe1e79VRb22bs6
xDfwtcmNocKWnHHxiv6A0sjm0HSoMg==
=CSKG
-----END PGP SIGNATURE-----

--=-FOp+GqeSI2bnqbVaozq5--

