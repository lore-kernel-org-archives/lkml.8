Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57979C55194
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 20:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AEF42074F
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 20:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgDYUs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 16:48:28 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:59870 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgDYUs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 16:48:27 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 4BFFD1C0239; Sat, 25 Apr 2020 22:48:26 +0200 (CEST)
Date:   Sat, 25 Apr 2020 22:48:25 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v20 00/17] Multicolor Framework (array edition)
Message-ID: <20200425204825.GG23926@amd>
References: <20200423155524.13971-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AGZzQgpsuUlWC1xT"
Content-Disposition: inline
In-Reply-To: <20200423155524.13971-1-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AGZzQgpsuUlWC1xT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the multi color LED framework.   This framework presents clustered
> colored LEDs into an array and allows the user space to adjust the bright=
ness
> of the cluster using a single file write.  The individual colored LEDs
> intensities are controlled via a single file that is an array of
> LEDs

Thanks for the series.

I believe 6/, 11/, 15/, 16/ could be applied now. Should I do that?

8..10/ might be ready, too... but I'm not relevant maintainer, so
you'll need to push them separately. I added my acks.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--AGZzQgpsuUlWC1xT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl6kohkACgkQMOfwapXb+vLpywCgtnFlcDBg/pxDI0KMk2G36Aqn
m+wAn39TLf6iQqWHndo1xzZbd/hCybVK
=r30Z
-----END PGP SIGNATURE-----

--AGZzQgpsuUlWC1xT--
