Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28D0C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92EE4206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgEEMx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 08:53:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:52402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728939AbgEEMxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 08:53:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 661D1AB3D;
        Tue,  5 May 2020 12:53:24 +0000 (UTC)
Message-ID: <cefb0be789dba88b3e3ad825fd74f49195110f97.camel@suse.de>
Subject: Re: [PATCH v2 2/2] usb: xhci: Load Raspberry Pi 4 VL805's firmware
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Matthias Brugger <mbrugger@suse.com>, u-boot@lists.denx.de,
        bmeng.cn@gmail.com, marex@denx.de, linux-kernel@vger.kernel.org
Cc:     sjg@chromium.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com
Date:   Tue, 05 May 2020 14:53:19 +0200
In-Reply-To: <0958ece3-feda-65c0-b0e2-893e2dfeb508@suse.com>
References: <20200430130433.11248-1-nsaenzjulienne@suse.de>
         <20200430130433.11248-3-nsaenzjulienne@suse.de>
         <0958ece3-feda-65c0-b0e2-893e2dfeb508@suse.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-QXkzHcpzhKgpjEe8/7nY"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QXkzHcpzhKgpjEe8/7nY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthias,

On Tue, 2020-05-05 at 14:15 +0200, Matthias Brugger wrote:
>=20
> On 30/04/2020 15:04, Nicolas Saenz Julienne wrote:
> > When needed, RPi4's co-processor (called VideoCore) has to be instructe=
d
> > to load VL805's firmware (the chip providing xHCI support). VideoCore's
> > firmware expects the board's PCIe bus to be already configured in order
> > for it to load the xHCI chip firmware. So we have to make sure this
> > happens in between the PCIe configuration and xHCI startup.
> >=20
> > Introduce a callback in xhci_pci_probe() to run this platform specific
> > routine.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> >=20
> > ---
> >=20
> > Changes since v1:
> >  - Create callback
> >=20
> >  board/raspberrypi/rpi/rpi.c | 12 ++++++++++++
> >  drivers/usb/host/xhci-pci.c |  6 ++++++
> >  include/usb/xhci.h          |  3 +++
> >  3 files changed, 21 insertions(+)
> >=20
> > diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> > index e367ba3092..8aa78d1f48 100644
> > --- a/board/raspberrypi/rpi/rpi.c
> > +++ b/board/raspberrypi/rpi/rpi.c
> > @@ -14,6 +14,7 @@
> >  #include <lcd.h>
> >  #include <memalign.h>
> >  #include <mmc.h>
> > +#include <usb/xhci.h>
> >  #include <asm/gpio.h>
> >  #include <asm/arch/mbox.h>
> >  #include <asm/arch/msg.h>
> > @@ -494,3 +495,14 @@ int ft_board_setup(void *blob, bd_t *bd)
> > =20
> >  	return 0;
> >  }
> > +
> > +#ifdef CONFIG_BCM2711
>=20
> This won't work with rpi_arm64_defconfig.
> Can't we just evaluate at runtime if we need to do anything in xhci_pci_f=
ixup.

I can't see why, who is going to call xhci_pci_probe() in RPi3?

Regards,
Nicolas

> I wonder if the newer RPi4 have also a newer revision ID (see get_board_r=
ev).
> If
> so we could add another bool to struct rpi_model which will indicate us i=
f we
> need to notify VideoCore about vl805's firmware.
>=20
> > +void xhci_pci_fixup(struct udevice *dev)
> > +{
> > +	int ret;
> > +
> > +	ret =3D bcm2711_notify_vl805_reset();
> > +	if (ret)
> > +		printf("RPI: Failed to notify VideoCore about vl805's
> > firmware\n");
> > +}
> > +#endif
> > diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> > index c1f60da541..1285dde1ef 100644
> > --- a/drivers/usb/host/xhci-pci.c
> > +++ b/drivers/usb/host/xhci-pci.c
> > @@ -11,6 +11,10 @@
> >  #include <usb.h>
> >  #include <usb/xhci.h>
> > =20
> > +__weak void xhci_pci_fixup(struct udevice *dev)
> > +{
> > +}
> > +
> >  static void xhci_pci_init(struct udevice *dev, struct xhci_hccr **ret_=
hccr,
> >  			  struct xhci_hcor **ret_hcor)
> >  {
> > @@ -40,6 +44,8 @@ static int xhci_pci_probe(struct udevice *dev)
> >  	struct xhci_hccr *hccr;
> >  	struct xhci_hcor *hcor;
> > =20
> > +	xhci_pci_fixup(dev);
> > +
> >  	xhci_pci_init(dev, &hccr, &hcor);
> > =20
> >  	return xhci_register(dev, hccr, hcor);
> > diff --git a/include/usb/xhci.h b/include/usb/xhci.h
> > index c16106a2fc..57feed7603 100644
> > --- a/include/usb/xhci.h
> > +++ b/include/usb/xhci.h
> > @@ -16,6 +16,7 @@
> >  #ifndef HOST_XHCI_H_
> >  #define HOST_XHCI_H_
> > =20
> > +#include <usb.h>
> >  #include <asm/types.h>
> >  #include <asm/cache.h>
> >  #include <asm/io.h>
> > @@ -1281,4 +1282,6 @@ extern struct dm_usb_ops xhci_usb_ops;
> > =20
> >  struct xhci_ctrl *xhci_get_ctrl(struct usb_device *udev);
> > =20
> > +extern void xhci_pci_fixup(struct udevice *dev);
> > +
> >  #endif /* HOST_XHCI_H_ */
> >=20


--=-QXkzHcpzhKgpjEe8/7nY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6xYb8ACgkQlfZmHno8
x/6I5Af8CZzY9nHkglF0QKY8BEoLvmIMJML83av1FG31bB4ishW+CXUM8LDfGno7
lTEusyV8pGmZmcXPAU5sUSUgqLoV2bOsuQRW3pAvMdaLliwUeevZT+NeIzMmoGpA
rImAx8Obcato9gtIfbiETFvLX2KU/dh74Yu/YrYxwdZ+EiiIXQuEU8ER1kDZ+dgM
tj+BVTMgpIVESzBVDm2bY5bvFIAjzIt07R2KYkYcVR8EbVfRW2osHWDfm4Ym02bQ
WhT8W1rfoU3opqdBmkGWRspiRlRg7rWcovKIpuq6P+AF5b+0GjYqBGVVY4143tZ8
7a8tw0SleKIzLluzO1N4jJHYyzIFAA==
=mq7+
-----END PGP SIGNATURE-----

--=-QXkzHcpzhKgpjEe8/7nY--

