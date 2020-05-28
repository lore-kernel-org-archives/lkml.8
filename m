Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D14C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1EBF20663
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ag9Myu/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436483AbgE1VKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 17:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407542AbgE1VKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 17:10:04 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3B1C08C5C6;
        Thu, 28 May 2020 14:10:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49Y0hT4bl4z9sSm;
        Fri, 29 May 2020 07:10:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1590700202;
        bh=JzM4I28iG/nJS9MnKKrqGozKC7jkipuHb2OZKTiOoEo=;
        h=Date:From:To:Cc:Subject:From;
        b=ag9Myu/WNngplbrzlJ3t00ti2yBDQsMPKmXsPryOwbKQOWh81G5duVCNoPaM54ybC
         4SVmZV5AeSxMjjNb2TVDRzMeoKzOUfOTv/ybQ1NbrGg97zPU3dXQu59SxHY6WWOUbG
         onWqEwFhC4K+3PXBSL3+ZAnliT0lE9tCxD5Xe85Vv5BnHOvae+TUp1hPpe2tXUEkUB
         W272LXuPXXwWmf3Y2k3UXwvKYN2Mq3wBe+NTWif56m16lsoMQ/OFAgwrdnPHYmr6jz
         26Q00SbXD8CIz1VARHaGwBfPh0hzldhizoCTBehOeMOTCV7Z0phncD7HrQmNuXCpfR
         MvnsGpzxb2h8A==
Date:   Fri, 29 May 2020 07:10:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: Fixes tag needs some work in the block tree
Message-ID: <20200529071000.4e88377c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rQhmSrKMvflAngcVmOo4rDo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rQhmSrKMvflAngcVmOo4rDo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  dc35ada4251f ("block: fix a warning when blkdev.h is included for !CONFIG=
_BLOCK builds")

Fixes tag

  Fixes: 956d510ee78 ("block: add disk/bio-based accounting helpers")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/rQhmSrKMvflAngcVmOo4rDo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7QKKgACgkQAVBC80lX
0GwULQf/e6Kkt+NMgOAYILOfwijkqF8aShOEJkHE2X8gvf4tCK/bxUNurbv89twn
ulUIfBxOQV7T5jhLc+ufa2nxuFrvpXbd7TCEskWDyw07mJnSZVcXSDSlV5UQQCyh
uDDbuPwJp18P4fzNPSNQjQOJIDbzL3tJQA5MtnmxfGxLCstwMr0wa7MifUjh0wcq
LTj3QMfbKbIfEf6oMyC0rCMfyz8fI3pyRZxJCbMRz2neNz+fOATjawhI8bGe31fx
Bz+CzpIp6uu2ax/6++xI65sxJpIVXW60gvTj+Eau7Cs6ahS61gG4GSjrjAEje2ds
E0Nvd8lhyy3METeTsrf8SWeAuuuigA==
=ibCT
-----END PGP SIGNATURE-----

--Sig_/rQhmSrKMvflAngcVmOo4rDo--
