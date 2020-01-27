Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC549C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF36C214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580146744;
	bh=X2ky7cOsapvH1/92VL5lYZkVJodVwwkKuFQoYOU9HM4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=kPB2ySh5sMX7LcqiBEgBT4BI4tg/4a0H15nUD/GlpwBM8gO4l4Ca+60Odk0qj5OFk
	 j/jmUnmUh3ERAS63vLDnfoQI7pHxWSMG17pPmI+ClkpRDyrGEKCNXim6FJEhffoRg2
	 N2YtVznY2y6t65+ojhzbpdb0lPDTQF39PpZiLaXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgA0RjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:39:03 -0500
Received: from foss.arm.com ([217.140.110.172]:47532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgA0RjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:39:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB0BD31B;
        Mon, 27 Jan 2020 09:39:01 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 372C33F67D;
        Mon, 27 Jan 2020 09:39:01 -0800 (PST)
Date:   Mon, 27 Jan 2020 17:38:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: [GIT PULL] regulator updates for v5.6
Message-ID: <20200127173859.GD3763@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit def9d2780727cec3313ed3522d0123158d87224d:

  Linux 5.5-rc7 (2020-01-19 16:02:49 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.6

for you to fetch changes up to e4e4c2ff78edd2f9c7d2d3e588ca68ffa1dd8dc8:

  Merge branch 'regulator-5.6' into regulator-next (2020-01-27 17:24:38 +0000)

----------------------------------------------------------------
regulator: Updates for v5.6

Hardly anything going on in the core this time around with the regulator
API and pretty quiet on the driver front:

 - An API for comparing regulators, useful for devices that need to
   check if supply voltages exactly match rather than just nominally
   match.
 - Conversion of several DT bindings to YAML format.
 - Conversion of I2C drivers to probe_new().
 - New drivers for Monolithic MPQ7920 and MP8859, and Rohm BD71828.

----------------------------------------------------------------
Axel Lin (7):
      regulator: Convert i2c drivers to use .probe_new
      regulator: bd718x7: Simplify the code by removing struct bd718xx_pmic_inits
      regulator: vqmmc-ipq4019: Remove ipq4019_regulator_remove
      regulator: vqmmc-ipq4019: Trivial clean up
      regulator: mpq7920: Remove unneeded fields from struct mpq7920_regulator_info
      regulator: mpq7920: Convert to use .probe_new
      regulator: mpq7920: Fix incorrect defines

Benjamin Gaignard (2):
      dt-bindings: regulator: Convert stm32 booster bindings to json-schema
      dt-bindings: regulator: Convert stm32 vrefbuf bindings to json-schema

Dan Carpenter (2):
      regulator: mp8859: tidy up white space in probe
      regulator: mpq7920: Check the correct variable in mpq7920_regulator_register()

Enric Balletbo i Serra (2):
      regulator: vctrl-regulator: Avoid deadlock getting and setting the voltage
      regulator: core: Fix exported symbols to the exported GPL version

Krzysztof Kozlowski (1):
      regulator: samsung: Rename Samsung to lowercase

Marek Vasut (1):
      regulator: core: Add regulator_is_equal() helper

Mark Brown (6):
      dt-bindings: Drop entry for Monolithic Power System, MPS
      regulator: bindings: Drop document bindings for mpq7920
      Merge branch 'regulator-5.5' into regulator-linus
      Merge branch 'regulator-5.6' into regulator-next
      Merge remote-tracking branch 'regulator/topic/equal' into regulator-next
      Merge branch 'regulator-5.6' into regulator-next

Markus Reichl (3):
      regulator: mp8859: add driver
      regulator: bindings: add MPS mp8859 voltage regulator
      regulator: mp8859: add config option and build entry

Matti Vaittinen (3):
      dt-bindings: regulator: Document ROHM BD71282 regulator bindings
      regulator: bd71828: Basic support for ROHM bd71828 PMIC regulators
      regulator: bd71828: remove get_voltage operation

Miquel Raynal (1):
      regulator: rk808: Lower log level on optional GPIOs being not available

Pascal Paillet (1):
      regulator: Convert stm32-pwr regulator to json-schema

Robert Marko (1):
      regulator: add IPQ4019 SDHCI VQMMC LDO driver

Saravanan Sekar (6):
      dt-bindings: Add an entry for Monolithic Power System, MPS
      regulator: bindings: add document bindings for mpq7920
      MAINTAINERS: Add entry for mpq7920 PMIC driver
      regulator: mpq7920: add mpq7920 regulator driver
      regulator: mpq7920: Fix Woverflow warning on conversion
      dt-bindings: regulator: add document bindings for mpq7920

Stephen Rothwell (1):
      regulator fix for "regulator: core: Add regulator_is_equal() helper"

YueHaibing (1):
      regulator: vqmmc-ipq4019: Fix platform_no_drv_owner.cocci warnings

 .../devicetree/bindings/regulator/mp8859.txt       |  22 +
 .../devicetree/bindings/regulator/mps,mpq7920.yaml | 121 +++
 .../bindings/regulator/rohm,bd71828-regulator.yaml | 107 +++
 .../bindings/regulator/st,stm32-booster.txt        |  18 -
 .../bindings/regulator/st,stm32-booster.yaml       |  46 ++
 .../bindings/regulator/st,stm32-vrefbuf.txt        |  20 -
 .../bindings/regulator/st,stm32-vrefbuf.yaml       |  52 ++
 .../bindings/regulator/st,stm32mp1-pwr-reg.txt     |  43 --
 .../bindings/regulator/st,stm32mp1-pwr-reg.yaml    |  64 ++
 MAINTAINERS                                        |   7 +
 drivers/regulator/Kconfig                          |  40 +
 drivers/regulator/Makefile                         |   4 +
 drivers/regulator/bd71828-regulator.c              | 807 +++++++++++++++++++++
 drivers/regulator/bd718x7-regulator.c              |  34 +-
 drivers/regulator/core.c                           |   2 +
 drivers/regulator/da9210-regulator.c               |   5 +-
 drivers/regulator/da9211-regulator.c               |   5 +-
 drivers/regulator/helpers.c                        |  14 +
 drivers/regulator/isl9305.c                        |   5 +-
 drivers/regulator/lp3971.c                         |   5 +-
 drivers/regulator/ltc3676.c                        |   5 +-
 drivers/regulator/mp8859.c                         | 156 ++++
 drivers/regulator/mpq7920.c                        | 330 +++++++++
 drivers/regulator/mpq7920.h                        |  69 ++
 drivers/regulator/mt6311-regulator.c               |   5 +-
 drivers/regulator/pv88060-regulator.c              |   5 +-
 drivers/regulator/pv88090-regulator.c              |   5 +-
 drivers/regulator/rk808-regulator.c                |   2 +-
 drivers/regulator/s2mpa01.c                        |   2 +-
 drivers/regulator/s2mps11.c                        |   2 +-
 drivers/regulator/s5m8767.c                        |   2 +-
 drivers/regulator/slg51000-regulator.c             |   5 +-
 drivers/regulator/sy8106a-regulator.c              |   5 +-
 drivers/regulator/sy8824x.c                        |   5 +-
 drivers/regulator/tps65132-regulator.c             |   5 +-
 drivers/regulator/vctrl-regulator.c                |  38 +-
 drivers/regulator/vqmmc-ipq4019-regulator.c        | 101 +++
 include/linux/regulator/consumer.h                 |   7 +
 38 files changed, 2014 insertions(+), 156 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mp8859.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71828-regulator.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/st,stm32-booster.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32-booster.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
 create mode 100644 drivers/regulator/bd71828-regulator.c
 create mode 100644 drivers/regulator/mp8859.c
 create mode 100644 drivers/regulator/mpq7920.c
 create mode 100644 drivers/regulator/mpq7920.h
 create mode 100644 drivers/regulator/vqmmc-ipq4019-regulator.c

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4vIDIACgkQJNaLcl1U
h9AA8wf/enoqI5R4N8FKl9yWp+pc+H0fn0bzznen/t+V+wptw7L475esX/9rj+h1
YdPuakyHsl6ofqq4C6MLlAB1DloK4hV/cwB29CEq6/S6NHET3ET+G9FoJoyJr+JN
OaoQFqajGBZ2IAumtjHl/KVCi1CWsJBGYtPhB0xUf4N2cG85MpKRWxv5oIGCoujb
gpByie6sGfGE0Oqxs0KMOkQHHWfxEom0237jsH7+nvL/WL5WNjdMtCRynxFargPL
ZZRx8hPNM+m1QwH2/xrmH0IMV8jydr5GGzAfHOSSxPZbo+3vBGf3iRFUOTxn5b2p
lvmGFXAUYegk4m80reZmqC/XxObG8w==
=ky9L
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--
