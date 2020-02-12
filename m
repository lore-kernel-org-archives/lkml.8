Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1ADC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 18:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB0B20724
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 18:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgBLSbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 13:31:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:57904 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbgBLSbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 13:31:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D1983AE46;
        Wed, 12 Feb 2020 18:31:49 +0000 (UTC)
Message-ID: <a1d66025baa13b2276b12405544fc7107aac8d6c.camel@suse.de>
Subject: Re: [PATCH] ARM: bcm2835_defconfig: add minimal support for
 Raspberry Pi4
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Stefan Wahren <stefan.wahren@i2se.com>
Date:   Wed, 12 Feb 2020 19:31:47 +0100
In-Reply-To: <20200212102009.17428-1-m.szyprowski@samsung.com>
References: <CGME20200212102022eucas1p1c49daf15d3e63eda9a56124bc4eafb57@eucas1p1.samsung.com>
         <20200212102009.17428-1-m.szyprowski@samsung.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ITbJ1iHkW+ijPO3M83tC"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ITbJ1iHkW+ijPO3M83tC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marek,
On Wed, 2020-02-12 at 11:20 +0100, Marek Szyprowski wrote:
> Add drivers for the minimal set of devices needed to boot Raspberry Pi4
> board.
>=20
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Just so you know, the amount of support on the RPi4 you might be able to ge=
t
updating bcm2835_defconfig's config is very limited. Only 1GB of ram and no
PCIe (so no USBs).

FYI I've been working on getting a workable configuration for arm32, short =
of
creating a new config altogether:
https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg163770.html

That said, if you insist on booting with bcm2835_defconfig, I have no probl=
em
with the patch.

Regards,
Nicolas

>  arch/arm/configs/bcm2835_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/arm/configs/bcm2835_defconfig
> b/arch/arm/configs/bcm2835_defconfig
> index 519ff58e67b3..b5e7c1bd95f2 100644
> --- a/arch/arm/configs/bcm2835_defconfig
> +++ b/arch/arm/configs/bcm2835_defconfig
> @@ -72,6 +72,7 @@ CONFIG_BLK_DEV_SD=3Dy
>  CONFIG_SCSI_CONSTANTS=3Dy
>  CONFIG_SCSI_SCAN_ASYNC=3Dy
>  CONFIG_NETDEVICES=3Dy
> +CONFIG_BCMGENET=3Dy
>  CONFIG_USB_LAN78XX=3Dy
>  CONFIG_USB_USBNET=3Dy
>  CONFIG_USB_NET_SMSC95XX=3Dy
> @@ -99,6 +100,8 @@ CONFIG_THERMAL=3Dy
>  CONFIG_BCM2835_THERMAL=3Dy
>  CONFIG_WATCHDOG=3Dy
>  CONFIG_BCM2835_WDT=3Dy
> +CONFIG_REGULATOR=3Dy
> +CONFIG_REGULATOR_GPIO=3Dy
>  CONFIG_MEDIA_SUPPORT=3Dy
>  CONFIG_MEDIA_CAMERA_SUPPORT=3Dy
>  CONFIG_DRM=3Dy


--=-ITbJ1iHkW+ijPO3M83tC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5ERJMACgkQlfZmHno8
x/7nMwf/V2o3WeDmAvMxxux/NwAAfKHB2HFIpdC962NUNKnoHxaP27wl/nzWhkXe
8ly7F1qMnQPcU8rnO3CyoZeRrlplQhg1Z8/RcXEmr83Ua5gj9eyrahwnJneui2BZ
bR+oZFOiGo40QJtNdjm16dT59SbiLfcskyiLOqNEItCehxf1qb22hc3Vz0aSeEXI
xd6qhcCU/KvQYyJWm0Izq3l0U43roUfhcqm89oVyZJq6lWT+RbS4KfYjNQA0OxkG
H8BSyfiK9RyY7XbCq/rpcKBnTvXCm3Lm9B6nuHGJBV31HeaukFzWJR+LhJ+pIxgX
xCtJYAy26dqMGTLAsu9F/XZ51sk6YA==
=gfp3
-----END PGP SIGNATURE-----

--=-ITbJ1iHkW+ijPO3M83tC--

