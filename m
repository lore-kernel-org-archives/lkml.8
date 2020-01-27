Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3747FC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 22:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B32A2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 22:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ny0HnEv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgA0W4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 17:56:09 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:44411 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgA0W4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 17:56:09 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4864qB6nz5z9sNF;
        Tue, 28 Jan 2020 09:56:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1580165767;
        bh=40GfQrYXKQRi1HiQxJm/dZEpU37gKsYP32p+mgdzUZg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ny0HnEv7EujiR1uHmWuoq+1HWmURBPwVEnJVqrzBBxIM+gdyE0tVc7ryLbnDkdDMt
         UEcbJQqQwNxMKi/3sxJgErHxaScmVceYCXsW4e4wLUBTopFFXpaYlIlh1zcAzVkr2l
         bK+JRLzcBHZgVJCTwZrSGP79CVVcsOpj2NVnTAibMy4CnlhXpShM7objm6hDi4vLdf
         D7toE5ArsrqGdQhj+1F9QEyc4CwMM/PBIBq6uCLn+FnGlEDzcApbwF73XAgLEwZbHQ
         fUVRZompKcY7+xTfC8JGgI3zAqShCeYTEHGcY9JAu3JZxrJksBpXg+I6mLjgg8K/Hg
         GKQeDSsMx6BZQ==
Date:   Tue, 28 Jan 2020 09:56:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the generic-ioremap tree with the
 drivers-x86 tree
Message-ID: <20200128095606.46321fd8@canb.auug.org.au>
In-Reply-To: <20200110165233.0ee71ee4@canb.auug.org.au>
References: <20200110165233.0ee71ee4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jfKxabZggQ46dtj35FrU3PZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jfKxabZggQ46dtj35FrU3PZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 10 Jan 2020 16:52:33 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the generic-ioremap tree got a conflict in:
>=20
>   drivers/platform/x86/intel_telemetry_pltdrv.c
>=20
> between commit:
>=20
>   ebc28a8e59ca ("platform/x86: intel_telemetry_pltdrv: use devm_platform_=
ioremap_resource()")
>=20
> from the drivers-x86 tree and commit:
>=20
>   4bdc0d676a64 ("remove ioremap_nocache and devm_ioremap_nocache")
>=20
> from the generic-ioremap tree.
>=20
> I fixed it up (the former removed th referneved to ioremap_nocache so
> I just used that) and can carry the fix as necessary. This is now fixed
> as far as linux-next is concerned, but any non trivial conflicts should
> be mentioned to your upstream maintainer when your tree is submitted for
> merging.  You may also want to consider cooperating with the maintainer
> of the conflicting tree to minimise any particularly complex conflicts.

This is now a conflict between the driver-x86 tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/jfKxabZggQ46dtj35FrU3PZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4vaoYACgkQAVBC80lX
0GxyXgf+KROeYp77akXAPd+oLq8ARqbG3f6/19EUYeGf8Kk7RELofvd7BVtjvEiY
BOR9VrkjScyaQW+O9akuM76rbfrBpaDOTWPIrZKE92uOFx8jGadACJcsG4glFq3T
8es7vxikFhWL+Ib1lJDWSfFlWK/mpVymiUfNZrc5mIcGSEnoXKTGKY3RmlRb5VDO
cL/yX0TvCZjzSIGjNWAFsURJ34sBKaPPWP61MblCIDf27gyV9EOL0d+0s+xIfJgg
NHM9K6OT7w+fP/uCPVwOVH/YkHvUNzx0VPhkBYVGHSV5S+OPaQjcmj+WRu1tKDhF
DEqLFTss+NKLOBwpLdCZh7nreEdYlA==
=IeyD
-----END PGP SIGNATURE-----

--Sig_/jfKxabZggQ46dtj35FrU3PZ--
