Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597F5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30BED20756
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fSz2gq4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgEUL4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:56:21 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51101 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729002AbgEUL4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:56:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49SSkn5rrqz9sSJ;
        Thu, 21 May 2020 21:56:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1590062179;
        bh=kwF6cPnS97gtdHYMgI/TZKraaabw4ylDI13DsO3XuGU=;
        h=Date:From:To:Cc:Subject:From;
        b=fSz2gq4z4lamWPoXUPF+xkHl2NIJZl6zoKzFseNG1yCNUqzSJDRRo6CBn4Y5f/pMA
         fR9SmXtDyqE7SPsYb/4FqurcXckTe9cpI1ymkbHvcjCXXcYZjathb2t4TxlmrPzNSe
         p8tJ/iuGc6FhuQUZoFeqNWTYXOpFhJ9OLvlm5vbUQzEC7TK4JRwPvXb7WQAPFAwmrB
         05cZ+oLXA9bmMpvlhSx4jEmJLg6Wj4JiSHniQO3E8Bx8los0nNXw4RHvNSlzCzKF8B
         IJW0GIHKFqmuCAeOe7VDHjJg+EVtSuQrZBq//RPEQnIQUUONzByTVZ96rt2YJKlBdE
         3MUdvt1TUJdQQ==
Date:   Thu, 21 May 2020 21:56:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the tip tree
Message-ID: <20200521215614.63e4473a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sWOO1vVeJ0E+_2_iXTGlbic";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sWOO1vVeJ0E+_2_iXTGlbic
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (x86_64 allnoconfig)
produced this warning:

arch/x86/kernel/traps.c: In function 'exc_double_fault':
arch/x86/kernel/traps.c:332:16: warning: unused variable 'address' [-Wunuse=
d-variable]
  332 |  unsigned long address =3D read_cr2();
      |                ^~~~~~~

Introduced by commit

  095b7a3e7745 ("x86/entry: Convert double fault exception to IDTENTRY_DF")

--=20
Cheers,
Stephen Rothwell

--Sig_/sWOO1vVeJ0E+_2_iXTGlbic
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7GbF4ACgkQAVBC80lX
0GwNrggAoUAxs2WMhydYKdkTiKnIdbEmBrLYPoHFKUeeKRhNs2WtmlTiHWlqjnZH
TWdFwzItQny2tCOXF2SahYOwDzjKtRkwSEsgLXRrH9/tdGYECRbkjQmz9mDMMFXv
ewN2P5HbIGOQnPJfOilgXoQ1eMGXen0XMDqHQNPml25UXqLAe0vxpz9vx0V5g/2T
CIh/QRoTOQFIK0mQM6BPldXIES4uRNZNjbo+j0tF7ots5LXutOtYPNne7/stNY5d
OMHiux+dYigBPPxg2Vx/e+Ur84JIZi/tuvbjhEyCOSVLWJENldB4F+zM+CjFlnap
NxLPw5kF3B6ghkbE2JkRAm7GNA2o5Q==
=BMkc
-----END PGP SIGNATURE-----

--Sig_/sWOO1vVeJ0E+_2_iXTGlbic--
