Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10339C3F2C1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35A224690
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="o1WmDQ8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgB0VEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:04:10 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.35]:42411 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726758AbgB0VEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:04:10 -0500
X-Greylist: delayed 1500 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Feb 2020 16:04:09 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id A0F685BBD9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 14:16:30 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id 7PaAjzwjkRP4z7PaAjOUXP; Thu, 27 Feb 2020 14:16:30 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dli9kbZ6lD/nnDirr7aZdMn36VuNaUx+QZ+TACIU/tA=; b=o1WmDQ8Ul7jha4hCTy8IB94VwD
        EJKa0915/vQCGn7dbSlMGMck6hiMPesVVtxejSyJ3zWgWRuAMUBFXPb9dWMa3m5200gVkD+dFdEh0
        7CBttQ89CyWYYlfb4IYCMTIFPDpqhinZQRnOQvDttvA+JmbU9vm0ejWlNBvmEwDvAnxiDfW+Yh0mU
        Xmf9WLa36EE1M0EdXowscfXwmiedtGUnl8MaFNnw/8e9RGlv4BB1Fa3J3zmq/VS54qy7AqRSnpsMq
        dTLgmsAUpbN0zULww6DGP9CJJcXwuWDhxdSa9cVq3SWgd75d3Er5uKWKdSnAl1ANhAgeK0mSjFZb2
        8AdnyFOg==;
Received: from [191.31.195.84] (port=40030 helo=castello.castello)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1j7Pa9-002xJo-TL; Thu, 27 Feb 2020 17:16:30 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v1 2/2] ARM: dts: Add Caninos Loucos Labrador
Date:   Thu, 27 Feb 2020 17:15:57 -0300
Message-Id: <20200227201557.368533-3-matheus@castello.eng.br>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227201557.368533-1-matheus@castello.eng.br>
References: <20200227201557.368533-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.195.84
X-Source-L: No
X-Exim-ID: 1j7Pa9-002xJo-TL
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello) [191.31.195.84]:40030
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 18
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Device Trees for Caninos Loucos Labrador SoM and base board.
Based on the work of Andreas Färber on Lemaker Guitar device tree.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 arch/arm/boot/dts/Makefile                  |  3 +-
 arch/arm/boot/dts/owl-s500-labrador-bb.dts  | 33 +++++++++++++++++++++
 arch/arm/boot/dts/owl-s500-labrador-v2.dtsi | 21 +++++++++++++
 3 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/owl-s500-labrador-bb.dts
 create mode 100644 arch/arm/boot/dts/owl-s500-labrador-v2.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d6546d2676b9..acdf65ef3236 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -842,7 +842,8 @@ dtb-$(CONFIG_ARCH_ORION5X) += \
 dtb-$(CONFIG_ARCH_ACTIONS) += \
 	owl-s500-cubieboard6.dtb \
 	owl-s500-guitar-bb-rev-b.dtb \
-	owl-s500-sparky.dtb
+	owl-s500-sparky.dtb \
+	owl-s500-labrador-bb.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += \
 	prima2-evb.dtb
 dtb-$(CONFIG_ARCH_PXA) += \
diff --git a/arch/arm/boot/dts/owl-s500-labrador-bb.dts b/arch/arm/boot/dts/owl-s500-labrador-bb.dts
new file mode 100644
index 000000000000..1e821804da30
--- /dev/null
+++ b/arch/arm/boot/dts/owl-s500-labrador-bb.dts
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019-2020 Matheus Castello
+ */
+
+/dts-v1/;
+
+#include "owl-s500-labrador-v2.dtsi"
+#include <dt-bindings/leds/common.h>
+
+/ {
+	compatible = "caninos,labrador-bb", "caninos,labrador", "actions,s500";
+	model = "Caninos Labrador Base Board M v1.0";
+
+	aliases {
+		serial3 = &uart3;
+	};
+
+	chosen {
+		stdout-path = "serial3:115200n8";
+	};
+
+	uart3_clk: uart3-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <921600>;
+		#clock-cells = <0>;
+	};
+};
+
+&uart3 {
+	status = "okay";
+	clocks = <&uart3_clk>;
+};
diff --git a/arch/arm/boot/dts/owl-s500-labrador-v2.dtsi b/arch/arm/boot/dts/owl-s500-labrador-v2.dtsi
new file mode 100644
index 000000000000..ee079f02b5dd
--- /dev/null
+++ b/arch/arm/boot/dts/owl-s500-labrador-v2.dtsi
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Caninos Labrador SoM V2
+ *
+ * Copyright (c) 2019-2020 Matheus Castello
+ */
+
+#include "owl-s500.dtsi"
+
+/ {
+	compatible = "caninos,labrador", "actions,s500";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x80000000>;
+	};
+};
+
+&timer {
+	clocks = <&hosc>;
+};
--
2.25.0

