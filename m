Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF78C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AAF4204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596458444;
	bh=8cTwBuKDDuPXiMiYysRN9Muj0ZY2IrvJy3ATZBTkxSM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=cLhFTpzBmvIx2sXgY+Q9xDXIgo9ZxxpqPNuMx0uS+SP7y+xzNNRUgJwiNtElu21eF
	 p7mqPryRSAVrYf9+bbo1p+xhJuJV4dMFhfckpUh5shiRqUdWR8+iRWjla9dYuKA3sD
	 k8CvplxRekC1b8PtncpzNxXuQnkdyzaOqJJOrdOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgHCMkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:40:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728718AbgHCMkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:40:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7F9320678;
        Mon,  3 Aug 2020 12:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596458411;
        bh=8cTwBuKDDuPXiMiYysRN9Muj0ZY2IrvJy3ATZBTkxSM=;
        h=From:To:Cc:Subject:Date:From;
        b=U/C4N9Rcjuo/ka+MVq+HVroS9MBoH3p7OiqIArL+f/T5aXfYHF+1M02ZEB4fZ6kcl
         h4nP/ZoPaczWO8q4p4Q43/d3pe89gZWELps52cqAgQ5Mpnu3XyM8bM2mMuM/7JIy23
         LRxt6ZKJunIE/Z+tD0lORSMsAmkiJ3FXXzuSRB3c=
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v5.9
Date:   Mon, 03 Aug 2020 13:39:15 +0100
Message-Id: <20200803124010.C7F9320678@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 92ed301919932f777713b9172e525674157e983d:

  Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.9

for you to fetch changes up to 3f02794888213efb224ef8e38d5d0e0f74b95416:

  Merge remote-tracking branch 'regulator/for-5.9' into regulator-next (2020-07-30 23:27:08 +0100)

----------------------------------------------------------------
regulator: Updates for v5.9

This time around the bulk of the work on the regulator API has been
cleanups of various kinds, partly but not entirely inspired by the W=1
stuff that 0day turned on.  There's also been a fairly large crop of new
drivers, and a few bugfixes for existing drivers.

 - Mode setting support for MT6397 and DA9211.
 - New drivers for ChromeOS embedded controllers, Fairchild FAN53880,
   NXP PCA9450, Qualcomm LABIBB, MP5496, and VBUS booster, and Silergy
   SY8827N

----------------------------------------------------------------
Alexander A. Klimov (1):
      regulator: Replace HTTP links with HTTPS ones

Anand K Mistry (6):
      regulator: mt6397: Move buck modes into header file
      regulator: mt6397: Implement of_map_mode
      regulator: mt6397: Document valid modes
      regulator: da9211: Move buck modes into header file
      regulator: da9211: Implement of_map_mode
      regulator: da9211: Document allowed modes

Axel Lin (2):
      regulator: fan53880: Add missing .owner field in regulator_desc
      regulator: pca9450: Convert to use module_i2c_driver

Chen-Yu Tsai (1):
      regulator: gpio: Honor regulator-boot-on property

Christoph Fritz (3):
      regulator: fan53880: Add initial support
      dt-bindings: regulator: Document bindings for fan53880
      regulator: fan53880: Add support for COMPILE_TEST

Colin Ian King (1):
      regulator: fix null pointer check on regmap

Colton Lewis (1):
      regulator: Correct kernel-doc inconsistency

Jisheng Zhang (3):
      regulator: add support for SY8827N regulator
      regulator: add document bindings for sy8827n
      regulator: mp886x: use .probe_new

Kathiravan T (4):
      regulator: qcom_smd: Add MP5496 regulators
      regulator: add MP5496 regulator compatible
      regulator: convert QCOM SMD-RPM regulator document to YAML schema
      regulator: add the sub node names for the MP5496 PMIC

Kieran Bingham (2):
      regulator: gpio: Fix trivial spelling
      regulator: Fix trivial spelling

