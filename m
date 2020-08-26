Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C97C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21E8B2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598438851;
	bh=M5FKNy7mR4CpIoDYVV/FmSlJr8tnd2RHgsaQRZK7yho=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=MuE+N6tNF26QQXTJHKu+mozb02WegdpVghB4lPcZDGpFT6mPbMyX5mPy/E2helry1
	 TdYk51uJ2tesMgD8HCcsS3tg8YZRX0pSNl3Q2wgWjlNF+4mypU0IVf4jQDr5OKNewZ
	 l54jEWB+g1qv/8XMh19E95GNj1hRdaDB0xBXtjHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgHZKr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgHZKrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:47:14 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6090206EB;
        Wed, 26 Aug 2020 10:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598438833;
        bh=M5FKNy7mR4CpIoDYVV/FmSlJr8tnd2RHgsaQRZK7yho=;
        h=From:To:Cc:Subject:Date:From;
        b=oouaKAT8CCiuPDnN0ib4TVula3BqoldT57MlfZzIT0/e4TgBe2rRUy/9JU6SZ3TyB
         K5TEDAcViyKF6aGWqFPhLJlNVgH2UUusL+WnQf2UcU3dmiyiqE1wBNEfc5dfPzR59w
         E5btJxTAF1R5E79BMYbrWPVJcEtnFKIlMyHXZUZg=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kAsxT-002DZs-1L; Wed, 26 Aug 2020 12:47:11 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] dt-bindings: fix references to files converted to yaml
Date:   Wed, 26 Aug 2020 12:47:09 +0200
Message-Id: <20200826104709.528809-1-mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were several files converted to yaml, but the .txt file
is still referenced somewhere else.

Update the references for them to point to the right file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../bindings/display/tilcdc/tilcdc.txt         |  2 +-
 .../bindings/mailbox/omap-mailbox.txt          |  2 +-
 .../devicetree/bindings/media/i2c/tvp5150.txt  |  2 +-
 .../bindings/pwm/google,cros-ec-pwm.yaml       |  2 +-
 .../bindings/soc/qcom/qcom,smd-rpm.yaml        |  2 +-
 .../bindings/sound/google,cros-ec-codec.yaml   |  2 +-
 MAINTAINERS                                    | 18 +++++++++---------
 .../bindings/net/wireless/siliabs,wfx.txt      |  2 +-
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt b/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt
index 8b2a71395647..3e64075ac7ec 100644
--- a/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt
+++ b/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt
@@ -37,7 +37,7 @@ Optional nodes:
    supports a single port with a single endpoint.
 
  - See also Documentation/devicetree/bindings/display/tilcdc/panel.txt and
-   Documentation/devicetree/bindings/display/bridge/ti,tfp410.txt for connecting
+   Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml for connecting
    tfp410 DVI encoder or lcd panel to lcdc
 
 [1] There is an errata about AM335x color wiring. For 16-bit color mode
diff --git a/Documentation/devicetree/bindings/mailbox/omap-mailbox.txt b/Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
index 35c3f56b7f7b..5fe80c1c19fc 100644
--- a/Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
+++ b/Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
@@ -69,7 +69,7 @@ The following are mandatory properties for the K3 AM65x and J721E SoCs only:
 			the interrupt routes between the IP and the main GIC
 			controllers. See the following binding for additional
 			details,
-			Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
+			Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
 
 Child Nodes:
 ============
diff --git a/Documentation/devicetree/bindings/media/i2c/tvp5150.txt b/Documentation/devicetree/bindings/media/i2c/tvp5150.txt
index 6c88ce858d08..719b2995dc17 100644
--- a/Documentation/devicetree/bindings/media/i2c/tvp5150.txt
+++ b/Documentation/devicetree/bindings/media/i2c/tvp5150.txt
@@ -56,7 +56,7 @@ Optional Connector Properties:
                   instead of using the autodetection mechnism. Please look at
                   [1] for more information.
 
-[1] Documentation/devicetree/bindings/display/connector/analog-tv-connector.txt.
+[1] Documentation/devicetree/bindings/display/connector/analog-tv-connector.yaml.
 
 Example - three input sources:
 #include <dt-bindings/display/sdtv-standards.h>
diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
index 41ece1d85315..4cfbffd8414a 100644
--- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
@@ -14,7 +14,7 @@ description: |
   Google's ChromeOS EC PWM is a simple PWM attached to the Embedded Controller
   (EC) and controlled via a host-command interface.
   An EC PWM node should be only found as a sub-node of the EC node (see
-  Documentation/devicetree/bindings/mfd/cros-ec.txt).
+  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml).
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
index 468d658ce3e7..2684f22a1d85 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
@@ -20,7 +20,7 @@ description: |
   present and this subnode may contain children that designate regulator
   resources.
 
