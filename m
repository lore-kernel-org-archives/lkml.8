Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D560C2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D15206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jZ66b3sx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732785AbgDCFua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 01:50:30 -0400
Received: from ozlabs.org ([203.11.71.1]:58507 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729423AbgDCFua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 01:50:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48tptq1tpbz9sRN;
        Fri,  3 Apr 2020 16:50:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1585893027;
        bh=UKN6QmIcwuqX/B5oC2vSZpoXEnSlY65X+GU5TPRYSEc=;
        h=Date:From:To:Cc:Subject:From;
        b=jZ66b3sxyHxOIPQQqyIz/6dQQw1DfSAqT6mfhTJmGXj/+vOxjM6B7qbvP/x9SQCib
         u9U6fgiGHrTJxyjjJuOyRlUSu4hepwwauRRExjcyt9aHciB7h7x0nvymY0zaMchLpF
         SUkXNWTtaWpH/NU9CwOpElMIHwL7dqU/xYdjNqHGUwDs9EV02uCXAazm9eEQChfkR7
         QsZUycf7QvmJKQ0o1BbV/RADWKNCTYU2yEVbm7gJ/QOGoO78ELD3WVuiih2cFSUWaj
         hHIA3vdIRJsam93uLmq9E0drgSU8mSyHFvn6jTZqa1IqjzK6VrzLZbdLytVQE6tW0P
         KJJd5EBE+2xhQ==
Date:   Fri, 3 Apr 2020 16:50:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the device-mapper tree
Message-ID: <20200403165026.095e51c7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VN=birYokzP7LT+E_lEn.85";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VN=birYokzP7LT+E_lEn.85
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

n commit

  5dd2653b281c ("dm integrity: fix ppc64le warning")

Fixes tag

  Fixes: 7649194a163 ("dm integrity: remove sector type casts")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/VN=birYokzP7LT+E_lEn.85
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6GzqIACgkQAVBC80lX
0GwLtwf/ZJ9gRsFkt28B2EwYEJw8gSDsORJAd+4qNZb1Y1sYz/aGoQbSCg4x2nE0
5jHybRSC+P1SYy395mfs3olyK+VMBGE/CCtdotZ/MtHZlR0DgP6RUXc36oNqqdJ4
dsmL3zlG6WsEZCawCV75UUB2/J4nKkvz3oWcaEzvzE+MkZbouRa2k5s6fWG+P15Q
vCvK++UCeI6LvMLEl7l+pbQJL1SN4U9n+OtQsseE58AKoFjZURki2k+nVVqGt79D
BAT6ut/zuJRl5gCQPEh2EK+/lTmw9qpjVOqeWLW1OZTxUb5c70+ppU4odbtWatVT
BsqQjUrrZ091wfD7QYGrJPzsbyzrpg==
=Hl97
-----END PGP SIGNATURE-----

--Sig_/VN=birYokzP7LT+E_lEn.85--
