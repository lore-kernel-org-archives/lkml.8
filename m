Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBA5C35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 10:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34B6217F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 10:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgBWKd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 05:33:26 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:58620 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgBWKd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 05:33:26 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 991AF1C036F; Sun, 23 Feb 2020 11:33:24 +0100 (CET)
Date:   Sun, 23 Feb 2020 11:33:23 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 032/191] usb: gadget: udc: fix possible
 sleep-in-atomic-context bugs in gr_probe()
Message-ID: <20200223103323.GD14067@amd>
References: <20200221072250.732482588@linuxfoundation.org>
 <20200221072255.095987384@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Content-Disposition: inline
In-Reply-To: <20200221072255.095987384@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Jia-Ju Bai <baijiaju1990@gmail.com>
>=20
> [ Upstream commit 9c1ed62ae0690dfe5d5e31d8f70e70a95cb48e52 ]
>=20
> The driver may sleep while holding a spinlock.

True, but you can't just fix that by removing the locking.

> +++ b/drivers/usb/gadget/udc/gr_udc.c
> @@ -2180,8 +2180,6 @@ static int gr_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
> =20
> -	spin_lock(&dev->lock);
> -
>  	/* Inside lock so that no gadget can use this udc until probe is done */
>  	retval =3D usb_add_gadget_udc(dev->dev, &dev->gadget);
>  	if (retval) {

As this comment tries to explain. It is possible that the comment can
just be removed, but it looks like the code needs to be rearranged so
that rest of system does not see partly-initialized device.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl5SVPMACgkQMOfwapXb+vLO7wCePfBiWkxUG6iwBB+/Zrtrmnaq
9GsAnibVRvR1tYRkGwmR5Die/TAMKTeg
=eY8A
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--
