Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74953C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5370120578
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgC0Klv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 06:41:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:43100 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgC0Klv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:41:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 14AAAAFB2;
        Fri, 27 Mar 2020 10:41:48 +0000 (UTC)
Message-ID: <0498ff6f39f77750c112a770e56f0beb201446a0.camel@suse.de>
Subject: Re: [PATCH] ARM: dts: bcm283x: Use firmware PM driver for V3D
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>
Cc:     devicetree@vger.kernel.org, Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        wahrenst@gmx.net, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Date:   Fri, 27 Mar 2020 11:41:46 +0100
In-Reply-To: <4239bf44-1a2d-09c4-fc1b-186955c062ab@gmail.com>
References: <20200303173217.3987-1-nsaenzjulienne@suse.de>
         <24f850f64b5c71c71938110775e16caaec2811cc.camel@suse.de>
         <8c2bdd83-c8a9-7ba8-8d61-69594e6a2bde@i2se.com>
         <4239bf44-1a2d-09c4-fc1b-186955c062ab@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-gzrfjv0pONOImR3jIMys"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gzrfjv0pONOImR3jIMys
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-03-26 at 17:35 -0700, Florian Fainelli wrote:
>=20
> On 3/26/2020 10:24 AM, Stefan Wahren wrote:
> > Am 26.03.20 um 13:24 schrieb Nicolas Saenz Julienne:
> > > Hi Stefan and Florian,
> > >=20
> > > On Tue, 2020-03-03 at 18:32 +0100, Nicolas Saenz Julienne wrote:
> > > > The register based driver turned out to be unstable, specially on R=
Pi3a+
> > > > but not limited to it. While a fix is being worked on, we roll back=
 to
> > > > using firmware based scheme.
> > > >=20
> > > > Fixes: e1dc2b2e1bef ("ARM: bcm283x: Switch V3D over to using the PM
> > > > driver
> > > > instead of firmware")
> > > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > > ---
> > > now that the problem Stefan was seeing is being taken care of, I thin=
k
> > > it's
> > > fair to reconsider taking this patch. Maybe even adding a Tested-by b=
y
> > > Stefan?
> >=20
> > after applying "drm/vc4: Fix HDMI mode validation" this commit doesn't
> > cause any regression:
> >=20
> > Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
>=20
> Good, how do you like to see this applied? Do we need to ensure that
> drm/vc4: Fix HDMI mode validation is applied to Linus' tree before
> merging this one? Nicolas, should this be queued for 5.7 or 5.8 (I do
> not think the 5.7 PRs have been merged yet).

Ideally both should be applied in the same time yes. I'm going to prepare a=
n
extra PR for v5.7 today.

Regards,
Nicolas


--=-gzrfjv0pONOImR3jIMys
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl592GoACgkQlfZmHno8
x/4syAf+P2dd4A3mafbrtA3sC1NVo/CmhLWTMxs3oK4Bz/T1Izsmb6kQMRrFQaAN
Q+BJYoadSildwMxEphIiMLMd/DgUcrvQxYNfbnN66J5dTRkKCSI1N8vthrguR5ZT
eARTfnkzzOGkoOVKTeh6IsNDadlP3xM3+z6SsCoAIdGngzjcb43I8go5QL+ZXCFf
jqy13op8m+Vcnluf1VZXhJDHfA6/VNCUUyV6xHUOMrJhoZ+bdPWEsewQj50m9NTx
2+IO/Fe3LcC692M/d+4+/C6qCj593e0+mtN3kJt2/0MkipEDUVjbXX9CKcMojhrp
e+vOQ+De19k3dq3DLwP2RPt88kDCHw==
=L34C
-----END PGP SIGNATURE-----

--=-gzrfjv0pONOImR3jIMys--

