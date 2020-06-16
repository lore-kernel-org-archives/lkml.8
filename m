Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52548C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21E292074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAyNYDjW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgFPGOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgFPGNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:13:47 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFACC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:13:46 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f185so1770237wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TDRFP1Ju9xYxuXv34Gg9AzLQw0DY+oO9qOTIzgpakmk=;
        b=YAyNYDjWMv+UT2GmMnPU0RGZinNNFGyGWLNezxAe5xCsa8Uc42QGRELf6gk/kAnDHl
         Jr/NbcJ5q/+lQJR/ktrd7pdFqHBumt2qcMzouAEedyYnWrjxIU1jS57XA+nT5cfPQEak
         1KKboghJNu/s8vQKzFw89e2ofvSNNJOrbfhM1kaECEg+3NrzS3i0cJrwTNQufB2W5ntQ
         oe19pnAkjkTpruzLxCdvuChryM5mGMdxyzP9XHazyofrRLBfpu8x+v17wXKPMJRWCkmD
         W6hkVxctiR6bsud6enOQbGoUVy9e45NRpOXQfmKE91gpVvZWDUbkWq1MoVd0Kg5IEWAU
         sP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TDRFP1Ju9xYxuXv34Gg9AzLQw0DY+oO9qOTIzgpakmk=;
        b=QnM9QF0VQ/AiuaDsvg49Wtt8V/uGVbPqjGfN53x9h8Y8FuoUoWl1LwHHPqnGmSCERS
         2ikZSFX3r8W96wtYFOpAMeV1pQpxNJYDAG4H71ZwcAAeoi8Qx2DAGatm5I/e0lT9bHB9
         r5GJWroUpZPgBgJqEYH3u8tbvZZ92mkOfezfPVO5dCDqH77ZjJIwMogSBijAZ+EyOs8a
         EtvUzSnhw8pBgPJGchgy54wXJqZwElvKNl9pbHQ6JvqLeDg6Gran/yMtqex4AAWzigBw
         cFWgs58fiBVUMn142d6oPMDEM6NCyPoGxGJzIZWGa984dKVTDnrtnJ+FbgaOWUJotRBE
         /z0A==
X-Gm-Message-State: AOAM531weBzYf6CENvvzSI0J4OemWmxGXTgVXQx+bL08MXo5IcqC+yvN
        nmjDywmTKwln21ajDavyVQQN+oqe1ng=
X-Google-Smtp-Source: ABdhPJwGU/KDYgT/qPq+KlV5ALcB9Lv4T5BGStZGuopOR6XDx0I5aV0qH8QQleMievr4TEIJjJXapw==
X-Received: by 2002:a1c:a943:: with SMTP id s64mr1435007wme.103.1592288025116;
        Mon, 15 Jun 2020 23:13:45 -0700 (PDT)
Received: from ODED-MAIN.localdomain ([87.71.142.251])
        by smtp.gmail.com with ESMTPSA id s2sm2354963wmh.15.2020.06.15.23.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 23:13:44 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org, Adam Aharon <aaharon@habana.ai>
Subject: [PATCH 7/7] habanalabs: calculate trace frequency from PLL
Date:   Tue, 16 Jun 2020 09:13:27 +0300
Message-Id: <20200616061327.12006-7-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616061327.12006-1-oded.gabbay@gmail.com>
References: <20200616061327.12006-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Aharon <aaharon@habana.ai>

The profiler needs to know the PLL values for correctly showing the
profiling data. Because our firmware can use different PLL configurations,
we need to read the PLL values from the ASIC to pass them to the profiler.

