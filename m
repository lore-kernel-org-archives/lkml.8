Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09C7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74EDF2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591014130;
	bh=AmJmZuyJqZWEpSnyuVs5VDQrpV3xeyVuXD1zvx8vlJY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=t6B98r50xLZXFb/2EzipQniFOHH5uIcODpj38hi+LRz/3iYxWUMeWZdpUxLmnYXmA
	 1w2Gl+fyGEUEdmSmPgcc2MMBTUzFVB1Xl+Y4RdVy/He993CJlBjtcm02ROpvNZDf/N
	 LK5DJUfjl4nLravwSNl8LLQfHdEx1BsGLVq0zbs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgFAMWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:22:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbgFAMWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:22:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 343C42077D;
        Mon,  1 Jun 2020 12:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591014118;
        bh=AmJmZuyJqZWEpSnyuVs5VDQrpV3xeyVuXD1zvx8vlJY=;
        h=Date:From:To:Cc:Subject:From;
        b=ikGKKCqloSXTtu7BxQzRknZCMsqbfLA+m7GiluouzDdn+sHwTxrgv6SLI3fVZHSUh
         +wxKEfWlKYKxVx7zndrkDweUP9swdsjwuUW25E6hlX8GTql1iXD5hFmhqeoDTisV92
         wOM7BHUE/djTFrkuSxxAJkLo+Cis84aVE0YgilV0=
Date:   Mon, 1 Jun 2020 13:21:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: [GIT PULL] regulator updates for v5.8
Message-ID: <20200601122156.GC45647@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Content-Disposition: inline
X-Cookie: Help a swallow land at Capistrano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rQ2U398070+RC21q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a145:

  Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tag=
s/regulator-v5.8

for you to fetch changes up to 5fb565b69dabd5a256fc116702331b54a4621dc9:

  Merge remote-tracking branch 'regulator/for-5.8' into regulator-linus (20=
20-06-01 13:01:44 +0100)

----------------------------------------------------------------
regulator: Updates for v5.8

The big change in this release is that Matti Vaittinen has factored out
the linear ranges support into a separate library in lib/ since it is
also useful for at least the power subsystem (and most likely others
too), it helps subsystems which need to map register values into more
useful real world values do so with minimal per-driver code.

 - Factoring out of the linear ranges support into a library in lib/
   from Matti Vaittinen.
 - Trace points for bypass mode.
 - Use the consumer name in debugfs to make it easier to understand.
 - New drivers for Maxim MAX77826 and MAX8998.

----------------------------------------------------------------
Anson Huang (1):
      dt-bindings: regulator: Convert anatop regulator to json-schema

Bjorn Andersson (1):
      regulator: qcom-rpmh: Fix typos in pm8150 and pm8150l

Charles Keepax (1):
      regulator: core: Add regulator bypass trace points

Colin Ian King (1):
      regulator: tps80031: remove redundant assignment to variables ret and=
 val

Iskren Chernev (3):
      regulator: max77826: Add max77826 regulator driver
      regulator: Document bindings for max77826
      regulator: max77826: Remove erroneous additionalProperties

Jason Yan (3):
      regulator: qcom_rpm: remove defined but not used 'pm8921_ftsmps'
      regulator: ab8500: remove some defined but not used variables
      regulator: db8500-prcmu: Use true,false for bool variable

Jonathan Bakker (2):
      regulator: max8998: Add charger regulator
      regulator/mfd: max8998: Document charger regulator

Marek Szyprowski (1):
      regulator: extract voltage balancing code to the separate function

Mark Brown (6):
      Merge tag 'linear-ranges-lib' of https://git.kernel.org/.../broonie/r=
egulator into regulator-5.8
      Merge branch 'topic/linear-range' of https://git.kernel.org/.../broon=
ie/regulator into regulator-5.8
      Merge series "MAINTAINER entries for few ROHM power devices" from Mat=
ti Vaittinen <matti.vaittinen@fi.rohmeurope.com>:
      Merge series "Fix regulators coupling for Exynos5800" from Marek Szyp=
rowski <m.szyprowski@samsung.com>:
      Merge remote-tracking branch 'regulator/for-5.7' into regulator-linus
      Merge remote-tracking branch 'regulator/for-5.8' into regulator-linus

Matti Vaittinen (8):
      regulator: bd718x7: remove voltage change restriction from BD71847
      lib: add linear ranges helpers
      lib/test_linear_ranges: add a test for the 'linear_ranges'
      power: supply: bd70528: rename linear_range to avoid collision
      regulator: use linear_ranges helper
      lib: linear_ranges: Add missing MODULE_LICENSE()
      regulator: bd718x7: remove voltage change restriction from BD71847 LD=
Os
      MAINTAINERS: Add maintainer entry for linear ranges helper

Micha=C5=82 Miros=C5=82aw (1):
      regulator: use consumer->supply_name in debugfs/regulator_summary

