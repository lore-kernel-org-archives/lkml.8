Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8233C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DDE20748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dfDtNYV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388214AbgAPV2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:28:42 -0500
Received: from ozlabs.org ([203.11.71.1]:50089 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729238AbgAPV2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:28:42 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47zHPM28Fcz9sRG;
        Fri, 17 Jan 2020 08:28:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1579210119;
        bh=dhL2oLt36qVVXXRO8eh4Ows9MshsQHRdLvBIk/5yB0M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dfDtNYV5/j7GksYw3MLyIWid/fuA7f3YAQj50BONrulY9IJy6LzTaTUDAWXut9kZ+
         3XhFE2dp5oHxKjr+zs5VxCaz5+KzfgVQgjXUgxmdM3bn38pk6lhsLaxeTmFz0Ww4Dy
         ICgUXw1GsyQeAodj4/MRRffCpLKsad9bmQtjS7Nl8pH7srkZgbjTyhTs2GlSCdQdso
         7cv1/2H/Ocu3xtPmMEb7oRoy1u4RPXpSnNpPon1iebq9XBrIJ9Twcs3MZs9XmYJt3i
         95Racl9Jq0W5ks8KCfuDL3DYCk5rraKD4Tt+5H01jk0cENeyALI6x3PfKdP4qcaoyA
         IHfMnI2W4XWAw==
Date:   Fri, 17 Jan 2020 08:28:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failures after merge of the keys tree
Message-ID: <20200117082826.38142c79@canb.auug.org.au>
In-Reply-To: <20140.1579207620@warthog.procyon.org.uk>
References: <20200109132240.264728ef@canb.auug.org.au>
        <20191212115901.221d8ba1@canb.auug.org.au>
        <20140.1579207620@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lOiKmKB=FW9oFY1WmVaXxc7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lOiKmKB=FW9oFY1WmVaXxc7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Thu, 16 Jan 2020 20:47:00 +0000 David Howells <dhowells@redhat.com> wrot=
e:
>
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>=20
> > Any ETA on when this tree will be updated? =20
>=20
> That should be fixed now.

Excellent, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/lOiKmKB=FW9oFY1WmVaXxc7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4g1XoACgkQAVBC80lX
0Gycmwf/SNhzBBck+HH1+pyi8USIswkz9E/UOdznEkXvqE3nhmw2IgWAMr7IZ4bo
g5I71qiRh0MGjpug7pTuAaym/0ytv9+mzx64nyfNdPyBzLg3gkL0xR1sP6Uvo8N7
m28OsT8D6m8yIFoqQqoUfhz/69w+mTRNl43/g8rRWpvPDtiJH/QI2ssHmZF1+Mcz
eq8luXeAAdRTv1Rf88AmIC2zXihidaAxIXA0LyZOeQyPiVDGPQww5oTxHmP9rJov
3v+9Y4YUkOPIepfNEsD1Ybw6uUknXlsL0Q0/ytZH5cQnM+JJt8ww+8ihbbvKtHO7
XoFgqvKpe6ZKOCXLk8JiqcG5ES53tA==
=Lv1B
-----END PGP SIGNATURE-----

--Sig_/lOiKmKB=FW9oFY1WmVaXxc7--
