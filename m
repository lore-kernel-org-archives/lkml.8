Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21C1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF09D2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgHDJnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:43:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:55056 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgHDJnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 05:43:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 747B9ADE5;
        Tue,  4 Aug 2020 09:43:36 +0000 (UTC)
Message-ID: <e0b2a00c8cf86cb1a91804942d35c9d4b98e9f9f.camel@suse.de>
Subject: Re: [PATCH v2 2/2] dma-pool: Only allocate from CMA when in same
 memory zone
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     amit.pundir@linaro.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, rientjes@google.com,
        jeremy.linton@arm.com, linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Date:   Tue, 04 Aug 2020 11:43:15 +0200
In-Reply-To: <20200804060633.GA7368@lst.de>
References: <20200803160956.19235-1-nsaenzjulienne@suse.de>
         <20200803160956.19235-3-nsaenzjulienne@suse.de>
         <20200804060633.GA7368@lst.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-37n9dG1PtRrqctFyLGEb"
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-37n9dG1PtRrqctFyLGEb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-08-04 at 08:06 +0200, Christoph Hellwig wrote:
> On Mon, Aug 03, 2020 at 06:09:56PM +0200, Nicolas Saenz Julienne wrote:
> > +	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
> > +		return end <=3D DMA_BIT_MASK(zone_dma_bits);
> > +	if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
> > +		return end <=3D DMA_BIT_MASK(32);
> > +	if (gfp & GFP_KERNEL)
> > +		return end > DMA_BIT_MASK(32);
>=20
> So the GFP_KERNEL one here looks weird.  For one I don't think the if
> line is needed at all, and it just confuses things.

Yes, sorry, shoud've seen that.

> Second I don't see the need (and actually some harm) in preventing GFP_KE=
RNEL
> allocations from dipping into lower CMA areas - something that we did sup=
port
> before 5.8 with the single pool.

My thinking is the least we pressure CMA the better, it's generally scarse,=
 and
it'll not grow as the atomic pools grow. As far as harm is concerned, we no=
w
check addresses for correctness, so we shouldn't run into problems.

There is a potential case for architectures defining a default CMA but not
defining DMA zones where this could be problematic. But isn't that just pla=
in
abusing CMA? If you need low memory allocations, you should be defining DMA
zones.

Regards,
Nicolas


--=-37n9dG1PtRrqctFyLGEb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl8pLbMACgkQlfZmHno8
x/6CFQgAroY7OAksNUQQ1MqKTFjhXVRYkfoAZYNmH6unfh6DBZ8bbSiIy9zgoaP8
W4Ve63kWqEzS9f64iOzDugZuZA5Cxs8w7ELVhNtfxN/qdLNHYOA3BkDsvDy+fHcD
Q5ITY/XPPFvGoLsI8N4z1DT4GAnS3iRZhl9LzslqGoOyQPcl9iLgVrxCOWDNhAek
7HGtXe+7mTFogwtf6r03ywUQCpBs56ZFXAbzKfeyhMSUHNjz4rPlfruOW8GpyMvA
JZeK2B6Pk4QSads310PrY4ZRkLYO2vmrYlFXSOosFv7oF6wwd7wnYMVI05JuQ7Yo
55KdR6h6r+HQ7BslvbaH8GDPGMiYhA==
=Ah73
-----END PGP SIGNATURE-----

--=-37n9dG1PtRrqctFyLGEb--

