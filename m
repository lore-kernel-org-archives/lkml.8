Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A880DC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65AD7206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+gESngz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgIDSrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 14:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgIDSqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 14:46:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4885EC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 11:46:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t10so7872737wrv.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 11:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=4Fkf2tZtY9Bklmb/+MYpfCfPf9iYHRKlMHlFvookwok=;
        b=b+gESngz1iFoklgQQ91Y85wbRsvo27NqymyMuEyLRsIqzNsjvEKFIr+/3euoLEr6si
         5zTvcO4e1O5cJy+3nHUnfmedXU6wXIgutbxtjsL8zoSSPExWDfFAbjKbWN/XrB8gWXsh
         3xtBduhT6QOUQtXATB1z++eM2SC8wFLjj+DvbpxhkrNvtMEqg4bAAzt6ksYe0BLjVi7i
         accXKJI1vUG2CspxWauZycM9v5j6P5t6FSjVRnA+7FCdzSyE15FmE9p/r7IJXW5pdMOZ
         AQAyCvd45PlPSF2e0CLp+T6VpQU7jI9tSSYkf6l/yjOvu4RP8KJeBFtZ2cY5JXMRVGZW
         sDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=4Fkf2tZtY9Bklmb/+MYpfCfPf9iYHRKlMHlFvookwok=;
        b=rf6XM0Kdgk3nvFcpsAtYWPCo0BsUYDJUOBaL0kOhCtgy0FRqpadkHZLAd5rNIIOiap
         VtfA+Xn5u14HYlAGMPBJgP85wytidvg3w1HcAbaK0ozvo5UYpNEgigCjkKWl/w6DYoLt
         GmgVKMb4wHDHq/R1l6gwudJAsJIwMzthzR4UEQ80Ze71iAyYckT9QlA8H6Ca1qssJ1Co
         YPw7glXkXhVeZy8urONvaVMAfgy5mkbj96HTpR9x0YDqMqtY+fbSc8g7NR0QYL6QetSL
         BGhJi47FQoaPhYeQpLEswe4bxmq5nFAgu+hBSTO680k8oKDyUSE3Ru7pf8W5gUaWXVgN
         QZ2A==
X-Gm-Message-State: AOAM532RED5AFztTJfD1JGiLvSYjSqHjs8PIvRb98qYpdAvxcceQb6qd
        VRH3dTrCoDfEnxdH4optVfjlbLYLvOQ=
X-Google-Smtp-Source: ABdhPJzv2aTsRG2WreeBZCVDIzDrFPiB1D4y6XyGEDVPf2Wcnw1ELExVt+wau8QgN4LUivAFA5qG2A==
X-Received: by 2002:adf:f984:: with SMTP id f4mr8930806wrr.102.1599245186981;
        Fri, 04 Sep 2020 11:46:26 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id q186sm14111670wma.45.2020.09.04.11.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 11:46:25 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH 1/6] habanalabs: rename ArmCP to CPU-CP
Date:   Fri,  4 Sep 2020 21:46:18 +0300
Message-Id: <20200904184623.13478-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were a couple of comments where the name ArmCP was still used. Rename
it to CPU-CP.

In addition, rename ArmCP or ARM in log messages to "device CPU".

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/firmware_if.c | 17 ++++++++-------
 drivers/misc/habanalabs/common/habanalabs.h  | 22 ++++++++++----------
 drivers/misc/habanalabs/gaudi/gaudi.c        |  4 ++--
 drivers/misc/habanalabs/goya/goya.c          |  2 +-
 4 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index f2a38e95359a..4409962d30ae 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -175,7 +175,7 @@ int hl_fw_unmask_irq_arr(struct hl_device *hdev, const u32 *irq_arr,
 	total_pkt_size = sizeof(struct cpucp_unmask_irq_arr_packet) +
 			irq_arr_size;
 
-	/* data should be aligned to 8 bytes in order to ArmCP to copy it */
+	/* data should be aligned to 8 bytes in order to CPU-CP to copy it */
 	total_pkt_size = (total_pkt_size + 0x7) & ~0x7;
 
 	/* total_pkt_size is casted to u16 later on */
@@ -283,7 +283,7 @@ int hl_fw_cpucp_info_get(struct hl_device *hdev)
 					&cpucp_info_dma_addr);
 	if (!cpucp_info_cpu_addr) {
 		dev_err(hdev->dev,
-			"Failed to allocate DMA memory for ArmCP info packet\n");
+			"Failed to allocate DMA memory for CPU-CP info packet\n");
 		return -ENOMEM;
 	}
 
