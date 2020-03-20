Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1804C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 22:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8018520722
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 22:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lM0yIWHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgCTWb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 18:31:26 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59510 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTWb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 18:31:26 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02KMVOjw055507;
        Fri, 20 Mar 2020 17:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584743484;
        bh=WGYA3OsL9hLfl6/RQScOCv8oBrr/ToVjiYnloTWkG2M=;
        h=From:To:CC:Subject:Date;
        b=lM0yIWHXB/1C4Tj2r3yvjCX14FHxLG73Q0bqgF2ibfPyJcIccDS2VR1V2FUr3we+2
         qTMr775XXNE7iLhwkGiGCd99fZNiAGq9eaZKkFYuUrC4JApU89eenKcpMAkSiEt0on
         mjUWGWAgXe5IfZbtrKvr1vaU6zKADQlimfS2LYIU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02KMVO5B127401
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Mar 2020 17:31:24 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 20
 Mar 2020 17:31:23 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 20 Mar 2020 17:31:23 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02KMVLli103649;
        Fri, 20 Mar 2020 17:31:22 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] PHY: For 5.7 merge window
Date:   Sat, 21 Mar 2020 04:01:21 +0530
Message-ID: <20200320223121.4821-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find the pull request for 5.7 merge window below. (Sorry for the
delay).

It adds two new PHY drivers for supporting Qualcomm high Speed PHY and
super speed PHY, redesigns phy-cadence-dp to phy-cadence-torrent driver
since Cadence Torrent driver can support PCIe, USB, SGMII etc.. in
addition to display port (support for the additional protocols will be
added later).

It also adds support for Qualcomm's PCIe, UFS and USB2 PHY; TI's
GMII PHY; Amlogic's USB2 PHY; Socionext's USB3/USB2/PCIe PHY.

Please see the tag message below for the complete list of changes.

Let me know If I have to change something.

Thanks
Kishon

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.7

for you to fetch changes up to 89d715371a05b1dee32faf49014b1acff6138b83:

  phy: qcom-qusb2: Add new overriding tuning parameters in QUSB2 V2 PHY (2020-03-20 19:34:29 +0530)

----------------------------------------------------------------
phy: for 5.7

*) Rename and Re-design phy-cadence-dp driver to phy-cadence-torrent driver
*) Add new PHY driver for Qualcomm 28nm Hi-Speed USB PHY
*) Add new PHY driver for Qualcomm Super Speed PHY in QCS404
*) Add support for Qualcomm PCIe QMP/QHP PHY in SDM845 to phy-qcom-qmp driver
*) Add support for Qualcomm UFS PHY in MSM8996 to phy-qcom-qmp driver
*) Add support for an additional reference clock in Mediatek phy-mtk-tphy driver
*) Add support for configuring tuning parameters in Mediatek phy-mtk-tphy driver
*) Add support for GMII PHY in TI K3 AM654x/J721E SoCs to phy-gmii-sel driver
*) Add support for USB2 PHY in Amlogic A1 SoC Family to phy-meson-g12a-usb2
   driver
*) Add support for USB3/USB2/PCIe PHY in Socionext Pro5 SoC to
   phy-uniphier-usb3ss/phy-uniphier-usb3hs/phy-uniphier-pcie driver respectively
*) Add support for QUSB2 PHY in Qualcomm SC7180 in driver
*) Convert dt-bindings of Cadence DP, Qualcomm QUSB2 to YAML format

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

----------------------------------------------------------------
Bjorn Andersson (5):
      dt-bindings: phy-qcom-qmp: Add SDM845 PCIe to binding
      phy: qcom: qmp: Add SDM845 PCIe QMP PHY support
      phy: qcom: qmp: Add SDM845 QHP PCIe PHY
      phy: qcom-qmp: Add MSM8996 UFS QMP support
      phy: qcom: qmp: Use power_on/off ops for PCIe

Christoph Muellner (1):
      phy: rk-inno-usb2: Decrease verbosity of repeating log.

Chunfeng Yun (10):
      dt-bindings: phy-mtk-tphy: add two optional properties for u2phy
      dt-bindings: phy-mtk-tphy: make the ref clock optional
      dt-bindings: phy-mtk-tphy: remove unused u3phya_ref clock
      dt-bindings: phy-mtk-tphy: add a new reference clock
      dt-bindings: phy-mtk-tphy: add the properties about address mapping
      phy: phy-mtk-tphy: add a property for disconnect threshold
      phy: phy-mtk-tphy: add a property for internal resistance
      phy: phy-mtk-tphy: make the ref clock optional
      phy: phy-mtk-tphy: remove unused u3phya_ref clock
      phy: phy-mtk-tphy: add a new reference clock

Grygorii Strashko (2):
      dt-bindings: phy: ti: gmii-sel: add support for am654x/j721e soc
      phy: ti: gmii-sel: add support for am654x/j721e soc

Hanjie Lin (2):
      dt-bindings: phy: Add Amlogic A1 USB2 PHY Bindings
      phy: amlogic: Add Amlogic A1 USB2 PHY Driver

Joe Perches (1):
      phy: amlogic: G12A: Fix misuse of GENMASK macro

