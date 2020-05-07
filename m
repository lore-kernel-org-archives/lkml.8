Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6588EC4724C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37AB020838
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="m4+31SmW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgEGDEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 23:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbgEGDEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 23:04:37 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352BAC061A0F;
        Wed,  6 May 2020 20:04:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49Hdbk5Nd1z9sRf;
        Thu,  7 May 2020 13:04:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1588820675;
        bh=a+F66NvecwiCtPS7aubjUnfdcDz9hKUlOuxsLFVVZdA=;
        h=Date:From:To:Cc:Subject:From;
        b=m4+31SmWOo9CFW7NN0hyV4U94NU1otuQbA4aEKKNVNToudihSgAnTSl9nAXwSa0Ab
         sDKyEUiAu/3vwW6motWQNJ86hAjKOIEBw7kjBD+bB95EIugtAYubXUEPqk92NfwsZU
         Hcqv+xCL5Fp8EIWg8Mmu9dquBGmfZNNvU15fakfvZNK0r2Cq0fw9Gfcr8ddOVoLdJZ
         AetFpXdAr4v44InTbC6zZP73CPnbTeFgfjuXHTo9bihhg74wr6NVbE3BPk95RR+nIj
         jD1yBYYgzssU5ZRfraY83MsVH4feAMUXzI+hhEvcT0vwW18pUh7wymm4EfPgrj3RIt
         wMjZ978XFhPCw==
Date:   Thu, 7 May 2020 13:04:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Harigovindan P <harigovi@codeaurora.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: linux-next: build warning after merge of the drm-misc tree
Message-ID: <20200507130433.27955b1f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IMMi3Hd2LSA7IcZxxDM+k=7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IMMi3Hd2LSA7IcZxxDM+k=7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

WARNING: modpost: missing MODULE_LICENSE() in drivers/gpu/drm/panel/panel-v=
isionox-rm69299.o
see include/linux/module.h for more information

Introduced by commit

  c7f66d32dd43 ("drm/panel: add support for rm69299 visionox panel")

--=20
Cheers,
Stephen Rothwell

--Sig_/IMMi3Hd2LSA7IcZxxDM+k=7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6zesEACgkQAVBC80lX
0GyMmggAn1kCCD1zMQkWORF0w7eNpngLumwm2QsWsEBC54XP6OTKJnQWsAImgxaq
Y0BeHLUvNygFlhlcOCwSgBNgEU4V/Xe5oyvEk/G1wwF79VtvUCSj6lnqVPhbwgZ3
rZALNBjk1uK5izQLc6WTszEF/1QhkAKzombsaJQXVIk1f5DpdNLZ8GdBZ1Cp/Hlq
9EWsw0COE3tDvQY+l+4H/NC8qKIftJkOMQmb8vtyGSyVlqOixW6ojrvQb7vNxR+O
lGJMFf7vMP5I83En+tD7cE4eCeStSxiIv6enrpyqodeehYXj5/tfD0Wk3jg38NUe
DVaIGkYGb/qP02vl9NBQfDffHQUrEA==
=MdCf
-----END PGP SIGNATURE-----

--Sig_/IMMi3Hd2LSA7IcZxxDM+k=7--
