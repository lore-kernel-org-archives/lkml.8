Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730B7C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BF9A206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UB1LjpM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgD1Gg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 02:36:59 -0400
Received: from ozlabs.org ([203.11.71.1]:37115 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbgD1Gg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:36:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49BBkx4j90z9sRY;
        Tue, 28 Apr 2020 16:36:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1588055817;
        bh=t0hxpspnXqRTaTDCuFjnvDSG2327Z+2CcoYz+C0uNZU=;
        h=Date:From:To:Cc:Subject:From;
        b=UB1LjpM3C5BDyexRnezg1pK9D//5CbDSIL9sJxBB6mJtzxmiKRdLHMtcw7z5xVHsB
         dHjFpGhD99yj/Qrj1SUypEoM86u5xR4vVVrbplslMsls6DcB3LfJ5+6KzNbEin/bV1
         n12cgULlljSSGT576z6kugr1xIv7S19GSVT6FDO95Rk3O+yL28FTOjs75BbufqX/mQ
         Oy9JTzp3rqO14cV1JoMsCtP48ZfSD+dRHOgyHvHuo0aqdstIJVwCqO//VG+NiNVepK
         9DwOdKDZhcL5LGdkfdKh3QAG7hiPea8I1qxvpJvmsKLyxRz61N6HoX6XifahTzXpRQ
         28pw04/vLVLrw==
Date:   Tue, 28 Apr 2020 16:36:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrej Picej <andpicej@gmail.com>
Subject: linux-next: build failure after merge of the hwmon-staging tree
Message-ID: <20200428163655.28eeeae0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MlvelvNSwKCtzHzKy6q7BCA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MlvelvNSwKCtzHzKy6q7BCA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hwmon-staging tree, today's linux-next build (powerpc
allyesconfig) failed like this:

drivers/hwmon/lm70.c: In function 'lm70_probe':
drivers/hwmon/lm70.c:186:34: error: 'lm70_acpi_ids' undeclared (first use i=
n this function); did you mean 'lm70_of_ids'?
  186 |   acpi_match =3D acpi_match_device(lm70_acpi_ids, &spi->dev);
      |                                  ^~~~~~~~~~~~~
      |                                  lm70_of_ids

Caused by commit

  02b925a9104d ("hwmon: (lm70) Add support for ACPI")

CONFIG_ACPI is not set.

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/MlvelvNSwKCtzHzKy6q7BCA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6nzwcACgkQAVBC80lX
0Gx1XAgAoUuHMnuMoz9SwvbULeeIWTzw3g/uUallchZFIyYdyuFJyziz3/URr2aj
5XTDpRp2xiEyAp12d7EMNvjP+YreN+TzIVbTKv2tKXIgCqgjMPbsJYFLeaZFwh0v
8SmBd2OkgbciSi4u/sWyQ/iLyW27pVpz16y5LXS12xN2fdS6jdvt3YcAHI/nxxGB
mIg6P0wiT1lJq2qsNfOFJUxXNWhsjqYlI2ShZJxErXa8ZeCzFlRbvkGekC1K8xFK
HXEDbyFuqxnt8GhDH5SIilKiGpLjRqoeh8I3cHX5XgASyAIQt+f/r08ZahICgXJr
KKANzVoTo+1yOMhod5Vb4tHlKgSfGQ==
=373Y
-----END PGP SIGNATURE-----

--Sig_/MlvelvNSwKCtzHzKy6q7BCA--
