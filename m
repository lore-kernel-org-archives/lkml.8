Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC71C2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C902063A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PoByQ9qT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgDFVwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:52:11 -0400
Received: from ozlabs.org ([203.11.71.1]:33205 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgDFVwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:52:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48x4544MV2z9sQx;
        Tue,  7 Apr 2020 07:52:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1586209928;
        bh=c1+hBHsAn2xI9Ur1Hg1FQilR/lVBYcoqLuZyfG+Wbew=;
        h=Date:From:To:Cc:Subject:From;
        b=PoByQ9qT62Gj5CtlG1IzFp+UV3KjjtKayYOeUihEl70qqH10BFPrV6V44xPKgV6UU
         68YbfGQaOBcok1Z/PvUOuUKTnbXucfG4Oj++bWesKThMTKKkX5WVLTbOzygiFSOelA
         YeG3aK/iTpYGSjRitckG8lvZN0hOfWacE15vvm/3rB3LF2wKH9V8x73ti5pCYUuc6v
         KYBEsmaOnOdAKIAG4lJaIN5ayGcSDcd9VLn2N1ydS5pqvgY9i4yVyvcNeVkOkIwG4V
         prWKYWsShaXOtDobLJpxvkL4hZl4bsKjzm4XZTzbRVuihsFCg9VDHrMEkrV+CiZGZq
         UqmF2mh5rGibg==
Date:   Tue, 7 Apr 2020 07:52:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the orangefs tree
Message-ID: <20200407075207.0bfc0e71@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Yjx3Liwg16le48WYW+H4GE2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Yjx3Liwg16le48WYW+H4GE2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  aa8891f95484 ("orangefs: don't mess with I_DIRTY_TIMES in orangefs_flush")
  4501ab590e3c ("Revert "orangefs: remember count when reading."")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/Yjx3Liwg16le48WYW+H4GE2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6LpIcACgkQAVBC80lX
0GwbmQf/S/CM4M8mIJzpsnmMbq1C39rrdLKmN4rf/9k8kO9vNLYWeaf3ST5102IA
VrzAHNIwqb5b8BNQbLD0yalIYbZirys86t2pQM0OwakDZXSC2WiH33HcfrW2uYyO
kA7jJ5UQQYNZXj+ElAgbdRk2crLn8ZI8bVqKuLQ/HjJ7pqjY6ZOo40H0C7G/1KQP
/Vw+feyF4f4iQnGThswg6+OD3jJRNB49Hh+v4Ha+iIQmNxdiZ2vtSZmu7Du+oaMQ
6xFUtKj9c9+sveaKVs180+F7qUQOgh5iKtAGWQf1mAGn4735QUevOB5Q4IWajc+S
2D2Wspy02lMUOKLEMjApfMjBVBxcXw==
=4+up
-----END PGP SIGNATURE-----

--Sig_/Yjx3Liwg16le48WYW+H4GE2--
