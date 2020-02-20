Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FC9C11D24
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC32208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bZEaVdng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbgBTWcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:32:36 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:50979 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728582AbgBTWce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 17:32:34 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48Nq8w2C7dz9sPk;
        Fri, 21 Feb 2020 09:32:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1582237952;
        bh=vZW6qBwpp0AeFzqX5S2fPUgNuPGNxKvPGsI0iF6UnS8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bZEaVdng4HOb/iwQzTpI3WW6LZsGSWjogQ/NkCqnwQutHyXMrxXMFmBfJ4F2zAMWo
         8BlzkS2sH9PV2stMLbNVoiXgCQRfFfdKIalFpBL2N8bV3vBEyVac+XOnP/jdWXo3mU
         5/+wtyJX7ftYCcAPMBKOGBj+PKAFCqqoLdYA2HhHU+RueVkWhPrVgQNUyMzysfDoO0
         eu6WpETca0hhYDGZUAkP/l6MM+blfobLMnSYVQkkYh5s4+e9GpX2oQBIbG068O7QQy
         9Ag4BeNFNkGRgF4GtKl9SOnkZSMN3kBarqsepE1fO4X4OXuc6CWegmtZwXvWydJIxE
         L0Fulnns7AMRA==
Date:   Fri, 21 Feb 2020 09:32:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: linux-next: build warning after merge of the btrfs tree
Message-ID: <20200221093226.6194414f@canb.auug.org.au>
In-Reply-To: <20200212160341.GL2902@suse.cz>
References: <20200212091028.718ca6dc@canb.auug.org.au>
        <20200212160341.GL2902@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Omun_ijJexlCWI7V7FVk+SA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Omun_ijJexlCWI7V7FVk+SA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Wed, 12 Feb 2020 17:03:41 +0100 David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Feb 12, 2020 at 09:10:28AM +1100, Stephen Rothwell wrote:
> >=20
> > After merging the btrfs tree, today's linux-next build (powerpc
> > ppc64_defconfig) produced this warning:
> >=20
> > fs/btrfs/volumes.c: In function 'btrfs_scratch_superblocks':
> > fs/btrfs/volumes.c:7338:3: warning: ignoring return value of 'write_one=
_page', declared with attribute warn_unused_result [-Wunused-result]
> >  7338 |   write_one_page(page);
> >       |   ^~~~~~~~~~~~~~~~~~~~
> >=20
> > Introduced by commit
> >=20
> >   d19ec014a46b ("btrfs: use the page-cache for super block reading") =20
>=20
> Known and fix is in the patchset revision that will be in the next
> for-next branch update. Thanks.

I am still getting that warning.

--=20
Cheers,
Stephen Rothwell

--Sig_/Omun_ijJexlCWI7V7FVk+SA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5PCPoACgkQAVBC80lX
0GzKZAf/TZsePCuP1LNEqIjwO1FunxodRm5cUEkRkmijOOQWsRxT3DLt5V2wvepL
b1mqzwwEswNT6/ozA1xKlIg0u+olZWVf4IwpmzPq4Fsjc7AAa4Sm9QMaBEZjS2/l
ahF6F5vT0fSu8S+0754b1xywXhGNiqXQqnhXThJh+04ERXm2DEhLwcscP4i84Lyb
bKbIP7BQ8cl//5Jgmb39rOmwfIcedFKGOwz/BdMxomWPmerepINtgGgY332+3ZTO
+VP3zubX7CFcKMkCtYVIwZUR6SHFfbqp7gYyAaorYhTNwhjA1H7JJphD1F73yiKC
N/dJqyuMR4hlmxgPOKkNkOM6iPBJlQ==
=sHfS
-----END PGP SIGNATURE-----

--Sig_/Omun_ijJexlCWI7V7FVk+SA--
