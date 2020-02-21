Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D24C11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 03:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC021208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 03:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="e3zdRwhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbgBUDhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 22:37:00 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:59179 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729632AbgBUDhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 22:37:00 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
        id 48Nxw96pvRz9sS3; Fri, 21 Feb 2020 14:36:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1582256217;
        bh=023zimJNppk3UBUgHQ61G7caK9h50x5C45Mcz1ME6eA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e3zdRwhjeJUcGi8UjR/bkaGU7iqvokZ0xSIereTY15GrOforn7fnCxaUAuHbxiZM4
         emwuWpBssUMeLJe/wGXWIiu66flWbyJ4cJ4MGXqogR27W3pz7uFchHhFUzLrqu3Y2+
         PplWrOzzPS2DH7Rn+fVEvIcvBGYlpQZH/yJb1Ohw=
Date:   Fri, 21 Feb 2020 14:29:07 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Ram Pai <linuxram@us.ibm.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
Message-ID: <20200221032907.GD2298@umbus.fritz.box>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-3-pasic@linux.ibm.com>
 <20200220154904-mutt-send-email-mst@kernel.org>
 <20200221011748.GE5713@oc0525413822.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
Content-Disposition: inline
In-Reply-To: <20200221011748.GE5713@oc0525413822.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2020 at 05:17:48PM -0800, Ram Pai wrote:
> On Thu, Feb 20, 2020 at 03:55:14PM -0500, Michael S. Tsirkin wrote:
> > On Thu, Feb 20, 2020 at 05:06:06PM +0100, Halil Pasic wrote:
> > > Currently the advanced guest memory protection technologies (AMD SEV,
> > > powerpc secure guest technology and s390 Protected VMs) abuse the
> > > VIRTIO_F_IOMMU_PLATFORM flag to make virtio core use the DMA API, whi=
ch
> > > is in turn necessary, to make IO work with guest memory protection.
> > >=20
> > > But VIRTIO_F_IOMMU_PLATFORM a.k.a. VIRTIO_F_ACCESS_PLATFORM is really=
 a
> > > different beast: with virtio devices whose implementation runs on an =
SMP
> > > CPU we are still fine with doing all the usual optimizations, it is j=
ust
> > > that we need to make sure that the memory protection mechanism does n=
ot
> > > get in the way. The VIRTIO_F_ACCESS_PLATFORM mandates more work on the
> > > side of the guest (and possibly he host side as well) than we actually
> > > need.
> > >=20
> > > An additional benefit of teaching the guest to make the right decision
> > > (and use DMA API) on it's own is: removing the need, to mandate speci=
al
> > > VM configuration for guests that may run with protection. This is
> > > especially interesting for s390 as VIRTIO_F_IOMMU_PLATFORM pushes all
> > > the virtio control structures into the first 2G of guest memory:
> > > something we don't necessarily want to do per-default.
> > >=20
> > > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > > Tested-by: Ram Pai <linuxram@us.ibm.com>
> > > Tested-by: Michael Mueller <mimu@linux.ibm.com>
> >=20
> > This might work for you but it's fragile, since without
> > VIRTIO_F_ACCESS_PLATFORM hypervisor assumes it gets
> > GPA's, not DMA addresses.
> >=20
> >=20
> >=20
> > IOW this looks like another iteration of:
> >=20
> > 	virtio: Support encrypted memory on powerpc secure guests
> >=20
> > which I was under the impression was abandoned as unnecessary.
>=20
> It has been abondoned on powerpc. We enabled VIRTIO_F_ACCESS_PLATFORM;
> by default, flag on powerpc.

Uh... we haven't yet, though we're working on it.

> We would like to enable secure guests on powerpc without this flag
> aswell enabled, but past experience has educated us that its not a easy
> path.  However if Halil makes some inroads in this path for s390, we
> will like to support him.
>=20
>=20
> RP
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5PToIACgkQbDjKyiDZ
s5L9mw//e6UlWdIjS0sVfS3LR0dfVU8WuWvcWGPlHsAvqf8ahlSYAPlyL8YHIHwe
kntSk9WXkEn3jRCsD+nHK+dAu10C1hiGl18RH+S0yisKRnH+WabU1oesIh5cDwaV
r+bZsU3HPaTwHS83yVNRYjoic3ZjV97karqDYGMHSnWWbVqCDZDnREwxG3VE1jm7
7sdJak8rTIZ1AUezQwSKgfIy4lkCGVoaUC9ZKIvdWVIHywQvtXDn2ikbGENaY3E3
MaU7NicXVogmy+beOzkOWNst0Xfm6N+oGHw2O/8zRpsmk95YAg84UGYEg4GfTEKE
UGjNeeMDAL5lMYRbqdbzBve+wGmgnyThjGwt3PeivwATqEiL3j8AmOelUmQ9SY2y
qPOTzprDVU+Vu0A+6NHBPuzvhFZr5dVpD4n5kF+TeH6lp+m4GC9YCIN6hT6NE+DG
/yc/2QUJk14otNc/h7Nk+RqVm1+ZORWoDqiISB/M3U2t3kaai0hczJ6q2tDjl1pJ
cDx9sX8mVAhyOT3LSxvfOrRDsUwyzuUjrqJCh9gnXv073cc8E6VnFb7g+Cj+NUYP
tbh3wOC7KKoovvfI4x2YrPNpkDSAOE91h5gaM1sFtmsB0leF77mrbDAwncZHC5C8
2EWMVf3S2sJLq9s1CulJ8Zc27iCG9F/71Bd88Nitf2HIvFqDSZs=
=5mIy
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--
