Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1C1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 11:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF04C2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 11:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Eki0+EB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgG3LP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 07:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgG3LP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 07:15:28 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26F2C061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 04:15:27 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BHSWG6sjxz9sR4;
        Thu, 30 Jul 2020 21:15:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1596107724;
        bh=SZTIjXiffI1HVrd0DN5lE7xLsaof/MbgIRVfIXV15o0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Eki0+EB8zA3AcxXO0Q7yIldE0cGruHJk4LbVRQGZZx2E+zpt7COogL+fUAVaXJLJB
         l89X4Nfb1EWBa+UtppIu1j/EzHFWc5PW8WLFkIpOswMAQ9lgc33aX0JsPhr++B4qQO
         jO4PDDrCxjIGQVGIVo1Jm8syzWBStJx/DCE1aNtGbYehglhiziNag9pEpTI3aHHCth
         bqBRTm8TTnjmXotXKbVD1dyOlO6p9rfCA14F5rIRAO7t87Vyd5gsCATIE/QWRt16+O
         Z/lmIIC+DtERZ67NYR6fLHi24Q3pSc3z8qQCMx9vJgDTU2S4MJPjaKDlCO61eIT4Sp
         fpSItUe4YKl7A==
Date:   Thu, 30 Jul 2020 21:15:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        re.emese@gmail.com, Kees Cook <keescook@chromium.org>, w@1wt.eu,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, hsinyi@chromium.org,
        "Theodore Ts'o" <tytso@mit.edu>, richard.henderson@linaro.org
Subject: Re: arm64: pointer_auth.h:40:3: error: implicit declaration of
 function =?UTF-8?B?4oCYZ2V0X3JhbmRvbV9ieXRlc+KAmTs=?= did you mean
 =?UTF-8?B?4oCYZ2V0X3JhbmRvbV9vbmNl4oCZPw==?=
Message-ID: <20200730211522.1ea3561f@canb.auug.org.au>
In-Reply-To: <CA+G9fYvSyXnfGmK1FLRtraWWre7QjUoGE_qiwM8XPUBXjnudWA@mail.gmail.com>
References: <CA+G9fYvSyXnfGmK1FLRtraWWre7QjUoGE_qiwM8XPUBXjnudWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/os0Su/w9QRKsjvVjuQA=g8C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/os0Su/w9QRKsjvVjuQA=g8C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Naresh,

On Thu, 30 Jul 2020 16:25:49 +0530 Naresh Kamboju <naresh.kamboju@linaro.or=
g> wrote:
>
> Linus master branch failed to build the arm64 architecture due to
> below error and warnings.

Thanks for the report.

Please see https://lore.kernel.org/lkml/202007292007.D87DBD34B@keescook/

--=20
Cheers,
Stephen Rothwell

--Sig_/os0Su/w9QRKsjvVjuQA=g8C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8iq8oACgkQAVBC80lX
0Gx/uAf/eDoIWkfM+LtYiHmGQ6ufky2yy+lfcuEjQT2zOc6JbKXNpUPObtUtYw5N
xaliQg8OvKqTL+0ENLVSknlASEzgNIkdYvgREDiErp8DYGNOjTsmDB6M54E6dvnc
vHYfUR9i5clTf0TCZaRvdlgeo+lMCtd9//qR7h5awpw/Cx4k27Ddav5tb+ZUwKL7
re5zX2+rgwg/hnCK04RMi/GDc4fjU2fC84BvwubITDqjEzbQFRVYjOscGWlcuKgq
3PYidzH1qppDtUIIrie+sMvtcYTUytrB3B9YZNjZCy/KsszvzgnZKIU3s6JPF0et
W5R6u6huphE4g7+w81uDGsBOv2gBqQ==
=BnqQ
-----END PGP SIGNATURE-----

--Sig_/os0Su/w9QRKsjvVjuQA=g8C--
