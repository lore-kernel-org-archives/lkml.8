Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381CBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2034C2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbgG0R5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:57:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:36584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729144AbgG0R5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:57:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 08CABABE9;
        Mon, 27 Jul 2020 17:57:09 +0000 (UTC)
Message-ID: <a9b811a84ac21c13693e6ffefd2914b911542e18.camel@suse.de>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Christoph Hellwig <hch@lst.de>,
        Amit Pundir <amit.pundir@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Date:   Mon, 27 Jul 2020 19:56:56 +0200
In-Reply-To: <20200724134114.GA3152@lst.de>
References: <550b30a86c0785049d24c945e2c6628d491cee3a.camel@suse.de>
         <CAMi1Hd2V2pJjP=USS4r-Z3vK-aq7_aBy-jcVNk1GvbdEQAuzWg@mail.gmail.com>
         <011994f8a717a00dcd9ed7682a1ddeb421c2c43f.camel@suse.de>
         <CAMi1Hd0=ZsGhTkSy221EP9Vb3GMOcS0UMczX2u5X9qK37_ea1A@mail.gmail.com>
         <01831596e4a2a6c9c066138b23bd30435f8e5569.camel@suse.de>
         <CAMi1Hd3C6kh5E49EgytBAQ_2AE_jvnp+eSNsxBYaux+exSvdbg@mail.gmail.com>
         <6db722947546221ed99d3f473f78e1a6de65d7d6.camel@suse.de>
         <CAMi1Hd0Xz6kOJFpA5PEpi6RDDGOcz0RmQ7tTOkuXq4QneOO_vQ@mail.gmail.com>
         <0dc1e922bf87fa73790e7471b3974528dd261486.camel@suse.de>
         <CAMi1Hd3O2HHBsnt=sac7FdcW0-3=4S3g_F9f__2h5gTsudfirA@mail.gmail.com>
         <20200724134114.GA3152@lst.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-qFFwwRyYdW0g8uHUD6n0"
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qFFwwRyYdW0g8uHUD6n0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,
thanks for having a look at this!

On Fri, 2020-07-24 at 15:41 +0200, Christoph Hellwig wrote:
> Yes, the iommu is an interesting case, and the current code is
> wrong for that.

Care to expand on this? I do get that checking dma_coherent_ok() on memory
that'll later on be mapped into an iommu is kind of silly, although I think
harmless in Amir's specific case, since devices have wide enough dma-ranges=
. Is
there more to it?

> Can you try the patch below?  It contains a modified version of Nicolas'
> patch to try CMA again for the expansion and a new (for now hackish) way =
to
> not apply the addressability check for dma-iommu allocations.
>=20
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 6bc74a2d51273e..ec5e525d2b9309 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -3,7 +3,9 @@
>   * Copyright (C) 2012 ARM Ltd.
>   * Copyright (C) 2020 Google LLC
>   */
> +#include <linux/cma.h>
>  #include <linux/debugfs.h>
> +#include <linux/dma-contiguous.h>
>  #include <linux/dma-direct.h>
>  #include <linux/dma-noncoherent.h>
>  #include <linux/init.h>
> @@ -55,6 +57,31 @@ static void dma_atomic_pool_size_add(gfp_t gfp, size_t
> size)
>  		pool_size_kernel +=3D size;
>  }
> =20
> +static bool cma_in_zone(gfp_t gfp)
> +{
> +	phys_addr_t end;
> +	unsigned long size;
> +	struct cma *cma;
> +
> +	cma =3D dev_get_cma_area(NULL);
> +	if (!cma)
> +		return false;
> +
> +	size =3D cma_get_size(cma);
> +	if (!size)
> +		return false;
> +	end =3D cma_get_base(cma) - memblock_start_of_DRAM() + size - 1;
> +
> +	/* CMA can't cross zone boundaries, see cma_activate_area() */
> +	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA) &&
> +	    end <=3D DMA_BIT_MASK(zone_dma_bits))
> +		return true;
> +	if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32) &&
> +	    end <=3D DMA_BIT_MASK(32))
> +		return true;
> +	return true;

IIUC this will always return true given a CMA is present. Which reverts to =
the
previous behaviour (previous as in breaking some rpi4 setups), isn't it?

Regards,
Nicolas


--=-qFFwwRyYdW0g8uHUD6n0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl8fFWgACgkQlfZmHno8
x/6obgf+LDzEyQY0PPgnBX0Bop85cj9nPiNdylLhZ6He/5cLrZMAcWtA69qcst1i
PQdp5ThWKd7Gd0mlmg+B9MdxgehKMf0q517j0pb4pBBxx96D4Hg/QjGSOfGeHLVe
9oaxYdxDf+xKTIn5v8myvHyQIHPYF8pkcVHp1M5b+q/Q9CUXpWB7wVQWM0vlcCIt
+HgRuyEzktxngXkRZsYCxmtEMEGGUri5klRs7O+M6Vbn+tlRHtYmjCFOEzmlXS9W
+bph7Ekf1b448fF2q5P7Xu5fhE7CYN8k8nr63AcVXVaLR/DsJ5GxjWFGKNye5/21
91Uk2Go4FCB6IrjoB9vmp5/TowXkOQ==
=D8U2
-----END PGP SIGNATURE-----

--=-qFFwwRyYdW0g8uHUD6n0--

