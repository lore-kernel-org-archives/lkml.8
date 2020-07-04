Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3316C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B84F21556
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgGDLzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 07:55:41 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:42754 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgGDLzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 07:55:41 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 445741C0BD2; Sat,  4 Jul 2020 13:55:39 +0200 (CEST)
Date:   Sat, 4 Jul 2020 13:55:38 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Kars Mulder <kerneldev@karsmulder.nl>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: Writing to a const pointer: is this supposed to happen?
Message-ID: <20200704115538.GD16083@amd>
References: <0c2bda4dd9e64a019d69339cf9054586@AcuMS.aculab.com>
 <33f8-5eff3180-187-71fa2980@45220895>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
In-Reply-To: <33f8-5eff3180-187-71fa2980@45220895>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2020-07-03 15:23:38, Kars Mulder wrote:
> > There ought to be one that returns a pointer to the first character
> > that isn't converted - but I'm no expert on the full range of these
> > functions.
>=20
> I've searched for a function that parses an int from a string and
> stores a pointer to the end; I can find some function simple_strtoul
> that matches this criterion, but it's documented as
>=20
>     "This function has caveats. Please use kstrtoul instead."
>=20
> ... and kstrtoul does not store a pointer to the end. The documentation
> of kstrtoul describes simple_strtoul as obsolete as well. Also, there's
> no simple_strtou16 function.
>=20
> It seems that the standard C function strtoul has the behaviour you
> describe as well, but this function is not defined in the kernel except
> for certain specific architectures.
>=20
> > The problem with strdup() is you get the extra (unlikely) failure path.
> > 128 bytes of stack won't be a problem if the function is (essentially)
> > a leaf.
> > Deep stack use is actually likely to be in the bowels of printf())
> > inside an obscure error path.
>=20
> The function already makes a call to kcalloc, so the unlikely out-of-
> memory error path already exists; a second memory allocation just
> makes it slightly less unlikely. The two new out-of-memory conditions
> do happen at different points of the function though, making them
> have different side effects. I could fix this by moving my code.
>=20
> As for this function being a leaf: keep in mind that this function has
> the potential of calling printk in an obscure error condition (the user-
> provided parameter being longer that 128 characters); quirks_param_set
> calls param_set_copystring, which on its turn calls pr_err, which is a
> macro for printk.
>=20
> Meanwhile, here's a patch for copying the parameter to the stack:

Looks good, I guess Signed-off-by would be useful.

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8AbjoACgkQMOfwapXb+vKN9wCfbUQeFanURlw6+rWB0+p1vitW
CvcAoInhzXKCjxwgcisiagABa62iJmaG
=u4ct
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
