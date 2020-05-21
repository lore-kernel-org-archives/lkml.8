Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FECC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACBD9206F6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rC+vrahW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgEUPCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:02:20 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:36100 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729481AbgEUPCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:02:20 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04LF2HIR101741;
        Thu, 21 May 2020 10:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590073337;
        bh=XUcNpLfupOrTnlSD6rhRE7DSiU4Wc5nJrdzWnNHy+bA=;
        h=From:To:CC:Subject:Date;
        b=rC+vrahW+jrLURA8QJ9Oit4MD2WyzFiXMs/CZIG25chdIz9dxazndzt5dQir7awLP
         SwZsmcUp+hZv1EPVXMemnU2ggqCge0S+2ZgTIfoLa+qos8T6BYzQBAhemcr04ausJq
         pIyuOA0AINtt1WXeGfvG0h6WyD0CwvEdYGXNiy10=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04LF2HNM014177;
        Thu, 21 May 2020 10:02:17 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 May 2020 10:02:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 May 2020 10:02:12 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04LF2APi003146;
        Thu, 21 May 2020 10:02:10 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: [GIT PULL] PHY: For 5.8
Date:   Thu, 21 May 2020 20:32:09 +0530
Message-ID: <20200521150209.6521-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find the pull request for 5.8 merge window below.

It adds four new PHY drivers for the various Cadence, Intel and
Qualcomm's PHYs. It adds support for Qualcomm's SM8250 UFS PHY
and SM8150 QMP USB3 PHY, Amlogic's USB2 PHY on Meson8m2 in existing
PHY drivers.

It also adds fixes to get USB working reliably in the various Broadcom,
Samsung, Amlogic and Cadence PHYs and converts bunch of device tree
binding documents to schema YAML format.

Please see the tag message below for the detailed list of changes and
let me know if I have to change something.

Thanks
Kishon

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-5.8

for you to fetch changes up to ac0a95a3ea7811f5cc4489924ddb54f0ea0f3007:

  phy: intel: Add driver support for ComboPhy (2020-05-19 20:26:06 +0530)

----------------------------------------------------------------
phy: for 5.8

*) Add new PHY driver to support Cadence SALVO PHY which supports USB3 & USB2
*) Add new PHY driver to support Intel ComboPhy which supports PCIe, SATA and
   EMAC
*) Add new PHY driver for Qualcomm IPQ40xx USB PHY
*) Add new PHY driver for Synopsys FemtoPHY V2 driver used in Qualcomm SOCs
*) Add support for Qualcomm SM8250 UFS PHY and SM8150 QMP USB3 PHY in
   qcom-qmp-phy driver
*) Add support for Amlogic USB2 PHY on Meson8m2 in phy-meson8b-usb2 driver
*) Add DisplayPort mode support in Wiz (TI Cadence PHY wrapper), to enable eDP
   in TI's J721E SoC
*) Add support for super speed USB PHY in TI's AM654 SoC
*) Add fix in Broadcom Stingray USB PHY to get USB PHY PLL lock reliably
*) Add fix in Samsung phy-s5pv210-usb2 to get USB working on s5pv210
*) Add fix in Amlogic phy-meson8b-usb2 to get host only mode working on Meson8
*) Add fix in Cadence phy-cadence-sierra to get USB3 device disconnect issue
*) Convert meson8b-usb2-phy, qcom-qmp-phy, rcar-gen3-phy-usb2 and
   rcar-gen3-phy-usb3 device tree binding to YAML schema
*) Minor fixes and cleanups in phy-cpcap-usb, j721e-wiz, omap-usb2,
   phy-bcm-sr-usb, phy-brcm-usb PHY driver

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

----------------------------------------------------------------
Bharat Gooty (1):
      drivers: phy: sr-usb: do not use internal fsm for USB2 phy init

Bjorn Andersson (2):
      phy: qcom: qmp: Add SM8250 UFS PHY
      phy: qcom-qmp: Ensure register indirection arrays initialized

Christophe JAILLET (1):
      phy: cpcap-usb: Remove some useless code

Dilip Kota (3):
      dt-bindings: phy: Add PHY_TYPE_XPCS definition
      dt-bindings: phy: Add YAML schemas for Intel ComboPhy
      phy: intel: Add driver support for ComboPhy

Geert Uytterhoeven (1):
      phy: intel-lgm-emmc: Add architecture dependency

Jack Pham (1):
      phy: qcom-qmp: Add SM8150 QMP USB3 PHY support

Jonathan Bakker (1):
      phy: samsung: s5pv210-usb2: Add delay after reset

Jyri Sarha (1):
      phy: ti: j721e-wiz: Implement DisplayPort mode to the wiz driver

Martin Blumenstingl (6):
      dt-bindings: phy: meson8b-usb2: Convert to json-schema
      dt-bindings: phy: meson8b-usb2: Add compatible string for Meson8m2
      phy: amlogic: meson8b-usb2: Use a MMIO regmap
      phy: amlogic: meson8b-usb2: Don't set REG_ADP_BC_ACA_ENABLE on Meson8
      phy: amlogic: meson8b-usb2: unset the IDDQ bit during PHY power-on
      phy: amlogic: meson8b-usb2: Add a compatible string for Meson8m2

