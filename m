Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F314C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4033B2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="X4a41nCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgESGQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 02:16:56 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56737 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgESGQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 02:16:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49R5J15Zn0z9sPK;
        Tue, 19 May 2020 16:16:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1589869014;
        bh=91pVM7ziWiSyFU0HhHOGx9PvU8o39xIEsU9i8jU4B4s=;
        h=Date:From:To:Cc:Subject:From;
        b=X4a41nCSUEyOV2+ZJV7ZROH0mdXJToC2tSvTXSAAUSMoFPKr/lT9UacAhvjx5Gsxf
         Rnu/Xr4JQcWmJRLo1C30BIUXoUMDHwsw+XjyQ6uhRU5bRrsv2ZleZt3FZb47raMl+/
         m4jvkDuo0QAAWHTajPj6+XOHWouI2m3Ezoe/Waib+e5UOSxcPYHFN5pqB7ZsnFO0Za
         zVocR1JpZv0vvNOd5muXttarzLnCvstiDeKrBKECZoCoE4syFJask+GonNj3fzCMoQ
         s53nXtRiqlxE7JvGS3gALUw2Y9/gi+AtdcI2224iKcP3D8kO1QzenhOlpyJS6y17XV
         VOwK21R/g0C5g==
Date:   Tue, 19 May 2020 16:16:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: linux-next: manual merge of the tip tree with the drm-misc tree
Message-ID: <20200519161647.32403208@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z9NU_G605JuTD9ChLDt=.5E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Z9NU_G605JuTD9ChLDt=.5E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  drivers/gpu/drm/drm_dp_mst_topology.c

between commit:

  a4292e52106b ("drm: Match drm_dp_send_clear_payload_id_table definition t=
o declaration")

from the drm-misc tree and commit:

  53965dbe5396 ("drm: Make drm_dp_mst_dsc_aux_for_port() safe for old compi=
lers")

from the tip tree.

I fixed it up (I used the former) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Z9NU_G605JuTD9ChLDt=.5E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7Dec8ACgkQAVBC80lX
0GzY8Qf9GmoyBCxWOB7HGwwV5JAnLgPlznojx78MaSq1M0n+D7gclsWyHlWQkusY
Br1BuPhoAlha3EmCqLVAKJp7mQD1dnzFj7Z2hZqcoHSsxxN7YIqgES/VjqY5gs4i
0q9oqhJ2tS0XVYgEHY3MeIZTZRteW/1FllBeyyXNvruCcltNt+QK0PcOoUIGGtu7
WXEqHwK1FSUXmI+TAx6Nr5GiIY1h0sRyWhOuYTvj9oDxIAc8H1cD4q3Y/EwzlWCm
UzuX+NL1NOP5fYVcEwRuG9uHbIMelMh9tvwgVYEwSxgFVK2ImBnE0TzfdR+913p4
JZcJBWdYzrppFPofG3IiGaChBYDcPw==
=myR2
-----END PGP SIGNATURE-----

--Sig_/Z9NU_G605JuTD9ChLDt=.5E--
