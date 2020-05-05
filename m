Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46210C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29BAC20675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbgEEPEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:04:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:42574 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729324AbgEEPEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:04:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A99B4AC44;
        Tue,  5 May 2020 15:04:08 +0000 (UTC)
Message-ID: <f28fb56ea214ff95c0a8c1b38cb28cc6390d166e.camel@suse.de>
Subject: Re: [PATCH v2 2/2] usb: xhci: Load Raspberry Pi 4 VL805's firmware
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Matthias Brugger <mbrugger@suse.com>, u-boot@lists.denx.de,
        bmeng.cn@gmail.com, marex@denx.de, linux-kernel@vger.kernel.org
Cc:     sjg@chromium.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com
Date:   Tue, 05 May 2020 17:04:04 +0200
In-Reply-To: <0ca001a3-75c3-e3ba-fc63-17c6b4982856@suse.com>
References: <20200430130433.11248-1-nsaenzjulienne@suse.de>
         <20200430130433.11248-3-nsaenzjulienne@suse.de>
         <0958ece3-feda-65c0-b0e2-893e2dfeb508@suse.com>
         <cefb0be789dba88b3e3ad825fd74f49195110f97.camel@suse.de>
         <38448831-9f22-f887-e938-065fed195414@suse.com>
         <073b80ef4285a02729f5b06872474202d4ff2e3e.camel@suse.de>
         <0ca001a3-75c3-e3ba-fc63-17c6b4982856@suse.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-vdGL3W4Bg/eO2ry47Gmv"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vdGL3W4Bg/eO2ry47Gmv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-05-05 at 16:59 +0200, Matthias Brugger wrote:
[...]
> > > > > > +#ifdef CONFIG_BCM2711
> > > > >=20
> > > > > This won't work with rpi_arm64_defconfig.
> > > > > Can't we just evaluate at runtime if we need to do anything in
> > > > > xhci_pci_fixup.
> > > >=20
> > > > I can't see why, who is going to call xhci_pci_probe() in RPi3?
> > > >=20
> > >=20
> > > If you do make rpi_arm64_defconfig and inspect the .config, you will =
see
> > > that
> > > CONFIG_BCM2711 is not defined, so this code won't be called on RPi4.
> >=20
> > Oh! Understood.
> >=20
> > Well, given that only xhci_pci_probe() is called if we're running on RP=
i4, I
> > think I can disregard those defines altogether. I'll double-check that.
> >=20
>=20
> Yes but from my understanding we only need to call the function on newer
> revisions of RPi4. Does it have any side effect on older revisions, e.g. =
we
> get
> error messages (see below)?

The firmware quirk supports older rpi4s and simply does nothing. Note that =
the
downstream Linux implementation runs this on all rpi4s.

> [...]>>>> I wonder if the newer RPi4 have also a newer revision ID (see
> > > > > get_board_rev).
> > > > > If
> > > > > so we could add another bool to struct rpi_model which will indic=
ate
> > > > > us if
> > > > > we
> > > > > need to notify VideoCore about vl805's firmware.
> > > > >=20
> > > > > > +void xhci_pci_fixup(struct udevice *dev)
> > > > > > +{
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	ret =3D bcm2711_notify_vl805_reset();
> > > > > > +	if (ret)
> > > > > > +		printf("RPI: Failed to notify VideoCore about vl805's
> > > > > > firmware\n");
>=20
> We already have
> printf("bcm2711: Faild to load vl805's firmware, %d\n", ret); in
> bcm2711_notify_vl805_reset(). Do we really need two error messages?

Agree, it's a little redundant. I'll get rid of it.

Regards,
Nicolas



--=-vdGL3W4Bg/eO2ry47Gmv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6xgGQACgkQlfZmHno8
x/5KZgf+JZzFgKU2+xe0hm2qYisgNnULomoi9iRujqc5FSiQSw8g2B83MlOSNsOV
9YJbS4/PyPFd2q/HOIY04FDsEuX1OHjjEzznlCkCUlG0dhFXXz994ZitaVog5qVv
k/AMZih3L5Hh0lo8ug5ZIm5eKPZsTTIIDYQBacT1K/IaetaYIRsNBNSxelMWNfEd
mYVvhCeMvN3AzLjuXNep+UEkfy4sPvLVnlCpM+aQU5Go8pK2CePH+tB0S9xOpROK
p1YIg5/BRRUnr+dQ8RGoWg0LNHK5AmqdpkKq+e7KV6B6mo/0YyMfIrg5BdhGJp6B
XbMfuvHZdUGIxHchhQ/lfKZKwpfkgw==
=HIix
-----END PGP SIGNATURE-----

--=-vdGL3W4Bg/eO2ry47Gmv--

