Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64B7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F706206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgHGIuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 04:50:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:36472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbgHGIuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 04:50:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 478AAAF06;
        Fri,  7 Aug 2020 08:50:39 +0000 (UTC)
Message-ID: <aae9250e660339142e9390427a603c4cf4e282af.camel@suse.de>
Subject: Re: [PATCH v3 2/2] dma-pool: Only allocate from CMA when in same
 memory zone
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     amit.pundir@linaro.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, rientjes@google.com,
        jeremy.linton@arm.com, linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Date:   Fri, 07 Aug 2020 10:50:19 +0200
In-Reply-To: <20200807052116.GA584@lst.de>
References: <20200806184756.32075-1-nsaenzjulienne@suse.de>
         <20200806184756.32075-3-nsaenzjulienne@suse.de>
         <20200807052116.GA584@lst.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-CN1cawQ3wxFHCl/garHR"
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CN1cawQ3wxFHCl/garHR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-08-07 at 07:21 +0200, Christoph Hellwig wrote:
> On Thu, Aug 06, 2020 at 08:47:55PM +0200, Nicolas Saenz Julienne wrote:
> > There is no guarantee to CMA's placement, so allocating a zone specific
> > atomic pool from CMA might return memory from a completely different
> > memory zone. To get around this double check CMA's placement before
> > allocating from it.
>=20
> As the builtbot pointed out, memblock_start_of_DRAM can't be used from
> non-__init code.  But lookig at it I think throwing that in
> is bogus anyway, as cma_get_base returns a proper physical address
> already.

It does indeed, but I'm comparing CMA's base with bitmasks that don't take =
into
account where the memory starts. Say memory starts at 0x80000000, and CMA f=
alls
into ZONE_DMA [0x80000000 0xC0000000], if you want to compare it with
DMA_BIT_MASK(zone_dma_bits) you're forced to unify the memory bases.

That said, I now realize that this doesn't work for ZONE_DMA32 which has a =
hard
limit on 32bit addresses reglardless of the memory base.

That said I still need to call memblock_start_of_DRAM() any suggestions WRT
that? I could save the value in dma_atomic_pool_init(), which is __init cod=
e.


--=-CN1cawQ3wxFHCl/garHR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl8tFcsACgkQlfZmHno8
x/5Wxwf+IXh+GDy4xNKtfhxHMTDolZREHO/kvmoJd/zTobn0o4992GzMyEVu9YLd
MA+Yxdpi4IDDTredYMITrPM7f0nd2BpqZ1Wf8zXF2o5nmtPoAeOqH89FbajqzXle
oLRzLPoC5xDcErO2J1UDIRg539IJu1kKGaPDxJT0gxcDv39DOMITNzMuphQwacLM
tYXUuZ9yNFRx0AdODTOXPE7iE4qKRQvm54rExmYsT3VJIjlo+H8qrpa79q6BhooL
G19pFMDFTVhX/iRA94j2HBXr7IjyDK44JJlHWZ9Ocf04S3bVCClkDH9nK74ZRHgm
GS5W7k8K8VWOD1DajSTMyZjk/2+E/A==
=i4iT
-----END PGP SIGNATURE-----

--=-CN1cawQ3wxFHCl/garHR--

