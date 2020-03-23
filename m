Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA3FC54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7996D2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgCWKmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 06:42:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:49936 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727908AbgCWKmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 06:42:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4C44FAEDA;
        Mon, 23 Mar 2020 10:42:20 +0000 (UTC)
Message-ID: <fc5bcca4feed54de243b3e24228ef1ad99430c4c.camel@suse.de>
Subject: Re: [PATCH v2 12/12] dt-bindings: arm: bcm: Convert BCM2835
 firmware binding to YAML
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Vinod Koul <vkoul@kernel.org>,
        "james.tai" <james.tai@realtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Date:   Mon, 23 Mar 2020 11:42:16 +0100
In-Reply-To: <20200323084044.dziwbk7pugoy73yh@gilmour.lan>
References: <20200204235552.7466-1-f.fainelli@gmail.com>
         <20200204235552.7466-13-f.fainelli@gmail.com>
         <20200206192333.GA30325@bogus>
         <47e12841-d9bb-3204-76c0-5bc0ef74b094@gmail.com>
         <20200323084044.dziwbk7pugoy73yh@gilmour.lan>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-RpMYkWCESsJPGDcne0PU"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RpMYkWCESsJPGDcne0PU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-03-23 at 09:40 +0100, Maxime Ripard wrote:
> Hi Florian,
>=20
> On Sun, Mar 22, 2020 at 02:35:17PM -0700, Florian Fainelli wrote:
> >=20
> > On 2/6/2020 11:23 AM, Rob Herring wrote:
> > > On Tue, Feb 04, 2020 at 03:55:52PM -0800, Florian Fainelli wrote:
> > > > Convert the Raspberry Pi BCM2835 firmware binding document to YAML.
> > > > Verified with dt_binding_check and dtbs_check.
> > > >=20
> > > > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > > > ---
> > > >  .../arm/bcm/raspberrypi,bcm2835-firmware.txt  | 14 --------
> > > >  .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 33 +++++++++++++++=
++++
> > > >  2 files changed, 33 insertions(+), 14 deletions(-)
> > > >  delete mode 100644
> > > > Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-
> > > > firmware.txt
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-
> > > > firmware.yaml
> > > >=20
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-
> > > > firmware.txt
> > > > b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-
> > > > firmware.txt
> > > > deleted file mode 100644
> > > > index 6824b3180ffb..000000000000
> > > > --- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835=
-
> > > > firmware.txt
> > > > +++ /dev/null
> > > > @@ -1,14 +0,0 @@
> > > > -Raspberry Pi VideoCore firmware driver
> > > > -
> > > > -Required properties:
> > > > -
> > > > -- compatible:		Should be "raspberrypi,bcm2835-firmware"
> > > > -- mboxes:		Phandle to the firmware device's Mailbox.
> > > > -			  (See: ../mailbox/mailbox.txt for more
> > > > information)
> > > > -
> > > > -Example:
> > > > -
> > > > -firmware {
> > > > -	compatible =3D "raspberrypi,bcm2835-firmware";
> > > > -	mboxes =3D <&mailbox>;
> > > > -};
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-
> > > > firmware.yaml
> > > > b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-
> > > > firmware.yaml
> > > > new file mode 100644
> > > > index 000000000000..db355d970f2b
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835=
-
> > > > firmware.yaml
> > > > @@ -0,0 +1,33 @@
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +%YAML 1.2
> > > > +---
> > > > +$id:=20
> > > > http://devicetree.org/schemas/arm/bcm/raspberrypi,bcm2835-firmware.=
yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Raspberry Pi VideoCore firmware driver
> > > > +
> > > > +maintainers:
> > > > +  - Eric Anholt <eric@anholt.net>
> > > > +  - Stefan Wahren <wahrenst@gmx.net>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: raspberrypi,bcm2835-firmware simple-bus
> > >                                           ^
> > >=20
> > > I need to check for spaces with the meta-schema...
> >=20
> > I believe I had tried to use:
> >=20
> > const: raspberrypi,bcm2835-firmware
> > const: simple-bus
> >=20
> > but this did not work, and I had to resort to doing this.
>=20
> That would be:
>=20
> compatible:
>   items:
>     - const: raspberrypi,bcm2835-firmware
>     - const: simple-bus
>=20
> It changes slightly from what the initial binding was saying though,
> since it wasn't mentionning simple-bus at all? Is that on purpose?

I guess we failed to update the binding after starting to use the firmware
device as a bus.


--=-RpMYkWCESsJPGDcne0PU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl54kogACgkQlfZmHno8
x/6Oxwf/RxCalW3P6O6N4jDFJcvvMOR8hT0bzENJf8exug8nu2upzGFR9cp5rgvy
nIuAsApBBpQ7BBIaD/Quv6256Qx5iYLAZGxbDMXhUwI7FyLiPJtf4Xgy6N1JVxrI
KSxJVwYzKAqYvT0C8hEtcOYilaGkLv8uvoK/gN1x1zNYUZil304HblPxudfJUqb4
/EDOh3y8ZL53j+7GQLp512aIF82mtD5m1Kvh7PqJSW41iqdQHW709Fw/lY+WoqHf
8lRgpMAmDMxiw6rNLasp0M4CmTowgbE3FwjltqJdgykk1upD3GQXDbKkxoIVIzqZ
gXEUdkyF5HlKG1wbYsTgqC6+vSnZiw==
=I9aD
-----END PGP SIGNATURE-----

--=-RpMYkWCESsJPGDcne0PU--

