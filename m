Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6105C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C377E20657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="O2s42cbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHQXe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 19:34:26 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48393 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgHQXeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 19:34:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BVr3g2lg5z9sRK;
        Tue, 18 Aug 2020 09:34:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1597707263;
        bh=VMshq5sMB5ZB+OwwfsYomTxZMUJqqkOpbDcA6NMaRDg=;
        h=Date:From:To:Cc:Subject:From;
        b=O2s42cbcvzOhoz2f6TuJ5dS5RX9dQ2pgFehnkm6YHh5nle+4WV/RzMVc7i8fqF3Nk
         ZJwScaveJKRMFa+eqETzTPBs4eI+CZ/wedqtc/zrxg8Nv/aTDMs11y09wzf7NhK6jk
         r/qcIBV9AXJfSIyHXCmBsvpyXTWad2vYhHbnDPwIb9DH+2lrZllSYOG/pDOzaRxuRD
         BDcH0xLziF4crRq7PTaOeP2MBrBa+rD1P+6To1dLRjaw4Ytlide9lbO+TfkALd3SIv
         9cfaSfgzO/yRTxuL0V9cee/NrQB9lEnG4XX4KgiClyIaz7LiMn+JdBZrdjvhWlYdrk
         MYHt/NR6vL7zw==
Date:   Tue, 18 Aug 2020 09:34:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the kspp-gustavo tree
Message-ID: <20200818093419.5362379c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FZOsxF9wUQNGY7YhsATfaIi";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FZOsxF9wUQNGY7YhsATfaIi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kspp-gustavo tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from include/linux/compiler_types.h:65,
                 from <command-line>:
arch/powerpc/net/bpf_jit_comp64.c: In function 'bpf_jit_build_body':
include/linux/compiler_attributes.h:214:41: error: attribute 'fallthrough' =
not preceding a case label or default label [-Werror]
  214 | # define fallthrough                    __attribute__((__fallthroug=
h__))
      |                                         ^~~~~~~~~~~~~
arch/powerpc/net/bpf_jit_comp64.c:847:4: note: in expansion of macro 'fallt=
hrough'
  847 |    fallthrough;
      |    ^~~~~~~~~~~

Caused by commit

  02b894b985cb ("treewide: Use fallthrough pseudo-keyword")

I have added the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 18 Aug 2020 09:26:47 +1000
Subject: [PATCH] revert part of "treewide: Use fallthrough pseudo-keyword"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/net/bpf_jit_comp64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_c=
omp64.c
index 57412af338fb..022103c6a201 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -844,7 +844,7 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 =
*image,
 		case BPF_JMP32 | BPF_JSET | BPF_K:
 		case BPF_JMP32 | BPF_JSET | BPF_X:
 			true_cond =3D COND_NE;
-			fallthrough;
+			/* Fall through */
=20
 cond_branch:
 			switch (code) {
--=20
2.28.0

--=20
Cheers,
Stephen Rothwell

--Sig_/FZOsxF9wUQNGY7YhsATfaIi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl87E/sACgkQAVBC80lX
0Gy0twf7B3yZMos/zj6GNX5eMro+wI4+zpw24SDNZP1N/eZ72fZQZOgvuqjC4aoS
cQwY2x+dSUcq9B8auza22Wfr0GdDZamlVO4g35W+FnDvDE9F0PKLYwC/Dl5EAlfK
7zBtZtbqqC/guTyLQDl9SEOCYu5ZdxpuWcFLwbvkPPs/OlVyengpkYCgNhMOtApP
GUmiM0knyO5Kd+i3ap7uL75I7BaOzk8+lv5x8GvzdUVUsg/59kENWHRE5rdYTW43
ZCAEpBiw/7Q+S2mC6OvcrKSuP6EH6zbCt3yvid1kUZ5JyuQQr1xSkQUSE/czDkEZ
nSXnEgoD+UgYbuisg9jbJ3fctUSDqg==
=D03y
-----END PGP SIGNATURE-----

--Sig_/FZOsxF9wUQNGY7YhsATfaIi--
