Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6182FC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E91321919
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599670906;
	bh=bJ2b6MfKauEwuBGog7JgCVabeyVWjEFU5iqs8dAiANw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tHURcEy/OuPL0CUpKyt3SSueQWYMGtdaoB0g3TaE9c/ZPy7W7Dy9SgQwoTcL3NDo8
	 5lJ7FJMnUbULwjljFkZ0rsGpbqIHywEJ0dGKicQOJlcM2mZZQQ7//x5a92A6a1/4Cq
	 crsbyEjwoltzWCbvx/xq9umEf1eIoztqtQDB1jko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbgIIRBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730619AbgIIPuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:50:50 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FBB3206D4;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=bJ2b6MfKauEwuBGog7JgCVabeyVWjEFU5iqs8dAiANw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D9TET/kLmIIrzvE/k/Hhg5Q6Z9QNUsDOVooTgJd519Ps9a/JKoNzoFom6i5hOQSro
         XF9NG+S5QEl9UGPLOh7H9IpfYub/xmObbZUxYbdFT8lbHUSrXLgwXY72u5ut3zTrz/
         XZmNIC2JWzd1pvC+yG9d6dxYkPmWQj3MtVzyJOgU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUWc-2S; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/30] dt-bindings: fix references to files converted to yaml
Date:   Wed,  9 Sep 2020 16:10:34 +0200
Message-Id: <8151ccfbd2830e5539b0e9bc3921560b8ef6655c.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
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
index 3c0692404907..f3fee4140272 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1544,7 +1544,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/actions.yaml
 F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
-F:	Documentation/devicetree/bindings/dma/owl-dma.txt
+F:	Documentation/devicetree/bindings/dma/owl-dma.yaml
 F:	Documentation/devicetree/bindings/i2c/i2c-owl.txt
 F:	Documentation/devicetree/bindings/mmc/owl-mmc.yaml
 F:	Documentation/devicetree/bindings/pinctrl/actions,*
@@ -5634,7 +5634,7 @@ DRM DRIVER FOR ROCKTECH JH057N00900 PANELS
 M:	Guido Günther <agx@sigxcpu.org>
 R:	Purism Kernel Team <kernel@puri.sm>
 S:	Maintained
-F:	Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
+F:	Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
 F:	drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
 
 DRM DRIVER FOR SAVAGE VIDEO CARDS
@@ -5883,7 +5883,7 @@ L:	linux-renesas-soc@vger.kernel.org
 S:	Supported
 T:	git git://linuxtv.org/pinchartl/media drm/du/next
 F:	Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt
-F:	Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
+F:	Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml
 F:	Documentation/devicetree/bindings/display/renesas,du.txt
 F:	drivers/gpu/drm/rcar-du/
 F:	drivers/gpu/drm/shmobile/
@@ -7013,7 +7013,7 @@ M:	Frank Li <Frank.li@nxp.com>
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
 F:	Documentation/admin-guide/perf/imx-ddr.rst
-F:	Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
+F:	Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
 F:	drivers/perf/fsl_imx8_ddr_perf.c
 
 FREESCALE IMX I2C DRIVER
@@ -7021,7 +7021,7 @@ M:	Oleksij Rempel <o.rempel@pengutronix.de>
 R:	Pengutronix Kernel Team <kernel@pengutronix.de>
 L:	linux-i2c@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/i2c/i2c-imx.txt
+F:	Documentation/devicetree/bindings/i2c/i2c-imx.yaml
 F:	drivers/i2c/busses/i2c-imx.c
 
 FREESCALE IMX LPI2C DRIVER
@@ -7029,7 +7029,7 @@ M:	Dong Aisheng <aisheng.dong@nxp.com>
 L:	linux-i2c@vger.kernel.org
 L:	linux-imx@nxp.com
 S:	Maintained
-F:	Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt
+F:	Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
 F:	drivers/i2c/busses/i2c-imx-lpi2c.c
 
 FREESCALE QORIQ DPAA ETHERNET DRIVER
@@ -11673,7 +11673,7 @@ MIPS GENERIC PLATFORM
 M:	Paul Burton <paulburton@kernel.org>
 L:	linux-mips@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/power/mti,mips-cpc.txt
+F:	Documentation/devicetree/bindings/power/mti,mips-cpc.yaml
 F:	arch/mips/generic/
 F:	arch/mips/tools/generic-board-config.sh
 
@@ -12534,7 +12534,7 @@ NXP SGTL5000 DRIVER
 M:	Fabio Estevam <festevam@gmail.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/sound/sgtl5000.txt
+F:	Documentation/devicetree/bindings/sound/sgtl5000.yaml
 F:	sound/soc/codecs/sgtl5000*
 
 NXP SJA1105 ETHERNET SWITCH DRIVER
@@ -16827,7 +16827,7 @@ SYNOPSYS DESIGNWARE DMAC DRIVER
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

