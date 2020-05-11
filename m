Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59DCC54E8F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A1A120736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEymHX8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgEKLdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729790AbgEKLdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:33:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E36CC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:33:01 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id n5so3894170wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=E4owJH3Clc7YkgRnHPdJIBvtDAIP0ZNR4GDAVYUCyy4=;
        b=eEymHX8xIp1dyfYkHT2juTICCL+XmYOi2gXa25cN2WGVmtMsti4kpizP1dldUibys+
         HrWHovgqDcX2IWFbnbhvBpZWUMmbB/KnySv01uTxcXb6UEJGhHCGouOB9/4ItQh+DO4C
         Fndz+/MTPBaRkZTkImjv5D7d+/nl/Wr6xs+HyF94Tc62gUfgjpOEF6jEdgyRahuq6aUB
         BuPeU6WKNx1ASkKVdefhyac+nmlO1gY14OfD+GyvB0L4ujn+09iJvSIYY7GSFBDRcpLG
         yv80c5K1XsI8oHRUfnmBZX+TWr5aGbjb/JG8w++T3qvKuK0gvvK3BFjsIAH1ekkA160W
         pssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=E4owJH3Clc7YkgRnHPdJIBvtDAIP0ZNR4GDAVYUCyy4=;
        b=ID1Vw/dc4znGhZ3aNc5+DW+QdZGAEAtck2NUCuEu0AdlJj0Jljawq9kx3DyEYjwAx7
         J2SjAJXdyreu3MQaJ2puoO/5GGkTeEqFVZzmruI2rZfrS/K8p649ii5CVcOUyDeFMk9N
         +40OWXobeJgmpFU3df9IZ2ki+VrKBkJxt8aaTiNpd0Jr3issZEvFMEG0+ZIzEddg9r8Y
         x6baeRRAQzIyNEUHd5iB6LTZLf3cuF9evP0RBzHKwDf/NnYYzvn6OWhYxTveLqMBhP5B
         isUCro6bn2wOuvkfn5YzNw1x+Kp5JvSkOMceGnf7/AwEztnifoG4jT7GiGFnptEShwEY
         8YWA==
X-Gm-Message-State: AGi0Pub2zVQU/oFkwkUEKV/dBP3oFb49pCoPuUuWl6jjTqDZ3ceDNGWJ
        qjzOPLiAX6qykGHWwy1dxnWQNJHE
X-Google-Smtp-Source: APiQypJFLaZ0DkuoF5yLq9AB7kMHG2sVmVemuLQ/pq0U2G4/+R6HeiUq1MLfO/F85xnZhmllqjWOOw==
X-Received: by 2002:a7b:c1c4:: with SMTP id a4mr31871761wmj.86.1589196778864;
        Mon, 11 May 2020 04:32:58 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id u12sm27830595wmu.25.2020.05.11.04.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 04:32:57 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH 10/11] habanalabs: add gaudi profiler module
Date:   Mon, 11 May 2020 14:32:31 +0300
Message-Id: <20200511113232.5771-11-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200511113232.5771-1-oded.gabbay@gmail.com>
References: <20200511113232.5771-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

Add the GAUDI code to initialize the ASIC's profiler. The profile receives
its initialization values from the user, same as in Goya, but the code to
initialize is in the driver because the configuration space of the
device is not directly exposed to the user.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/Makefile        |   3 +-
 drivers/misc/habanalabs/gaudi/gaudi.c         |   4 +-
 drivers/misc/habanalabs/gaudi/gaudiP.h        |   2 +
 .../misc/habanalabs/gaudi/gaudi_coresight.c   | 885 ++++++++++++++++++
 4 files changed, 891 insertions(+), 3 deletions(-)
 create mode 100644 drivers/misc/habanalabs/gaudi/gaudi_coresight.c

diff --git a/drivers/misc/habanalabs/gaudi/Makefile b/drivers/misc/habanalabs/gaudi/Makefile
index 1fe4ed625f47..f802cdc980ca 100644
--- a/drivers/misc/habanalabs/gaudi/Makefile
+++ b/drivers/misc/habanalabs/gaudi/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 subdir-ccflags-y += -I$(src)
 
-HL_GAUDI_FILES := gaudi/gaudi.o gaudi/gaudi_hwmgr.o gaudi/gaudi_security.o
\ No newline at end of file
+HL_GAUDI_FILES := gaudi/gaudi.o gaudi/gaudi_hwmgr.o gaudi/gaudi_security.o \
+	gaudi/gaudi_coresight.o
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 96f533a2cf82..62aa2e5690bb 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7387,7 +7387,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.send_heartbeat = gaudi_send_heartbeat,
 	.enable_clock_gating = gaudi_enable_clock_gating,
 	.disable_clock_gating = gaudi_disable_clock_gating,
-	.debug_coresight = NULL,
+	.debug_coresight = gaudi_debug_coresight,
 	.is_device_idle = gaudi_is_device_idle,
 	.soft_reset_late_init = gaudi_soft_reset_late_init,
 	.hw_queues_lock = gaudi_hw_queues_lock,
@@ -7401,7 +7401,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.init_iatu = gaudi_init_iatu,
 	.rreg = hl_rreg,
 	.wreg = hl_wreg,
-	.halt_coresight = NULL,
+	.halt_coresight = gaudi_halt_coresight,
 	.get_clk_rate = gaudi_get_clk_rate,
 	.get_queue_id_for_cq = gaudi_get_queue_id_for_cq,
 	.read_device_fw_version = gaudi_read_device_fw_version,
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index a311f3106b0a..b3d29ed35b20 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -252,6 +252,8 @@ void gaudi_init_security(struct hl_device *hdev);
 void gaudi_add_device_attr(struct hl_device *hdev,
 			struct attribute_group *dev_attr_grp);
 void gaudi_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq);
+int gaudi_debug_coresight(struct hl_device *hdev, void *data);
+void gaudi_halt_coresight(struct hl_device *hdev);
 int gaudi_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
 
 #endif /* GAUDIP_H_ */