Jorge Ramirez-Ortiz (3):
      dt-bindings: phy: remove qcom-dwc3-usb-phy
      dt-bindings: Add Qualcomm USB SuperSpeed PHY bindings
      phy: qualcomm: usb: Add SuperSpeed PHY driver

Kunihiko Hayashi (7):
      phy: socionext: Use devm_platform_ioremap_resource()
      dt-bindings: phy: socionext: Add Pro5 support and remove Pro4 from usb3-hsphy
      phy: uniphier-usb3ss: Add Pro5 support
      phy: uniphier-usb3hs: Add legacy SoC support for Pro5
      phy: uniphier-usb3hs: Change Rx sync mode to avoid communication failure
      phy: uniphier-pcie: Add legacy SoC support for Pro5
      phy: uniphier-pcie: Add SoC-dependent phy-mode function support

Sandeep Maheswaram (6):
      dt-bindings: phy: qcom,qusb2: Convert QUSB2 phy bindings to yaml
      dt-bindings: phy: qcom,qusb2: Add compatibles for QUSB2 V2 phy and SC7180
      phy: qcom-qusb2: Add generic QUSB2 V2 PHY support
      dt-bindings: phy: qcom-qusb2: Add support for overriding Phy tuning parameters
      phy: qcom-qusb2: Add support for overriding tuning parameters in QUSB2 V2 PHY
      phy: qcom-qusb2: Add new overriding tuning parameters in QUSB2 V2 PHY

Shawn Guo (1):
      phy: qualcomm: Add Synopsys 28nm Hi-Speed USB PHY driver

Sriharsha Allenki (1):
      dt-bindings: phy: Add Qualcomm Synopsys Hi-Speed USB PHY binding

Swapnil Jakhade (10):
      phy: cadence-torrent: Adopt Torrent nomenclature
      phy: cadence-torrent: Add wrapper for PHY register access
      phy: cadence-torrent: Add wrapper for DPTX register access
      phy: cadence-torrent: Refactor code for reusability
      phy: cadence-torrent: Add 19.2 MHz reference clock support
      phy: cadence-torrent: Implement PHY configure APIs
      phy: cadence-torrent: Use regmap to read and write Torrent PHY registers
      phy: cadence-torrent: Use regmap to read and write DPTX PHY registers
      phy: cadence-torrent: Add platform dependent initialization structure
      phy: cadence-torrent: Add support for subnode bindings

Yuti Amonkar (3):
      dt-bindings: phy: Remove Cadence MHDP PHY dt binding
      dt-bindings: phy: Add Cadence MHDP PHY bindings in YAML format.
      phy: cadence-dp: Rename to phy-cadence-torrent

 Documentation/devicetree/bindings/phy/amlogic,meson-g12a-usb2-phy.yaml |   14 +
 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt               |   30 -
 Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml         |  143 ++++
 Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt                 |   32 +-
 Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml              |  185 +++++
 Documentation/devicetree/bindings/phy/qcom,usb-hs-28nm.yaml            |   90 +++
 Documentation/devicetree/bindings/phy/qcom,usb-ss.yaml                 |   83 ++
 Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt            |   37 -
 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt                 |   15 +
 Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt               |   68 --
 Documentation/devicetree/bindings/phy/ti-phy-gmii-sel.txt              |    1 +
 Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt            |   13 +-
 Documentation/devicetree/bindings/phy/uniphier-usb3-hsphy.txt          |    6 +-
 Documentation/devicetree/bindings/phy/uniphier-usb3-ssphy.txt          |    5 +-
 drivers/phy/amlogic/phy-meson-g12a-usb2.c                              |   87 ++-
 drivers/phy/cadence/Kconfig                                            |    6 +-
 drivers/phy/cadence/Makefile                                           |    2 +-
 drivers/phy/cadence/phy-cadence-dp.c                                   |  541 -------------
 drivers/phy/cadence/phy-cadence-torrent.c                              | 1944 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/mediatek/phy-mtk-tphy.c                                    |   64 +-
 drivers/phy/qualcomm/Kconfig                                           |   20 +
 drivers/phy/qualcomm/Makefile                                          |    2 +
 drivers/phy/qualcomm/phy-qcom-qmp.c                                    |  425 ++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp.h                                    |  114 +++
 drivers/phy/qualcomm/phy-qcom-qusb2.c                                  |  144 +++-
 drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c                            |  415 ++++++++++
 drivers/phy/qualcomm/phy-qcom-usb-ss.c                                 |  246 ++++++
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c                          |    2 +-
 drivers/phy/socionext/phy-uniphier-pcie.c                              |  102 ++-
 drivers/phy/socionext/phy-uniphier-usb3hs.c                            |   92 ++-
 drivers/phy/socionext/phy-uniphier-usb3ss.c                            |    8 +-
 drivers/phy/ti/phy-gmii-sel.c                                          |   19 +
 32 files changed, 4119 insertions(+), 836 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hs-28nm.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-ss.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
 delete mode 100644 drivers/phy/cadence/phy-cadence-dp.c
 create mode 100644 drivers/phy/cadence/phy-cadence-torrent.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-ss.c