@@ -298,7 +298,7 @@ int hl_fw_cpucp_info_get(struct hl_device *hdev)
 					HL_CPUCP_INFO_TIMEOUT_USEC, &result);
 	if (rc) {
 		dev_err(hdev->dev,
-			"Failed to handle ArmCP info pkt, error %d\n", rc);
+			"Failed to handle CPU-CP info pkt, error %d\n", rc);
 		goto out;
 	}
 
@@ -333,7 +333,7 @@ int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size)
 					max_size, &eeprom_info_dma_addr);
 	if (!eeprom_info_cpu_addr) {
 		dev_err(hdev->dev,
-			"Failed to allocate DMA memory for ArmCP EEPROM packet\n");
+			"Failed to allocate DMA memory for CPU-CP EEPROM packet\n");
 		return -ENOMEM;
 	}
 
@@ -349,7 +349,8 @@ int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size)
 
 	if (rc) {
 		dev_err(hdev->dev,
-			"Failed to handle ArmCP EEPROM packet, error %d\n", rc);
+			"Failed to handle CPU-CP EEPROM packet, error %d\n",
+			rc);
 		goto out;
 	}
 
@@ -379,7 +380,7 @@ int hl_fw_cpucp_pci_counters_get(struct hl_device *hdev,
 					HL_CPUCP_INFO_TIMEOUT_USEC, &result);
 	if (rc) {
 		dev_err(hdev->dev,
-			"Failed to handle ArmCP PCI info pkt, error %d\n", rc);
+			"Failed to handle CPU-CP PCI info pkt, error %d\n", rc);
 		return rc;
 	}
 	counters->rx_throughput = result;
@@ -390,7 +391,7 @@ int hl_fw_cpucp_pci_counters_get(struct hl_device *hdev,
 					HL_CPUCP_INFO_TIMEOUT_USEC, &result);
 	if (rc) {
 		dev_err(hdev->dev,
-			"Failed to handle ArmCP PCI info pkt, error %d\n", rc);
+			"Failed to handle CPU-CP PCI info pkt, error %d\n", rc);
 		return rc;
 	}
 	counters->tx_throughput = result;
@@ -403,7 +404,7 @@ int hl_fw_cpucp_pci_counters_get(struct hl_device *hdev,
 			HL_CPUCP_INFO_TIMEOUT_USEC, &result);
 	if (rc) {
 		dev_err(hdev->dev,
-			"Failed to handle ArmCP PCI info pkt, error %d\n", rc);
+			"Failed to handle CPU-CP PCI info pkt, error %d\n", rc);
 		return rc;
 	}
 	counters->replay_cnt = (u32) result;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 6ea8ae616cf4..b56410d75065 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -466,7 +466,7 @@ struct hl_cs_job;
 #define HL_EQ_LENGTH			64
 #define HL_EQ_SIZE_IN_BYTES		(HL_EQ_LENGTH * HL_EQ_ENTRY_SIZE)
 
