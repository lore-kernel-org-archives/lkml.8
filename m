Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA901C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B69DF2173E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgHETp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:45:26 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:45454 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729186AbgHETpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 15:45:15 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 29CB91C0BD2; Wed,  5 Aug 2020 21:45:13 +0200 (CEST)
Date:   Wed, 5 Aug 2020 21:45:12 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Konrad Dybcio <konradybcio@gmail.com>
List-Id: <soc.lore.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL 0/5] ARM: SoC: changes for v5.9
Message-ID: <20200805194512.bh5hds2l46opcole@duo.ucw.cz>
References: <CAK8P3a1vFJ+uUGPGifZGhECXvxA=2u745WrGNZb08s1nHkZQ9g@mail.gmail.com>
 <20200805172746.GC1118@bug>
 <CAK8P3a2KnmDXYCyst15=kZWneDTMFAbz47F_TYnY_26+W4PM6A@mail.gmail.com>
 <CAMS8qEVzCtxrH-K4U4_TeHi3RXDQ7UeGo+sVnB-HPS0Y+mju-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="v2jz4bfp3v7pyu7z"
Content-Disposition: inline
In-Reply-To: <CAMS8qEVzCtxrH-K4U4_TeHi3RXDQ7UeGo+sVnB-HPS0Y+mju-w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v2jz4bfp3v7pyu7z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Thanks for all the kind words, I really appreciate it.

Thanks for good work :-).

> >My impression is that the newly added phones are still fairly rudimentar=
y,
> >but some others that were added in the past releases have gotten
> >further. I don't know any details, but I've added Konrad to Cc, he can
> >comment on his work.
>=20
> Thanks for adding me. The Sony sdm630/6 phones are shaping up really
> well, but most of the work is not upstreamed yet mainly due to SMMU
> maintainers not liking Qualcomm code and looking for cleaner
> solutions. As time progresses, more things will see the light of the
> upstream. The current-ish progress can be seen on my github [1]. And
> much more is yet to come.
>=20
> Regarding msm8992/4, there is a need for the 20nm DSI PHY driver. It
> exists for every other gen of qcom SoCs since 2013, but due to low
> interest in these platforms, this specific one never got there. I
> tried emailing the person who wrote most of the present ones, but
> gmail told me the mail didn't exist :shrug:.

I won't pretend to understand all this. Do you normally have modems
working?

> >> Should we have some kind of linux-phones mailing list? There is quite =
a lot of
> >> stuff common in phones.
>=20
> >PostmarketOS is probably the right place to look for this.
>=20
> First of all: postmarketOS, not PostmarketOS :P
>=20
> I would actually say that's incorrect. With the release of the
> PinePhone and the Librem 5, the Linux mobile community has entered its
> heyday and plenty mobile-oriented distributions have arisen (for
> example Mobian, Manjaro ARM, Pure OS-ARM etc.) and some have gotten
> more attention than before (think Ubuntu Touch, Maemo Leste). pmOS is
> only one of many.
>=20
> The current thing to do is every distro maintains their own kernel (or
> over 100 like in pmOS, which is terrible for the poor CI :/) and only
> a small percentage of patches end up being upstreamed for various
> reasons (clean-ness of the code, will of the maintainers, time
> constraints..). As time goes, we're gonna see more stuff being
> added.

I did not know how popular PinePhone is. Does it currently have useful
battery life?

Would something like phone@vger.kernel.org be useful for low-level
stuff?

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--v2jz4bfp3v7pyu7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXysMSAAKCRAw5/Bqldv6
8phFAJ4z18tm5ObumuMFHNk30LayrjBw8gCfZ7oRyGDbXIqWqqdKsst3BA+ROQ4=
=OxLd
-----END PGP SIGNATURE-----

--v2jz4bfp3v7pyu7z--