kbuild test robot (1):
      regulator: max8998: max8998_set_current_limit() can be static

 Documentation/devicetree/bindings/mfd/max8998.txt  |   8 +
 .../bindings/regulator/anatop-regulator.txt        |  40 ---
 .../bindings/regulator/anatop-regulator.yaml       |  94 +++++++
 .../bindings/regulator/maxim,max77826.yaml         |  68 +++++
 MAINTAINERS                                        |   7 +
 drivers/power/supply/bd70528-charger.c             |  10 +-
 drivers/regulator/88pg86x.c                        |   4 +-
 drivers/regulator/88pm800-regulator.c              |   4 +-
 drivers/regulator/Kconfig                          |  11 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/ab8500.c                         |  22 --
 drivers/regulator/act8865-regulator.c              |   4 +-
 drivers/regulator/act8945a-regulator.c             |   2 +-
 drivers/regulator/arizona-ldo1.c                   |   2 +-
 drivers/regulator/arizona-micsupp.c                |   4 +-
 drivers/regulator/as3711-regulator.c               |   6 +-
 drivers/regulator/as3722-regulator.c               |   4 +-
 drivers/regulator/axp20x-regulator.c               |  16 +-
 drivers/regulator/bcm590xx-regulator.c             |   8 +-
 drivers/regulator/bd70528-regulator.c              |   8 +-
 drivers/regulator/bd71828-regulator.c              |  10 +-
 drivers/regulator/bd718x7-regulator.c              | 238 ++++++++++++++--
 drivers/regulator/core.c                           |  59 ++--
 drivers/regulator/da903x.c                         |   2 +-
 drivers/regulator/db8500-prcmu.c                   |   2 +-
 drivers/regulator/helpers.c                        | 130 ++++-----
 drivers/regulator/hi6421-regulator.c               |   4 +-
 drivers/regulator/lochnagar-regulator.c            |   4 +-
 drivers/regulator/lp873x-regulator.c               |   4 +-
 drivers/regulator/lp87565-regulator.c              |   2 +-
 drivers/regulator/lp8788-buck.c                    |   2 +-
 drivers/regulator/max77650-regulator.c             |   2 +-
 drivers/regulator/max77826-regulator.c             | 301 +++++++++++++++++=
++++
 drivers/regulator/max8998.c                        | 105 +++++++
 drivers/regulator/mcp16502.c                       |   4 +-
 drivers/regulator/mp8859.c                         |   2 +-
 drivers/regulator/mt6323-regulator.c               |   6 +-
 drivers/regulator/mt6358-regulator.c               |   8 +-
 drivers/regulator/mt6380-regulator.c               |   6 +-
 drivers/regulator/mt6397-regulator.c               |   6 +-
 drivers/regulator/palmas-regulator.c               |   4 +-
 drivers/regulator/qcom-rpmh-regulator.c            |  10 +-
 drivers/regulator/qcom_rpm-regulator.c             |  24 +-
 drivers/regulator/qcom_smd-regulator.c             |  78 +++---
 drivers/regulator/rk808-regulator.c                |  10 +-
 drivers/regulator/s2mps11.c                        |  14 +-
 drivers/regulator/sky81452-regulator.c             |   2 +-
 drivers/regulator/stpmic1_regulator.c              |  18 +-
 drivers/regulator/tps65086-regulator.c             |  10 +-
 drivers/regulator/tps65217-regulator.c             |   4 +-
 drivers/regulator/tps65218-regulator.c             |   6 +-
 drivers/regulator/tps65912-regulator.c             |   4 +-
 drivers/regulator/tps80031-regulator.c             |   7 +-
 drivers/regulator/twl-regulator.c                  |   4 +-
 drivers/regulator/twl6030-regulator.c              |   2 +-
 drivers/regulator/wm831x-dcdc.c                    |   2 +-
 drivers/regulator/wm831x-ldo.c                     |   4 +-
 drivers/regulator/wm8350-regulator.c               |   2 +-
 drivers/regulator/wm8400-regulator.c               |   2 +-
 include/linux/linear_range.h                       |  48 ++++
 include/linux/mfd/max8998.h                        |   1 +
 include/linux/regulator/coupler.h                  |   8 +
 include/linux/regulator/driver.h                   |  27 +-
 include/trace/events/regulator.h                   |  32 +++
 lib/Kconfig                                        |   3 +
 lib/Kconfig.debug                                  |  12 +
 lib/Makefile                                       |   2 +
 lib/linear_ranges.c                                | 245 +++++++++++++++++
 lib/test_linear_ranges.c                           | 228 ++++++++++++++++
 69 files changed, 1652 insertions(+), 381 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/anatop-regu=
lator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/anatop-regu=
lator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77=
826.yaml
 create mode 100644 drivers/regulator/max77826-regulator.c
 create mode 100644 include/linux/linear_range.h
 create mode 100644 lib/linear_ranges.c
 create mode 100644 lib/test_linear_ranges.c

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7U8uMACgkQJNaLcl1U
h9DEbwf/aREJHdFHefjH0zN+RGTk6IK7BNK0iuolsP0u2eOJS92hz5bT27JTDCf3
JahnQj1V5DnPqg8ahm9+7bmTgsmg6v8R2JvgZt09cYQLmMbUT7yTBsXs2anNzRA5
ZkdJdSSEta1FSXmrO7awKYQCP9eXuYDvbgQC9ples1qroB2nhy2W+wF0M2+qBd33
E91TdjaNO1sRec8kGE7HvdtsqRauUhGgd0+v5xpOCxd5LpbasH0H0UmQ1xT7Ocnr
iJ1pWKEnqITaatwQqLhTFB1TcBxQlVhS34+jKNpkdpGTs5LroJ6B5sHuH+7ULcWq
yM4pv6+Dqd4RS6w8XJV3cddkNyjm3w==
=H+eH
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
