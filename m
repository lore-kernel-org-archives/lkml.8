Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AB8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB01F20874
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbgFWCvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:51:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:32908 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731434AbgFWCvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:51:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1833EAE33;
        Tue, 23 Jun 2020 02:51:29 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?James=20Tai=20=5B=E6=88=B4=E5=BF=97=E5=B3=B0=5D?= 
        <james.tai@realtek.com>,
        =?UTF-8?q?Stanley=20Chang=20=5B=E6=98=8C=E8=82=B2=E5=BE=B7=5D?= 
        <stanley_chang@realtek.com>, Edgar Lee <cylee12@realtek.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        hp@ligomedia.com
Subject: [PATCH v2 00/29] ARM: Realtek DHC SoC info
Date:   Tue, 23 Jun 2020 04:50:37 +0200
Message-Id: <20200623025106.31273-1-afaerber@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds a soc bus driver for Realtek Digital Home Center SoC families.

v2 is rebased on syscon and RTD1319, adjusts field widths and incorporates
data additions from Stanley's monolithic patch.

The previous RFC's reg hack is superseded in v2 with a trivial read-only
eFuse driver, along with an extension of the nvmem consumer API.

Reminder: For RTD1293 I had to invent my own detection logic, possibly flawed.
Nor have the names of the magic register bits been disclosed.

We have no RTD1294 nor RTD1392 DT in mainline, so their detection is included
mainly as proof of concept. No EVB names were visible in public BSP sources;
Ligomedia seems the only vendor so far with publicly announced RTD1392 STBs,
for RTD1294 I only find one all-Chinese page and some Russian forum posts -
patches and testing welcome. Otherwise we can only test that the other models
are not misdetected as RTD1392 or RTD1294.

DHC upstreaming progress is being tracked at:
https://en.opensuse.org/HCL:Realtek_DHC

Latest experimental patches at:
https://github.com/afaerber/linux/commits/rtd1295-next

Have a lot of fun!

Cheers,
Andreas

v1 -> v2:
* Cleaned up binding schema (Rob)
* Rebased onto syscon mfd refactoring of containing SB2, Iso, etc.
* Limit chip id and rev to 16 bits, as per old header files
* Include mentioned RTD1395, RTD1619 and RTD1319 patches
* Incorporate RTD1392 and RTD1319 bits from Stanley's API export patch
* Add eFuse nvmem driver and adopt and extend nvmem cell API

Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: James Tai <james.tai@realtek.com>
Cc: Stanley Chang [昌育德] <stanley_chang@realtek.com>
Cc: Edgar Lee <cylee12@realtek.com>
Cc: hp@ligomedia.com

Andreas Färber (27):
  dt-bindings: soc: Add Realtek RTD1195 chip info binding
  soc: Add Realtek DHC chip info driver for RTD1195 and RTD1295
  arm64: dts: realtek: rtd129x: Add chip info node
  ARM: dts: rtd1195: Add chip info node
  dt-bindings: soc: realtek: rtd1195-chip: Add iso-syscon property
  soc: realtek: chip: Detect RTD1296
  arm64: dts: realtek: rtd129x: Extend chip-info reg with CHIP_INFO1
  soc: realtek: chip: Detect RTD1293
  soc: realtek: chip: Add RTD1395 info
  arm64: dts: realtek: rtd139x: Add chip info node
  soc: realtek: chip: Add RTD1619 info
  arm64: dts: realtek: rtd16xx: Add chip info node
  soc: realtek: chip: Add RTD1319 info
  arm64: dts: realtek: rtd13xx: Add chip info node
  dt-bindings: nvmem: Add Realtek RTD1195 eFuse
  nvmem: Add Realtek DHC eFuse driver
  ARM: dts: rtd1195: Add eFuse node
  arm64: dts: realtek: rtd129x: Add eFuse node
  arm64: dts: realtek: rtd139x: Add eFuse node
  arm64: dts: realtek: rtd16xx: Add eFuse node
  arm64: dts: realtek: rtd13xx: Add eFuse node
  dt-bindings: soc: realtek: rtd1195-chip: Allow nvmem-cells property
  arm64: dts: realtek: rtd129x: Add eFuse package_id to chip-info
  soc: realtek: chip: Detect RTD1294
  nvmem: core: Grammar fixes for help text
  nvmem: core: Add nvmem_cell_read_u8()
  soc: realtek: chip: Adopt nvmem_cell_read_u8() helper

Stanley Chang (2):
  soc: realtek: chip: Add RTD1319 revisions
  soc: realtek: chip: Detect RTD1392

 .../bindings/nvmem/realtek,rtd1195-efuse.yaml |  53 ++++
 .../soc/realtek/realtek,rtd1195-chip.yaml     |  55 ++++
 MAINTAINERS                                   |   4 +
 arch/arm/boot/dts/rtd1195.dtsi                |  13 +
 arch/arm64/boot/dts/realtek/rtd129x.dtsi      |  23 ++
 arch/arm64/boot/dts/realtek/rtd139x.dtsi      |  15 +-
 arch/arm64/boot/dts/realtek/rtd13xx.dtsi      |  15 +
 arch/arm64/boot/dts/realtek/rtd16xx.dtsi      |  15 +
 drivers/nvmem/Kconfig                         |   9 +
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/core.c                          |  27 +-
 drivers/nvmem/rtk-dhc-efuse.c                 |  86 ++++++
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/realtek/Kconfig                   |  13 +
 drivers/soc/realtek/Makefile                  |   2 +
 drivers/soc/realtek/chip.c                    | 269 ++++++++++++++++++
 include/linux/nvmem-consumer.h                |   1 +
 18 files changed, 597 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/realtek,rtd1195-efuse.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
 create mode 100644 drivers/nvmem/rtk-dhc-efuse.c
 create mode 100644 drivers/soc/realtek/Kconfig
 create mode 100644 drivers/soc/realtek/Makefile
 create mode 100644 drivers/soc/realtek/chip.c

-- 
2.26.2

