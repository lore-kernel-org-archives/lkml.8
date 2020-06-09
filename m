Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E656C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 07:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60B6C2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 07:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgFIHsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 03:48:08 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:50536 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgFIHsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 03:48:04 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 094B9AD4DA;
        Tue,  9 Jun 2020 15:40:30 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from ubuntu18.lan (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P31250T139912844142336S1591688422511107_;
        Tue, 09 Jun 2020 15:40:28 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f1bb287535e694da4612b79938bd4beb>
X-RL-SENDER: yifeng.zhao@rock-chips.com
X-SENDER: zyf@rock-chips.com
X-LOGIN-NAME: yifeng.zhao@rock-chips.com
X-FST-TO: miquel.raynal@bootlin.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Yifeng Zhao <yifeng.zhao@rock-chips.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        heiko@sntech.de, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>
Subject: [PATCH v6 0/8] Add Rockchip NFC drivers for RK3308 and others
Date:   Tue,  9 Jun 2020 15:40:17 +0800
Message-Id: <20200609074020.23860-1-yifeng.zhao@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Rockchp's NFC(Nand Flash Controller) has four versions: V600, V622, V800 and V900.
This series patch can support all four versions.


Changes in v6:
- Fix some wrong define
- Modified the definition of compatible
- The mtd->name set by NAND label property.
- Add some comments.
- Fix compile error.

Changes in v5:
- Fix some wrong define
- Add boot-medium define
- Remove some compatible define
- Add boot blocks support  with different ecc for bootrom.
- Rename rockchip-nand.c to rockchip-nand-controller.c.
- Unification of other variable names.
- Remove some compatible define.

Changes in v4:
- The compatible define with rkxx_nfc
- Add assigned-clocks
- Fix some wrong define
- Define platform data structure for the register offsets.
- The compatible define with rkxx_nfc.
- Use SET_SYSTEM_SLEEP_PM_OPS to define PM_OPS.
- Use exec_op instead of legacy hooks.

Changes in v3:
- Change the title for the dt-bindings

Changes in v2:
- Fix compile error.
- Include header files sorted by file name.

Yifeng Zhao (8):
  dt-bindings: mtd: Describe Rockchip RK3xxx NAND flash controller
  mtd: rawnand: rockchip: NFC drivers for RK3308, RK2928 and others
  MAINTAINERS: add maintainers to rockchip nfc
  arm64: dts: rockchip: Add nfc dts for RK3308 SOC
  arm64: dts: rockchip: Add nfc dts for PX30 SOC
  arm: dts: rockchip: Add nfc dts for RV1108 SOC
  arm: dts: rockchip: Add nfc dts for RK2928 and other SOC
  arm: dts: rockchip: Add nfc dts for RK3036 SOC

 .../mtd/rockchip,nand-controller.yaml         |  154 ++
 MAINTAINERS                                   |    4 +-
 arch/arm/boot/dts/rk3036.dtsi                 |   52 +
 arch/arm/boot/dts/rk3xxx.dtsi                 |    9 +
 arch/arm/boot/dts/rv1108.dtsi                 |   11 +
 arch/arm64/boot/dts/rockchip/px30.dtsi        |   15 +
 arch/arm64/boot/dts/rockchip/rk3308.dtsi      |   15 +
 drivers/mtd/nand/raw/Kconfig                  |   21 +
 drivers/mtd/nand/raw/Makefile                 |    1 +
 .../mtd/nand/raw/rockchip-nand-controller.c   | 1393 +++++++++++++++++
 10 files changed, 1673 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
 create mode 100644 drivers/mtd/nand/raw/rockchip-nand-controller.c

-- 
2.17.1



