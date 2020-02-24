Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F98C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E1220714
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bVj1Dp6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbgBXGny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 01:43:54 -0500
Received: from ozlabs.org ([203.11.71.1]:44553 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbgBXGny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 01:43:54 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
        id 48QswR5bYFz9sRh; Mon, 24 Feb 2020 17:43:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1582526631;
        bh=ZF5PG8T/t5BL5oaCO6K1q0KQ7vQbeqwM3LxrmTrD5EY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bVj1Dp6aUpCfIOZgD5kdvV05fCY+oTTKywiyc9cxriZC7InXfdxb/DT/Atn/qxCv7
         O6stUqLU4tHlAllQ0B3BCVqYzS/Wqn+uIdFxv0XCAB2JSjy717kH5q89gkoQqekPol
         MQiIowckKYzopovcwGfC1Gdj8tkKagI8QC3nKr8E=
Date:   Mon, 24 Feb 2020 16:44:28 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200224054428.GF1751@umbus.fritz.box>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220163055-mutt-send-email-mst@kernel.org>
 <20200221164151.GD10054@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nHwqXXcoX0o6fKCv"
Content-Disposition: inline
In-Reply-To: <20200221164151.GD10054@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nHwqXXcoX0o6fKCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2020 at 05:41:51PM +0100, Christoph Hellwig wrote:
> On Thu, Feb 20, 2020 at 04:33:35PM -0500, Michael S. Tsirkin wrote:
> > So it sounds like a host issue: the emulation of s390 unnecessarily com=
plicated.
> > Working around it by the guest looks wrong ...
>=20
> Yes.  If your host (and I don't care if you split hypervisor,
> ultravisor and megavisor out in your implementation) wants to
> support a VM architecture where the host can't access all guest
> memory you need to ensure the DMA API is used.  Extra points for
> simply always setting the flag and thus future proofing the scheme.

Moving towards F_ACCESS_PLATFORM everywhere is a good idea (for other
reasons), but that doesn't make the problem as it exists right now go
away.

But, "you need to ensure the DMA API is used" makes no sense from the
host point of view.  The existence of the DMA API is an entirely guest
side, and Linux specific detail, the host can't make decisions based
on that.

For POWER - possibly s390 as well - the hypervisor has no way of
knowing at machine construction time whether it will be an old kernel
(or non Linux OS) which can't support F_ACCESS_PLATFORM, or a guest
which will enter secure mode and therefore requires F_ACCESS_PLATFORM
(according to you).  That's the fundamental problem here.

The normal virtio model of features that the guest can optionally
accept would work nicely here - except that that wouldn't work for the
case of hardware virtio devices, where the access limitations come
=66rom "host" (platform) side and therefore can't be disabled by that
host.

We really do have two cases here: 1) access restrictions originating
with the host/platform (e.g. hardware virtio) and 2) access
restrictions originating with the guest (e.g. secure VMs).  What we
need to do to deal with them is basically the same at the driver
level, but it has subtle and important differences at the platform
level.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nHwqXXcoX0o6fKCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5TYrkACgkQbDjKyiDZ
s5LgfA//XEY3lmBePwheA7+ZxvP//i1z+aeebGoX04iO9GIleC4oyEM4gwYIBsyE
wN2BIrmBL7Zv5wxxna4aFmlHWVHtjclnMlbnScF3iSkYjcAqB0WowhE+uMerv86z
0SQsaZBBEzM2AUCdyWpi1NvPPH6qWbB1BAlZ1gS18mpsYePFvZ5Yx7v8HlXoSdti
nHf9vONIz4DjMutYICE0h4wRSG8fE0Glav04Rlvy4G024l5rW3o3Hd4Fg6hlL6Bx
lG9vYtmbznT2FaqV1vvs9LHFQ+luXOqLisBYunWFHDGSBLqQdfWnVApMfHpmkudT
pVFwEZmU3Vdy0MgEF6mMunZ2vw0PqQaQSIw2KUm4KJXSLjrR2qI+XUY878F+hI5h
fvAxlo4FDEBDVgeIudJY28B/57nJdaMZCpxZB6YFHGtuQJU5VHFRLA1wi96A3mFr
W29jfmZcozEl2fpJyr7lg/znfmjbrAx63AeNJkKQ9lWpDGilVd90xHaWcEy+t28L
U9GggmVjYO4KOGiOTjkrY+wskuPj/qZaoEWFra3bzryLW5muVLoCT12H2X+NtcjF
2Poa8kmUAlBjnnrf3QLCh2rQQVuHNXMbS7eYpeSBfld+gHjj7FBMS5ymAnEK0X3B
WySnu4ZlVaDEYjtHlp6tvfiRlkt1PGQswZY8OhtHA6QBkQVs4t0=
=snSR
-----END PGP SIGNATURE-----

--nHwqXXcoX0o6fKCv--
