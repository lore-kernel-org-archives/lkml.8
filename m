Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02981C433F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2BC22070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgGTN5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:57:42 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:53682 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgGTN5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:57:42 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6CB0E1C0BE2; Mon, 20 Jul 2020 15:57:39 +0200 (CEST)
Date:   Mon, 20 Jul 2020 15:57:39 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Alexandre Courbot <gnurou@gmail.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH] leds: add NCT6795D driver
Message-ID: <20200720135739.GA25390@amd>
References: <20200713134114.137265-1-gnurou@gmail.com>
 <20200714223344.GA20740@amd>
 <CAAVeFuKomLcAue9rGXhK3Uc=H+v9ZLBA84Ozr_rZDRQMYeC=dg@mail.gmail.com>
 <17fe52a2-73ff-b547-8a59-5df009c929c8@gmail.com>
 <CAAVeFuJQCp7Fpqx3nUHMy29Jw1pLNoQtxRw3qxfEf3YKnrm0fw@mail.gmail.com>
 <20200717074410.GA8895@amd>
 <756fa49f-bf67-0447-cf45-1358b66c40f8@gmail.com>
 <CAAVeFuLxKO9nJ+1GDuAr+-Z_BQMZpEVD46F2j=dZ3hDUv-eE=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <CAAVeFuLxKO9nJ+1GDuAr+-Z_BQMZpEVD46F2j=dZ3hDUv-eE=A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > According to common LED bindings you should propose a new function
> > if none of the existing ones fits your needs.
> >
> > > This is normally used for motherboard lightning, right? I believe this
> > > is getting common on gaming boards, and we want common support for
> > > that.
> >
> > I agree.
>=20
> These boards are indeed far from being a rarity so having a function
> for them (maybe named LED_FUNCTION_RGB_HEADER?) makes sense IMHO. I'll
> submit a patch for that with the next revision.

I'd call it something LED_FUNCTION_INTERNALS, and make it clear this
is for illuminating machine internals.

> Speaking of which, after looking at the multicolor patchset it is
> pretty obvious that it would be a much better way to expose this RGB
> header, so I think I will wait until it is merged and adapt the driver
> to use it.

Take a look at LED tree today, or linux-next tommorow. Basics should
be there.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8VotIACgkQMOfwapXb+vKNcgCgjuVOW4eF5G/5uj4aPjCntFch
a3MAn1mc7n0bgxRW40r1DsSqabTZrizE
=thMV
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
