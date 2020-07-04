Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB80FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 21:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A480420CC7
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 21:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0kyQ6xh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgGDV3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 17:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgGDV3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 17:29:53 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8DFC061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 14:29:52 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o2so37735889wmh.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 14:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f4ffDNMvZHyojT7Jb6jRJ6a52bJY7G7AQQz2cABNlEQ=;
        b=T0kyQ6xhec/4GJsXUbdxVSHCnrBlBmq7HmvkOmT0FiTxNCZCq4E0MPEmGrVO3KSu1w
         ftcgJgG9eigvUSoBSIekFqmI6/dsnXwzl5ZpDNQH4pMUGlyaa+lzySLC5BaEjA4CaDJ9
         K+yXE9UWZqdlASAULL2KJphscWOnzJz4SvvXZEon2iyBPwMxAwbA08N6Qbd6Vyu+31SI
         xQIj1mufiQ37KYOe+BCPK7sJBMXps7R1Y5RPOFH796O+3K9ojMnRbE+f4umZcBlK7/QU
         i84jLcxE9wtw3XY9K9ce4apRehpvTQ1hY5mSmvUt37ATrluU+pqHH6qjBhuORZQaxM58
         OWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f4ffDNMvZHyojT7Jb6jRJ6a52bJY7G7AQQz2cABNlEQ=;
        b=pUekZIQ6KBwQ6H3JwOn32/4rof34+Kauayr6HwRRriBfOiUU0qKLSj0bCg5W5e1Kbg
         8gpfaV8aOYVi7S1R1BD0d3cPQ5dWnTvMJE/vW+EeWjeWCw9+EqAhUXVpCq0L4dem43p0
         6kcU10UJJqCDOIuJ5GahU7fCuExFr0uEC/nNBW6wBt4k/WRRwxL9wt3XIZNCbjEew6JJ
         dsXsxEoaVNPZ7U9tB3G2GijoCCmGlX2jz/bVVirgoRb+hDcHsHMSF1EIfwP9hS5i+BY6
         YJGGWPnSFuCXNwptodR59z2Q1PwqeOnK5QfwPzdNCT0BXToQ5+pL6pHDi6z//9SQO097
         ve9g==
X-Gm-Message-State: AOAM532veZyAy4DY2jhhsoXA8wkeb78JyTf/qaTXjStF1ikx8ewhcjAf
        YZw3s78QXuThp0ljEWI85j2VImbH
X-Google-Smtp-Source: ABdhPJwdLh7znvgXw7PpJRg5SxM/1ECn9b/8CNI6WS9kC1lJ9Os4odP53raRb/aWhLEU4F+uGpzt3w==
X-Received: by 2002:a1c:a4c6:: with SMTP id n189mr41335046wme.173.1593898190870;
        Sat, 04 Jul 2020 14:29:50 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id x7sm18397141wrr.72.2020.07.04.14.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 14:29:49 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 2/2] habanalabs: set clock gating per engine
Date:   Sun,  5 Jul 2020 00:29:51 +0300
Message-Id: <20200704212951.20062-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200704212951.20062-1-oded.gabbay@gmail.com>
References: <20200704212951.20062-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For debugging purposes, we need to allow the root user better control of
the clock gating feature of the DMA and compute engines. Therefore, change
the clock gating debugfs interface to be bitmask instead of true/false.
Each bit represents a different engine, according to gaudi_engine_id enum.

See debugfs documentation for more details.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 .../ABI/testing/debugfs-driver-habanalabs     |  11 +-
 drivers/misc/habanalabs/debugfs.c             |  17 +--
 drivers/misc/habanalabs/device.c              |   2 +-
 drivers/misc/habanalabs/gaudi/gaudi.c         | 112 ++++++++++++------
 drivers/misc/habanalabs/goya/goya.c           |   8 +-
 drivers/misc/habanalabs/habanalabs.h          |  13 +-
 drivers/misc/habanalabs/habanalabs_drv.c      |   2 +-
 7 files changed, 103 insertions(+), 62 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-driver-habanalabs b/Documentation/ABI/testing/debugfs-driver-habanalabs
