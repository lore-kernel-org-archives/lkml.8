Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267C5C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 20:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE4624681
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 20:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WoqPppWf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgA0Utp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 15:49:45 -0500
Received: from ozlabs.org ([203.11.71.1]:51483 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgA0Utp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 15:49:45 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48621L11LNz9sPJ;
        Tue, 28 Jan 2020 07:49:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1580158183;
        bh=MZBieDPcgK1Py+yEa7RVUg6oDYVyHNyza9ueNz0hp6g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WoqPppWfNbhN5WbUEvLeIYp4SVnNnvJcMdwaz/YrJplbYokfPHLP08IPd2vh0ar36
         85Kl+Ak/rr47/CnclemByeGS83u8uaGZQ1LeiqDAwS8d8VqgeNgN4DmP6F9k+UclMN
         17YqsFvGCupQbLjTfnykZ8HYztDlEggJSt4dH+OSL1a2aplDtKaVWFDeez5b+hjcfx
         Kd/1APKeFBtdU9P8Scqgo8yGkOfFWi0UnQplevii3UDeLZi0ms2K2WKoOv4OApDSSd
         z8cnY0o6aIsqGcLzZn/Lpvbg0tUtJs2SXfV4CjJgEsoAfmfhsWs+edQ4sCwaHnzC1m
         30e2/5OXeMFGQ==
Date:   Tue, 28 Jan 2020 07:49:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kars de Jong <jongk@linux-m68k.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: linux-next: manual merge of the vfs tree with the m68k tree
Message-ID: <20200128074942.74ae0eaf@canb.auug.org.au>
In-Reply-To: <20200113095037.156597ff@canb.auug.org.au>
References: <20200113095037.156597ff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gdKS2q7hrkg+72Y3xpfQrd8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gdKS2q7hrkg+72Y3xpfQrd8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 13 Jan 2020 09:50:37 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the vfs tree got a conflict in:
>=20
>   arch/m68k/kernel/syscalls/syscall.tbl
>=20
> between commit:
>=20
>   e8bb2a2a1d51 ("m68k: Wire up clone3() syscall")
>=20
> from the m68k tree and commit:
>=20
>   0a51692d49ec ("open: introduce openat2(2) syscall")
>=20
> from the vfs tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc arch/m68k/kernel/syscalls/syscall.tbl
> index a00a5d0db602,2559925f1924..000000000000
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@@ -434,4 -434,5 +434,5 @@@
>   432	common	fsmount				sys_fsmount
>   433	common	fspick				sys_fspick
>   434	common	pidfd_open			sys_pidfd_open
>  -# 435 reserved for clone3
>  +435	common	clone3				__sys_clone3
> + 437	common	openat2				sys_openat2

This is now a conflict between the vfs tree and Linus' tree - just a
reminder for pull requests.

--=20
Cheers,
Stephen Rothwell

--Sig_/gdKS2q7hrkg+72Y3xpfQrd8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4vTOYACgkQAVBC80lX
0GxAPQf+PpquqqjcPl7E+m0z4lOhmCP6kfeFMsKjqxsPDzXVgeHCZC2MG4rzeH4d
+1UQcalFquTcVDtmDP+ZDyMcCA5dUA3M+JMQ2EZjUHDt6TXu8VoJjdkziTa7j9UE
fuWs2XTO2zMGnTIYkMSOwPJ6xeIYZyNs89UuDlT7qsvrLb9Z4O90R6vN2MzeQOJm
YVhrLCkB0wcVls2JmSL2TLyULAf4hhy5hM2ejt7tDJLuDIek+GZ3LAh8sU6ioOoE
YWav6/nhYNLfnYxET8NHuEJ6MXAL55FNJ6EUwtvyCiV4p2nfFcK6bM/wiefZTteP
alvsia2SbHeNTotXjFU0EyOEWcYYeQ==
=Nyi9
-----END PGP SIGNATURE-----

--Sig_/gdKS2q7hrkg+72Y3xpfQrd8--
