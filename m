Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D9EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED4F22311C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbgHFRXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:23:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:44438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730027AbgHFRXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:23:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9A7B6AED2;
        Thu,  6 Aug 2020 11:50:49 +0000 (UTC)
Message-ID: <3a530804ad5aa96d2502da8ee3e8650b0b477c0f.camel@suse.de>
Subject: Re: [PATCH v2 2/2] dma-pool: Only allocate from CMA when in same
 memory zone
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     amit.pundir@linaro.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, rientjes@google.com,
        jeremy.linton@arm.com, linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Date:   Thu, 06 Aug 2020 13:50:29 +0200
In-Reply-To: <20200806051814.GA10143@lst.de>
References: <20200803160956.19235-1-nsaenzjulienne@suse.de>
         <20200803160956.19235-3-nsaenzjulienne@suse.de>
         <20200804060633.GA7368@lst.de>
         <e0b2a00c8cf86cb1a91804942d35c9d4b98e9f9f.camel@suse.de>
         <20200806051814.GA10143@lst.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-BLB/tUqhN7FZgmlmL87f"
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BLB/tUqhN7FZgmlmL87f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-08-06 at 07:18 +0200, Christoph Hellwig wrote:
> On Tue, Aug 04, 2020 at 11:43:15AM +0200, Nicolas Saenz Julienne wrote:
> > > Second I don't see the need (and actually some harm) in preventing GF=
P_KERNEL
> > > allocations from dipping into lower CMA areas - something that we did=
 support
> > > before 5.8 with the single pool.
> >=20
> > My thinking is the least we pressure CMA the better, it's generally sca=
rse, and
> > it'll not grow as the atomic pools grow. As far as harm is concerned, w=
e now
> > check addresses for correctness, so we shouldn't run into problems.
> >=20
> > There is a potential case for architectures defining a default CMA but =
not
> > defining DMA zones where this could be problematic. But isn't that just=
 plain
> > abusing CMA? If you need low memory allocations, you should be defining=
 DMA
> > zones.
>=20
> The latter is pretty much what I expect, as we only support the default a=
nd
> per-device DMA CMAs.

Fair enough, should I send a v3 with everything cleaned-up/rebased, or you'=
d
rather pick it up from your version?


--=-BLB/tUqhN7FZgmlmL87f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl8r7oUACgkQlfZmHno8
x/6NNAf8CT1UiVU7PCKz2LUHhepxWBfqr/Fz15NMCjlWxLecIvE8NeFQYjnkzCr8
WNIEZM0Vi5yiy2M5Au0e18rt/S/U2O4wCD95KXIAO7b7iMhP0jJFh9nqnj6IDUrJ
+QzQLSMHGGD+UO4bxtpONvZ0/UekL1werA7sP2qQynpUDFijzq8HZ9/U2tD+Mtyl
CFUOvAI5xO6AsVH4xryG4jWUb66/hflTOJ2nwz6ybrN/R+L2UvxYrynf2/lHIZq/
wqfGMD/Oh+KAiecex8ZgavWC/Adft7bAfJ3E7JZp5V3C+wW/QB7XWeGtAAawy1nC
B5Pd5WHQFwp5oP5bPzDO17kycEbD8Q==
=DGkG
-----END PGP SIGNATURE-----

--=-BLB/tUqhN7FZgmlmL87f--

