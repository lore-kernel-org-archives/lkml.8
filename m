Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8957DC10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DC820828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583774235;
	bh=hLg6mb0PPdCQMLVFNOOaqWYFTPhbmH5go/QVWRE8B/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0bAia2MfjNxHe8lQMh7s1mwY/4LQp8e9Yplnoht5CNJHwSJ889Z2kg0NqbDd/Abr/
	 gAcZyBMDSxoLUNnFfLlpwDLEyRg/razW00kf0bjtzAAsFr9MrrJQkIBgZupJ9z+FL4
	 DEIydQfxbZblX2ZXwr9P+oJAM5K3wvytkh96yorM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgCIRRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 13:17:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbgCIRRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 13:17:06 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A7D92253D;
        Mon,  9 Mar 2020 17:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583774225;
        bh=hLg6mb0PPdCQMLVFNOOaqWYFTPhbmH5go/QVWRE8B/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZnyymLfjm89RwOQLNRfB94an7z6VteWYJ3lWWXUfl4twWFVvRpLB41/5aO0hAxLGl
         Yr82+8zGpK2kh02ggQtkka5hosOAMj2Z0ScmqlR3/1T+xMdwSmvIo+wMTT7lyfE4e2
         h485OlhZIpNyRDUQzjZJtsjkWVbwmsgwCRAdnWz4=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-clk@vger.kernel.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com
Subject: [PATCHv2 2/3] dt-bindings: documentation: add clock bindings information for Agilex
Date:   Mon,  9 Mar 2020 12:16:52 -0500
Message-Id: <20200309171653.27630-3-dinguyen@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309171653.27630-1-dinguyen@kernel.org>
References: <20200309171653.27630-1-dinguyen@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Agilex clock bindings, and add the clock header file. The
clock header is an enumeration of all the different clocks on the Agilex
platform.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v2: convert original document to YAML
---
 .../bindings/clock/intc,agilex.yaml           | 79 +++++++++++++++++++
 include/dt-bindings/clock/agilex-clock.h      | 70 ++++++++++++++++
 2 files changed, 149 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/intc,agilex.yaml
 create mode 100644 include/dt-bindings/clock/agilex-clock.h

