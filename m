Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC0FC3F2CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 02:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC71224649
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 02:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgCACYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 21:24:20 -0500
Received: from shelob.surriel.com ([96.67.55.147]:55254 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgCACYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 21:24:20 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1j8EH7-00016k-Gx; Sat, 29 Feb 2020 21:24:13 -0500
Message-ID: <af33fa8d3908684df7bac352e037c87a20fb5d3f.camel@surriel.com>
Subject: Re: [PATCH 2/2] mm,thp,compaction,cma: allow THP migration for CMA
 allocations
From:   Rik van Riel <riel@surriel.com>
To:     Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        mhocko@kernel.org, mgorman@techsingularity.net,
        rientjes@google.com, aarcange@redhat.com
Date:   Sat, 29 Feb 2020 21:24:09 -0500
In-Reply-To: <1094fc21-9104-1410-bc03-f1934dbfcd66@suse.cz>
References: <cover.1582321645.git.riel@surriel.com>
         <3289dc5e6c4c3174999598d8293adf8ed3e93b57.1582321645.git.riel@surriel.com>
         <05027092-a43e-756f-4fee-78f29a048ca1@suse.cz>
         <b3529cfa33f55d47aa2e017c8b0291395c302a02.camel@surriel.com>
         <81c8d2fa-a8ae-82b8-f359-bba055fbff68@suse.cz>
         <bd867dba881347a21757fba908f48a6e23e72439.camel@surriel.com>
         <1094fc21-9104-1410-bc03-f1934dbfcd66@suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-uhw2MaE8So4ibiAndE8G"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uhw2MaE8So4ibiAndE8G
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-02-28 at 16:17 +0100, Vlastimil Babka wrote:
> On 2/26/20 6:53 PM, Rik van Riel wrote:
> >=20
> > It appears that the order in which things are done does
> > not really provide a good moment:
> > 1) decide to attempt allocating a range of memory
> > 2) scan each page block for unmovable pages
> > 3) if no unmovable pages are found, mark the page block
> >    MIGRATE_ISOLATE
> >=20
> > I wonder if we should do things the opposite way, first
> > marking the page block MIGRATE_ISOLATE (to prevent new
> > allocations), then scanning it, and calling lru_add_drain_all
> > if we encounter a page that looks like it could benefit from
> > that.
> >=20
> > If we still see unmovable pages after that, it is cheap
> > enough to set the page block back to its previous state.
>=20
> Yeah seems like the whole has_unmovable_pages() thing isn't much
> useful
> here. It might prevent some unnecessary action like isolating
> something,
> then finding non-movable page and rolling back the isolation. But
> maybe
> it's not worth the savings, and also has_unmovable_pages() being
> false
> doesn't guarantee succeed in the actual isolate+migrate attempt.  And
> if
> it can cause a false negative due to lru pages not drained, then it's
> actually worse than if it wasn't called at all.

We'll experiment with that, and see how often it is an
issue in practice.

If this aspect of the code needs improving, I suspect
Roman and I will find it soon enough.

--=20
All Rights Reversed.

--=-uhw2MaE8So4ibiAndE8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl5bHMkACgkQznnekoTE
3oPf1QgAubWJCIPdZBomnqtqeXqkQcsFhxmG9DpikmTRcoNXX7zWbxFMPVk3KyyZ
hOn+5R1mudluuIYV00LcFYSh1tFi6HDyf6Z/RztnXGykpe9s0ggFSe1tBJEM/AYN
J7MYW9M0gFBfSHpi+pAmS/dkOVb5LtVtuDD3DZDd1cYs8vRLqPnpTmSdSgkUkl31
L9t2XJc6KmPdgXTwlv3+CvzfrVJbD15RRRWvw9ThAdsft/6n4RXSOR6BIovTBBqT
FZCxcn6fk60dZPCvo5+IEjR7u24t67vQjX+sOFNRwxw3N9wg+9eO2agPcDfDBCUc
qGvK2lxwzLcDcqhgHKrMvOye+aPmqA==
=69L+
-----END PGP SIGNATURE-----

--=-uhw2MaE8So4ibiAndE8G--

