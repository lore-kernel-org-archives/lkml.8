Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFD1C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 12:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62F56206EF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 12:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgICMgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 08:36:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48950 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728565AbgICM2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 08:28:40 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7C657E04B63EC1F09FCD;
        Thu,  3 Sep 2020 20:28:32 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Sep 2020 20:28:24 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 3/3] ARM: dts: add SD5203 dts
Date:   Thu, 3 Sep 2020 20:27:34 +0800
Message-ID: <20200903122734.2369-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200903122734.2369-1-thunder.leizhen@huawei.com>
References: <20200903122734.2369-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

Add sd5203.dts for Hisilicon SD5203 SoC platform.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/boot/dts/Makefile   |  2 +
 arch/arm/boot/dts/sd5203.dts | 90 ++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 arch/arm/boot/dts/sd5203.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4572db3fa5ae..1d1262df5c55 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -357,6 +357,8 @@ dtb-$(CONFIG_ARCH_MPS2) += \
 	mps2-an399.dtb
 dtb-$(CONFIG_ARCH_MOXART) += \
 	moxart-uc7112lx.dtb
+dtb-$(CONFIG_ARCH_SD5203) += \
+	sd5203.dtb
 dtb-$(CONFIG_SOC_IMX1) += \
 	imx1-ads.dtb \
 	imx1-apf9328.dtb
diff --git a/arch/arm/boot/dts/sd5203.dts b/arch/arm/boot/dts/sd5203.dts
new file mode 100644
index 000000000000..99da46072f72
--- /dev/null
+++ b/arch/arm/boot/dts/sd5203.dts
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020 Hisilicon Limited.
+ *
+ * DTS file for Hisilicon SD5203 Board
+ */
+
+/dts-v1/;
+
+/ {
+	model = "Hisilicon SD5203";
+	compatible = "hisilicon,sd5203";
+	interrupt-parent = <&vic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	chosen {
+		bootargs="console=ttyS0,9600 earlycon=uart8250,mmio32,0x1600d000";
+	};
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	cpu {
+		compatible = "arm,arm926ej-s";
+		device_type = "cpu";
+	};
+
+	memory@30000000 {
+		device_type = "memory";
+		reg = <0x30000000 0x8000000>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+
+		vic: interrupt-controller@10130000 {
+			compatible = "hisilicon,sd5203-vic";
+			reg = <0x10130000 0x1000>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		refclk125mhz: refclk125mhz {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <125000000>;
+		};
+
+		timer0: timer@16002000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x16002000 0x1000>;
+			interrupts = <4>;
+			clocks = <&refclk125mhz>;
+			clock-names = "apb_pclk";
+		};
+
+		timer1: timer@16003000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x16003000 0x1000>;
+			interrupts = <5>;
+			clocks = <&refclk125mhz>;
+			clock-names = "apb_pclk";
+		};
+
+		uart0: serial@1600D000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x1600D000 0x1000>;
+			bus_id = "uart0";
+			clocks = <&refclk125mhz>;
+			clock-names = "apb_pclk";
+			reg-shift = <2>;
+			interrupts = <17>;
+		};
+
+		uart1: serial@1600C000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x1600C000 0x1000>;
+			clocks = <&refclk125mhz>;
+			clock-names = "apb_pclk";
+			reg-shift = <2>;
+			interrupts = <16>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.26.0.106.g9fadedd


