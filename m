Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FE0C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 11:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3C820801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 11:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgBQLMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 06:12:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:48004 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbgBQLMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 06:12:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0CB5EB05D;
        Mon, 17 Feb 2020 11:12:45 +0000 (UTC)
Message-ID: <9d3a870fdd71fd2ed5a4a5992b2dd39388eaedd5.camel@suse.de>
Subject: Re: [PATCH] usb: xhci-pci: Raspberry Pi FW loader for VIA VL805
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, oneukum@suse.com,
        phil@raspberrypi.com, tim.gover@raspberrypi.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 17 Feb 2020 12:12:42 +0100
In-Reply-To: <20200217103605.GA93732@kroah.com>
References: <20200217100701.19949-1-nsaenzjulienne@suse.de>
         <20200217103605.GA93732@kroah.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-XZFCLbgsBknBnaLkhP22"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XZFCLbgsBknBnaLkhP22
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg, thanks for having a look at this.

On Mon, 2020-02-17 at 11:36 +0100, Greg Kroah-Hartman wrote:

[...]

> > +#include <soc/bcm2835/raspberrypi-firmware.h>
>=20
> That feels really wrong :(

I know, not that happy about it either, but I had to start with something :=
)

> > +
> >  #include "xhci.h"
> >  #include "xhci-trace.h"
> > =20
> > @@ -308,6 +310,44 @@ static int xhci_pci_setup(struct usb_hcd *hcd)
> >  	return xhci_pci_reinit(xhci, pdev);
> >  }
> > =20
> > +/*
> > + * On the Raspberry Pi 4, after a PCI reset, VL805's firmware may eith=
er be
> > + * loaded directly from an EEPROM or, if not present, by the SoC's
> > VideCore.
> > + * Inform VideCore that VL805 was just reset, or defer xhci's probe if=
 not
> > yet
> > + * joinable trough the mailbox interface.
> > + */
> > +static int raspberrypi_load_vl805_fw(struct pci_dev *pdev)
> > +{
> > +#ifdef CONFIG_RASPBERRYPI_FIRMWARE
>=20
> Can you just put #ifdefs in a .h file instead please?

Yes, although...

> > +	struct device_node *fw_np;
> > +	struct rpi_firmware *fw;
> > +	u32 dev_addr;
> > +	int ret;
> > +
> > +	fw_np =3D of_find_compatible_node(NULL, NULL,
> > +					"raspberrypi,bcm2835-firmware");
> > +	if (!fw_np)
> > +		return 0;
>=20
> So for non-rpi systems, this will work just fine, no need to #ifdef out
> the whole function, right?

...you're right here, on non-rpi systems this will just return without erro=
rs.
On top of that, most VL805 users don't use device-tree, so it'll be fast.

> > +
> > +	fw =3D rpi_firmware_get(fw_np);
> > +	of_node_put(fw_np);
> > +	if (!fw)
> > +		return -EPROBE_DEFER;
> > +
> > +	dev_addr =3D pdev->bus->number << 20 | PCI_SLOT(pdev->devfn) << 15 |
> > +		   PCI_FUNC(pdev->devfn) << 12;
> > +
> > +	ret =3D rpi_firmware_property(fw, RPI_FIRMWARE_NOTIFY_XHCI_RESET,
> > +				    &dev_addr, sizeof(dev_addr));
> > +	if (ret)
> > +		return ret;
> > +
> > +	dev_dbg(&pdev->dev, "loaded Raspberry Pi's VL805 firmware\n");
> > +
> > +#endif
> > +	return 0;
> > +}

> Why not put this whole function in some rpi-platform code?

I think moving it into firmware/raspberrypi.c should be acceptable. That sa=
id
I'd still be on the loose regarding the include file, and the platform spec=
ific
function call in xhci_pci_probe(). Any suggestions?
Note that it's important to us to be able to defer the probe as the firmwar=
e
inteface bringup might race with xHC's

> > +
> >  /*
> >   * We need to register our own PCI probe function (instead of the USB
> > core's
> >   * function) in order to create a second roothub under xHCI.
> > @@ -321,6 +361,16 @@ static int xhci_pci_probe(struct pci_dev *dev, con=
st
> > struct pci_device_id *id)
> > =20
> >  	driver =3D (struct hc_driver *)id->driver_data;
> > =20
> > +	if (dev->vendor =3D=3D PCI_VENDOR_ID_VIA && dev->device =3D=3D 0x3483=
) {
> > +		retval =3D raspberrypi_load_vl805_fw(dev);
> > +		if (retval) {
> > +			if (retval !=3D -EPROBE_DEFER)
> > +				dev_err(&dev->dev,
> > +					"Failed to load VL805's firmware");
>=20
> Shouldn't the function print an error if there is one?

Noted, I'll update that.

Regards,
Nicolas


--=-XZFCLbgsBknBnaLkhP22
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5KdSoACgkQlfZmHno8
x/6d/Af5AT5S0Pwl8xDlumP0TchdnzD/yXqk8Z3/Ysr8N+PeZKeXQpprFdma2otT
z3axXIyIc2syYEscAQUqge9eKMfgHPBbsCSPICAEl00hQysxFxPmc1kJlhzxkN+F
6p3LRnzdUgVWGoc8ZMfym6EFVOlVcmQWqYKa4XaNhyhMIIMr0c5xfW2GSXpMFsNj
ZtKXzOkDVUdeD7bAZKXELiQL/O3Kgqaut8Wm4F3ux9qTTxLv8WhWNk/dIOrwIpfm
4zy6GgZ2zmr+3rP0JNXqSujyjh9ZYj2cuJ75c/JeRzVa5r4b5ARhZ64F5ZpP+slW
q5LpISI31g/y0STz1WxFgvLwttMljg==
=QcVm
-----END PGP SIGNATURE-----

--=-XZFCLbgsBknBnaLkhP22--

