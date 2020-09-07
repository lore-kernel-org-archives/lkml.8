Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB54C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD4821532
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbgIGRvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:51:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:43202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729290AbgIGRur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 13:50:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3FCB8B706;
        Mon,  7 Sep 2020 17:50:45 +0000 (UTC)
Message-ID: <1ae30b3bfd97aba56323422baeb5b48b787c7561.camel@suse.de>
Subject: Re: [RFC] arm64: mm: Do not use both DMA zones when 30-bit address
 space unavailable
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, f.fainelli@gmail.com, hch@lst.de,
        linux-rpi-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, robh@kernel.org
Date:   Mon, 07 Sep 2020 19:50:43 +0200
In-Reply-To: <20200828174338.GK3169@gaia>
References: <20200819182434.28196-1-nsaenzjulienne@suse.de>
         <20200828174338.GK3169@gaia>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-jEUGUkKCXaIdBYqcfad8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jEUGUkKCXaIdBYqcfad8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Catalin, sorry for the late reply, I was on vacation.

On Fri, 2020-08-28 at 18:43 +0100, Catalin Marinas wrote:
> Hi Nicolas,
>=20
> On Wed, Aug 19, 2020 at 08:24:33PM +0200, Nicolas Saenz Julienne wrote:
> > There is no benefit in splitting the 32-bit address space into two
> > distinct DMA zones when the 30-bit address space isn't even available o=
n
> > a device. If that is the case, default to one big ZONE_DMA spanning the
> > whole 32-bit address space.
> >=20
> > This will help reduce some of the issues we've seen with big crash
> > kernel allocations.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >=20
> > Whith this patch, on a 8GB RPi4 the setup looks like this:
> >=20
> > 	DMA      [mem 0x0000000000000000-0x000000003fffffff]
> > 	DMA32    [mem 0x0000000040000000-0x00000000ffffffff]
> > 	Normal   [mem 0x0000000100000000-0x00000001ffffffff]
> >=20
> > And stock 8GB virtme/qemu:
> >=20
> > 	DMA      [mem 0x0000000040000000-0x00000000ffffffff]
> > 	DMA32    empty
> > 	Normal   [mem 0x0000000100000000-0x000000023fffffff]
> >=20
> >  arch/arm64/mm/init.c | 29 +++++++++++++++++++++++++----
> >  1 file changed, 25 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index b6881d61b818..857a62611d7a 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -183,13 +183,20 @@ static void __init reserve_elfcorehdr(void)
> > =20
> >  /*
> >   * Return the maximum physical address for a zone with a given address=
 size
> > - * limit. It currently assumes that for memory starting above 4G, 32-b=
it
> > - * devices will use a DMA offset.
> > + * limit or zero if memory starts from an address higher than the zone=
 targeted.
> > + * It currently assumes that for memory starting above 4G, 32-bit devi=
ces will
> > + * use a DMA offset.
> >   */
> >  static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
> >  {
> > -	phys_addr_t offset =3D memblock_start_of_DRAM() & GENMASK_ULL(63, zon=
e_bits);
> > -	return min(offset + (1ULL << zone_bits), memblock_end_of_DRAM());
> > +	phys_addr_t base =3D memblock_start_of_DRAM();
> > +	phys_addr_t offset =3D base & GENMASK_ULL(63, 32);
> > +	s64 zone_size =3D (1ULL << zone_bits) - (base & DMA_BIT_MASK(32));
> > +
> > +	if (zone_size <=3D 0)
> > +		return 0;
> > +
> > +	return min(base + zone_size + offset, memblock_end_of_DRAM());
> >  }
>=20
> OK, so we can still get some ZONE_DMA if DRAM starts in the first GB.
>=20
> I don't think it entirely solves the problem.

Agree. Didn't mean to imply it.

> It just happens that the
> other affected SoCs don't have memory in the first GB. With this patch,
> we go by the assumption that ZONE_DMA/DMA32 split is only needed if
> there is memory in the low 1GB and such <32-bit devices don't have a DMA
> offset.

The way I understand it is: "we may have 30 bit DMA limited devices, the re=
st
can deal with 32 bit."

On top of that, I believe it makes little sense to use an offset in the
physical address space below the 32bit mark. You'd be limiting the amount o=
f
memory available to the system. So, if you're going support DMA limited dev=
ices
on your otherwise RAM hungry SoC, you'll have to have that physical address
space directly available, or at least part of it.

All in all, I believe that assuming no 30 bit DMA limited devices exist in =
the
system if the physical addresses don't exist is a fairly safe.

Also note the usage of 'zone_dma_bits' in the DMA code, which assumes that
ZONE_DMA's physical address space is always smaller than (1 << zone_dma_bit=
s) -
1.

> Adding Rob H (it's easier to ask him than grep'ing the DT files ;)), we
> may be ok with this assumption on current SoCs.

=46rom what I've personally grep'd there is no new devices with odd ranges in
sight.

> An alternative (and I think we had a patch at some point) is to make it
> generic and parse the dma-range in the DT to identify the minimum mask
> and set ZONE_DMA accordingly. But this doesn't solve ACPI, so if Linux
> can boot with ACPI on RPi4 it would still be broken.

ACPI is being worked on by, among others, Jeremy Linton (one of your collea=
gues
I believe).

We could always use sane defaults for ACPI and be smarter with DT. Yet,
implementing this entails translating nested dma-ranges with the only help =
of
libfdt, which isn't trivial (see devices/of/address.c). IIRC RobH said that=
 it
wasn't worth the effort just for a board.

Regards,
Nicolas


--=-jEUGUkKCXaIdBYqcfad8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl9WcvMACgkQlfZmHno8
x/5SPwf+LS7zNqFJoobSUCd6kWxkW5mxRCm7JOLYs8tJDrCPf1uWYM00qPzT5BHR
11bGxXEyIUSTMGbDaweUtB38fZ/xIOtC9xYafM1JdRLRfvOrL/rudFVV/1WRl1f1
U2clpewbHg9WcwVC1uzVZItpnPV5g2m1cNBH1sdcHvEjjclKkvrdLt4OPMDifavB
Tpa6lYZxoxiXUrJpd5XHk3ugwI1u4/Ecz5RMelAvUtKnSDUDMFNTVFGIF6rZulRx
ztbTrngzgFnbAOIoo2Vq8nDeEa0sfv+s7cGrny1ySH7HFva5JjSQX3djnF4FlHD0
WcVEDs2XUgpTzJA56v1ChaGpZvl+Ow==
=ZN1c
-----END PGP SIGNATURE-----

--=-jEUGUkKCXaIdBYqcfad8--

