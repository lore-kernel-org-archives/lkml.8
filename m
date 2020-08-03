Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD46C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 04:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0B92068F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 04:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QQAcTy+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgHCE7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 00:59:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59217 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbgHCE7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 00:59:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BKlzY1RNmz9s1x;
        Mon,  3 Aug 2020 14:59:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1596430762;
        bh=MPhLnoYZ1H5ZvLDWHdju+j3itySzNLNR+DZxYy9IYNw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QQAcTy+NeF/H+YtJdcgnyqiwVBl+3dAeUgIc/CElGZRCnphjUhbGe5K9KcHunBFpR
         tCbo/SeRBBZS8I9wVXYEkjymC2cFBLpa8xcxN+zQiEopmTuVd1EXOyjbUSotq3yViw
         AgC+AQb7rer1tNoxVwP9eX4g4qm4tJwZd6aWLqnodhNATEWxOujoVE2aVlLqoLk8Aa
         BHqGkn3hxhM1m/i+yfc9P7MMv/MA7aq6oTXhnuqDgGdUi3IEVXPd+Bo+OuuHXwdhz1
         tkoBoEE2oo+1S2yzA1owsIiYwg2Goev88O56jWESos4Coz9KUiGESLMcduyQLldQLZ
         icRQJTv35wb6g==
Date:   Mon, 3 Aug 2020 14:59:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linux PowerPC List <linuxppc-dev@lists.ozlabs.org>,
        Willy Tarreau <w@1wt.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] powerpc: fix up PPC_FSL_BOOK3E build
Message-ID: <20200803145920.72a6fa4b@canb.auug.org.au>
In-Reply-To: <20200803135447.3833067d@canb.auug.org.au>
References: <20200803135447.3833067d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_a6zgj=YiioLKMMN9YZ42FX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_a6zgj=YiioLKMMN9YZ42FX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 3 Aug 2020 13:54:47 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Commit
>=20
>   1c9df907da83 ("random: fix circular include dependency on arm64 after a=
ddition of percpu.h")
>=20
> exposed a curcular include dependency:
>=20
> asm/mmu.h includes asm/percpu.h, which includes asm/paca.h, which
> includes asm/mmu.h
>=20
> So fix it by extracting the small part of asm/mmu.h that needs
> asm/percu.h into a new file and including that where necessary.
>=20
> Cc: Willy Tarreau <w@1wt.eu>
> Cc: <stable@kernel.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

I should have put:

Fixes: 1c9df907da83 ("random: fix circular include dependency on arm64 afte=
r addition of percpu.h")

--=20
Cheers,
Stephen Rothwell

--Sig_/_a6zgj=YiioLKMMN9YZ42FX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8nmagACgkQAVBC80lX
0GzdnAf/efDjHOIC93+8ioQY0UcLlTfk9I7vm8keK3/kCYBUUFSV0y/ewUjRYz4s
4WYVm0Xj00VX9FkiGB8lhoO0nGsf+P9O2k59Y6kQwndAldplPwcjzIgsSDSx+LBm
/aBItNNDfabEUMp67T2ybKCfy1h08wsInmM9gl0V2z1Mo1r4ax3StistxUzQwGj5
fScto/C2aistdWaybnT3Y8AQTMJhxBXkuZoc4s2aMEYC7JxVN/goi3ItOyC37GLL
LR8a1XvjS3sdDZ7gGsY8PXBSB4AmDMx5UPNHAxQk0vKFOQqveoSNxoskOWUEKNrZ
Px72hWk/2AInQqviFzFMMzsPmqw3og==
=Ghwq
-----END PGP SIGNATURE-----

--Sig_/_a6zgj=YiioLKMMN9YZ42FX--
