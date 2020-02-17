Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91849C3402B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7339420836
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgBQTjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 14:39:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:51422 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729625AbgBQTjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 14:39:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D108CAC53;
        Mon, 17 Feb 2020 19:39:08 +0000 (UTC)
Message-ID: <8b50c93b2556413ce2736e18e939f1b376bf48c7.camel@suse.de>
Subject: Re: [PATCH] usb: xhci-pci: Raspberry Pi FW loader for VIA VL805
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     tim.gover@raspberrypi.org, oneukum@suse.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 17 Feb 2020 20:39:06 +0100
In-Reply-To: <bf77d351-ca8c-d9fd-e5ea-71441ac00ab3@i2se.com>
References: <20200217100701.19949-1-nsaenzjulienne@suse.de>
         <bf77d351-ca8c-d9fd-e5ea-71441ac00ab3@i2se.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ogkfL5d9U8ZLHgULSlCK"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ogkfL5d9U8ZLHgULSlCK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-02-17 at 18:47 +0100, Stefan Wahren wrote:
> > +
> > +	dev_addr =3D pdev->bus->number << 20 | PCI_SLOT(pdev->devfn) << 15 |
> > +		   PCI_FUNC(pdev->devfn) << 12;
> > +
> > +	ret =3D rpi_firmware_property(fw, RPI_FIRMWARE_NOTIFY_XHCI_RESET,
> > +				    &dev_addr, sizeof(dev_addr));
> > +	if (ret)
> > +		return ret;
> not sure, but there could be a corner case which should be handled
> differently. In case the Raspberry Pi 4 has an EEPROM for the VL805
> firmware but the firmware is too old to handle
> RPI_FIRMWARE_NOTIFY_XHCI_RESET, we should return with 0. I don't know
> there is a change to detect this reliable. I just want to mention this.

Ouch, good point, that can be problematic. I'll test that scenario tomorrow=
.

> > diff --git a/include/soc/bcm2835/raspberrypi-firmware.h
> > b/include/soc/bcm2835/raspberrypi-firmware.h
> > index 7800e12ee042..cc9cdbc66403 100644
> > --- a/include/soc/bcm2835/raspberrypi-firmware.h
> > +++ b/include/soc/bcm2835/raspberrypi-firmware.h
> > @@ -90,7 +90,7 @@ enum rpi_firmware_property_tag {
> >  	RPI_FIRMWARE_SET_PERIPH_REG =3D                         0x00038045,
> >  	RPI_FIRMWARE_GET_POE_HAT_VAL =3D                        0x00030049,
> >  	RPI_FIRMWARE_SET_POE_HAT_VAL =3D                        0x00030050,
> > -
> > +	RPI_FIRMWARE_NOTIFY_XHCI_RESET =3D                      0x00030058,
>=20
> In past we updated the firmware mailbox property interface in a bunch as
> a separate patch. So we can avoid those gaps.

Ok, I'll change that.

Regards,
Nicolas


--=-ogkfL5d9U8ZLHgULSlCK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5K69oACgkQlfZmHno8
x/564ggAnRR3cI7WWFgxYpBmwwEU6WnQinv4UaaIe0w5g4vjvt8UjgnypPpwGlBI
qqVXlFsvzR1pXNyTDZcjdzkqmYekgCaR4+0ONPYL+ofhQ3SeYg/FwsVgkWTcE0SQ
FmiQRIDZk9qYF1UV5ABz0dPTvD3nBjNEN5+1s2Ti6hjSIb3OIVH/DgsxSUIQfvaK
iL1+4ikVfvckbDrBG/PnCsCfxoiTfQWMC/QoUZROSsO4NVBFojLwyK0nDA+O9k8R
6N/1OMUoJOCzjW27KZ3vUuKf2Vc3pu4UgfPXEY4oeWpAF+5055DHaJBrYDQopEzE
0sJWKha2D5TpFR9/StcAUyp2secwOw==
=+vmi
-----END PGP SIGNATURE-----

--=-ogkfL5d9U8ZLHgULSlCK--

