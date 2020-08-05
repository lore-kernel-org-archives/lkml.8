Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221CFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E254422EBE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgHETco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:32:44 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:44580 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbgHETcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 15:32:35 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C9CC71C0BDE; Wed,  5 Aug 2020 21:32:33 +0200 (CEST)
Date:   Wed, 5 Aug 2020 21:32:33 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Konrad Dybcio <konradybcio@gmail.com>
Subject: Re: [GIT PULL 0/5] ARM: SoC: changes for v5.9
Message-ID: <20200805193233.hp6mrzccs6p2pz2g@duo.ucw.cz>
References: <CAK8P3a1vFJ+uUGPGifZGhECXvxA=2u745WrGNZb08s1nHkZQ9g@mail.gmail.com>
 <20200805172746.GC1118@bug>
 <CAK8P3a2KnmDXYCyst15=kZWneDTMFAbz47F_TYnY_26+W4PM6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="l2livdf6ntlighw4"
Content-Disposition: inline
In-Reply-To: <CAK8P3a2KnmDXYCyst15=kZWneDTMFAbz47F_TYnY_26+W4PM6A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l2livdf6ntlighw4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2020-08-05 21:06:45, Arnd Bergmann wrote:
> On Wed, Aug 5, 2020 at 7:27 PM Pavel Machek <pavel@ucw.cz> wrote:
> > > 2. In the past few merge windows we have seen an increase in (usually
> > >    older) Android phones and tablets gaining mainline kernel support.
> > >    This time we get a total of eight Snapdragon phones and two Tegra
> > >    tablets. To me this indicates that we finally have sufficient driv=
er
> > >    support, in particular on the GPU side, to make this workable.
> > >    It also shows the impact that a single hobbyist developer can have,
> > >    as most of the new support was submitted by Konrad Dybcio who only
> > >    started contributing kernel patches to mainline Linux for postmark=
etos
> > >    earlier this year.
> >
> > I'm happy to see that. So far, Nokia N900 is reaonably supported (basic=
ally everything
> > but Bluetooth works, voicecalls miss userland daemon for audio), and Mo=
torola
> > Droid 4 (modem needs some more in kernel, camera will be hard).
> >
> > Is there anything with similar support coming in, or is it usual "it bo=
ots,
> > serial console works"?
>=20
> My impression is that the newly added phones are still fairly rudimentary,
> but some others that were added in the past releases have gotten
> further. I don't know any details, but I've added Konrad to Cc, he can
> comment on his work.
>=20
> One of the missing pieces with the OMAP based phones has always
> been the GPU, and on that front I think by now almost every other GPU
> is ahead.

I have working 3D on Droid 4 with Maemo Leste... but I'm not sure what
kind of hacks are involved. (And not sure I want to know).

> > Should we have some kind of linux-phones mailing list? There is quite a=
 lot of
> > stuff common in phones.
>=20
> PostmarketOS is probably the right place to look for this.

Yes, I monitor postmarketOS a bit.

But I believe we should have something cross-distro. I'm more involved
with Maemo Leste, but there are other players -- at least Librem and
Jolla.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--l2livdf6ntlighw4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXysJUQAKCRAw5/Bqldv6
8lCsAJ4si4Dy8ZQ5LESLKIwkKq7mrToYaQCeIpY7FJaklNDYssEO5SS40hDc34k=
=Ck0F
-----END PGP SIGNATURE-----

--l2livdf6ntlighw4--
