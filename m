Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54B7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8DB6206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFQTPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 15:15:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:60036 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgFQTPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 15:15:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B724AAE2C;
        Wed, 17 Jun 2020 19:15:22 +0000 (UTC)
Message-ID: <954083bf13bd7c24c31c9673269ea0eedb925f43.camel@suse.de>
Subject: Re: [PATCH v4 4/5] dm: pci: Assign controller device node to root
 bridge
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Simon Glass <sjg@chromium.org>
Cc:     Matthias Brugger <mbrugger@suse.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>,
        lk <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>
Date:   Wed, 17 Jun 2020 21:15:16 +0200
In-Reply-To: <CAPnjgZ3PwTWBQ2Vi4=Sc7JB699TrSxr=PAJupL_3POhJ00qSsA@mail.gmail.com>
References: <20200612164632.25648-1-nsaenzjulienne@suse.de>
         <20200612164632.25648-5-nsaenzjulienne@suse.de>
         <CAPnjgZ2jarQArKN=0h0mNnxE7gAL0juvGhMxMF4a0CehqxWcRw@mail.gmail.com>
         <d3346d7cb9655eb111b4126d72a08499c6254fef.camel@suse.de>
         <CAPnjgZ3PwTWBQ2Vi4=Sc7JB699TrSxr=PAJupL_3POhJ00qSsA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-C+TXhUdXAiW5aA7sAVb3"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-C+TXhUdXAiW5aA7sAVb3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-06-16 at 17:31 -0600, Simon Glass wrote:
> Hi Nicolas,
>
> On Tue, 16 Jun 2020 at 08:09, Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > On Tue, 2020-06-16 at 07:43 -0600, Simon Glass wrote:
> > > Hi Nicolas,
> > >
> > > On Fri, 12 Jun 2020 at 10:47, Nicolas Saenz Julienne
> > > <nsaenzjulienne@suse.de> wrote:
> > > > There is no distinction in DT between the PCI controller device and=
 the
> > > > root bridge, whereas such distinction exists from dm's perspective.=
 Make
> > > > sure the root bridge ofnode is assigned to the controller's platfor=
m
> > > > device node.
> > > >
> > > > This permits setups like this to work correctly:
> > > >
> > > >         pcie {
> > > >                 compatible =3D "...";
> > > >                 ...
> > > >                 dev {
> > > >                         reg =3D <0 0 0 0 0>;
> > > >                         ...
> > > >                 };
> > > >         };
> > > >
> > > > Without this the dev node is assigned to the root bridge and the
> > > > actual device search starts one level lower than expected.
> > > >
> > > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > > ---
> > > >  drivers/pci/pci-uclass.c | 15 ++++++++++++++-
> > > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > >
> > > Can you update the tests to handle this case please?
> >
> > I'd be glad to, but I'm not familiar with the test FW in u-booy, coud g=
ive
> > me
> > some pointers on where/how to test this?
> >
>
> Yes it is at test/dm/pci.c and the device tree is test.dts
>
> 'make qcheck' to run all tests. To run one test, build for sandbox and
> then something like
>
> u-boot -T -c "ut dm pci_swapcase"
>
> for example.
>
> You can perhaps use an existing PCI controller in test.dts but feel
> free to add one more if you need it for your test. Make sure that you
> don't break other tests.

Thanks for the info.

Actually adding the tests made me doubleguess myself, and now I'm pretty su=
re
that what I shoudl've done in DT is the following:

	&pcie0 {
	       pci@0 {
		       #address-cells =3D <3>;
		       #size-cells =3D <2>;
		       ranges;

		       reg =3D <0 0 0 0 0>;

		       usb@1,0 {
			       reg =3D <0x10000 0 0 0 0>;
			       resets =3D <&reset RASPBERRYPI_FIRMWARE_RESET_ID_USB>;
		       };
	       };
	};


(with "lspci -tv": [0000:00]---00.0-[01]----00.0  VIA Technologies, Inc. VL=
805 USB 3.0 Host Controller)

With this the patch above isn't needed, which is great.

I'll send this to upstream Linux just to get a confirmation this is correct=
,
although if you have any comments it'll be appreciated.

Regards,
Nicolas


--=-C+TXhUdXAiW5aA7sAVb3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7qa8QACgkQlfZmHno8
x/5HKAf/VE3jKjTDXedZWguvOmcbQ8MamvcvMoG7eMXVYZq2CyuZx3el/7OD1kQc
mJh2y045Kjs60uOf64auqvVtx3r+2WwUC35EiRi7rBFUL4OEtM+JnOxsI4i/pBVT
y4/xy1Z6XQ4/9h1uWyU98zQir6mNb9JHQ/uf8hR/yoilHcArwUSrnSQgGn3P/5XX
UhV34+3/pryJNKlfk+WrzD/k1BrA744X49gdRfdsNuDxq/KrTdGWUL1022J1Gbr3
G8rD6YmZNO6I2+JnwUZgfOljakBM7C7B8GROZ92SbJjSMtbWJ26ADSaSCNikIzHB
MLLejB5M91/NeW1QwqJU1hdDi50IUA==
=TJ4O
-----END PGP SIGNATURE-----

--=-C+TXhUdXAiW5aA7sAVb3--

