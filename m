Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE01C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 21:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 007642065C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 21:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgFNV3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 17:29:13 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:48594 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgFNV3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 17:29:13 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C48C11C0BD2; Sun, 14 Jun 2020 23:29:11 +0200 (CEST)
Date:   Sun, 14 Jun 2020 23:29:11 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Jiri Slaby <jslaby@suse.cz>, SeongJae Park <sjpark@amazon.com>,
        Joe Perches <joe@perches.com>, akpm@linux-foundation.org,
        apw@canonical.com, SeongJae Park <sjpark@amazon.de>,
        colin.king@canonical.com, sj38.park@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Recommend denylist/allowlist instead of
 blacklist/whitelist
Message-ID: <20200614212911.GB24529@amd>
References: <20200611073804.10225-1-sjpark@amazon.com>
 <38ac91ab-ced3-8a4f-b825-4503fdcddeb8@suse.cz>
 <877dwcfitg.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline
In-Reply-To: <877dwcfitg.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2020-06-13 00:40:59, Michael Ellerman wrote:
> Jiri Slaby <jslaby@suse.cz> writes:
> > On 11. 06. 20, 9:38, SeongJae Park wrote:
> >> On Wed, 10 Jun 2020 23:35:24 -0700 Joe Perches <joe@perches.com> wrote:
> >>> On Thu, 2020-06-11 at 08:25 +0200, SeongJae Park wrote:
> >>>> From: SeongJae Park <sjpark@amazon.de>
> >>>>
> >>>> This patchset 1) adds support of deprecated terms in the 'checkpatch=
=2Epl'
> >>>> and 2) set the 'blacklist' and 'whitelist' as deprecated with
> >>>> replacement suggestion of 'denylist' and 'allowlist', because the
> >>>> suggestions are incontrovertible, doesn't make people hurt, and more
> >>>> self-explanatory.
> >>>
> >>> While the checkpatch implementation is better,
> >>> I'm still very "meh" about the whole concept.
> >>=20
> >> I can understand your concerns about politic things in the second patc=
h.
> >> However, the concept of the 'deprecated terms' in the first patch is n=
ot
> >> political but applicable to the general cases.  We already had the com=
mits[1]
> >> for a similar case.  So, could you ack for at least the first patch?
> >>=20
> >> [1] https://www.phoronix.com/scan.php?page=3Dnews_item&px=3DLinux-Kern=
el-Hugs
> >
> > Fuck you! replaced by hug you! is a completely different story. The
> > former is indeed offending to majority (despite it's quite common to
> > tell someone "fuck you" in my subregion; OTOH hugging, no way -- I'm a
> > straight non-communist). If it turns out that any word (e.g. blacklist)
> > offends _majority_ (or at least a significant part of it) of some
> > minority or culture, then sure, we should send it to /dev/null.
> > should by no means listen to extreme individuals.
>=20
> I agree you have to draw the line somewhere, there will always be
> someone somewhere that's offended by something. But this seems like a
> pretty easy case.
>=20
> It's not like blacklist / whitelist are even good to begin with, it's
> not obvious which is which, you have to learn that black is bad and
> white is good.
>=20
> Blocklist (or denylist?) and allowlist are actually more descriptive and
> less likely to cause confusion.

You do not understand how word "blacklist" is used inside the kernel,
do you? Do a quick grep.
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

iEYEARECAAYFAl7mlqcACgkQMOfwapXb+vLVHQCeLR9BjgTY+oHUi1XFMXuPB+wR
1QQAoIBeNk2dUqngwfvHEz/sVZpMNoiL
=mvXj
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
