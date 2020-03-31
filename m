Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF63FC2D0F0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6B920678
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mYF7lBKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbgCaXzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 19:55:40 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43513 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731577AbgCaXzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 19:55:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48sR6J5J6Nz9sSr;
        Wed,  1 Apr 2020 10:55:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1585698937;
        bh=rDNoZ+6beun+Ikg0pG43tcuh0VSxpHG3ieiOl6HxBNI=;
        h=Date:From:To:Cc:Subject:From;
        b=mYF7lBKGhaQXl7oxFyDDn1groAoQkkPAbVt4RY+aTMaHEQgOgkoG1xy5RhtAjOMrP
         acLmupojoDQIWzk/MB7uDKUiJVacetCJucruLwiCneLUK9az2AcJJgwLsRI6vgYoly
         QbU7znyqc9xuuuWmAL5rIM+OTY8lockk5EIBqect63ZkZ89VTTkn6svsqMg6Z7qrM1
         F0tqFETTlLefplfpuxMZhqnSsB2lKLj1kr0MR9Ex0y0nQm6EIPbMEDhWCpNsMunuEa
         xAMrhZg1lqXlkslZPLXMLjm3t2SL4+EQHlKPJ9DWu/lKjpnyKjpMzpRL9Nh/nHede3
         0QUvNUu1MxsSQ==
Date:   Wed, 1 Apr 2020 10:55:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: linux-next: manual merge of the vfs tree with Linus' tree
Message-ID: <20200401105535.275226a6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dMFgTUt6PoU=B/_6fgvBzlE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dMFgTUt6PoU=B/_6fgvBzlE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  drivers/staging/exfat/Kconfig

between commit:

  590a95e418d1 ("staging: exfat: remove staging version of exfat filesystem=
")

from Linus' tree and commit:

  1a3c0509ce83 ("staging: exfat: make staging/exfat and fs/exfat mutually e=
xclusive")

from the vfs tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/dMFgTUt6PoU=B/_6fgvBzlE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6D2HcACgkQAVBC80lX
0GyN8wf9Hv7RmdHInXlR0OJveBlgrq8qRZSYW5qDwgrDhdusU/Bpyxz8RXM2g2/9
Ex4DHx5S1A7KMokPVyUruhDAI3KT+IKN8/cOl0JenDHzXm6fLkz7E5yaOMifdtNI
R94+6uXgp5F6d+EZn6PFxz5DPKb3lN2Q+3HpDWUSo7vh0Q20Luss0cPihWj0Nk3M
pi7sHAhajKOxOk//1lXYXsinpFFDdrbNSIT0gqSUQa484bQ1iu3nZyRuIaQa/zRh
7EtNAezYiiyd2wVb23xxTk5OvD+lnFLjzwpNNazrGf/Un3HNJ83gX0mNFR7oov/0
RrkqdzssrxI2ez3YSTrMZyG/gsglqw==
=Zp2H
-----END PGP SIGNATURE-----

--Sig_/dMFgTUt6PoU=B/_6fgvBzlE--