diff --git a/Documentation/devicetree/bindings/clock/intc,agilex.yaml b/Documentation/devicetree/bindings/clock/intc,agilex.yaml
new file mode 100644
index 000000000000..bd5c4f590e12
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/intc,agilex.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/intc,agilex.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel SoCFPGA Agilex platform clock controller binding
+
+maintainers:
+  - Dinh Nguyen <dinguyen@kernel.org>
+
+description: |
+  The Intel Agilex Clock controller is an integrated clock controller, which
+  generates and supplies to all modules.
+
+  This binding uses the common clock binding[1].
+  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - intel,agilex-clkmgr
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
+  # Clock controller node
+  - |
+	clkmgr: clock-controller@ffd10000 {
+		compatible = "intel,agilex-clkmgr";
+		reg = <0xffd10000 0x1000>;
+		#clock-cells = <1>;
+	};
+
+  # External clocks
+  - |
+    clocks {
+       cb_intosc_hs_div2_clk: cb-intosc-hs-div2-clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		};
+
+	cb_intosc_ls_clk: cb-intosc-ls-clk {
+		#clock-cells = <0>;
+			compatible = "fixed-clock";
+		};
+
+	f2s_free_clk: f2s-free-clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		};
+
+	osc1: osc1 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+	};
+    };
+
+  # The clock consumer shall specify the desired clock-output of the clock
+  # controller as below by specifying output-id in its "clk" phandle cell.
+  - |
+    i2c0: i2c@ffc02800 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "snps,designware-i2c";
+	reg = <0xffc02800 0x100>;
+	interrupts = <0 103 4>;
+	resets = <&rst I2C0_RESET>;
+	clocks = <&clkmgr AGILEX_L4_SP_CLK>;
+	};
+...
diff --git a/include/dt-bindings/clock/agilex-clock.h b/include/dt-bindings/clock/agilex-clock.h
new file mode 100644
index 000000000000..f19cf8ccbdd2
--- /dev/null
+++ b/include/dt-bindings/clock/agilex-clock.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019, Intel Corporation
+ */
+
+#ifndef __AGILEX_CLOCK_H
+#define __AGILEX_CLOCK_H
+
+/* fixed rate clocks */
+#define AGILEX_OSC1			0
+#define AGILEX_CB_INTOSC_HS_DIV2_CLK	1
+#define AGILEX_CB_INTOSC_LS_CLK		2
+#define AGILEX_L4_SYS_FREE_CLK		3
+#define AGILEX_F2S_FREE_CLK		4
+
+/* PLL clocks */
+#define AGILEX_MAIN_PLL_CLK		5
+#define AGILEX_MAIN_PLL_C0_CLK		6
+#define AGILEX_MAIN_PLL_C1_CLK		7
+#define AGILEX_MAIN_PLL_C2_CLK		8
+#define AGILEX_MAIN_PLL_C3_CLK		9
+#define AGILEX_PERIPH_PLL_CLK		10
+#define AGILEX_PERIPH_PLL_C0_CLK	11
+#define AGILEX_PERIPH_PLL_C1_CLK	12
+#define AGILEX_PERIPH_PLL_C2_CLK	13
+#define AGILEX_PERIPH_PLL_C3_CLK	14
+#define AGILEX_MPU_FREE_CLK		15
+#define AGILEX_MPU_CCU_CLK		16
+#define AGILEX_BOOT_CLK			17
+
+/* fixed factor clocks */
+#define AGILEX_L3_MAIN_FREE_CLK		18
+#define AGILEX_NOC_FREE_CLK		19
+#define AGILEX_S2F_USR0_CLK		20
+#define AGILEX_NOC_CLK			21
+#define AGILEX_EMAC_A_FREE_CLK		22
+#define AGILEX_EMAC_B_FREE_CLK		23
+#define AGILEX_EMAC_PTP_FREE_CLK	24
+#define AGILEX_GPIO_DB_FREE_CLK		25
+#define AGILEX_SDMMC_FREE_CLK		26
+#define AGILEX_S2F_USER0_FREE_CLK	27
+#define AGILEX_S2F_USER1_FREE_CLK	28
+#define AGILEX_PSI_REF_FREE_CLK		29
+
+/* Gate clocks */
+#define AGILEX_MPU_CLK			30
+#define AGILEX_MPU_L2RAM_CLK		31
+#define AGILEX_MPU_PERIPH_CLK		32
+#define AGILEX_L4_MAIN_CLK		33
+#define AGILEX_L4_MP_CLK		34
+#define AGILEX_L4_SP_CLK		35
+#define AGILEX_CS_AT_CLK		36
+#define AGILEX_CS_TRACE_CLK		37
+#define AGILEX_CS_PDBG_CLK		38
+#define AGILEX_CS_TIMER_CLK		39
+#define AGILEX_S2F_USER0_CLK		40
+#define AGILEX_EMAC0_CLK		41
+#define AGILEX_EMAC1_CLK		43
+#define AGILEX_EMAC2_CLK		44
+#define AGILEX_EMAC_PTP_CLK		45
+#define AGILEX_GPIO_DB_CLK		46
+#define AGILEX_NAND_CLK			47
+#define AGILEX_PSI_REF_CLK		48
+#define AGILEX_S2F_USER1_CLK		49
+#define AGILEX_SDMMC_CLK		50
+#define AGILEX_SPI_M_CLK		51
+#define AGILEX_USB_CLK			52
+#define AGILEX_NUM_CLKS			53
+
+#endif	/* __AGILEX_CLOCK_H */
-- 
2.17.1

