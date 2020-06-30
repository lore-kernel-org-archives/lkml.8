Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F35C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F482074D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GTRluhyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgF3VB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:01:59 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39833 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbgF3VB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:01:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49xGxt3zgYz9sTT;
        Wed,  1 Jul 2020 07:01:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1593550916;
        bh=hvAwvRDMhAwRRPC7R2/pFhoi1UNVdOxRyZPB8GwgEAw=;
        h=Date:From:To:Cc:Subject:From;
        b=GTRluhyXExlrX3l7xTX6lHaqT/hthK61CEMtSJG/RYXtXlxtEr286LNf7tx+LgSiY
         +vM7TWjsW/FotlmZlM5lsU+JBNCwoeU8vedcIJLO/aA9OUAoawaPLfeCIrImBDr05g
         eFYRrHmr9MQ/T2EaNmQWT5gsvHFpTA18vPNMsEtiHnJJ6arQk+FzGkxvAi4lsRbaZb
         iHgIGDF0NREItMjO67ygRJSfT/8MFV6rRrJ7z5WIcADR2lKtVscIpwndcoZcmjuW/0
         G9mNw+qMAKjRBahGqZVUS3MG5EfClNKSFzdWMtp1XAwKDJhTtLkzQDFceUBruEl2y1
         1xSdVOrZ+6yTQ==
Date:   Wed, 1 Jul 2020 07:01:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: linux-next: Fixes tag needs some work in the iommu tree
Message-ID: <20200701070152.743020ca@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/J8Zc_zyiT4Ta4vmr=ar3yiA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/J8Zc_zyiT4Ta4vmr=ar3yiA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  9a295ff0ffc9 ("iommu/amd: Print extended features in one line to fix dive=
rgent log levels")

Fixes tag

  Fixes: 3928aa3f57 ("iommu/amd: Detect and enable guest vAPIC support")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/J8Zc_zyiT4Ta4vmr=ar3yiA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl77qEAACgkQAVBC80lX
0GwJ4Qf7Beg37jh+Q1x/Gn6Vo4Ah510+tjsUmoZ/8sJbJ7jd1LdqKIpL0dFWwuYb
2+3a6sEcUQI9kEjvbYdXD379wmnPY+c+9zNExbt7MK4LUoSH3t6ST1rN0h2VpuaC
M2GPzGDqvcmmMJb6eej3TOjQz95AZtUdCdiU6Tz56SX58CCrWzzHYsNPmNzfBf5P
wldWC2xs42yGi9oJhtPX06MBnPqwp0sEqEIzbY0JRG263qR0IDEAQlPNUNv8o0Y6
v9ifmt4sWwp/ooPNIYIQYIJIYM6Ey+5ka1sIcJhgmOtPKOhBNu3Ru1d1qXbXIZD8
V/C9132wtHKVABNcUO7mXw8kGxRH1Q==
=L4bY
-----END PGP SIGNATURE-----

--Sig_/J8Zc_zyiT4Ta4vmr=ar3yiA--