-  Refer to Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
+  Refer to Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
   for information on the regulator subnodes that can exist under the
   rpm_requests.
 
diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
index c84e656afb0a..3b9143af2c7c 100644
--- a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
@@ -13,7 +13,7 @@ description: |
   Google's ChromeOS EC codec is a digital mic codec provided by the
   Embedded Controller (EC) and is controlled via a host-command interface.
   An EC codec node should only be found as a sub-node of the EC node (see
-  Documentation/devicetree/bindings/mfd/cros-ec.txt).
+  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml).
 
 properties:
   compatible:
diff --git a/MAINTAINERS b/MAINTAINERS
index 8107b3d5d6df..2cb818035d1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1530,7 +1530,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/actions.yaml
 F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
-F:	Documentation/devicetree/bindings/dma/owl-dma.txt
+F:	Documentation/devicetree/bindings/dma/owl-dma.yaml
 F:	Documentation/devicetree/bindings/i2c/i2c-owl.txt
 F:	Documentation/devicetree/bindings/mmc/owl-mmc.yaml
 F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
@@ -5609,7 +5609,7 @@ DRM DRIVER FOR ROCKTECH JH057N00900 PANELS
 M:	Guido Günther <agx@sigxcpu.org>
 R:	Purism Kernel Team <kernel@puri.sm>
 S:	Maintained
-F:	Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
+F:	Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
 F:	drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
 
 DRM DRIVER FOR SAVAGE VIDEO CARDS
@@ -5857,7 +5857,7 @@ L:	linux-renesas-soc@vger.kernel.org
 S:	Supported
 T:	git git://linuxtv.org/pinchartl/media drm/du/next
 F:	Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt
-F:	Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
+F:	Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml
 F:	Documentation/devicetree/bindings/display/renesas,du.txt
 F:	drivers/gpu/drm/rcar-du/
 F:	drivers/gpu/drm/shmobile/
@@ -6984,7 +6984,7 @@ M:	Frank Li <Frank.li@nxp.com>
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
 F:	Documentation/admin-guide/perf/imx-ddr.rst
-F:	Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
+F:	Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
 F:	drivers/perf/fsl_imx8_ddr_perf.c
 
 FREESCALE IMX I2C DRIVER
@@ -6992,7 +6992,7 @@ M:	Oleksij Rempel <o.rempel@pengutronix.de>
 R:	Pengutronix Kernel Team <kernel@pengutronix.de>
 L:	linux-i2c@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/i2c/i2c-imx.txt
+F:	Documentation/devicetree/bindings/i2c/i2c-imx.yaml
 F:	drivers/i2c/busses/i2c-imx.c
 
 FREESCALE IMX LPI2C DRIVER
@@ -7000,7 +7000,7 @@ M:	Dong Aisheng <aisheng.dong@nxp.com>
 L:	linux-i2c@vger.kernel.org
 L:	linux-imx@nxp.com
 S:	Maintained
-F:	Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt
+F:	Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
 F:	drivers/i2c/busses/i2c-imx-lpi2c.c
 
 FREESCALE QORIQ DPAA ETHERNET DRIVER
@@ -11637,7 +11637,7 @@ MIPS GENERIC PLATFORM
 M:	Paul Burton <paulburton@kernel.org>
 L:	linux-mips@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/power/mti,mips-cpc.txt
+F:	Documentation/devicetree/bindings/power/mti,mips-cpc.yaml
 F:	arch/mips/generic/
 F:	arch/mips/tools/generic-board-config.sh
 
@@ -12498,7 +12498,7 @@ NXP SGTL5000 DRIVER
 M:	Fabio Estevam <festevam@gmail.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/sound/sgtl5000.txt
+F:	Documentation/devicetree/bindings/sound/sgtl5000.yaml
 F:	sound/soc/codecs/sgtl5000*
 
 NXP SJA1105 ETHERNET SWITCH DRIVER
@@ -16779,7 +16779,7 @@ SYNOPSYS DESIGNWARE DMAC DRIVER
 M:	Viresh Kumar <vireshk@kernel.org>
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/dma/snps-dma.txt
+F:	Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
 F:	drivers/dma/dw/
 F:	include/dt-bindings/dma/dw-dmac.h
 F:	include/linux/dma/dw.h
diff --git a/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/siliabs,wfx.txt b/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/siliabs,wfx.txt
index 17db67559f5e..362af9f0b7e3 100644
--- a/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/siliabs,wfx.txt
+++ b/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/siliabs,wfx.txt
@@ -51,7 +51,7 @@ Required properties:
 In addition, it is recommended to declare a mmc-pwrseq on SDIO host above WFx.
 Without it, you may encounter issues with warm boot. mmc-pwrseq should be
 compatible with mmc-pwrseq-simple. Please consult
-Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt for more
+Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml for more
 information.
 
 Example:
-- 
2.26.2