-/* Host <-> ArmCP shared memory size */
+/* Host <-> CPU-CP shared memory size */
 #define HL_CPU_ACCESSIBLE_MEM_SIZE	SZ_2M
 
 /**
@@ -648,7 +648,7 @@ enum div_select_defs {
  * @debugfs_read32: debug interface for reading u32 from DRAM/SRAM.
  * @debugfs_write32: debug interface for writing u32 to DRAM/SRAM.
  * @add_device_attr: add ASIC specific device attributes.
- * @handle_eqe: handle event queue entry (IRQ) from ArmCP.
+ * @handle_eqe: handle event queue entry (IRQ) from CPU-CP.
  * @set_pll_profile: change PLL profile (manual/automatic).
  * @get_events_stat: retrieve event queue entries histogram.
  * @read_pte: read MMU page table entry from DRAM.
@@ -657,7 +657,7 @@ enum div_select_defs {
  *                        (L1 only) or hard (L0 & L1) flush.
  * @mmu_invalidate_cache_range: flush specific MMU STLB cache lines with
  *                              ASID-VA-size mask.
- * @send_heartbeat: send is-alive packet to ArmCP and verify response.
+ * @send_heartbeat: send is-alive packet to CPU-CP and verify response.
  * @set_clock_gating: enable/disable clock gating per engine according to
  *                    clock gating mask in hdev
  * @disable_clock_gating: disable clock gating completely
@@ -1438,8 +1438,8 @@ struct hl_device_idle_busy_ts {
  * @dev: related kernel basic device structure.
  * @dev_ctrl: related kernel device structure for the control device
  * @work_freq: delayed work to lower device frequency if possible.
- * @work_heartbeat: delayed work for ArmCP is-alive check.
- * @asic_name: ASIC specific nmae.
+ * @work_heartbeat: delayed work for CPU-CP is-alive check.
+ * @asic_name: ASIC specific name.
  * @asic_type: ASIC specific type.
  * @completion_queue: array of hl_cq.
  * @cq_wq: work queues of completion queues for executing work in process
@@ -1450,14 +1450,14 @@ struct hl_device_idle_busy_ts {
  * @hw_queues_mirror_list: CS mirror list for TDR.
  * @hw_queues_mirror_lock: protects hw_queues_mirror_list.
  * @kernel_cb_mgr: command buffer manager for creating/destroying/handling CGs.
- * @event_queue: event queue for IRQ from ArmCP.
+ * @event_queue: event queue for IRQ from CPU-CP.
  * @dma_pool: DMA pool for small allocations.
- * @cpu_accessible_dma_mem: Host <-> ArmCP shared memory CPU address.
- * @cpu_accessible_dma_address: Host <-> ArmCP shared memory DMA address.
- * @cpu_accessible_dma_pool: Host <-> ArmCP shared memory pool.
+ * @cpu_accessible_dma_mem: Host <-> CPU-CP shared memory CPU address.
+ * @cpu_accessible_dma_address: Host <-> CPU-CP shared memory DMA address.
+ * @cpu_accessible_dma_pool: Host <-> CPU-CP shared memory pool.
  * @asid_bitmap: holds used/available ASIDs.
  * @asid_mutex: protects asid_bitmap.
- * @send_cpu_message_lock: enforces only one message in Host <-> ArmCP queue.
+ * @send_cpu_message_lock: enforces only one message in Host <-> CPU-CP queue.
  * @debug_lock: protects critical section of setting debug mode for device
  * @asic_prop: ASIC specific immutable properties.
  * @asic_funcs: ASIC specific functions.
@@ -1511,7 +1511,7 @@ struct hl_device_idle_busy_ts {
  * @late_init_done: is late init stage was done during initialization.
  * @hwmon_initialized: is H/W monitor sensors was initialized.
  * @hard_reset_pending: is there a hard reset work pending.
- * @heartbeat: is heartbeat sanity check towards ArmCP enabled.
+ * @heartbeat: is heartbeat sanity check towards CPU-CP enabled.
  * @reset_on_lockup: true if a reset should be done in case of stuck CS, false
  *                   otherwise.
  * @dram_supports_virtual_memory: is MMU enabled towards DRAM.
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index bc7e7e3ba3a8..7946179632fb 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -2854,7 +2854,7 @@ static int gaudi_init_cpu_queues(struct hl_device *hdev, u32 cpu_timeout)
 
 	if (err) {
 		dev_err(hdev->dev,
-			"Failed to communicate with ARM CPU (ArmCP timeout)\n");
+			"Failed to communicate with Device CPU (CPU-CP timeout)\n");
 		return -EIO;
 	}
 
@@ -5616,7 +5616,7 @@ static bool gaudi_tpc_read_interrupts(struct hl_device *hdev, u8 tpc_id,
 	bool soft_reset_required = false;
 
 	/* Accessing the TPC_INTR_CAUSE registers requires disabling the clock
-	 * gating, and thus cannot be done in ArmCP and should be done instead
+	 * gating, and thus cannot be done in CPU-CP and should be done instead
 	 * by the driver.
 	 */
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 94b7958ba5fb..fb7e4f50c198 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4509,7 +4509,7 @@ static int goya_unmask_irq_arr(struct hl_device *hdev, u32 *irq_arr,
 	total_pkt_size = sizeof(struct cpucp_unmask_irq_arr_packet) +
 			irq_arr_size;
 
-	/* data should be aligned to 8 bytes in order to ArmCP to copy it */
+	/* data should be aligned to 8 bytes in order to CPU-CP to copy it */
 	total_pkt_size = (total_pkt_size + 0x7) & ~0x7;
 
 	/* total_pkt_size is casted to u16 later on */
-- 
2.17.1

