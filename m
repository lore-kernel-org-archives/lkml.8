Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D8FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43A4620672
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbgGHQAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:00:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:36070 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730179AbgGHQAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:00:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BC203AE25;
        Wed,  8 Jul 2020 16:00:37 +0000 (UTC)
Message-ID: <e81db35628a22a0d1635699d1e87bacde706ad25.camel@suse.de>
Subject: Re: [PATCH] dma-pool: use single atomic pool for both DMA zones
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Wed, 08 Jul 2020 18:00:35 +0200
In-Reply-To: <20200708153509.GA26743@lst.de>
References: <20200707122804.21262-1-nsaenzjulienne@suse.de>
         <20200708153509.GA26743@lst.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-1l9N/1yPO/4ruj6aYldS"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1l9N/1yPO/4ruj6aYldS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-07-08 at 17:35 +0200, Christoph Hellwig wrote:
> On Tue, Jul 07, 2020 at 02:28:04PM +0200, Nicolas Saenz Julienne wrote:
> > When allocating atomic DMA memory for a device, the dma-pool core
> > queries __dma_direct_optimal_gfp_mask() to check which atomic pool to
> > use. It turns out the GFP flag returned is only an optimistic guess.
> > The pool selected might sometimes live in a zone higher than the
> > device's view of memory.
> >=20
> > As there isn't a way to grantee a mapping between a device's DMA
> > constraints and correct GFP flags this unifies both DMA atomic pools.
> > The resulting pool is allocated in the lower DMA zone available, if any=
,
> > so as for devices to always get accessible memory while having the
> > flexibility of using dma_pool_kernel for the non constrained ones.
> >=20
> > Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to map to=
 gfp
> > mask")
> > Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> > Suggested-by: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>=20
> Hmm, this is not what I expected from the previous thread.  I thought
> we'd just use one dma pool based on runtime available of the zones..

I may be misunderstanding you, but isn't that going back to how things used=
 to
be before pulling in David Rientjes' work? The benefit of having a GFP_KERN=
EL
pool is that non-address-constrained devices can get their atomic memory th=
ere,
instead of consuming somewhat scarcer low memory.


--=-1l9N/1yPO/4ruj6aYldS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl8F7aMACgkQlfZmHno8
x/5/9gf+NzyxgUaobjh+kSJ+z1K3KcgSbBWTsleHIga7PNEsLskweeTIbHy8Mu+L
+l3d5Luho/JiDNEwb/ogwIUOxxVnRMMypi0Pi1sSQKC8saaZBaACuZHlbl9FYola
+hM7aLJNaSdqN5lEqo185qtvbWE4czz+Lvhw+AiuzzI4d4bKswtCYj9kKO70ir+I
cTIIpzcwHXjDELCOGBnTmhIIL11feTP7BDZszZdk+Pp99KFBLPedpmSvp0PoaKN0
qxchAwBNrt31Jb1VjkMpRyAUqFZFPbcbBw0cqNdovej39bRIdJnjKUV2Qpg56ZRh
S5MgcOa4ctQVFoo7VirwED00A3dGDg==
=bCcC
-----END PGP SIGNATURE-----

--=-1l9N/1yPO/4ruj6aYldS--

