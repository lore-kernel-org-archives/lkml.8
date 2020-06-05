Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B507EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 05:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8996820872
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 05:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ut/yKQ82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgFEF5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 01:57:53 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47673 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgFEF5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 01:57:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49dX4H29xpz9sT6;
        Fri,  5 Jun 2020 15:57:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591336671;
        bh=JgC7ao72YUYUs9MwlarCOBb9HzV7cUc2p+0sPD/Gpis=;
        h=Date:From:To:Cc:Subject:From;
        b=ut/yKQ82OsfY+QpA1giDnDt80l+zq0aSeG4COfo/LpEKdMcZXPRco18agq9jFlRuf
         /Qzj6SXIdAfM5NC2KpPlvZp7S1X1dSoQ4vgAfA6gorgs78JjUrkF/uFl5QsrIqEZbF
         swOxtVEBUGf0LlRL42TEC17HUgjQYyvfP9mEArxppVRHqpvdjLp52fpcnT9ORvKAGN
         du8w6y1epwcagSY+SUCRHmlfhl45/KHJ098RU6FxrcnPcwZc23045qaoVm+TQUPL6L
         Y+AsmUJ1WCT6g/u3eOYiCmjSG5SJyAfx1kLirau3aYIP27evkxCkEE3MQdwYKQ+3CL
         nNIFbVS0A24BA==
Date:   Fri, 5 Jun 2020 15:57:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Rich Felker <dalias@libc.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: linux-next: manual merge of the akpm tree with the sh tree
Message-ID: <20200605155750.3241776c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wX7ZcsSm_Cx5E=acndPcYnm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wX7ZcsSm_Cx5E=acndPcYnm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm tree got a conflict in:

  arch/sh/include/asm/pgtable_64.h

between commit:

  37744feebc08 ("sh: remove sh5 support")

from the sh tree and patch:

  "mm: consolidate pte_index() and pte_offset_*() definitions"

from the akpm tree.

I fixed it up (the former deleted the file, so I did that) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/wX7ZcsSm_Cx5E=acndPcYnm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7Z3t4ACgkQAVBC80lX
0GxV1wgAkfC/NEkW4Jabhx4L05N+1s3wthHMEaKK/sZn1mH/co20psdpu8MMho7k
Q1OYaWto8GNDEDVFWaBL0VQ6/k0xtDMEFQDOfeteY6Hi3FHUzDgkkI4ZH2y+nHUO
QgIjQHdgKJbhrAA8NfkFMpBYmlm4CE0jFX7G5V/atTIkZRYST1dLi8T/qTm7pAXE
IugE6VXFoMlHAE7tfrIEpeiTKPn+stbKlJHEQmw/lvYyRf6ilR0JVWNEN9ysydH5
dq9h5WV9KS/zV9/rLF3LZQOe966izaj26vNmKaJKTVnKR4jfZEB4bMlRfRPXwJsY
6ZK2ivcx5oo1zIGl5gY54nJISe0IVg==
=+nxp
-----END PGP SIGNATURE-----

--Sig_/wX7ZcsSm_Cx5E=acndPcYnm--
