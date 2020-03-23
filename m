Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27024C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF21320714
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KBvcX/j7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgCWUTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:19:14 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51073 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgCWUTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:19:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48mQhH3rGHz9sR4;
        Tue, 24 Mar 2020 07:19:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1584994752;
        bh=55SbTnHJWs3v4tN8TDPEr7gmdYr/dXGxIh5pGOfQbdc=;
        h=Date:From:To:Cc:Subject:From;
        b=KBvcX/j7uCeAkyOzvRBVbij/MGnnh7DUUPz4doLPykt7cH8P7l0jKxCXCer+lbdME
         T2HpV+MosuajcryL1/0DF1BU4tEk3pxTNbeVhxYm6UorfNHm1qBsP21l10lBp6dE+9
         eSkBqwSA8q9bYwvaO/SpF8a7cWkuktAxtwQHSR87SEMrtKlWaL6QNGuxNHmILuOl11
         09GJTLSrICpB8gsEYljrXQB5EXeXcOmQwfnJ88OHrmPOMvSe15KLcsb6iyeu+BJ+m0
         2MaFznPXPDQCoSnScEin8t7Bnl9kz/N/VSzD20ueUIPuq83el3t+eyRXag8GznkC8D
         rl1ZslwX2rfOg==
Date:   Tue, 24 Mar 2020 07:19:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the thermal tree
Message-ID: <20200324071907.500c6a7b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZQR9Pa+DwleBlAdxx9NXJOF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZQR9Pa+DwleBlAdxx9NXJOF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  ba53cb499706 ("thermal: imx8mm: Add i.MX8MP support")
  06ccf2eecd67 ("dt-bindings: thermal: imx8mm-thermal: Add support for i.MX=
8MP")
  5c7bc817d814 ("thermal: qcom: tsens.h: Replace zero-length array with fle=
xible-array member")
  7796140751cb ("thermal: imx_sc_thermal: Fix incorrect data type")
  eed84a45ca84 ("thermal: int340x_thermal: Use scnprintf() for avoiding pot=
ential buffer overflow")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZQR9Pa+DwleBlAdxx9NXJOF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl55GbsACgkQAVBC80lX
0Gx8AQf+JhhKtF/DUIXyHEvCDGj4OVGjZP3VF3jebtt326VT+4Hu9GrXgBcRrOlO
H2ht1cdHwUrOrYR4iU5ngR6gx/JcHVkSESW0vP5d6ZP4KOqgCkcjM8wzdv7kiQQW
ZDh/FLcxmPRGVTSbARI7HlfHpnVv93vgXhGZAifzAsMfYEP8HWCCxo4ivqZZxZdJ
YOCh8pRYlFYUbXV21qIoKcdSQtL4sq00FlOT5309lha6JTlM0hl5nyFPIbu/ZeLk
mXfQGTS975f3ec+7WAglp2p2344bxCCeXlhFLBf9nQfrJp2NL1Yh8kJq1/FfKt9H
GmuklkuNdbEzl33XXvYBFlxjZmFkmw==
=f3ZL
-----END PGP SIGNATURE-----

--Sig_/ZQR9Pa+DwleBlAdxx9NXJOF--