index f6d9c2a8d528..2e9ae311e02d 100644
--- a/Documentation/ABI/testing/debugfs-driver-habanalabs
+++ b/Documentation/ABI/testing/debugfs-driver-habanalabs
@@ -16,7 +16,16 @@ Description:    Allow the root user to disable/enable in runtime the clock
                 gating mechanism in Gaudi. Due to how Gaudi is built, the
                 clock gating needs to be disabled in order to access the
                 registers of the TPC and MME engines. This is sometimes needed
-                during debug by the user and hence the user needs this option
+                during debug by the user and hence the user needs this option.
+                The user can supply a bitmask value, each bit represents
+                a different engine to disable/enable its clock gating feature.
+                The bitmask is composed of 20 bits:
+                0  -  7 : DMA channels
+                8  - 11 : MME engines
+                12 - 19 : TPC engines
+                The bit's location of a specific engine can be determined
+                using (1 << GAUDI_ENGINE_ID_*). GAUDI_ENGINE_ID_* values
+                are defined in uapi habanalabs.h file in enum gaudi_engine_id
 
 What:           /sys/kernel/debug/habanalabs/hl<n>/command_buffers
 Date:           Jan 2019
diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/debugfs.c
index fc4372c18ce2..136b8f6fa0b3 100644
--- a/drivers/misc/habanalabs/debugfs.c
+++ b/drivers/misc/habanalabs/debugfs.c
@@ -981,7 +981,7 @@ static ssize_t hl_clk_gate_read(struct file *f, char __user *buf,
 	if (*ppos)
 		return 0;
 
-	sprintf(tmp_buf, "%d\n", hdev->clock_gating);
+	sprintf(tmp_buf, "0x%llx\n", hdev->clock_gating_mask);
 	rc = simple_read_from_buffer(buf, strlen(tmp_buf) + 1, ppos, tmp_buf,
 			strlen(tmp_buf) + 1);
 
@@ -993,7 +993,7 @@ static ssize_t hl_clk_gate_write(struct file *f, const char __user *buf,
 {
 	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
 	struct hl_device *hdev = entry->hdev;
-	u32 value;
+	u64 value;
 	ssize_t rc;
 
 	if (atomic_read(&hdev->in_reset)) {
@@ -1002,19 +1002,12 @@ static ssize_t hl_clk_gate_write(struct file *f, const char __user *buf,
 		return 0;
 	}
 
-	rc = kstrtouint_from_user(buf, count, 10, &value);
+	rc = kstrtoull_from_user(buf, count, 16, &value);
 	if (rc)
 		return rc;
 
-	if (value) {
-		hdev->clock_gating = 1;
-		if (hdev->asic_funcs->enable_clock_gating)
-			hdev->asic_funcs->enable_clock_gating(hdev);
-	} else {
-		if (hdev->asic_funcs->disable_clock_gating)
-			hdev->asic_funcs->disable_clock_gating(hdev);
-		hdev->clock_gating = 0;
-	}
+	hdev->clock_gating_mask = value;
+	hdev->asic_funcs->set_clock_gating(hdev);
 
 	return count;
 }
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 2b38a119704c..59608d1bac88 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -608,7 +608,7 @@ int hl_device_set_debug_mode(struct hl_device *hdev, bool enable)
 		hdev->in_debug = 0;
 
 		if (!hdev->hard_reset_pending)
-			hdev->asic_funcs->enable_clock_gating(hdev);
+			hdev->asic_funcs->set_clock_gating(hdev);
 
 		goto out;
 	}
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index e22206527164..9d6aebef8854 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -98,6 +98,11 @@
 
 #define GAUDI_ARB_WDT_TIMEOUT		0x1000000
 
+#define GAUDI_CLK_GATE_DEBUGFS_MASK	(\
+		BIT(GAUDI_ENGINE_ID_MME_0) |\
+		BIT(GAUDI_ENGINE_ID_MME_2) |\
+		GENMASK_ULL(GAUDI_ENGINE_ID_TPC_7, GAUDI_ENGINE_ID_TPC_0))
+
 static const char gaudi_irq_name[GAUDI_MSI_ENTRIES][GAUDI_MAX_STRING_LEN] = {
 		"gaudi cq 0_0", "gaudi cq 0_1", "gaudi cq 0_2", "gaudi cq 0_3",
 		"gaudi cq 1_0", "gaudi cq 1_1", "gaudi cq 1_2", "gaudi cq 1_3",
@@ -106,14 +111,14 @@ static const char gaudi_irq_name[GAUDI_MSI_ENTRIES][GAUDI_MAX_STRING_LEN] = {
 };
 
 static const u8 gaudi_dma_assignment[GAUDI_DMA_MAX] = {
-	[GAUDI_PCI_DMA_1] = 0,
-	[GAUDI_PCI_DMA_2] = 1,
-	[GAUDI_PCI_DMA_3] = 5,
-	[GAUDI_HBM_DMA_1] = 2,
-	[GAUDI_HBM_DMA_2] = 3,
-	[GAUDI_HBM_DMA_3] = 4,
-	[GAUDI_HBM_DMA_4] = 6,
-	[GAUDI_HBM_DMA_5] = 7
+	[GAUDI_PCI_DMA_1] = GAUDI_ENGINE_ID_DMA_0,
+	[GAUDI_PCI_DMA_2] = GAUDI_ENGINE_ID_DMA_1,
+	[GAUDI_PCI_DMA_3] = GAUDI_ENGINE_ID_DMA_5,
+	[GAUDI_HBM_DMA_1] = GAUDI_ENGINE_ID_DMA_2,
+	[GAUDI_HBM_DMA_2] = GAUDI_ENGINE_ID_DMA_3,
+	[GAUDI_HBM_DMA_3] = GAUDI_ENGINE_ID_DMA_4,
+	[GAUDI_HBM_DMA_4] = GAUDI_ENGINE_ID_DMA_6,
+	[GAUDI_HBM_DMA_5] = GAUDI_ENGINE_ID_DMA_7
 };
 
 static const u8 gaudi_cq_assignment[NUMBER_OF_CMPLT_QUEUES] = {
@@ -1819,7 +1824,7 @@ static void gaudi_init_golden_registers(struct hl_device *hdev)
 
 	gaudi_init_rate_limiter(hdev);
 
-	gaudi_disable_clock_gating(hdev);
+	hdev->asic_funcs->disable_clock_gating(hdev);
 
 	for (tpc_id = 0, tpc_offset = 0;
 				tpc_id < TPC_NUMBER_OF_ENGINES;
@@ -2531,46 +2536,55 @@ static void gaudi_tpc_stall(struct hl_device *hdev)
 	WREG32(mmTPC7_CFG_TPC_STALL, 1 << TPC0_CFG_TPC_STALL_V_SHIFT);
 }
 
-static void gaudi_enable_clock_gating(struct hl_device *hdev)
+static void gaudi_set_clock_gating(struct hl_device *hdev)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
 	u32 qman_offset;
 	int i;
 
-	if (!hdev->clock_gating)
-		return;
-
-	if (gaudi->hw_cap_initialized & HW_CAP_CLK_GATE)
-		return;
-
 	/* In case we are during debug session, don't enable the clock gate
 	 * as it may interfere
 	 */
 	if (hdev->in_debug)
 		return;
 
-	for (i = 0, qman_offset = 0 ; i < PCI_DMA_NUMBER_OF_CHNLS ; i++) {
+	for (i = GAUDI_PCI_DMA_1, qman_offset = 0 ; i < GAUDI_HBM_DMA_1 ; i++) {
+		if (!(hdev->clock_gating_mask &
+					(BIT_ULL(gaudi_dma_assignment[i]))))
+			continue;
+
 		qman_offset = gaudi_dma_assignment[i] * DMA_QMAN_OFFSET;
 		WREG32(mmDMA0_QM_CGM_CFG1 + qman_offset, QMAN_CGM1_PWR_GATE_EN);
 		WREG32(mmDMA0_QM_CGM_CFG + qman_offset,
 				QMAN_UPPER_CP_CGM_PWR_GATE_EN);
 	}
 
-	for (; i < HBM_DMA_NUMBER_OF_CHNLS ; i++) {
+	for (i = GAUDI_HBM_DMA_1 ; i < GAUDI_DMA_MAX ; i++) {
+		if (!(hdev->clock_gating_mask &
+					(BIT_ULL(gaudi_dma_assignment[i]))))
+			continue;
+
 		qman_offset = gaudi_dma_assignment[i] * DMA_QMAN_OFFSET;
 		WREG32(mmDMA0_QM_CGM_CFG1 + qman_offset, QMAN_CGM1_PWR_GATE_EN);
 		WREG32(mmDMA0_QM_CGM_CFG + qman_offset,
 				QMAN_COMMON_CP_CGM_PWR_GATE_EN);
 	}
 
-	WREG32(mmMME0_QM_CGM_CFG1, QMAN_CGM1_PWR_GATE_EN);
-	WREG32(mmMME0_QM_CGM_CFG,
-			QMAN_COMMON_CP_CGM_PWR_GATE_EN);
-	WREG32(mmMME2_QM_CGM_CFG1, QMAN_CGM1_PWR_GATE_EN);
-	WREG32(mmMME2_QM_CGM_CFG,
-			QMAN_COMMON_CP_CGM_PWR_GATE_EN);
+	if (hdev->clock_gating_mask & (BIT_ULL(GAUDI_ENGINE_ID_MME_0))) {
+		WREG32(mmMME0_QM_CGM_CFG1, QMAN_CGM1_PWR_GATE_EN);
+		WREG32(mmMME0_QM_CGM_CFG, QMAN_COMMON_CP_CGM_PWR_GATE_EN);
+	}
+
+	if (hdev->clock_gating_mask & (BIT_ULL(GAUDI_ENGINE_ID_MME_2))) {
+		WREG32(mmMME2_QM_CGM_CFG1, QMAN_CGM1_PWR_GATE_EN);
+		WREG32(mmMME2_QM_CGM_CFG, QMAN_COMMON_CP_CGM_PWR_GATE_EN);
+	}
 
 	for (i = 0, qman_offset = 0 ; i < TPC_NUMBER_OF_ENGINES ; i++) {
+		if (!(hdev->clock_gating_mask &
+					(BIT_ULL(GAUDI_ENGINE_ID_TPC_0 + i))))
+			continue;
+
 		WREG32(mmTPC0_QM_CGM_CFG1 + qman_offset,
 				QMAN_CGM1_PWR_GATE_EN);
 		WREG32(mmTPC0_QM_CGM_CFG + qman_offset,
@@ -2663,7 +2677,7 @@ static void gaudi_halt_engines(struct hl_device *hdev, bool hard_reset)
 	gaudi_stop_hbm_dma_qmans(hdev);
 	gaudi_stop_pci_dma_qmans(hdev);
 
-	gaudi_disable_clock_gating(hdev);
+	hdev->asic_funcs->disable_clock_gating(hdev);
 
 	msleep(wait_timeout_ms);
 
@@ -3003,7 +3017,7 @@ static int gaudi_hw_init(struct hl_device *hdev)
 
 	gaudi_init_tpc_qmans(hdev);
 
-	gaudi_enable_clock_gating(hdev);
+	hdev->asic_funcs->set_clock_gating(hdev);
 
 	gaudi_enable_timestamp(hdev);
 
@@ -3112,7 +3126,9 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 					HW_CAP_HBM_DMA | HW_CAP_PLL |
 					HW_CAP_MMU |
 					HW_CAP_SRAM_SCRAMBLER |
-					HW_CAP_HBM_SCRAMBLER);
+					HW_CAP_HBM_SCRAMBLER |
+					HW_CAP_CLK_GATE);
+
 	memset(gaudi->events_stat, 0, sizeof(gaudi->events_stat));
 }
 
@@ -4526,13 +4542,18 @@ static int gaudi_debugfs_read32(struct hl_device *hdev, u64 addr, u32 *val)
 	int rc = 0;
 
 	if ((addr >= CFG_BASE) && (addr < CFG_BASE + CFG_SIZE)) {
-		if (gaudi->hw_cap_initialized & HW_CAP_CLK_GATE) {
+
+		if ((gaudi->hw_cap_initialized & HW_CAP_CLK_GATE) &&
+				(hdev->clock_gating_mask &
+						GAUDI_CLK_GATE_DEBUGFS_MASK)) {
+
 			dev_err_ratelimited(hdev->dev,
 				"Can't read register - clock gating is enabled!\n");
 			rc = -EFAULT;
 		} else {
 			*val = RREG32(addr - CFG_BASE);
 		}
+
 	} else if ((addr >= SRAM_BASE_ADDR) &&
 			(addr < SRAM_BASE_ADDR + SRAM_BAR_SIZE)) {
 		*val = readl(hdev->pcie_bar[SRAM_BAR_ID] +
@@ -4568,13 +4589,18 @@ static int gaudi_debugfs_write32(struct hl_device *hdev, u64 addr, u32 val)
 	int rc = 0;
 
 	if ((addr >= CFG_BASE) && (addr < CFG_BASE + CFG_SIZE)) {
-		if (gaudi->hw_cap_initialized & HW_CAP_CLK_GATE) {
+
+		if ((gaudi->hw_cap_initialized & HW_CAP_CLK_GATE) &&
+				(hdev->clock_gating_mask &
+						GAUDI_CLK_GATE_DEBUGFS_MASK)) {
+
 			dev_err_ratelimited(hdev->dev,
 				"Can't write register - clock gating is enabled!\n");
 			rc = -EFAULT;
 		} else {
 			WREG32(addr - CFG_BASE, val);
 		}
+
 	} else if ((addr >= SRAM_BASE_ADDR) &&
 			(addr < SRAM_BASE_ADDR + SRAM_BAR_SIZE)) {
 		writel(val, hdev->pcie_bar[SRAM_BAR_ID] +
@@ -4610,7 +4636,11 @@ static int gaudi_debugfs_read64(struct hl_device *hdev, u64 addr, u64 *val)
 	int rc = 0;
 
 	if ((addr >= CFG_BASE) && (addr <= CFG_BASE + CFG_SIZE - sizeof(u64))) {
-		if (gaudi->hw_cap_initialized & HW_CAP_CLK_GATE) {
+
+		if ((gaudi->hw_cap_initialized & HW_CAP_CLK_GATE) &&
+				(hdev->clock_gating_mask &
+						GAUDI_CLK_GATE_DEBUGFS_MASK)) {
+
 			dev_err_ratelimited(hdev->dev,
 				"Can't read register - clock gating is enabled!\n");
 			rc = -EFAULT;
@@ -4620,6 +4650,7 @@ static int gaudi_debugfs_read64(struct hl_device *hdev, u64 addr, u64 *val)
 
 			*val = (((u64) val_h) << 32) | val_l;
 		}
+
 	} else if ((addr >= SRAM_BASE_ADDR) &&
 		   (addr <= SRAM_BASE_ADDR + SRAM_BAR_SIZE - sizeof(u64))) {
 		*val = readq(hdev->pcie_bar[SRAM_BAR_ID] +
@@ -4656,7 +4687,11 @@ static int gaudi_debugfs_write64(struct hl_device *hdev, u64 addr, u64 val)
 	int rc = 0;
 
 	if ((addr >= CFG_BASE) && (addr <= CFG_BASE + CFG_SIZE - sizeof(u64))) {
-		if (gaudi->hw_cap_initialized & HW_CAP_CLK_GATE) {
+
+		if ((gaudi->hw_cap_initialized & HW_CAP_CLK_GATE) &&
+				(hdev->clock_gating_mask &
+						GAUDI_CLK_GATE_DEBUGFS_MASK)) {
+
 			dev_err_ratelimited(hdev->dev,
 				"Can't write register - clock gating is enabled!\n");
 			rc = -EFAULT;
@@ -4665,6 +4700,7 @@ static int gaudi_debugfs_write64(struct hl_device *hdev, u64 addr, u64 val)
 			WREG32(addr + sizeof(u32) - CFG_BASE,
 				upper_32_bits(val));
 		}
+
 	} else if ((addr >= SRAM_BASE_ADDR) &&
 		   (addr <= SRAM_BASE_ADDR + SRAM_BAR_SIZE - sizeof(u64))) {
 		writeq(val, hdev->pcie_bar[SRAM_BAR_ID] +
@@ -4886,7 +4922,7 @@ static void gaudi_mmu_prepare(struct hl_device *hdev, u32 asid)
 	gaudi_mmu_prepare_reg(hdev, mmPSOC_GLOBAL_CONF_TRACE_ARUSER, asid);
 	gaudi_mmu_prepare_reg(hdev, mmPSOC_GLOBAL_CONF_TRACE_AWUSER, asid);
 
-	hdev->asic_funcs->enable_clock_gating(hdev);
+	hdev->asic_funcs->set_clock_gating(hdev);
 
 	mutex_unlock(&gaudi->clk_gate_mutex);
 }
@@ -5267,7 +5303,7 @@ static void gaudi_print_ecc_info_generic(struct hl_device *hdev,
 	}
 
 	if (disable_clock_gating) {
-		hdev->asic_funcs->enable_clock_gating(hdev);
+		hdev->asic_funcs->set_clock_gating(hdev);
 		mutex_unlock(&gaudi->clk_gate_mutex);
 	}
 }
@@ -5754,7 +5790,7 @@ static bool gaudi_tpc_read_interrupts(struct hl_device *hdev, u8 tpc_id,
 	/* Clear interrupts */
 	WREG32(mmTPC0_CFG_TPC_INTR_CAUSE + tpc_offset, 0);
 
-	hdev->asic_funcs->enable_clock_gating(hdev);
+	hdev->asic_funcs->set_clock_gating(hdev);
 
 	mutex_unlock(&gaudi->clk_gate_mutex);
 
@@ -6270,7 +6306,7 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u32 *mask,
 	if (s)
 		seq_puts(s, "\n");
 
-	hdev->asic_funcs->enable_clock_gating(hdev);
+	hdev->asic_funcs->set_clock_gating(hdev);
 
 	mutex_unlock(&gaudi->clk_gate_mutex);
 
@@ -6371,7 +6407,7 @@ static int gaudi_run_tpc_kernel(struct hl_device *hdev, u64 tpc_kernel,
 		dev_err(hdev->dev,
 			"Timeout while waiting for TPC%d icache prefetch\n",
 			tpc_id);
-		hdev->asic_funcs->enable_clock_gating(hdev);
+		hdev->asic_funcs->set_clock_gating(hdev);
 		mutex_unlock(&gaudi->clk_gate_mutex);
 		return -EIO;
 	}
@@ -6400,7 +6436,7 @@ static int gaudi_run_tpc_kernel(struct hl_device *hdev, u64 tpc_kernel,
 		1000,
 		kernel_timeout);
 
-	hdev->asic_funcs->enable_clock_gating(hdev);
+	hdev->asic_funcs->set_clock_gating(hdev);
 	mutex_unlock(&gaudi->clk_gate_mutex);
 
 	if (rc) {
@@ -6741,7 +6777,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.mmu_invalidate_cache = gaudi_mmu_invalidate_cache,
 	.mmu_invalidate_cache_range = gaudi_mmu_invalidate_cache_range,
 	.send_heartbeat = gaudi_send_heartbeat,
-	.enable_clock_gating = gaudi_enable_clock_gating,
+	.set_clock_gating = gaudi_set_clock_gating,
 	.disable_clock_gating = gaudi_disable_clock_gating,
 	.debug_coresight = gaudi_debug_coresight,
 	.is_device_idle = gaudi_is_device_idle,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 0d2952bb58df..83f0c70f140b 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5028,14 +5028,14 @@ int goya_armcp_info_get(struct hl_device *hdev)
 	return 0;
 }
 
-static void goya_enable_clock_gating(struct hl_device *hdev)
+static void goya_set_clock_gating(struct hl_device *hdev)
 {
-
+	/* clock gating not supported in Goya */
 }
 
 static void goya_disable_clock_gating(struct hl_device *hdev)
 {
-
+	/* clock gating not supported in Goya */
 }
 
 static bool goya_is_device_idle(struct hl_device *hdev, u32 *mask,
@@ -5259,7 +5259,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.mmu_invalidate_cache = goya_mmu_invalidate_cache,
 	.mmu_invalidate_cache_range = goya_mmu_invalidate_cache_range,
 	.send_heartbeat = goya_send_heartbeat,
-	.enable_clock_gating = goya_enable_clock_gating,
+	.set_clock_gating = goya_set_clock_gating,
 	.disable_clock_gating = goya_disable_clock_gating,
 	.debug_coresight = goya_debug_coresight,
 	.is_device_idle = goya_is_device_idle,
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 1ecdcf8b763a..dee5cc25fe5b 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -578,8 +578,9 @@ enum hl_pll_frequency {
  * @mmu_invalidate_cache_range: flush specific MMU STLB cache lines with
  *                              ASID-VA-size mask.
  * @send_heartbeat: send is-alive packet to ArmCP and verify response.
- * @enable_clock_gating: enable clock gating for reducing power consumption.
- * @disable_clock_gating: disable clock for accessing registers on HBW.
+ * @set_clock_gating: enable/disable clock gating per engine according to
+ *                    clock gating mask in hdev
+ * @disable_clock_gating: disable clock gating completely
  * @debug_coresight: perform certain actions on Coresight for debugging.
  * @is_device_idle: return true if device is idle, false otherwise.
  * @soft_reset_late_init: perform certain actions needed after soft reset.
@@ -680,7 +681,7 @@ struct hl_asic_funcs {
 	int (*mmu_invalidate_cache_range)(struct hl_device *hdev, bool is_hard,
 			u32 asid, u64 va, u64 size);
 	int (*send_heartbeat)(struct hl_device *hdev);
-	void (*enable_clock_gating)(struct hl_device *hdev);
+	void (*set_clock_gating)(struct hl_device *hdev);
 	void (*disable_clock_gating)(struct hl_device *hdev);
 	int (*debug_coresight)(struct hl_device *hdev, void *data);
 	bool (*is_device_idle)(struct hl_device *hdev, u32 *mask,
@@ -1398,6 +1399,9 @@ struct hl_device_idle_busy_ts {
  * @max_power: the max power of the device, as configured by the sysadmin. This
  *             value is saved so in case of hard-reset, the driver will restore
  *             this value and update the F/W after the re-initialization
+ * @clock_gating_mask: is clock gating enabled. bitmask that represents the
+ *                     different engines. See debugfs-driver-habanalabs for
+ *                     details.
  * @in_reset: is device in reset flow.
  * @curr_pll_profile: current PLL profile.
  * @cs_active_cnt: number of active command submissions on this device (active
@@ -1425,7 +1429,6 @@ struct hl_device_idle_busy_ts {
  * @init_done: is the initialization of the device done.
  * @mmu_enable: is MMU enabled.
  * @mmu_huge_page_opt: is MMU huge pages optimization enabled.
- * @clock_gating: is clock gating enabled.
  * @device_cpu_disabled: is the device CPU disabled (due to timeouts)
  * @dma_mask: the dma mask that was set for this device
  * @in_debug: is device under debug. This, together with fpriv_list, enforces
@@ -1493,6 +1496,7 @@ struct hl_device {
 	atomic64_t			dram_used_mem;
 	u64				timeout_jiffies;
 	u64				max_power;
+	u64				clock_gating_mask;
 	atomic_t			in_reset;
 	enum hl_pll_frequency		curr_pll_profile;
 	int				cs_active_cnt;
@@ -1514,7 +1518,6 @@ struct hl_device {
 	u8				dram_default_page_mapping;
 	u8				pmmu_huge_range;
 	u8				init_done;
-	u8				clock_gating;
 	u8				device_cpu_disabled;
 	u8				dma_mask;
 	u8				in_debug;
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index 8652c7e5d7f1..22716da9f85f 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -232,7 +232,7 @@ static void set_driver_behavior_per_device(struct hl_device *hdev)
 	hdev->fw_loading = 1;
 	hdev->cpu_queues_enable = 1;
 	hdev->heartbeat = 1;
-	hdev->clock_gating = 1;
+	hdev->clock_gating_mask = ULONG_MAX;
 
 	hdev->reset_pcilink = 0;
 	hdev->axi_drain = 0;
-- 
2.17.1

