Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0579C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7679B2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgFOI4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:56:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:53576 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729018AbgFOI4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:56:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ECEE0AA7C;
        Mon, 15 Jun 2020 08:56:51 +0000 (UTC)
Message-ID: <1f5863414c56e45398a3660d718da81126af430a.camel@suse.de>
Subject: Re: [PATCH v4 5/5] usb: xhci-pci: Add reset controller support
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Marek Vasut <marex@denx.de>, mbrugger@suse.com,
        u-boot@lists.denx.de, bmeng.cn@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     sjg@chromium.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        mark.kettenis@xs4all.nl
Date:   Mon, 15 Jun 2020 10:56:45 +0200
In-Reply-To: <7959ad10-4112-e880-14d9-9c24574c8026@denx.de>
References: <20200612164632.25648-1-nsaenzjulienne@suse.de>
         <20200612164632.25648-6-nsaenzjulienne@suse.de>
         <7959ad10-4112-e880-14d9-9c24574c8026@denx.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-eWvZBlqpVqim0ArsX7ky"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eWvZBlqpVqim0ArsX7ky
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-06-12 at 19:08 +0200, Marek Vasut wrote:
> On 6/12/20 6:46 PM, Nicolas Saenz Julienne wrote:
> > Some atypical users of xhci-pci might need to manually reset their xHCI
> > controller before starting the HCD setup. Check if a reset controller
> > device is available to the PCI bus and trigger a reset.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >  drivers/usb/host/xhci-pci.c | 38 +++++++++++++++++++++++++++++++++++--
> >  1 file changed, 36 insertions(+), 2 deletions(-)
>=20
> Can the XHCI core code do the reset management instead ? Then everyone
> benefits from it.

I'll look into it.

> The rest of the series is nice, thanks.

Thanks!

Regards,
Nicolas



--=-eWvZBlqpVqim0ArsX7ky
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7nN80ACgkQlfZmHno8
x/72RAgAgD80smgpcmi5WtdW5GX+k5TR7ZDGlh1+H4Byg7EXCfL+/o0bWqQIUSA2
M8yk2gZwNLYnWfF5LYVqBio70I2Kaj4bim6W4py5d7M9TMZq+/pFtIyAD3tH+Ni1
Z+fW+75mhkEZz0K6fJOGYiF0pa+R3QkHtKhNluBRf4QKzu1ZTz0iQhNG2qKlsnMG
UdVuPlLn9asWtKgeZlsMp3CqBAWmEtnoZ2uzclmwvWUa5JSe1jFHWHvFicOeKT0F
kNKCdR/gJe0fBXHGh5iPzZ1kSOh1YJ0JHpm3GKW+TKMbe2GKoMvC76gQUHzgPqZo
0U/ajTPrV3mtIMlZPB7TviyeihZKfA==
=7138
-----END PGP SIGNATURE-----

--=-eWvZBlqpVqim0ArsX7ky--

