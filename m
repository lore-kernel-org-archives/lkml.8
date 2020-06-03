Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5384CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26A5720658
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ie3lU8FK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgFCX4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 19:56:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47845 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgFCX4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 19:56:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49cm5H4QvHz9sRN;
        Thu,  4 Jun 2020 09:56:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591228565;
        bh=/zxbXFxFamUIQavwHFTTGTY7S1++MLMYz1/H6wafsPg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ie3lU8FKvBecCJwoaEGVQ0BGavib0Jj0bBlGJrP4kDD6re2L664r+vqwp1hWqy6a8
         iuN4RYzoEoWh+0Kl6sQ4MdVrpDK0JEOVlbkn5IWyJHHqS1Fqw0vhzjSFBuj6FMFFbP
         E+2gpvUd4PKQVW4RGl9f37ZQ14JS/qEkFLR+ZQbTHt+n6yI8q9e7YwVv81GBlp37wv
         Vmcs+07zRq4n6IPVs7yAcH19qWlVW28H6uiWHa+OCjSpAc7gkwK7PrmQyENmD9r9m3
         yOguwJ3M2ixdP68/E0Qe+5Z9TXnHjtHlKAu7DUQY/3ArsyTEeC+q0P2a/k5//0M2Nz
         yNWs5vwOcgkPw==
Date:   Thu, 4 Jun 2020 09:56:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: linux-next: manual merge of the mips tree with the clk tree
Message-ID: <20200604095601.1e88997e@canb.auug.org.au>
In-Reply-To: <20200511092448.65c5d790@canb.auug.org.au>
References: <20200511092448.65c5d790@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/munb1_60mhOHYgbt7nWI3lw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/munb1_60mhOHYgbt7nWI3lw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 11 May 2020 09:24:48 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the mips tree got a conflict in:
>=20
>   arch/mips/loongson2ef/Kconfig
>=20
> between commit:
>=20
>   bbd7ffdbef68 ("clk: Allow the common clk framework to be selectable")
>=20
> from the clk tree and commit:
>=20
>   c02e96304451 ("mips: loongsoon2ef: remove private clk api")
>=20
> from the mips tree.

This is now a conflict between Linus' tree and the clk tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/munb1_60mhOHYgbt7nWI3lw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7YOJEACgkQAVBC80lX
0GxEVAf+Kl5c3yr22UYJv7+87hBvVQrFUT9TfK3sdLfKok6ZdI6371jQilJGWJn9
VlduIveZPHTPTtRkXXh40NE3943gItluiVVuSMmMn6F8OXKIxzZjBUhw9ueBxKz2
bGcyrWRKqRsbucgN9py0xnJxfiRLis9KnG1po4a+iC6ZXgqRNxA5RsTestMB3nwb
wyVqFcOre34gxE8hWJ4CN77kfYWVICr/b/JDTP7xzRfAp7/XZ78tUwHqrcqXaY/r
tQu528O3e2FeNchzt4VWfgxOTaDrh1mdjpF/VufXMMGXUnipkLi0SY/Mt4qBq8/j
hnf8qD1zd1pD7RdbZGhINIhhGdJbng==
=ssJ/
-----END PGP SIGNATURE-----

--Sig_/munb1_60mhOHYgbt7nWI3lw--
