Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE4FC352BE
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 01:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CAA220737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 01:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="q0U3Iqa7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392568AbgDOB36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 21:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387762AbgDOB3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 21:29:55 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB9AC061A0C;
        Tue, 14 Apr 2020 18:29:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4924Xb3fBQz9sSX;
        Wed, 15 Apr 2020 11:29:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1586914191;
        bh=omhW4zB3sxql8kZzIQwJeeaiRkbdk2G13+ZpkM3mT3Q=;
        h=Date:From:To:Cc:Subject:From;
        b=q0U3Iqa7R2Her0iMgffAZccP3SLf05k7Al5aqMXIjoSD+CduUn5KeHCVkQ+MKmdoP
         lfamB2H+SOn6TKVOy3NBLUrruug/2Mq2DMHpdkmohl8c4rFkBn4jxAeb3a5KaH2nev
         MC8yXmDLoC5sOZlk/TBq4h/tJmwFcJ8PGY2YN7mGuCa88Ts1C98TebQ55M5mu+nKet
         75e1clACPhGyO8n3c9is6L/0zZltwTEjG0v+/BqyXmFn+iNkuN5PXjD/TmsV8KsxNN
         e9Q8zMe7KuQAlCTs8UgjyCx2dIvfNKxUWQzzSCDvRU173EuxE8+IteJTTyxJ23Fc+5
         qUxHYFhZWwhvQ==
Date:   Wed, 15 Apr 2020 11:29:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the v4l-dvb tree
Message-ID: <20200415112949.2dbb0bab@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tjprqdaFY=/5=VZWsmvA/hD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tjprqdaFY=/5=VZWsmvA/hD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the v4l-dvb tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

WARNING: unmet direct dependencies detected for CEC_CORE
  Depends on [m]: MEDIA_SUPPORT [=3Dm]
  Selected by [y]:
  - DRM_TEGRA [=3Dy] && HAS_IOMEM [=3Dy] && (ARCH_TEGRA [=3Dy] || ARM [=3Dy=
] && COMPILE_TEST [=3Dn]) && COMMON_CLK [=3Dy] && DRM [=3Dy] && OF [=3Dy] &=
& CEC_NOTIFIER [=3Dy]
  Selected by [m]:
  - VIDEO_SAMSUNG_S5P_CEC [=3Dm] && MEDIA_SUPPORT [=3Dm] && MEDIA_PLATFORM_=
SUPPORT [=3Dy] && CEC_PLATFORM_DRIVERS [=3Dy] && (ARCH_EXYNOS [=3Dy] || COM=
PILE_TEST [=3Dn])
  - DRM_EXYNOS_HDMI [=3Dy] && HAS_IOMEM [=3Dy] && DRM_EXYNOS [=3Dm] && (DRM=
_EXYNOS_MIXER [=3Dy] || DRM_EXYNOS5433_DECON [=3Dn]) && CEC_NOTIFIER [=3Dy]
  - DRM_I2C_ADV7511_CEC [=3Dy] && HAS_IOMEM [=3Dy] && DRM [=3Dy] && DRM_BRI=
DGE [=3Dy] && DRM_I2C_ADV7511 [=3Dm]
  - DRM_DW_HDMI [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dy] && DRM_BRIDGE [=3D=
y] && CEC_NOTIFIER [=3Dy]

There have been so many Kconfig changes today that I cannot figure out
what caused this, sorry.

--=20
Cheers,
Stephen Rothwell

--Sig_/tjprqdaFY=/5=VZWsmvA/hD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6WY40ACgkQAVBC80lX
0GyUnAf/YAxleygqwxPfTDVhKZzg6hEpSOGjRCgpP1Ivdby9YEazQSuzk3eG3I2n
yR40lk3o6nJ0CSpVvWRsXygK3ddMVLunty3izjz9HrE7itUsCYUu8tSUI5pZBiGT
1fFbIMJaL4uDeEoNkxPXpdvhsGB8decsiNfmT1XnFyY/05hS6QFZVnURg3USUCzo
9MgYyLraN8aj+G83z3xyHEsPjYjnB+AhPnGzF5oNM7gVMBUgxYYQd/WD6vYqrRos
kafDR1tMJ3+R9Oz7eKB6Ge6nk0sG7NGRb/yh2aIrewMBKxrrYqlPf2uNaNg/mnX4
oVFWvIuQ3aJRHYJ+6Zrrqcmd/9sRuA==
=08rm
-----END PGP SIGNATURE-----

--Sig_/tjprqdaFY=/5=VZWsmvA/hD--
