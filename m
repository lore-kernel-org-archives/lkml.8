Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC0CC2BA18
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 23:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6319920721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 23:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ITKVdNfE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgDCXNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 19:13:19 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33165 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbgDCXNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 19:13:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48vG241Znlz9sPF;
        Sat,  4 Apr 2020 10:13:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1585955596;
        bh=YXRbc4ZAD8npearX2Gz5juL1X/2lFW7aKLgT9PEbZH0=;
        h=Date:From:To:Cc:Subject:From;
        b=ITKVdNfEoFElndRcUH30LmDqrYUL0RcyBQeGQN49s68lADtSZVNfZx42ldnORIb3o
         Jn2yh+qQ1wmc6zLFvdvE5M6E6iS0RwFXMRatgJQMJMzMUx/5NmF3TcZrTXaLMCnWSl
         yO7RMuzweDj4dhmSZYKSR+mXI5oG4sT34yO1t52n2V3Vr7O227wEqQk5xc3GQWNcvb
         dk+eZUaeagMn6xdmyScwwn+Rmvz2V0IFT71Wr8ru663aWH7DbReQAjXjWtIJuCMZxj
         YsTDbde7RDHmfF+GjFemey1sbAeM8D86dB2bJ08KXm/fZl6Qd1A9+i+T5b0cqlmRHO
         wfDmEuRSB54SQ==
Date:   Sat, 4 Apr 2020 10:13:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: linux-next: manual merge of the csky tree with Linus' tree
Message-ID: <20200404101314.72468dd9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lbdWKaWV45Pq8DV+YaKrQyq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lbdWKaWV45Pq8DV+YaKrQyq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the csky tree got a conflict in:

  arch/csky/include/asm/Kbuild

between commit:

  630f289b7114 ("asm-generic: make more kernel-space headers mandatory")

from Linus' tree and commit:

  33e53ae1ce41 ("csky: Add kprobes supported")

from the csky tree.

I fixed it up (the former is a superset of the latter) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/lbdWKaWV45Pq8DV+YaKrQyq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6HwwoACgkQAVBC80lX
0Gz31QgAhQVL+lDwvSUY/O4zCeV7laK6lwqEb70C+OXO+uFZjuqg5KAQBybWL58x
qe5a7GuLCAaqyLs1F/gm7gysNZtc4EhcDyG+OLVJHIp+zlVU7lvW694uj6BFQjS5
Vru37ESBPtG1vCcz0i+88qAegB/sjLbPpe9Zp1h3MlV56EAS+UeWrPFcpmLyMopL
Ks8uekzXEW5yWut3JsHuseLHJUtXa1YGjqCrszBjOMUYdBNzr/hAlz4ClQNh290p
2yG8CUqG6H9xNOljYiyMuBE+SmYxTVgS7vbaZQjm0jS/ccdDdDIyP9uE8qqQ85xY
woCd1grCNBZCHnEG1YvI4BszOSjPQA==
=RREJ
-----END PGP SIGNATURE-----

--Sig_/lbdWKaWV45Pq8DV+YaKrQyq--
