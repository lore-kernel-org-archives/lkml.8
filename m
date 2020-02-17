Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641B2C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 20:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438072070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 20:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgBQUSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 15:18:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:59992 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728519AbgBQUSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 15:18:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AF18BAAC2;
        Mon, 17 Feb 2020 20:18:35 +0000 (UTC)
Message-ID: <5eca1bbe77c8731f1eafd11a3bf0df25196d08d4.camel@suse.de>
Subject: Re: [PATCH] ARM: bcm2835_defconfig: add minimal support for
 Raspberry Pi4
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>
Date:   Mon, 17 Feb 2020 21:18:34 +0100
In-Reply-To: <9330d511-dc7d-8d67-043a-acee7e6ebd73@samsung.com>
References: <CGME20200214151840eucas1p2ccd15a69aea02a20eda1e4b6e9c8f44e@eucas1p2.samsung.com>
         <C0LZGU1IU7QO.9VKWHWJ56XZV@vian>
         <9330d511-dc7d-8d67-043a-acee7e6ebd73@samsung.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-J2gniWakOkK7NLSAQW+2"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-J2gniWakOkK7NLSAQW+2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[ Adding Florian to the coversation ]

On Mon, 2020-02-17 at 13:22 +0100, Marek Szyprowski wrote:
> Hi Nicolas,
> On 14.02.2020 16:14, Nicolas Saenz Julienne wrote:
> > IMO bcm2711_defconfig if the last resort solution. I don't think you ca=
n
> > do bcm2835_lpae_defconfig as RPi and RPi2 SoCs don't support LPAE.
>=20
> Okay, if you want I can send a patch adding bcm2711_defconfig.
>=20
> > An intemediate solution is being discussed here:
> > https://lkml.org/lkml/2020/1/10/694
>=20
> Right, I also agree that multi_v7_lpae_defconfig is needed. Best would=
=20
> be to have both (bcm2711 for quick tests of board-dedicated kernel and=
=20
> multi for distributions).

So I understand you'd be creating a new bcm2711_defconfig based on
bcm2835_defconfig plus whatever is needed. Sounds OK to me. It'd be nice to
have a small kernel config to do bisects with.

Any comments Florian, Stefan?

Regards,
Nicolas


--=-J2gniWakOkK7NLSAQW+2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5K9RoACgkQlfZmHno8
x/7+CQgAlX6GuRQwDDhcjqF4J1qacdRU58hzBDuQDgSqKXrWBRseYfz6scxL16e8
gGgBIHtSwkIsqaaJjEp/WYSYikXcQDwCBy7OS3zwe8L3UoYzV5/jJz6QZneFybTd
VKhxnTshUc6sR1KCHdrnHIPLKK1uTAFedr1lNh6hCpGULt/j65fFWYaKCBk/BGq1
hsYNgafWEGpN+EtnNJ0g3BBknUYtEcp8tUh1JpNK1wgYnjFKdgK5voJYwiTbEZXD
3KyWicIpKoPUOza2OWj8desQGizfbmsqPcvcPv9MC9Vgk9Vr0pVBG1AT8t3Pz0oz
zbPKnTOksDehURKeZzFwI5nj5/GPrA==
=1B/n
-----END PGP SIGNATURE-----

--=-J2gniWakOkK7NLSAQW+2--

