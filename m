Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729B9C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A29E2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQftE4Fs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgCDH2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:28:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43125 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725271AbgCDH2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 02:28:31 -0500
Received: by mail-pg1-f193.google.com with SMTP id u12so556996pgb.10;
        Tue, 03 Mar 2020 23:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SKaKKOwbVvUzJRthPD3C+eqKdYtX8gC7Qngg2fLVFko=;
        b=uQftE4Fs7rqOb170yUztSHtfXKlM+PGvmhSrhP/RgFlFIvdyf/RPZDFOVMzoLWjjxk
         Y1llyhmjX1bu7E5Z8fTrdr8XoudXZaoxkTBiEHoFIH8FFtwF8/xnpenT3ldi1a0sS++K
         BVp4RW0VAqolXu5bu4IB+n2fZ8WHXH6RTNTUIC3yEPTHseVjYMI/d58tNumQ3iQyUrxd
         Q6ASlcbndZ9gmbKOVJVwVuo757CEXJpvbj+1sxaV+A76wJ1n3idmoOQH2tYI/pNAqFrD
         oUtRrzk5qj7p6w6dAKPyg7whsP1Kd3xaMT7Fv6E2BfFddOOCCy2wf6o5vj/VVq5IyMTT
         XhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SKaKKOwbVvUzJRthPD3C+eqKdYtX8gC7Qngg2fLVFko=;
        b=qfSrz4uXyOOl0eGUVGu/SPkvEZUypObmENUyqmNZvLXkkKqqXjO/bxlCC6oAF99mxb
         LG2zgNSmBIzEqVPDOyNc2liQhG9ON6zdNIoM6RvdoVpFgpDzTPcXoB8QOrGnWeedcHdE
         ElbM35msV4zR6oGCnzRFey0qchVPjy/M/NIzQq1CtEIjL1mUQZhxE2FTeTKthU0YLW6x
         3ZAOQrI4PDfv1EFAo9IxlXB/JJR/RMJFcuw8Y7TUSc5fBpXyRQ+ar+ZGOCBmeOiP7nam
         KjOdgkhQfwjdjducV5pmPGJGxbVYhPEVk4hU0VQTaEFeC9Qissnx2LwJ39YD57tYG4dM
         qG5Q==
X-Gm-Message-State: ANhLgQ2RCMP461hPDkcHOW7GfVB6phlS0MUhG0UAOwTAgJLdTFjOqFV6
        ZYS5pJkUTuuAHfvhc0nhi28=
X-Google-Smtp-Source: ADFU+vsSM5WWdmtMppdokwQTrLYgSA69OfmS/3yYbFWChrmWpG9on+IqGOz0ZVXO33zAk9Dfx1SIfw==
X-Received: by 2002:a63:6203:: with SMTP id w3mr1404835pgb.35.1583306909314;
        Tue, 03 Mar 2020 23:28:29 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j38sm23435859pgi.51.2020.03.03.23.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 23:28:28 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v6 4/7] clk: sprd: Add dt-bindings include file for SC9863A
Date:   Wed,  4 Mar 2020 15:27:27 +0800
Message-Id: <20200304072730.9193-5-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304072730.9193-1-zhang.lyra@gmail.com>
References: <20200304072730.9193-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

This file defines all SC9863A clock indexes, it should be included in the
device tree in which there's device using the clocks.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/clock/sprd,sc9863a-clk.h | 334 +++++++++++++++++++
 1 file changed, 334 insertions(+)
 create mode 100644 include/dt-bindings/clock/sprd,sc9863a-clk.h