Lee Jones (19):
      regulator: consumer: Supply missing prototypes for 3 core functions
      regulator: dbx500-prcmu: Remove unused function dbx500_regulator_testcase()
      regulator: ab8500: Remove unused embedded struct expand_register
      regulator: wm8350-regulator: Repair odd formatting in documentation
      regulator: cpcap-regulator: Remove declared and set, but never used variable 'ignore'
      regulator: cpcap-regulator: Demote kerneldoc header to standard comment
      regulator: max14577-regulator: Demote kerneldoc header to standard comment
      regulator: max8998: Staticify internal function max8998_get_current_limit()
      regulator: qcom-rpmh-regulator: Repair dodgy kerneldoc header formatting
      regulator: pwm-regulator: Demote kerneldoc header to standard comment
      regulator: stpmic1_regulator: Properly document 'struct stpmic1_regulator_cfg'
      regulator: tps65217-regulator: Remove pointless 'is unsigned int <0' check
      regulator: tps65217-regulator: Use the returned value of tps65217_reg_read()
      regulator: tps65218-regulator: Remove pointless 'is unsigned int <0' check
      regulator: wm8400-regulator: Repair dodgy kerneldoc header formatting
      regulator: qcom_smd-regulator: Remove unused 'struct regulator_desc pmi8994_boost'
      regulator: devres: Fix issues with kerneldoc headers
      regulator: of_regulator: Add missing colon for rdev kerneldoc argument
      regulator: devres: Standardise on function documentation headers

Luca Ceresoli (1):
      regulator: lp87565: enable voltage regardless of ENx pin

Mark Brown (11):
      Merge existing fixes from regulator/for-5.8
      Merge series "Add support for voltage regulator on ChromeOS EC." from Pi-Hsun Shih <pihsun@chromium.org>:
      Merge series "Add frequency / voltage scaling support for IPQ6018 SoC" from Kathiravan T <kathirav@codeaurora.org>:
      Merge series "regulator/qcom: Constify static structs" from Rikard Falkeborn <rikard.falkeborn@gmail.com>:
      Merge series "Introduce PMIC based USB type C detection" from Wesley Cheng <wcheng@codeaurora.org>:
      Merge series "regulator: add support for SY8827N regulator" from Jisheng Zhang <Jisheng.Zhang@synaptics.com>:
      Merge series "regulator: da9211: support changing modes" from Anand K Mistry <amistry@google.com>:
      Merge series "regulator: mt6397: Implement of_map_mode regulator_desc function" from Anand K Mistry <amistry@google.com>:
      Merge series "Add pca9450 driver" from Robin Gong <yibin.gong@nxp.com>:
      Merge series "regulator_sync_state() support" from Saravana Kannan <saravanak@google.com>:
      Merge remote-tracking branch 'regulator/for-5.9' into regulator-next

Nisha Kumari (2):
      regulator: qcom: Add labibb driver
      regulator: Add labibb regulator binding

Pi-Hsun Shih (5):
      dt-bindings: regulator: Add DT binding for cros-ec-regulator
      platform/chrome: cros_ec: Add command for regulator control.
      regulator: Add driver for cros-ec-regulator
      platform/chrome: cros_ec: Fix host command for regulator control.
      regulator: cros-ec-regulator: Fix double free of desc->name.

Rikard Falkeborn (8):
      regulator: anatop: Constify anatop_core_rops
      regulator: cpcap: Constify cpcap_regulator_ops
      regulator: ltc3676: Constify ltc3676_regulators
      regulator: max8907: Constify static structs
      regulator: max8997: Constify struct regulator_ops
      regulator: qcom_rpm: Constify struct regulator_ops
      regulator: qcom_spmi: Constify struct regulator_ops
      regulator: cros-ec: Constify cros_ec_regulator_voltage_ops

Robin Gong (3):
      regulator: pfuze100: add condition check for 'ramp_delay = 0'
      regulator: pca9450: add pca9450 pmic driver
      dt-bindings: regulator: add pca9450 regulator yaml

Saravana Kannan (1):
      regulator: core: Add destroy_regulator()

Sumit Semwal (1):
      regulator: Allow regulators to verify enabled during enable()

Vladimir Zapolskiy (1):
      regulator: fix memory leak on error path of regulator_register()

