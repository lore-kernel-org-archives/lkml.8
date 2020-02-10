Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBC5C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B303824676
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZYsxv5An"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBJUmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 15:42:18 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:54819 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgBJUmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 15:42:18 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48GdBJ4Qp0z9sPF;
        Tue, 11 Feb 2020 07:42:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1581367336;
        bh=kXMVdBaIv15+3S5E6H+mlqHGS96jd8kMmA7ruP5v6KM=;
        h=Date:From:To:Cc:Subject:From;
        b=ZYsxv5Anbr6Hq7FFU0RWgNZ9EsDs0cpOg+dTRuqYvNnwxIsXPjJc7m9eMG+PWs+8H
         Gps8MJ81lAfM/XmsRsFOXFPrP5klJP2unr8NXcCVGofrQtzwyDB81nvNlCa1pLBUKb
         EsGsI2bWWslx6sJ5r9piaQW43u/XqvPV48vAUjXYKnTj+csiDUg0xl4Vv2I60xMHTt
         265rUT1m67VOPRVmM1I4Gqf//5UoALWQwUbw+sEjr+HMex7Kk4Vvgj4XjaCVOzfuTp
         EAq/CX0VrIYY8HCRQo/GwoLNbx93lY4mX0EO2Fvis543jp1gxov4jDxiYG37BoOwjk
         GPqt94tPatzeg==
Date:   Tue, 11 Feb 2020 07:42:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the mlx5-next tree
Message-ID: <20200211074209.3e0a1b19@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7a/4BJAxvxPe4hQtVlShozH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7a/4BJAxvxPe4hQtVlShozH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  a4ad6db8a2de ("net/mlx5: Add bit to indicate support for encap/decap in s=
w-steering managed tables")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/7a/4BJAxvxPe4hQtVlShozH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5BwCEACgkQAVBC80lX
0GxuVgf/fES8Hrb3HVelFHtFl8gA/XQgSxG3iYWCugiF6beIlEoE5R7rsBoD7S0z
z+8GY9csShtM9XnGm4z9hKsIUVvVqW6XWW8jQGD9nbqa+1S4Uih5UAbCUQsTOBjI
BX8kcrmzCBkZT/cbxcU29JGgvRqKepZQfLnRmakjV7tz0JC5O5jElhAXs4TX3B3G
HR5SyII9dkfIKIVwal0P6WfQYf5ev2CHTwzqYW38aHgX1pwypp6NW9JJZ+BzSyk5
072krYL/jJtFZX6CARs7jaTLpdYWhtrhuIoamxUyQ38980eJFHxtSvzg6QAmi1J2
Ui2t6vtTbHIDMktoqCNZacGakMsTGA==
=9q7M
-----END PGP SIGNATURE-----

--Sig_/7a/4BJAxvxPe4hQtVlShozH--
