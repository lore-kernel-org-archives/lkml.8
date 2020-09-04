Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE02C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 422C020791
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599215090;
	bh=6dlzHURxLhflehCVYVCij0VG/d/I/vDnqgeaf5qsTm0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=CtCxEBCr66j/6ilGCrMB8yxTtML4sYCVP9+tSf8vA9Z59eaMiybJDNi0o0BZ41HLM
	 R7QFMCh6l3RPBV+rRbkCrdl98mq+639xvzz4oXk/YSBIHfVYM/BH4MFb9mQ4pcKcBE
	 szOKnQe8cgSjZgW9TsRCshRW6A429UppyqxarxU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbgIDKYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:24:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730117AbgIDKYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:24:40 -0400
Received: from localhost (unknown [122.182.253.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A789D2084D;
        Fri,  4 Sep 2020 10:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599215079;
        bh=6dlzHURxLhflehCVYVCij0VG/d/I/vDnqgeaf5qsTm0=;
        h=Date:From:To:Cc:Subject:From;
        b=LA9e4XgIxR6Y69aFKuJrKoBxGu1Yl0FSRRcWvMdVfyfSOjphyP+egKM5GrxUiAOYT
         9S6lSZ9eRU+jD/8E14OREqUiLqTybpLbh0/vB8Rc2zvt7H90sFSG7EBxK3bZKGRPTX
         V2RMTZGpsewvU5hlSZ1ekorzsNrBpMpLcwOj2BRs=
Date:   Fri, 4 Sep 2020 15:54:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v5.9-rc4
Message-ID: <20200904102433.GB2639@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive couple of core fixes and odd driver fixes for
dmaengine subsystem.

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-5.9-rc4

for you to fetch changes up to 46815bf4d5a2e6ed64e4fa636c7d13f025bf40d8:

  dmaengine: ti: k3-udma: Update rchan_oes_offset for am654 SYSFW ABI 3.0 (=
2020-09-03 12:53:53 +0530)

----------------------------------------------------------------
dmaengine fixes for v5.9-rc4

Core:
 - drop ACPI CSRT table reference after using it
 - fix of_dma_router_xlate() error handling

Drivers: Off fixes in:
 - idxd
 - at_hdmac
 - pl330
 - dw-edma
 - jz478

----------------------------------------------------------------
Dave Jiang (1):
      dmaengine: idxd: reset states after device disable or reset

Gustavo Pimentel (1):
      dmaengine: dw-edma: Fix scatter-gather address calculation

Hanjun Guo (1):
      dmaengine: acpi: Put the CSRT table after using it

Madhuparna Bhowmik (1):
      drivers/dma/dma-jz4780: Fix race condition between probe and irq hand=
ler

Marek Szyprowski (1):
      dmaengine: pl330: Fix burst length if burst size is smaller than bus =
width

Peter Ujfalusi (3):
      dmaengine: of-dma: Fix of_dma_router_xlate's of_dma_xlate handling
      dmaengine: ti: k3-udma: Fix the TR initialization for prep_slave_sg
      dmaengine: ti: k3-udma: Update rchan_oes_offset for am654 SYSFW ABI 3=
=2E0

Yu Kuai (3):
      dmaengine: at_hdmac: check return value of of_find_device_by_node() i=
n at_dma_xlate()
      dmaengine: at_hdmac: add missing put_device() call in at_dma_xlate()
      dmaengine: at_hdmac: add missing kfree() call in at_dma_xlate()

 drivers/dma/acpi-dma.c             |  4 +++-
 drivers/dma/at_hdmac.c             | 11 +++++++++--
 drivers/dma/dma-jz4780.c           | 38 +++++++++++++++++++---------------=
----
 drivers/dma/dw-edma/dw-edma-core.c | 11 ++++++-----
 drivers/dma/idxd/device.c          | 26 ++++++++++++++++++++++++++
 drivers/dma/idxd/irq.c             | 12 ------------
 drivers/dma/of-dma.c               |  8 ++++----
 drivers/dma/pl330.c                |  2 +-
 drivers/dma/ti/k3-udma.c           | 10 +++++-----
 9 files changed, 73 insertions(+), 49 deletions(-)

Thanks
--=20
~Vinod

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl9SFeAACgkQfBQHDyUj
g0dY3Q/9GPq1DW+cxwVZrraw9M1MhyVMnPGzzwUXJduIskW2VedCLtei963TOW+l
OkvbV4B9E8s7CdwIDDpsgcDjpVrQbwybEIScmMxq/ojKpP/ruosd7v4oqUrSCxDv
Vmd3vYRNacC/9YlxQx1IT1nPIyjKnUn7jWR078E1HT8CegGb4AiRKXgVZZowGZ15
nnlN9mptZ9nYIj8pbAGbYY2Q61WmC0mSGLsNnyfYSP9dguiAKcCbQeLNWEoRZmGN
uc6FGLJJUX45ciOZoQu4u/6v9Gf8sye64QHsmbSxK8bBXAM2WBR9T/GWj5x+kPyy
Q8FPA0bm8AX5g8doSKhpRID9hSNqQuch8ltiDtB6+9+3aG1zc44LqSLD3ek8RyvD
kRGQu/w13Ux3bZVpb6E8Q1xiV7RGa0WFFLUcVYB4oYjdPwUohBRA6x2AaUSyEMBb
RWQ/l+q8DRIisnnZRc55P/SV9ZuXhypaa/lSnxy3R0VseyhX4BNys/PJa0u8aVcN
0+OsOGKOGHI2xDFy+a57fkjvBDChlK9BRuX3BD0Y7D30HjUyySChjkID1RpNoVmD
Tvyh4CKkD/bU2uoVZyd4Pysnovhzly5DEmRyadcKyd34rYHWcpFycF56UBgiciU2
bqGg9XSLEeqNLzMZd+vLBR5UNnsgEvC8/c0DrFS+63JnwZYq8iQ=
=yvrJ
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--
