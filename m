Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A57DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC9C620715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgGFOJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:09:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:55352 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729121AbgGFOJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:09:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 60CABAD89;
        Mon,  6 Jul 2020 14:09:39 +0000 (UTC)
Message-ID: <32ee3bf222b1966caa98b67a9cec8712817a4b52.camel@suse.de>
Subject: Re: [BUG] XHCI getting ZONE_DMA32 memory > than its bus_dma_limit
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     David Rientjes <rientjes@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mm@kvack.org,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Date:   Mon, 06 Jul 2020 16:09:36 +0200
In-Reply-To: <alpine.DEB.2.23.453.2007051635250.3687564@chino.kir.corp.google.com>
References: <34619bdf-6527-ae82-7e4d-e2ea7c67ed56@arm.com>
         <a9058fd2c54bbea69fdf97e30277338a61b5c0b4.camel@suse.de>
         <cc17fe85-99a3-ec8c-985a-2a21cf09bf49@arm.com>
         <alpine.DEB.2.23.453.2007051635250.3687564@chino.kir.corp.google.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Lcrx70eLFfcZwFObGsLO"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Lcrx70eLFfcZwFObGsLO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2020-07-05 at 16:41 -0700, David Rientjes wrote:
> On Fri, 3 Jul 2020, Robin Murphy wrote:
>=20
> > > Just for the record the offending commit is: c84dc6e68a1d2 ("dma-pool=
: add
> > > additional coherent pools to map to gfp mask").
> > >=20
> > > On Thu, 2020-07-02 at 12:49 -0500, Jeremy Linton wrote:
> > > > Hi,
> > > >=20
> > > > Using 5.8rc3:
> > > >=20
> > > > The rpi4 has a 3G dev->bus_dma_limit on its XHCI controller. With a=
 usb3
> > > > hub, plus a few devices plugged in, randomly devices will fail
> > > > operations. This appears to because xhci_alloc_container_ctx() is
> > > > getting buffers > 3G via dma_pool_zalloc().
> > > >=20
> > > > Tracking that down, it seems to be caused by dma_alloc_from_pool() =
using
> > > > dev_to_pool()->dma_direct_optimal_gfp_mask() to "optimistically" se=
lect
> > > > the atomic_pool_dma32 but then failing to verify that the allocatio=
ns in
> > > > the pool are less than the dev bus_dma_limit.
> > >=20
> > > I can reproduce this too.
> > >=20
> > > The way I see it, dev_to_pool() wants a strict
> > > dma_direct_optimal_gfp_mask()
> > > that is never wrong, since it's going to stick to that pool for the
> > > device's
> > > lifetime. I've been looking at how to implement it, and it's not so
> > > trivial
> > > as
> > > I can't see a failproof way to make a distinction between who needs D=
MA32
> > > and
> > > who is OK with plain KERNEL memory.
> > >=20
> > > Otherwise, as Jeremy points out, the patch needs to implement allocat=
ions
> > > with
> > > an algorithm similar to __dma_direct_alloc_pages()'s, which TBH I don=
't
> > > know
> > > if
> > > it's a little overkill for the atomic context.
> > >=20
> > > Short of finding a fix in the coming rc's, I suggest we revert this.
> >=20
> > Or perhaps just get rid of atomic_pool_dma32 (and allocate atomic_pool_=
dma
> > from ZONE_DMA32 if !ZONE_DMA). That should make it fall pretty much bac=
k in
> > line while still preserving the potential benefit of the kernel pool fo=
r
> > non-address-constrained devices.
> >=20
>=20
> I assume it depends on how often we have devices where=20
> __dma_direct_alloc_pages() behavior is required, i.e. what requires the=
=20
> dma_coherent_ok() checks and altering of the gfp flags to get memory that=
=20
> works.
>=20
> Is the idea that getting rid of atomic_pool_dma32 would use GFP_KERNEL=
=20
> (and atomic_pool_kernel) as the default policy here?  That doesn't do any=
=20
> dma_coherent_ok() checks so dma_direct_alloc_pages would return from=20
> ZONE_NORMAL without a < 3G check?

IIUC this is not what Robin proposes.

The idea is to only have one DMA pool, located in ZONE_DMA, if enabled, and
ZONE_DMA32 otherwise. This way you're always sure the memory is going to be
good enough for any device while maintaining the benefits of
atomic_pool_kernel.

> It *seems* like we want to check if dma_coherent_ok() succeeds for ret in=
=20
> dma_direct_alloc_pages() when allocating from the atomic pool and, based=
=20
> on criteria that allows fallback, just fall into=20
> __dma_direct_alloc_pages()?

I suspect I don't have enough perspective here but, isn't that breaking the
point of having an atomic pool? Wouldn't that generate big latency spikes? =
I
can see how audio transfers over USB could be affected by this specifically=
,
IIRC those are allocated atomically and have timing constraints.

That said, if Robin solution works for you, I don't mind having a go at it.

Regards,
Nicolas


--=-Lcrx70eLFfcZwFObGsLO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl8DMKAACgkQlfZmHno8
x/4PFwf8Capzlqn/Uy/aJ6xtWqywe8OWD8Bp6nVhwYFcckHhezshHDDl24+KBv3k
nu27VBCWkHQ/zlOjIJtNhsPPX/Jx5es/SwRSqCU+zl1lB0GdwPZwLWpCXAEGOnsX
A9FvFRMTxKU8U8ejMFhhOQguZNprBhlBGvyrMCxuj/ZkOn2Y/P6IUdbGPTUdE+/e
CzPEIdc3M1YwWQrTR2XqC+/Ep0VwlU6GM10UYtf3R/BSIcjp5kHQlde3RB69OmCM
fl69IxeAm1YWKbzx70a+bLzIfVRCjUXcTV9eOO/90IIzX8YFZgKFFyDpGNVhrbwc
9ccaHAnpo8yHTIWxMt5N8Tpj0HdtKw==
=bUSO
-----END PGP SIGNATURE-----

--=-Lcrx70eLFfcZwFObGsLO--

