Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7288EC35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C72D20828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Zc4b1jGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgBXGnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 01:43:55 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:51167 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbgBXGny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 01:43:54 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
        id 48QswR352Lz9sRR; Mon, 24 Feb 2020 17:43:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1582526631;
        bh=HE+dMIiDFpTtJfitS88px2QE5uurDOINjlLTLx6xBso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zc4b1jGX8kDXRZ1/cxrzaVVzmmi3Jbx5z+q4guCIZLM1Y9iri/Msd8YT7mp3duvPv
         lZjUNHzQT4RarBAuU51b2dq+ass/738MniN+F2rqaZcXondrlOoj5IxTkyHcwg8+nK
         1J6cZyaSBlb6Qhiu+Uk9hyWjjsOcm4EaK0zEMN1Y=
Date:   Mon, 24 Feb 2020 14:33:14 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Janosch Frank <frankja@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH 1/2] mm: move force_dma_unencrypted() to mem_encrypt.h
Message-ID: <20200224033314.GC1751@umbus.fritz.box>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-2-pasic@linux.ibm.com>
 <20200220161146.GA12709@lst.de>
 <4369f099-e4e4-4a58-b38b-642cf53ccca6@de.ibm.com>
 <20200220163135.GA13192@lst.de>
 <20200221032727.GC2298@umbus.fritz.box>
 <20200221140639.54928efe.pasic@linux.ibm.com>
 <20200221104724-mutt-send-email-mst@kernel.org>
 <20200221190702.68fd57fc.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <20200221190702.68fd57fc.pasic@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2020 at 07:07:02PM +0100, Halil Pasic wrote:
> On Fri, 21 Feb 2020 10:48:15 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
> > On Fri, Feb 21, 2020 at 02:06:39PM +0100, Halil Pasic wrote:
> > > On Fri, 21 Feb 2020 14:27:27 +1100
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >=20
> > > > On Thu, Feb 20, 2020 at 05:31:35PM +0100, Christoph Hellwig wrote:
> > > > > On Thu, Feb 20, 2020 at 05:23:20PM +0100, Christian Borntraeger w=
rote:
> > > > > > >From a users perspective it makes absolutely perfect sense to =
use the
> > > > > > bounce buffers when they are NEEDED.=20
> > > > > > Forcing the user to specify iommu_platform just because you nee=
d bounce buffers
> > > > > > really feels wrong. And obviously we have a severe performance =
issue
> > > > > > because of the indirections.
> > > > >=20
> > > > > The point is that the user should not have to specify iommu_platf=
orm.
> > > > > We need to make sure any new hypervisor (especially one that migh=
t require
> > > > > bounce buffering) always sets it,
> > > >=20
> > > > So, I have draft qemu patches which enable iommu_platform by defaul=
t.
> > > > But that's really because of other problems with !iommu_platform, n=
ot
> > > > anything to do with bounce buffering or secure VMs.
> > > >=20
> > > > The thing is that the hypervisor *doesn't* require bounce buffering.
> > > > In the POWER (and maybe s390 as well) models for Secure VMs, it's t=
he
> > > > *guest*'s choice to enter secure mode, so the hypervisor has no rea=
son
> > > > to know whether the guest needs bounce buffering.  As far as the
> > > > hypervisor and qemu are concerned that's a guest internal detail, it
> > > > just expects to get addresses it can access whether those are GPAs
> > > > (iommu_platform=3Doff) or IOVAs (iommu_platform=3Don).
> > >=20
> > > I very much agree!
> > >=20
> > > >=20
> > > > > as was a rather bogus legacy hack
> > > >=20
> > > > It was certainly a bad idea, but it was a bad idea that went into a
> > > > public spec and has been widely deployed for many years.  We can't
> > > > just pretend it didn't happen and move on.
> > > >=20
> > > > Turning iommu_platform=3Don by default breaks old guests, some of w=
hich
> > > > we still care about.  We can't (automatically) do it only for guests
> > > > that need bounce buffering, because the hypervisor doesn't know that
> > > > ahead of time.
> > >=20
> > > Turning iommu_platform=3Don for virtio-ccw makes no sense whatsover,
> > > because for CCW I/O there is no such thing as IOMMU and the addresses
> > > are always physical addresses.
> >=20
> > Fix the name then. The spec calls is ACCESS_PLATFORM now, which
> > makes much more sense.
>=20
> I don't quite get it. Sorry. Maybe I will revisit this later.

Halil, I think I can clarify this.

The "iommu_platform" flag doesn't necessarily have anything to do with
an iommu, although it often will.  Basically it means "access guest
memory via the bus's normal DMA mechanism" rather than "access guest
memory using GPA, because you're the hypervisor and you can do that".

For the case of ccw, both mechanisms end up being the same thing,
since CCW's normal DMA *is* untranslated GPA access.

For this reason, the flag in the spec was renamed to ACCESS_PLATFORM,
but the flag in qemu still has the old name.

AIUI, Michael is saying you could trivially change the name in qemu
(obviously you'd need to alias the old name to the new one for
compatibility).


Actually, the fact that ccw has no translation makes things easier for
you: you don't really have any impediment to turning ACCESS_PLATFORM
on by default, since it doesn't make any real change to how things
work.

The remaining difficulty is that the virtio driver - since it can sit
on multiple buses - won't know this, and will reject the
ACCESS_PLATFORM flag, even though it could just do what it normally
does on ccw and it would work.

For that case, we could consider a hack in qemu where for virtio-ccw
devices *only* we allow the guest to nack the ACCESS_PLATFORM flag and
carry on anyway.  Normally we insist that the guest accept the
ACCESS_PLATFORM flag if offered, because on most platforms they
*don't* amount to the same thing.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5TQ/gACgkQbDjKyiDZ
s5KScw/6A2bpuaDoeyju/89gg/50j1boGL5GLhZekxNikY9NGo8Q75SrCFgLeofE
WKee9dbP9N7t/rufx/3GTmHZdcG1Ag+7CJmiDZbkROVckdBwRex/g8Og8iQa97gK
aPUZKxNShLlV6p3FAUYYrv9F7t3nsJXLijRv/2t07uSKVsxY19DXGzgXFDrWj2R8
C/Xond2gjve7erMO8Ld/yFxAU20E3zj0LgFWiqwUnAWMgPFxPlx1L6ssv0kTOcD3
6tWGB5efKZz3UAbHHQyC3ziru+kPIRRKrk2tQ7rzQpoW8uPquTPZWl6+nJ6rKj4m
/QU++2cDASm+dTHnTRXiTUsZt26+VBgcDh+CZmGu9vvf2OJgmCJzeGwpuf1mWYCY
VXyT8dpChUq3q3YMxzoIuRVeyLJuBdZ8a8zofP6BCrXY4aMTji5eclg327DFonZB
0u3oKQxUR+vcPjWjsASjSnePzE/qxMABZboqSErqXNzeNq6AZen/s9ctO6E6wuHk
mXty/bXyjOeL/PI3kOUljvF7qtrGssMH+lxBxAaFdRD3DTdDxMwRd9bdYRBr7SJh
lwt0VMzt9PaXGATp73GTB+Mp5hlzcgIuaZS4/+ksp98iOPQ9nmbpXfqr4NZG/YZs
Uy5FiOjXXQASBIn+E2e83zoLgNsGMgTWDLh4NYs5vvzNxwD0YcM=
=jat8
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
