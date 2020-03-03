Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCD8C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09252073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbgCCScz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:32:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:53468 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728986AbgCCScy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 13:32:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D161BB259;
        Tue,  3 Mar 2020 18:32:51 +0000 (UTC)
Message-ID: <d706df27ceb8af106f15a328c2ffbe20f62d61c6.camel@suse.de>
Subject: Re: [PATCH] DTS: bcm2711: Move emmc2 into its own bus
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, florian.fainelli@broadcom.com,
        phil@raspberrypi.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 03 Mar 2020 19:32:49 +0100
In-Reply-To: <b1b49120-701c-5ebd-8f2d-fd3c88ff3fac@gmail.com>
References: <20200303120820.4377-1-nsaenzjulienne@suse.de>
         <b1b49120-701c-5ebd-8f2d-fd3c88ff3fac@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-RFl3Qiw92Rz2LT1BjykV"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RFl3Qiw92Rz2LT1BjykV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Tue, 2020-03-03 at 10:21 -0800, Florian Fainelli wrote:
> On 3/3/20 4:08 AM, Nicolas Saenz Julienne wrote:
> > Depending on bcm2711's revision its emmc2 controller might have
> > different DMA constraints. Raspberry Pi 4's firmware will take care of
> > updating those, but only if a certain alias is found in the device tree=
.
> > So, move emmc2 into its own bus, so as not to pollute other devices wit=
h
> > dma-ranges changes and create the emmc2bus alias.
> >=20
> > Based in Phil ELwell's downstream implementation.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>=20
> Nit: the subject should be ARM: dts: bcm2711. Some more comments below.

Of course, should have known better.

> > ---
> >  arch/arm/boot/dts/bcm2711-rpi-4-b.dts |  1 +
> >  arch/arm/boot/dts/bcm2711.dtsi        | 19 ++++++++++++++-----
> >  2 files changed, 15 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> > b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> > index 1d4b589fe233..e26ea9006378 100644
> > --- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> > +++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> > @@ -20,6 +20,7 @@ memory@0 {
> >  	};
> > =20
> >  	aliases {
> > +		emmc2bus =3D &emmc2bus;
> >  		ethernet0 =3D &genet;
> >  		pcie0 =3D &pcie0;
> >  	};
> > diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711=
.dtsi
> > index d1e684d0acfd..61ea8b44c51e 100644
> > --- a/arch/arm/boot/dts/bcm2711.dtsi
> > +++ b/arch/arm/boot/dts/bcm2711.dtsi
> > @@ -241,17 +241,26 @@ pwm1: pwm@7e20c800 {
> >  			status =3D "disabled";
> >  		};
> > =20
> > +		hvs@7e400000 {
> > +			interrupts =3D <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
> > +		};
> > +	};
> > +
> > +	emmc2bus: emmc2bus {
> > +		compatible =3D "simple-bus";
> > +		#address-cells =3D <2>;
> > +		#size-cells =3D <1>;
> > +
> > +		ranges =3D <0x0 0x7e000000  0x0 0xfe000000  0x01800000>;
> > +		dma-ranges =3D <0x0 0xc0000000  0x0 0x00000000  0x40000000>;
>=20
> This deserves a comment for two reasons:
>=20
> - explaining which of these properties is getting patched by the
> firmware (and it would be really nice if we had a concept of annotation
> attributes for Device Tree such that you could express something like:
>=20
> 	dma-ranges =3D <> __patchable;

Something like this would've been useful to me some time ago while debuggin=
g
CMA issues on a random arm64 Board. I was left wondering if the memory node=
s on
that specific board were set in stone or just a placeholder.

> - explaining why this is not collapsed in the soc bus node, because the
> dma-ranges constraint can be different based on the Pi4 revision

Noted

> With that fixed, this looks good to me!

Thanks!

>=20
> > +
> >  		emmc2: emmc2@7e340000 {
> >  			compatible =3D "brcm,bcm2711-emmc2";
> > -			reg =3D <0x7e340000 0x100>;
> > +			reg =3D <0x0 0x7e340000 0x100>;
> >  			interrupts =3D <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
> >  			clocks =3D <&clocks BCM2711_CLOCK_EMMC2>;
> >  			status =3D "disabled";
> >  		};
> > -
> > -		hvs@7e400000 {
> > -			interrupts =3D <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
> > -		};
> >  	};
> > =20
> >  	arm-pmu {
> >=20
>=20
>=20


--=-RFl3Qiw92Rz2LT1BjykV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5eotEACgkQlfZmHno8
x/65SQgAjizh4jYhQUUdPkHWpK1vmzYwARYZ9gDu0tyF+J26+4j7LFgytfLPEUMg
JHjH0xmFXW7cG80ISt2NxRInXjq/eaFytgby5zsBxG1DJhspUYn2zBb7VXWDevZ2
FHWjiKw2adk6mzNkO4sNG4P/D9WTtUlSvwAFDuNvsHEV8kUmtIldA6iItq4Xtyg6
BgojLHH0tqNjzdDeB0aOFaDXJMM7svxHiupbP0Li50uQByQgGoxiwsOVt2SBBdFa
qa6ucFjQstOAn207YYZeAYZinMZaMa0K1+0VeQ/SuVsUCNHCavKLkl4c7JEqixUR
TrQHZbzYvV//fJJISCqUAFBpdMNnTg==
=9Zb+
-----END PGP SIGNATURE-----

--=-RFl3Qiw92Rz2LT1BjykV--

