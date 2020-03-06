Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91985C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A78E20656
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583516465;
	bh=Ji3HeCBf5PV/zS/+mfoKR78uIdgM+KemFNGJRINU4DI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=otjMQmmfcN5xeYNozHyUhyS4BLW/jFLkokl0JNwczGYGZNytnkBKuBC5HBVPEU575
	 lDr7/b2t2q2KMvJmPYCbiOQmynst7FMjIpY5y+6QPNlooXN0zki+0jWIBluaq3myNS
	 5kOZycQoeYYddiKZ7L+w7ijLjpCiOn0pSYV0nfdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCFRlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:41:04 -0500
Received: from foss.arm.com ([217.140.110.172]:36864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgCFRlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:41:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25CE030E;
        Fri,  6 Mar 2020 09:41:03 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DA743F6C4;
        Fri,  6 Mar 2020 09:41:02 -0800 (PST)
Date:   Fri, 6 Mar 2020 17:41:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] spi fixes for v5.6
Message-ID: <20200306174101.GE4114@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Content-Disposition: inline
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit a5362b84bdff1def10c136e36ef2126f7f545b2c:

  dt-binding: spi: add NPCM PSPI reset binding (2020-01-23 12:13:55 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.6-rc4

for you to fetch changes up to f9981d4f50b475d7dbb70f3022b87a3c8bba9fd6:

  spi: spi_register_controller(): free bus id on error paths (2020-03-04 14:28:57 +0000)

----------------------------------------------------------------
spi: Fixes for v5.6

A selection of small fixes, mostly for drivers, that have arrived since
the merge window.  None of them are earth shattering in themselves but
all useful for affected systems.

----------------------------------------------------------------
Aaro Koskinen (1):
      spi: spi_register_controller(): free bus id on error paths

Christophe JAILLET (1):
      spi: bcm63xx-hsspi: Really keep pll clk enabled

Evan Green (1):
      spi: pxa2xx: Add CS control clock quirk

Lukas Wunner (1):
      spi: spidev: Fix CS polarity if GPIO descriptors are used

Thommy Jakobsson (1):
      spi/zynqmp: remove entry that causes a cs glitch

Tudor Ambarus (1):
      spi: atmel-quadspi: fix possible MMIO window size overrun

Vignesh Raghavendra (2):
      spi: spi-omap2-mcspi: Handle DMA size restriction on AM65x
      spi: spi-omap2-mcspi: Support probe deferral for DMA channels

Yuji Sasaki (1):
      spi: qup: call spi_qup_pm_resume_runtime before suspending

 drivers/spi/atmel-quadspi.c                   |  11 +++
 drivers/spi/spi-bcm63xx-hsspi.c               |   1 -
 drivers/spi/spi-omap2-mcspi.c                 | 103 ++++++++++++++++----------
 drivers/spi/spi-pxa2xx.c                      |  23 ++++++
 drivers/spi/spi-qup.c                         |  11 ++-
 drivers/spi/spi-zynqmp-gqspi.c                |   3 -
 drivers/spi/spi.c                             |  32 ++++----
 drivers/spi/spidev.c                          |   5 ++
 include/linux/platform_data/spi-omap2-mcspi.h |   1 +
 9 files changed, 126 insertions(+), 64 deletions(-)

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5iiywACgkQJNaLcl1U
h9CpnAf+INrrd3GWVT9hlZKOaED3YbPtubGP32W7y8i8BqGwMbde4nDiQq8C+2py
jwDOJEJqOgRUpVP44uXZ4hGymU/raOocRSBgwgdJ3an3NS3schvl/X9vbljdBrms
0ICwftHxZenEFaPzNKcR+SwhmYhlPDrwXqlVinRWUUI4OtGOa1OCOdIFl0qebt6c
JhESa50FTHw6EvQvdJG1uDCPygRJL7v2ZUWXVgWmJg1spLiA8KQfa58lUq20oy9k
5ggl6Mk4mWYkC+3XbyRT9Z48UR78/mkOkbjlvPIqy+khzbYOoXOeBBKWuZrKK7bi
6x8va41i7BjIrZUqZ1LHyhdN6u8U/Q==
=PDco
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--
