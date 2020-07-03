Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEFBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840C221548
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgGCOxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 10:53:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:60512 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgGCOxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 10:53:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2C652AF69;
        Fri,  3 Jul 2020 14:53:47 +0000 (UTC)
Message-ID: <a9058fd2c54bbea69fdf97e30277338a61b5c0b4.camel@suse.de>
Subject: Re: [BUG] XHCI getting ZONE_DMA32 memory > than its bus_dma_limit
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Jeremy Linton <jeremy.linton@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mm@kvack.org,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        rientjes@google.com, Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Date:   Fri, 03 Jul 2020 16:53:45 +0200
In-Reply-To: <34619bdf-6527-ae82-7e4d-e2ea7c67ed56@arm.com>
References: <34619bdf-6527-ae82-7e4d-e2ea7c67ed56@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-jPh4P4ef6IRIm8gZjo2Z"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jPh4P4ef6IRIm8gZjo2Z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeremy,
thanks for the bug report.

Just for the record the offending commit is: c84dc6e68a1d2 ("dma-pool: add
additional coherent pools to map to gfp mask").

On Thu, 2020-07-02 at 12:49 -0500, Jeremy Linton wrote:
> Hi,
>=20
> Using 5.8rc3:
>=20
> The rpi4 has a 3G dev->bus_dma_limit on its XHCI controller. With a usb3=
=20
> hub, plus a few devices plugged in, randomly devices will fail=20
> operations. This appears to because xhci_alloc_container_ctx() is=20
> getting buffers > 3G via dma_pool_zalloc().
>=20
> Tracking that down, it seems to be caused by dma_alloc_from_pool() using=
=20
> dev_to_pool()->dma_direct_optimal_gfp_mask() to "optimistically" select=
=20
> the atomic_pool_dma32 but then failing to verify that the allocations in=
=20
> the pool are less than the dev bus_dma_limit.

I can reproduce this too.

The way I see it, dev_to_pool() wants a strict dma_direct_optimal_gfp_mask(=
)
that is never wrong, since it's going to stick to that pool for the device'=
s
lifetime. I've been looking at how to implement it, and it's not so trivial=
 as
I can't see a failproof way to make a distinction between who needs DMA32 a=
nd
who is OK with plain KERNEL memory.

Otherwise, as Jeremy points out, the patch needs to implement allocations w=
ith
an algorithm similar to __dma_direct_alloc_pages()'s, which TBH I don't kno=
w if
it's a little overkill for the atomic context.

Short of finding a fix in the coming rc's, I suggest we revert this.

Regards,
Nicolas


--=-jPh4P4ef6IRIm8gZjo2Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7/RnkACgkQlfZmHno8
x/7Hzwf9EK5UZ/nU0kNYHFn34OzNUw81RBxAseEJjDNzqtbLPFOnBapN7FTeMf3t
SEVbR4NXtItrMqKjppBcAhqjw6geoWvgonDnZlMKZhV4CNSGqgBc8U1kn5FRY4H/
6/nJ2yzcRtuYCmoIK/Rtc6g53+lJoM+Cmor1Bdp9RG+qOc9cylECc1FI6zx3HaZv
vBfaKbqF6relsISrxWkD/iRne99hINnTvdE2LTz8VoZWWbN3G+lUkDw9KJbm4WaT
3lFAMPf2XQ9pJVmDj+M2TYMLkCGTelhml4o1ngHvugQFfjaueuFdOcbXiTikx7RP
IJWc4W/+qG6zKC3cOjN6oj6fLNCQaw==
=5wyW
-----END PGP SIGNATURE-----

--=-jPh4P4ef6IRIm8gZjo2Z--

