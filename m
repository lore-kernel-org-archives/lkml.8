Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCCAC3B1BF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 23:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B592086A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 23:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cY4mbkYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgBPXZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 18:25:22 -0500
Received: from ozlabs.org ([203.11.71.1]:45119 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgBPXZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 18:25:22 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48LNWg4Zttz9sP7;
        Mon, 17 Feb 2020 10:25:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1581895519;
        bh=6iPV44G5eZYzV2SJDig7NPknoWdW2BskygcTyt0PuDw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cY4mbkYZ70iAVxMmfS5ul1fZQp5Um4ugLEVc5cdZvywg9N2PKK3FsrcELXMrPUM2u
         xjblANLau25Q7GcaHXwOny51z1ZNQL0QCLf40S0LcEqaG5rERqpKDpSbUzGV/pkmjm
         Dt0gOgRBhlaPDnO8Ep0JPShe4bvHHLbPUC6dEu5JUZyiWv/kdchtYqC+h0Ada2zzjB
         8vTFnx+CHBAPmZM/VfLl4GuMntIr/ma28uKBYTzsEuUsoKtZlGPNwTSp646UD8SOVO
         8nHhQuIpFGpOjG6y6lbs/jqVe6ZOvP+WnO0UF2AQfmgV4jM/57JycGOZqVXOEijzQ2
         4ddsUP6k8hCGg==
Date:   Mon, 17 Feb 2020 10:25:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Changbin Du <changbin.du@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Make perf able to build with latest libbfd
Message-ID: <20200217102513.2fb2c691@canb.auug.org.au>
In-Reply-To: <20200130105548.GC3841@kernel.org>
References: <20200128152938.31413-1-changbin.du@gmail.com>
        <20200129075829.GB1256499@krava>
        <20200130105548.GC3841@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0d+.dJHvJr2Y1QPjR1vadWw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0d+.dJHvJr2Y1QPjR1vadWw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Thu, 30 Jan 2020 11:55:48 +0100 Arnaldo Carvalho de Melo <arnaldo.melo@g=
mail.com> wrote:
>
> Em Wed, Jan 29, 2020 at 08:58:29AM +0100, Jiri Olsa escreveu:
> > On Tue, Jan 28, 2020 at 11:29:38PM +0800, Changbin Du wrote: =20
> > > libbfd has changed the bfd_section_* macros to inline functions
> > > bfd_section_<field> since 2019-09-18. See below two commits:
> > >   o http://www.sourceware.org/ml/gdb-cvs/2019-09/msg00064.html
> > >   o https://www.sourceware.org/ml/gdb-cvs/2019-09/msg00072.html
> > >=20
> > > This fix make perf able to build with both old and new libbfd.
> > >=20
> > > Signed-off-by: Changbin Du <changbin.du@gmail.com> =20
> >=20
> > Acked-by: Jiri Olsa <jolsa@redhat.com> =20
>=20
> Thanks, applied.

Just wondering if this should have been cc'd to stable?
--=20
Cheers,
Stephen Rothwell

--Sig_/0d+.dJHvJr2Y1QPjR1vadWw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5Jz1kACgkQAVBC80lX
0Gxjwwf/UqUMntkbN9GJcF9N5WQRoywnprnZHDA91mETTX+NCdpDvEF6HxL+wjWA
mhvGnvH0remKhel2BLCxJsvvW695MF2PaTP2cuYneWHNqNgnUtyjuMx7yVgY/NSB
L7qwjnBajKDqZ0NrLjU1FZwkuOzvDN6fq/BNAVbGB+3PaD3FbIoux/jXgTjaNH/t
IyRcmQ9ITYGOLjyh/470NlYlZqPmnfW6o79wuVOgrZb/+BrynarXJm6QqZmHs18Z
ufXG4Ab2pB2cHgL7SlFBzxTC05oM1Zskd461F090Asjm3duAythz0byaiRkinzc5
/4rAtvLuODE7n6LPUP+pnABdNRqedQ==
=2OUh
-----END PGP SIGNATURE-----

--Sig_/0d+.dJHvJr2Y1QPjR1vadWw--
