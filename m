Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5336EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 04:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 210CB20702
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 04:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594096082;
	bh=ZrG8zfHtY/JZ5uDmtDxnyc8SoBUayZoOLVZU2bdnJM8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=GhNsx+Sc2NgC0Stt+rnoHo7yUJfLKHehfeI+61DwRL54ecKJMjgrs+o6i1DpYOzlp
	 gqHN5zfG8zXr0jvg/6x9tjULZAUdCBT4SR+1Ze11nmRx5ijmAawKuNdF1MmZMoxJQX
	 1o062e/ngTMrDkf+E722r0PVjrX4G8jtaDSxjoRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgGGE14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 00:27:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgGGE1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 00:27:55 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 200EB20702;
        Tue,  7 Jul 2020 04:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594096075;
        bh=ZrG8zfHtY/JZ5uDmtDxnyc8SoBUayZoOLVZU2bdnJM8=;
        h=Date:From:To:Cc:Subject:From;
        b=tK9MhcQwaFqLTvRmvT2fud7OKaMZscPT25ZFmernfHuHARY6D13vLtnwNWd7EzCts
         8fRop+pAycr1yfZM73q4Og9SdsXsJYKrpGH42jup3AlSHZOTHIJh7pwRsApllEw9w/
         0crYKJUBvDvB8NeDmlbevGaxQfbH/V36g8w803mo=
Date:   Tue, 7 Jul 2020 09:57:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] soundwire: fixes for 5.8
Message-ID: <20200707042750.GB676979@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Please pull to receive a single fix for Intel driver

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-5.8-fixes

for you to fetch changes up to bf6d6e68d2028a2d82f4c106f50ec75cc1e6ef89:

  soundwire: intel: fix memory leak with devm_kasprintf (2020-06-22 17:15:2=
0 +0530)

----------------------------------------------------------------
soundwire fixes for v5.8

-  Intel driver memory leak fix

----------------------------------------------------------------
Pierre-Louis Bossart (1):
      soundwire: intel: fix memory leak with devm_kasprintf

 drivers/soundwire/intel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
--=20
~Vinod

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl8D+cYACgkQfBQHDyUj
g0ezRhAAs0bVOhTTYkpgEGm3Jsm2jB/cFjF++LQ/X1uPKUifurcxoLNg5DJVXCF4
yjyysfzkmgGqiCRkohadr3V1tqaAhmi4K733QC7pm/+VqXKw5QawX9rOoZuqoqH0
HCMHsgAjgUe7Bg8E+dO8M3bEn+hxfpOs/+6gFycGSWwRKpmvUZUzl1RD5FUddW/M
/IzKTvxGd7F+sD8Mo50uEaxpc4+nz5LsaU1w94hZ0urD4GIuDzNcsGXSHEyWDSMa
KAyugvSlnZmRSbbZMwzMAyUvPizGOlaIXgZHbiJRUsvilpTXL6tz5UjnLrlzmlun
u3vytAEPiMD4s1qHMYHlkY7NmMsEYxZKO5Q4XD8Zk2cGnCTF7hnApjEAK/iqfscQ
i8YYK3t/eZYt9lrm8ix20Cpa1XYZePIE7q9cN1lfc7t8W4ZWuT3aBM9wG3B/nDyY
WD2oL3veOgRGMB/4nZF2S4Pg4P9t6IruEOA4Rv2jM/oImtRoulcGC0CHm04HnBz9
Hi1gdSzNx4t8d2/AOtbmQKFm0L1nxQoKMWEfKQ9QPUB+HvpVSe6DE9Z61OfJQf3v
onj4zMnhEWkxVuxoeeUC70ZnughBTUtGfLVCfiVNPAGw9JIcL26J3CrhD2eFvPCP
zgGmIuAReM4GiMaicveRjLcqo1tpUDjpdAJX+7TyxN9YaWKSmCY=
=pyH1
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