Wesley Cheng (2):
      regulator: Add support for QCOM PMIC VBUS booster
      regulator: Add dt-binding for QCOM PMIC VBUS output regulator

 .../devicetree/bindings/regulator/da9211.txt       |   4 +
 .../regulator/google,cros-ec-regulator.yaml        |  51 ++
 .../devicetree/bindings/regulator/lp872x.txt       |   4 +-
 .../bindings/regulator/mt6397-regulator.txt        |   3 +
 .../bindings/regulator/nxp,pca9450-regulator.yaml  | 190 +++++
 .../bindings/regulator/onnn,fan53880.yaml          |  85 +++
 .../bindings/regulator/qcom,smd-rpm-regulator.txt  | 320 --------
 .../bindings/regulator/qcom,smd-rpm-regulator.yaml | 108 +++
 .../regulator/qcom,usb-vbus-regulator.yaml         |  41 +
 .../bindings/regulator/qcom-labibb-regulator.yaml  |  70 ++
 .../bindings/regulator/silergy,sy8827n.yaml        |  45 ++
 drivers/platform/chrome/cros_ec_trace.c            |   5 +
 drivers/regulator/Kconfig                          |  55 ++
 drivers/regulator/Makefile                         |   6 +
 drivers/regulator/ab8500.c                         |   7 +-
 drivers/regulator/anatop-regulator.c               |   2 +-
 drivers/regulator/core.c                           | 115 ++-
 drivers/regulator/cpcap-regulator.c                |  18 +-
 drivers/regulator/cros-ec-regulator.c              | 252 +++++++
 drivers/regulator/da9211-regulator.c               |  30 +-
 drivers/regulator/dbx500-prcmu.c                   |   8 -
 drivers/regulator/devres.c                         |  54 +-
 drivers/regulator/fan53880.c                       | 184 +++++
 drivers/regulator/fixed.c                          |   2 +-
 drivers/regulator/gpio-regulator.c                 |   9 +-
 drivers/regulator/hi6421-regulator.c               |   2 +-
 drivers/regulator/hi6421v530-regulator.c           |   2 +-
 drivers/regulator/lp873x-regulator.c               |   2 +-
 drivers/regulator/lp87565-regulator.c              |  23 +-
 drivers/regulator/ltc3676.c                        |   2 +-
 drivers/regulator/max14577-regulator.c             |   2 +-
 drivers/regulator/max8907-regulator.c              |   6 +-
 drivers/regulator/max8997-regulator.c              |  14 +-
 drivers/regulator/max8998.c                        |   2 +-
 drivers/regulator/mp886x.c                         |   5 +-
 drivers/regulator/mt6397-regulator.c               |  17 +-
 drivers/regulator/of_regulator.c                   |   2 +-
 drivers/regulator/pbias-regulator.c                |   2 +-
 drivers/regulator/pca9450-regulator.c              | 833 +++++++++++++++++++++
 drivers/regulator/pfuze100-regulator.c             |   9 +-
 drivers/regulator/pwm-regulator.c                  |   2 +-
 drivers/regulator/qcom-labibb-regulator.c          | 175 +++++
 drivers/regulator/qcom-rpmh-regulator.c            |  14 +-
 drivers/regulator/qcom_rpm-regulator.c             |   6 +-
 drivers/regulator/qcom_smd-regulator.c             |  43 +-
 drivers/regulator/qcom_spmi-regulator.c            |  24 +-
 drivers/regulator/qcom_usb_vbus-regulator.c        |  97 +++
 drivers/regulator/stpmic1_regulator.c              |   2 +-
 drivers/regulator/sy8827n.c                        | 185 +++++
 drivers/regulator/tps65023-regulator.c             |   2 +-
 drivers/regulator/tps6507x-regulator.c             |   2 +-
 drivers/regulator/tps65086-regulator.c             |   2 +-
 drivers/regulator/tps65217-regulator.c             |   9 +-
 drivers/regulator/tps65218-regulator.c             |   6 +-
 drivers/regulator/tps65912-regulator.c             |   2 +-
 drivers/regulator/wm8350-regulator.c               |  10 +-
 drivers/regulator/wm8400-regulator.c               |   6 +-
 .../dt-bindings/regulator/dlg,da9211-regulator.h   |  16 +
 .../regulator/mediatek,mt6397-regulator.h          |  15 +
 include/linux/platform_data/cros_ec_commands.h     |  83 ++
 include/linux/regulator/consumer.h                 |  10 +
 include/linux/regulator/driver.h                   |   7 +-
 include/linux/regulator/machine.h                  |   1 +
 include/linux/regulator/pca9450.h                  | 219 ++++++
 64 files changed, 3042 insertions(+), 487 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/google,cros-ec-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/onnn,fan53880.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/silergy,sy8827n.yaml
 create mode 100644 drivers/regulator/cros-ec-regulator.c
 create mode 100644 drivers/regulator/fan53880.c
 create mode 100644 drivers/regulator/pca9450-regulator.c
 create mode 100644 drivers/regulator/qcom-labibb-regulator.c
 create mode 100644 drivers/regulator/qcom_usb_vbus-regulator.c
 create mode 100644 drivers/regulator/sy8827n.c
 create mode 100644 include/dt-bindings/regulator/dlg,da9211-regulator.h
 create mode 100644 include/dt-bindings/regulator/mediatek,mt6397-regulator.h
 create mode 100644 include/linux/regulator/pca9450.h
