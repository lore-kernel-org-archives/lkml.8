Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7C2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 714B7207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgGJITo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:19:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:46418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgGJITo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:19:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AFBB7AB7A;
        Fri, 10 Jul 2020 08:19:42 +0000 (UTC)
Message-ID: <5c21867fd2e9c1c25f3080deeeb0ccdb3070ead2.camel@suse.de>
Subject: Re: [PATCH] dma-pool: use single atomic pool for both DMA zones
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     David Rientjes <rientjes@google.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Fri, 10 Jul 2020 10:19:40 +0200
In-Reply-To: <alpine.DEB.2.23.453.2007091448550.972523@chino.kir.corp.google.com>
References: <20200707122804.21262-1-nsaenzjulienne@suse.de>
         <20200708153509.GA26743@lst.de>
         <e81db35628a22a0d1635699d1e87bacde706ad25.camel@suse.de>
         <20200708161010.GA30184@lst.de>
         <alpine.DEB.2.23.453.2007091448550.972523@chino.kir.corp.google.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ghHFpb3jrVR40NR7F7FC"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ghHFpb3jrVR40NR7F7FC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-07-09 at 14:49 -0700, David Rientjes wrote:
> On Wed, 8 Jul 2020, Christoph Hellwig wrote:
>=20
> > On Wed, Jul 08, 2020 at 06:00:35PM +0200, Nicolas Saenz Julienne wrote:
> > > On Wed, 2020-07-08 at 17:35 +0200, Christoph Hellwig wrote:
> > > > On Tue, Jul 07, 2020 at 02:28:04PM +0200, Nicolas Saenz Julienne wr=
ote:
> > > > > When allocating atomic DMA memory for a device, the dma-pool core
> > > > > queries __dma_direct_optimal_gfp_mask() to check which atomic poo=
l to
> > > > > use. It turns out the GFP flag returned is only an optimistic gue=
ss.
> > > > > The pool selected might sometimes live in a zone higher than the
> > > > > device's view of memory.
> > > > >=20
> > > > > As there isn't a way to grantee a mapping between a device's DMA
> > > > > constraints and correct GFP flags this unifies both DMA atomic po=
ols.
> > > > > The resulting pool is allocated in the lower DMA zone available, =
if
> > > > > any,
> > > > > so as for devices to always get accessible memory while having th=
e
> > > > > flexibility of using dma_pool_kernel for the non constrained ones=
.
> > > > >=20
> > > > > Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to =
map
> > > > > to gfp
> > > > > mask")
> > > > > Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> > > > > Suggested-by: Robin Murphy <robin.murphy@arm.com>
> > > > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > >=20
> > > > Hmm, this is not what I expected from the previous thread.  I thoug=
ht
> > > > we'd just use one dma pool based on runtime available of the zones.=
.
> > >=20
> > > I may be misunderstanding you, but isn't that going back to how thing=
s
> > > used to
> > > be before pulling in David Rientjes' work? The benefit of having a
> > > GFP_KERNEL
> > > pool is that non-address-constrained devices can get their atomic mem=
ory
> > > there,
> > > instead of consuming somewhat scarcer low memory.
> >=20
> > Yes, I think we are misunderstanding each other.  I don't want to remov=
e
> > any pool, just make better runtime decisions when to use them.
> >=20
>=20
> Just to be extra explicit for the record and for my own understanding:=
=20
> Nicolas, your patch series "dma-pool: Fix atomic pool selection" obsolete=
s=20
> this patch, right? :)

Yes, that's right.

Regards,
Nicolas


--=-ghHFpb3jrVR40NR7F7FC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl8IJJwACgkQlfZmHno8
x/7eRgf+LVqWrnAjb1c88gXOrDMdl27HUQzIDYXit5TQgnkyp7CwzALmvSEnc2Es
BtY2vTG+MkAnQosY5mRuw2Ycs6K89qFjVnd5JmCefM44A89n3vTG1Fu3/1yOFjEZ
dcdJuY7x6pFvZal7dEJpm3BMjWMGPRwCgdgF3fMmVqfwA7k4R0TflEZT/W7fSz1N
c9mVgO4dfv4uBghkHYe+ffZ/71uuWtebNkM5mwygsTJ6IFvQErnf0jF4ROi+Tv+o
XvKnWsFxvX8B36eZWhNHr5bWXbS7dHjAqiwIqhgKvwRvEqrSWVL3np29KwdrP09k
4AowWeWsNLJ9kHsHfaoaubpv6nUDbA==
=ZWwI
-----END PGP SIGNATURE-----

--=-ghHFpb3jrVR40NR7F7FC--

