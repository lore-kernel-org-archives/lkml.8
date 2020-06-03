Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB457C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1E63206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CDbanImM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgFCMwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgFCMww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:52:52 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABA4C08C5C0;
        Wed,  3 Jun 2020 05:52:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49cTN22FHYz9sSc;
        Wed,  3 Jun 2020 22:52:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591188770;
        bh=U+VwkglKt05YbLBNtU1dwgDkEzgBXJ6rAnxyYgo5E4o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CDbanImMLmBPCyDWgCpMqhPZ3zoOU0lAL1tITpl00DkKTyDeyVsZF7u8i/dnjc2nX
         lPDIFjcotWkEDR97Mz9PXZyCMXZSIUXgJ6LT1WxZKXc1WXf5x9UBEdJlsfnoaI5ODn
         ZCuy4sK/25wro6pXq6bxPTRylZRiclI1rzZTdb5oJkYV1yhextCC0AKaE6YOJ4yCNv
         9z501Z0golR1iuUqkCqRA1LOrHsGI5ITcu5TZoM6c5gpe2PGHPghAlZbSGaibZFS0I
         +KyvNZnCBF+lw2I9fxQ8Ci++IA1qvA22PJdZ/UnBIGpHioGPHd1TyRI8wmsPCxZ+oV
         7jCxoc7Q4RlHw==
Date:   Wed, 3 Jun 2020 22:52:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Rich Felker <dalias@libc.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Subject: Re: linux-sh for-next reactivation
Message-ID: <20200603225248.01740901@canb.auug.org.au>
In-Reply-To: <87y2p4n12r.wl-ysato@users.sourceforge.jp>
References: <20200602031123.GA1079@brightrain.aerifal.cx>
 <20200602150039.780a0ac0@canb.auug.org.au>
 <20200602202832.GA3776@brightrain.aerifal.cx>
 <20200603084105.47bd62c5@canb.auug.org.au>
 <87y2p4n12r.wl-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TIvt.0mHpqZzWI2yT4MsQv4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TIvt.0mHpqZzWI2yT4MsQv4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Yoshinori,

On Wed, 03 Jun 2020 14:57:32 +0900 Yoshinori Sato <ysato@users.sourceforge.=
jp> wrote:
>
> I only provided it temporarily.
> Plase remove git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git#sh-next

OK, will do.  I will also rename the sh-rf tree to sh.

--=20
Cheers,
Stephen Rothwell

--Sig_/TIvt.0mHpqZzWI2yT4MsQv4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7XnSEACgkQAVBC80lX
0GzQ0wf9ET0YopjHkh6G+ERw67pvFWuVakeEytMr0AszH4YAJhXwvAbB2svr0yeR
21bdiSxsSF4MYAuVzutRu68H7ZL1tPuKP8sX0P0FFu8imOHiNjLMzHaoItbJjczE
vjCCRSEWB+jg1M3EB+jg5CJMp3+6+ZJdF8rJh1geZF96tyacojFT8toeraASZoro
8pnqfUdBDs5MJiy46ARgM4WRj/NdQdvmbLv+vHuPKWXHS4ZIbBLNh0KeXaLOk7GO
nQj+T/logmiwfNUZs/3o+F4/DOOUkyUhbfvPtBO4C3MSMNNX3Cpf2T8n7GhkkPON
3r8JXvxGyxyi+gO/vZ+4EfvI4cUeEw==
=LEvm
-----END PGP SIGNATURE-----

--Sig_/TIvt.0mHpqZzWI2yT4MsQv4--