diff --git a/include/dt-bindings/clock/sprd,sc9863a-clk.h b/include/dt-bindings/clock/sprd,sc9863a-clk.h
new file mode 100644
index 000000000000..901ba59676c2
--- /dev/null
+++ b/include/dt-bindings/clock/sprd,sc9863a-clk.h
@@ -0,0 +1,334 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Unisoc SC9863A platform clocks
+ *
+ * Copyright (C) 2019, Unisoc Communications Inc.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SC9863A_H_
+#define _DT_BINDINGS_CLK_SC9863A_H_
+
+#define CLK_MPLL0_GATE		0
+#define CLK_DPLL0_GATE		1
+#define CLK_LPLL_GATE		2
+#define CLK_GPLL_GATE		3
+#define CLK_DPLL1_GATE		4
+#define CLK_MPLL1_GATE		5
+#define CLK_MPLL2_GATE		6
+#define CLK_ISPPLL_GATE		7
+#define CLK_PMU_APB_NUM		(CLK_ISPPLL_GATE + 1)
+
+#define CLK_AUDIO_GATE		0
+#define CLK_RPLL		1
+#define CLK_RPLL_390M		2
+#define CLK_RPLL_260M		3
+#define CLK_RPLL_195M		4
+#define CLK_RPLL_26M		5
+#define CLK_ANLG_PHY_G5_NUM	(CLK_RPLL_26M + 1)
+
+#define CLK_TWPLL		0
+#define CLK_TWPLL_768M		1
+#define CLK_TWPLL_384M		2
+#define CLK_TWPLL_192M		3
+#define CLK_TWPLL_96M		4
+#define CLK_TWPLL_48M		5
+#define CLK_TWPLL_24M		6
+#define CLK_TWPLL_12M		7
+#define CLK_TWPLL_512M		8
+#define CLK_TWPLL_256M		9
+#define CLK_TWPLL_128M		10
+#define CLK_TWPLL_64M		11
+#define CLK_TWPLL_307M2		12
+#define CLK_TWPLL_219M4		13
+#define CLK_TWPLL_170M6		14
+#define CLK_TWPLL_153M6		15
+#define CLK_TWPLL_76M8		16
+#define CLK_TWPLL_51M2		17
+#define CLK_TWPLL_38M4		18
+#define CLK_TWPLL_19M2		19
+#define CLK_LPLL		20
+#define CLK_LPLL_409M6		21
+#define CLK_LPLL_245M76		22
+#define CLK_GPLL		23
+#define CLK_ISPPLL		24
+#define CLK_ISPPLL_468M		25
+#define CLK_ANLG_PHY_G1_NUM	(CLK_ISPPLL_468M + 1)
+
+#define CLK_DPLL0		0
+#define CLK_DPLL1		1
+#define CLK_DPLL0_933M		2
+#define CLK_DPLL0_622M3		3
+#define CLK_DPLL0_400M		4
+#define CLK_DPLL0_266M7		5
+#define CLK_DPLL0_123M1		6
+#define CLK_DPLL0_50M		7
+#define CLK_ANLG_PHY_G7_NUM	(CLK_DPLL0_50M + 1)
+
+#define CLK_MPLL0		0
+#define CLK_MPLL1		1
+#define CLK_MPLL2		2
+#define CLK_MPLL2_675M		3
+#define CLK_ANLG_PHY_G4_NUM	(CLK_MPLL2_675M + 1)
+
+#define CLK_AP_APB		0
+#define CLK_AP_CE		1
+#define CLK_NANDC_ECC		2
+#define CLK_NANDC_26M		3
+#define CLK_EMMC_32K		4
+#define CLK_SDIO0_32K		5
+#define CLK_SDIO1_32K		6
+#define CLK_SDIO2_32K		7
+#define CLK_OTG_UTMI		8
+#define CLK_AP_UART0		9
+#define CLK_AP_UART1		10
+#define CLK_AP_UART2		11
+#define CLK_AP_UART3		12
+#define CLK_AP_UART4		13
+#define CLK_AP_I2C0		14
+#define CLK_AP_I2C1		15
+#define CLK_AP_I2C2		16
+#define CLK_AP_I2C3		17
+#define CLK_AP_I2C4		18
+#define CLK_AP_I2C5		19
+#define CLK_AP_I2C6		20
+#define CLK_AP_SPI0		21
+#define CLK_AP_SPI1		22
+#define CLK_AP_SPI2		23
+#define CLK_AP_SPI3		24
+#define CLK_AP_IIS0		25
+#define CLK_AP_IIS1		26
+#define CLK_AP_IIS2		27
+#define CLK_SIM0		28
+#define CLK_SIM0_32K		29
+#define CLK_AP_CLK_NUM		(CLK_SIM0_32K + 1)
+
+#define CLK_13M			0
+#define CLK_6M5			1
+#define CLK_4M3			2
+#define CLK_2M			3
+#define CLK_250K		4
+#define CLK_RCO_25M		5
+#define CLK_RCO_4M		6
+#define CLK_RCO_2M		7
+#define CLK_EMC			8
+#define CLK_AON_APB		9
+#define CLK_ADI			10
+#define CLK_AUX0		11
+#define CLK_AUX1		12
+#define CLK_AUX2		13
+#define CLK_PROBE		14
+#define CLK_PWM0		15
+#define CLK_PWM1		16
+#define CLK_PWM2		17
+#define CLK_AON_THM		18
+#define CLK_AUDIF		19
+#define CLK_CPU_DAP		20
+#define CLK_CPU_TS		21
+#define CLK_DJTAG_TCK		22
+#define CLK_EMC_REF		23
+#define CLK_CSSYS		24
+#define CLK_AON_PMU		25
+#define CLK_PMU_26M		26
+#define CLK_AON_TMR		27
+#define CLK_POWER_CPU		28
+#define CLK_AP_AXI		29
+#define CLK_SDIO0_2X		30
+#define CLK_SDIO1_2X		31
+#define CLK_SDIO2_2X		32
+#define CLK_EMMC_2X		33
+#define CLK_DPU			34
+#define CLK_DPU_DPI		35
+#define CLK_OTG_REF		36
+#define CLK_SDPHY_APB		37
+#define CLK_ALG_IO_APB		38
+#define CLK_GPU_CORE		39
+#define CLK_GPU_SOC		40
+#define CLK_MM_EMC		41
+#define CLK_MM_AHB		42
+#define CLK_BPC			43
+#define CLK_DCAM_IF		44
+#define CLK_ISP			45
+#define CLK_JPG			46
+#define CLK_CPP			47
+#define CLK_SENSOR0		48
+#define CLK_SENSOR1		49
+#define CLK_SENSOR2		50
+#define CLK_MM_VEMC		51
+#define CLK_MM_VAHB		52
+#define CLK_VSP			53
+#define CLK_CORE0		54
+#define CLK_CORE1		55
+#define CLK_CORE2		56
+#define CLK_CORE3		57
+#define CLK_CORE4		58
+#define CLK_CORE5		59
+#define CLK_CORE6		60
+#define CLK_CORE7		61
+#define CLK_SCU			62
+#define CLK_ACE			63
+#define CLK_AXI_PERIPH		64
+#define CLK_AXI_ACP		65
+#define CLK_ATB			66
+#define CLK_DEBUG_APB		67
+#define CLK_GIC			68
+#define CLK_PERIPH		69
+#define CLK_AON_CLK_NUM		(CLK_VSP + 1)
+
+#define CLK_OTG_EB		0
+#define CLK_DMA_EB		1
+#define CLK_CE_EB		2
+#define CLK_NANDC_EB		3
+#define CLK_SDIO0_EB		4
+#define CLK_SDIO1_EB		5
+#define CLK_SDIO2_EB		6
+#define CLK_EMMC_EB		7
+#define CLK_EMMC_32K_EB		8
+#define CLK_SDIO0_32K_EB	9
+#define CLK_SDIO1_32K_EB	10
+#define CLK_SDIO2_32K_EB	11
+#define CLK_NANDC_26M_EB	12
+#define CLK_DMA_EB2		13
+#define CLK_CE_EB2		14
+#define CLK_AP_AHB_GATE_NUM	(CLK_CE_EB2 + 1)
+
+#define CLK_GPIO_EB		0
+#define CLK_PWM0_EB		1
+#define CLK_PWM1_EB		2
+#define CLK_PWM2_EB		3
+#define CLK_PWM3_EB		4
+#define CLK_KPD_EB		5
+#define CLK_AON_SYST_EB		6
+#define CLK_AP_SYST_EB		7
+#define CLK_AON_TMR_EB		8
+#define CLK_EFUSE_EB		9
+#define CLK_EIC_EB		10
+#define CLK_INTC_EB		11
+#define CLK_ADI_EB		12
+#define CLK_AUDIF_EB		13
+#define CLK_AUD_EB		14
+#define CLK_VBC_EB		15
+#define CLK_PIN_EB		16
+#define CLK_AP_WDG_EB		17
+#define CLK_MM_EB		18
+#define CLK_AON_APB_CKG_EB	19
+#define CLK_CA53_TS0_EB		20
+#define CLK_CA53_TS1_EB		21
+#define CLK_CS53_DAP_EB		22
+#define CLK_PMU_EB		23
+#define CLK_THM_EB		24
+#define CLK_AUX0_EB		25
+#define CLK_AUX1_EB		26
+#define CLK_AUX2_EB		27
+#define CLK_PROBE_EB		28
+#define CLK_EMC_REF_EB		29
+#define CLK_CA53_WDG_EB		30
+#define CLK_AP_TMR1_EB		31
+#define CLK_AP_TMR2_EB		32
+#define CLK_DISP_EMC_EB		33
+#define CLK_ZIP_EMC_EB		34
+#define CLK_GSP_EMC_EB		35
+#define CLK_MM_VSP_EB		36
+#define CLK_MDAR_EB		37
+#define CLK_RTC4M0_CAL_EB	38
+#define CLK_RTC4M1_CAL_EB	39
+#define CLK_DJTAG_EB		40
+#define CLK_MBOX_EB		41
+#define CLK_AON_DMA_EB		42
+#define CLK_AON_APB_DEF_EB	43
+#define CLK_CA5_TS0_EB		44
+#define CLK_DBG_EB		45
+#define CLK_DBG_EMC_EB		46
+#define CLK_CROSS_TRIG_EB	47
+#define CLK_SERDES_DPHY_EB	48
+#define CLK_ARCH_RTC_EB		49
+#define CLK_KPD_RTC_EB		50
+#define CLK_AON_SYST_RTC_EB	51
+#define CLK_AP_SYST_RTC_EB	52
+#define CLK_AON_TMR_RTC_EB	53
+#define CLK_AP_TMR0_RTC_EB	54
+#define CLK_EIC_RTC_EB		55
+#define CLK_EIC_RTCDV5_EB	56
+#define CLK_AP_WDG_RTC_EB	57
+#define CLK_CA53_WDG_RTC_EB	58
+#define CLK_THM_RTC_EB		59
+#define CLK_ATHMA_RTC_EB	60
+#define CLK_GTHMA_RTC_EB	61
+#define CLK_ATHMA_RTC_A_EB	62
+#define CLK_GTHMA_RTC_A_EB	63
+#define CLK_AP_TMR1_RTC_EB	64
+#define CLK_AP_TMR2_RTC_EB	65
+#define CLK_DXCO_LC_RTC_EB	66
+#define CLK_BB_CAL_RTC_EB	67
+#define CLK_GNU_EB		68
+#define CLK_DISP_EB		69
+#define CLK_MM_EMC_EB		70
+#define CLK_POWER_CPU_EB	71
+#define CLK_HW_I2C_EB		72
+#define CLK_MM_VSP_EMC_EB	73
+#define CLK_VSP_EB		74
+#define CLK_CSSYS_EB		75
+#define CLK_DMC_EB		76
+#define CLK_ROSC_EB		77
+#define CLK_S_D_CFG_EB		78
+#define CLK_S_D_REF_EB		79
+#define CLK_B_DMA_EB		80
+#define CLK_ANLG_EB		81
+#define CLK_ANLG_APB_EB		82
+#define CLK_BSMTMR_EB		83
+#define CLK_AP_AXI_EB		84
+#define CLK_AP_INTC0_EB		85
+#define CLK_AP_INTC1_EB		86
+#define CLK_AP_INTC2_EB		87
+#define CLK_AP_INTC3_EB		88
+#define CLK_AP_INTC4_EB		89
+#define CLK_AP_INTC5_EB		90
+#define CLK_SCC_EB		91
+#define CLK_DPHY_CFG_EB		92
+#define CLK_DPHY_REF_EB		93
+#define CLK_CPHY_CFG_EB		94
+#define CLK_OTG_REF_EB		95
+#define CLK_SERDES_EB		96
+#define CLK_AON_AP_EMC_EB	97
+#define CLK_AON_APB_GATE_NUM	(CLK_AON_AP_EMC_EB + 1)
+
+#define CLK_MAHB_CKG_EB		0
+#define CLK_MDCAM_EB		1
+#define CLK_MISP_EB		2
+#define CLK_MAHBCSI_EB		3
+#define CLK_MCSI_S_EB		4
+#define CLK_MCSI_T_EB		5
+#define CLK_DCAM_AXI_EB		6
+#define CLK_ISP_AXI_EB		7
+#define CLK_MCSI_EB		8
+#define CLK_MCSI_S_CKG_EB	9
+#define CLK_MCSI_T_CKG_EB	10
+#define CLK_SENSOR0_EB		11
+#define CLK_SENSOR1_EB		12
+#define CLK_SENSOR2_EB		13
+#define CLK_MCPHY_CFG_EB	14
+#define CLK_MM_GATE_NUM		(CLK_MCPHY_CFG_EB + 1)
+
+#define CLK_SIM0_EB		0
+#define CLK_IIS0_EB		1
+#define CLK_IIS1_EB		2
+#define CLK_IIS2_EB		3
+#define CLK_SPI0_EB		4
+#define CLK_SPI1_EB		5
+#define CLK_SPI2_EB		6
+#define CLK_I2C0_EB		7
+#define CLK_I2C1_EB		8
+#define CLK_I2C2_EB		9
+#define CLK_I2C3_EB		10
+#define CLK_I2C4_EB		11
+#define CLK_UART0_EB		12
+#define CLK_UART1_EB		13
+#define CLK_UART2_EB		14
+#define CLK_UART3_EB		15
+#define CLK_UART4_EB		16
+#define CLK_SIM0_32K_EB		17
+#define CLK_SPI3_EB		18
+#define CLK_I2C5_EB		19
+#define CLK_I2C6_EB		20
+#define CLK_AP_APB_GATE_NUM	(CLK_I2C6_EB + 1)
+
+#endif /* _DT_BINDINGS_CLK_SC9863A_H_ */
-- 
2.20.1

