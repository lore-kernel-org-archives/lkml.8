Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92C0C4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B9A2072D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Somggjd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgBZU1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:27:01 -0500
Received: from ozlabs.org ([203.11.71.1]:54353 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbgBZU1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 15:27:01 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48SS5H328jz9sP7;
        Thu, 27 Feb 2020 07:26:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1582748819;
        bh=oY/iKkm51MiwcxmelQFrfFmvG31r59pUeL9thyiTnBs=;
        h=Date:From:To:Cc:Subject:From;
        b=Somggjd3nEvgqaar6icbnz76SAj6/AjtYZ+8Kb+lEeOjofIfRvp1kMsXa0CSzregm
         9EiA91JRfVnfd4p58PT12E4QEYYIqICJhRb6N3F1hJPsSuzoCUbMxmEiR8EXWMyhob
         UQ8fxaLv8viz+RGnNWLiSeuCjFq7cICEfKWvzEJAntk6W25WSF8PNTi+mJsOBj6fm7
         lDDiHNOibx/t2fLj8lweUuU94M4Nm3h+eHnDDXEy1FfCfjuCDLUvYxYG0hLh4LYD+m
         zokfwDn5ZXxVgtA5cdZZ/ThWn8SqR9f74kSpnnc0/GZMrOcYs29psXLVqeQqsyJPt6
         exNauHH++upew==
Date:   Thu, 27 Feb 2020 07:26:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the leds tree
Message-ID: <20200227072654.63bd8f28@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pw._w/D/YBj9t=0ZZooqA_a";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pw._w/D/YBj9t=0ZZooqA_a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  111798333210 ("leds: add SGI IP30 led support")
  0b24e7c74537 ("leds: lm3697: fix spelling mistake "To" -> "Too"")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/pw._w/D/YBj9t=0ZZooqA_a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5W1I4ACgkQAVBC80lX
0GzCMgf/UGqg6KZA7IRAHYkSUQ9+rn2d3IpccOjH200NTR6DrYijvf27rvJz42jp
OHWVjp71Al15Q6RtPGG1RcLjd18Pg5TqP8NK0JA6K/MlwJkWK4eITkoDYmHW4c6y
ud5GZg0oKganorfU/0BQ7I0NSvm4vC0SyydWBkR8AsLecnSNsLCdcSAGzYfkMyG2
+nV8yHMbwd0xuKWBcCDqYSu1YpOJz6HDDxepO8ZY4bimcWerlsjN2vDrDVrT0m6y
T98VcYlujHKk9etsPrZcBz690KRd2Zk6GqbwaWkUdHxQnHxPNQdcTzVf+WWyrZ/v
VRH2PDA2Nm9Uain7Pz9Y5K6HHAklDQ==
=8DSw
-----END PGP SIGNATURE-----

--Sig_/pw._w/D/YBj9t=0ZZooqA_a--
