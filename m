Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2ABC10DCE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B224820637
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="hzsuDJzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCGAug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 19:50:36 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.142]:12431 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726231AbgCGAuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 19:50:35 -0500
X-Greylist: delayed 1466 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Mar 2020 19:50:35 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 737C29C9A76
        for <linux-kernel@vger.kernel.org>; Fri,  6 Mar 2020 18:26:08 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id ANI8jWugtRP4zANI8jtw3d; Fri, 06 Mar 2020 18:26:08 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=msXgc3TGQhw2fSPO6AXY+2RmKkB9onA2Nue9cLwXGQI=; b=hzsuDJzqHrn7CrKIhYBOffx5FB
        reovpBTHdQE0LIYla3E2AySPD7mJ957Nl/JTwPDB2xijwvGHSAAe+duO1JNfGW+Jcwl393c4S/uUd
        fJrrkmUgxY9Vrkw3J5IknOlGwWoR3VtO57uvpSOQcoim+2raXEDOpkfoiV3lb9NlS/aBZvlXWlOd6
        GAbJ39Eg6TEt1JjeEDeY8xNEJivr7Zcj2t2gVPdbmC3D1zEsm7UxYQAVMp2vhYBWNGL+JUFszd4q9
        gizZrCZJ93q4ZQy/RAR3h7P5IvyL6JnB77kjnY1KDoN4oLaSANkxUJsStUEqKprNnUy62SWePA+7x
        5RtjdTOg==;
Received: from [191.31.207.132] (port=48872 helo=castello.castello)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1jANI7-001YDM-Ri; Fri, 06 Mar 2020 21:26:08 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v2 3/3] ARM: dts: Add Caninos Loucos Labrador
Date:   Fri,  6 Mar 2020 21:24:53 -0300
Message-Id: <20200307002453.350430-4-matheus@castello.eng.br>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200307002453.350430-1-matheus@castello.eng.br>
References: <20200229104358.GB19610@mani>
 <20200307002453.350430-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.207.132
X-Source-L: No
X-Exim-ID: 1jANI7-001YDM-Ri
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello) [191.31.207.132]:48872
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 25
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Device Trees for Caninos Loucos Labrador CoM and base board.
Based on the work of Andreas Färber on Lemaker Guitar device tree.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 arch/arm/boot/dts/Makefile                  |  1 +
 arch/arm/boot/dts/owl-s500-labrador-bb.dts  | 34 +++++++++++++++++++++
 arch/arm/boot/dts/owl-s500-labrador-v2.dtsi | 21 +++++++++++++
 3 files changed, 56 insertions(+)
 create mode 100644 arch/arm/boot/dts/owl-s500-labrador-bb.dts
 create mode 100644 arch/arm/boot/dts/owl-s500-labrador-v2.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d6546d2676b9..99f633460833 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -842,6 +842,7 @@ dtb-$(CONFIG_ARCH_ORION5X) += \
 dtb-$(CONFIG_ARCH_ACTIONS) += \
 	owl-s500-cubieboard6.dtb \
 	owl-s500-guitar-bb-rev-b.dtb \
+	owl-s500-labrador-bb.dtb \
 	owl-s500-sparky.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += \
 	prima2-evb.dtb
diff --git a/arch/arm/boot/dts/owl-s500-labrador-bb.dts b/arch/arm/boot/dts/owl-s500-labrador-bb.dts
new file mode 100644
index 000000000000..91012b4a4c30
--- /dev/null
+++ b/arch/arm/boot/dts/owl-s500-labrador-bb.dts
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Caninos Labrador Base Board
+ *
+ * Copyright (c) 2019-2020 Matheus Castello
+ */
+
+/dts-v1/;
+
+#include "owl-s500-labrador-v2.dtsi"
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
index 000000000000..0b54f1ef3ec0
--- /dev/null
+++ b/arch/arm/boot/dts/owl-s500-labrador-v2.dtsi
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Caninos Labrador CoM V2
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

