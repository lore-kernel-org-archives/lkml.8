Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE4DC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CFBC2073B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgEENrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:47:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:58614 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728965AbgEENrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:47:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 72CD5ABB2;
        Tue,  5 May 2020 13:47:04 +0000 (UTC)
Message-ID: <073b80ef4285a02729f5b06872474202d4ff2e3e.camel@suse.de>
Subject: Re: [PATCH v2 2/2] usb: xhci: Load Raspberry Pi 4 VL805's firmware
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Matthias Brugger <mbrugger@suse.com>, u-boot@lists.denx.de,
        bmeng.cn@gmail.com, marex@denx.de, linux-kernel@vger.kernel.org
Cc:     sjg@chromium.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com
Date:   Tue, 05 May 2020 15:47:00 +0200
In-Reply-To: <38448831-9f22-f887-e938-065fed195414@suse.com>
References: <20200430130433.11248-1-nsaenzjulienne@suse.de>
         <20200430130433.11248-3-nsaenzjulienne@suse.de>
         <0958ece3-feda-65c0-b0e2-893e2dfeb508@suse.com>
         <cefb0be789dba88b3e3ad825fd74f49195110f97.camel@suse.de>
         <38448831-9f22-f887-e938-065fed195414@suse.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-gTb7tVCY4YQZBYQw8Qwq"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gTb7tVCY4YQZBYQw8Qwq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-05-05 at 15:39 +0200, Matthias Brugger wrote:
>=20
> On 05/05/2020 14:53, Nicolas Saenz Julienne wrote:
> > Hi Matthias,
> >=20
> > On Tue, 2020-05-05 at 14:15 +0200, Matthias Brugger wrote:
> > > On 30/04/2020 15:04, Nicolas Saenz Julienne wrote:
> > > > When needed, RPi4's co-processor (called VideoCore) has to be instr=
ucted
> > > > to load VL805's firmware (the chip providing xHCI support). VideoCo=
re's
> > > > firmware expects the board's PCIe bus to be already configured in o=
rder
> > > > for it to load the xHCI chip firmware. So we have to make sure this
> > > > happens in between the PCIe configuration and xHCI startup.
> > > >=20
> > > > Introduce a callback in xhci_pci_probe() to run this platform speci=
fic
> > > > routine.
> > > >=20
> > > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > >=20
> > > > ---
> > > >=20
> > > > Changes since v1:
> > > >  - Create callback
> > > >=20
> > > >  board/raspberrypi/rpi/rpi.c | 12 ++++++++++++
> > > >  drivers/usb/host/xhci-pci.c |  6 ++++++
> > > >  include/usb/xhci.h          |  3 +++
> > > >  3 files changed, 21 insertions(+)
> > > >=20
> > > > diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rp=
i.c
> > > > index e367ba3092..8aa78d1f48 100644
> > > > --- a/board/raspberrypi/rpi/rpi.c
> > > > +++ b/board/raspberrypi/rpi/rpi.c
> > > > @@ -14,6 +14,7 @@
> > > >  #include <lcd.h>
> > > >  #include <memalign.h>
> > > >  #include <mmc.h>
> > > > +#include <usb/xhci.h>
> > > >  #include <asm/gpio.h>
> > > >  #include <asm/arch/mbox.h>
> > > >  #include <asm/arch/msg.h>
> > > > @@ -494,3 +495,14 @@ int ft_board_setup(void *blob, bd_t *bd)
> > > > =20
> > > >  	return 0;
> > > >  }
> > > > +
> > > > +#ifdef CONFIG_BCM2711
> > >=20
> > > This won't work with rpi_arm64_defconfig.
> > > Can't we just evaluate at runtime if we need to do anything in
> > > xhci_pci_fixup.
> >=20
> > I can't see why, who is going to call xhci_pci_probe() in RPi3?
> >=20
>=20
> If you do make rpi_arm64_defconfig and inspect the .config, you will see =
that
> CONFIG_BCM2711 is not defined, so this code won't be called on RPi4.

Oh! Understood.

