Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD73C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B32CA20739
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgGHKfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 06:35:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:42246 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgGHKfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 06:35:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52AA1AC53;
        Wed,  8 Jul 2020 10:35:37 +0000 (UTC)
Message-ID: <21a7276e98ae245404d82537ac1ee597a92f9150.camel@suse.de>
Subject: Re: [PATCH] dma-pool: use single atomic pool for both DMA zones
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Jeremy Linton <jeremy.linton@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Wed, 08 Jul 2020 12:35:34 +0200
In-Reply-To: <e6504dc5-4169-edf9-d08e-17a378a1ef7a@arm.com>
References: <20200707122804.21262-1-nsaenzjulienne@suse.de>
         <e6504dc5-4169-edf9-d08e-17a378a1ef7a@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-bnAJ3XLxuxNA1ZPiHOdm"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bnAJ3XLxuxNA1ZPiHOdm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jim,

On Tue, 2020-07-07 at 17:08 -0500, Jeremy Linton wrote:
> Hi,
>=20
> I spun this up on my 8G model using the PFTF firmware from:
>=20
> https://github.com/pftf/RPi4/releases
>=20
> Which allows me to switch between ACPI/DT on the machine. In DT mode it=
=20
> works fine now,=20

Nice, would that count as a Tested-by from you?

> but with ACPI I continue to have failures unless I=20
> disable CMA via cma=3D0 on the kernel command line.=20

Yes, I see why, in atomic_pool_expand() memory is allocated from CMA withou=
t
checking its correctness. That calls for a separate fix. I'll try to think =
of
something.

> It think that is because
>=20
> using DT:
>=20
> [    0.000000] Reserved memory: created CMA memory pool at
> 0x0000000037400000, size 64 MiB
>=20
>=20
> using ACPI:
> [    0.000000] cma: Reserved 64 MiB at 0x00000000f8000000
>=20
> Which is AFAIK because the default arm64 CMA allocation is just below=20
> the arm64_dma32_phys_limit.

As I'm sure you know, we fix the CMA address trough DT, isn't that possible
trough ACPI?

Regards,
Nicolas


--=-bnAJ3XLxuxNA1ZPiHOdm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl8FoXYACgkQlfZmHno8
x/4A1Af/cSs8xlWTPpYUFQ6HpjKk8LJ80zIBr1nld7DKsJH3aV7pkT2+pDvdro26
g4qSXpPsH+9Ru29z1eViXhXNwyazsyXUCHOY66QdlFVFtWnD8wYqxQj7cWCyiRwE
+DiHDBRH69MusXE+11rstR2JBJDISdNYxyLAEAByDRfxq0CHYLI2mIY69Qdu3qK/
G8Udgvqpjc+S7ywvgxVMOVIxKRdq+QpkjaToQt0u8V1VGaKqQ61lNVOYzmCRyeIF
4f3Y+nBqL36I5n5GWY/qmNurJkcy7JuEYXtf6+0bupSM7wHbPCTxweaL4kKaJEwn
/JaA8YIaJjTDqEpYesnAiuSGN/ckTw==
=PfbY
-----END PGP SIGNATURE-----

--=-bnAJ3XLxuxNA1ZPiHOdm--

