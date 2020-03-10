Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E29C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D98F208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgCJSWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:22:25 -0400
Received: from shelob.surriel.com ([96.67.55.147]:50150 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgCJSWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:22:25 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1jBjWD-0007pX-Th; Tue, 10 Mar 2020 14:22:17 -0400
Message-ID: <833c188c0c1b9b0b842973952907bdabed774122.camel@surriel.com>
Subject: Re: [PATCH v2] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
From:   Rik van Riel <riel@surriel.com>
To:     Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Date:   Tue, 10 Mar 2020 14:22:17 -0400
In-Reply-To: <20200310180558.GD85000@carbon.dhcp.thefacebook.com>
References: <20200310002524.2291595-1-guro@fb.com>
         <5cfa9031-fc15-2bcc-adb9-9779285ef0f7@oracle.com>
         <20200310180558.GD85000@carbon.dhcp.thefacebook.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-D94rFl3rXI1Y1H51/0DC"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-D94rFl3rXI1Y1H51/0DC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-03-10 at 11:05 -0700, Roman Gushchin wrote:
> On Tue, Mar 10, 2020 at 10:27:01AM -0700, Mike Kravetz wrote:
> >=20
> > > +	for_each_node_state(nid, N_ONLINE) {
> > > +		unsigned long min_pfn =3D 0, max_pfn =3D 0;
> > > +
> > > +		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn,
> > > NULL) {
> > > +			if (!min_pfn)
> > > +				min_pfn =3D start_pfn;
> > > +			max_pfn =3D end_pfn;
> > > +		}
> > > +
> > > +		res =3D cma_declare_contiguous(PFN_PHYS(min_pfn), size,
> > > +					     PFN_PHYS(max_pfn), (1UL <<
> > > 30),
> >=20
> > The alignment is hard coded for x86 gigantic page size.  If this
> > supports
> > more architectures or becomes arch independent we will need to
> > determine
> > what this alignment should be.  Perhaps an arch specific call back
> > to get
> > the alignment for gigantic pages.  That will require a little
> > thought as
> > some arch's support multiple gigantic page sizes.
>=20
> Good point!
> Should we take the biggest possible size as a reference?
> Or the smallest (larger than MAX_ORDER)?

I would say biggest.

You can always allocate multiple smaller gigantic pages
inside the space reserved for one ginormous one.

--=20
All Rights Reversed.

--=-D94rFl3rXI1Y1H51/0DC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl5n2tkACgkQznnekoTE
3oN+Owf/Sy6WliqWQnAbEHq56M8WlOqyAKoXZupvl2NMopJY6+FsMKMtOezaF0+s
7jli5AA4QEwoCAcLAWsfwZa5lmnrCs918KI8pnQ+6xFFDh7bg9j+iyxvS87SUseM
jOiAjAdjHIODLlz5Q7lHktmtO68cU8QDcKjbBtobntk+LS7oGA+FwucdRaZ/hLyI
+Rn43qwaod6UxqZCkoNblYlxJhosQfF7bZ99Gkmh+K09lEmgylK0fObIpPIfKI4q
sYBTMe7qUzdsfqAOFmF5xzRZX2q0mwOCdTZhjpZ68MjRpHsvKstrlh4UqfAgd7D+
uDn75ec2IPpFAR/8DTp06Kl6a1+q2g==
=tGVb
-----END PGP SIGNATURE-----

--=-D94rFl3rXI1Y1H51/0DC--

