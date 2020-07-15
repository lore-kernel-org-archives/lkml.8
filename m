Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B57C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A5F2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594805783;
	bh=KvERwz6a46BBHzE6XXdChhsa8mTA1HYiIRsamLDzAAk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ZxedoH1HbluZr80ubfBAnYIP8NU5lWFjABzYKbDAVf/tbz6B4tMxNUuxDTBfXXeUC
	 VUiqbDyMFkX9Abqp2u0nIWHJsfoo5eTKkGGxZhumf5VOZCQye7bb2UI/B46q7pJF2E
	 APLwEA2IAFcTb23SJNWd2EV/JtRArEUq9heDVwoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbgGOJgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:36:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730288AbgGOJgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:36:22 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3A5C2064B;
        Wed, 15 Jul 2020 09:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594805781;
        bh=KvERwz6a46BBHzE6XXdChhsa8mTA1HYiIRsamLDzAAk=;
        h=Date:From:To:Cc:Subject:From;
        b=cwOG7ONgUQATsH0ycjjCKSrtHYV3VXdEM2cynR4bGOZa8BCiEhjKyOOrHm16HYgVY
         otwZoFZJNRtQDR25TUIM12C7x61DjAcXhnGTUhVbfWqiHKEzWDFrkcgXluTSz4Zm+y
         ObSdpCvHZSO5nJIs9kRXmZru3HVKMywxudVviKtU=
Date:   Wed, 15 Jul 2020 15:06:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] dmaengine: fixes for v5.8-rc6
Message-ID: <20200715093617.GF34333@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here is the dmaengine pull request for v5.8. Please note dmaengine tree
has moved to kernel.org so you would need to pull from that now on.

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-5.8-rc6

for you to fetch changes up to 87730ccbddcb48478b1b88e88b14e73424130764:

  dmaengine: ioat setting ioat timeout as module parameter (2020-07-06 14:4=
9:34 +0530)

----------------------------------------------------------------
dmaengine fixes for v5.5-rc6

 - Update dmaengine tree location to k.org
 - dmatest fix for completing threads
 - Driver fixes for:
   - k3dma
   - fsl-dma
   - idxd
   - tegra
   - and few other in bunch of other drivers

----------------------------------------------------------------
Andy Shevchenko (1):
      dmaengine: dw: Initialize channel before each transfer

Angelo Dureghello (1):
      dmaengine: fsl-edma: fix wrong tcd endianness for big-endian cpu

Dave Jiang (3):
      dmaengine: idxd: fix hw descriptor fields for delta record
      dmaengine: idxd: cleanup workqueue config after disabling
      dmaengine: idxd: fix misc interrupt handler thread unmasking

Dinghao Liu (1):
      dmaengine: tegra210-adma: Fix runtime PM imbalance on error

Fabio Estevam (1):
      dmaengine: imx-sdma: Fix: Remove 'always true' comparison

Krzysztof Kozlowski (3):
      dmaengine: fsl-edma: Add lockdep assert for exported function
      dmaengine: fsl-edma: Fix NULL pointer exception in fsl_edma_tx_handler
      dmaengine: mcf-edma: Fix NULL pointer exception in mcf_edma_tx_handler

Leonid Ravich (1):
      dmaengine: ioat setting ioat timeout as module parameter

Nikhil Rao (1):
      dmaengine: idxd: fix cdev locking for open and release

Peter Ujfalusi (5):
      dmaengine: ti: k3-udma: Use correct node to read "ti,udma-atype"
      dmaengine: ti: k3-udma: Fix cleanup code for alloc_chan_resources
      dmaengine: ti: k3-udma: Fix the running channel handling in alloc_cha=
n_resources
      dmaengine: ti: k3-udma: Fix delayed_work usage for tx drain workaround
      dmaengine: dmatest: stop completed threads when running without set c=
hannel

Robin Gong (1):
      dmaengine: fsl-edma-common: correct DSIZE_32BYTE

Vinod Koul (1):
      MAINTAINERS: switch dmaengine tree to kernel.org

Yoshihiro Shimoda (1):
      dmaengine: sh: usb-dmac: set tx_result parameters

Yu Kuai (1):
      dmaengine: ti: k3-udma: add missing put_device() call in of_xudma_dev=
_get()

 MAINTAINERS                      |  2 +-
 drivers/dma/dmatest.c            |  2 ++
 drivers/dma/dw/core.c            | 12 ------------
 drivers/dma/fsl-edma-common.c    | 28 ++++++++++++++++------------
 drivers/dma/fsl-edma-common.h    |  2 +-
 drivers/dma/fsl-edma.c           |  7 +++++++
 drivers/dma/idxd/cdev.c          | 19 ++++++++++++++++---
 drivers/dma/idxd/device.c        | 25 +++++++++++++++++++++++++
 drivers/dma/idxd/idxd.h          |  1 +
 drivers/dma/idxd/irq.c           |  3 ++-
 drivers/dma/idxd/sysfs.c         |  5 +++++
 drivers/dma/imx-sdma.c           | 11 ++++-------
 drivers/dma/ioat/dma.c           | 12 ++++++++++++
 drivers/dma/ioat/dma.h           |  2 --
 drivers/dma/mcf-edma.c           |  7 +++++++
 drivers/dma/sh/usb-dmac.c        |  2 ++
 drivers/dma/tegra210-adma.c      |  5 ++++-
 drivers/dma/ti/k3-udma-private.c |  1 +
 drivers/dma/ti/k3-udma.c         | 39 +++++++++++++++++++-----------------=
---
 include/uapi/linux/idxd.h        |  3 +++
 20 files changed, 128 insertions(+), 60 deletions(-)

Thanks
--=20
~Vinod

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl8OzhEACgkQfBQHDyUj
g0cuyhAA0l/b0AeNH5mVbRQTysAB0mY6SInJBpMfwkAmr8gIETOm+p10KB2/iCVr
tj10KP/mfnh0Uz4H//utTlL+UZhSmpIMgAB0Cp6G1rtz5Qp1FoX24ccsofU1NJ74
iRG9+VA3lCufP0zq3u31eJ12j3yi0g7JiptBElsZhDUT1GNLVoniQbqKkeuvqb5G
3REAUV1zEu53YnMvdlbW1zrlRa+HF7/QE7Yu4i9MLI3cetGQAvIQXp+lwnboc+Nq
MhAYZQXi2U6zoFSrFVH+hGU0+H+SN9zktVI6atztaLj8lDZYW/tucbeIU9wNbNbs
3WE+TlGlV9SgZa4tSSowmOO1YGS8EmxwZmyYJQtIHdtQAG5o9T8hyfpTko0EEmCJ
5lvdujFw9VzMGjP6uQPHWsiG3YFr+Mz6wttJMDilUkXQaYjVbtzouOTCdh0vdVxd
Prj6AL7fulN7Rm0H9nsP/jULXpPwduv1OkCYO9/0PoelEAaePnl71q1dCl945doz
nqPvvhwVqgq3bAU2UvRckc9ST2qPCnmUI6roeOcX+lq6HY3Z7uzo5dlc3/eGkNPm
vdGkM5Jz0ootr38FLxVoaEIyAmXtN35f7V1MsQNhqtALA+a9p+s4KZFwEBnToK9a
LgN3hTu/ztEgQswN7RwcWWM5ljNoAhPZ9w1P3xdQaah6Zv1cBiA=
=uBEH
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
