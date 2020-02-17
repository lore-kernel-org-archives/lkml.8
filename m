Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99F4C76199
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 01:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FE420726
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 01:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RnpMjBMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgBQBWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 20:22:47 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:43625 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgBQBWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 20:22:47 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48LR7822HLz9sRJ;
        Mon, 17 Feb 2020 12:22:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1581902565;
        bh=luamyo6WSdH/2y3M3DUvoqa26qJ9gBwp8fXnRt7PeAM=;
        h=Date:From:To:Cc:Subject:From;
        b=RnpMjBMYnA/iqpOCLam5sDhQqA4+jX+Keh6KbhQxfojbYueETMv0QJBeDy2UyCqzU
         yedZlcTEu1V7o2kv1aZEaS/cxHvKAYmxS5Yxq3PvCr3cI51wG2Qs5bj1EccUCLtR31
         uf2HwhGPWnWZExoRd2GAB1XCY1Ezx9Z/j8E1uBMJktz250c/UNo2T0Y1GS2wG6rfoh
         +JzOX+UCg1uKzNmmmpskGUvZg6xguRWhKGZuKYSI+lxdHZ7Ow1UMB3GilR/joMcMgl
         CVy8Kp4jvGPUrhSP2r9SKMVCI7kSWZJPVeTk5N+6oZna9yKZ9K9YAGR+Uz1GFBe08H
         pDxN7EY56ZutA==
Date:   Mon, 17 Feb 2020 12:22:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <ren_guo@c-sky.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MaJun <majun258@linux.alibaba.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: linux-next: manual merge of the akpm-current tree with the csky
 tree
Message-ID: <20200217122242.2da61737@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6AU8AwlppohqBCyFoxVmg2l";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6AU8AwlppohqBCyFoxVmg2l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/csky/include/asm/Kbuild

between commit:

  aeb58bb21421 ("csky: Add PCI support")

from the csky tree and commit:

  25e6e2bca62a ("asm-generic: make more kernel-space headers mandatory")

from the akpm-current tree.

I fixed it up (the latter is a superset of the former) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/6AU8AwlppohqBCyFoxVmg2l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5J6uIACgkQAVBC80lX
0GyhKAgAkQyt4kX6yBaqXAer+7/xmL4KpEktZMmtbK+kP1ZqFn/yT14T9n2RYhwI
T3I2nBFh8TsRLqpNyJ6w13fs6zohY550bYk+wlM7mRcqp/MB/gRqCp3ZDg87abFJ
buTzVtB92MhegVUP9Ueomd4lxhtIGOR/EM17QhDGO7f/PJNCNu2hTDPU75FhAf4b
3QTDalNRe1oizJaFDWOpLAjuoNL3NEKLCjLqOYM1EEr8MiqJjlNWh6gECyCbMxM4
aiK/BWZcLkxki+JEaVPf864hm/WawUzOoZIbJS6ywh9Q10l0BwwbqmPvb3QlFw8f
4s+Z7EXFHM9k5txvtnjD84Dg/VAVAg==
=8Szk
-----END PGP SIGNATURE-----

--Sig_/6AU8AwlppohqBCyFoxVmg2l--
