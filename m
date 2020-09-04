Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF102C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6414206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599214727;
	bh=gwPeA8gCxEsz87NfPWJo0G43154gGpjhQSmwjGM+pgc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Kct+GYnqOeu2iG1MB36A+edzNVgOPuZPI4Is5Wbzc1VfUo6AOQdZuFckiAX89BXIY
	 5dmHMLHYHIcAzF9kiQCKrvuztCJgRSVThtQe9VVkiV6W13hhH/5ff6WNNUK4Ej7g3B
	 KFxnWrEvYMlw0LDdtWazQUehldpVWvn3D3aCIZPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbgIDKSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729946AbgIDKR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:17:56 -0400
Received: from localhost (unknown [122.182.253.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 786A5206D4;
        Fri,  4 Sep 2020 10:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599214675;
        bh=gwPeA8gCxEsz87NfPWJo0G43154gGpjhQSmwjGM+pgc=;
        h=Date:From:To:Cc:Subject:From;
        b=IUzxSNqlq37uQc5NlyOtiiZIGwXUfRrQfc+Poat5HVl7Y8ZF1G8R7502z9Gd9oAPD
         X2mbWNuRbigNtyJAHX9T3muKMJ6OErhoiFZ9OnY4GZWeZY0yuIUdz9ryC4BLpwlAlp
         kXOmGcYcs97Kb0vQI10FMtmHazvxd5X5XJFdXmN0=
Date:   Fri, 4 Sep 2020 15:47:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: PHY fixes for v5.9
Message-ID: <20200904101750.GA2639@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Please pull to receive the fixes for PHY subsystem. Cooupld of fixes on
QCOM driver and one on TI driver

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
fixes-5.9

for you to fetch changes up to ad7a7acaedcf45071c822b6c983f9c1e084041c9:

  phy: omap-usb2-phy: disable PHY charger detect (2020-08-31 14:30:59 +0530)

----------------------------------------------------------------
phy: fixes for 5.9

*) platform_no_drv_owner.cocci and return value check qcom ipq806x-usb driv=
er
*) correcting register programming for ipq8074 phy
*) disable PHY charger detect for omap-usb2-phy

----------------------------------------------------------------
Roger Quadros (1):
      phy: omap-usb2-phy: disable PHY charger detect

Sivaprakash Murugesan (1):
      phy: qcom-qmp: Use correct values for ipq8074 PCIe Gen2 PHY init

Wei Yongjun (1):
      phy: qualcomm: fix return value check in qcom_ipq806x_usb_phy_probe()

YueHaibing (1):
      phy: qualcomm: fix platform_no_drv_owner.cocci warnings

 drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c |  5 ++-
 drivers/phy/qualcomm/phy-qcom-qmp.c         | 16 +++++-----
 drivers/phy/qualcomm/phy-qcom-qmp.h         |  2 ++
 drivers/phy/ti/phy-omap-usb2.c              | 47 ++++++++++++++++++++++++-=
----
 4 files changed, 53 insertions(+), 17 deletions(-)

Thanks
--=20
~Vinod

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl9SFE4ACgkQfBQHDyUj
g0dpAxAAxczx98p154uPgFwvI3Us/lMZcwMp2E5jKSVZrevCD7oCACr+8Tkl1FQh
2MeTWLUbmP1Y40GjBgQdgPRxMVjbIcQpZVWe4CpG79TzwhC03FRSGuGeazlhfjCC
/SrZaBRqCKUA+4B99f9E+S3Z/ES5UlAjSo7nUqHK+aCzmBVYjTtkCeTaqJM1ZoCJ
6pXFg3OmHcUaFqlM0ki0oBrluuIfgtJLlYlaF43qm6saXLosfRfRgzOtv9dYMTKW
F/PU5Rdxe1Vyy45zrEU2wK/dJseNx+b6A/SraoeSzB9ZnctYcJyz2ajYOoW6CupV
sycA+YFEBN4oFyBI8OZiLxawZojYzwsg3ZbCoY4g3sabQ5z2PhpUz5LmzovpTLH0
E8PpJpVGYDMp/9xf9uflI9sM3tJWgq6FwnYZr7XBuIZ80dRK7ZzRT5DrfUfLKhUz
kE5YMCOWyumval+fmk2eof3QcXIcBq6ene7Vy1nDc8lWle2YPdGEEplIYGclUv6N
NzMXnfFNd3Li99++IoqOhpwonjyxi7t4gcfwO1j7q1dSpVbo4CSWaaGQqRVwwmNZ
xF6fnIbgZSe4cySqT/UDhSWFwITf5x8DwQY8HhF8e2F9d/JEybZRE9Rzsp+y26vE
+Mj3xHK/pfk+/XDo0sLSEjsIl/lkZevrmluY2LOobO7znN2ajZg=
=vZSo
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--
