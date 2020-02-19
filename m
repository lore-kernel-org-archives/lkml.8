Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A7FC5ACC5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8865524671
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OxtDRleT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgBSUgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:36:11 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:35883 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgBSUgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:36:11 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48N8d45BWDz9sRJ;
        Thu, 20 Feb 2020 07:36:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1582144569;
        bh=TkqEEwqDzqYiH2o6WiFCr72ERsD1x+T3P32jihGOYCQ=;
        h=Date:From:To:Cc:Subject:From;
        b=OxtDRleTEiNhrfMl3pqRY7hT69zEUB7PUrbMlnrHBtJ+valEgYFukjQuMq4fvsv8C
         i0OGFjC3ac0MychhxVMfGxcIE0BS6d5ZpTpn3mF3FsHuekPSdcuLaVPtlS1VKnNqAX
         jqb+qn3zudzh7iMTRlvAbJCaDgqoAw15iiXpVXk9lcAQWPM8CAYLpqX0z4BuhMCHAH
         6JUZ8ON+F37kpiJ5ERsRPQtktMtcp7KoTgZ+n9xfPIbHosvbSSXXXNoXjxreA+MlDE
         BxFxCL+Liwkyj+CYtVeBanGz13vRJUgZoVNepJDgn5f8sbLiwZYUU4Xg9YsJ6H+2Sm
         nj36ZSM8NfEYw==
Date:   Thu, 20 Feb 2020 07:36:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Hogan <jhogan@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "=?UTF-8?B?5ZGo55Cw5p2w?= (Zhou Yanjie)" <zhouyanjie@wanyeetech.com>,
        Paul Burton <paulburton@kernel.org>
Subject: linux-next: Fixes tag needs some work in the mips-fixes tree
Message-ID: <20200220073607.33d9cca3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/H2CiBq0BTtkowjMOgaJPm0p";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/H2CiBq0BTtkowjMOgaJPm0p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  eb41113870c9 ("MIPS: X1000: Fix clock of watchdog node.")

Fixes tag

  Fixes: 7a16ccd300c2 ("[v8,1/4] MIPS: Ingenic: Add Ingenic X1000 support."=
).

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/H2CiBq0BTtkowjMOgaJPm0p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5NnDcACgkQAVBC80lX
0GxBMwf/YZy6RPn9UUN7yzl6aC5gG8nU0D+PBZj+a/OVG5M2OJwt7U5+nooEY55F
ZfU1QuLwA9gXTnAz4DoEaF4p6M+sMfUNKbNk/k2ctzuW4XzZ5vsEQUNRcnv4vQBu
XsVTZhJ0dQVy0HPyTh83stVNQyulrU85yvot3OJ4Yt99ySvq0RRdT1BsuElFIDOO
NCAHraZQt/57bg81EKN15V8m0HC5InauwSLPdmqAX/SzUJjCpLJxO1Voe0Lo8uEu
VHpBDLt5o3ry3/f5HH2Dc62V/tmowjxyN3OjcmUgyp2uKyIQ97MC/anopDkyFSkF
MzCtayj4Al5bMaagCMmWAJnnXlxjrw==
=pNiL
-----END PGP SIGNATURE-----

--Sig_/H2CiBq0BTtkowjMOgaJPm0p--
