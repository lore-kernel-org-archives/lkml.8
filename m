Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AB8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 04:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F34A32072A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 04:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YFBSpc4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgGaEAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 00:00:21 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46027 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgGaEAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 00:00:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BHtpj6GDcz9sRN;
        Fri, 31 Jul 2020 14:00:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1596168015;
        bh=IYnmS5SRsESSUPE13MZ6169T6bUwLsb8HLxQLRkNHo8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YFBSpc4oM0SeYkZYs/cgfF5nya0iOo2PRYRpDrBbOKN9Pr6lc2wCV1c7wsjW7b9/1
         yVWWY+DKKPXQLbDBnQmioF5qBRWHvzI4LrmZ82F1oQ336hE6ITFowYbHMCOcf02ECO
         jVw8LDep3ich1zbiBzBqtXb552qhwuH+a114H99KZCyIa3kbtXBi/8s7AIbBWVQQoK
         Dgz/mFyK92zwnBnzPtWiBcbixO2zd079LXDoc+FWST8HqS+IgkiB2hG9DJ8NNY5R2+
         n7kKz0H870Y4v4ncFhjXsj4FBRQlFAwjyOLwxUgv1b+MY8ZpEoX7Rmewi63ecQfu0T
         lSEdVmjnnSmjw==
Date:   Fri, 31 Jul 2020 14:00:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: linux-next: manual merge of the devfreq tree with the arm-soc
 tree
Message-ID: <20200731140012.34ee461d@canb.auug.org.au>
In-Reply-To: <20200727201600.7d3b31c8@canb.auug.org.au>
References: <20200727201600.7d3b31c8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qsbv3btk.mRkXMN70G7UUS8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qsbv3btk.mRkXMN70G7UUS8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 27 Jul 2020 20:16:00 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the devfreq tree got a conflict in:
>=20
>   MAINTAINERS
>=20
> between commit:
>=20
>   8a9ff8758159 ("MAINTAINERS: Add Krzysztof Kozlowski as maintainer of me=
mory controllers")
>=20
> from the arm-soc tree and commit:
>=20
>   34886407581b ("PM / devfreq: tegra: Add Dmitry as a maintainer")
>=20
> from the devfreq tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc MAINTAINERS
> index 2b1d2d3fbd4e,e2e95c877f0b..000000000000
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@@ -11202,13 -11086,15 +11202,22 @@@ F:	Documentation/core-api/boot-time=
-mm.
>   F:	include/linux/memblock.h
>   F:	mm/memblock.c
>  =20
>  +MEMORY CONTROLLER DRIVERS
>  +M:	Krzysztof Kozlowski <krzk@kernel.org>
>  +L:	linux-kernel@vger.kernel.org
>  +S:	Maintained
>  +F:	Documentation/devicetree/bindings/memory-controllers/
>  +F:	drivers/memory/
>  +
> + MEMORY FREQUENCY SCALING DRIVERS FOR NVIDIA TEGRA
> + M:	Dmitry Osipenko <digetx@gmail.com>
> + L:	linux-pm@vger.kernel.org
> + L:	linux-tegra@vger.kernel.org
> + T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
> + S:	Maintained
> + F:	drivers/devfreq/tegra20-devfreq.c
> + F:	drivers/devfreq/tegra30-devfreq.c
> +=20
>   MEMORY MANAGEMENT
>   M:	Andrew Morton <akpm@linux-foundation.org>
>   L:	linux-mm@kvack.org


This is now a conflict between the pm and arm-soc trees.

--=20
Cheers,
Stephen Rothwell

--Sig_/qsbv3btk.mRkXMN70G7UUS8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8jl0wACgkQAVBC80lX
0Gz8cwf/fmKmvAQ3/kX0yatHmq0S7WxLOHsKfm2+y0ElWDk7Rf+jE7ENo6Kb3E54
kQ//XxPLlqGig9cyXiSdxsUKmJMg68TXN4kJYAoAZGQdbj5uc4HuDwuTRMh1h1cX
2TdcVDiHgqF0g9QQaOLqNY6Avk9fgdUYm8wpj5TgVVi+J4lN8LTZ7h/NcoAbkPrs
TPfQW65Kv3xA4P61NkK9rl8n0KvDqBnGKGaCcw/efP4974sd8Yc0bW+GV/M8TUT9
A94HFVDjLya/8SoWyNyXuqCKjkgBZzwdQ25KyXZtP7JmCFudqVBzPsizdT6JrvMo
tePjWt9Eoze7YF8O1MZvMD3xwAEIgA==
=U0jt
-----END PGP SIGNATURE-----

--Sig_/qsbv3btk.mRkXMN70G7UUS8--
