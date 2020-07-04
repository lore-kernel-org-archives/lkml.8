Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A509C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C8E920890
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgGDUJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 16:09:26 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:49892 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgGDUJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 16:09:26 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0A9101C0C0E; Sat,  4 Jul 2020 22:09:24 +0200 (CEST)
Date:   Sat, 4 Jul 2020 22:09:23 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     =?utf-8?B?5a2Z5LiW6b6Z?= sunshilong <sunshilong369@gmail.com>
Cc:     Greg KH <greg@kroah.com>,
        kernelnewbies <Kernelnewbies@kernelnewbies.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Are there some potentially serious problems that I should be
 aware of if I totally disable the CONFIG_ACPI option on the X86_64 platform?
Message-ID: <20200704200923.GB24405@amd>
References: <CAAvDm6bGBbN=EiJxO9Fq9HqLz6F=hSQqjKms_G6qPHzbZ6G3zg@mail.gmail.com>
 <20200704122222.GB15530@amd>
 <CAAvDm6bjTzcRXs0qMF2nTo_mfEDE1MYbh_ExMojOMNZ9H+iKVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline
In-Reply-To: <CAAvDm6bjTzcRXs0qMF2nTo_mfEDE1MYbh_ExMojOMNZ9H+iKVg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2020-07-04 21:34:36, =E5=AD=99=E4=B8=96=E9=BE=99 sunshilong wrote:
> Thank you for taking the time to respond to me.
>=20
> >These machines are still mostly IBM-PC compatible, so it is likely to
> >somehow work. You'll likely get worse power and thermal
> >management. Try it.
> It's an industrial personal computer with an Intel processor.
> What I am worried about is that it may damage the hardware.

I'd simply try it. Risk is really quite low...

If in doubt, you could ask vendor.

But you will not get definitive answers on the mailing list...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8A4fMACgkQMOfwapXb+vJskQCgpOmIeZIRft+5g2tDz2REqdy+
q3IAnisn+kDNmQTDep9iYwwcNzDzImLK
=40+X
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
