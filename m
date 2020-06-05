Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B98C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 05:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85E1E207D3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 05:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ID28M0F0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgFEFmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 01:42:25 -0400
Received: from ozlabs.org ([203.11.71.1]:46029 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgFEFmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 01:42:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49dWkQ4qC2z9sT8;
        Fri,  5 Jun 2020 15:42:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591335742;
        bh=zxhBh5gkqZHVn6JmP9LjThC7hym8PFZ7KAb1oBOBnss=;
        h=Date:From:To:Cc:Subject:From;
        b=ID28M0F0tnPNQDnkfEbpvMlTNOuUZH+kstPdu+EpDqAwKdPAOcKn+LRv4kHgMsYn7
         bzebu0lkCYg6smSLCp8lJyfsfMfHSOHCJRY/7luUwF07ak2hfNas4x5b3kwcKtfSME
         j6yT+fAoW93w9lOWv+mUanv4YOQ2QTi1Q6GucDEIzJ6JnzOWDgMqsGR76cyIAmzeTQ
         zvAndcm2xUI7y49VJ0341anNvIaBPTml6MA91Dwd4qRDAE02foa8q5kCaZO2nPWnox
         rXKyCBdqhYUQBWjJ9YlRAlBJfxhGlfJaSV2/sv9WRszN1NizQYFlF0rCW4QS0G4VQq
         6ReKVjYUUKUxg==
Date:   Fri, 5 Jun 2020 15:42:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Rich Felker <dalias@libc.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: linux-next: manual merge of the akpm tree with the sh tree
Message-ID: <20200605154221.40ccd77c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W7Ma=Hw+d2/YHrOhubl_KFk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/W7Ma=Hw+d2/YHrOhubl_KFk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm tree got a conflict in:

  arch/sh/include/asm/pgtable_64.h

between commit:

  37744feebc08 ("sh: remove sh5 support")

from the sh tree and patch:

  "sh: drop __pXd_offset() macros that duplicate pXd_index() ones"

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

--Sig_/W7Ma=Hw+d2/YHrOhubl_KFk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7Z2z0ACgkQAVBC80lX
0GwZ3QgAmeB4AHRQ9znPmK0iC6Fukvh/OnEl45Z0WoLcZTdRV9sQr13fltBjx9gi
4gEZS3GgRGX8Butp1QHT8IRDN47dFOMDgENIz83V0ASDq3parxtA9e3pttdU0YZc
NN7O3rDB7GPmyvnihnjGlfVapMgHZhLkG4sM6WBIEqGcbaK7cTp+BdEk+HdbSWHA
aeCrpb03zJ39c27R5tmx8zmO1ICN5RMvIiVVkO+gf2H19CBooD4Fq+6DIgZy5VXN
rU7yvK9596j0Aeub1C7t9YhGfDtxEBtPGtot5wxvOU6TbeEq5jYQ/CluRzw4eaNw
4zrU17M1pno+c+nYlCUP5COPGiA/fg==
=13LO
-----END PGP SIGNATURE-----

--Sig_/W7Ma=Hw+d2/YHrOhubl_KFk--
