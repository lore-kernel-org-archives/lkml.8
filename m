Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29A8C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 03:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E9124683
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 03:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Nyq+0yKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgB0DLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 22:11:51 -0500
Received: from ozlabs.org ([203.11.71.1]:48643 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbgB0DLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 22:11:51 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48Sd4P0RpTz9sQx;
        Thu, 27 Feb 2020 14:11:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1582773109;
        bh=eHa+3pK4PlM4yhNHt2NS/FOBoc7mPNn7GOxAa/M0LMg=;
        h=Date:From:To:Cc:Subject:From;
        b=Nyq+0yKTfhkk5WFspY03agxZgzcUEHdh1/60g1acP+MphqdJaseXmlmMdDuMzyTBq
         IG/9Lrb1T/g5Ni6X+oXbU7sq+4vLNUQvnHMhU3JxAZdTr6lkNFJToST0Ml9/Gqnzed
         LykgaI4+dPdJXVxGDPPe1Lwyx09nNBBx4Qb6MbPEgtOSHmlDAoDoHZSnLixQpEZMRS
         5arX4GrauYai0Bi5iO9/VBjNnw41ChA1g3jnZVKXr+yNNKM88aBa12ul66xhW1q7lo
         GJetiGnzra6R5LfguWCesz2F2tHu/DKEGmibdTNAeXebHhBSwgKJJ+mmkIVSIpHOXu
         3OxuY5idVDJfQ==
Date:   Thu, 27 Feb 2020 14:11:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: linux-next: manual merge of the akpm-current tree with the kvms390
 tree
Message-ID: <20200227141148.05d7d502@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GX7+R1ByaTc96Id/6+oIct9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GX7+R1ByaTc96Id/6+oIct9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  mm/gup.c

between commit:

  732b80e677b8 ("mm/gup/writeback: add callbacks for inaccessible pages")

from the kvms390 tree and commit:

  9947ea2c1e60 ("mm/gup: track FOLL_PIN pages")

from the akpm-current tree.

I fixed it up (see below - maybe not optimally) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/gup.c
index 354bcfbd844b,f589299b0d4a..000000000000
--- a/mm/gup.c
+++ b/mm/gup.c
@@@ -269,18 -470,11 +468,19 @@@ retry
  		goto retry;
  	}
 =20
+ 	/* try_grab_page() does nothing unless FOLL_GET or FOLL_PIN is set. */
+ 	if (unlikely(!try_grab_page(page, flags))) {
+ 		page =3D ERR_PTR(-ENOMEM);
+ 		goto out;
+ 	}
 +	if (flags & FOLL_GET) {
- 		if (unlikely(!try_get_page(page))) {
- 			page =3D ERR_PTR(-ENOMEM);
- 			goto out;
- 		}
 +		ret =3D arch_make_page_accessible(page);
 +		if (ret) {
 +			put_page(page);
 +			page =3D ERR_PTR(ret);
 +			goto out;
 +		}
 +	}
  	if (flags & FOLL_TOUCH) {
  		if ((flags & FOLL_WRITE) &&
  		    !pte_dirty(pte) && !PageDirty(page))

--Sig_/GX7+R1ByaTc96Id/6+oIct9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5XM3QACgkQAVBC80lX
0Gxbrwf/QMaJBJLbG8u0mjOZR+stuPMQ5XeLc3F0RdgSbb6OOG3TWsvaSutk6WSI
P0d8yxNW5FbFe/Bk9aWekvpl75nUEhxqv9TosNEmTDo58PmZ6XNZ1N74Tiy6oHTP
cqgwVc7G1kG/iSv4w8A2GZjqiaZMcgUexEWfG4FessQdUsZ8eyapYWZfiZqwDg4A
ec5zYwqtse/hcvKHgDd0QdFhqzXdnp+/LtwZ1WDRAKeL0n5XPkRWtI6uPduDhttH
J9MVJmlC8Z6Q4xtnsbjBWA7EyIrL5egzuCW9lO2dqWQCWUJVh6f73g9eJW3fAiSO
PxsqoKewipY27I3WpObTzXNHYwGKXA==
=f+KP
-----END PGP SIGNATURE-----

--Sig_/GX7+R1ByaTc96Id/6+oIct9--
