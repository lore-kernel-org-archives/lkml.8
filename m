Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0DCC35240
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448B2214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgA1SNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:13:04 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:56402 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgA1SNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 13:13:04 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 8DC231C25FD; Tue, 28 Jan 2020 19:13:02 +0100 (CET)
Date:   Tue, 28 Jan 2020 19:13:01 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot+156a04714799b1d480bc@syzkaller.appspotmail.com,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH 4.19 67/92] netfilter: nf_tables: add
 __nft_chain_type_get()
Message-ID: <20200128181301.GB11577@amd>
References: <20200128135809.344954797@linuxfoundation.org>
 <20200128135817.894498379@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <20200128135817.894498379@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Pablo Neira Ayuso <pablo@netfilter.org>
>=20
> commit 826035498ec14b77b62a44f0cb6b94d45530db6f upstream.
>=20
> This new helper function validates that unknown family and chain type
> coming from userspace do not trigger an out-of-bound array access. Bail
> out in case __nft_chain_type_get() returns NULL from
> nft_chain_parse_hook().

> +++ b/net/netfilter/nf_tables_api.c
> @@ -472,14 +472,27 @@ static inline u64 nf_tables_alloc_handle
>  static const struct nft_chain_type *chain_type[NFPROTO_NUMPROTO][NFT_CHA=
IN_T_MAX];
> =20
>  static const struct nft_chain_type *
> +__nft_chain_type_get(u8 family, enum nft_chain_types type)
> +{
> +	if (family >=3D NFPROTO_NUMPROTO ||
> +	    type >=3D NFT_CHAIN_T_MAX)
> +		return NULL;
> +
> +	return chain_type[family][type];
> +}

Are enum types guaranteed to be unsigned on all compilers we care
about? Google says they can be signed, too. So, should the test be
"((unsigned int) type) >=3D ..." ?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl4wea0ACgkQMOfwapXb+vJzmACgpi7GdZGQUmNUC33lmbEt/vZo
pecAnjMmeEu7IiNTeQXeZK4UccuQ0lhK
=/wSs
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