Well, given that only xhci_pci_probe() is called if we're running on RPi4, =
I
think I can disregard those defines altogether. I'll double-check that.

Regards,
Nicolas

> Regards,
> Matthias
>=20
> > Regards,
> > Nicolas
> >=20
> > > I wonder if the newer RPi4 have also a newer revision ID (see
> > > get_board_rev).
> > > If
> > > so we could add another bool to struct rpi_model which will indicate =
us if
> > > we
> > > need to notify VideoCore about vl805's firmware.
> > >=20
> > > > +void xhci_pci_fixup(struct udevice *dev)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	ret =3D bcm2711_notify_vl805_reset();
> > > > +	if (ret)
> > > > +		printf("RPI: Failed to notify VideoCore about vl805's
> > > > firmware\n");
> > > > +}
> > > > +#endif
> > > > diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pc=
i.c
> > > > index c1f60da541..1285dde1ef 100644
> > > > --- a/drivers/usb/host/xhci-pci.c
> > > > +++ b/drivers/usb/host/xhci-pci.c
> > > > @@ -11,6 +11,10 @@
> > > >  #include <usb.h>
> > > >  #include <usb/xhci.h>
> > > > =20
> > > > +__weak void xhci_pci_fixup(struct udevice *dev)
> > > > +{
> > > > +}
> > > > +
> > > >  static void xhci_pci_init(struct udevice *dev, struct xhci_hccr
> > > > **ret_hccr,
> > > >  			  struct xhci_hcor **ret_hcor)
> > > >  {
> > > > @@ -40,6 +44,8 @@ static int xhci_pci_probe(struct udevice *dev)
> > > >  	struct xhci_hccr *hccr;
> > > >  	struct xhci_hcor *hcor;
> > > > =20
> > > > +	xhci_pci_fixup(dev);
> > > > +
> > > >  	xhci_pci_init(dev, &hccr, &hcor);
> > > > =20
> > > >  	return xhci_register(dev, hccr, hcor);
> > > > diff --git a/include/usb/xhci.h b/include/usb/xhci.h
> > > > index c16106a2fc..57feed7603 100644
> > > > --- a/include/usb/xhci.h
> > > > +++ b/include/usb/xhci.h
> > > > @@ -16,6 +16,7 @@
> > > >  #ifndef HOST_XHCI_H_
> > > >  #define HOST_XHCI_H_
> > > > =20
> > > > +#include <usb.h>
> > > >  #include <asm/types.h>
> > > >  #include <asm/cache.h>
> > > >  #include <asm/io.h>
> > > > @@ -1281,4 +1282,6 @@ extern struct dm_usb_ops xhci_usb_ops;
> > > > =20
> > > >  struct xhci_ctrl *xhci_get_ctrl(struct usb_device *udev);
> > > > =20
> > > > +extern void xhci_pci_fixup(struct udevice *dev);
> > > > +
> > > >  #endif /* HOST_XHCI_H_ */
> > > >=20


--=-gTb7tVCY4YQZBYQw8Qwq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6xblQACgkQlfZmHno8
x/7l+Af/SDoBVKw5HdpLkFov8Q6yNB39S5R4rQ9T8R5xCY8mTMqyTUBfukTrv4Hs
yRw5KSV4YgH/eNOBiy80CR/MnB4/nSwK1z+Luszqj7c6RCSYzRo0cUVCOhm9FBBg
Be8EdlrL3zjdLEx369R7Tgo7U0pQCwfs3d4CNS/BGSLC6rKPVcmw3otsqWoS8Jqm
Sf3z1PSAv+4FbIoRIyU3Us9i7rCGL/y6yQtvryfeAcXswwWS6QkUcAdwcDa62ft6
OevVpIJY6FFNVHH3FD+q1nE7Hd06pn4XGrCzdE1BGof+hNtaWGmaSp8rHaTbkIE+
vcojpVpRnWt3/5ljveGjZo8nRPNBGw==
=EafC
-----END PGP SIGNATURE-----

--=-gTb7tVCY4YQZBYQw8Qwq--

