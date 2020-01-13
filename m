Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E32C33CAB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 01:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A08A22314
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 01:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tY5Y4d+S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733109AbgAMBhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 20:37:03 -0500
Received: from ozlabs.org ([203.11.71.1]:60039 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727494AbgAMBhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 20:37:03 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47wx5n1mBCz9sP3;
        Mon, 13 Jan 2020 12:37:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1578879421;
        bh=+E9/y7ZqNrVh5A4Mdg1MXXzDnmtB35I9JqeIGqTthOY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tY5Y4d+SbhrJwRxL6blpvuvFNPTvZkl3cyTufl1b+M5K3YGx17A9SpwM3GwjExDpW
         V73n6ieu5eO3bLqNcuUDuxoYSuDcjo1vkoZqRorjLkKhSc4V3BAd+c12M2ziSa7RrP
         nNDUic0cL22h9ehtkAZAlrS5s68idsRc8wXlczfOHCKRxk6rs7Gl5MprM5yyiaAZfX
         9/EY713+6sS4Y+bBT5mw3fkVHIcTDoOp6WjfMB2DL+Gkk9/8lgZ3w3UsudpIxeMNM7
         aV6NlhCiZ8QvQo37pttU3tqIVDPbCo19wXddBOPOvuQnixVjz7E3CcDr8jaoDlSH71
         k2UGo3M0PE22Q==
Date:   Mon, 13 Jan 2020 12:37:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kars de Jong <jongk@linux-m68k.org>
Subject: Re: linux-next: manual merge of the keys tree with the m86k tree
Message-ID: <20200113123700.66678b59@canb.auug.org.au>
In-Reply-To: <20200113123603.33c957e1@canb.auug.org.au>
References: <20200113123603.33c957e1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pmX1aiNqPKM4ADVfByxEXCA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pmX1aiNqPKM4ADVfByxEXCA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 13 Jan 2020 12:36:03 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the keys tree got a conflict in:
>=20
>   arch/m68k/kernel/syscalls/syscall.tbl
>=20
> between commit:
>=20
>   e8bb2a2a1d51 ("m68k: Wire up clone3() syscall")
>=20
> from the m86k tree and commit:
>=20
>   519c484a997a ("Add a general, global device notification watch list")
>=20
> from the keys tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Sorry, forgot the diff ...

--=20
Cheers,
Stephen Rothwell

diff --cc arch/m68k/kernel/syscalls/syscall.tbl
index b911e0f50a71,83e4e8784b88..000000000000
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@@ -434,5 -434,5 +434,6 @@@
  432	common	fsmount				sys_fsmount
  433	common	fspick				sys_fspick
  434	common	pidfd_open			sys_pidfd_open
 -# 435 reserved for clone3
 +435	common	clone3				__sys_clone3
+ 436	common	watch_devices			sys_watch_devices
 +437	common	openat2				sys_openat2

--Sig_/pmX1aiNqPKM4ADVfByxEXCA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4bybwACgkQAVBC80lX
0Gy3tQf+JTWHpzmgLKxMC6EnUpwvvKATptxnrrx5UEBBSaPACd3Cmr2tLmDHETR8
dUSxD8load1scgLI5RbU0JvYz68TTINm/LgNcxWW1BCWqp1FYOv1L9HAqCDYhEgV
3p3MmM3C/AnMVYHNNLv+RZc6TmaB8LkUq4Nbc2JqsX+o/WgCTh/z+cqthXGgi5m2
MsdAnx3gmSbueHBnIwM4NLpw3X/Lg/Ca1lCD16UUm9o4/ocwtksAftAL/4rMdR5D
ru9d52cbZI7pzLQD6wHwiTDol/JKukEZ0MZhTdGzu0ZMau1Yb6PGaVvsIEJ62TTc
xprh4RCZxY/8nDux0u1q7xzje0HM8A==
=1kU1
-----END PGP SIGNATURE-----

--Sig_/pmX1aiNqPKM4ADVfByxEXCA--
