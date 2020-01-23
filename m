Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02DCC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 05:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9629324673
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 05:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="d2azf7mo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgAWFnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 00:43:16 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:53703 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgAWFnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 00:43:16 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 483B5F3FXwz9s1x;
        Thu, 23 Jan 2020 16:43:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1579758193;
        bh=QUWn6y5zPxlhHR/1mS+e4JFMgFp62v+3+GWV14dEtu4=;
        h=Date:From:To:Cc:Subject:From;
        b=d2azf7mosYLbvPEGvDzYHU1ZZw4pAN5g5ZuxF9rRWVDyT4wOee4F5RvQTC2CUFU0C
         V5kPux6XyZqDkXOKDfjwsEPjOwVDl2wYeLsd5IyBZhBKN/J9TiDrw56MccMxJRoM4l
         Hyy130jUyiq7uH1o/fSf0/rUECnpsZt6ccDtDiGRdIPT4RaeB+xJLtcN0G1lgPO6TF
         inAw/129YI92OXBjCtL4UH3TpQAtbhkzA+3qHKyoV6W9vNRWVjvE3aA+3rzB7LR9Ml
         hLKCkooMD/uYqimPW07ESyC0DlXDvDwE2O4cgLMCsDw7rhQeTpmYpEAv0ijq5YQuni
         wRdDeKf5SfO6w==
Date:   Thu, 23 Jan 2020 16:43:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: linux-next: manual merge of the akpm tree with the arm64 tree
Message-ID: <20200123164311.1e96c59a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/T8AES2Lai6Vf=vXHwTSB6az";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/T8AES2Lai6Vf=vXHwTSB6az
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm tree got a conflict in:

  arch/arm64/Kconfig

between commit:

  983460233659 ("arm64: Kconfig: select HAVE_FUTEX_CMPXCHG")

from the arm64 tree and commit:

  2a6e68c2d781 ("asm-generic/tlb: rename HAVE_RCU_TABLE_FREE")

from the akpm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/Kconfig
index 21de6ffc3652,c050d2393610..000000000000
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@@ -164,8 -164,7 +164,8 @@@ config ARM6
  	select HAVE_PERF_USER_STACK_DUMP
  	select HAVE_REGS_AND_STACK_ACCESS_API
  	select HAVE_FUNCTION_ARG_ACCESS_API
 +	select HAVE_FUTEX_CMPXCHG if FUTEX
- 	select HAVE_RCU_TABLE_FREE
+ 	select MMU_GATHER_RCU_TABLE_FREE
  	select HAVE_RSEQ
  	select HAVE_STACKPROTECTOR
  	select HAVE_SYSCALL_TRACEPOINTS

--Sig_/T8AES2Lai6Vf=vXHwTSB6az
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4pMm8ACgkQAVBC80lX
0GyViQgAlUrG4scij+tRuc9pb1J1YF4Yx/i5XRxmZjpiJ/G0xK4WzgxPqCq2gOJy
L4Uu+f09SEKPz6Q++vxHQJvPoRW8sPLCdYnwKvObSl0M5ZLdv/QGMGBav4KUgMSJ
sNL8G3t9UjM2KjP/psWdt3fkXGm0qeN0ybio83XezResbPdWT8RVKvo8t81NNEKm
fBZUC7hZdhft5iQhRt73taTlbrErKc+L2W9yxwv9VOpphAYaU3GFTQuBv+5L3JsX
ftMeFPZ2UuwlnnvmjMZB74Imdii/luDUjgjxwDcVDRKa/t3pghkhkCeJoa3Dlop7
bIjW+aGTC/iytupZSdV0tzHowkcBCQ==
=ZFvs
-----END PGP SIGNATURE-----

--Sig_/T8AES2Lai6Vf=vXHwTSB6az--
