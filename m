Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD05CC33CAB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 01:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A301A21556
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 01:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BrCqiY97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733077AbgAMBgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 20:36:07 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:48051 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730100AbgAMBgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 20:36:07 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47wx4h6tf0z9sP3;
        Mon, 13 Jan 2020 12:36:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1578879365;
        bh=2EcIJoyOz9tK0xOmQQ7WAxOvnQE7s026EZeSflLOAEk=;
        h=Date:From:To:Cc:Subject:From;
        b=BrCqiY97gvIaH5Kk29l5Y52tIzivjiWEfW9wqq+Ahya6mGr3a41iKLxiOxp7KmSAU
         +lNnk0eX61mE4R4ZUO3TPXc1WZblh2VZlKykcY+hH7QzVIVIEM5siAYZ8hGoPk6GmT
         rttjXuvnaa9MoRlKO3Mm8qcj70izKYJaOs5g5otc6cfmxwvilht1RRNc/ZfhT0OyI3
         4l9MBkOp6csYNSkbCyoXCU79p1ea3C9YjxPVBRWJ2QvWb2tDq/I/5spPG75zKhpEkn
         r2iTrRNDgx79U3MKql11PE4W3WEtoH+dp2yhibPSgzIaBHVB8qzYu9osQNyeYe1Vki
         UZBGRm1rlCfuw==
Date:   Mon, 13 Jan 2020 12:36:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kars de Jong <jongk@linux-m68k.org>
Subject: linux-next: manual merge of the keys tree with the m86k tree
Message-ID: <20200113123603.33c957e1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/259KabfiEtsM5joRfPsaXt3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/259KabfiEtsM5joRfPsaXt3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the keys tree got a conflict in:

  arch/m68k/kernel/syscalls/syscall.tbl

between commit:

  e8bb2a2a1d51 ("m68k: Wire up clone3() syscall")

from the m86k tree and commit:

  519c484a997a ("Add a general, global device notification watch list")

from the keys tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/259KabfiEtsM5joRfPsaXt3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4byYMACgkQAVBC80lX
0GyswQf+IyWDYqngcu1V5qKkljBR81wDWBv48b8GtXCeZ74gr10TiFKhW0++d05K
b6wiLqkrBVKTMwo1R+oqxW6jO2Wz0t9+x97wNTfnjbY6L2yvQCKEgULiV92tEWBE
5rsY1lzGj+b8Kup4DOouCokVrrOF0zuFuhH/KnYb39GTKUTNTnlk+lInCwTYcnA+
xUdl+kMqXFFM3erzBhXKGBTb6y1YTq3zZx9ZbKmPjCN6HOUG9R53fru7S5Bg2b5e
NMxxCpyTp7rCLdHUsLKC/Zo6vIatIhGu4P08SF59C1jHjMYxVaORaTUiUmqdIPuk
NAxSfO6Q+9uvAQJ9e4RymplE1PDVbg==
=u0aq
-----END PGP SIGNATURE-----

--Sig_/259KabfiEtsM5joRfPsaXt3--
