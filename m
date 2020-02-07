Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB216C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 23:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8832B21741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 23:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgBGXFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 18:05:15 -0500
Received: from shelob.surriel.com ([96.67.55.147]:35972 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgBGXFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 18:05:15 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1j0CgO-0000fj-P5; Fri, 07 Feb 2020 18:05:08 -0500
Message-ID: <d17a44fd064998729ca78193071a6d993b7047dc.camel@surriel.com>
Subject: Re: Reclaim regression after 1c30844d2dfe
From:   Rik van Riel <riel@surriel.com>
To:     Ivan Babrou <ivan@cloudflare.com>, linux-mm@kvack.org,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Date:   Fri, 07 Feb 2020 18:05:08 -0500
In-Reply-To: <CABWYdi1eOUD1DHORJxTsWPMT3BcZhz++xP1pXhT=x4SgxtgQZA@mail.gmail.com>
References: <CABWYdi1eOUD1DHORJxTsWPMT3BcZhz++xP1pXhT=x4SgxtgQZA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-6A9rXYC18lShoxYcdkQX"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6A9rXYC18lShoxYcdkQX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-02-07 at 14:54 -0800, Ivan Babrou wrote:
> This change from 5.5 times:
>=20
> * https://github.com/torvalds/linux/commit/1c30844d2dfe
>=20
> > mm: reclaim small amounts of memory when an external fragmentation
> > event occurs
>=20
> Introduced undesired effects in our environment.
>=20
> * NUMA with 2 x CPU
> * 128GB of RAM
> * THP disabled
> * Upgraded from 4.19 to 5.4
>=20
> Before we saw free memory hover at around 1.4GB with no spikes. After
> the upgrade we saw some machines decide that they need a lot more
> than
> that, with frequent spikes above 10GB, often only on a single numa
> node.
>=20
> We can see kswapd quite active in balance_pgdat (it didn't look like
> it slept at all):
>=20
> $ ps uax | fgrep kswapd
> root       1850 23.0  0.0      0     0 ?        R    Jan30 1902:24
> [kswapd0]
> root       1851  1.8  0.0      0     0 ?        S    Jan30 152:16
> [kswapd1]
>=20
> This in turn massively increased pressure on page cache, which did
> not
> go well to services that depend on having a quick response from a
> local cache backed by solid storage.
>=20
> Here's how it looked like when I zeroed vm.watermark_boost_factor:

We have observed the same thing, even on single node systems.

I have some hacky patches to apply the watermark_boost thing on
a per pgdat basis, which seems to resolve the issue, but I have
not yet found the time to get the locking for that correct.

Given how rare the watermark boosting is, maybe the answer is
just to use atomics? Not sure :)

--=20
All Rights Reversed.

--=-6A9rXYC18lShoxYcdkQX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl497SQACgkQznnekoTE
3oNxGQf+OJuEbFhLoPE5sLSrff3Oy2r6y4K+3zTbgwCor6u81/US1dw02nOM7SDM
Be/cv5hHzWe6RlAyTLuvEdw1GGB9iDV6p4VtcpeaG9wIUCXj2YLVP6JK8H5OLc5U
fQLXBdGlauAYUUIXOvIzf5jXr4AWf2ta5hzz3lyYPBJjfTFhHd3Qjh6Ovf2KTG2P
VukeNv2Df+eVDfSKSPrY4vpXkmlQc4hmkJQyQ1yo7Vek9ImE8T/YdmP7jvNsNbEe
oncCPd1nbUu45CO3ikmX+LLksNF13+k7w5sL+s8mO2XVfDp/AEeuZLWJKvLTFXpL
n1PBkdVntgV7ACE9yhRE8kOv0c956g==
=xCiA
-----END PGP SIGNATURE-----

--=-6A9rXYC18lShoxYcdkQX--

