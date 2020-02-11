Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D40FC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E93A20714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgBKKDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 05:03:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:55194 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728073AbgBKKDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:03:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D3190B150;
        Tue, 11 Feb 2020 10:02:57 +0000 (UTC)
Message-ID: <28f7ea832ead04dd93cd582480fb946604bb407d.camel@suse.de>
Subject: Re: [PATCH] usb: xhci: Enable LPM for VIA LABS VL805
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 11 Feb 2020 11:02:55 +0100
In-Reply-To: <19e1d141-2033-782f-e5a3-dcba6bdc0a8a@i2se.com>
References: <20200120142422.3907-1-nsaenzjulienne@suse.de>
         <20200210185921.GA1058087@kroah.com>
         <1478f170-f0ec-96df-79cf-f7c44bebc290@linux.intel.com>
         <19e1d141-2033-782f-e5a3-dcba6bdc0a8a@i2se.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-4mJyqWT1X0J6LlfdjyE7"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4mJyqWT1X0J6LlfdjyE7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan, Mathias.

On Tue, 2020-02-11 at 10:49 +0100, Stefan Wahren wrote:
> Hi Mathias,
>=20
> On 11.02.20 10:34, Mathias Nyman wrote:
> > On 10.2.2020 20.59, Greg Kroah-Hartman wrote:
> > > On Mon, Jan 20, 2020 at 03:24:22PM +0100, Nicolas Saenz Julienne wrot=
e:
> > > > This PCIe controller chip is used on the Raspberry Pi 4 and multipl=
e
> > > > adapter cards. There is no publicly available documentation for the
> > > > chip, yet both the downstream RPi4 kernel and the controller cards
> > > > support/advertise LPM support.
> > > >=20
> > > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > > ---
> > > >  drivers/usb/host/xhci-pci.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >=20
> > > > diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pc=
i.c
> > > > index 4917c5b033fa..c1976e98992b 100644
> > > > --- a/drivers/usb/host/xhci-pci.c
> > > > +++ b/drivers/usb/host/xhci-pci.c
> > > > @@ -241,6 +241,9 @@ static void xhci_pci_quirks(struct device *dev,
> > > > struct xhci_hcd *xhci)
> > > >  			pdev->device =3D=3D 0x3432)
> > > >  		xhci->quirks |=3D XHCI_BROKEN_STREAMS;
> > > > =20
> > > > +	if (pdev->vendor =3D=3D PCI_VENDOR_ID_VIA && pdev->device =3D=3D =
0x3483)
> > > > +		xhci->quirks |=3D XHCI_LPM_SUPPORT;
> > > > +
> > > >  	if (pdev->vendor =3D=3D PCI_VENDOR_ID_ASMEDIA &&
> > > >  			pdev->device =3D=3D 0x1042)
> > > >  		xhci->quirks |=3D XHCI_BROKEN_STREAMS;
> > > Mathias, is this in your review queue?
> > >=20
> > Ah yes, before adding link power management support for this controller=
 we
> > should check that it has sane (or any) exit latency values set in its
> > HCSPARAMS3 capability register.

I did some checks myself before sending the patch, and tested with some dev=
ices
I own. The latencies seemd reasonable. For example I just hooked up an USB3=
 HD,
the root HUB exposes:

	bU1DevExitLat           4 micro seconds
	bU2DevExitLat         231 micro seconds

And xhci configured the device with:

	bU1DevExitLat          10 micro seconds
	bU2DevExitLat        2047 micro seconds

> > Nicolas, if you have this controller could you show the capability
> > registers:
> >=20
> > cat /sys/kernel/debug/usb/xhci/*/reg-cap

CAPLENGTH =3D 0x01000020
HCSPARAMS1 =3D 0x05000420
HCSPARAMS2 =3D 0xfc000031
HCSPARAMS3 =3D 0x00e70004
HCCPARAMS1 =3D 0x002841eb
DOORBELLOFF =3D 0x00000100
RUNTIMEOFF =3D 0x00000200
HCCPARAMS2 =3D 0x00000000

> sorry for the naive question, but do you need the dump with or without
> this patch applied?

IIRC these are dumps from xhci's extended registers. Shouldn't matter at al=
l.=20

Regards,
Nicolas


--=-4mJyqWT1X0J6LlfdjyE7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5Ce88ACgkQlfZmHno8
x/7F9Qf+KWPtMeGt4zPdB2ls5zaDGQPrv3QRvhIdmu/ovQXjdcwOghNJtYpYtfod
p75/dlkegGgfNF+6nlZSMydSAPlvy1/stxk12OhPASHLTA2knxSOUhlfmX82PC4P
AGcGqCC7mXzeqYh4Bw1+MUkHHjNivZEOGswGkzZ8j6g/DabCEyMgByoYl1/G+hdM
REqOtzfuxCQF+2BJLyRC7LHBO42cOLg2vGz+whF6PjmkSBJEr8MUGlOuCrtpJP2g
ajtbxF8u7DcL+cI4m48gpIiWP/TPVb4qJOJ3B2/qKjO8NcXPveo08DGa/sy8wcDg
8wicmtAbbG37PAVtD0R2XUmBnWudbw==
=9y0c
-----END PGP SIGNATURE-----

--=-4mJyqWT1X0J6LlfdjyE7--