Peter Chen (3):
      doc: dt-binding: cdns-salvo-phy: add binding doc
      phy: cadence: salvo: add salvo phy driver
      phy: phy-cadence-salvo: add phy .init API

Rikard Falkeborn (3):
      phy: sr-usb: Constify phy_ops
      phy: phy-brcm-usb: Constify static structs
      phy: phy-bcm-ns2-usbdrd: Constify phy_ops

Robert Marko (2):
      phy: add driver for Qualcomm IPQ40xx USB PHY
      dt-bindings: phy-qcom-ipq4019-usb: add binding document

Roger Quadros (3):
      phy: omap-usb2: Clean up exported header
      phy: ti: am654: show up in regmap debugfs
      phy: ti: am654: add support for USB super-speed

Sandeep Maheswaram (4):
      dt-bindings: phy: qcom,qmp: Convert QMP PHY bindings to yaml
      dt-bindings: phy: qcom,qmp-usb3-dp: Add dt bindings for USB3 DP PHY
      dt-bindings: phy: qcom,qmp-usb3-dp: Add support for SC7180
      phy: qcom-qmp: Add QMP V3 USB3 PHY support for SC7180

Sanket Parmar (1):
      phy: cadence: sierra: Fix for USB3 U1/U2 state

Wei Yongjun (1):
      phy: ti: j721e-wiz: Fix some error return code in wiz_probe()

Wesley Cheng (5):
      dt-bindings: phy: Add binding for qcom,usb-snps-femto-v2
      phy: qcom-snps: Add SNPS USB PHY driver for QCOM based SOCs
      phy: qcom-qmp: Use proper PWRDOWN offset for sm8150 USB
      phy: qcom-qmp: Rename UFS PCS QMP v4 registers
      dt-bindings: phy: usb-snps-femto-v2: Add regulator entries to example

Yoshihiro Shimoda (4):
      dt-bindings: phy: renesas: usb2-phy: convert bindings to json-schema
      dt-bindings: phy: renesas: usb2-phy: add r8a77961 support
      dt-bindings: phy: renesas: usb3-phy: convert bindings to json-schema
      dt-bindings: phy: renesas: usb3-phy: add r8a77961 support

 Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml |  64 ++++++++++
 Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml           |  52 +++++++++
 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml          | 101 ++++++++++++++++
 Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt          |  28 -----
 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml             | 313 +++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml     | 136 ++++++++++++++++++++++
 Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml   |  80 +++++++++++++
 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt              | 242 --------------------------------------
 Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml     |  50 ++++++++
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt        |  70 -----------
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt        |  52 ---------
 Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml         | 117 +++++++++++++++++++
 Documentation/devicetree/bindings/phy/renesas,usb3-phy.yaml         |  79 +++++++++++++
 drivers/phy/amlogic/Kconfig                                         |   3 +-
 drivers/phy/amlogic/phy-meson8b-usb2.c                              | 149 ++++++++++++++++--------
 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c                           |   2 +-
 drivers/phy/broadcom/phy-bcm-sr-usb.c                               |  57 +--------
 drivers/phy/broadcom/phy-brcm-usb.c                                 |  16 +--
 drivers/phy/cadence/Kconfig                                         |   9 ++
 drivers/phy/cadence/Makefile                                        |   1 +
 drivers/phy/cadence/phy-cadence-salvo.c                             | 325 +++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/cadence/phy-cadence-sierra.c                            |  27 ++---
 drivers/phy/intel/Kconfig                                           |  15 +++
 drivers/phy/intel/Makefile                                          |   1 +
 drivers/phy/intel/phy-intel-combo.c                                 | 632 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/motorola/phy-cpcap-usb.c                                |   2 -
 drivers/phy/qualcomm/Kconfig                                        |  17 +++
 drivers/phy/qualcomm/Makefile                                       |   2 +
 drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c                         | 148 +++++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.c                                 | 254 ++++++++++++++++++++++++++++++++++++----
 drivers/phy/qualcomm/phy-qcom-qmp.h                                 | 238 +++++++++++++++++++++++++++++++++----
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c                       | 287 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/samsung/phy-s5pv210-usb2.c                              |   4 +
 drivers/phy/ti/phy-am654-serdes.c                                   | 104 ++++++++++++++++-
 drivers/phy/ti/phy-j721e-wiz.c                                      |  65 ++++++++++-
 drivers/phy/ti/phy-omap-usb2.c                                      |  60 +++++++++-
 include/dt-bindings/phy/phy.h                                       |   1 +
 include/linux/phy/omap_usb.h                                        |  69 +----------
 38 files changed, 3228 insertions(+), 644 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt
 create mode 100644 Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/renesas,usb3-phy.yaml
 create mode 100644 drivers/phy/cadence/phy-cadence-salvo.c
 create mode 100644 drivers/phy/intel/phy-intel-combo.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