diff --git a/drivers/misc/habanalabs/gaudi/gaudi_coresight.c b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
new file mode 100644
index 000000000000..a7b99816c60b
--- /dev/null
+++ b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
@@ -0,0 +1,885 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include "gaudiP.h"
+#include "include/gaudi/gaudi_coresight.h"
+#include "include/gaudi/asic_reg/gaudi_regs.h"
+#include "include/gaudi/gaudi_masks.h"
+
+#include <uapi/misc/habanalabs.h>
+#include <linux/coresight.h>
+
+#define SPMU_SECTION_SIZE		MME0_ACC_SPMU_MAX_OFFSET
+#define SPMU_EVENT_TYPES_OFFSET		0x400
+#define SPMU_MAX_COUNTERS		6
+
+static u64 debug_stm_regs[GAUDI_STM_LAST + 1] = {
+	[GAUDI_STM_MME0_ACC]	= mmMME0_ACC_STM_BASE,
+	[GAUDI_STM_MME0_SBAB]	= mmMME0_SBAB_STM_BASE,
+	[GAUDI_STM_MME0_CTRL]	= mmMME0_CTRL_STM_BASE,
+	[GAUDI_STM_MME1_ACC]	= mmMME1_ACC_STM_BASE,
+	[GAUDI_STM_MME1_SBAB]	= mmMME1_SBAB_STM_BASE,
+	[GAUDI_STM_MME1_CTRL]	= mmMME1_CTRL_STM_BASE,
+	[GAUDI_STM_MME2_ACC]	= mmMME2_ACC_STM_BASE,
+	[GAUDI_STM_MME2_SBAB]	= mmMME2_SBAB_STM_BASE,
+	[GAUDI_STM_MME2_CTRL]	= mmMME2_CTRL_STM_BASE,
+	[GAUDI_STM_MME3_ACC]	= mmMME3_ACC_STM_BASE,
+	[GAUDI_STM_MME3_SBAB]	= mmMME3_SBAB_STM_BASE,
+	[GAUDI_STM_MME3_CTRL]	= mmMME3_CTRL_STM_BASE,
+	[GAUDI_STM_DMA_IF_W_S]	= mmDMA_IF_W_S_STM_BASE,
+	[GAUDI_STM_DMA_IF_E_S]	= mmDMA_IF_E_S_STM_BASE,
+	[GAUDI_STM_DMA_IF_W_N]	= mmDMA_IF_W_N_STM_BASE,
+	[GAUDI_STM_DMA_IF_E_N]	= mmDMA_IF_E_N_STM_BASE,
+	[GAUDI_STM_CPU]		= mmCPU_STM_BASE,
+	[GAUDI_STM_DMA_CH_0_CS]	= mmDMA_CH_0_CS_STM_BASE,
+	[GAUDI_STM_DMA_CH_1_CS]	= mmDMA_CH_1_CS_STM_BASE,
+	[GAUDI_STM_DMA_CH_2_CS]	= mmDMA_CH_2_CS_STM_BASE,
+	[GAUDI_STM_DMA_CH_3_CS]	= mmDMA_CH_3_CS_STM_BASE,
+	[GAUDI_STM_DMA_CH_4_CS]	= mmDMA_CH_4_CS_STM_BASE,
+	[GAUDI_STM_DMA_CH_5_CS]	= mmDMA_CH_5_CS_STM_BASE,
+	[GAUDI_STM_DMA_CH_6_CS]	= mmDMA_CH_6_CS_STM_BASE,
+	[GAUDI_STM_DMA_CH_7_CS]	= mmDMA_CH_7_CS_STM_BASE,
+	[GAUDI_STM_PCIE]	= mmPCIE_STM_BASE,
+	[GAUDI_STM_MMU_CS]	= mmMMU_CS_STM_BASE,
+	[GAUDI_STM_PSOC]	= mmPSOC_STM_BASE,
+	[GAUDI_STM_NIC0_0]	= mmSTM_0_NIC0_DBG_BASE,
+	[GAUDI_STM_NIC0_1]	= mmSTM_1_NIC0_DBG_BASE,
+	[GAUDI_STM_NIC1_0]	= mmSTM_0_NIC1_DBG_BASE,
+	[GAUDI_STM_NIC1_1]	= mmSTM_1_NIC1_DBG_BASE,
+	[GAUDI_STM_NIC2_0]	= mmSTM_0_NIC2_DBG_BASE,
+	[GAUDI_STM_NIC2_1]	= mmSTM_1_NIC2_DBG_BASE,
+	[GAUDI_STM_NIC3_0]	= mmSTM_0_NIC3_DBG_BASE,
+	[GAUDI_STM_NIC3_1]	= mmSTM_1_NIC3_DBG_BASE,
+	[GAUDI_STM_NIC4_0]	= mmSTM_0_NIC4_DBG_BASE,
+	[GAUDI_STM_NIC4_1]	= mmSTM_1_NIC4_DBG_BASE,
+	[GAUDI_STM_TPC0_EML]	= mmTPC0_EML_STM_BASE,
+	[GAUDI_STM_TPC1_EML]	= mmTPC1_EML_STM_BASE,
+	[GAUDI_STM_TPC2_EML]	= mmTPC2_EML_STM_BASE,
+	[GAUDI_STM_TPC3_EML]	= mmTPC3_EML_STM_BASE,
+	[GAUDI_STM_TPC4_EML]	= mmTPC4_EML_STM_BASE,
+	[GAUDI_STM_TPC5_EML]	= mmTPC5_EML_STM_BASE,
+	[GAUDI_STM_TPC6_EML]	= mmTPC6_EML_STM_BASE,
+	[GAUDI_STM_TPC7_EML]	= mmTPC7_EML_STM_BASE
+};
+
+static u64 debug_etf_regs[GAUDI_ETF_LAST + 1] = {
+	[GAUDI_ETF_MME0_ACC]		= mmMME0_ACC_ETF_BASE,
+	[GAUDI_ETF_MME0_SBAB]		= mmMME0_SBAB_ETF_BASE,
+	[GAUDI_ETF_MME0_CTRL]		= mmMME0_CTRL_ETF_BASE,
+	[GAUDI_ETF_MME1_ACC]		= mmMME1_ACC_ETF_BASE,
+	[GAUDI_ETF_MME1_SBAB]		= mmMME1_SBAB_ETF_BASE,
+	[GAUDI_ETF_MME1_CTRL]		= mmMME1_CTRL_ETF_BASE,
+	[GAUDI_ETF_MME2_ACC]		= mmMME2_MME2_ACC_ETF_BASE,
+	[GAUDI_ETF_MME2_SBAB]		= mmMME2_SBAB_ETF_BASE,
+	[GAUDI_ETF_MME2_CTRL]		= mmMME2_CTRL_ETF_BASE,
+	[GAUDI_ETF_MME3_ACC]		= mmMME3_ACC_ETF_BASE,
+	[GAUDI_ETF_MME3_SBAB]		= mmMME3_SBAB_ETF_BASE,
+	[GAUDI_ETF_MME3_CTRL]		= mmMME3_CTRL_ETF_BASE,
+	[GAUDI_ETF_DMA_IF_W_S]		= mmDMA_IF_W_S_ETF_BASE,
+	[GAUDI_ETF_DMA_IF_E_S]		= mmDMA_IF_E_S_ETF_BASE,
+	[GAUDI_ETF_DMA_IF_W_N]		= mmDMA_IF_W_N_ETF_BASE,
+	[GAUDI_ETF_DMA_IF_E_N]		= mmDMA_IF_E_N_ETF_BASE,
+	[GAUDI_ETF_CPU_0]		= mmCPU_ETF_0_BASE,
+	[GAUDI_ETF_CPU_1]		= mmCPU_ETF_1_BASE,
+	[GAUDI_ETF_CPU_TRACE]		= mmCPU_ETF_TRACE_BASE,
+	[GAUDI_ETF_DMA_CH_0_CS]		= mmDMA_CH_0_CS_ETF_BASE,
+	[GAUDI_ETF_DMA_CH_1_CS]		= mmDMA_CH_1_CS_ETF_BASE,
+	[GAUDI_ETF_DMA_CH_2_CS]		= mmDMA_CH_2_CS_ETF_BASE,
+	[GAUDI_ETF_DMA_CH_3_CS]		= mmDMA_CH_3_CS_ETF_BASE,
+	[GAUDI_ETF_DMA_CH_4_CS]		= mmDMA_CH_4_CS_ETF_BASE,
+	[GAUDI_ETF_DMA_CH_5_CS]		= mmDMA_CH_5_CS_ETF_BASE,
+	[GAUDI_ETF_DMA_CH_6_CS]		= mmDMA_CH_6_CS_ETF_BASE,
+	[GAUDI_ETF_DMA_CH_7_CS]		= mmDMA_CH_7_CS_ETF_BASE,
+	[GAUDI_ETF_PCIE]		= mmPCIE_ETF_BASE,
+	[GAUDI_ETF_MMU_CS]		= mmMMU_CS_ETF_BASE,
+	[GAUDI_ETF_PSOC]		= mmPSOC_ETF_BASE,
+	[GAUDI_ETF_NIC0_0]		= mmETF_0_NIC0_DBG_BASE,
+	[GAUDI_ETF_NIC0_1]		= mmETF_1_NIC0_DBG_BASE,
+	[GAUDI_ETF_NIC1_0]		= mmETF_0_NIC1_DBG_BASE,
+	[GAUDI_ETF_NIC1_1]		= mmETF_1_NIC1_DBG_BASE,
+	[GAUDI_ETF_NIC2_0]		= mmETF_0_NIC2_DBG_BASE,
+	[GAUDI_ETF_NIC2_1]		= mmETF_1_NIC2_DBG_BASE,
+	[GAUDI_ETF_NIC3_0]		= mmETF_0_NIC3_DBG_BASE,
+	[GAUDI_ETF_NIC3_1]		= mmETF_1_NIC3_DBG_BASE,
+	[GAUDI_ETF_NIC4_0]		= mmETF_0_NIC4_DBG_BASE,
+	[GAUDI_ETF_NIC4_1]		= mmETF_1_NIC4_DBG_BASE,
+	[GAUDI_ETF_TPC0_EML]		= mmTPC0_EML_ETF_BASE,
+	[GAUDI_ETF_TPC1_EML]		= mmTPC1_EML_ETF_BASE,
+	[GAUDI_ETF_TPC2_EML]		= mmTPC2_EML_ETF_BASE,
+	[GAUDI_ETF_TPC3_EML]		= mmTPC3_EML_ETF_BASE,
+	[GAUDI_ETF_TPC4_EML]		= mmTPC4_EML_ETF_BASE,
+	[GAUDI_ETF_TPC5_EML]		= mmTPC5_EML_ETF_BASE,
+	[GAUDI_ETF_TPC6_EML]		= mmTPC6_EML_ETF_BASE,
+	[GAUDI_ETF_TPC7_EML]		= mmTPC7_EML_ETF_BASE
+};
+
+static u64 debug_funnel_regs[GAUDI_FUNNEL_LAST + 1] = {
+	[GAUDI_FUNNEL_MME0_ACC]		= mmMME0_ACC_FUNNEL_BASE,
+	[GAUDI_FUNNEL_MME1_ACC]		= mmMME1_ACC_FUNNEL_BASE,
+	[GAUDI_FUNNEL_MME2_ACC]		= mmMME2_ACC_FUNNEL_BASE,
+	[GAUDI_FUNNEL_MME3_ACC]		= mmMME3_ACC_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y0_X0]	= mmSRAM_Y0_X0_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y0_X1]	= mmSRAM_Y0_X1_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y0_X2]	= mmSRAM_Y0_X2_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y0_X3]	= mmSRAM_Y0_X3_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y0_X4]	= mmSRAM_Y0_X4_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y0_X5]	= mmSRAM_Y0_X5_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y0_X6]	= mmSRAM_Y0_X6_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y0_X7]	= mmSRAM_Y0_X7_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y1_X0]	= mmSRAM_Y1_X0_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y1_X1]	= mmSRAM_Y1_X1_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y1_X2]	= mmSRAM_Y1_X2_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y1_X3]	= mmSRAM_Y1_X3_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y1_X4]	= mmSRAM_Y1_X4_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y1_X5]	= mmSRAM_Y1_X5_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y1_X6]	= mmSRAM_Y1_X6_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y1_X7]	= mmSRAM_Y1_X7_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y2_X0]	= mmSRAM_Y2_X0_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y2_X1]	= mmSRAM_Y2_X1_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y2_X2]	= mmSRAM_Y2_X2_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y2_X3]	= mmSRAM_Y2_X3_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y2_X4]	= mmSRAM_Y2_X4_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y2_X5]	= mmSRAM_Y2_X5_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y2_X6]	= mmSRAM_Y2_X6_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y2_X7]	= mmSRAM_Y2_X7_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y3_X0]	= mmSRAM_Y3_X0_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y3_X1]	= mmSRAM_Y3_X1_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y3_X2]	= mmSRAM_Y3_X2_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y3_X4]	= mmSRAM_Y3_X4_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y3_X3]	= mmSRAM_Y3_X3_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y3_X5]	= mmSRAM_Y3_X5_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y3_X6]	= mmSRAM_Y3_X6_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SRAM_Y3_X7]	= mmSRAM_Y3_X7_FUNNEL_BASE,
+	[GAUDI_FUNNEL_SIF_0]		= mmSIF_FUNNEL_0_BASE,
+	[GAUDI_FUNNEL_SIF_1]		= mmSIF_FUNNEL_1_BASE,
+	[GAUDI_FUNNEL_SIF_2]		= mmSIF_FUNNEL_2_BASE,
+	[GAUDI_FUNNEL_SIF_3]		= mmSIF_FUNNEL_3_BASE,
+	[GAUDI_FUNNEL_SIF_4]		= mmSIF_FUNNEL_4_BASE,
+	[GAUDI_FUNNEL_SIF_5]		= mmSIF_FUNNEL_5_BASE,
+	[GAUDI_FUNNEL_SIF_6]		= mmSIF_FUNNEL_6_BASE,
+	[GAUDI_FUNNEL_SIF_7]		= mmSIF_FUNNEL_7_BASE,
+	[GAUDI_FUNNEL_NIF_0]		= mmNIF_FUNNEL_0_BASE,
+	[GAUDI_FUNNEL_NIF_1]		= mmNIF_FUNNEL_1_BASE,
+	[GAUDI_FUNNEL_NIF_2]		= mmNIF_FUNNEL_2_BASE,
+	[GAUDI_FUNNEL_NIF_3]		= mmNIF_FUNNEL_3_BASE,
+	[GAUDI_FUNNEL_NIF_4]		= mmNIF_FUNNEL_4_BASE,
+	[GAUDI_FUNNEL_NIF_5]		= mmNIF_FUNNEL_5_BASE,
+	[GAUDI_FUNNEL_NIF_6]		= mmNIF_FUNNEL_6_BASE,
+	[GAUDI_FUNNEL_NIF_7]		= mmNIF_FUNNEL_7_BASE,
+	[GAUDI_FUNNEL_DMA_IF_W_S]	= mmDMA_IF_W_S_FUNNEL_BASE,
+	[GAUDI_FUNNEL_DMA_IF_E_S]	= mmDMA_IF_E_S_FUNNEL_BASE,
+	[GAUDI_FUNNEL_DMA_IF_W_N]	= mmDMA_IF_W_N_FUNNEL_BASE,
+	[GAUDI_FUNNEL_DMA_IF_E_N]	= mmDMA_IF_E_N_FUNNEL_BASE,
+	[GAUDI_FUNNEL_CPU]		= mmCPU_FUNNEL_BASE,
+	[GAUDI_FUNNEL_NIC_TPC_W_S]	= mmNIC_TPC_FUNNEL_W_S_BASE,
+	[GAUDI_FUNNEL_NIC_TPC_E_S]	= mmNIC_TPC_FUNNEL_E_S_BASE,
+	[GAUDI_FUNNEL_NIC_TPC_W_N]	= mmNIC_TPC_FUNNEL_W_N_BASE,
+	[GAUDI_FUNNEL_NIC_TPC_E_N]	= mmNIC_TPC_FUNNEL_E_N_BASE,
+	[GAUDI_FUNNEL_PCIE]		= mmPCIE_FUNNEL_BASE,
+	[GAUDI_FUNNEL_PSOC]		= mmPSOC_FUNNEL_BASE,
+	[GAUDI_FUNNEL_NIC0]		= mmFUNNEL_NIC0_DBG_BASE,
+	[GAUDI_FUNNEL_NIC1]		= mmFUNNEL_NIC1_DBG_BASE,
+	[GAUDI_FUNNEL_NIC2]		= mmFUNNEL_NIC2_DBG_BASE,
+	[GAUDI_FUNNEL_NIC3]		= mmFUNNEL_NIC3_DBG_BASE,
+	[GAUDI_FUNNEL_NIC4]		= mmFUNNEL_NIC4_DBG_BASE,
+	[GAUDI_FUNNEL_TPC0_EML]		= mmTPC0_EML_FUNNEL_BASE,
+	[GAUDI_FUNNEL_TPC1_EML]		= mmTPC1_EML_FUNNEL_BASE,
+	[GAUDI_FUNNEL_TPC2_EML]		= mmTPC2_EML_FUNNEL_BASE,
+	[GAUDI_FUNNEL_TPC3_EML]		= mmTPC3_EML_FUNNEL_BASE,
+	[GAUDI_FUNNEL_TPC4_EML]		= mmTPC4_EML_FUNNEL_BASE,
+	[GAUDI_FUNNEL_TPC5_EML]		= mmTPC5_EML_FUNNEL_BASE,
+	[GAUDI_FUNNEL_TPC6_EML]		= mmTPC6_EML_FUNNEL_BASE,
+	[GAUDI_FUNNEL_TPC7_EML]		= mmTPC7_EML_FUNNEL_BASE
+};
+
+static u64 debug_bmon_regs[GAUDI_BMON_LAST + 1] = {
+	[GAUDI_BMON_MME0_ACC_0]		= mmMME0_ACC_BMON0_BASE,
+	[GAUDI_BMON_MME0_SBAB_0]	= mmMME0_SBAB_BMON0_BASE,
+	[GAUDI_BMON_MME0_SBAB_1]	= mmMME0_SBAB_BMON1_BASE,
+	[GAUDI_BMON_MME0_CTRL_0]	= mmMME0_CTRL_BMON0_BASE,
+	[GAUDI_BMON_MME0_CTRL_1]	= mmMME0_CTRL_BMON1_BASE,
+	[GAUDI_BMON_MME1_ACC_0]		= mmMME1_ACC_BMON0_BASE,
+	[GAUDI_BMON_MME1_SBAB_0]	= mmMME1_SBAB_BMON0_BASE,
+	[GAUDI_BMON_MME1_SBAB_1]	= mmMME1_SBAB_BMON1_BASE,
+	[GAUDI_BMON_MME1_CTRL_0]	= mmMME1_CTRL_BMON0_BASE,
+	[GAUDI_BMON_MME1_CTRL_1]	= mmMME1_CTRL_BMON1_BASE,
+	[GAUDI_BMON_MME2_ACC_0]		= mmMME2_ACC_BMON0_BASE,
+	[GAUDI_BMON_MME2_SBAB_0]	= mmMME2_SBAB_BMON0_BASE,
+	[GAUDI_BMON_MME2_SBAB_1]	= mmMME2_SBAB_BMON1_BASE,
+	[GAUDI_BMON_MME2_CTRL_0]	= mmMME2_CTRL_BMON0_BASE,
+	[GAUDI_BMON_MME2_CTRL_1]	= mmMME2_CTRL_BMON1_BASE,
+	[GAUDI_BMON_MME3_ACC_0]		= mmMME3_ACC_BMON0_BASE,
+	[GAUDI_BMON_MME3_SBAB_0]	= mmMME3_SBAB_BMON0_BASE,
+	[GAUDI_BMON_MME3_SBAB_1]	= mmMME3_SBAB_BMON1_BASE,
+	[GAUDI_BMON_MME3_CTRL_0]	= mmMME3_CTRL_BMON0_BASE,
+	[GAUDI_BMON_MME3_CTRL_1]	= mmMME3_CTRL_BMON1_BASE,
+	[GAUDI_BMON_DMA_IF_W_S_SOB_WR]	= mmDMA_IF_W_S_SOB_WR_BMON_BASE,
+	[GAUDI_BMON_DMA_IF_W_S_0_WR]	= mmDMA_IF_W_S_HBM0_WR_BMON_BASE,
+	[GAUDI_BMON_DMA_IF_W_S_0_RD]	= mmDMA_IF_W_S_HBM0_RD_BMON_BASE,
+	[GAUDI_BMON_DMA_IF_W_S_1_WR]	= mmDMA_IF_W_S_HBM1_WR_BMON_BASE,
+	[GAUDI_BMON_DMA_IF_W_S_1_RD]	= mmDMA_IF_W_S_HBM1_RD_BMON_BASE,
+	[GAUDI_BMON_DMA_IF_E_S_SOB_WR]	= mmDMA_IF_E_S_SOB_WR_BMON_BASE,
+	[GAUDI_BMON_DMA_IF_E_S_0_WR]	= mmDMA_IF_E_S_HBM0_WR_BMON_BASE,
+	[GAUDI_BMON_DMA_IF_E_S_0_RD]	= mmDMA_IF_E_S_HBM0_RD_BMON_BASE,
+	[GAUDI_BMON_DMA_IF_E_S_1_WR]	= mmDMA_IF_E_S_HBM1_WR_BMON_BASE,
+	[GAUDI_BMON_DMA_IF_E_S_1_RD]	= mmDMA_IF_E_S_HBM1_RD_BMON_BASE,
+	[GAUDI_BMON_DMA_IF_W_N_SOB_WR]	= mmDMA_IF_W_N_SOB_WR_BMON_BASE,
+	[GAUDI_BMON_DMA_IF_W_N_HBM0_WR]	= mmDMA_IF_W_N_HBM0_WR_BMON_BASE,
+	[GAUDI_BMON_DMA_IF_W_N_HBM0_RD]	= mmDMA_IF_W_N_HBM0_RD_BMON_BASE,
+	[GAUDI_BMON_DMA_IF_W_N_HBM1_WR]	= mmDMA_IF_W_N_HBM1_WR_BMON_BASE,
+	[GAUDI_BMON_DMA_IF_W_N_HBM1_RD]	= mmDMA_IF_W_N_HBM1_RD_BMON_BASE,
+	[GAUDI_BMON_DMA_IF_E_N_SOB_WR]	= mmDMA_IF_E_N_SOB_WR_BMON_BASE,
+	[GAUDI_BMON_DMA_IF_E_N_HBM0_WR]	= mmDMA_IF_E_N_HBM0_WR_BMON_BASE,
+	[GAUDI_BMON_DMA_IF_E_N_HBM0_RD]	= mmDMA_IF_E_N_HBM0_RD_BMON_BASE,
+	[GAUDI_BMON_DMA_IF_E_N_HBM1_WR]	= mmDMA_IF_E_N_HBM1_WR_BMON_BASE,
+	[GAUDI_BMON_DMA_IF_E_N_HBM1_RD]	= mmDMA_IF_E_N_HBM1_RD_BMON_BASE,
+	[GAUDI_BMON_CPU_WR]		= mmCPU_WR_BMON_BASE,
+	[GAUDI_BMON_CPU_RD]		= mmCPU_RD_BMON_BASE,
+	[GAUDI_BMON_DMA_CH_0_0]		= mmDMA_CH_0_BMON_0_BASE,
+	[GAUDI_BMON_DMA_CH_0_1]		= mmDMA_CH_0_BMON_1_BASE,
+	[GAUDI_BMON_DMA_CH_1_0]		= mmDMA_CH_1_BMON_0_BASE,
+	[GAUDI_BMON_DMA_CH_1_1]		= mmDMA_CH_1_BMON_1_BASE,
+	[GAUDI_BMON_DMA_CH_2_0]		= mmDMA_CH_2_BMON_0_BASE,
+	[GAUDI_BMON_DMA_CH_2_1]		= mmDMA_CH_2_BMON_1_BASE,
+	[GAUDI_BMON_DMA_CH_3_0]		= mmDMA_CH_3_BMON_0_BASE,
+	[GAUDI_BMON_DMA_CH_3_1]		= mmDMA_CH_3_BMON_1_BASE,
+	[GAUDI_BMON_DMA_CH_4_0]		= mmDMA_CH_4_BMON_0_BASE,
+	[GAUDI_BMON_DMA_CH_4_1]		= mmDMA_CH_4_BMON_1_BASE,
+	[GAUDI_BMON_DMA_CH_5_0]		= mmDMA_CH_5_BMON_0_BASE,
+	[GAUDI_BMON_DMA_CH_5_1]		= mmDMA_CH_5_BMON_1_BASE,
+	[GAUDI_BMON_DMA_CH_6_0]		= mmDMA_CH_6_BMON_0_BASE,
+	[GAUDI_BMON_DMA_CH_6_1]		= mmDMA_CH_6_BMON_1_BASE,
+	[GAUDI_BMON_DMA_CH_7_0]		= mmDMA_CH_7_BMON_0_BASE,
+	[GAUDI_BMON_DMA_CH_7_1]		= mmDMA_CH_7_BMON_1_BASE,
+	[GAUDI_BMON_PCIE_MSTR_WR]	= mmPCIE_BMON_MSTR_WR_BASE,
+	[GAUDI_BMON_PCIE_MSTR_RD]	= mmPCIE_BMON_MSTR_RD_BASE,
+	[GAUDI_BMON_PCIE_SLV_WR]	= mmPCIE_BMON_SLV_WR_BASE,
+	[GAUDI_BMON_PCIE_SLV_RD]	= mmPCIE_BMON_SLV_RD_BASE,
+	[GAUDI_BMON_MMU_0]		= mmMMU_BMON_0_BASE,
+	[GAUDI_BMON_MMU_1]		= mmMMU_BMON_1_BASE,
+	[GAUDI_BMON_NIC0_0]		= mmBMON0_NIC0_DBG_BASE,
+	[GAUDI_BMON_NIC0_1]		= mmBMON1_NIC0_DBG_BASE,
+	[GAUDI_BMON_NIC0_2]		= mmBMON2_NIC0_DBG_BASE,
+	[GAUDI_BMON_NIC0_3]		= mmBMON3_NIC0_DBG_BASE,
+	[GAUDI_BMON_NIC0_4]		= mmBMON4_NIC0_DBG_BASE,
+	[GAUDI_BMON_NIC1_0]		= mmBMON0_NIC1_DBG_BASE,
+	[GAUDI_BMON_NIC1_1]		= mmBMON1_NIC1_DBG_BASE,
+	[GAUDI_BMON_NIC1_2]		= mmBMON2_NIC1_DBG_BASE,
+	[GAUDI_BMON_NIC1_3]		= mmBMON3_NIC1_DBG_BASE,
+	[GAUDI_BMON_NIC1_4]		= mmBMON4_NIC1_DBG_BASE,
+	[GAUDI_BMON_NIC2_0]		= mmBMON0_NIC2_DBG_BASE,
+	[GAUDI_BMON_NIC2_1]		= mmBMON1_NIC2_DBG_BASE,
+	[GAUDI_BMON_NIC2_2]		= mmBMON2_NIC2_DBG_BASE,
+	[GAUDI_BMON_NIC2_3]		= mmBMON3_NIC2_DBG_BASE,
+	[GAUDI_BMON_NIC2_4]		= mmBMON4_NIC2_DBG_BASE,
+	[GAUDI_BMON_NIC3_0]		= mmBMON0_NIC3_DBG_BASE,
+	[GAUDI_BMON_NIC3_1]		= mmBMON1_NIC3_DBG_BASE,
+	[GAUDI_BMON_NIC3_2]		= mmBMON2_NIC3_DBG_BASE,
+	[GAUDI_BMON_NIC3_3]		= mmBMON3_NIC3_DBG_BASE,
+	[GAUDI_BMON_NIC3_4]		= mmBMON4_NIC3_DBG_BASE,
+	[GAUDI_BMON_NIC4_0]		= mmBMON0_NIC4_DBG_BASE,
+	[GAUDI_BMON_NIC4_1]		= mmBMON1_NIC4_DBG_BASE,
+	[GAUDI_BMON_NIC4_2]		= mmBMON2_NIC4_DBG_BASE,
+	[GAUDI_BMON_NIC4_3]		= mmBMON3_NIC4_DBG_BASE,
+	[GAUDI_BMON_NIC4_4]		= mmBMON4_NIC4_DBG_BASE,
+	[GAUDI_BMON_TPC0_EML_0]		= mmTPC0_EML_BUSMON_0_BASE,
+	[GAUDI_BMON_TPC0_EML_1]		= mmTPC0_EML_BUSMON_1_BASE,
+	[GAUDI_BMON_TPC0_EML_2]		= mmTPC0_EML_BUSMON_2_BASE,
+	[GAUDI_BMON_TPC0_EML_3]		= mmTPC0_EML_BUSMON_3_BASE,
+	[GAUDI_BMON_TPC1_EML_0]		= mmTPC1_EML_BUSMON_0_BASE,
+	[GAUDI_BMON_TPC1_EML_1]		= mmTPC1_EML_BUSMON_1_BASE,
+	[GAUDI_BMON_TPC1_EML_2]		= mmTPC1_EML_BUSMON_2_BASE,
+	[GAUDI_BMON_TPC1_EML_3]		= mmTPC1_EML_BUSMON_3_BASE,
+	[GAUDI_BMON_TPC2_EML_0]		= mmTPC2_EML_BUSMON_0_BASE,
+	[GAUDI_BMON_TPC2_EML_1]		= mmTPC2_EML_BUSMON_1_BASE,
+	[GAUDI_BMON_TPC2_EML_2]		= mmTPC2_EML_BUSMON_2_BASE,
+	[GAUDI_BMON_TPC2_EML_3]		= mmTPC2_EML_BUSMON_3_BASE,
+	[GAUDI_BMON_TPC3_EML_0]		= mmTPC3_EML_BUSMON_0_BASE,
+	[GAUDI_BMON_TPC3_EML_1]		= mmTPC3_EML_BUSMON_1_BASE,
+	[GAUDI_BMON_TPC3_EML_2]		= mmTPC3_EML_BUSMON_2_BASE,
+	[GAUDI_BMON_TPC3_EML_3]		= mmTPC3_EML_BUSMON_3_BASE,
+	[GAUDI_BMON_TPC4_EML_0]		= mmTPC4_EML_BUSMON_0_BASE,
+	[GAUDI_BMON_TPC4_EML_1]		= mmTPC4_EML_BUSMON_1_BASE,
+	[GAUDI_BMON_TPC4_EML_2]		= mmTPC4_EML_BUSMON_2_BASE,
+	[GAUDI_BMON_TPC4_EML_3]		= mmTPC4_EML_BUSMON_3_BASE,
+	[GAUDI_BMON_TPC5_EML_0]		= mmTPC5_EML_BUSMON_0_BASE,
+	[GAUDI_BMON_TPC5_EML_1]		= mmTPC5_EML_BUSMON_1_BASE,
+	[GAUDI_BMON_TPC5_EML_2]		= mmTPC5_EML_BUSMON_2_BASE,
+	[GAUDI_BMON_TPC5_EML_3]		= mmTPC5_EML_BUSMON_3_BASE,
+	[GAUDI_BMON_TPC6_EML_0]		= mmTPC6_EML_BUSMON_0_BASE,
+	[GAUDI_BMON_TPC6_EML_1]		= mmTPC6_EML_BUSMON_1_BASE,
+	[GAUDI_BMON_TPC6_EML_2]		= mmTPC6_EML_BUSMON_2_BASE,
+	[GAUDI_BMON_TPC6_EML_3]		= mmTPC6_EML_BUSMON_3_BASE,
+	[GAUDI_BMON_TPC7_EML_0]		= mmTPC7_EML_BUSMON_0_BASE,
+	[GAUDI_BMON_TPC7_EML_1]		= mmTPC7_EML_BUSMON_1_BASE,
+	[GAUDI_BMON_TPC7_EML_2]		= mmTPC7_EML_BUSMON_2_BASE,
+	[GAUDI_BMON_TPC7_EML_3]		= mmTPC7_EML_BUSMON_3_BASE
+};
+
+static u64 debug_spmu_regs[GAUDI_SPMU_LAST + 1] = {
+	[GAUDI_SPMU_MME0_ACC]		= mmMME0_ACC_SPMU_BASE,
+	[GAUDI_SPMU_MME0_SBAB]		= mmMME0_SBAB_SPMU_BASE,
+	[GAUDI_SPMU_MME0_CTRL]		= mmMME0_CTRL_SPMU_BASE,
+	[GAUDI_SPMU_MME1_ACC]		= mmMME1_ACC_SPMU_BASE,
+	[GAUDI_SPMU_MME1_SBAB]		= mmMME1_SBAB_SPMU_BASE,
+	[GAUDI_SPMU_MME1_CTRL]		= mmMME1_CTRL_SPMU_BASE,
+	[GAUDI_SPMU_MME2_MME2_ACC]	= mmMME2_ACC_SPMU_BASE,
+	[GAUDI_SPMU_MME2_SBAB]		= mmMME2_SBAB_SPMU_BASE,
+	[GAUDI_SPMU_MME2_CTRL]		= mmMME2_CTRL_SPMU_BASE,
+	[GAUDI_SPMU_MME3_ACC]		= mmMME3_ACC_SPMU_BASE,
+	[GAUDI_SPMU_MME3_SBAB]		= mmMME3_SBAB_SPMU_BASE,
+	[GAUDI_SPMU_MME3_CTRL]		= mmMME3_CTRL_SPMU_BASE,
+	[GAUDI_SPMU_DMA_CH_0_CS]	= mmDMA_CH_0_CS_SPMU_BASE,
+	[GAUDI_SPMU_DMA_CH_1_CS]	= mmDMA_CH_1_CS_SPMU_BASE,
+	[GAUDI_SPMU_DMA_CH_2_CS]	= mmDMA_CH_2_CS_SPMU_BASE,
+	[GAUDI_SPMU_DMA_CH_3_CS]	= mmDMA_CH_3_CS_SPMU_BASE,
+	[GAUDI_SPMU_DMA_CH_4_CS]	= mmDMA_CH_4_CS_SPMU_BASE,
+	[GAUDI_SPMU_DMA_CH_5_CS]	= mmDMA_CH_5_CS_SPMU_BASE,
+	[GAUDI_SPMU_DMA_CH_6_CS]	= mmDMA_CH_6_CS_SPMU_BASE,
+	[GAUDI_SPMU_DMA_CH_7_CS]	= mmDMA_CH_7_CS_SPMU_BASE,
+	[GAUDI_SPMU_PCIE]		= mmPCIE_SPMU_BASE,
+	[GAUDI_SPMU_MMU_CS]		= mmMMU_CS_SPMU_BASE,
+	[GAUDI_SPMU_NIC0_0]		= mmSPMU_0_NIC0_DBG_BASE,
+	[GAUDI_SPMU_NIC0_1]		= mmSPMU_1_NIC0_DBG_BASE,
+	[GAUDI_SPMU_NIC1_0]		= mmSPMU_0_NIC1_DBG_BASE,
+	[GAUDI_SPMU_NIC1_1]		= mmSPMU_1_NIC1_DBG_BASE,
+	[GAUDI_SPMU_NIC2_0]		= mmSPMU_0_NIC2_DBG_BASE,
+	[GAUDI_SPMU_NIC2_1]		= mmSPMU_1_NIC2_DBG_BASE,
+	[GAUDI_SPMU_NIC3_0]		= mmSPMU_0_NIC3_DBG_BASE,
+	[GAUDI_SPMU_NIC3_1]		= mmSPMU_1_NIC3_DBG_BASE,
+	[GAUDI_SPMU_NIC4_0]		= mmSPMU_0_NIC4_DBG_BASE,
+	[GAUDI_SPMU_NIC4_1]		= mmSPMU_1_NIC4_DBG_BASE,
+	[GAUDI_SPMU_TPC0_EML]		= mmTPC0_EML_SPMU_BASE,
+	[GAUDI_SPMU_TPC1_EML]		= mmTPC1_EML_SPMU_BASE,
+	[GAUDI_SPMU_TPC2_EML]		= mmTPC2_EML_SPMU_BASE,
+	[GAUDI_SPMU_TPC3_EML]		= mmTPC3_EML_SPMU_BASE,
+	[GAUDI_SPMU_TPC4_EML]		= mmTPC4_EML_SPMU_BASE,
+	[GAUDI_SPMU_TPC5_EML]		= mmTPC5_EML_SPMU_BASE,
+	[GAUDI_SPMU_TPC6_EML]		= mmTPC6_EML_SPMU_BASE,
+	[GAUDI_SPMU_TPC7_EML]		= mmTPC7_EML_SPMU_BASE
+};
+
+static int gaudi_coresight_timeout(struct hl_device *hdev, u64 addr,
+		int position, bool up)
+{
+	int rc;
+	u32 val;
+
+	rc = hl_poll_timeout(
+		hdev,
+		addr,
+		val,
+		up ? val & BIT(position) : !(val & BIT(position)),
+		1000,
+		CORESIGHT_TIMEOUT_USEC);
+
+	if (rc) {
+		dev_err(hdev->dev,
+			"Timeout while waiting for coresight, addr: 0x%llx, position: %d, up: %d\n",
+				addr, position, up);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int gaudi_config_stm(struct hl_device *hdev,
+		struct hl_debug_params *params)
+{
+	struct hl_debug_params_stm *input;
+	u64 base_reg;
+	int rc;
+
+	if (params->reg_idx >= ARRAY_SIZE(debug_stm_regs)) {
+		dev_err(hdev->dev, "Invalid register index in STM\n");
+		return -EINVAL;
+	}
+
+	base_reg = debug_stm_regs[params->reg_idx] - CFG_BASE;
+
+	WREG32(base_reg + 0xFB0, CORESIGHT_UNLOCK);
+
+	if (params->enable) {
+		input = params->input;
+
+		if (!input)
+			return -EINVAL;
+
+		WREG32(base_reg + 0xE80, 0x80004);
+		WREG32(base_reg + 0xD64, 7);
+		WREG32(base_reg + 0xD60, 0);
+		WREG32(base_reg + 0xD00, lower_32_bits(input->he_mask));
+		WREG32(base_reg + 0xD60, 1);
+		WREG32(base_reg + 0xD00, upper_32_bits(input->he_mask));
+		WREG32(base_reg + 0xE70, 0x10);
+		WREG32(base_reg + 0xE60, 0);
+		WREG32(base_reg + 0xE00, lower_32_bits(input->sp_mask));
+		WREG32(base_reg + 0xEF4, input->id);
+		WREG32(base_reg + 0xDF4, 0x80);
+		WREG32(base_reg + 0xE8C, input->frequency);
+		WREG32(base_reg + 0xE90, 0x7FF);
+
+		/* SW-2176 - SW WA for HW bug */
+		if ((CFG_BASE + base_reg) >= mmDMA_CH_0_CS_STM_BASE &&
+			(CFG_BASE + base_reg) <= mmDMA_CH_7_CS_STM_BASE) {
+
+			WREG32(base_reg + 0xE68, 0xffff8005);
+			WREG32(base_reg + 0xE6C, 0x0);
+		}
+
+		WREG32(base_reg + 0xE80, 0x27 | (input->id << 16));
+	} else {
+		WREG32(base_reg + 0xE80, 4);
+		WREG32(base_reg + 0xD64, 0);
+		WREG32(base_reg + 0xD60, 1);
+		WREG32(base_reg + 0xD00, 0);
+		WREG32(base_reg + 0xD20, 0);
+		WREG32(base_reg + 0xD60, 0);
+		WREG32(base_reg + 0xE20, 0);
+		WREG32(base_reg + 0xE00, 0);
+		WREG32(base_reg + 0xDF4, 0x80);
+		WREG32(base_reg + 0xE70, 0);
+		WREG32(base_reg + 0xE60, 0);
+		WREG32(base_reg + 0xE64, 0);
+		WREG32(base_reg + 0xE8C, 0);
+
+		rc = gaudi_coresight_timeout(hdev, base_reg + 0xE80, 23, false);
+		if (rc) {
+			dev_err(hdev->dev,
+				"Failed to disable STM on timeout, error %d\n",
+				rc);
+			return rc;
+		}
+
+		WREG32(base_reg + 0xE80, 4);
+	}
+
+	return 0;
+}
+
+static int gaudi_config_etf(struct hl_device *hdev,
+		struct hl_debug_params *params)
+{
+	struct hl_debug_params_etf *input;
+	u64 base_reg;
+	u32 val;
+	int rc;
+
+	if (params->reg_idx >= ARRAY_SIZE(debug_etf_regs)) {
+		dev_err(hdev->dev, "Invalid register index in ETF\n");
+		return -EINVAL;
+	}
+
+	base_reg = debug_etf_regs[params->reg_idx] - CFG_BASE;
+
+	WREG32(base_reg + 0xFB0, CORESIGHT_UNLOCK);
+
+	val = RREG32(base_reg + 0x304);
+	val |= 0x1000;
+	WREG32(base_reg + 0x304, val);
+	val |= 0x40;
+	WREG32(base_reg + 0x304, val);
+
+	rc = gaudi_coresight_timeout(hdev, base_reg + 0x304, 6, false);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to %s ETF on timeout, error %d\n",
+				params->enable ? "enable" : "disable", rc);
+		return rc;
+	}
+
+	rc = gaudi_coresight_timeout(hdev, base_reg + 0xC, 2, true);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to %s ETF on timeout, error %d\n",
+				params->enable ? "enable" : "disable", rc);
+		return rc;
+	}
+
+	WREG32(base_reg + 0x20, 0);
+
+	if (params->enable) {
+		input = params->input;
+
+		if (!input)
+			return -EINVAL;
+
+		WREG32(base_reg + 0x34, 0x3FFC);
+		WREG32(base_reg + 0x28, input->sink_mode);
+		WREG32(base_reg + 0x304, 0x4001);
+		WREG32(base_reg + 0x308, 0xA);
+		WREG32(base_reg + 0x20, 1);
+	} else {
+		WREG32(base_reg + 0x34, 0);
+		WREG32(base_reg + 0x28, 0);
+		WREG32(base_reg + 0x304, 0);
+	}
+
+	return 0;
+}
+
+static bool gaudi_etr_validate_address(struct hl_device *hdev, u64 addr,
+					u32 size, bool *is_host)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct gaudi_device *gaudi = hdev->asic_specific;
+
+	/* maximum address length is 50 bits */
+	if (addr >> 50) {
+		dev_err(hdev->dev,
+			"ETR buffer address shouldn't exceed 50 bits\n");
+		return false;
+	}
+
+	/* PMMU and HPMMU addresses are equal, check only one of them */
+	if ((gaudi->hw_cap_initialized & HW_CAP_MMU) &&
+		hl_mem_area_inside_range(addr, size,
+				prop->pmmu.start_addr,
+				prop->pmmu.end_addr)) {
+		*is_host = true;
+		return true;
+	}
+
+	if (hl_mem_area_inside_range(addr, size,
+			prop->dram_user_base_address,
+			prop->dram_end_address))
+		return true;
+
+	if (hl_mem_area_inside_range(addr, size,
+			prop->sram_user_base_address,
+			prop->sram_end_address))
+		return true;
+
+	if (!(gaudi->hw_cap_initialized & HW_CAP_MMU))
+		dev_err(hdev->dev, "ETR buffer should be in SRAM/DRAM\n");
+
+	return false;
+}
+
+static int gaudi_config_etr(struct hl_device *hdev,
+		struct hl_debug_params *params)
+{
+	struct hl_debug_params_etr *input;
+	u64 msb;
+	u32 val;
+	int rc;
+
+	WREG32(mmPSOC_ETR_LAR, CORESIGHT_UNLOCK);
+
+	val = RREG32(mmPSOC_ETR_FFCR);
+	val |= 0x1000;
+	WREG32(mmPSOC_ETR_FFCR, val);
+	val |= 0x40;
+	WREG32(mmPSOC_ETR_FFCR, val);
+
+	rc = gaudi_coresight_timeout(hdev, mmPSOC_ETR_FFCR, 6, false);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to %s ETR on timeout, error %d\n",
+				params->enable ? "enable" : "disable", rc);
+		return rc;
+	}
+
+	rc = gaudi_coresight_timeout(hdev, mmPSOC_ETR_STS, 2, true);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to %s ETR on timeout, error %d\n",
+				params->enable ? "enable" : "disable", rc);
+		return rc;
+	}
+
+	WREG32(mmPSOC_ETR_CTL, 0);
+
+	if (params->enable) {
+		bool is_host = false;
+
+		input = params->input;
+
+		if (!input)
+			return -EINVAL;
+
+		if (input->buffer_size == 0) {
+			dev_err(hdev->dev,
+				"ETR buffer size should be bigger than 0\n");
+			return -EINVAL;
+		}
+
+		if (!gaudi_etr_validate_address(hdev,
+				input->buffer_address, input->buffer_size,
+				&is_host)) {
+			dev_err(hdev->dev, "ETR buffer address is invalid\n");
+			return -EINVAL;
+		}
+
+		msb = upper_32_bits(input->buffer_address) >> 8;
+		msb &= PSOC_GLOBAL_CONF_TRACE_ADDR_MSB_MASK;
+		WREG32(mmPSOC_GLOBAL_CONF_TRACE_ADDR, msb);
+
+		WREG32(mmPSOC_ETR_BUFWM, 0x3FFC);
+		WREG32(mmPSOC_ETR_RSZ, input->buffer_size);
+		WREG32(mmPSOC_ETR_MODE, input->sink_mode);
+		/* Workaround for H3 #HW-2075 bug: use small data chunks */
+		WREG32(mmPSOC_ETR_AXICTL, (is_host ? 0 : 0x700) |
+					PSOC_ETR_AXICTL_PROTCTRLBIT1_SHIFT);
+		WREG32(mmPSOC_ETR_DBALO,
+				lower_32_bits(input->buffer_address));
+		WREG32(mmPSOC_ETR_DBAHI,
+				upper_32_bits(input->buffer_address));
+		WREG32(mmPSOC_ETR_FFCR, 3);
+		WREG32(mmPSOC_ETR_PSCR, 0xA);
+		WREG32(mmPSOC_ETR_CTL, 1);
+	} else {
+		WREG32(mmPSOC_ETR_BUFWM, 0);
+		WREG32(mmPSOC_ETR_RSZ, 0x400);
+		WREG32(mmPSOC_ETR_DBALO, 0);
+		WREG32(mmPSOC_ETR_DBAHI, 0);
+		WREG32(mmPSOC_ETR_PSCR, 0);
+		WREG32(mmPSOC_ETR_MODE, 0);
+		WREG32(mmPSOC_ETR_FFCR, 0);
+
+		if (params->output_size >= sizeof(u64)) {
+			u32 rwp, rwphi;
+
+			/*
+			 * The trace buffer address is 50 bits wide. The end of
+			 * the buffer is set in the RWP register (lower 32
+			 * bits), and in the RWPHI register (upper 8 bits).
+			 * The 10 msb of the 50-bit address are stored in a
+			 * global configuration register.
+			 */
+			rwp = RREG32(mmPSOC_ETR_RWP);
+			rwphi = RREG32(mmPSOC_ETR_RWPHI) & 0xff;
+			msb = RREG32(mmPSOC_GLOBAL_CONF_TRACE_ADDR) &
+					PSOC_GLOBAL_CONF_TRACE_ADDR_MSB_MASK;
+			*(u64 *) params->output = ((u64) msb << 40) |
+						((u64) rwphi << 32) | rwp;
+		}
+	}
+
+	return 0;
+}
+
+static int gaudi_config_funnel(struct hl_device *hdev,
+		struct hl_debug_params *params)
+{
+	u64 base_reg;
+
+	if (params->reg_idx >= ARRAY_SIZE(debug_funnel_regs)) {
+		dev_err(hdev->dev, "Invalid register index in FUNNEL\n");
+		return -EINVAL;
+	}
+
+	base_reg = debug_funnel_regs[params->reg_idx] - CFG_BASE;
+
+	WREG32(base_reg + 0xFB0, CORESIGHT_UNLOCK);
+
+	WREG32(base_reg, params->enable ? 0x33F : 0);
+
+	return 0;
+}
+
+static int gaudi_config_bmon(struct hl_device *hdev,
+		struct hl_debug_params *params)
+{
+	struct hl_debug_params_bmon *input;
+	u64 base_reg;
+
+	if (params->reg_idx >= ARRAY_SIZE(debug_bmon_regs)) {
+		dev_err(hdev->dev, "Invalid register index in BMON\n");
+		return -EINVAL;
+	}
+
+	base_reg = debug_bmon_regs[params->reg_idx] - CFG_BASE;
+
+	WREG32(base_reg + 0x104, 1);
+
+	if (params->enable) {
+		input = params->input;
+
+		if (!input)
+			return -EINVAL;
+
+		WREG32(base_reg + 0x200, lower_32_bits(input->start_addr0));
+		WREG32(base_reg + 0x204, upper_32_bits(input->start_addr0));
+		WREG32(base_reg + 0x208, lower_32_bits(input->addr_mask0));
+		WREG32(base_reg + 0x20C, upper_32_bits(input->addr_mask0));
+		WREG32(base_reg + 0x240, lower_32_bits(input->start_addr1));
+		WREG32(base_reg + 0x244, upper_32_bits(input->start_addr1));
+		WREG32(base_reg + 0x248, lower_32_bits(input->addr_mask1));
+		WREG32(base_reg + 0x24C, upper_32_bits(input->addr_mask1));
+		WREG32(base_reg + 0x224, 0);
+		WREG32(base_reg + 0x234, 0);
+		WREG32(base_reg + 0x30C, input->bw_win);
+		WREG32(base_reg + 0x308, input->win_capture);
+		WREG32(base_reg + 0x700, 0xA000B00 | (input->id << 12));
+		WREG32(base_reg + 0x708, 0xA000A00 | (input->id << 12));
+		WREG32(base_reg + 0x70C, 0xA000C00 | (input->id << 12));
+		WREG32(base_reg + 0x100, 0x11);
+		WREG32(base_reg + 0x304, 0x1);
+	} else {
+		WREG32(base_reg + 0x200, 0);
+		WREG32(base_reg + 0x204, 0);
+		WREG32(base_reg + 0x208, 0xFFFFFFFF);
+		WREG32(base_reg + 0x20C, 0xFFFFFFFF);
+		WREG32(base_reg + 0x240, 0);
+		WREG32(base_reg + 0x244, 0);
+		WREG32(base_reg + 0x248, 0xFFFFFFFF);
+		WREG32(base_reg + 0x24C, 0xFFFFFFFF);
+		WREG32(base_reg + 0x224, 0xFFFFFFFF);
+		WREG32(base_reg + 0x234, 0x1070F);
+		WREG32(base_reg + 0x30C, 0);
+		WREG32(base_reg + 0x308, 0xFFFF);
+		WREG32(base_reg + 0x700, 0xA000B00);
+		WREG32(base_reg + 0x708, 0xA000A00);
+		WREG32(base_reg + 0x70C, 0xA000C00);
+		WREG32(base_reg + 0x100, 1);
+		WREG32(base_reg + 0x304, 0);
+		WREG32(base_reg + 0x104, 0);
+	}
+
+	return 0;
+}
+
+static int gaudi_config_spmu(struct hl_device *hdev,
+		struct hl_debug_params *params)
+{
+	u64 base_reg;
+	struct hl_debug_params_spmu *input = params->input;
+	u64 *output;
+	u32 output_arr_len;
+	u32 events_num;
+	u32 overflow_idx;
+	u32 cycle_cnt_idx;
+	int i;
+
+	if (params->reg_idx >= ARRAY_SIZE(debug_spmu_regs)) {
+		dev_err(hdev->dev, "Invalid register index in SPMU\n");
+		return -EINVAL;
+	}
+
+	base_reg = debug_spmu_regs[params->reg_idx] - CFG_BASE;
+
+	if (params->enable) {
+		input = params->input;
+
+		if (!input)
+			return -EINVAL;
+
+		if (input->event_types_num < 3) {
+			dev_err(hdev->dev,
+				"not enough event types values for SPMU enable\n");
+			return -EINVAL;
+		}
+
+		if (input->event_types_num > SPMU_MAX_COUNTERS) {
+			dev_err(hdev->dev,
+				"too many event types values for SPMU enable\n");
+			return -EINVAL;
+		}
+
+		WREG32(base_reg + 0xE04, 0x41013046);
+		WREG32(base_reg + 0xE04, 0x41013040);
+
+		for (i = 0 ; i < input->event_types_num ; i++)
+			WREG32(base_reg + SPMU_EVENT_TYPES_OFFSET + i * 4,
+				input->event_types[i]);
+
+		WREG32(base_reg + 0xE04, 0x41013041);
+		WREG32(base_reg + 0xC00, 0x8000003F);
+	} else {
+		output = params->output;
+		output_arr_len = params->output_size / 8;
+		events_num = output_arr_len - 2;
+		overflow_idx = output_arr_len - 2;
+		cycle_cnt_idx = output_arr_len - 1;
+
+		if (!output)
+			return -EINVAL;
+
+		if (output_arr_len < 3) {
+			dev_err(hdev->dev,
+				"not enough values for SPMU disable\n");
+			return -EINVAL;
+		}
+
+		if (events_num > SPMU_MAX_COUNTERS) {
+			dev_err(hdev->dev,
+				"too many events values for SPMU disable\n");
+			return -EINVAL;
+		}
+
+		WREG32(base_reg + 0xE04, 0x41013040);
+
+		for (i = 0 ; i < events_num ; i++)
+			output[i] = RREG32(base_reg + i * 8);
+
+		output[overflow_idx] = RREG32(base_reg + 0xCC0);
+
+		output[cycle_cnt_idx] = RREG32(base_reg + 0xFC);
+		output[cycle_cnt_idx] <<= 32;
+		output[cycle_cnt_idx] |= RREG32(base_reg + 0xF8);
+
+		WREG32(base_reg + 0xCC0, 0);
+	}
+
+	return 0;
+}
+
+int gaudi_debug_coresight(struct hl_device *hdev, void *data)
+{
+	struct hl_debug_params *params = data;
+	u32 val;
+	int rc = 0;
+
+	switch (params->op) {
+	case HL_DEBUG_OP_STM:
+		rc = gaudi_config_stm(hdev, params);
+		break;
+	case HL_DEBUG_OP_ETF:
+		rc = gaudi_config_etf(hdev, params);
+		break;
+	case HL_DEBUG_OP_ETR:
+		rc = gaudi_config_etr(hdev, params);
+		break;
+	case HL_DEBUG_OP_FUNNEL:
+		rc = gaudi_config_funnel(hdev, params);
+		break;
+	case HL_DEBUG_OP_BMON:
+		rc = gaudi_config_bmon(hdev, params);
+		break;
+	case HL_DEBUG_OP_SPMU:
+		rc = gaudi_config_spmu(hdev, params);
+		break;
+	case HL_DEBUG_OP_TIMESTAMP:
+		/* Do nothing as this opcode is deprecated */
+		break;
+
+	default:
+		dev_err(hdev->dev, "Unknown coresight id %d\n", params->op);
+		return -EINVAL;
+	}
+
+	/* Perform read from the device to flush all configuration */
+	val = RREG32(mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG);
+
+	return rc;
+}
+
+void gaudi_halt_coresight(struct hl_device *hdev)
+{
+	struct hl_debug_params params = {};
+	int i, rc;
+
+	for (i = GAUDI_ETF_FIRST ; i <= GAUDI_ETF_LAST ; i++) {
+		params.reg_idx = i;
+		rc = gaudi_config_etf(hdev, &params);
+		if (rc)
+			dev_err(hdev->dev, "halt ETF failed, %d/%d\n", rc, i);
+	}
+
+	rc = gaudi_config_etr(hdev, &params);
+	if (rc)
+		dev_err(hdev->dev, "halt ETR failed, %d\n", rc);
+}
-- 
2.17.1