Signed-off-by: Adam Aharon <aaharon@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c         |  33 ++++-
 .../misc/habanalabs/gaudi/gaudi_coresight.c   |   6 +-
 drivers/misc/habanalabs/goya/goya.c           |  33 ++++-
 drivers/misc/habanalabs/goya/goya_coresight.c |   6 +-
 drivers/misc/habanalabs/habanalabs.h          |  11 ++
 .../include/gaudi/asic_reg/gaudi_regs.h       |   1 +
 .../gaudi/asic_reg/psoc_cpu_pll_regs.h        | 114 ++++++++++++++++++
 7 files changed, 194 insertions(+), 10 deletions(-)
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_cpu_pll_regs.h

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 1ac7eb2498ef..1bde7e6eeb9b 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -555,11 +555,36 @@ static int gaudi_early_fini(struct hl_device *hdev)
 static void gaudi_fetch_psoc_frequency(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u32 trace_freq = 0;
+	u32 pll_clk = 0;
+	u32 div_fctr = RREG32(mmPSOC_CPU_PLL_DIV_FACTOR_2);
+	u32 div_sel = RREG32(mmPSOC_CPU_PLL_DIV_SEL_2);
+	u32 nr = RREG32(mmPSOC_CPU_PLL_NR);
+	u32 nf = RREG32(mmPSOC_CPU_PLL_NF);
+	u32 od = RREG32(mmPSOC_CPU_PLL_OD);
+
+	if (div_sel == DIV_SEL_REF_CLK || div_sel == DIV_SEL_DIVIDED_REF) {
+		if (div_sel == DIV_SEL_REF_CLK)
+			trace_freq = PLL_REF_CLK;
+		else
+			trace_freq = PLL_REF_CLK / (div_fctr + 1);
+	} else if (div_sel == DIV_SEL_PLL_CLK ||
+					div_sel == DIV_SEL_DIVIDED_PLL) {
+		pll_clk = PLL_REF_CLK * (nf + 1) / ((nr + 1) * (od + 1));
+		if (div_sel == DIV_SEL_PLL_CLK)
+			trace_freq = pll_clk;
+		else
+			trace_freq = pll_clk / (div_fctr + 1);
+	} else {
+		dev_warn(hdev->dev,
+			"Received invalid div select value: %d", div_sel);
+	}
 
-	prop->psoc_pci_pll_nr = RREG32(mmPSOC_PCI_PLL_NR);
-	prop->psoc_pci_pll_nf = RREG32(mmPSOC_PCI_PLL_NF);
-	prop->psoc_pci_pll_od = RREG32(mmPSOC_PCI_PLL_OD);
-	prop->psoc_pci_pll_div_factor = RREG32(mmPSOC_PCI_PLL_DIV_FACTOR_1);
+	prop->psoc_timestamp_frequency = trace_freq;
+	prop->psoc_pci_pll_nr = nr;
+	prop->psoc_pci_pll_nf = nf;
+	prop->psoc_pci_pll_od = od;
+	prop->psoc_pci_pll_div_factor = div_fctr;
 }
 
 static int _gaudi_init_tpc_mem(struct hl_device *hdev,
diff --git a/drivers/misc/habanalabs/gaudi/gaudi_coresight.c b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
index bf0e062d7b87..c32322cb1728 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
@@ -392,6 +392,7 @@ static int gaudi_config_stm(struct hl_device *hdev,
 {
 	struct hl_debug_params_stm *input;
 	u64 base_reg;
+	u32 frequency;
 	int rc;
 
 	if (params->reg_idx >= ARRAY_SIZE(debug_stm_regs)) {
@@ -420,7 +421,10 @@ static int gaudi_config_stm(struct hl_device *hdev,
 		WREG32(base_reg + 0xE00, lower_32_bits(input->sp_mask));
 		WREG32(base_reg + 0xEF4, input->id);
 		WREG32(base_reg + 0xDF4, 0x80);
-		WREG32(base_reg + 0xE8C, input->frequency);
+		frequency = hdev->asic_prop.psoc_timestamp_frequency;
+		if (frequency == 0)
+			frequency = input->frequency;
+		WREG32(base_reg + 0xE8C, frequency);
 		WREG32(base_reg + 0xE90, 0x7FF);
 
 		/* SW-2176 - SW WA for HW bug */
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 547fd766667a..6816f6217ee1 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -594,11 +594,36 @@ static void goya_qman0_set_security(struct hl_device *hdev, bool secure)
 static void goya_fetch_psoc_frequency(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u32 trace_freq = 0;
+	u32 pll_clk = 0;
+	u32 div_fctr = RREG32(mmPSOC_PCI_PLL_DIV_FACTOR_1);
+	u32 div_sel = RREG32(mmPSOC_PCI_PLL_DIV_SEL_1);
+	u32 nr = RREG32(mmPSOC_PCI_PLL_NR);
+	u32 nf = RREG32(mmPSOC_PCI_PLL_NF);
+	u32 od = RREG32(mmPSOC_PCI_PLL_OD);
+
+	if (div_sel == DIV_SEL_REF_CLK || div_sel == DIV_SEL_DIVIDED_REF) {
+		if (div_sel == DIV_SEL_REF_CLK)
+			trace_freq = PLL_REF_CLK;
+		else
+			trace_freq = PLL_REF_CLK / (div_fctr + 1);
+	} else if (div_sel == DIV_SEL_PLL_CLK ||
+					div_sel == DIV_SEL_DIVIDED_PLL) {
+		pll_clk = PLL_REF_CLK * (nf + 1) / ((nr + 1) * (od + 1));
+		if (div_sel == DIV_SEL_PLL_CLK)
+			trace_freq = pll_clk;
+		else
+			trace_freq = pll_clk / (div_fctr + 1);
+	} else {
+		dev_warn(hdev->dev,
+			"Received invalid div select value: %d", div_sel);
+	}
 
-	prop->psoc_pci_pll_nr = RREG32(mmPSOC_PCI_PLL_NR);
-	prop->psoc_pci_pll_nf = RREG32(mmPSOC_PCI_PLL_NF);
-	prop->psoc_pci_pll_od = RREG32(mmPSOC_PCI_PLL_OD);
-	prop->psoc_pci_pll_div_factor = RREG32(mmPSOC_PCI_PLL_DIV_FACTOR_1);
+	prop->psoc_timestamp_frequency = trace_freq;
+	prop->psoc_pci_pll_nr = nr;
+	prop->psoc_pci_pll_nf = nf;
+	prop->psoc_pci_pll_od = od;
+	prop->psoc_pci_pll_div_factor = div_fctr;
 }
 
 int goya_late_init(struct hl_device *hdev)
diff --git a/drivers/misc/habanalabs/goya/goya_coresight.c b/drivers/misc/habanalabs/goya/goya_coresight.c
index 1258724ea510..472246e3f4cd 100644
--- a/drivers/misc/habanalabs/goya/goya_coresight.c
+++ b/drivers/misc/habanalabs/goya/goya_coresight.c
@@ -232,6 +232,7 @@ static int goya_config_stm(struct hl_device *hdev,
 {
 	struct hl_debug_params_stm *input;
 	u64 base_reg;
+	u32 frequency;
 	int rc;
 
 	if (params->reg_idx >= ARRAY_SIZE(debug_stm_regs)) {
@@ -264,7 +265,10 @@ static int goya_config_stm(struct hl_device *hdev,
 		WREG32(base_reg + 0xE20, 0xFFFFFFFF);
 		WREG32(base_reg + 0xEF4, input->id);
 		WREG32(base_reg + 0xDF4, 0x80);
-		WREG32(base_reg + 0xE8C, input->frequency);
+		frequency = hdev->asic_prop.psoc_timestamp_frequency;
+		if (frequency == 0)
+			frequency = input->frequency;
+		WREG32(base_reg + 0xE8C, frequency);
 		WREG32(base_reg + 0xE90, 0x7FF);
 		WREG32(base_reg + 0xE80, 0x27 | (input->id << 16));
 	} else {
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 8cd4b55d0608..4e68a41cce77 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -247,6 +247,7 @@ struct hl_mmu_properties {
  * @psoc_pci_pll_nf: PCI PLL NF value.
  * @psoc_pci_pll_od: PCI PLL OD value.
  * @psoc_pci_pll_div_factor: PCI PLL DIV FACTOR 1 value.
+ * @psoc_timestamp_frequency: frequency of the psoc timestamp clock.
  * @high_pll: high PLL frequency used by the device.
  * @cb_pool_cb_cnt: number of CBs in the CB pool.
  * @cb_pool_cb_size: size of each CB in the CB pool.
@@ -291,6 +292,7 @@ struct asic_fixed_properties {
 	u32				psoc_pci_pll_nf;
 	u32				psoc_pci_pll_od;
 	u32				psoc_pci_pll_div_factor;
+	u32				psoc_timestamp_frequency;
 	u32				high_pll;
 	u32				cb_pool_cb_cnt;
 	u32				cb_pool_cb_size;
@@ -533,6 +535,15 @@ enum hl_pll_frequency {
 	PLL_LAST
 };
 
+#define PLL_REF_CLK 50
+
+enum div_select_defs {
+	DIV_SEL_REF_CLK = 0,
+	DIV_SEL_PLL_CLK = 1,
+	DIV_SEL_DIVIDED_REF = 2,
+	DIV_SEL_DIVIDED_PLL = 3,
+};
+
 /**
  * struct hl_asic_funcs - ASIC specific functions that are can be called from
  *                        common code.
diff --git a/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h b/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
index 85e3b5148595..62078077aee5 100644
--- a/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
+++ b/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
@@ -91,6 +91,7 @@
 
 #include "psoc_pci_pll_regs.h"
 #include "psoc_hbm_pll_regs.h"
+#include "psoc_cpu_pll_regs.h"
 
 #define GAUDI_ECC_MEM_SEL_OFFSET	0xF18
 #define GAUDI_ECC_ADDRESS_OFFSET	0xF1C
diff --git a/drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_cpu_pll_regs.h b/drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_cpu_pll_regs.h
new file mode 100644
index 000000000000..2585c70f59ef
--- /dev/null
+++ b/drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_cpu_pll_regs.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+/************************************
+ ** This is an auto-generated file **
+ **       DO NOT EDIT BELOW        **
+ ************************************/
+
+#ifndef ASIC_REG_PSOC_CPU_PLL_REGS_H_
+#define ASIC_REG_PSOC_CPU_PLL_REGS_H_
+
+/*
+ *****************************************
+ *   PSOC_CPU_PLL (Prototype: PLL)
+ *****************************************
+ */
+
+#define mmPSOC_CPU_PLL_NR                                            0xC70100
+
+#define mmPSOC_CPU_PLL_NF                                            0xC70104
+
+#define mmPSOC_CPU_PLL_OD                                            0xC70108
+
+#define mmPSOC_CPU_PLL_NB                                            0xC7010C
+
+#define mmPSOC_CPU_PLL_CFG                                           0xC70110
+
+#define mmPSOC_CPU_PLL_LOSE_MASK                                     0xC70120
+
+#define mmPSOC_CPU_PLL_LOCK_INTR                                     0xC70128
+
+#define mmPSOC_CPU_PLL_LOCK_BYPASS                                   0xC7012C
+
+#define mmPSOC_CPU_PLL_DATA_CHNG                                     0xC70130
+
+#define mmPSOC_CPU_PLL_RST                                           0xC70134
+
+#define mmPSOC_CPU_PLL_SLIP_WD_CNTR                                  0xC70150
+
+#define mmPSOC_CPU_PLL_DIV_FACTOR_0                                  0xC70200
+
+#define mmPSOC_CPU_PLL_DIV_FACTOR_1                                  0xC70204
+
+#define mmPSOC_CPU_PLL_DIV_FACTOR_2                                  0xC70208
+
+#define mmPSOC_CPU_PLL_DIV_FACTOR_3                                  0xC7020C
+
+#define mmPSOC_CPU_PLL_DIV_FACTOR_CMD_0                              0xC70220
+
+#define mmPSOC_CPU_PLL_DIV_FACTOR_CMD_1                              0xC70224
+
+#define mmPSOC_CPU_PLL_DIV_FACTOR_CMD_2                              0xC70228
+
+#define mmPSOC_CPU_PLL_DIV_FACTOR_CMD_3                              0xC7022C
+
+#define mmPSOC_CPU_PLL_DIV_SEL_0                                     0xC70280
+
+#define mmPSOC_CPU_PLL_DIV_SEL_1                                     0xC70284
+
+#define mmPSOC_CPU_PLL_DIV_SEL_2                                     0xC70288
+
+#define mmPSOC_CPU_PLL_DIV_SEL_3                                     0xC7028C
+
+#define mmPSOC_CPU_PLL_DIV_EN_0                                      0xC702A0
+
+#define mmPSOC_CPU_PLL_DIV_EN_1                                      0xC702A4
+
+#define mmPSOC_CPU_PLL_DIV_EN_2                                      0xC702A8
+
+#define mmPSOC_CPU_PLL_DIV_EN_3                                      0xC702AC
+
+#define mmPSOC_CPU_PLL_DIV_FACTOR_BUSY_0                             0xC702C0
+
+#define mmPSOC_CPU_PLL_DIV_FACTOR_BUSY_1                             0xC702C4
+
+#define mmPSOC_CPU_PLL_DIV_FACTOR_BUSY_2                             0xC702C8
+
+#define mmPSOC_CPU_PLL_DIV_FACTOR_BUSY_3                             0xC702CC
+
+#define mmPSOC_CPU_PLL_CLK_GATER                                     0xC70300
+
+#define mmPSOC_CPU_PLL_CLK_RLX_0                                     0xC70310
+
+#define mmPSOC_CPU_PLL_CLK_RLX_1                                     0xC70314
+
+#define mmPSOC_CPU_PLL_CLK_RLX_2                                     0xC70318
+
+#define mmPSOC_CPU_PLL_CLK_RLX_3                                     0xC7031C
+
+#define mmPSOC_CPU_PLL_REF_CNTR_PERIOD                               0xC70400
+
+#define mmPSOC_CPU_PLL_REF_LOW_THRESHOLD                             0xC70410
+
+#define mmPSOC_CPU_PLL_REF_HIGH_THRESHOLD                            0xC70420
+
+#define mmPSOC_CPU_PLL_PLL_NOT_STABLE                                0xC70430
+
+#define mmPSOC_CPU_PLL_FREQ_CALC_EN                                  0xC70440
+
+#define mmPSOC_CPU_PLL_RLX_BITMAP_CFG                                0xC70500
+
+#define mmPSOC_CPU_PLL_RLX_BITMAP_0                                  0xC70510
+
+#define mmPSOC_CPU_PLL_RLX_BITMAP_1                                  0xC70514
+
+#define mmPSOC_CPU_PLL_RLX_BITMAP_2                                  0xC70518
+
+#define mmPSOC_CPU_PLL_RLX_BITMAP_3                                  0xC7051C
+
+#endif /* ASIC_REG_PSOC_CPU_PLL_REGS_H_ */
-- 
2.17.1

