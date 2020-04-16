Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68EBC2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A440221BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503954AbgDPJgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:36:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:35074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503898AbgDPJgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:36:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 773B5AD0E;
        Thu, 16 Apr 2020 09:36:13 +0000 (UTC)
Message-ID: <aa03258a2db37293b4be56dcd2b3f5f32665c6dc.camel@suse.de>
Subject: Re: [PATCH] ARM: dts: bcm283x: Disable dsi0 node
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Eric Anholt <eric@anholt.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 16 Apr 2020 11:36:11 +0200
In-Reply-To: <CADaigPXwfjd-HoOtBm_fuPQ9eh7AKTaJx+ocLsppPFdL3Cr4jg@mail.gmail.com>
References: <20200415144233.23274-1-nsaenzjulienne@suse.de>
         <CADaigPXwfjd-HoOtBm_fuPQ9eh7AKTaJx+ocLsppPFdL3Cr4jg@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-CzeniVIMWfPwxKpMT9vR"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CzeniVIMWfPwxKpMT9vR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-04-15 at 12:17 -0700, Eric Anholt wrote:
> On Wed, Apr 15, 2020 at 7:42 AM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > Since its inception the module was meant to be disabled by default, but
> > the original commit failed to add the relevant property.
> >=20
> > Fixes: 4aba4cf82054 ("ARM: dts: bcm2835: Add the DSI module nodes and
> > clocks")
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >  arch/arm/boot/dts/bcm283x.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x=
.dtsi
> > index e1abe8c730cef..b83a864e2e8ba 100644
> > --- a/arch/arm/boot/dts/bcm283x.dtsi
> > +++ b/arch/arm/boot/dts/bcm283x.dtsi
> > @@ -372,6 +372,7 @@ dsi0: dsi@7e209000 {
> >                                              "dsi0_ddr2",
> >                                              "dsi0_ddr";
> >=20
> > +                       status =3D "disabled";
> >                 };
>=20
> If you've confirmed that vc4 still probes,

Confirmed.

> Reviewed-by: Eric Anholt <eric@anholt.net>

Thanks,
Nicolas


--=-CzeniVIMWfPwxKpMT9vR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6YJwsACgkQlfZmHno8
x/4N9wgAqYlPDHTVq7kMKPOn6adydtLBBvfMnRHRMQMXIFhdmuET8wrmugAmzy9y
DD67algfoFxdsMWGSIApFa1P0Yh2fkI9Wqe9jUIVdFn8od6P7s4ntl1ifzi//UDJ
BA/iSHNI5AZfeeIarCjijfArnXocnV1qtGC6JypqTtPSXjZW2e3TepNg3WIPTx/W
iw/7W7KOJC7nxFJ3M89ZGJ+GbZmt4Q3dbjX1CS3CeWNzibqTGqBkG+OsUvfOIs12
W31QzmL50Qut49DVLk47tL2KxaMOdUoywRHcq2LYIJiN1cyShGGvt4uh80ITC7aw
EjUyVcq3XKr6b81WqlQz982PVe+0IQ==
=f98w
-----END PGP SIGNATURE-----

--=-CzeniVIMWfPwxKpMT9vR--

