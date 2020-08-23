Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF67C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 10:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FBB92074D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 10:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgHWKpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 06:45:04 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:48730 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgHWKpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 06:45:01 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A4BEA1C0BBB; Sun, 23 Aug 2020 12:44:59 +0200 (CEST)
Date:   Sun, 23 Aug 2020 12:44:59 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Vrabel <david.vrabel@citrix.com>,
        Joerg Roedel <jroedel@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: Track page table modifications in
 __apply_to_page_range()
Message-ID: <20200823104459.untmn33r46wqxi66@duo.ucw.cz>
References: <20200821123746.16904-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ab2tecr4xsmyxrrm"
Content-Disposition: inline
In-Reply-To: <20200821123746.16904-1-joro@8bytes.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ab2tecr4xsmyxrrm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The __apply_to_page_range() function is also used to change and/or
> allocate page-table pages in the vmalloc area of the address space.
> Make sure these changes get synchronized to other page-tables in the
> system by calling arch_sync_kernel_mappings() when necessary.
>=20
> Tested-by: Chris Wilson <chris@chris-wilson.co.uk> #x86-32
> Cc: <stable@vger.kernel.org> # v5.8+
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

This seems to solve screen blinking problems on Thinkpad X60. (It
already survived few unison runs, which would usually kill it.).

Tested-by: Pavel Machek <pavel@ucw.cz>

Thanks and best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ab2tecr4xsmyxrrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX0JIqwAKCRAw5/Bqldv6
8kjIAJoD97mGm2SLYscxJlq2IzZ34vE4vQCcDwXVYWTvZgJt0mtfFG77d0syZ0o=
=f1aM
-----END PGP SIGNATURE-----

--ab2tecr4xsmyxrrm--
