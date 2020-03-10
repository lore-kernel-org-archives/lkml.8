Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71DBC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9241221D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgCJTrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:47:14 -0400
Received: from shelob.surriel.com ([96.67.55.147]:50306 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgCJTrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:47:14 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1jBkqJ-0000Fp-Qs; Tue, 10 Mar 2020 15:47:07 -0400
Message-ID: <43e2e8443288260aa305f39ba566f81bf065d010.camel@surriel.com>
Subject: Re: [PATCH v2] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
From:   Rik van Riel <riel@surriel.com>
To:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Date:   Tue, 10 Mar 2020 15:46:51 -0400
In-Reply-To: <20200310193622.GC8447@dhcp22.suse.cz>
References: <20200310002524.2291595-1-guro@fb.com>
         <5cfa9031-fc15-2bcc-adb9-9779285ef0f7@oracle.com>
         <20200310180558.GD85000@carbon.dhcp.thefacebook.com>
         <4b78a8a9-7b5a-eb62-acaa-2677e615bea1@oracle.com>
         <20200310191906.GA96999@carbon.dhcp.thefacebook.com>
         <20200310193622.GC8447@dhcp22.suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-nkTzW+dTroZRzhK+ANyt"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nkTzW+dTroZRzhK+ANyt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-03-10 at 20:36 +0100, Michal Hocko wrote:
> On Tue 10-03-20 12:19:06, Roman Gushchin wrote:
> [...]
> > > I found this out by testing code and specifying
> > > hugetlb_cma=3D2M.  Messages
> > > in log were:
> > > 	kernel: hugetlb_cma: reserve 2097152, 1048576 per node
> > > 	kernel: hugetlb_cma: successfully reserved 1048576 on node 0
> > > 	kernel: hugetlb_cma: successfully reserved 1048576 on node 1
> > > But, it really reserved 1GB per node.
> >=20
> > Good point! In the passed size is too small to cover a single huge
> > page,
> > we should probably print a warning and bail out.
>=20
> Or maybe you just want to make the interface the unit size rather
> than
> overall size oriented. E.g. I want 10G pages per each numa node.

How would that work for architectures that have multiple
possible hugetlbfs gigantic page sizes, where the admin
can allocate different numbers of differently sized pages
after bootup?

--=20
All Rights Reversed.

--=-nkTzW+dTroZRzhK+ANyt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl5n7qsACgkQznnekoTE
3oNPgAf/WwM7t19gfs8VgvGYuxQB6n6Cej1p3fn/Vt33tpr5NTsNhSYGXd5Fkk6z
TJLqGmGSm1yIfl9A+zu5faSdhZ4WWPGwbDclmyninsndL8fq/hXnlms0LvNuFV4M
xgzIfCppKwldxAINa87dLbA5WWstSLK+rWMCOghhbOxnsGk0JxltTFTmR7vZxG/s
9yvMK+Q2gfhxByVkmd8olXb0BIE5TpDzmvBy6OQE0MMD5BNPBijzPodF9/Xeq003
NjQfxAzVGukmIkJEL7waRt+FkcO+IoDve7I94ZWcJ0F1w4HaZN62RTh37YCGpql1
hnUpkr+EHWLlvuhAxNa+1PTU/D9HGg==
=f+4d
-----END PGP SIGNATURE-----

--=-nkTzW+dTroZRzhK+ANyt--

