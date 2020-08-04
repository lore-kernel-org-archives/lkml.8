Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9B5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 22:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECCDA207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 22:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="V9Dl2vgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHDWKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 18:10:36 -0400
Received: from ozlabs.org ([203.11.71.1]:38509 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgHDWKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 18:10:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BLppx4TXdz9sRK;
        Wed,  5 Aug 2020 08:10:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1596579034;
        bh=FIq4payXXLivYqUp0sOw7hl2UYg4DeQ2DSZtFhZ5650=;
        h=Date:From:To:Cc:Subject:From;
        b=V9Dl2vgo3kqGWpJwbgvicI3J3mKGkuspjVlpCWTV7zkBjBan4/X2svElItpgcDlnp
         OG8tGYJ59qQFActTb5KNURpGSTipKe/Vu7cPvmsSHO4g1gs57JnNvlYNk8WvdArYri
         PZR/5OtAuT/7epRTfsYlOQ0MxPoXzq28gyUdA/cKcSgG9rhdrbUdNw6+p5uRNM7XKT
         C2oOt+bd0hAe9vDyddnLqr72hPgEs8fr9nY8DZ44T3r76n6CaeBcXJWIyMTw5unW5u
         XMeNY9CGhhaQze6lzC65lBxAexa4km4rjZ7d8LTAmEeensoGE33iTdeQ78X2adN3rA
         qfvvr7YYcjR1g==
Date:   Wed, 5 Aug 2020 08:10:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Scott Mayhew <smayhew@redhat.com>
Subject: linux-next: Fixes tag needs some work in the nfs tree
Message-ID: <20200805081032.5cebc428@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_dse2axoBWWvg8KlGZ915db";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_dse2axoBWWvg8KlGZ915db
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  8c8f8e3106bb ("nfs: nfs_file_write() should check for writeback errors")

Fixes tag

  Fixes: 6fbda89b257f ("NFS: Replace custom error reporting mechanism with

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

In commit

  67dd23f9e6fb ("nfs: ensure correct writeback errors are returned on close=
()")

Fixes tag

  Fixes: 6fbda89b257f ("NFS: Replace custom error reporting mechanism with

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Pleas do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/_dse2axoBWWvg8KlGZ915db
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8p3NkACgkQAVBC80lX
0Gxt7gf/Y+TAVzc1d8P42J/I9Wl/xMC7jaacuEvLcdwP3u/oooXK6v+Si/q+ni2/
2R4vQbv+x2G8KzkzrxU4qulnswcyRfTm82a+FTX0AnxdaBw0jt0SkXbKLxcEkDbF
LflnJGo3bHEQsxa1dX9gskcIoR/r1L6pqP9E7oyhp8xkmYR2hvrGm9geJr9K8tJy
TmS0BJhCXRx8ke3ddlQ1UA74/f9ly//e0J014WQeqy/XTI/iXV+Nj/gscLM4zGKI
4Tw20gy1JnGFO0fRqaJnho5u8cJ2hiHGGatGmzFnWQMPOaewtmRcHBloYb98jT1A
xnls+6LPs3sxUvda1+W6TuygKRrPkg==
=eWUn
-----END PGP SIGNATURE-----

--Sig_/_dse2axoBWWvg8KlGZ915db--
