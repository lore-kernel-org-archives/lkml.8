Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EA3C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A9EC21532
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbgIINeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 09:34:01 -0400
Received: from shelob.surriel.com ([96.67.55.147]:45342 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730355AbgIINTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 09:19:34 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kG00L-0003w1-7V; Wed, 09 Sep 2020 09:19:17 -0400
Message-ID: <054d02f3b34d9946905929ff268b685c91494b3e.camel@surriel.com>
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
From:   Rik van Riel <riel@surriel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
        Roman Gushchin <guro@fb.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 09 Sep 2020 09:19:16 -0400
In-Reply-To: <20200909070445.GA7348@dhcp22.suse.cz>
References: <20200902180628.4052244-1-zi.yan@sent.com>
         <20200903142300.bjq2um5y5nwocvar@box>
         <20200903163020.GG60440@carbon.dhcp.thefacebook.com>
         <8e677ead-206d-08dd-d73e-569bd3803e3b@redhat.com>
         <7E20392E-5ED7-4C22-9555-F3BAABF3CBE9@nvidia.com>
         <20200908143503.GE26850@dhcp22.suse.cz>
         <7ed82cb06074b30c2956638082c515fb179f69a3.camel@surriel.com>
         <20200909070445.GA7348@dhcp22.suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-a/joHFftty7+65yl3VYm"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-a/joHFftty7+65yl3VYm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-09-09 at 09:04 +0200, Michal Hocko wrote:
> On Tue 08-09-20 10:41:10, Rik van Riel wrote:
> > On Tue, 2020-09-08 at 16:35 +0200, Michal Hocko wrote:
> >=20
> > > A global knob is insufficient. 1G pages will become a very
> > > precious
> > > resource as it requires a pre-allocation (reservation). So it
> > > really
> > > has
> > > to be an opt-in and the question is whether there is also some
> > > sort
> > > of
> > > access control needed.
> >=20
> > The 1GB pages do not require that much in the way of
> > pre-allocation. The memory can be obtained through CMA,
> > which means it can be used for movable 4kB and 2MB
> > allocations when not
> > being used for 1GB pages.
>=20
> That CMA has to be pre-reserved, right? That requires a
> configuration.

To some extent, yes.

However, because that pool can be used for movable
4kB and 2MB
pages as well as for 1GB pages, it would be easy to just set
the size of that pool to eg. 1/3 or even 1/2 of memory for every
system.

It isn't like the pool needs to be the exact right size. We
just need to avoid the "highmem problem" of having too little
memory for kernel allocations.

--=20
All Rights Reversed.

--=-a/joHFftty7+65yl3VYm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl9Y1lQACgkQznnekoTE
3oPHVQf/bgeq438Tq37bx4goKsEOaJmg8kdwGMi1Sa0MPj0rHzIqrrcpBGN7MoTB
cJwWBXlXktTn7r9fdv3TVFu2DwctuUu3U8XA6tKveENqUqW/rZJfkayb6mCF8qDv
deKHkCbDyFrp4ugPQ8Ey2QX8fPcqI02kHTGmJQQxohE7Y1Gim5qiLzkn5aYQVDK1
mC2AgQYpGISMW/hPJ8yAZl3mKaQ5MKqfrhlqRHbq8y8oibv4ttkSLTFKX5E+Xizn
zRQ4Re4Ld/zou/xUVXYMUkA71eqoIb+qDhXFmomWrBxmdHirzgMqDpKX6L7Kxm4+
+s3riO3TZZP2YCwj5xbMWABajAf8Mw==
=tW2I
-----END PGP SIGNATURE-----

--=-a/joHFftty7+65yl3VYm--

