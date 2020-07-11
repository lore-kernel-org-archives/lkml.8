Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCD7C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 13:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 652512065D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 13:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgGKNsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 09:48:18 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:35894 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgGKNsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 09:48:18 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5D1471C0BD2; Sat, 11 Jul 2020 15:48:15 +0200 (CEST)
Date:   Sat, 11 Jul 2020 15:48:14 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, dmurphy@ti.com,
        jacek.anaszewski@gmail.com, vishwa@linux.ibm.com
Subject: Re: [PATCH 1/2] dt-bindings: leds: pca955x: Add IBM implementation
 compatible string
Message-ID: <20200711134814.GB6407@amd>
References: <20200709201220.13736-1-eajames@linux.ibm.com>
 <20200709201220.13736-2-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
In-Reply-To: <20200709201220.13736-2-eajames@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> IBM created an implementation of the PCA9552 on a PIC16F
> microcontroller. Document the new compatible string for this device.

Is the implementation opensource?

> Signed-off-by: Eddie James <eajames@linux.ibm.com>

> +++ b/Documentation/devicetree/bindings/leds/leds-pca955x.txt
> @@ -9,6 +9,7 @@ Required properties:
>  	"nxp,pca9550"
>  	"nxp,pca9551"
>  	"nxp,pca9552"
> +	"nxp,pca9552-ibm"
>  	"nxp,pca9553"

Is it good idea to use nxp prefix for something that is
software-defined and not built by nxp?

Would ibm,pca9552 be better, or maybe even sw,pca9552 to indicate that
is not real hardware, but software emulation?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8Jwx4ACgkQMOfwapXb+vIgMACgolyJryoAUGrvtZYcbrqprmGv
rqgAn3oROytMSB/cAB9QLxtzJcFvZc3z
=tTZV
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
