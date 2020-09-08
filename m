Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7B8C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 116A6206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbgIHQ3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:29:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:43854 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731931AbgIHQXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:23:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E81E7AFED;
        Tue,  8 Sep 2020 12:16:23 +0000 (UTC)
Message-ID: <49b99d5a87f349bf9ede2a5f737e4f1981a12441.camel@suse.de>
Subject: Re: [RFC] arm64: mm: Do not use both DMA zones when 30-bit address
 space unavailable
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, f.fainelli@gmail.com, hch@lst.de,
        linux-rpi-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, robh@kernel.org,
        Robin Murphy <robin.murphy@arm.com>
Date:   Tue, 08 Sep 2020 14:15:57 +0200
In-Reply-To: <20200908111454.GB25591@gaia>
References: <20200819182434.28196-1-nsaenzjulienne@suse.de>
         <20200828174338.GK3169@gaia>
         <1ae30b3bfd97aba56323422baeb5b48b787c7561.camel@suse.de>
         <20200908111454.GB25591@gaia>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-rb/XBEX16UjId/WsOdIB"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rb/XBEX16UjId/WsOdIB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Catalin, thanks for taking the time.

On Tue, 2020-09-08 at 12:14 +0100, Catalin Marinas wrote:
> > Also note the usage of 'zone_dma_bits' in the DMA code, which assumes t=
hat
> > ZONE_DMA's physical address space is always smaller than (1 << zone_dma=
_bits) -
> > 1.
>=20
> I think part of those uses are broken. dma_direct_supported() does the
> right thing and uses the DMA address instead of the physical one. Here
> __phys_to_dma() subtracts the dma_pfn_offset, which in my above example
> would be (0b10 << (30 - PAGE_SHIFT)).
>=20
> dma_direct_optimal_gfp_mask(), OTOH, seems to start ok with a
> __dma_to_phys() on the dma_limit but it ends up comparing the physical
> address with the DMA mask. This gives the wrong result on arm64
> platforms where RAM starts above 4GB and still expect a ZONE_DMA32. It
> should compare *phys_limit with __dma_to_phys(DMA_BIT_MASK(...)). I
> guess it ends up bouncing via swiotlb more often.

I'll look into this.

> We assumed such offsets on arm64 since commit d50314a6b070 ("arm64:
> Create non-empty ZONE_DMA when DRAM starts above 4GB").
>=20
> > > An alternative (and I think we had a patch at some point) is to make =
it
> > > generic and parse the dma-range in the DT to identify the minimum mas=
k
> > > and set ZONE_DMA accordingly. But this doesn't solve ACPI, so if Linu=
x
> > > can boot with ACPI on RPi4 it would still be broken.
> >=20
> > ACPI is being worked on by, among others, Jeremy Linton (one of your co=
lleagues
> > I believe).
> >=20
> > We could always use sane defaults for ACPI and be smarter with DT. Yet,
> > implementing this entails translating nested dma-ranges with the only h=
elp of
> > libfdt, which isn't trivial (see devices/of/address.c). IIRC RobH said =
that it
> > wasn't worth the effort just for a board.
>=20
> That would have been the ideal, more generic solution. But I agree that
> it's not worth the effort if the only SoC affected is RPi4.
>=20
> To summarise, I'd like ZONE_DMA to overlap with ZONE_DMA32 (i.e. expand
> zone_dma_bits to 32 and drop ZONE_DMA32) for all SoCs other than RPi4.
> The solutions so far:
>=20
> 1. Assume that, if RAM starts at 0, we need a zone_dma_bits =3D=3D 30. Th=
is
>    also assumes that it's only RPi4 in this category or that any such
>    future SoC has a need for 30-bit DMA.
>=20
> 2. Adjust zone_dma_bits at boot-time only if the SoC is RPi4.
>=20
> 3. Use the more complex dma-ranges approach to calculate the correct
>    zone_dma_bits as a minimum of all dma masks in the DT.
>=20
> We can discount (3) as not worth the effort. I'd go with (1) (this
> patch) if we can guarantee that no current or future SoC has RAM
> starting at 0 while not needing 30-bit DMA masks. If not, we can go with
> (2) unless others have a better suggestion.

After a quick check at the devices we have for testing at suse it's clear t=
hat
(1) is impossible. So I'll push for solution (2).

Regards,
Nicolas


--=-rb/XBEX16UjId/WsOdIB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl9Xdf0ACgkQlfZmHno8
x/5FBgf/cwDBci7PK4a6ppnpfI3QWSqAQO/qfY2bb5We8JnAwqWAFwxChmY1AfIw
PtKwHTZW+5BppSEzvrWiQTDg0NEEJmYKp3eoVf7Sn5QpWh8vzz2GHHZv+gbAt7n2
y8qIboeCtLbZcjHPUu8YxMnUG9z6pdz/wIrG76/HTucaUZkS0gbM8C7N6PljVK0v
v+ErRhBrUFfocKCC694ZzomuEnzh7wRN3D0JZlKRFXSsgtrV19DcR8hQ/a6vK+q9
at1pcoOtMwI52WngNqQRmkUpnA+A8bliFukG9ZLx63elITkLjrngd+VHps63uI1W
6OoxRbUu/ss8iU7QoO1dEup5q5KQyQ==
=KAwd
-----END PGP SIGNATURE-----

--=-rb/XBEX16UjId/WsOdIB--

