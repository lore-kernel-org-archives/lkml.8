Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E82C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 22:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D57B320709
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 22:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="M5laFzK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgHRWaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 18:30:39 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41571 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgHRWai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 18:30:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BWQbb4prnz9sPf;
        Wed, 19 Aug 2020 08:30:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1597789836;
        bh=1gjRiVgYgoe5FwHLOxx/q36r4UxxcTTxIyGM4l2io9Y=;
        h=Date:From:To:Cc:Subject:From;
        b=M5laFzK7kkm3RSHzVgwyrnh+IhEteClUsAwk21ux3UP0flU3Kmd5tPGTnuTuQiojd
         htalMdAptkFgm7qWJgptxfBG4OVrJPaw8oWnRPN7ihFHSQc/sKmHvU9umNPlM3o3sL
         gAz3030uByhirAt2P1UKkTPkotKn+DGaqD17K7oMRD0YUpWsxOaB0Ji1v2/Sr/ETaf
         WPPNhxDxihgjBPZ6e5TSUdpkZsrGKjRDNzpv3dFY7PCVa6TL5bnoef7px9RaovhoUM
         LEnQ5Ro1Mg2dO+N5Z0paMnwo3gVA9Ozj9bb14AOIAvWw2g59O2LGpGQ44WbtNy4Eri
         9M413xOVKUUIA==
Date:   Wed, 19 Aug 2020 08:30:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        brookxu <brookxu.cn@gmail.com>,
        Chunguang Xu <brookxu@tencent.com>
Subject: linux-next: Signed-off-by missing for commits in the ext4 tree
Message-ID: <20200819083034.6c2b3b33@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dgvTkg2jpM3WZMgkEcK8Ipi";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dgvTkg2jpM3WZMgkEcK8Ipi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  dddcd2f9ebde ("ext4: optimize the implementation of ext4_mb_good_group()")
  051e2ce8cb90 ("ext4: delete invalid comments near ext4_mb_check_limits()")
  e9a3cd48d653 ("ext4: fix typos in ext4_mb_regular_allocator() comment")
  9375ac770cda ("ext4: delete the invalid BUGON in ext4_mb_load_buddy_gfp()=
")

are missing a Signed-off-by from their authors.

Not really (I assume), but their author is brookxu <brookxu.cn@gmail.com>
and the Signed-off-by is Chunguang Xu <brookxu@tencent.com>.  Consistency
would be nice.

--=20
Cheers,
Stephen Rothwell

--Sig_/dgvTkg2jpM3WZMgkEcK8Ipi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl88VooACgkQAVBC80lX
0Gwqhwf6Ar7wek+8xwmLcFGPaq8OmS1oaeA1BYGDWu8uoxno7Ve1Pp2o3lINTfVN
0O/dIi2F8/8EJwDaw57twGlpNR5dBtHWuXFqnYgdqCtu4qEcccT6BfX7IC7bhW/8
gzdNPT3kboQZsvqrJpZhri2FdBsEpAYMZ05bCCv9bcrr8fWXaBY6i9LzoyzoNFaV
NJrT+kRZyYqomLW8x0puDonXE1jcqz24oh4H/WLyBgzqFfiyJbDNOS98WXYj7NlL
9fl5M+v0NnwoHEqVf0eTOpoyPFGSP3l7/gS5fknQjIU1fCMe3t24YEWvB1wWXzNY
wUFs10zygU4chO9K6rXRrVSi5TG5+g==
=PDjy
-----END PGP SIGNATURE-----

--Sig_/dgvTkg2jpM3WZMgkEcK8Ipi--
