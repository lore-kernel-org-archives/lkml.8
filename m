Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28B3C433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 22:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982A120758
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 22:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgGNWdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 18:33:50 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:53694 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgGNWdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 18:33:49 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id BA2741C0BD5; Wed, 15 Jul 2020 00:33:46 +0200 (CEST)
Date:   Wed, 15 Jul 2020 00:33:45 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Alexandre Courbot <gnurou@gmail.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH] leds: add NCT6795D driver
Message-ID: <20200714223344.GA20740@amd>
References: <20200713134114.137265-1-gnurou@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20200713134114.137265-1-gnurou@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add support for the LED feature of the NCT6795D chip found on some
> motherboards, notably MSI ones. The LEDs are typically used using a
> RGB connector so this driver creates one LED device for each color
> component.

Ok, let me take a look. What entries does it present in /sys?

We'll want you to switch to multicolor framework.

> Also add self as maintainer.

That will need to be separate patch, I'd be asking for trouble if I
took that.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8OMsgACgkQMOfwapXb+vL42wCeMS5VYBSWE5YVKlf8oN1Fujvx
nMcAoKbj+iXU1maSYd3fUX+vjt0CYC1I
=nAm1
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
