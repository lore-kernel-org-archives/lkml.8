Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B61C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A00DC20760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XpfOfCrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgGPIAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:00:22 -0400
Received: from ozlabs.org ([203.11.71.1]:51327 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgGPIAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:00:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B6mrZ6jdxz9sSt;
        Thu, 16 Jul 2020 18:00:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1594886416;
        bh=Xcj3p9YfvfovEYkul2s8sEr+JVKNdgx8sf9anhjSULc=;
        h=Date:From:To:Cc:Subject:From;
        b=XpfOfCrHxdYUTbMaS3/x3mM5YmD5H+ymqmKNNcjN8XvyL8TCfoa3TMtLh7KX1lCmB
         bW1AwRlmsyI/Ho6T+OlJYBEBCGa4Rx4U4MSsvbsACnrBva04s/ygZK3sEu9UrmHSqW
         XumhgRmZ5JWPdiRlv0H4ZIhh/0uVkCX97oWNa+1RTPx+BC6I7Y2FFJdL/pG6DwZvT0
         eBOjibLnnkrQNfafyvZmBnLOSz7jrVY5AC5X1w6pkvQK8L7NcUAlYML+1COsIxzJF+
         82ks1Jj3VvLgI3IuczADCkU8PAFSzEqJ8OFkxh43aO5lcgv2tStlqKIuPoH6m0BnZK
         XMVAfVbwmj1VA==
Date:   Thu, 16 Jul 2020 18:00:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: linux-next: manual merge of the akpm-current tree with the arm64
 tree
Message-ID: <20200716180012.032723a9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iDWzjgiAzDhNubtgCyBLPeP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iDWzjgiAzDhNubtgCyBLPeP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/arm64/mm/init.c

between commit:

  abb7962adc80 ("arm64/hugetlb: Reserve CMA areas for gigantic pages on 16K=
 and 64K configs")

from the arm64 tree and commit:

  10d44973d8ab ("mm/hugetlb: split hugetlb_cma in nodes with memory")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/mm/init.c
index f8c19c6c8e71,ee551d71c4dd..000000000000
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@@ -421,22 -421,21 +421,21 @@@ void __init bootmem_init(void
  	arm64_numa_init();
 =20
  	/*
- 	 * must be done after arm64_numa_init() which calls numa_init() to
- 	 * initialize node_online_map that gets used in hugetlb_cma_reserve()
- 	 * while allocating required CMA size across online nodes.
+ 	 * sparse_init() tries to allocate memory from memblock, so must be
+ 	 * done after the fixed reservations
  	 */
- #if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
- 	arm64_hugetlb_cma_reserve();
- #endif
+ 	sparse_init();
+ 	zone_sizes_init(min, max);
 =20
  	/*
- 	 * Sparsemem tries to allocate bootmem in memory_present(), so must be
- 	 * done after the fixed reservations.
+ 	 * must be done after zone_sizes_init() which calls free_area_init()
+ 	 * that calls node_set_state() to initialize node_states[N_MEMORY]
+ 	 * because hugetlb_cma_reserve() will scan over nodes with N_MEMORY
+ 	 * state
  	 */
- 	memblocks_present();
-=20
- 	sparse_init();
- 	zone_sizes_init(min, max);
 -#ifdef CONFIG_ARM64_4K_PAGES
 -	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
++#if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
++	arm64_hugetlb_cma_reserve();
+ #endif
 =20
  	memblock_dump_all();
  }

--Sig_/iDWzjgiAzDhNubtgCyBLPeP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8QCQwACgkQAVBC80lX
0GzyaQf/VARsxA8jSgUUyLjAghNhWS0czhM76uG1R0gDAzgXJBdjF+162LSypSmB
1FsP/7psKnv9kvOj9t1MoRzObuvrkpnW8g5Ugfh0b0Q1lTJskOJU4BAMynSO1oIQ
F+9T2F47qvq0l4CiHbuKMnUU7pVZNTWGxd02gcGYIosvXOD0sVyJS1A+gpkFFMxZ
CSJHW1wuTJenk1C95byqFO4trRa8bMGGGpSIlLRlX/IPRWjXJQe6ZQl9R2MeuHu5
nsfluHK0LqG1o151GQ27GXjNtJjMVsbWZ/kXJaGlfVDU2V+9vOwBcw8d5yF7picV
NFO/+ox9sTPiPZH9DfWv7cS47TBk1Q==
=IOnC
-----END PGP SIGNATURE-----

--Sig_/iDWzjgiAzDhNubtgCyBLPeP--
