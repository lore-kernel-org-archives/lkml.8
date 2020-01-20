Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9642FC33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 11:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CBB2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 11:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgATLEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 06:04:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:35194 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgATLEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 06:04:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5AAEEAB98;
        Mon, 20 Jan 2020 11:03:59 +0000 (UTC)
Message-ID: <936f10bbeca467ea8ebc669280a50c688730689d.camel@suse.de>
Subject: Re: [PATCH] ARM: dts: bcm2711: Use bcm2711 compatible for sdhci
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stephen Brennan <stephen@brennan.io>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Date:   Mon, 20 Jan 2020 12:03:51 +0100
In-Reply-To: <20200120041740.193485-1-stephen@brennan.io>
References: <20200120041740.193485-1-stephen@brennan.io>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-1hEev43/tJ9sBH/p5ozK"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1hEev43/tJ9sBH/p5ozK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Sun, 2020-01-19 at 20:17 -0800, Stephen Brennan wrote:
> When booting Raspberry Pi 4B using a micro SDHC UHS class 1 card, the SD
> card partitions never appear in /dev.  According to the device tree
> bindings for Broadcom IPROC SDHCI controller, we should use
> "brcm,bcm2711-emmc2" compatible string on BCM2711. Set this compatible
> string, which allows these cards to be mounted.
>=20
> Signed-off-by: Stephen Brennan <stephen@brennan.io>

Your UHS class 1 card should work out of the box using the current kernel
version. Note that the device node is defined here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/arm/boot/dts/bcm2711.dtsi?h=3Dv5.5-rc7#n255

and enabled here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/arm/boot/dts/bcm2711-rpi-4-b.dts?h=3Dv5.5-rc7#n98

Regards,
Nicolas


--=-1hEev43/tJ9sBH/p5ozK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl4liRcACgkQlfZmHno8
x/4HgAf+NZ4dXRnz4viAUpt3yt45XQkO90pfw8tprx62Kg/wpWACbrlLmpQFPAN1
J+TyaIUKBbYtLbEnpt2uXERW80/KfLJYTdoRf5cxFA9GUzGgMNQwr8Oy+L9VPXRm
sdYrsAZYC9DsSyHdUsxiDlOAGTDoWGvoogcpXML1xj9M/SDrNM2zUGLM2tIBJNGf
YN3/iq25yumk1zFVJ9Jp3zWEjGxUIUGenWgzVw/2G2GGyYByHM99lNa/M9dDPnrW
l8O8RaDq/S+qBeEPdRsInN4ZKIv/adIASRHbuM4ExTpJ+ecvOmVotfdNBZCBLE4K
fdGlhkO0iOwNtO0KiYA6IUdBjGNzMQ==
=Inmb
-----END PGP SIGNATURE-----

--=-1hEev43/tJ9sBH/p5ozK--

