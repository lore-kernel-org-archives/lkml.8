Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB9CC35248
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637822082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgA3IyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 03:54:18 -0500
Received: from mga06.intel.com ([134.134.136.31]:47265 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbgA3IyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 03:54:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 00:54:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,381,1574150400"; 
   d="scan'208";a="376991371"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga004.jf.intel.com with ESMTP; 30 Jan 2020 00:54:14 -0800
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        yixin.zhu@linux.intel.com, cheol.yong.kim@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v3 2/2] dt-bindings: clk: intel: Add bindings document & header file for a new clock driver
Date:   Thu, 30 Jan 2020 16:54:01 +0800
Message-Id: <1c4b7a999f47df4214a60971e27fa9311c8c64b4.1580373142.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1580373142.git.rahul.tanwar@linux.intel.com>
References: <cover.1580373142.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1580373142.git.rahul.tanwar@linux.intel.com>
References: <cover.1580373142.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock generation unit(CGU) is a clock controller IP of Intel's Lightning
Mountain(LGM) SoC. Add DT bindings include file and document for CGU clock
controller driver of LGM.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 .../devicetree/bindings/clock/intel,cgu-lgm.yaml   |  40 +++++
 include/dt-bindings/clock/intel,lgm-clk.h          | 165 +++++++++++++++++++++
 2 files changed, 205 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml
 create mode 100644 include/dt-bindings/clock/intel,lgm-clk.h

