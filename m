Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5E4C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9A920748
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgC0Luk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 07:50:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:53566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgC0Luj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 07:50:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CC6C8AB7F;
        Fri, 27 Mar 2020 11:50:38 +0000 (UTC)
Message-ID: <d7991163f6d0f500081b2798ee434116ce57ffec.camel@suse.de>
Subject: Re: [PATCH] ARM: bcm2835_defconfig: Enable fixed-regulator
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Mar 2020 12:50:37 +0100
In-Reply-To: <20200326134458.13992-1-nsaenzjulienne@suse.de>
References: <20200326134458.13992-1-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-WF16Mj6dPfgblFzyBCUd"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WF16Mj6dPfgblFzyBCUd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-03-26 at 14:44 +0100, Nicolas Saenz Julienne wrote:
> This regulator is now used to control the SD card's power supply on the
> Raspberry Pi 4.
>=20
> Suggested-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Applied for-next.

Regards,
Nicolas


--=-WF16Mj6dPfgblFzyBCUd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl596I0ACgkQlfZmHno8
x/6QaAf/R/VrfJrSqxqTlH5+WwUUila4oMiR537O8rk9WNGE0tVPfb4zlruLtE4H
USWVBiKC3FjV3VNpyO4EwmpdL5qerciK8L3s8Jla+miyPX/9cUtQtpAih44CxFa/
F0KoL8y08eJ1uyHrpZQzUq6MsczQlt5LenQV+US3p2+CHUCZ1LOhn5qmILzjX7wA
eUnRUz+F/O69uWu/MroVn50lA9so26oR8cZDANy33wBTMSJzaXuNHVPNsTR7/XU2
7eNwdrKVFe3HbZTlONDA4aI81OuUeka55eOtcKry29UCr3ivzEShjbvVcGEw5iK7
K8KwPiU70f8bqrJj0ya0hg/QzRbq+A==
=/KKZ
-----END PGP SIGNATURE-----

--=-WF16Mj6dPfgblFzyBCUd--

