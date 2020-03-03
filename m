Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D2FC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A691220870
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbgCCRcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:32:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:44474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730375AbgCCRcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:32:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D0F79B028;
        Tue,  3 Mar 2020 17:32:38 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>
Cc:     wahrenst@gmx.net, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: bcm283x: Use firmware PM driver for V3D
Date:   Tue,  3 Mar 2020 18:32:16 +0100
Message-Id: <20200303173217.3987-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register based driver turned out to be unstable, specially on RPi3a+
but not limited to it. While a fix is being worked on, we roll back to
using firmware based scheme.

Fixes: e1dc2b2e1bef ("ARM: bcm283x: Switch V3D over to using the PM driver instead of firmware")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

See https://github.com/raspberrypi/linux/issues/3046 for more reference.
Note: I tested this on RPi3b, RPi3a+ and RPi2b.

 arch/arm/boot/dts/bcm2835-common.dtsi     |  1 -
 arch/arm/boot/dts/bcm2835-rpi-common.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/bcm2835.dtsi            |  1 +
 arch/arm/boot/dts/bcm2836.dtsi            |  1 +
 arch/arm/boot/dts/bcm2837.dtsi            |  1 +
 5 files changed, 15 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-common.dtsi

diff --git a/arch/arm/boot/dts/bcm2835-common.dtsi b/arch/arm/boot/dts/bcm2835-common.dtsi
index 2b1d9d4c0cde..4119271c979d 100644
--- a/arch/arm/boot/dts/bcm2835-common.dtsi
+++ b/arch/arm/boot/dts/bcm2835-common.dtsi
@@ -130,7 +130,6 @@ v3d: v3d@7ec00000 {
 			compatible = "brcm,bcm2835-v3d";
 			reg = <0x7ec00000 0x1000>;
 			interrupts = <1 10>;
-			power-domains = <&pm BCM2835_POWER_DOMAIN_GRAFX_V3D>;
 		};
 
 		vc4: gpu {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-common.dtsi b/arch/arm/boot/dts/bcm2835-rpi-common.dtsi
new file mode 100644
index 000000000000..b78a57534611
--- /dev/null
+++ b/arch/arm/boot/dts/bcm2835-rpi-common.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This include file covers the common peripherals and configuration between
+ * bcm2835, bcm2836 and bcm2837 implementations that interact with RPi's
+ * firmware interface.
+ */
+
+#include <dt-bindings/power/raspberrypi-power.h>
+
+&v3d {
+	power-domains = <&power RPI_POWER_DOMAIN_V3D>;
+};
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 53bf4579cc22..0549686134ea 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "bcm283x.dtsi"
 #include "bcm2835-common.dtsi"
+#include "bcm2835-rpi-common.dtsi"
 
 / {
 	compatible = "brcm,bcm2835";
diff --git a/arch/arm/boot/dts/bcm2836.dtsi b/arch/arm/boot/dts/bcm2836.dtsi
index 82d6c4662ae4..b390006aef79 100644
--- a/arch/arm/boot/dts/bcm2836.dtsi
+++ b/arch/arm/boot/dts/bcm2836.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "bcm283x.dtsi"
 #include "bcm2835-common.dtsi"
+#include "bcm2835-rpi-common.dtsi"
 
 / {
 	compatible = "brcm,bcm2836";
diff --git a/arch/arm/boot/dts/bcm2837.dtsi b/arch/arm/boot/dts/bcm2837.dtsi
index 9e95fee78e19..0199ec98cd61 100644
--- a/arch/arm/boot/dts/bcm2837.dtsi
+++ b/arch/arm/boot/dts/bcm2837.dtsi
@@ -1,5 +1,6 @@
 #include "bcm283x.dtsi"
 #include "bcm2835-common.dtsi"
+#include "bcm2835-rpi-common.dtsi"
 
 / {
 	compatible = "brcm,bcm2837";
-- 
2.25.1

