Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945DDC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 628722065F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tCt3nDUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgGQMAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 08:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgGQMAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 08:00:53 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF6FC061755;
        Fri, 17 Jul 2020 05:00:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B7V7l29pkz9sR4;
        Fri, 17 Jul 2020 22:00:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1594987251;
        bh=4MGJKluqDSBdANksRYdiW/8gMkKqqwzjaR5VZewNpa4=;
        h=Date:From:To:Cc:Subject:From;
        b=tCt3nDUBVfJp0cefSiSVLdkJ/L+/fCfTRAlzahiGr6Z47pLATW5fRqmeseOBHaOob
         O6Lg/h1ULRxDBAx1olmDzptpSgsVAUIIVv2Pze8QJwyUvCCjjlhaXLj5pf3q4nj4IP
         TGoZ9B3ai4icVilqAH/1EBQpZGWdYJfy6Zj2xjyCzXccFcZQGHPa9z2FMlupHWOS47
         S2clOIPN3lfqXWHYTKn05aHCaNwGHaqGqVcbiEFm3MpFm/34rYq2rglFMdMPkKSJD8
         nZrX/Ehl3vgmaDUkjRWKqQ+yCC0lHKmSeyuQ1TilYeU3Q9Rw0nbg4v2BqBcMBrJFyG
         TzSr1AovdRbrQ==
Date:   Fri, 17 Jul 2020 22:00:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mfd tree
Message-ID: <20200717220050.034e93e0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/99+HQU_Mm71v2Rrv5FaYIpg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/99+HQU_Mm71v2Rrv5FaYIpg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  52aa6355da7a ("mfd: kempld-core: Fix 'assignment of read-only location' e=
rror")

Fixes tag

  Fixes: 765f4122aee ("mfd: core: Make a best effort attempt to match devic=
es with the correct of_nodes")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/99+HQU_Mm71v2Rrv5FaYIpg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8RkvIACgkQAVBC80lX
0GyonAf9HgXtPCrVl2OMVejZ0TR7gJMM3vNce+T+6OjaT6ygNWnCnt+zqAuSEZSz
DrIMcwMbvvZwgsLFKwZ37BNY9pNzsbC2ZZKjVqcLps+87mYalBBnNKJtlir80H7x
Epu/jjqQbAMzFJE2kYCXU86CbaWNlFakixJuJ02oHlIJv/UTk/U0eQaazgSVC0+A
FHK8nsmdUiIjStxbpfNVcetGmJeawCUyA+gd7EqSSjTWRi3Rfj3AVrU2hDZMRw1p
NGI7gb1bmOOg3UNK8u97TODY4Cm3PDQcfvGFkc4HN1bO1wVXziKfJKIwFjVns/UT
/ovn0FuMMaURXOB8mdDOk3DY7EnSUg==
=grsJ
-----END PGP SIGNATURE-----

--Sig_/99+HQU_Mm71v2Rrv5FaYIpg--
