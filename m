Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C27C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 20:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B7C20674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 20:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgHQUZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 16:25:13 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:39384 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgHQUZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 16:25:12 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B40CA1C0BB6; Mon, 17 Aug 2020 22:25:08 +0200 (CEST)
Date:   Mon, 17 Aug 2020 22:25:08 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Rob Herring <robh@kernel.org>
Cc:     Eddie James <eajames@linux.ibm.com>, vishwa@linux.ibm.com,
        andy.shevchenko@gmail.com, robh+dt@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmurphy@ti.com,
        jacek.anaszewski@gmail.com
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: pca955x: Add IBM
 implementation compatible string
Message-ID: <20200817202508.GA13123@amd>
References: <20200803145055.5203-1-eajames@linux.ibm.com>
 <20200803145055.5203-2-eajames@linux.ibm.com>
 <20200812195747.GA2605701@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20200812195747.GA2605701@bogus>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2020-08-12 13:57:47, Rob Herring wrote:
> On Mon, 03 Aug 2020 09:50:54 -0500, Eddie James wrote:
> > IBM created an implementation of the PCA9552 on a PIC16F
> > microcontroller. Document the new compatible string for this device.
> >=20
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > ---
> >  Documentation/devicetree/bindings/leds/leds-pca955x.txt | 1 +
> >  1 file changed, 1 insertion(+)
>=20
> Acked-by: Rob Herring <robh@kernel.org>

Thanks, I applied the series.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8656QACgkQMOfwapXb+vJ/vgCggeE9wN9rcZ//IBVRvJwgJupz
L5cAoKKJ85ZMJGg6Sf/GbCNP2talpcIQ
=wI1t
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