diff --git a/Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml b/Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml
new file mode 100644
index 000000000000..e9649fe75435
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/clock/intel,cgu-lgm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel Lightning Mountain SoC's Clock Controller(CGU) Binding
+
+maintainers:
+  - Rahul Tanwar <rahul.tanwar@linux.intel.com>
+
+description: |
+  Lightning Mountain(LGM) SoC's Clock Generation Unit(CGU) driver provides
+  all means to access the CGU hardware module in order to generate a series
+  of clocks for the whole system and individual peripherals.
+
+properties:
+  compatible:
+    const: intel,cgu-lgm
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+examples:
+  - |
+    cgu: clock-controller@e0200000 {
+        compatible = "intel,cgu-lgm";
+        reg = <0xe0200000 0x33c>;
+        #clock-cells = <1>;
+    };
+
+...
diff --git a/include/dt-bindings/clock/intel,lgm-clk.h b/include/dt-bindings/clock/intel,lgm-clk.h
new file mode 100644
index 000000000000..d6797521d36a
--- /dev/null
+++ b/include/dt-bindings/clock/intel,lgm-clk.h
@@ -0,0 +1,165 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2018 Intel Corporation.
+ * Lei Chuanhua <Chuanhua.lei@intel.com>
+ * Zhu Yixin <Yixin.zhu@intel.com>
+ */
+#ifndef __INTEL_LGM_CLK_H
+#define __INTEL_LGM_CLK_H
+
+/* PLL clocks */
+#define LGM_CLK_OSC		1
+#define LGM_CLK_PLLPP		2
+#define LGM_CLK_PLL2		3
+#define LGM_CLK_PLL0CZ		4
+#define LGM_CLK_PLL0B		5
+#define LGM_CLK_PLL1		6
+#define LGM_CLK_LJPLL3		7
+#define LGM_CLK_LJPLL4		8
+#define LGM_CLK_PLL0CM0		9
+#define LGM_CLK_PLL0CM1		10
+
+/* clocks from PLLs */
+
+/* ROPLL clocks */
+#define LGM_CLK_PP_HW		15
+#define LGM_CLK_PP_UC		16
+#define LGM_CLK_PP_FXD		17
+#define LGM_CLK_PP_TBM		18
+
+/* PLL2 clocks */
+#define LGM_CLK_DDR		20
+
+/* PLL0CZ */
+#define LGM_CLK_CM		25
+#define LGM_CLK_IC		26
+#define LGM_CLK_SDXC3		27
+
+/* PLL0B */
+#define LGM_CLK_NGI		30
+#define LGM_CLK_NOC4		31
+#define LGM_CLK_SW		32
+#define LGM_CLK_QSPI		33
+#define LGM_CLK_CQEM		LGM_CLK_SW
+#define LGM_CLK_EMMC5		LGM_CLK_NOC4
+
+/* PLL1 */
+#define LGM_CLK_CT		35
+#define LGM_CLK_DSP		36
+#define LGM_CLK_VIF		37
+
+/* LJPLL3 */
+#define LGM_CLK_CML		40
+#define LGM_CLK_SERDES		41
+#define LGM_CLK_POOL		42
+#define LGM_CLK_PTP		43
+
+/* LJPLL4 */
+#define LGM_CLK_PCIE		45
+#define LGM_CLK_SATA		LGM_CLK_PCIE
+
+/* PLL0CM0 */
+#define LGM_CLK_CPU0		50
+
+/* PLL0CM1 */
+#define LGM_CLK_CPU1		55
+
+/* Miscellaneous clocks */
+#define LGM_CLK_EMMC4		60
+#define LGM_CLK_SDXC2		61
+#define LGM_CLK_EMMC		62
+#define LGM_CLK_SDXC		63
+#define LGM_CLK_SLIC		64
+#define LGM_CLK_DCL		65
+#define LGM_CLK_DOCSIS		66
+#define LGM_CLK_PCM		67
+#define LGM_CLK_DDR_PHY		68
+#define LGM_CLK_PONDEF		69
+#define LGM_CLK_PL25M		70
+#define LGM_CLK_PL10M		71
+#define LGM_CLK_PL1544K		72
+#define LGM_CLK_PL2048K		73
+#define LGM_CLK_PL8K		74
+#define LGM_CLK_PON_NTR		75
+#define LGM_CLK_SYNC0		76
+#define LGM_CLK_SYNC1		77
+#define LGM_CLK_PROGDIV		78
+#define LGM_CLK_OD0		79
+#define LGM_CLK_OD1		80
+#define LGM_CLK_CBPHY0		81
+#define LGM_CLK_CBPHY1		82
+#define LGM_CLK_CBPHY2		83
+#define LGM_CLK_CBPHY3		84
+
+/* Gate clocks */
+/* Gate CLK0 */
+#define LGM_GCLK_C55		100
+#define LGM_GCLK_QSPI		101
+#define LGM_GCLK_EIP197		102
+#define LGM_GCLK_VAULT		103
+#define LGM_GCLK_TOE		104
+#define LGM_GCLK_SDXC		105
+#define LGM_GCLK_EMMC		106
+#define LGM_GCLK_SPI_DBG	107
+#define LGM_GCLK_DMA3		108
+
+/* Gate CLK1 */
+#define LGM_GCLK_DMA0		120
+#define LGM_GCLK_LEDC0		121
+#define LGM_GCLK_LEDC1		122
+#define LGM_GCLK_I2S0		123
+#define LGM_GCLK_I2S1		124
+#define LGM_GCLK_EBU		125
+#define LGM_GCLK_PWM		126
+#define LGM_GCLK_I2C0		127
+#define LGM_GCLK_I2C1		128
+#define LGM_GCLK_I2C2		129
+#define LGM_GCLK_I2C3		130
+#define LGM_GCLK_SSC0		131
+#define LGM_GCLK_SSC1		132
+#define LGM_GCLK_SSC2		133
+#define LGM_GCLK_SSC3		134
+#define LGM_GCLK_GPTC0		135
+#define LGM_GCLK_GPTC1		136
+#define LGM_GCLK_GPTC2		137
+#define LGM_GCLK_GPTC3		138
+#define LGM_GCLK_ASC0		139
+#define LGM_GCLK_ASC1		140
+#define LGM_GCLK_ASC2		141
+#define LGM_GCLK_ASC3		142
+#define LGM_GCLK_PCM0		143
+#define LGM_GCLK_PCM1		144
+#define LGM_GCLK_PCM2		145
+
+/* Gate CLK2 */
+#define LGM_GCLK_PCIE10		150
+#define LGM_GCLK_PCIE11		151
+#define LGM_GCLK_PCIE30		152
+#define LGM_GCLK_PCIE31		153
+#define LGM_GCLK_PCIE20		154
+#define LGM_GCLK_PCIE21		155
+#define LGM_GCLK_PCIE40		156
+#define LGM_GCLK_PCIE41		157
+#define LGM_GCLK_XPCS0		158
+#define LGM_GCLK_XPCS1		159
+#define LGM_GCLK_XPCS2		160
+#define LGM_GCLK_XPCS3		161
+#define LGM_GCLK_SATA0		162
+#define LGM_GCLK_SATA1		163
+#define LGM_GCLK_SATA2		164
+#define LGM_GCLK_SATA3		165
+
+/* Gate CLK3 */
+#define LGM_GCLK_ARCEM4		170
+#define LGM_GCLK_IDMAR1		171
+#define LGM_GCLK_IDMAT0		172
+#define LGM_GCLK_IDMAT1		173
+#define LGM_GCLK_IDMAT2		174
+#define LGM_GCLK_PPV4		175
+#define LGM_GCLK_GSWIPO		176
+#define LGM_GCLK_CQEM		177
+#define LGM_GCLK_XPCS5		178
+#define LGM_GCLK_USB1		179
+#define LGM_GCLK_USB2		180
+
+#endif /* __INTEL_LGM_CLK_H */
-- 
2.11.0

