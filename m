Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC38C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA9C6206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3RwV7oR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgEORyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 13:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726023AbgEORyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:54:06 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1FAC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 10:54:05 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id h4so3159877wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 10:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zIquj/FZAg1XcbdFwXppYvP8B6tWj+cODejsx+a6m1s=;
        b=H3RwV7oROdH61R1949PBIRaBPJOoux1OtLlGq+q89j6TN9fj0k3pYJAWqvSqZ1CtEm
         oEJCM7hGydKbzV5lo6eY0UxSSg9cN7Hgy/nbIdmMlAD2Y+mXFyT1vVUoVzvsTGglWXKN
         xDiMVUvshSC15hxLqSGp3ctaxgoEnQ3qG0Vc2/nuBaaPXvIv1lCzDa2o7H5cCuqV4opW
         IHvkvoSdCkbk5wOQ0Iw8L4yZ8N8pu2CGZ7JMthW1P9YziEulM8orA9J2WPUh43NFCRA+
         zmKE164H+yyJ7I9jd8uHgwp8IPY90CRnxzIwYqJ7ry2IOMZDKYc6K7c9PgnEVWNkSx07
         e31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zIquj/FZAg1XcbdFwXppYvP8B6tWj+cODejsx+a6m1s=;
        b=g0bkeY8p25fgSHXXWTj99U9gX+/LM7io5DOr3YD8/DkuAVMbfaSTL6qUHtGnA9uTVY
         WLpXODmtWwjGwFqEMQvjeCtvXc6UvJQP9YP0wmm3c/suzgecC0UszqLwdV+s1yR5dFJI
         WG52rLJWUQ0BK+gI0iM1se1g11S3UFIQXVpReePVs72vzJBkVRpm9no5assueDpNPIGI
         CDVKfztjZ5rBA9XlXdsQhUOr4nFWwtiJWmMQ91cc1pc6oGPDabIhf0tg1egU+I3YSyEC
         pNF14bwZdJ09FxP2NTmkcoH6RrVtwRJPakRtoupyOXiDLwVnnuZW0Bt5XkXuijLaQ4C2
         AwAQ==
X-Gm-Message-State: AOAM532iwTCRuczbzciPmPHTtDBd5VJkW46UTWtHZfDars+h8Urr78DC
        od3xyDZLhHj/G0feBMWK/Abxrt3C
X-Google-Smtp-Source: ABdhPJyeuXNlZGPJulOYyFVykpqbramaid6e0B79Zlz05vg/wG9urMWlK3MMytzZBEMKmO/61TeHQw==
X-Received: by 2002:a1c:545b:: with SMTP id p27mr4983735wmi.81.1589565240623;
        Fri, 15 May 2020 10:54:00 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id o205sm4487347wmo.32.2020.05.15.10.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 10:53:59 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: move event handling to common firmware file
Date:   Fri, 15 May 2020 20:53:56 +0300
Message-Id: <20200515175356.12555-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Instead of writing similar event handling code for each ASIC, move the code
to the common firmware file. This code will be used for GAUDI and all
future ASICs.

In addition, add two new fields to the auto-generated events file: valid
and description. This will save the need to manually write the events
description in the source code and simplify the code.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/firmware_if.c         |  63 ++
 drivers/misc/habanalabs/gaudi/gaudi.c         | 714 +-----------------
 drivers/misc/habanalabs/gaudi/gaudiP.h        |   2 +
 drivers/misc/habanalabs/habanalabs.h          |   3 +
 .../include/gaudi/gaudi_async_ids_map.h       | 687 -----------------
 .../gaudi/gaudi_async_ids_map_extended.h      | 694 +++++++++++++++++
 6 files changed, 801 insertions(+), 1362 deletions(-)
 delete mode 100644 drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h

diff --git a/drivers/misc/habanalabs/firmware_if.c b/drivers/misc/habanalabs/firmware_if.c
index ba3fbf136f15..baf790cf4b78 100644
--- a/drivers/misc/habanalabs/firmware_if.c
+++ b/drivers/misc/habanalabs/firmware_if.c
@@ -11,6 +11,7 @@
 #include <linux/firmware.h>
 #include <linux/genalloc.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/slab.h>
 
 /**
  * hl_fw_load_fw_to_device() - Load F/W code to device's memory.
@@ -130,6 +131,68 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 	return rc;
 }
 
+int hl_fw_unmask_irq(struct hl_device *hdev, u16 event_type)
+{
+	struct armcp_packet pkt;
+	long result;
+	int rc;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = cpu_to_le32(ARMCP_PACKET_UNMASK_RAZWI_IRQ <<
+				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.value = cpu_to_le64(event_type);
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+			HL_DEVICE_TIMEOUT_USEC, &result);
+
+	if (rc)
+		dev_err(hdev->dev, "failed to unmask RAZWI IRQ %d", event_type);
+
+	return rc;
+}
+
+int hl_fw_unmask_irq_arr(struct hl_device *hdev, const u32 *irq_arr,
+		size_t irq_arr_size)
+{
+	struct armcp_unmask_irq_arr_packet *pkt;
+	size_t total_pkt_size;
+	long result;
+	int rc;
+
+	total_pkt_size = sizeof(struct armcp_unmask_irq_arr_packet) +
+			irq_arr_size;
+
+	/* data should be aligned to 8 bytes in order to ArmCP to copy it */
+	total_pkt_size = (total_pkt_size + 0x7) & ~0x7;
+
+	/* total_pkt_size is casted to u16 later on */
+	if (total_pkt_size > USHRT_MAX) {
+		dev_err(hdev->dev, "too many elements in IRQ array\n");
+		return -EINVAL;
+	}
+
+	pkt = kzalloc(total_pkt_size, GFP_KERNEL);
+	if (!pkt)
+		return -ENOMEM;
+
+	pkt->length = cpu_to_le32(irq_arr_size / sizeof(irq_arr[0]));
+	memcpy(&pkt->irqs, irq_arr, irq_arr_size);
+
+	pkt->armcp_pkt.ctl = cpu_to_le32(ARMCP_PACKET_UNMASK_RAZWI_IRQ_ARRAY <<
+						ARMCP_PKT_CTL_OPCODE_SHIFT);
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) pkt,
+			total_pkt_size, HL_DEVICE_TIMEOUT_USEC, &result);
+
+	if (rc)
+		dev_err(hdev->dev, "failed to unmask IRQ array\n");
+
+	kfree(pkt);
+
+	return rc;
+}
+
 int hl_fw_test_cpu_queue(struct hl_device *hdev)
 {
 	struct armcp_packet test_pkt = {};
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index af8cc08ff0ad..73c6142b0659 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -11,7 +11,7 @@
 #include "include/gaudi/gaudi_masks.h"
 #include "include/gaudi/gaudi_fw_if.h"
 #include "include/gaudi/gaudi_reg_map.h"
-#include "include/gaudi/gaudi_async_ids_map.h"
+#include "include/gaudi/gaudi_async_ids_map_extended.h"
 
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -148,278 +148,6 @@ static const u16 gaudi_packet_sizes[MAX_PACKET_ID] = {
 	[PACKET_LOAD_AND_EXE]	= sizeof(struct packet_load_and_exe)
 };
 
-static const u32 gaudi_all_events[] = {
-	GAUDI_EVENT_PCIE_CORE_SERR,
-	GAUDI_EVENT_PCIE_CORE_DERR,
-	GAUDI_EVENT_PCIE_IF_SERR,
-	GAUDI_EVENT_PCIE_IF_DERR,
-	GAUDI_EVENT_PCIE_PHY_SERR,
-	GAUDI_EVENT_PCIE_PHY_DERR,
-	GAUDI_EVENT_TPC0_SERR,
-	GAUDI_EVENT_TPC1_SERR,
-	GAUDI_EVENT_TPC2_SERR,
-	GAUDI_EVENT_TPC3_SERR,
-	GAUDI_EVENT_TPC4_SERR,
-	GAUDI_EVENT_TPC5_SERR,
-	GAUDI_EVENT_TPC6_SERR,
-	GAUDI_EVENT_TPC7_SERR,
-	GAUDI_EVENT_TPC0_DERR,
-	GAUDI_EVENT_TPC1_DERR,
-	GAUDI_EVENT_TPC2_DERR,
-	GAUDI_EVENT_TPC3_DERR,
-	GAUDI_EVENT_TPC4_DERR,
-	GAUDI_EVENT_TPC5_DERR,
-	GAUDI_EVENT_TPC6_DERR,
-	GAUDI_EVENT_TPC7_DERR,
-	GAUDI_EVENT_MME0_ACC_SERR,
-	GAUDI_EVENT_MME0_ACC_DERR,
-	GAUDI_EVENT_MME0_SBAB_SERR,
-	GAUDI_EVENT_MME0_SBAB_DERR,
-	GAUDI_EVENT_MME1_ACC_SERR,
-	GAUDI_EVENT_MME1_ACC_DERR,
-	GAUDI_EVENT_MME1_SBAB_SERR,
-	GAUDI_EVENT_MME1_SBAB_DERR,
-	GAUDI_EVENT_MME2_ACC_SERR,
-	GAUDI_EVENT_MME2_ACC_DERR,
-	GAUDI_EVENT_MME2_SBAB_SERR,
-	GAUDI_EVENT_MME2_SBAB_DERR,
-	GAUDI_EVENT_MME3_ACC_SERR,
-	GAUDI_EVENT_MME3_ACC_DERR,
-	GAUDI_EVENT_MME3_SBAB_SERR,
-	GAUDI_EVENT_MME3_SBAB_DERR,
-	GAUDI_EVENT_DMA0_SERR_ECC,
-	GAUDI_EVENT_DMA1_SERR_ECC,
-	GAUDI_EVENT_DMA2_SERR_ECC,
-	GAUDI_EVENT_DMA3_SERR_ECC,
-	GAUDI_EVENT_DMA4_SERR_ECC,
-	GAUDI_EVENT_DMA5_SERR_ECC,
-	GAUDI_EVENT_DMA6_SERR_ECC,
-	GAUDI_EVENT_DMA7_SERR_ECC,
-	GAUDI_EVENT_DMA0_DERR_ECC,
-	GAUDI_EVENT_DMA1_DERR_ECC,
-	GAUDI_EVENT_DMA2_DERR_ECC,
-	GAUDI_EVENT_DMA3_DERR_ECC,
-	GAUDI_EVENT_DMA4_DERR_ECC,
-	GAUDI_EVENT_DMA5_DERR_ECC,
-	GAUDI_EVENT_DMA6_DERR_ECC,
-	GAUDI_EVENT_DMA7_DERR_ECC,
-	GAUDI_EVENT_CPU_IF_ECC_SERR,
-	GAUDI_EVENT_CPU_IF_ECC_DERR,
-	GAUDI_EVENT_PSOC_MEM_SERR,
-	GAUDI_EVENT_PSOC_CORESIGHT_SERR,
-	GAUDI_EVENT_PSOC_MEM_DERR,
-	GAUDI_EVENT_PSOC_CORESIGHT_DERR,
-	GAUDI_EVENT_SRAM0_SERR,
-	GAUDI_EVENT_SRAM1_SERR,
-	GAUDI_EVENT_SRAM2_SERR,
-	GAUDI_EVENT_SRAM3_SERR,
-	GAUDI_EVENT_SRAM7_SERR,
-	GAUDI_EVENT_SRAM6_SERR,
-	GAUDI_EVENT_SRAM5_SERR,
-	GAUDI_EVENT_SRAM4_SERR,
-	GAUDI_EVENT_SRAM8_SERR,
-	GAUDI_EVENT_SRAM9_SERR,
-	GAUDI_EVENT_SRAM10_SERR,
-	GAUDI_EVENT_SRAM11_SERR,
-	GAUDI_EVENT_SRAM15_SERR,
-	GAUDI_EVENT_SRAM14_SERR,
-	GAUDI_EVENT_SRAM13_SERR,
-	GAUDI_EVENT_SRAM12_SERR,
-	GAUDI_EVENT_SRAM16_SERR,
-	GAUDI_EVENT_SRAM17_SERR,
-	GAUDI_EVENT_SRAM18_SERR,
-	GAUDI_EVENT_SRAM19_SERR,
-	GAUDI_EVENT_SRAM23_SERR,
-	GAUDI_EVENT_SRAM22_SERR,
-	GAUDI_EVENT_SRAM21_SERR,
-	GAUDI_EVENT_SRAM20_SERR,
-	GAUDI_EVENT_SRAM24_SERR,
-	GAUDI_EVENT_SRAM25_SERR,
-	GAUDI_EVENT_SRAM26_SERR,
-	GAUDI_EVENT_SRAM27_SERR,
-	GAUDI_EVENT_SRAM31_SERR,
-	GAUDI_EVENT_SRAM30_SERR,
-	GAUDI_EVENT_SRAM29_SERR,
-	GAUDI_EVENT_SRAM28_SERR,
-	GAUDI_EVENT_SRAM0_DERR,
-	GAUDI_EVENT_SRAM1_DERR,
-	GAUDI_EVENT_SRAM2_DERR,
-	GAUDI_EVENT_SRAM3_DERR,
-	GAUDI_EVENT_SRAM7_DERR,
-	GAUDI_EVENT_SRAM6_DERR,
-	GAUDI_EVENT_SRAM5_DERR,
-	GAUDI_EVENT_SRAM4_DERR,
-	GAUDI_EVENT_SRAM8_DERR,
-	GAUDI_EVENT_SRAM9_DERR,
-	GAUDI_EVENT_SRAM10_DERR,
-	GAUDI_EVENT_SRAM11_DERR,
-	GAUDI_EVENT_SRAM15_DERR,
-	GAUDI_EVENT_SRAM14_DERR,
-	GAUDI_EVENT_SRAM13_DERR,
-	GAUDI_EVENT_SRAM12_DERR,
-	GAUDI_EVENT_SRAM16_DERR,
-	GAUDI_EVENT_SRAM17_DERR,
-	GAUDI_EVENT_SRAM18_DERR,
-	GAUDI_EVENT_SRAM19_DERR,
-	GAUDI_EVENT_SRAM23_DERR,
-	GAUDI_EVENT_SRAM22_DERR,
-	GAUDI_EVENT_SRAM21_DERR,
-	GAUDI_EVENT_SRAM20_DERR,
-	GAUDI_EVENT_SRAM24_DERR,
-	GAUDI_EVENT_SRAM25_DERR,
-	GAUDI_EVENT_SRAM26_DERR,
-	GAUDI_EVENT_SRAM27_DERR,
-	GAUDI_EVENT_SRAM31_DERR,
-	GAUDI_EVENT_SRAM30_DERR,
-	GAUDI_EVENT_SRAM29_DERR,
-	GAUDI_EVENT_SRAM28_DERR,
-	GAUDI_EVENT_NIC0_SERR,
-	GAUDI_EVENT_NIC1_SERR,
-	GAUDI_EVENT_NIC2_SERR,
-	GAUDI_EVENT_NIC3_SERR,
-	GAUDI_EVENT_NIC4_SERR,
-	GAUDI_EVENT_NIC0_DERR,
-	GAUDI_EVENT_NIC1_DERR,
-	GAUDI_EVENT_NIC2_DERR,
-	GAUDI_EVENT_NIC3_DERR,
-	GAUDI_EVENT_NIC4_DERR,
-	GAUDI_EVENT_DMA_IF0_SERR,
-	GAUDI_EVENT_DMA_IF1_SERR,
-	GAUDI_EVENT_DMA_IF2_SERR,
-	GAUDI_EVENT_DMA_IF3_SERR,
-	GAUDI_EVENT_DMA_IF0_DERR,
-	GAUDI_EVENT_DMA_IF1_DERR,
-	GAUDI_EVENT_DMA_IF2_DERR,
-	GAUDI_EVENT_DMA_IF3_DERR,
-	GAUDI_EVENT_GIC500,
-	GAUDI_EVENT_HBM_0_SERR,
-	GAUDI_EVENT_HBM_1_SERR,
-	GAUDI_EVENT_HBM_2_SERR,
-	GAUDI_EVENT_HBM_3_SERR,
-	GAUDI_EVENT_HBM_0_DERR,
-	GAUDI_EVENT_HBM_1_DERR,
-	GAUDI_EVENT_HBM_2_DERR,
-	GAUDI_EVENT_HBM_3_DERR,
-	GAUDI_EVENT_MMU_SERR,
-	GAUDI_EVENT_MMU_DERR,
-	GAUDI_EVENT_PCIE_DEC,
-	GAUDI_EVENT_TPC0_DEC,
-	GAUDI_EVENT_TPC1_DEC,
-	GAUDI_EVENT_TPC2_DEC,
-	GAUDI_EVENT_TPC3_DEC,
-	GAUDI_EVENT_TPC4_DEC,
-	GAUDI_EVENT_TPC5_DEC,
-	GAUDI_EVENT_TPC6_DEC,
-	GAUDI_EVENT_TPC7_DEC,
-	GAUDI_EVENT_AXI_ECC,
-	GAUDI_EVENT_L2_RAM_ECC,
-	GAUDI_EVENT_MME0_WBC_RSP,
-	GAUDI_EVENT_MME0_SBAB0_RSP,
-	GAUDI_EVENT_MME1_WBC_RSP,
-	GAUDI_EVENT_MME1_SBAB0_RSP,
-	GAUDI_EVENT_MME2_WBC_RSP,
-	GAUDI_EVENT_MME2_SBAB0_RSP,
-	GAUDI_EVENT_MME3_WBC_RSP,
-	GAUDI_EVENT_MME3_SBAB0_RSP,
-	GAUDI_EVENT_PLL0,
-	GAUDI_EVENT_PLL1,
-	GAUDI_EVENT_PLL2,
-	GAUDI_EVENT_PLL3,
-	GAUDI_EVENT_PLL4,
-	GAUDI_EVENT_PLL5,
-	GAUDI_EVENT_PLL6,
-	GAUDI_EVENT_PLL7,
-	GAUDI_EVENT_PLL8,
-	GAUDI_EVENT_PLL9,
-	GAUDI_EVENT_PLL10,
-	GAUDI_EVENT_PLL11,
-	GAUDI_EVENT_PLL12,
-	GAUDI_EVENT_PLL13,
-	GAUDI_EVENT_PLL14,
-	GAUDI_EVENT_PLL15,
-	GAUDI_EVENT_PLL16,
-	GAUDI_EVENT_PLL17,
-	GAUDI_EVENT_CPU_AXI_SPLITTER,
-	GAUDI_EVENT_PSOC_AXI_DEC,
-	GAUDI_EVENT_PSOC_PRSTN_FALL,
-	GAUDI_EVENT_TPC0_BMON_SPMU,
-	GAUDI_EVENT_TPC0_KRN_ERR,
-	GAUDI_EVENT_TPC1_BMON_SPMU,
-	GAUDI_EVENT_TPC1_KRN_ERR,
-	GAUDI_EVENT_TPC2_BMON_SPMU,
-	GAUDI_EVENT_TPC2_KRN_ERR,
-	GAUDI_EVENT_TPC3_BMON_SPMU,
-	GAUDI_EVENT_TPC3_KRN_ERR,
-	GAUDI_EVENT_TPC4_BMON_SPMU,
-	GAUDI_EVENT_TPC4_KRN_ERR,
-	GAUDI_EVENT_TPC5_BMON_SPMU,
-	GAUDI_EVENT_TPC5_KRN_ERR,
-	GAUDI_EVENT_TPC6_BMON_SPMU,
-	GAUDI_EVENT_TPC6_KRN_ERR,
-	GAUDI_EVENT_TPC7_BMON_SPMU,
-	GAUDI_EVENT_TPC7_KRN_ERR,
-	GAUDI_EVENT_MMU_PAGE_FAULT,
-	GAUDI_EVENT_MMU_WR_PERM,
-	GAUDI_EVENT_DMA_BM_CH0,
-	GAUDI_EVENT_DMA_BM_CH1,
-	GAUDI_EVENT_DMA_BM_CH2,
-	GAUDI_EVENT_DMA_BM_CH3,
-	GAUDI_EVENT_DMA_BM_CH4,
-	GAUDI_EVENT_DMA_BM_CH5,
-	GAUDI_EVENT_DMA_BM_CH6,
-	GAUDI_EVENT_DMA_BM_CH7,
-	GAUDI_EVENT_HBM0_SPI_0,
-	GAUDI_EVENT_HBM0_SPI_1,
-	GAUDI_EVENT_HBM1_SPI_0,
-	GAUDI_EVENT_HBM1_SPI_1,
-	GAUDI_EVENT_HBM2_SPI_0,
-	GAUDI_EVENT_HBM2_SPI_1,
-	GAUDI_EVENT_HBM3_SPI_0,
-	GAUDI_EVENT_HBM3_SPI_1,
-	GAUDI_EVENT_RAZWI_OR_ADC,
-	GAUDI_EVENT_TPC0_QM,
-	GAUDI_EVENT_TPC1_QM,
-	GAUDI_EVENT_TPC2_QM,
-	GAUDI_EVENT_TPC3_QM,
-	GAUDI_EVENT_TPC4_QM,
-	GAUDI_EVENT_TPC5_QM,
-	GAUDI_EVENT_TPC6_QM,
-	GAUDI_EVENT_TPC7_QM,
-	GAUDI_EVENT_MME0_QM,
-	GAUDI_EVENT_MME2_QM,
-	GAUDI_EVENT_DMA0_QM,
-	GAUDI_EVENT_DMA1_QM,
-	GAUDI_EVENT_DMA2_QM,
-	GAUDI_EVENT_DMA3_QM,
-	GAUDI_EVENT_DMA4_QM,
-	GAUDI_EVENT_DMA5_QM,
-	GAUDI_EVENT_DMA6_QM,
-	GAUDI_EVENT_DMA7_QM,
-	GAUDI_EVENT_NIC0_QM0,
-	GAUDI_EVENT_NIC0_QM1,
-	GAUDI_EVENT_NIC1_QM0,
-	GAUDI_EVENT_NIC1_QM1,
-	GAUDI_EVENT_NIC2_QM0,
-	GAUDI_EVENT_NIC2_QM1,
-	GAUDI_EVENT_NIC3_QM0,
-	GAUDI_EVENT_NIC3_QM1,
-	GAUDI_EVENT_NIC4_QM0,
-	GAUDI_EVENT_NIC4_QM1,
-	GAUDI_EVENT_DMA0_CORE,
-	GAUDI_EVENT_DMA1_CORE,
-	GAUDI_EVENT_DMA2_CORE,
-	GAUDI_EVENT_DMA3_CORE,
-	GAUDI_EVENT_DMA4_CORE,
-	GAUDI_EVENT_DMA5_CORE,
-	GAUDI_EVENT_DMA6_CORE,
-	GAUDI_EVENT_DMA7_CORE,
-	GAUDI_EVENT_FIX_POWER_ENV_S,
-	GAUDI_EVENT_FIX_POWER_ENV_E,
-	GAUDI_EVENT_FIX_THERMAL_ENV_S,
-	GAUDI_EVENT_FIX_THERMAL_ENV_E,
-	GAUDI_EVENT_RAZWI_OR_ADC_SW
-};
-
 static const char * const
 gaudi_tpc_interrupts_cause[GAUDI_NUM_OF_TPC_INTR_CAUSE] = {
 	"tpc_address_exceed_slm",
@@ -1133,6 +861,7 @@ static int gaudi_alloc_internal_qmans_pq_mem(struct hl_device *hdev)
 static int gaudi_sw_init(struct hl_device *hdev)
 {
 	struct gaudi_device *gaudi;
+	u32 i, event_id = 0;
 	int rc;
 
 	/* Allocate device structure */
@@ -1140,6 +869,21 @@ static int gaudi_sw_init(struct hl_device *hdev)
 	if (!gaudi)
 		return -ENOMEM;
 
+	for (i = 0 ; i < ARRAY_SIZE(gaudi_irq_map_table) ; i++) {
+		if (gaudi_irq_map_table[i].valid) {
+			if (event_id == GAUDI_EVENT_SIZE) {
+				dev_err(hdev->dev,
+					"Event array exceeds the limit of %u events\n",
+					GAUDI_EVENT_SIZE);
+				rc = -EINVAL;
+				goto free_gaudi_device;
+			}
+
+			gaudi->events[event_id++] =
+					gaudi_irq_map_table[i].fc_id;
+		}
+	}
+
 	gaudi->armcp_info_get = gaudi_armcp_info_get;
 
 	gaudi->max_freq_value = GAUDI_MAX_CLK_FREQ;
@@ -2908,7 +2652,7 @@ static void gaudi_halt_engines(struct hl_device *hdev, bool hard_reset)
 		 */
 		WREG32(mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU, KMD_MSG_GOTO_WFE);
 		WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR,
-			GAUDI_EVENT_HALT_MACHINE);
+				GAUDI_EVENT_HALT_MACHINE);
 		msleep(cpu_timeout_ms);
 	}
 
@@ -5190,339 +4934,20 @@ static int gaudi_send_job_on_qman0(struct hl_device *hdev,
 	return rc;
 }
 
-static const char *_gaudi_get_event_desc(u16 event_type)
-{
-	switch (event_type) {
-	case GAUDI_EVENT_PCIE_CORE_SERR:
-		return "PCIe_core_serr";
-	case GAUDI_EVENT_PCIE_CORE_DERR:
-		return "PCIe_core_derr";
-	case GAUDI_EVENT_PCIE_IF_SERR:
-		return "PCIe_if_serr";
-	case GAUDI_EVENT_PCIE_IF_DERR:
-		return "PCIe_if_derr";
-	case GAUDI_EVENT_PCIE_PHY_SERR:
-		return "PCIe_phy_serr";
-	case GAUDI_EVENT_PCIE_PHY_DERR:
-		return "PCIe_phy_derr";
-	case GAUDI_EVENT_TPC0_SERR ... GAUDI_EVENT_TPC7_SERR:
-		return "TPC%d_Serr";
-	case GAUDI_EVENT_TPC0_DERR ... GAUDI_EVENT_TPC7_DERR:
-		return "TPC%d_Derr";
-	case GAUDI_EVENT_MME0_ACC_SERR:
-	case GAUDI_EVENT_MME1_ACC_SERR:
-	case GAUDI_EVENT_MME2_ACC_SERR:
-	case GAUDI_EVENT_MME3_ACC_SERR:
-		return "MME%d_acc_serr";
-	case GAUDI_EVENT_MME0_ACC_DERR:
-	case GAUDI_EVENT_MME1_ACC_DERR:
-	case GAUDI_EVENT_MME2_ACC_DERR:
-	case GAUDI_EVENT_MME3_ACC_DERR:
-		return "MME%d_acc_derr";
-	case GAUDI_EVENT_MME0_SBAB_SERR:
-	case GAUDI_EVENT_MME1_SBAB_SERR:
-	case GAUDI_EVENT_MME2_SBAB_SERR:
-	case GAUDI_EVENT_MME3_SBAB_SERR:
-		return "MME%d_sbab_serr";
-	case GAUDI_EVENT_MME0_SBAB_DERR:
-	case GAUDI_EVENT_MME1_SBAB_DERR:
-	case GAUDI_EVENT_MME2_SBAB_DERR:
-	case GAUDI_EVENT_MME3_SBAB_DERR:
-		return "MME%d_sbab_derr";
-	case GAUDI_EVENT_DMA0_SERR_ECC ... GAUDI_EVENT_DMA7_SERR_ECC:
-		return "DMA%d_serr_ecc";
-	case GAUDI_EVENT_DMA0_DERR_ECC ... GAUDI_EVENT_DMA7_DERR_ECC:
-		return "DMA%d_derr_ecc";
-	case GAUDI_EVENT_CPU_IF_ECC_SERR:
-		return "CPU_if_ecc_serr";
-	case GAUDI_EVENT_CPU_IF_ECC_DERR:
-		return "CPU_if_ecc_derr";
-	case GAUDI_EVENT_PSOC_MEM_SERR:
-		return "PSOC_mem_serr";
-	case GAUDI_EVENT_PSOC_MEM_DERR:
-		return "PSOC_mem_derr";
-	case GAUDI_EVENT_PSOC_CORESIGHT_SERR:
-		return "PSOC_coresight_serr";
-	case GAUDI_EVENT_PSOC_CORESIGHT_DERR:
-		return "PSOC_coresight_derr";
-	case GAUDI_EVENT_SRAM0_SERR ... GAUDI_EVENT_SRAM28_SERR:
-		return "SRAM%d_serr";
-	case GAUDI_EVENT_SRAM0_DERR ... GAUDI_EVENT_SRAM28_DERR:
-		return "SRAM%d_derr";
-	case GAUDI_EVENT_DMA_IF0_SERR ... GAUDI_EVENT_DMA_IF3_SERR:
-		return "DMA%d_if_serr";
-	case GAUDI_EVENT_DMA_IF0_DERR ... GAUDI_EVENT_DMA_IF3_DERR:
-		return "DMA%d_if_derr";
-	case GAUDI_EVENT_GIC500:
-		return "GIC500";
-	case GAUDI_EVENT_HBM_0_SERR ... GAUDI_EVENT_HBM_3_SERR:
-		return "HBM%d_serr";
-	case GAUDI_EVENT_HBM_0_DERR ... GAUDI_EVENT_HBM_3_DERR:
-		return "HBM%d_derr";
-	case GAUDI_EVENT_MMU_SERR:
-		return "MMU_serr";
-	case GAUDI_EVENT_MMU_DERR:
-		return "MMU_derr";
-	case GAUDI_EVENT_PCIE_DEC:
-		return "PCIe_dec";
-	case GAUDI_EVENT_TPC0_DEC:
-	case GAUDI_EVENT_TPC1_DEC:
-	case GAUDI_EVENT_TPC2_DEC:
-	case GAUDI_EVENT_TPC3_DEC:
-	case GAUDI_EVENT_TPC4_DEC:
-	case GAUDI_EVENT_TPC5_DEC:
-	case GAUDI_EVENT_TPC6_DEC:
-	case GAUDI_EVENT_TPC7_DEC:
-		return "TPC%d_dec";
-	case GAUDI_EVENT_AXI_ECC:
-		return "AXI_ecc";
-	case GAUDI_EVENT_L2_RAM_ECC:
-		return "L2_ram_ecc";
-	case GAUDI_EVENT_MME0_WBC_RSP:
-	case GAUDI_EVENT_MME1_WBC_RSP:
-	case GAUDI_EVENT_MME2_WBC_RSP:
-	case GAUDI_EVENT_MME3_WBC_RSP:
-		return "MME%d_wbc_rsp";
-	case GAUDI_EVENT_MME0_SBAB0_RSP:
-	case GAUDI_EVENT_MME1_SBAB0_RSP:
-	case GAUDI_EVENT_MME2_SBAB0_RSP:
-	case GAUDI_EVENT_MME3_SBAB0_RSP:
-		return "MME%d_sbab0_rsp";
-	case GAUDI_EVENT_PLL0 ... GAUDI_EVENT_PLL17:
-		return "PLL%d";
-	case GAUDI_EVENT_CPU_AXI_SPLITTER:
-		return "CPU_axi_splitter";
-	case GAUDI_EVENT_PSOC_AXI_DEC:
-		return "CPU_axi_dec";
-	case GAUDI_EVENT_PSOC_PRSTN_FALL:
-		return "PSOC_prstn_fall";
-	case GAUDI_EVENT_TPC0_BMON_SPMU:
-	case GAUDI_EVENT_TPC1_BMON_SPMU:
-	case GAUDI_EVENT_TPC2_BMON_SPMU:
-	case GAUDI_EVENT_TPC3_BMON_SPMU:
-	case GAUDI_EVENT_TPC4_BMON_SPMU:
-	case GAUDI_EVENT_TPC5_BMON_SPMU:
-	case GAUDI_EVENT_TPC6_BMON_SPMU:
-	case GAUDI_EVENT_TPC7_BMON_SPMU:
-		return "TPC%d_bmon_spmu";
-	case GAUDI_EVENT_TPC0_KRN_ERR:
-	case GAUDI_EVENT_TPC1_KRN_ERR:
-	case GAUDI_EVENT_TPC2_KRN_ERR:
-	case GAUDI_EVENT_TPC3_KRN_ERR:
-	case GAUDI_EVENT_TPC4_KRN_ERR:
-	case GAUDI_EVENT_TPC5_KRN_ERR:
-	case GAUDI_EVENT_TPC6_KRN_ERR:
-	case GAUDI_EVENT_TPC7_KRN_ERR:
-		return "TPC%d_krn_err";
-	case GAUDI_EVENT_MMU_PAGE_FAULT:
-		return "MMU_page_fault";
-	case GAUDI_EVENT_MMU_WR_PERM:
-		return "MMU_write_permission";
-	case GAUDI_EVENT_DMA_BM_CH0 ... GAUDI_EVENT_DMA_BM_CH7:
-		return "DMA_bm_ch%d";
-	case GAUDI_EVENT_HBM0_SPI_0:
-	case GAUDI_EVENT_HBM1_SPI_0:
-	case GAUDI_EVENT_HBM2_SPI_0:
-	case GAUDI_EVENT_HBM3_SPI_0:
-		return "HBM%d_spi_0";
-	case GAUDI_EVENT_HBM0_SPI_1:
-	case GAUDI_EVENT_HBM1_SPI_1:
-	case GAUDI_EVENT_HBM2_SPI_1:
-	case GAUDI_EVENT_HBM3_SPI_1:
-		return "HBM%d_spi_1";
-	case GAUDI_EVENT_FIX_POWER_ENV_S:
-		return "POWER_ENV_S";
-	case GAUDI_EVENT_FIX_POWER_ENV_E:
-		return "POWER_ENV_E";
-	case GAUDI_EVENT_FIX_THERMAL_ENV_S:
-		return "THERMAL_ENV_S";
-	case GAUDI_EVENT_FIX_THERMAL_ENV_E:
-		return "THERMAL_ENV_E";
-	case GAUDI_EVENT_RAZWI_OR_ADC:
-		return "PSOC_razwi_or_adc";
-	case GAUDI_EVENT_TPC0_QM ... GAUDI_EVENT_TPC7_QM:
-		return "TPC%d_qm";
-	case GAUDI_EVENT_MME0_QM ... GAUDI_EVENT_MME2_QM:
-		return "MME%d_qm";
-	case GAUDI_EVENT_DMA0_QM ... GAUDI_EVENT_DMA7_QM:
-		return "DMA%d_qm";
-	case GAUDI_EVENT_DMA0_CORE ... GAUDI_EVENT_DMA7_CORE:
-		return "DMA%d_core";
-	case GAUDI_EVENT_RAZWI_OR_ADC_SW:
-		return "PSOC_razwi_or_adc_sw";
-	default:
-		return "N/A";
-	}
-}
-
 static void gaudi_get_event_desc(u16 event_type, char *desc, size_t size)
 {
-	u8 index;
+	if (event_type >= GAUDI_EVENT_SIZE)
+		goto event_not_supported;
 
-	switch (event_type) {
-	case GAUDI_EVENT_TPC0_SERR ... GAUDI_EVENT_TPC7_SERR:
-		index = event_type - GAUDI_EVENT_TPC0_SERR;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_TPC0_DERR ... GAUDI_EVENT_TPC7_DERR:
-		index = event_type - GAUDI_EVENT_TPC0_DERR;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_MME0_ACC_SERR:
-	case GAUDI_EVENT_MME1_ACC_SERR:
-	case GAUDI_EVENT_MME2_ACC_SERR:
-	case GAUDI_EVENT_MME3_ACC_SERR:
-		index = (event_type - GAUDI_EVENT_MME0_ACC_SERR) / 4;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_MME0_ACC_DERR:
-	case GAUDI_EVENT_MME1_ACC_DERR:
-	case GAUDI_EVENT_MME2_ACC_DERR:
-	case GAUDI_EVENT_MME3_ACC_DERR:
-		index = (event_type - GAUDI_EVENT_MME0_ACC_DERR) / 4;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_MME0_SBAB_SERR:
-	case GAUDI_EVENT_MME1_SBAB_SERR:
-	case GAUDI_EVENT_MME2_SBAB_SERR:
-	case GAUDI_EVENT_MME3_SBAB_SERR:
-		index = (event_type - GAUDI_EVENT_MME0_SBAB_SERR) / 4;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_MME0_SBAB_DERR:
-	case GAUDI_EVENT_MME1_SBAB_DERR:
-	case GAUDI_EVENT_MME2_SBAB_DERR:
-	case GAUDI_EVENT_MME3_SBAB_DERR:
-		index = (event_type - GAUDI_EVENT_MME0_SBAB_DERR) / 4;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_DMA0_SERR_ECC ... GAUDI_EVENT_DMA7_SERR_ECC:
-		index = event_type - GAUDI_EVENT_DMA0_SERR_ECC;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_DMA0_DERR_ECC ... GAUDI_EVENT_DMA7_DERR_ECC:
-		index = event_type - GAUDI_EVENT_DMA0_DERR_ECC;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_SRAM0_SERR ... GAUDI_EVENT_SRAM28_SERR:
-		index = event_type - GAUDI_EVENT_SRAM0_SERR;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_SRAM0_DERR ... GAUDI_EVENT_SRAM28_DERR:
-		index = event_type - GAUDI_EVENT_SRAM0_DERR;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_DMA_IF0_SERR ... GAUDI_EVENT_DMA_IF3_SERR:
-		index = event_type - GAUDI_EVENT_DMA_IF0_SERR;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_DMA_IF0_DERR ... GAUDI_EVENT_DMA_IF3_DERR:
-		index = event_type - GAUDI_EVENT_DMA_IF0_DERR;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_HBM_0_SERR ... GAUDI_EVENT_HBM_3_SERR:
-		index = event_type - GAUDI_EVENT_HBM_0_SERR;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_HBM_0_DERR ... GAUDI_EVENT_HBM_3_DERR:
-		index = event_type - GAUDI_EVENT_HBM_0_DERR;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_TPC0_DEC:
-	case GAUDI_EVENT_TPC1_DEC:
-	case GAUDI_EVENT_TPC2_DEC:
-	case GAUDI_EVENT_TPC3_DEC:
-	case GAUDI_EVENT_TPC4_DEC:
-	case GAUDI_EVENT_TPC5_DEC:
-	case GAUDI_EVENT_TPC6_DEC:
-	case GAUDI_EVENT_TPC7_DEC:
-		index = (event_type - GAUDI_EVENT_TPC0_DEC) / 2;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_MME0_WBC_RSP:
-	case GAUDI_EVENT_MME1_WBC_RSP:
-	case GAUDI_EVENT_MME2_WBC_RSP:
-	case GAUDI_EVENT_MME3_WBC_RSP:
-		index = (event_type - GAUDI_EVENT_MME0_WBC_RSP) / 5;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_MME0_SBAB0_RSP:
-	case GAUDI_EVENT_MME1_SBAB0_RSP:
-	case GAUDI_EVENT_MME2_SBAB0_RSP:
-	case GAUDI_EVENT_MME3_SBAB0_RSP:
-		index = (event_type - GAUDI_EVENT_MME0_SBAB0_RSP) / 5;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_PLL0 ... GAUDI_EVENT_PLL17:
-		index = event_type - GAUDI_EVENT_PLL0;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_TPC0_BMON_SPMU:
-	case GAUDI_EVENT_TPC1_BMON_SPMU:
-	case GAUDI_EVENT_TPC2_BMON_SPMU:
-	case GAUDI_EVENT_TPC3_BMON_SPMU:
-	case GAUDI_EVENT_TPC4_BMON_SPMU:
-	case GAUDI_EVENT_TPC5_BMON_SPMU:
-	case GAUDI_EVENT_TPC6_BMON_SPMU:
-	case GAUDI_EVENT_TPC7_BMON_SPMU:
-		index = (event_type - GAUDI_EVENT_TPC0_BMON_SPMU) / 6;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_TPC0_KRN_ERR:
-	case GAUDI_EVENT_TPC1_KRN_ERR:
-	case GAUDI_EVENT_TPC2_KRN_ERR:
-	case GAUDI_EVENT_TPC3_KRN_ERR:
-	case GAUDI_EVENT_TPC4_KRN_ERR:
-	case GAUDI_EVENT_TPC5_KRN_ERR:
-	case GAUDI_EVENT_TPC6_KRN_ERR:
-	case GAUDI_EVENT_TPC7_KRN_ERR:
-		index = (event_type - GAUDI_EVENT_TPC0_KRN_ERR) / 6;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_MMU_PAGE_FAULT:
-		snprintf(desc, size, _gaudi_get_event_desc(event_type));
-		break;
-	case GAUDI_EVENT_MMU_WR_PERM:
-		snprintf(desc, size, _gaudi_get_event_desc(event_type));
-		break;
-	case GAUDI_EVENT_DMA_BM_CH0 ... GAUDI_EVENT_DMA_BM_CH7:
-		index = event_type - GAUDI_EVENT_DMA_BM_CH0;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_HBM0_SPI_0:
-	case GAUDI_EVENT_HBM1_SPI_0:
-	case GAUDI_EVENT_HBM2_SPI_0:
-	case GAUDI_EVENT_HBM3_SPI_0:
-		index = (event_type - GAUDI_EVENT_HBM0_SPI_0) / 4;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_HBM0_SPI_1:
-	case GAUDI_EVENT_HBM1_SPI_1:
-	case GAUDI_EVENT_HBM2_SPI_1:
-	case GAUDI_EVENT_HBM3_SPI_1:
-		index = (event_type - GAUDI_EVENT_HBM0_SPI_1) / 4;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_TPC0_QM ... GAUDI_EVENT_TPC7_QM:
-		index = event_type - GAUDI_EVENT_TPC0_QM;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_MME0_QM ... GAUDI_EVENT_MME2_QM:
-		index = event_type - GAUDI_EVENT_MME0_QM;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_DMA0_QM ... GAUDI_EVENT_DMA7_QM:
-		index = event_type - GAUDI_EVENT_DMA0_QM;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	case GAUDI_EVENT_DMA0_CORE ... GAUDI_EVENT_DMA7_CORE:
-		index = event_type - GAUDI_EVENT_DMA0_CORE;
-		snprintf(desc, size, _gaudi_get_event_desc(event_type), index);
-		break;
-	default:
-		snprintf(desc, size, _gaudi_get_event_desc(event_type));
-		break;
-	}
+	if (!gaudi_irq_map_table[event_type].valid)
+		goto event_not_supported;
+
+	snprintf(desc, size, gaudi_irq_map_table[event_type].name);
+
+	return;
+
+event_not_supported:
+	snprintf(desc, size, "N/A");
 }
 
 static const char *gaudi_get_razwi_initiator_dma_name(struct hl_device *hdev,
@@ -6145,7 +5570,7 @@ static void gaudi_handle_qman_err(struct hl_device *hdev, u16 event_type)
 static void gaudi_print_irq_info(struct hl_device *hdev, u16 event_type,
 					bool razwi)
 {
-	char desc[20] = "";
+	char desc[64] = "";
 
 	gaudi_get_event_desc(event_type, desc, sizeof(desc));
 	dev_err_ratelimited(hdev->dev, "Received H/W interrupt %d [\"%s\"]\n",
@@ -6159,75 +5584,14 @@ static void gaudi_print_irq_info(struct hl_device *hdev, u16 event_type,
 	}
 }
 
-static int gaudi_unmask_irq_arr(struct hl_device *hdev, const u32 *irq_arr,
-		size_t irq_arr_size)
-{
-	struct armcp_unmask_irq_arr_packet *pkt;
-	size_t total_pkt_size;
-	long result;
-	int rc;
-
-	total_pkt_size = sizeof(struct armcp_unmask_irq_arr_packet) +
-			irq_arr_size;
-
-	/* data should be aligned to 8 bytes in order to ArmCP to copy it */
-	total_pkt_size = (total_pkt_size + 0x7) & ~0x7;
-
-	/* total_pkt_size is casted to u16 later on */
-	if (total_pkt_size > USHRT_MAX) {
-		dev_err(hdev->dev, "too many elements in IRQ array\n");
-		return -EINVAL;
-	}
-
-	pkt = kzalloc(total_pkt_size, GFP_KERNEL);
-	if (!pkt)
-		return -ENOMEM;
-
-	pkt->length = cpu_to_le32(irq_arr_size / sizeof(irq_arr[0]));
-	memcpy(&pkt->irqs, irq_arr, irq_arr_size);
-
-	pkt->armcp_pkt.ctl = cpu_to_le32(ARMCP_PACKET_UNMASK_RAZWI_IRQ_ARRAY <<
-						ARMCP_PKT_CTL_OPCODE_SHIFT);
-
-	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) pkt,
-			total_pkt_size, HL_DEVICE_TIMEOUT_USEC, &result);
-
-	if (rc)
-		dev_err(hdev->dev, "failed to unmask IRQ array\n");
-
-	kfree(pkt);
-
-	return rc;
-}
-
 static int gaudi_soft_reset_late_init(struct hl_device *hdev)
 {
+	struct gaudi_device *gaudi = hdev->asic_specific;
+
 	/* Unmask all IRQs since some could have been received
 	 * during the soft reset
 	 */
-	return gaudi_unmask_irq_arr(hdev, gaudi_all_events,
-					sizeof(gaudi_all_events));
-}
-
-static int gaudi_unmask_irq(struct hl_device *hdev, u16 event_type)
-{
-	struct armcp_packet pkt;
-	long result;
-	int rc;
-
-	memset(&pkt, 0, sizeof(pkt));
-
-	pkt.ctl = cpu_to_le32(ARMCP_PACKET_UNMASK_RAZWI_IRQ <<
-				ARMCP_PKT_CTL_OPCODE_SHIFT);
-	pkt.value = cpu_to_le64(event_type);
-
-	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-			HL_DEVICE_TIMEOUT_USEC, &result);
-
-	if (rc)
-		dev_err(hdev->dev, "failed to unmask RAZWI IRQ %d", event_type);
-
-	return rc;
+	return hl_fw_unmask_irq_arr(hdev, gaudi->events, sizeof(gaudi->events));
 }
 
 static int gaudi_hbm_read_interrupts(struct hl_device *hdev, int device)
@@ -6489,7 +5853,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 					"AXI_SLV_DEC_Error");
 		if (soft_reset_required)
 			hl_device_reset(hdev, false, false);
-		gaudi_unmask_irq(hdev, event_type);
+		hl_fw_unmask_irq(hdev, event_type);
 		break;
 
 	case GAUDI_EVENT_TPC0_KRN_ERR:
@@ -6506,7 +5870,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 					"KRN_ERR");
 		if (soft_reset_required)
 			hl_device_reset(hdev, false, false);
-		gaudi_unmask_irq(hdev, event_type);
+		hl_fw_unmask_irq(hdev, event_type);
 		break;
 
 	case GAUDI_EVENT_PCIE_CORE_SERR:
@@ -6552,13 +5916,13 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	case GAUDI_EVENT_DMA0_CORE ... GAUDI_EVENT_DMA7_CORE:
 		gaudi_print_irq_info(hdev, event_type, true);
 		gaudi_handle_qman_err(hdev, event_type);
-		gaudi_unmask_irq(hdev, event_type);
+		hl_fw_unmask_irq(hdev, event_type);
 		break;
 
 	case GAUDI_EVENT_RAZWI_OR_ADC_SW:
 		gaudi_print_irq_info(hdev, event_type, true);
 		hl_device_reset(hdev, false, false);
-		gaudi_unmask_irq(hdev, event_type);
+		hl_fw_unmask_irq(hdev, event_type);
 		break;
 
 	case GAUDI_EVENT_TPC0_BMON_SPMU:
@@ -6571,12 +5935,12 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	case GAUDI_EVENT_TPC7_BMON_SPMU:
 	case GAUDI_EVENT_DMA_BM_CH0 ... GAUDI_EVENT_DMA_BM_CH7:
 		gaudi_print_irq_info(hdev, event_type, false);
-		gaudi_unmask_irq(hdev, event_type);
+		hl_fw_unmask_irq(hdev, event_type);
 		break;
 
 	case GAUDI_EVENT_FIX_POWER_ENV_S ... GAUDI_EVENT_FIX_THERMAL_ENV_E:
 		gaudi_print_clk_change_info(hdev, event_type);
-		gaudi_unmask_irq(hdev, event_type);
+		hl_fw_unmask_irq(hdev, event_type);
 		break;
 
 	case GAUDI_EVENT_PSOC_GPIO_U16_0:
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index b3d29ed35b20..a46530d375fa 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -218,6 +218,7 @@ struct gaudi_internal_qman_info {
  *                  consecutive order.
  * @hbm_bar_cur_addr: current address of HBM PCI bar.
  * @max_freq_value: current max clk frequency.
+ * @events: array that holds all event id's
  * @events_stat: array that holds histogram of all received events.
  * @events_stat_aggregate: same as events_stat but doesn't get cleared on reset
  * @hw_cap_initialized: This field contains a bit per H/W engine. When that
@@ -241,6 +242,7 @@ struct gaudi_device {
 	u64				hbm_bar_cur_addr;
 	u64				max_freq_value;
 
+	u32				events[GAUDI_EVENT_SIZE];
 	u32				events_stat[GAUDI_EVENT_SIZE];
 	u32				events_stat_aggregate[GAUDI_EVENT_SIZE];
 	u32				hw_cap_initialized;
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index eb0b8594a210..5a855b7edf43 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1739,6 +1739,9 @@ int hl_fw_load_fw_to_device(struct hl_device *hdev, const char *fw_name,
 int hl_fw_send_pci_access_msg(struct hl_device *hdev, u32 opcode);
 int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 				u16 len, u32 timeout, long *result);
+int hl_fw_unmask_irq(struct hl_device *hdev, u16 event_type);
+int hl_fw_unmask_irq_arr(struct hl_device *hdev, const u32 *irq_arr,
+		size_t irq_arr_size);
 int hl_fw_test_cpu_queue(struct hl_device *hdev);
 void *hl_fw_cpu_accessible_dma_pool_alloc(struct hl_device *hdev, size_t size,
 						dma_addr_t *dma_handle);
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map.h b/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map.h
deleted file mode 100644
index d2959506eeee..000000000000
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map.h
+++ /dev/null
@@ -1,687 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * Copyright 2018-2020 HabanaLabs, Ltd.
- * All Rights Reserved.
- *
- */
-
-/************************************
- ** This is an auto-generated file **
- **       DO NOT EDIT BELOW        **
- ************************************/
-
-#ifndef __GAUDI_ASYNC_IDS_MAP_EVENTS_H_
-#define __GAUDI_ASYNC_IDS_MAP_EVENTS_H_
-
-struct gaudi_async_events_ids_map {
-	int fc_id;
-	int cpu_id;
-};
-
-static struct gaudi_async_events_ids_map gaudi_irq_map_table[] = {
-	{ .fc_id = 0, .cpu_id = 0 },
-	{ .fc_id = 1, .cpu_id = 1 },
-	{ .fc_id = 2, .cpu_id = 2 },
-	{ .fc_id = 3, .cpu_id = 3 },
-	{ .fc_id = 4, .cpu_id = 4 },
-	{ .fc_id = 5, .cpu_id = 5 },
-	{ .fc_id = 6, .cpu_id = 6 },
-	{ .fc_id = 7, .cpu_id = 7 },
-	{ .fc_id = 8, .cpu_id = 8 },
-	{ .fc_id = 9, .cpu_id = 9 },
-	{ .fc_id = 10, .cpu_id = 10 },
-	{ .fc_id = 11, .cpu_id = 11 },
-	{ .fc_id = 12, .cpu_id = 12 },
-	{ .fc_id = 13, .cpu_id = 13 },
-	{ .fc_id = 14, .cpu_id = 14 },
-	{ .fc_id = 15, .cpu_id = 15 },
-	{ .fc_id = 16, .cpu_id = 16 },
-	{ .fc_id = 17, .cpu_id = 17 },
-	{ .fc_id = 18, .cpu_id = 18 },
-	{ .fc_id = 19, .cpu_id = 19 },
-	{ .fc_id = 20, .cpu_id = 20 },
-	{ .fc_id = 21, .cpu_id = 21 },
-	{ .fc_id = 22, .cpu_id = 22 },
-	{ .fc_id = 23, .cpu_id = 23 },
-	{ .fc_id = 24, .cpu_id = 24 },
-	{ .fc_id = 25, .cpu_id = 25 },
-	{ .fc_id = 26, .cpu_id = 26 },
-	{ .fc_id = 27, .cpu_id = 27 },
-	{ .fc_id = 28, .cpu_id = 28 },
-	{ .fc_id = 29, .cpu_id = 29 },
-	{ .fc_id = 30, .cpu_id = 30 },
-	{ .fc_id = 31, .cpu_id = 31 },
-	{ .fc_id = 32, .cpu_id = 32 },
-	{ .fc_id = 33, .cpu_id = 33 },
-	{ .fc_id = 34, .cpu_id = 34 },
-	{ .fc_id = 35, .cpu_id = 35 },
-	{ .fc_id = 36, .cpu_id = 36 },
-	{ .fc_id = 37, .cpu_id = 37 },
-	{ .fc_id = 38, .cpu_id = 38 },
-	{ .fc_id = 39, .cpu_id = 38 },
-	{ .fc_id = 40, .cpu_id = 38 },
-	{ .fc_id = 41, .cpu_id = 38 },
-	{ .fc_id = 42, .cpu_id = 38 },
-	{ .fc_id = 43, .cpu_id = 38 },
-	{ .fc_id = 44, .cpu_id = 38 },
-	{ .fc_id = 45, .cpu_id = 38 },
-	{ .fc_id = 46, .cpu_id = 39 },
-	{ .fc_id = 47, .cpu_id = 39 },
-	{ .fc_id = 48, .cpu_id = 39 },
-	{ .fc_id = 49, .cpu_id = 39 },
-	{ .fc_id = 50, .cpu_id = 39 },
-	{ .fc_id = 51, .cpu_id = 39 },
-	{ .fc_id = 52, .cpu_id = 39 },
-	{ .fc_id = 53, .cpu_id = 39 },
-	{ .fc_id = 54, .cpu_id = 40 },
-	{ .fc_id = 55, .cpu_id = 41 },
-	{ .fc_id = 56, .cpu_id = 42 },
-	{ .fc_id = 57, .cpu_id = 43 },
-	{ .fc_id = 58, .cpu_id = 44 },
-	{ .fc_id = 59, .cpu_id = 45 },
-	{ .fc_id = 60, .cpu_id = 46 },
-	{ .fc_id = 61, .cpu_id = 47 },
-	{ .fc_id = 62, .cpu_id = 48 },
-	{ .fc_id = 63, .cpu_id = 49 },
-	{ .fc_id = 64, .cpu_id = 50 },
-	{ .fc_id = 65, .cpu_id = 51 },
-	{ .fc_id = 66, .cpu_id = 52 },
-	{ .fc_id = 67, .cpu_id = 53 },
-	{ .fc_id = 68, .cpu_id = 54 },
-	{ .fc_id = 69, .cpu_id = 55 },
-	{ .fc_id = 70, .cpu_id = 56 },
-	{ .fc_id = 71, .cpu_id = 56 },
-	{ .fc_id = 72, .cpu_id = 56 },
-	{ .fc_id = 73, .cpu_id = 56 },
-	{ .fc_id = 74, .cpu_id = 56 },
-	{ .fc_id = 75, .cpu_id = 56 },
-	{ .fc_id = 76, .cpu_id = 56 },
-	{ .fc_id = 77, .cpu_id = 56 },
-	{ .fc_id = 78, .cpu_id = 57 },
-	{ .fc_id = 79, .cpu_id = 57 },
-	{ .fc_id = 80, .cpu_id = 57 },
-	{ .fc_id = 81, .cpu_id = 57 },
-	{ .fc_id = 82, .cpu_id = 57 },
-	{ .fc_id = 83, .cpu_id = 57 },
-	{ .fc_id = 84, .cpu_id = 57 },
-	{ .fc_id = 85, .cpu_id = 57 },
-	{ .fc_id = 86, .cpu_id = 58 },
-	{ .fc_id = 87, .cpu_id = 59 },
-	{ .fc_id = 88, .cpu_id = 60 },
-	{ .fc_id = 89, .cpu_id = 61 },
-	{ .fc_id = 90, .cpu_id = 62 },
-	{ .fc_id = 91, .cpu_id = 63 },
-	{ .fc_id = 92, .cpu_id = 64 },
-	{ .fc_id = 93, .cpu_id = 64 },
-	{ .fc_id = 94, .cpu_id = 64 },
-	{ .fc_id = 95, .cpu_id = 64 },
-	{ .fc_id = 96, .cpu_id = 64 },
-	{ .fc_id = 97, .cpu_id = 64 },
-	{ .fc_id = 98, .cpu_id = 64 },
-	{ .fc_id = 99, .cpu_id = 64 },
-	{ .fc_id = 100, .cpu_id = 64 },
-	{ .fc_id = 101, .cpu_id = 64 },
-	{ .fc_id = 102, .cpu_id = 64 },
-	{ .fc_id = 103, .cpu_id = 64 },
-	{ .fc_id = 104, .cpu_id = 64 },
-	{ .fc_id = 105, .cpu_id = 64 },
-	{ .fc_id = 106, .cpu_id = 64 },
-	{ .fc_id = 107, .cpu_id = 64 },
-	{ .fc_id = 108, .cpu_id = 64 },
-	{ .fc_id = 109, .cpu_id = 64 },
-	{ .fc_id = 110, .cpu_id = 64 },
-	{ .fc_id = 111, .cpu_id = 64 },
-	{ .fc_id = 112, .cpu_id = 64 },
-	{ .fc_id = 113, .cpu_id = 64 },
-	{ .fc_id = 114, .cpu_id = 64 },
-	{ .fc_id = 115, .cpu_id = 64 },
-	{ .fc_id = 116, .cpu_id = 64 },
-	{ .fc_id = 117, .cpu_id = 64 },
-	{ .fc_id = 118, .cpu_id = 64 },
-	{ .fc_id = 119, .cpu_id = 64 },
-	{ .fc_id = 120, .cpu_id = 64 },
-	{ .fc_id = 121, .cpu_id = 64 },
-	{ .fc_id = 122, .cpu_id = 64 },
-	{ .fc_id = 123, .cpu_id = 64 },
-	{ .fc_id = 124, .cpu_id = 65 },
-	{ .fc_id = 125, .cpu_id = 65 },
-	{ .fc_id = 126, .cpu_id = 65 },
-	{ .fc_id = 127, .cpu_id = 65 },
-	{ .fc_id = 128, .cpu_id = 65 },
-	{ .fc_id = 129, .cpu_id = 65 },
-	{ .fc_id = 130, .cpu_id = 65 },
-	{ .fc_id = 131, .cpu_id = 65 },
-	{ .fc_id = 132, .cpu_id = 65 },
-	{ .fc_id = 133, .cpu_id = 65 },
-	{ .fc_id = 134, .cpu_id = 65 },
-	{ .fc_id = 135, .cpu_id = 65 },
-	{ .fc_id = 136, .cpu_id = 65 },
-	{ .fc_id = 137, .cpu_id = 65 },
-	{ .fc_id = 138, .cpu_id = 65 },
-	{ .fc_id = 139, .cpu_id = 65 },
-	{ .fc_id = 140, .cpu_id = 65 },
-	{ .fc_id = 141, .cpu_id = 65 },
-	{ .fc_id = 142, .cpu_id = 65 },
-	{ .fc_id = 143, .cpu_id = 65 },
-	{ .fc_id = 144, .cpu_id = 65 },
-	{ .fc_id = 145, .cpu_id = 65 },
-	{ .fc_id = 146, .cpu_id = 65 },
-	{ .fc_id = 147, .cpu_id = 65 },
-	{ .fc_id = 148, .cpu_id = 65 },
-	{ .fc_id = 149, .cpu_id = 65 },
-	{ .fc_id = 150, .cpu_id = 65 },
-	{ .fc_id = 151, .cpu_id = 65 },
-	{ .fc_id = 152, .cpu_id = 65 },
-	{ .fc_id = 153, .cpu_id = 65 },
-	{ .fc_id = 154, .cpu_id = 65 },
-	{ .fc_id = 155, .cpu_id = 65 },
-	{ .fc_id = 156, .cpu_id = 66 },
-	{ .fc_id = 157, .cpu_id = 66 },
-	{ .fc_id = 158, .cpu_id = 66 },
-	{ .fc_id = 159, .cpu_id = 66 },
-	{ .fc_id = 160, .cpu_id = 66 },
-	{ .fc_id = 161, .cpu_id = 66 },
-	{ .fc_id = 162, .cpu_id = 66 },
-	{ .fc_id = 163, .cpu_id = 66 },
-	{ .fc_id = 164, .cpu_id = 66 },
-	{ .fc_id = 165, .cpu_id = 66 },
-	{ .fc_id = 166, .cpu_id = 67 },
-	{ .fc_id = 167, .cpu_id = 67 },
-	{ .fc_id = 168, .cpu_id = 67 },
-	{ .fc_id = 169, .cpu_id = 67 },
-	{ .fc_id = 170, .cpu_id = 67 },
-	{ .fc_id = 171, .cpu_id = 67 },
-	{ .fc_id = 172, .cpu_id = 67 },
-	{ .fc_id = 173, .cpu_id = 67 },
-	{ .fc_id = 174, .cpu_id = 67 },
-	{ .fc_id = 175, .cpu_id = 67 },
-	{ .fc_id = 176, .cpu_id = 68 },
-	{ .fc_id = 177, .cpu_id = 68 },
-	{ .fc_id = 178, .cpu_id = 68 },
-	{ .fc_id = 179, .cpu_id = 68 },
-	{ .fc_id = 180, .cpu_id = 69 },
-	{ .fc_id = 181, .cpu_id = 69 },
-	{ .fc_id = 182, .cpu_id = 69 },
-	{ .fc_id = 183, .cpu_id = 69 },
-	{ .fc_id = 184, .cpu_id = 70 },
-	{ .fc_id = 185, .cpu_id = 71 },
-	{ .fc_id = 186, .cpu_id = 71 },
-	{ .fc_id = 187, .cpu_id = 71 },
-	{ .fc_id = 188, .cpu_id = 71 },
-	{ .fc_id = 189, .cpu_id = 72 },
-	{ .fc_id = 190, .cpu_id = 72 },
-	{ .fc_id = 191, .cpu_id = 72 },
-	{ .fc_id = 192, .cpu_id = 72 },
-	{ .fc_id = 193, .cpu_id = 73 },
-	{ .fc_id = 194, .cpu_id = 74 },
-	{ .fc_id = 195, .cpu_id = 75 },
-	{ .fc_id = 196, .cpu_id = 76 },
-	{ .fc_id = 197, .cpu_id = 77 },
-	{ .fc_id = 198, .cpu_id = 78 },
-	{ .fc_id = 199, .cpu_id = 79 },
-	{ .fc_id = 200, .cpu_id = 80 },
-	{ .fc_id = 201, .cpu_id = 81 },
-	{ .fc_id = 202, .cpu_id = 82 },
-	{ .fc_id = 203, .cpu_id = 83 },
-	{ .fc_id = 204, .cpu_id = 84 },
-	{ .fc_id = 205, .cpu_id = 85 },
-	{ .fc_id = 206, .cpu_id = 86 },
-	{ .fc_id = 207, .cpu_id = 87 },
-	{ .fc_id = 208, .cpu_id = 88 },
-	{ .fc_id = 209, .cpu_id = 89 },
-	{ .fc_id = 210, .cpu_id = 90 },
-	{ .fc_id = 211, .cpu_id = 91 },
-	{ .fc_id = 212, .cpu_id = 92 },
-	{ .fc_id = 213, .cpu_id = 93 },
-	{ .fc_id = 214, .cpu_id = 94 },
-	{ .fc_id = 215, .cpu_id = 95 },
-	{ .fc_id = 216, .cpu_id = 96 },
-	{ .fc_id = 217, .cpu_id = 97 },
-	{ .fc_id = 218, .cpu_id = 98 },
-	{ .fc_id = 219, .cpu_id = 99 },
-	{ .fc_id = 220, .cpu_id = 100 },
-	{ .fc_id = 221, .cpu_id = 101 },
-	{ .fc_id = 222, .cpu_id = 102 },
-	{ .fc_id = 223, .cpu_id = 103 },
-	{ .fc_id = 224, .cpu_id = 104 },
-	{ .fc_id = 225, .cpu_id = 105 },
-	{ .fc_id = 226, .cpu_id = 106 },
-	{ .fc_id = 227, .cpu_id = 107 },
-	{ .fc_id = 228, .cpu_id = 108 },
-	{ .fc_id = 229, .cpu_id = 109 },
-	{ .fc_id = 230, .cpu_id = 110 },
-	{ .fc_id = 231, .cpu_id = 111 },
-	{ .fc_id = 232, .cpu_id = 112 },
-	{ .fc_id = 233, .cpu_id = 113 },
-	{ .fc_id = 234, .cpu_id = 114 },
-	{ .fc_id = 235, .cpu_id = 115 },
-	{ .fc_id = 236, .cpu_id = 116 },
-	{ .fc_id = 237, .cpu_id = 117 },
-	{ .fc_id = 238, .cpu_id = 118 },
-	{ .fc_id = 239, .cpu_id = 119 },
-	{ .fc_id = 240, .cpu_id = 119 },
-	{ .fc_id = 241, .cpu_id = 119 },
-	{ .fc_id = 242, .cpu_id = 119 },
-	{ .fc_id = 243, .cpu_id = 119 },
-	{ .fc_id = 244, .cpu_id = 119 },
-	{ .fc_id = 245, .cpu_id = 119 },
-	{ .fc_id = 246, .cpu_id = 119 },
-	{ .fc_id = 247, .cpu_id = 119 },
-	{ .fc_id = 248, .cpu_id = 119 },
-	{ .fc_id = 249, .cpu_id = 119 },
-	{ .fc_id = 250, .cpu_id = 119 },
-	{ .fc_id = 251, .cpu_id = 119 },
-	{ .fc_id = 252, .cpu_id = 119 },
-	{ .fc_id = 253, .cpu_id = 119 },
-	{ .fc_id = 254, .cpu_id = 119 },
-	{ .fc_id = 255, .cpu_id = 119 },
-	{ .fc_id = 256, .cpu_id = 119 },
-	{ .fc_id = 257, .cpu_id = 120 },
-	{ .fc_id = 258, .cpu_id = 121 },
-	{ .fc_id = 259, .cpu_id = 122 },
-	{ .fc_id = 260, .cpu_id = 123 },
-	{ .fc_id = 261, .cpu_id = 124 },
-	{ .fc_id = 262, .cpu_id = 125 },
-	{ .fc_id = 263, .cpu_id = 126 },
-	{ .fc_id = 264, .cpu_id = 127 },
-	{ .fc_id = 265, .cpu_id = 127 },
-	{ .fc_id = 266, .cpu_id = 127 },
-	{ .fc_id = 267, .cpu_id = 127 },
-	{ .fc_id = 268, .cpu_id = 127 },
-	{ .fc_id = 269, .cpu_id = 128 },
-	{ .fc_id = 270, .cpu_id = 128 },
-	{ .fc_id = 271, .cpu_id = 128 },
-	{ .fc_id = 272, .cpu_id = 128 },
-	{ .fc_id = 273, .cpu_id = 128 },
-	{ .fc_id = 274, .cpu_id = 128 },
-	{ .fc_id = 275, .cpu_id = 128 },
-	{ .fc_id = 276, .cpu_id = 128 },
-	{ .fc_id = 277, .cpu_id = 129 },
-	{ .fc_id = 278, .cpu_id = 129 },
-	{ .fc_id = 279, .cpu_id = 129 },
-	{ .fc_id = 280, .cpu_id = 129 },
-	{ .fc_id = 281, .cpu_id = 130 },
-	{ .fc_id = 282, .cpu_id = 131 },
-	{ .fc_id = 283, .cpu_id = 132 },
-	{ .fc_id = 284, .cpu_id = 133 },
-	{ .fc_id = 285, .cpu_id = 134 },
-	{ .fc_id = 286, .cpu_id = 135 },
-	{ .fc_id = 287, .cpu_id = 136 },
-	{ .fc_id = 288, .cpu_id = 137 },
-	{ .fc_id = 289, .cpu_id = 138 },
-	{ .fc_id = 290, .cpu_id = 139 },
-	{ .fc_id = 291, .cpu_id = 140 },
-	{ .fc_id = 292, .cpu_id = 141 },
-	{ .fc_id = 293, .cpu_id = 142 },
-	{ .fc_id = 294, .cpu_id = 143 },
-	{ .fc_id = 295, .cpu_id = 144 },
-	{ .fc_id = 296, .cpu_id = 145 },
-	{ .fc_id = 297, .cpu_id = 146 },
-	{ .fc_id = 298, .cpu_id = 147 },
-	{ .fc_id = 299, .cpu_id = 148 },
-	{ .fc_id = 300, .cpu_id = 149 },
-	{ .fc_id = 301, .cpu_id = 150 },
-	{ .fc_id = 302, .cpu_id = 151 },
-	{ .fc_id = 303, .cpu_id = 152 },
-	{ .fc_id = 304, .cpu_id = 153 },
-	{ .fc_id = 305, .cpu_id = 154 },
-	{ .fc_id = 306, .cpu_id = 155 },
-	{ .fc_id = 307, .cpu_id = 156 },
-	{ .fc_id = 308, .cpu_id = 157 },
-	{ .fc_id = 309, .cpu_id = 158 },
-	{ .fc_id = 310, .cpu_id = 159 },
-	{ .fc_id = 311, .cpu_id = 160 },
-	{ .fc_id = 312, .cpu_id = 161 },
-	{ .fc_id = 313, .cpu_id = 162 },
-	{ .fc_id = 314, .cpu_id = 163 },
-	{ .fc_id = 315, .cpu_id = 164 },
-	{ .fc_id = 316, .cpu_id = 165 },
-	{ .fc_id = 317, .cpu_id = 166 },
-	{ .fc_id = 318, .cpu_id = 167 },
-	{ .fc_id = 319, .cpu_id = 168 },
-	{ .fc_id = 320, .cpu_id = 169 },
-	{ .fc_id = 321, .cpu_id = 170 },
-	{ .fc_id = 322, .cpu_id = 171 },
-	{ .fc_id = 323, .cpu_id = 172 },
-	{ .fc_id = 324, .cpu_id = 173 },
-	{ .fc_id = 325, .cpu_id = 174 },
-	{ .fc_id = 326, .cpu_id = 175 },
-	{ .fc_id = 327, .cpu_id = 176 },
-	{ .fc_id = 328, .cpu_id = 177 },
-	{ .fc_id = 329, .cpu_id = 178 },
-	{ .fc_id = 330, .cpu_id = 179 },
-	{ .fc_id = 331, .cpu_id = 180 },
-	{ .fc_id = 332, .cpu_id = 181 },
-	{ .fc_id = 333, .cpu_id = 182 },
-	{ .fc_id = 334, .cpu_id = 183 },
-	{ .fc_id = 335, .cpu_id = 184 },
-	{ .fc_id = 336, .cpu_id = 185 },
-	{ .fc_id = 337, .cpu_id = 186 },
-	{ .fc_id = 338, .cpu_id = 187 },
-	{ .fc_id = 339, .cpu_id = 188 },
-	{ .fc_id = 340, .cpu_id = 189 },
-	{ .fc_id = 341, .cpu_id = 190 },
-	{ .fc_id = 342, .cpu_id = 191 },
-	{ .fc_id = 343, .cpu_id = 192 },
-	{ .fc_id = 344, .cpu_id = 193 },
-	{ .fc_id = 345, .cpu_id = 194 },
-	{ .fc_id = 346, .cpu_id = 195 },
-	{ .fc_id = 347, .cpu_id = 196 },
-	{ .fc_id = 348, .cpu_id = 197 },
-	{ .fc_id = 349, .cpu_id = 198 },
-	{ .fc_id = 350, .cpu_id = 199 },
-	{ .fc_id = 351, .cpu_id = 200 },
-	{ .fc_id = 352, .cpu_id = 201 },
-	{ .fc_id = 353, .cpu_id = 202 },
-	{ .fc_id = 354, .cpu_id = 203 },
-	{ .fc_id = 355, .cpu_id = 204 },
-	{ .fc_id = 356, .cpu_id = 205 },
-	{ .fc_id = 357, .cpu_id = 206 },
-	{ .fc_id = 358, .cpu_id = 207 },
-	{ .fc_id = 359, .cpu_id = 208 },
-	{ .fc_id = 360, .cpu_id = 209 },
-	{ .fc_id = 361, .cpu_id = 210 },
-	{ .fc_id = 362, .cpu_id = 211 },
-	{ .fc_id = 363, .cpu_id = 212 },
-	{ .fc_id = 364, .cpu_id = 213 },
-	{ .fc_id = 365, .cpu_id = 214 },
-	{ .fc_id = 366, .cpu_id = 215 },
-	{ .fc_id = 367, .cpu_id = 216 },
-	{ .fc_id = 368, .cpu_id = 217 },
-	{ .fc_id = 369, .cpu_id = 218 },
-	{ .fc_id = 370, .cpu_id = 219 },
-	{ .fc_id = 371, .cpu_id = 220 },
-	{ .fc_id = 372, .cpu_id = 221 },
-	{ .fc_id = 373, .cpu_id = 222 },
-	{ .fc_id = 374, .cpu_id = 223 },
-	{ .fc_id = 375, .cpu_id = 224 },
-	{ .fc_id = 376, .cpu_id = 225 },
-	{ .fc_id = 377, .cpu_id = 226 },
-	{ .fc_id = 378, .cpu_id = 227 },
-	{ .fc_id = 379, .cpu_id = 228 },
-	{ .fc_id = 380, .cpu_id = 229 },
-	{ .fc_id = 381, .cpu_id = 230 },
-	{ .fc_id = 382, .cpu_id = 231 },
-	{ .fc_id = 383, .cpu_id = 232 },
-	{ .fc_id = 384, .cpu_id = 233 },
-	{ .fc_id = 385, .cpu_id = 234 },
-	{ .fc_id = 386, .cpu_id = 235 },
-	{ .fc_id = 387, .cpu_id = 236 },
-	{ .fc_id = 388, .cpu_id = 237 },
-	{ .fc_id = 389, .cpu_id = 238 },
-	{ .fc_id = 390, .cpu_id = 239 },
-	{ .fc_id = 391, .cpu_id = 240 },
-	{ .fc_id = 392, .cpu_id = 241 },
-	{ .fc_id = 393, .cpu_id = 242 },
-	{ .fc_id = 394, .cpu_id = 243 },
-	{ .fc_id = 395, .cpu_id = 244 },
-	{ .fc_id = 396, .cpu_id = 245 },
-	{ .fc_id = 397, .cpu_id = 246 },
-	{ .fc_id = 398, .cpu_id = 247 },
-	{ .fc_id = 399, .cpu_id = 248 },
-	{ .fc_id = 400, .cpu_id = 249 },
-	{ .fc_id = 401, .cpu_id = 250 },
-	{ .fc_id = 402, .cpu_id = 251 },
-	{ .fc_id = 403, .cpu_id = 252 },
-	{ .fc_id = 404, .cpu_id = 253 },
-	{ .fc_id = 405, .cpu_id = 254 },
-	{ .fc_id = 406, .cpu_id = 255 },
-	{ .fc_id = 407, .cpu_id = 256 },
-	{ .fc_id = 408, .cpu_id = 257 },
-	{ .fc_id = 409, .cpu_id = 258 },
-	{ .fc_id = 410, .cpu_id = 259 },
-	{ .fc_id = 411, .cpu_id = 260 },
-	{ .fc_id = 412, .cpu_id = 261 },
-	{ .fc_id = 413, .cpu_id = 262 },
-	{ .fc_id = 414, .cpu_id = 263 },
-	{ .fc_id = 415, .cpu_id = 264 },
-	{ .fc_id = 416, .cpu_id = 265 },
-	{ .fc_id = 417, .cpu_id = 266 },
-	{ .fc_id = 418, .cpu_id = 267 },
-	{ .fc_id = 419, .cpu_id = 268 },
-	{ .fc_id = 420, .cpu_id = 269 },
-	{ .fc_id = 421, .cpu_id = 270 },
-	{ .fc_id = 422, .cpu_id = 271 },
-	{ .fc_id = 423, .cpu_id = 272 },
-	{ .fc_id = 424, .cpu_id = 273 },
-	{ .fc_id = 425, .cpu_id = 274 },
-	{ .fc_id = 426, .cpu_id = 275 },
-	{ .fc_id = 427, .cpu_id = 276 },
-	{ .fc_id = 428, .cpu_id = 277 },
-	{ .fc_id = 429, .cpu_id = 278 },
-	{ .fc_id = 430, .cpu_id = 279 },
-	{ .fc_id = 431, .cpu_id = 280 },
-	{ .fc_id = 432, .cpu_id = 281 },
-	{ .fc_id = 433, .cpu_id = 282 },
-	{ .fc_id = 434, .cpu_id = 283 },
-	{ .fc_id = 435, .cpu_id = 284 },
-	{ .fc_id = 436, .cpu_id = 285 },
-	{ .fc_id = 437, .cpu_id = 286 },
-	{ .fc_id = 438, .cpu_id = 287 },
-	{ .fc_id = 439, .cpu_id = 288 },
-	{ .fc_id = 440, .cpu_id = 289 },
-	{ .fc_id = 441, .cpu_id = 290 },
-	{ .fc_id = 442, .cpu_id = 291 },
-	{ .fc_id = 443, .cpu_id = 292 },
-	{ .fc_id = 444, .cpu_id = 293 },
-	{ .fc_id = 445, .cpu_id = 294 },
-	{ .fc_id = 446, .cpu_id = 295 },
-	{ .fc_id = 447, .cpu_id = 296 },
-	{ .fc_id = 448, .cpu_id = 297 },
-	{ .fc_id = 449, .cpu_id = 298 },
-	{ .fc_id = 450, .cpu_id = 299 },
-	{ .fc_id = 451, .cpu_id = 300 },
-	{ .fc_id = 452, .cpu_id = 301 },
-	{ .fc_id = 453, .cpu_id = 302 },
-	{ .fc_id = 454, .cpu_id = 303 },
-	{ .fc_id = 455, .cpu_id = 304 },
-	{ .fc_id = 456, .cpu_id = 305 },
-	{ .fc_id = 457, .cpu_id = 306 },
-	{ .fc_id = 458, .cpu_id = 307 },
-	{ .fc_id = 459, .cpu_id = 308 },
-	{ .fc_id = 460, .cpu_id = 309 },
-	{ .fc_id = 461, .cpu_id = 310 },
-	{ .fc_id = 462, .cpu_id = 311 },
-	{ .fc_id = 463, .cpu_id = 312 },
-	{ .fc_id = 464, .cpu_id = 313 },
-	{ .fc_id = 465, .cpu_id = 314 },
-	{ .fc_id = 466, .cpu_id = 315 },
-	{ .fc_id = 467, .cpu_id = 316 },
-	{ .fc_id = 468, .cpu_id = 317 },
-	{ .fc_id = 469, .cpu_id = 318 },
-	{ .fc_id = 470, .cpu_id = 319 },
-	{ .fc_id = 471, .cpu_id = 320 },
-	{ .fc_id = 472, .cpu_id = 321 },
-	{ .fc_id = 473, .cpu_id = 322 },
-	{ .fc_id = 474, .cpu_id = 323 },
-	{ .fc_id = 475, .cpu_id = 324 },
-	{ .fc_id = 476, .cpu_id = 325 },
-	{ .fc_id = 477, .cpu_id = 326 },
-	{ .fc_id = 478, .cpu_id = 327 },
-	{ .fc_id = 479, .cpu_id = 328 },
-	{ .fc_id = 480, .cpu_id = 329 },
-	{ .fc_id = 481, .cpu_id = 330 },
-	{ .fc_id = 482, .cpu_id = 331 },
-	{ .fc_id = 483, .cpu_id = 332 },
-	{ .fc_id = 484, .cpu_id = 333 },
-	{ .fc_id = 485, .cpu_id = 334 },
-	{ .fc_id = 486, .cpu_id = 335 },
-	{ .fc_id = 487, .cpu_id = 336 },
-	{ .fc_id = 488, .cpu_id = 337 },
-	{ .fc_id = 489, .cpu_id = 338 },
-	{ .fc_id = 490, .cpu_id = 339 },
-	{ .fc_id = 491, .cpu_id = 340 },
-	{ .fc_id = 492, .cpu_id = 341 },
-	{ .fc_id = 493, .cpu_id = 342 },
-	{ .fc_id = 494, .cpu_id = 343 },
-	{ .fc_id = 495, .cpu_id = 344 },
-	{ .fc_id = 496, .cpu_id = 345 },
-	{ .fc_id = 497, .cpu_id = 346 },
-	{ .fc_id = 498, .cpu_id = 347 },
-	{ .fc_id = 499, .cpu_id = 348 },
-	{ .fc_id = 500, .cpu_id = 349 },
-	{ .fc_id = 501, .cpu_id = 350 },
-	{ .fc_id = 502, .cpu_id = 351 },
-	{ .fc_id = 503, .cpu_id = 352 },
-	{ .fc_id = 504, .cpu_id = 353 },
-	{ .fc_id = 505, .cpu_id = 354 },
-	{ .fc_id = 506, .cpu_id = 355 },
-	{ .fc_id = 507, .cpu_id = 356 },
-	{ .fc_id = 508, .cpu_id = 357 },
-	{ .fc_id = 509, .cpu_id = 358 },
-	{ .fc_id = 510, .cpu_id = 359 },
-	{ .fc_id = 511, .cpu_id = 360 },
-	{ .fc_id = 512, .cpu_id = 361 },
-	{ .fc_id = 513, .cpu_id = 362 },
-	{ .fc_id = 514, .cpu_id = 363 },
-	{ .fc_id = 515, .cpu_id = 364 },
-	{ .fc_id = 516, .cpu_id = 365 },
-	{ .fc_id = 517, .cpu_id = 366 },
-	{ .fc_id = 518, .cpu_id = 367 },
-	{ .fc_id = 519, .cpu_id = 368 },
-	{ .fc_id = 520, .cpu_id = 369 },
-	{ .fc_id = 521, .cpu_id = 370 },
-	{ .fc_id = 522, .cpu_id = 371 },
-	{ .fc_id = 523, .cpu_id = 372 },
-	{ .fc_id = 524, .cpu_id = 373 },
-	{ .fc_id = 525, .cpu_id = 374 },
-	{ .fc_id = 526, .cpu_id = 375 },
-	{ .fc_id = 527, .cpu_id = 376 },
-	{ .fc_id = 528, .cpu_id = 377 },
-	{ .fc_id = 529, .cpu_id = 378 },
-	{ .fc_id = 530, .cpu_id = 379 },
-	{ .fc_id = 531, .cpu_id = 380 },
-	{ .fc_id = 532, .cpu_id = 381 },
-	{ .fc_id = 533, .cpu_id = 382 },
-	{ .fc_id = 534, .cpu_id = 383 },
-	{ .fc_id = 535, .cpu_id = 384 },
-	{ .fc_id = 536, .cpu_id = 385 },
-	{ .fc_id = 537, .cpu_id = 386 },
-	{ .fc_id = 538, .cpu_id = 387 },
-	{ .fc_id = 539, .cpu_id = 388 },
-	{ .fc_id = 540, .cpu_id = 389 },
-	{ .fc_id = 541, .cpu_id = 390 },
-	{ .fc_id = 542, .cpu_id = 391 },
-	{ .fc_id = 543, .cpu_id = 392 },
-	{ .fc_id = 544, .cpu_id = 393 },
-	{ .fc_id = 545, .cpu_id = 394 },
-	{ .fc_id = 546, .cpu_id = 395 },
-	{ .fc_id = 547, .cpu_id = 396 },
-	{ .fc_id = 548, .cpu_id = 397 },
-	{ .fc_id = 549, .cpu_id = 398 },
-	{ .fc_id = 550, .cpu_id = 399 },
-	{ .fc_id = 551, .cpu_id = 400 },
-	{ .fc_id = 552, .cpu_id = 401 },
-	{ .fc_id = 553, .cpu_id = 402 },
-	{ .fc_id = 554, .cpu_id = 403 },
-	{ .fc_id = 555, .cpu_id = 404 },
-	{ .fc_id = 556, .cpu_id = 405 },
-	{ .fc_id = 557, .cpu_id = 406 },
-	{ .fc_id = 558, .cpu_id = 407 },
-	{ .fc_id = 559, .cpu_id = 408 },
-	{ .fc_id = 560, .cpu_id = 409 },
-	{ .fc_id = 561, .cpu_id = 410 },
-	{ .fc_id = 562, .cpu_id = 411 },
-	{ .fc_id = 563, .cpu_id = 412 },
-	{ .fc_id = 564, .cpu_id = 413 },
-	{ .fc_id = 565, .cpu_id = 414 },
-	{ .fc_id = 566, .cpu_id = 415 },
-	{ .fc_id = 567, .cpu_id = 416 },
-	{ .fc_id = 568, .cpu_id = 417 },
-	{ .fc_id = 569, .cpu_id = 418 },
-	{ .fc_id = 570, .cpu_id = 419 },
-	{ .fc_id = 571, .cpu_id = 420 },
-	{ .fc_id = 572, .cpu_id = 421 },
-	{ .fc_id = 573, .cpu_id = 422 },
-	{ .fc_id = 574, .cpu_id = 423 },
-	{ .fc_id = 575, .cpu_id = 424 },
-	{ .fc_id = 576, .cpu_id = 425 },
-	{ .fc_id = 577, .cpu_id = 426 },
-	{ .fc_id = 578, .cpu_id = 427 },
-	{ .fc_id = 579, .cpu_id = 428 },
-	{ .fc_id = 580, .cpu_id = 429 },
-	{ .fc_id = 581, .cpu_id = 430 },
-	{ .fc_id = 582, .cpu_id = 431 },
-	{ .fc_id = 583, .cpu_id = 432 },
-	{ .fc_id = 584, .cpu_id = 433 },
-	{ .fc_id = 585, .cpu_id = 434 },
-	{ .fc_id = 586, .cpu_id = 435 },
-	{ .fc_id = 587, .cpu_id = 436 },
-	{ .fc_id = 588, .cpu_id = 437 },
-	{ .fc_id = 589, .cpu_id = 438 },
-	{ .fc_id = 590, .cpu_id = 439 },
-	{ .fc_id = 591, .cpu_id = 440 },
-	{ .fc_id = 592, .cpu_id = 441 },
-	{ .fc_id = 593, .cpu_id = 442 },
-	{ .fc_id = 594, .cpu_id = 443 },
-	{ .fc_id = 595, .cpu_id = 444 },
-	{ .fc_id = 596, .cpu_id = 445 },
-	{ .fc_id = 597, .cpu_id = 446 },
-	{ .fc_id = 598, .cpu_id = 447 },
-	{ .fc_id = 599, .cpu_id = 448 },
-	{ .fc_id = 600, .cpu_id = 449 },
-	{ .fc_id = 601, .cpu_id = 450 },
-	{ .fc_id = 602, .cpu_id = 451 },
-	{ .fc_id = 603, .cpu_id = 452 },
-	{ .fc_id = 604, .cpu_id = 453 },
-	{ .fc_id = 605, .cpu_id = 454 },
-	{ .fc_id = 606, .cpu_id = 455 },
-	{ .fc_id = 607, .cpu_id = 456 },
-	{ .fc_id = 608, .cpu_id = 457 },
-	{ .fc_id = 609, .cpu_id = 458 },
-	{ .fc_id = 610, .cpu_id = 459 },
-	{ .fc_id = 611, .cpu_id = 460 },
-	{ .fc_id = 612, .cpu_id = 461 },
-	{ .fc_id = 613, .cpu_id = 462 },
-	{ .fc_id = 614, .cpu_id = 463 },
-	{ .fc_id = 615, .cpu_id = 464 },
-	{ .fc_id = 616, .cpu_id = 465 },
-	{ .fc_id = 617, .cpu_id = 466 },
-	{ .fc_id = 618, .cpu_id = 467 },
-	{ .fc_id = 619, .cpu_id = 468 },
-	{ .fc_id = 620, .cpu_id = 469 },
-	{ .fc_id = 621, .cpu_id = 470 },
-	{ .fc_id = 622, .cpu_id = 471 },
-	{ .fc_id = 623, .cpu_id = 472 },
-	{ .fc_id = 624, .cpu_id = 473 },
-	{ .fc_id = 625, .cpu_id = 474 },
-	{ .fc_id = 626, .cpu_id = 475 },
-	{ .fc_id = 627, .cpu_id = 476 },
-	{ .fc_id = 628, .cpu_id = 477 },
-	{ .fc_id = 629, .cpu_id = 478 },
-	{ .fc_id = 630, .cpu_id = 479 },
-	{ .fc_id = 631, .cpu_id = 480 },
-	{ .fc_id = 632, .cpu_id = 481 },
-	{ .fc_id = 633, .cpu_id = 482 },
-	{ .fc_id = 634, .cpu_id = 483 },
-	{ .fc_id = 635, .cpu_id = 484 },
-	{ .fc_id = 636, .cpu_id = 485 },
-	{ .fc_id = 637, .cpu_id = 486 },
-	{ .fc_id = 638, .cpu_id = 487 },
-	{ .fc_id = 639, .cpu_id = 488 },
-	{ .fc_id = 640, .cpu_id = 489 },
-	{ .fc_id = 641, .cpu_id = 490 },
-	{ .fc_id = 642, .cpu_id = 491 },
-	{ .fc_id = 643, .cpu_id = 492 },
-	{ .fc_id = 644, .cpu_id = 493 },
-	{ .fc_id = 645, .cpu_id = 494 },
-	{ .fc_id = 646, .cpu_id = 495 },
-	{ .fc_id = 647, .cpu_id = 496 },
-	{ .fc_id = 648, .cpu_id = 497 },
-	{ .fc_id = 649, .cpu_id = 498 },
-	{ .fc_id = 650, .cpu_id = 499 },
-	{ .fc_id = 651, .cpu_id = 500 },
-	{ .fc_id = 652, .cpu_id = 501 },
-	{ .fc_id = 653, .cpu_id = 502 },
-	{ .fc_id = 654, .cpu_id = 503 },
-	{ .fc_id = 655, .cpu_id = 504 },
-	{ .fc_id = 656, .cpu_id = 505 },
-	{ .fc_id = 657, .cpu_id = 506 },
-	{ .fc_id = 658, .cpu_id = 507 },
-	{ .fc_id = 659, .cpu_id = 508 },
-	{ .fc_id = 660, .cpu_id = 509 },
-	{ .fc_id = 661, .cpu_id = 510 },
-	{ .fc_id = 662, .cpu_id = 511 },
-};
-
-#endif /* __GAUDI_ASYNC_IDS_MAP_EVENTS_H_ */
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h b/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h
new file mode 100644
index 000000000000..737176ba06fb
--- /dev/null
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h
@@ -0,0 +1,694 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2018-2020 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+/************************************
+ ** This is an auto-generated file **
+ **       DO NOT EDIT BELOW        **
+ ************************************/
+
+#ifndef __GAUDI_ASYNC_IDS_MAP_EVENTS_EXT_H_
+#define __GAUDI_ASYNC_IDS_MAP_EVENTS_EXT_H_
+
+struct gaudi_async_events_ids_map {
+	int fc_id;
+	int cpu_id;
+	int valid;
+	char name[64];
+};
+
+static struct gaudi_async_events_ids_map gaudi_irq_map_table[] = {
+	{ .fc_id = 0, .cpu_id = 0, .valid = 0, .name = "" },
+	{ .fc_id = 1, .cpu_id = 1, .valid = 0, .name = "" },
+	{ .fc_id = 2, .cpu_id = 2, .valid = 0, .name = "" },
+	{ .fc_id = 3, .cpu_id = 3, .valid = 0, .name = "" },
+	{ .fc_id = 4, .cpu_id = 4, .valid = 0, .name = "" },
+	{ .fc_id = 5, .cpu_id = 5, .valid = 0, .name = "" },
+	{ .fc_id = 6, .cpu_id = 6, .valid = 0, .name = "" },
+	{ .fc_id = 7, .cpu_id = 7, .valid = 0, .name = "" },
+	{ .fc_id = 8, .cpu_id = 8, .valid = 0, .name = "" },
+	{ .fc_id = 9, .cpu_id = 9, .valid = 0, .name = "" },
+	{ .fc_id = 10, .cpu_id = 10, .valid = 0, .name = "" },
+	{ .fc_id = 11, .cpu_id = 11, .valid = 0, .name = "" },
+	{ .fc_id = 12, .cpu_id = 12, .valid = 0, .name = "" },
+	{ .fc_id = 13, .cpu_id = 13, .valid = 0, .name = "" },
+	{ .fc_id = 14, .cpu_id = 14, .valid = 0, .name = "" },
+	{ .fc_id = 15, .cpu_id = 15, .valid = 0, .name = "" },
+	{ .fc_id = 16, .cpu_id = 16, .valid = 0, .name = "" },
+	{ .fc_id = 17, .cpu_id = 17, .valid = 0, .name = "" },
+	{ .fc_id = 18, .cpu_id = 18, .valid = 0, .name = "" },
+	{ .fc_id = 19, .cpu_id = 19, .valid = 0, .name = "" },
+	{ .fc_id = 20, .cpu_id = 20, .valid = 0, .name = "" },
+	{ .fc_id = 21, .cpu_id = 21, .valid = 0, .name = "" },
+	{ .fc_id = 22, .cpu_id = 22, .valid = 0, .name = "" },
+	{ .fc_id = 23, .cpu_id = 23, .valid = 0, .name = "" },
+	{ .fc_id = 24, .cpu_id = 24, .valid = 0, .name = "" },
+	{ .fc_id = 25, .cpu_id = 25, .valid = 0, .name = "" },
+	{ .fc_id = 26, .cpu_id = 26, .valid = 0, .name = "" },
+	{ .fc_id = 27, .cpu_id = 27, .valid = 0, .name = "" },
+	{ .fc_id = 28, .cpu_id = 28, .valid = 0, .name = "" },
+	{ .fc_id = 29, .cpu_id = 29, .valid = 0, .name = "" },
+	{ .fc_id = 30, .cpu_id = 30, .valid = 0, .name = "" },
+	{ .fc_id = 31, .cpu_id = 31, .valid = 0, .name = "" },
+	{ .fc_id = 32, .cpu_id = 32, .valid = 1, .name = "PCIE_CORE_SERR" },
+	{ .fc_id = 33, .cpu_id = 33, .valid = 1, .name = "PCIE_CORE_DERR" },
+	{ .fc_id = 34, .cpu_id = 34, .valid = 1, .name = "PCIE_IF_SERR" },
+	{ .fc_id = 35, .cpu_id = 35, .valid = 1, .name = "PCIE_IF_DERR" },
+	{ .fc_id = 36, .cpu_id = 36, .valid = 1, .name = "PCIE_PHY_SERR" },
+	{ .fc_id = 37, .cpu_id = 37, .valid = 1, .name = "PCIE_PHY_DERR" },
+	{ .fc_id = 38, .cpu_id = 38, .valid = 1, .name = "TPC0_SERR" },
+	{ .fc_id = 39, .cpu_id = 38, .valid = 1, .name = "TPC1_SERR" },
+	{ .fc_id = 40, .cpu_id = 38, .valid = 1, .name = "TPC2_SERR" },
+	{ .fc_id = 41, .cpu_id = 38, .valid = 1, .name = "TPC3_SERR" },
+	{ .fc_id = 42, .cpu_id = 38, .valid = 1, .name = "TPC4_SERR" },
+	{ .fc_id = 43, .cpu_id = 38, .valid = 1, .name = "TPC5_SERR" },
+	{ .fc_id = 44, .cpu_id = 38, .valid = 1, .name = "TPC6_SERR" },
+	{ .fc_id = 45, .cpu_id = 38, .valid = 1, .name = "TPC7_SERR" },
+	{ .fc_id = 46, .cpu_id = 39, .valid = 1, .name = "TPC0_DERR" },
+	{ .fc_id = 47, .cpu_id = 39, .valid = 1, .name = "TPC1_DERR" },
+	{ .fc_id = 48, .cpu_id = 39, .valid = 1, .name = "TPC2_DERR" },
+	{ .fc_id = 49, .cpu_id = 39, .valid = 1, .name = "TPC3_DERR" },
+	{ .fc_id = 50, .cpu_id = 39, .valid = 1, .name = "TPC4_DERR" },
+	{ .fc_id = 51, .cpu_id = 39, .valid = 1, .name = "TPC5_DERR" },
+	{ .fc_id = 52, .cpu_id = 39, .valid = 1, .name = "TPC6_DERR" },
+	{ .fc_id = 53, .cpu_id = 39, .valid = 1, .name = "TPC7_DERR" },
+	{ .fc_id = 54, .cpu_id = 40, .valid = 1, .name = "MME0_ACC_SERR" },
+	{ .fc_id = 55, .cpu_id = 41, .valid = 1, .name = "MME0_ACC_DERR" },
+	{ .fc_id = 56, .cpu_id = 42, .valid = 1, .name = "MME0_SBAB_SERR" },
+	{ .fc_id = 57, .cpu_id = 43, .valid = 1, .name = "MME0_SBAB_DERR" },
+	{ .fc_id = 58, .cpu_id = 44, .valid = 1, .name = "MME1_ACC_SERR" },
+	{ .fc_id = 59, .cpu_id = 45, .valid = 1, .name = "MME1_ACC_DERR" },
+	{ .fc_id = 60, .cpu_id = 46, .valid = 1, .name = "MME1_SBAB_SERR" },
+	{ .fc_id = 61, .cpu_id = 47, .valid = 1, .name = "MME1_SBAB_DERR" },
+	{ .fc_id = 62, .cpu_id = 48, .valid = 1, .name = "MME2_ACC_SERR" },
+	{ .fc_id = 63, .cpu_id = 49, .valid = 1, .name = "MME2_ACC_DERR" },
+	{ .fc_id = 64, .cpu_id = 50, .valid = 1, .name = "MME2_SBAB_SERR" },
+	{ .fc_id = 65, .cpu_id = 51, .valid = 1, .name = "MME2_SBAB_DERR" },
+	{ .fc_id = 66, .cpu_id = 52, .valid = 1, .name = "MME3_ACC_SERR" },
+	{ .fc_id = 67, .cpu_id = 53, .valid = 1, .name = "MME3_ACC_DERR" },
+	{ .fc_id = 68, .cpu_id = 54, .valid = 1, .name = "MME3_SBAB_SERR" },
+	{ .fc_id = 69, .cpu_id = 55, .valid = 1, .name = "MME3_SBAB_DERR" },
+	{ .fc_id = 70, .cpu_id = 56, .valid = 1, .name = "DMA0_SERR_ECC" },
+	{ .fc_id = 71, .cpu_id = 56, .valid = 1, .name = "DMA1_SERR_ECC" },
+	{ .fc_id = 72, .cpu_id = 56, .valid = 1, .name = "DMA2_SERR_ECC" },
+	{ .fc_id = 73, .cpu_id = 56, .valid = 1, .name = "DMA3_SERR_ECC" },
+	{ .fc_id = 74, .cpu_id = 56, .valid = 1, .name = "DMA4_SERR_ECC" },
+	{ .fc_id = 75, .cpu_id = 56, .valid = 1, .name = "DMA5_SERR_ECC" },
+	{ .fc_id = 76, .cpu_id = 56, .valid = 1, .name = "DMA6_SERR_ECC" },
+	{ .fc_id = 77, .cpu_id = 56, .valid = 1, .name = "DMA7_SERR_ECC" },
+	{ .fc_id = 78, .cpu_id = 57, .valid = 1, .name = "DMA0_DERR_ECC" },
+	{ .fc_id = 79, .cpu_id = 57, .valid = 1, .name = "DMA1_DERR_ECC" },
+	{ .fc_id = 80, .cpu_id = 57, .valid = 1, .name = "DMA2_DERR_ECC" },
+	{ .fc_id = 81, .cpu_id = 57, .valid = 1, .name = "DMA3_DERR_ECC" },
+	{ .fc_id = 82, .cpu_id = 57, .valid = 1, .name = "DMA4_DERR_ECC" },
+	{ .fc_id = 83, .cpu_id = 57, .valid = 1, .name = "DMA5_DERR_ECC" },
+	{ .fc_id = 84, .cpu_id = 57, .valid = 1, .name = "DMA6_DERR_ECC" },
+	{ .fc_id = 85, .cpu_id = 57, .valid = 1, .name = "DMA7_DERR_ECC" },
+	{ .fc_id = 86, .cpu_id = 58, .valid = 1, .name = "CPU_IF_ECC_SERR" },
+	{ .fc_id = 87, .cpu_id = 59, .valid = 1, .name = "CPU_IF_ECC_DERR" },
+	{ .fc_id = 88, .cpu_id = 60, .valid = 1, .name = "PSOC_MEM_SERR" },
+	{ .fc_id = 89, .cpu_id = 61, .valid = 1,
+		.name = "PSOC_CORESIGHT_SERR" },
+	{ .fc_id = 90, .cpu_id = 62, .valid = 1, .name = "PSOC_MEM_DERR" },
+	{ .fc_id = 91, .cpu_id = 63, .valid = 1,
+		.name = "PSOC_CORESIGHT_DERR" },
+	{ .fc_id = 92, .cpu_id = 64, .valid = 1, .name = "SRAM0_SERR" },
+	{ .fc_id = 93, .cpu_id = 64, .valid = 1, .name = "SRAM1_SERR" },
+	{ .fc_id = 94, .cpu_id = 64, .valid = 1, .name = "SRAM2_SERR" },
+	{ .fc_id = 95, .cpu_id = 64, .valid = 1, .name = "SRAM3_SERR" },
+	{ .fc_id = 96, .cpu_id = 64, .valid = 1, .name = "SRAM7_SERR" },
+	{ .fc_id = 97, .cpu_id = 64, .valid = 1, .name = "SRAM6_SERR" },
+	{ .fc_id = 98, .cpu_id = 64, .valid = 1, .name = "SRAM5_SERR" },
+	{ .fc_id = 99, .cpu_id = 64, .valid = 1, .name = "SRAM4_SERR" },
+	{ .fc_id = 100, .cpu_id = 64, .valid = 1, .name = "SRAM8_SERR" },
+	{ .fc_id = 101, .cpu_id = 64, .valid = 1, .name = "SRAM9_SERR" },
+	{ .fc_id = 102, .cpu_id = 64, .valid = 1, .name = "SRAM10_SERR" },
+	{ .fc_id = 103, .cpu_id = 64, .valid = 1, .name = "SRAM11_SERR" },
+	{ .fc_id = 104, .cpu_id = 64, .valid = 1, .name = "SRAM15_SERR" },
+	{ .fc_id = 105, .cpu_id = 64, .valid = 1, .name = "SRAM14_SERR" },
+	{ .fc_id = 106, .cpu_id = 64, .valid = 1, .name = "SRAM13_SERR" },
+	{ .fc_id = 107, .cpu_id = 64, .valid = 1, .name = "SRAM12_SERR" },
+	{ .fc_id = 108, .cpu_id = 64, .valid = 1, .name = "SRAM16_SERR" },
+	{ .fc_id = 109, .cpu_id = 64, .valid = 1, .name = "SRAM17_SERR" },
+	{ .fc_id = 110, .cpu_id = 64, .valid = 1, .name = "SRAM18_SERR" },
+	{ .fc_id = 111, .cpu_id = 64, .valid = 1, .name = "SRAM19_SERR" },
+	{ .fc_id = 112, .cpu_id = 64, .valid = 1, .name = "SRAM23_SERR" },
+	{ .fc_id = 113, .cpu_id = 64, .valid = 1, .name = "SRAM22_SERR" },
+	{ .fc_id = 114, .cpu_id = 64, .valid = 1, .name = "SRAM21_SERR" },
+	{ .fc_id = 115, .cpu_id = 64, .valid = 1, .name = "SRAM20_SERR" },
+	{ .fc_id = 116, .cpu_id = 64, .valid = 1, .name = "SRAM24_SERR" },
+	{ .fc_id = 117, .cpu_id = 64, .valid = 1, .name = "SRAM25_SERR" },
+	{ .fc_id = 118, .cpu_id = 64, .valid = 1, .name = "SRAM26_SERR" },
+	{ .fc_id = 119, .cpu_id = 64, .valid = 1, .name = "SRAM27_SERR" },
+	{ .fc_id = 120, .cpu_id = 64, .valid = 1, .name = "SRAM31_SERR" },
+	{ .fc_id = 121, .cpu_id = 64, .valid = 1, .name = "SRAM30_SERR" },
+	{ .fc_id = 122, .cpu_id = 64, .valid = 1, .name = "SRAM29_SERR" },
+	{ .fc_id = 123, .cpu_id = 64, .valid = 1, .name = "SRAM28_SERR" },
+	{ .fc_id = 124, .cpu_id = 65, .valid = 1, .name = "SRAM0_DERR" },
+	{ .fc_id = 125, .cpu_id = 65, .valid = 1, .name = "SRAM1_DERR" },
+	{ .fc_id = 126, .cpu_id = 65, .valid = 1, .name = "SRAM2_DERR" },
+	{ .fc_id = 127, .cpu_id = 65, .valid = 1, .name = "SRAM3_DERR" },
+	{ .fc_id = 128, .cpu_id = 65, .valid = 1, .name = "SRAM7_DERR" },
+	{ .fc_id = 129, .cpu_id = 65, .valid = 1, .name = "SRAM6_DERR" },
+	{ .fc_id = 130, .cpu_id = 65, .valid = 1, .name = "SRAM5_DERR" },
+	{ .fc_id = 131, .cpu_id = 65, .valid = 1, .name = "SRAM4_DERR" },
+	{ .fc_id = 132, .cpu_id = 65, .valid = 1, .name = "SRAM8_DERR" },
+	{ .fc_id = 133, .cpu_id = 65, .valid = 1, .name = "SRAM9_DERR" },
+	{ .fc_id = 134, .cpu_id = 65, .valid = 1, .name = "SRAM10_DERR" },
+	{ .fc_id = 135, .cpu_id = 65, .valid = 1, .name = "SRAM11_DERR" },
+	{ .fc_id = 136, .cpu_id = 65, .valid = 1, .name = "SRAM15_DERR" },
+	{ .fc_id = 137, .cpu_id = 65, .valid = 1, .name = "SRAM14_DERR" },
+	{ .fc_id = 138, .cpu_id = 65, .valid = 1, .name = "SRAM13_DERR" },
+	{ .fc_id = 139, .cpu_id = 65, .valid = 1, .name = "SRAM12_DERR" },
+	{ .fc_id = 140, .cpu_id = 65, .valid = 1, .name = "SRAM16_DERR" },
+	{ .fc_id = 141, .cpu_id = 65, .valid = 1, .name = "SRAM17_DERR" },
+	{ .fc_id = 142, .cpu_id = 65, .valid = 1, .name = "SRAM18_DERR" },
+	{ .fc_id = 143, .cpu_id = 65, .valid = 1, .name = "SRAM19_DERR" },
+	{ .fc_id = 144, .cpu_id = 65, .valid = 1, .name = "SRAM23_DERR" },
+	{ .fc_id = 145, .cpu_id = 65, .valid = 1, .name = "SRAM22_DERR" },
+	{ .fc_id = 146, .cpu_id = 65, .valid = 1, .name = "SRAM21_DERR" },
+	{ .fc_id = 147, .cpu_id = 65, .valid = 1, .name = "SRAM20_DERR" },
+	{ .fc_id = 148, .cpu_id = 65, .valid = 1, .name = "SRAM24_DERR" },
+	{ .fc_id = 149, .cpu_id = 65, .valid = 1, .name = "SRAM25_DERR" },
+	{ .fc_id = 150, .cpu_id = 65, .valid = 1, .name = "SRAM26_DERR" },
+	{ .fc_id = 151, .cpu_id = 65, .valid = 1, .name = "SRAM27_DERR" },
+	{ .fc_id = 152, .cpu_id = 65, .valid = 1, .name = "SRAM31_DERR" },
+	{ .fc_id = 153, .cpu_id = 65, .valid = 1, .name = "SRAM30_DERR" },
+	{ .fc_id = 154, .cpu_id = 65, .valid = 1, .name = "SRAM29_DERR" },
+	{ .fc_id = 155, .cpu_id = 65, .valid = 1, .name = "SRAM28_DERR" },
+	{ .fc_id = 156, .cpu_id = 66, .valid = 1, .name = "NIC0_SERR" },
+	{ .fc_id = 157, .cpu_id = 66, .valid = 1, .name = "NIC1_SERR" },
+	{ .fc_id = 158, .cpu_id = 66, .valid = 1, .name = "NIC2_SERR" },
+	{ .fc_id = 159, .cpu_id = 66, .valid = 1, .name = "NIC3_SERR" },
+	{ .fc_id = 160, .cpu_id = 66, .valid = 1, .name = "NIC4_SERR" },
+	{ .fc_id = 161, .cpu_id = 66, .valid = 0, .name = "" },
+	{ .fc_id = 162, .cpu_id = 66, .valid = 0, .name = "" },
+	{ .fc_id = 163, .cpu_id = 66, .valid = 0, .name = "" },
+	{ .fc_id = 164, .cpu_id = 66, .valid = 0, .name = "" },
+	{ .fc_id = 165, .cpu_id = 66, .valid = 0, .name = "" },
+	{ .fc_id = 166, .cpu_id = 67, .valid = 1, .name = "NIC0_DERR" },
+	{ .fc_id = 167, .cpu_id = 67, .valid = 1, .name = "NIC1_DERR" },
+	{ .fc_id = 168, .cpu_id = 67, .valid = 1, .name = "NIC2_DERR" },
+	{ .fc_id = 169, .cpu_id = 67, .valid = 1, .name = "NIC3_DERR" },
+	{ .fc_id = 170, .cpu_id = 67, .valid = 1, .name = "NIC4_DERR" },
+	{ .fc_id = 171, .cpu_id = 67, .valid = 0, .name = "" },
+	{ .fc_id = 172, .cpu_id = 67, .valid = 0, .name = "" },
+	{ .fc_id = 173, .cpu_id = 67, .valid = 0, .name = "" },
+	{ .fc_id = 174, .cpu_id = 67, .valid = 0, .name = "" },
+	{ .fc_id = 175, .cpu_id = 67, .valid = 0, .name = "" },
+	{ .fc_id = 176, .cpu_id = 68, .valid = 1, .name = "DMA_IF0_SERR" },
+	{ .fc_id = 177, .cpu_id = 68, .valid = 1, .name = "DMA_IF1_SERR" },
+	{ .fc_id = 178, .cpu_id = 68, .valid = 1, .name = "DMA_IF2_SERR" },
+	{ .fc_id = 179, .cpu_id = 68, .valid = 1, .name = "DMA_IF3_SERR" },
+	{ .fc_id = 180, .cpu_id = 69, .valid = 1, .name = "DMA_IF0_DERR" },
+	{ .fc_id = 181, .cpu_id = 69, .valid = 1, .name = "DMA_IF1_DERR" },
+	{ .fc_id = 182, .cpu_id = 69, .valid = 1, .name = "DMA_IF2_DERR" },
+	{ .fc_id = 183, .cpu_id = 69, .valid = 1, .name = "DMA_IF3_DERR" },
+	{ .fc_id = 184, .cpu_id = 70, .valid = 1, .name = "GIC500" },
+	{ .fc_id = 185, .cpu_id = 71, .valid = 1, .name = "HBM_0_SERR" },
+	{ .fc_id = 186, .cpu_id = 71, .valid = 1, .name = "HBM_1_SERR" },
+	{ .fc_id = 187, .cpu_id = 71, .valid = 1, .name = "HBM_2_SERR" },
+	{ .fc_id = 188, .cpu_id = 71, .valid = 1, .name = "HBM_3_SERR" },
+	{ .fc_id = 189, .cpu_id = 72, .valid = 1, .name = "HBM_0_DERR" },
+	{ .fc_id = 190, .cpu_id = 72, .valid = 1, .name = "HBM_1_DERR" },
+	{ .fc_id = 191, .cpu_id = 72, .valid = 1, .name = "HBM_2_DERR" },
+	{ .fc_id = 192, .cpu_id = 72, .valid = 1, .name = "HBM_3_DERR" },
+	{ .fc_id = 193, .cpu_id = 73, .valid = 1, .name = "MMU_SERR" },
+	{ .fc_id = 194, .cpu_id = 74, .valid = 1, .name = "MMU_DERR" },
+	{ .fc_id = 195, .cpu_id = 75, .valid = 0, .name = "" },
+	{ .fc_id = 196, .cpu_id = 76, .valid = 0, .name = "" },
+	{ .fc_id = 197, .cpu_id = 77, .valid = 0, .name = "" },
+	{ .fc_id = 198, .cpu_id = 78, .valid = 0, .name = "" },
+	{ .fc_id = 199, .cpu_id = 79, .valid = 0, .name = "" },
+	{ .fc_id = 200, .cpu_id = 80, .valid = 1, .name = "PCIE_DEC" },
+	{ .fc_id = 201, .cpu_id = 81, .valid = 1, .name = "TPC0_DEC" },
+	{ .fc_id = 202, .cpu_id = 82, .valid = 0, .name = "" },
+	{ .fc_id = 203, .cpu_id = 83, .valid = 1, .name = "TPC1_DEC" },
+	{ .fc_id = 204, .cpu_id = 84, .valid = 0, .name = "" },
+	{ .fc_id = 205, .cpu_id = 85, .valid = 1, .name = "TPC2_DEC" },
+	{ .fc_id = 206, .cpu_id = 86, .valid = 0, .name = "" },
+	{ .fc_id = 207, .cpu_id = 87, .valid = 1, .name = "TPC3_DEC" },
+	{ .fc_id = 208, .cpu_id = 88, .valid = 0, .name = "" },
+	{ .fc_id = 209, .cpu_id = 89, .valid = 1, .name = "TPC4_DEC" },
+	{ .fc_id = 210, .cpu_id = 90, .valid = 0, .name = "" },
+	{ .fc_id = 211, .cpu_id = 91, .valid = 1, .name = "TPC5_DEC" },
+	{ .fc_id = 212, .cpu_id = 92, .valid = 0, .name = "" },
+	{ .fc_id = 213, .cpu_id = 93, .valid = 1, .name = "TPC6_DEC" },
+	{ .fc_id = 214, .cpu_id = 94, .valid = 0, .name = "" },
+	{ .fc_id = 215, .cpu_id = 95, .valid = 1, .name = "TPC7_DEC" },
+	{ .fc_id = 216, .cpu_id = 96, .valid = 0, .name = "" },
+	{ .fc_id = 217, .cpu_id = 97, .valid = 1, .name = "AXI_ECC" },
+	{ .fc_id = 218, .cpu_id = 98, .valid = 1, .name = "L2_RAM_ECC" },
+	{ .fc_id = 219, .cpu_id = 99, .valid = 1, .name = "MME0_WBC_RSP" },
+	{ .fc_id = 220, .cpu_id = 100, .valid = 1, .name = "MME0_SBAB0_RSP" },
+	{ .fc_id = 221, .cpu_id = 101, .valid = 0, .name = "" },
+	{ .fc_id = 222, .cpu_id = 102, .valid = 0, .name = "" },
+	{ .fc_id = 223, .cpu_id = 103, .valid = 0, .name = "" },
+	{ .fc_id = 224, .cpu_id = 104, .valid = 1, .name = "MME1_WBC_RSP" },
+	{ .fc_id = 225, .cpu_id = 105, .valid = 1, .name = "MME1_SBAB0_RSP" },
+	{ .fc_id = 226, .cpu_id = 106, .valid = 0, .name = "" },
+	{ .fc_id = 227, .cpu_id = 107, .valid = 0, .name = "" },
+	{ .fc_id = 228, .cpu_id = 108, .valid = 0, .name = "" },
+	{ .fc_id = 229, .cpu_id = 109, .valid = 1, .name = "MME2_WBC_RSP" },
+	{ .fc_id = 230, .cpu_id = 110, .valid = 1, .name = "MME2_SBAB0_RSP" },
+	{ .fc_id = 231, .cpu_id = 111, .valid = 0, .name = "" },
+	{ .fc_id = 232, .cpu_id = 112, .valid = 0, .name = "" },
+	{ .fc_id = 233, .cpu_id = 113, .valid = 0, .name = "" },
+	{ .fc_id = 234, .cpu_id = 114, .valid = 1, .name = "MME3_WBC_RSP" },
+	{ .fc_id = 235, .cpu_id = 115, .valid = 1, .name = "MME3_SBAB0_RSP" },
+	{ .fc_id = 236, .cpu_id = 116, .valid = 0, .name = "" },
+	{ .fc_id = 237, .cpu_id = 117, .valid = 0, .name = "" },
+	{ .fc_id = 238, .cpu_id = 118, .valid = 0, .name = "" },
+	{ .fc_id = 239, .cpu_id = 119, .valid = 1, .name = "PLL0" },
+	{ .fc_id = 240, .cpu_id = 119, .valid = 1, .name = "PLL1" },
+	{ .fc_id = 241, .cpu_id = 119, .valid = 1, .name = "PLL2" },
+	{ .fc_id = 242, .cpu_id = 119, .valid = 1, .name = "PLL3" },
+	{ .fc_id = 243, .cpu_id = 119, .valid = 1, .name = "PLL4" },
+	{ .fc_id = 244, .cpu_id = 119, .valid = 1, .name = "PLL5" },
+	{ .fc_id = 245, .cpu_id = 119, .valid = 1, .name = "PLL6" },
+	{ .fc_id = 246, .cpu_id = 119, .valid = 1, .name = "PLL7" },
+	{ .fc_id = 247, .cpu_id = 119, .valid = 1, .name = "PLL8" },
+	{ .fc_id = 248, .cpu_id = 119, .valid = 1, .name = "PLL9" },
+	{ .fc_id = 249, .cpu_id = 119, .valid = 1, .name = "PLL10" },
+	{ .fc_id = 250, .cpu_id = 119, .valid = 1, .name = "PLL11" },
+	{ .fc_id = 251, .cpu_id = 119, .valid = 1, .name = "PLL12" },
+	{ .fc_id = 252, .cpu_id = 119, .valid = 1, .name = "PLL13" },
+	{ .fc_id = 253, .cpu_id = 119, .valid = 1, .name = "PLL14" },
+	{ .fc_id = 254, .cpu_id = 119, .valid = 1, .name = "PLL15" },
+	{ .fc_id = 255, .cpu_id = 119, .valid = 1, .name = "PLL16" },
+	{ .fc_id = 256, .cpu_id = 119, .valid = 1, .name = "PLL17" },
+	{ .fc_id = 257, .cpu_id = 120, .valid = 1,
+		.name = "CPU_AXI_SPLITTER" },
+	{ .fc_id = 258, .cpu_id = 121, .valid = 0, .name = "" },
+	{ .fc_id = 259, .cpu_id = 122, .valid = 0, .name = "" },
+	{ .fc_id = 260, .cpu_id = 123, .valid = 0, .name = "" },
+	{ .fc_id = 261, .cpu_id = 124, .valid = 0, .name = "" },
+	{ .fc_id = 262, .cpu_id = 125, .valid = 1, .name = "PSOC_AXI_DEC" },
+	{ .fc_id = 263, .cpu_id = 126, .valid = 1, .name = "PSOC_PRSTN_FALL" },
+	{ .fc_id = 264, .cpu_id = 127, .valid = 1, .name = "NIC_SEI_0" },
+	{ .fc_id = 265, .cpu_id = 127, .valid = 1, .name = "NIC_SEI_1" },
+	{ .fc_id = 266, .cpu_id = 127, .valid = 1, .name = "NIC_SEI_2" },
+	{ .fc_id = 267, .cpu_id = 127, .valid = 1, .name = "NIC_SEI_3" },
+	{ .fc_id = 268, .cpu_id = 127, .valid = 1, .name = "NIC_SEI_4" },
+	{ .fc_id = 269, .cpu_id = 128, .valid = 0, .name = "" },
+	{ .fc_id = 270, .cpu_id = 128, .valid = 0, .name = "" },
+	{ .fc_id = 271, .cpu_id = 128, .valid = 0, .name = "" },
+	{ .fc_id = 272, .cpu_id = 128, .valid = 0, .name = "" },
+	{ .fc_id = 273, .cpu_id = 128, .valid = 0, .name = "" },
+	{ .fc_id = 274, .cpu_id = 128, .valid = 0, .name = "" },
+	{ .fc_id = 275, .cpu_id = 128, .valid = 0, .name = "" },
+	{ .fc_id = 276, .cpu_id = 128, .valid = 0, .name = "" },
+	{ .fc_id = 277, .cpu_id = 129, .valid = 0, .name = "" },
+	{ .fc_id = 278, .cpu_id = 129, .valid = 0, .name = "" },
+	{ .fc_id = 279, .cpu_id = 129, .valid = 0, .name = "" },
+	{ .fc_id = 280, .cpu_id = 129, .valid = 0, .name = "" },
+	{ .fc_id = 281, .cpu_id = 130, .valid = 0, .name = "" },
+	{ .fc_id = 282, .cpu_id = 131, .valid = 0, .name = "" },
+	{ .fc_id = 283, .cpu_id = 132, .valid = 0, .name = "" },
+	{ .fc_id = 284, .cpu_id = 133, .valid = 0, .name = "" },
+	{ .fc_id = 285, .cpu_id = 134, .valid = 0, .name = "" },
+	{ .fc_id = 286, .cpu_id = 135, .valid = 0, .name = "" },
+	{ .fc_id = 287, .cpu_id = 136, .valid = 0, .name = "" },
+	{ .fc_id = 288, .cpu_id = 137, .valid = 0, .name = "" },
+	{ .fc_id = 289, .cpu_id = 138, .valid = 0, .name = "" },
+	{ .fc_id = 290, .cpu_id = 139, .valid = 1, .name = "PCIE_FLR" },
+	{ .fc_id = 291, .cpu_id = 140, .valid = 0, .name = "" },
+	{ .fc_id = 292, .cpu_id = 141, .valid = 0, .name = "" },
+	{ .fc_id = 293, .cpu_id = 142, .valid = 0, .name = "" },
+	{ .fc_id = 294, .cpu_id = 143, .valid = 0, .name = "" },
+	{ .fc_id = 295, .cpu_id = 144, .valid = 0, .name = "" },
+	{ .fc_id = 296, .cpu_id = 145, .valid = 0, .name = "" },
+	{ .fc_id = 297, .cpu_id = 146, .valid = 0, .name = "" },
+	{ .fc_id = 298, .cpu_id = 147, .valid = 0, .name = "" },
+	{ .fc_id = 299, .cpu_id = 148, .valid = 0, .name = "" },
+	{ .fc_id = 300, .cpu_id = 149, .valid = 1, .name = "TPC0_BMON_SPMU" },
+	{ .fc_id = 301, .cpu_id = 150, .valid = 1, .name = "TPC0_KRN_ERR" },
+	{ .fc_id = 302, .cpu_id = 151, .valid = 0, .name = "" },
+	{ .fc_id = 303, .cpu_id = 152, .valid = 0, .name = "" },
+	{ .fc_id = 304, .cpu_id = 153, .valid = 0, .name = "" },
+	{ .fc_id = 305, .cpu_id = 154, .valid = 0, .name = "" },
+	{ .fc_id = 306, .cpu_id = 155, .valid = 1, .name = "TPC1_BMON_SPMU" },
+	{ .fc_id = 307, .cpu_id = 156, .valid = 1, .name = "TPC1_KRN_ERR" },
+	{ .fc_id = 308, .cpu_id = 157, .valid = 0, .name = "" },
+	{ .fc_id = 309, .cpu_id = 158, .valid = 0, .name = "" },
+	{ .fc_id = 310, .cpu_id = 159, .valid = 0, .name = "" },
+	{ .fc_id = 311, .cpu_id = 160, .valid = 0, .name = "" },
+	{ .fc_id = 312, .cpu_id = 161, .valid = 1, .name = "TPC2_BMON_SPMU" },
+	{ .fc_id = 313, .cpu_id = 162, .valid = 1, .name = "TPC2_KRN_ERR" },
+	{ .fc_id = 314, .cpu_id = 163, .valid = 0, .name = "" },
+	{ .fc_id = 315, .cpu_id = 164, .valid = 0, .name = "" },
+	{ .fc_id = 316, .cpu_id = 165, .valid = 0, .name = "" },
+	{ .fc_id = 317, .cpu_id = 166, .valid = 0, .name = "" },
+	{ .fc_id = 318, .cpu_id = 167, .valid = 1, .name = "TPC3_BMON_SPMU" },
+	{ .fc_id = 319, .cpu_id = 168, .valid = 1, .name = "TPC3_KRN_ERR" },
+	{ .fc_id = 320, .cpu_id = 169, .valid = 0, .name = "" },
+	{ .fc_id = 321, .cpu_id = 170, .valid = 0, .name = "" },
+	{ .fc_id = 322, .cpu_id = 171, .valid = 0, .name = "" },
+	{ .fc_id = 323, .cpu_id = 172, .valid = 0, .name = "" },
+	{ .fc_id = 324, .cpu_id = 173, .valid = 1, .name = "TPC4_BMON_SPMU" },
+	{ .fc_id = 325, .cpu_id = 174, .valid = 1, .name = "TPC4_KRN_ERR" },
+	{ .fc_id = 326, .cpu_id = 175, .valid = 0, .name = "" },
+	{ .fc_id = 327, .cpu_id = 176, .valid = 0, .name = "" },
+	{ .fc_id = 328, .cpu_id = 177, .valid = 0, .name = "" },
+	{ .fc_id = 329, .cpu_id = 178, .valid = 0, .name = "" },
+	{ .fc_id = 330, .cpu_id = 179, .valid = 1, .name = "TPC5_BMON_SPMU" },
+	{ .fc_id = 331, .cpu_id = 180, .valid = 1, .name = "TPC5_KRN_ERR" },
+	{ .fc_id = 332, .cpu_id = 181, .valid = 0, .name = "" },
+	{ .fc_id = 333, .cpu_id = 182, .valid = 0, .name = "" },
+	{ .fc_id = 334, .cpu_id = 183, .valid = 0, .name = "" },
+	{ .fc_id = 335, .cpu_id = 184, .valid = 0, .name = "" },
+	{ .fc_id = 336, .cpu_id = 185, .valid = 1, .name = "TPC6_BMON_SPMU" },
+	{ .fc_id = 337, .cpu_id = 186, .valid = 1, .name = "TPC6_KRN_ERR" },
+	{ .fc_id = 338, .cpu_id = 187, .valid = 0, .name = "" },
+	{ .fc_id = 339, .cpu_id = 188, .valid = 0, .name = "" },
+	{ .fc_id = 340, .cpu_id = 189, .valid = 0, .name = "" },
+	{ .fc_id = 341, .cpu_id = 190, .valid = 0, .name = "" },
+	{ .fc_id = 342, .cpu_id = 191, .valid = 1, .name = "TPC7_BMON_SPMU" },
+	{ .fc_id = 343, .cpu_id = 192, .valid = 1, .name = "TPC7_KRN_ERR" },
+	{ .fc_id = 344, .cpu_id = 193, .valid = 0, .name = "" },
+	{ .fc_id = 345, .cpu_id = 194, .valid = 0, .name = "" },
+	{ .fc_id = 346, .cpu_id = 195, .valid = 0, .name = "" },
+	{ .fc_id = 347, .cpu_id = 196, .valid = 0, .name = "" },
+	{ .fc_id = 348, .cpu_id = 197, .valid = 0, .name = "" },
+	{ .fc_id = 349, .cpu_id = 198, .valid = 0, .name = "" },
+	{ .fc_id = 350, .cpu_id = 199, .valid = 0, .name = "" },
+	{ .fc_id = 351, .cpu_id = 200, .valid = 0, .name = "" },
+	{ .fc_id = 352, .cpu_id = 201, .valid = 0, .name = "" },
+	{ .fc_id = 353, .cpu_id = 202, .valid = 0, .name = "" },
+	{ .fc_id = 354, .cpu_id = 203, .valid = 0, .name = "" },
+	{ .fc_id = 355, .cpu_id = 204, .valid = 0, .name = "" },
+	{ .fc_id = 356, .cpu_id = 205, .valid = 0, .name = "" },
+	{ .fc_id = 357, .cpu_id = 206, .valid = 0, .name = "" },
+	{ .fc_id = 358, .cpu_id = 207, .valid = 0, .name = "" },
+	{ .fc_id = 359, .cpu_id = 208, .valid = 0, .name = "" },
+	{ .fc_id = 360, .cpu_id = 209, .valid = 0, .name = "" },
+	{ .fc_id = 361, .cpu_id = 210, .valid = 0, .name = "" },
+	{ .fc_id = 362, .cpu_id = 211, .valid = 0, .name = "" },
+	{ .fc_id = 363, .cpu_id = 212, .valid = 0, .name = "" },
+	{ .fc_id = 364, .cpu_id = 213, .valid = 0, .name = "" },
+	{ .fc_id = 365, .cpu_id = 214, .valid = 0, .name = "" },
+	{ .fc_id = 366, .cpu_id = 215, .valid = 0, .name = "" },
+	{ .fc_id = 367, .cpu_id = 216, .valid = 0, .name = "" },
+	{ .fc_id = 368, .cpu_id = 217, .valid = 0, .name = "" },
+	{ .fc_id = 369, .cpu_id = 218, .valid = 0, .name = "" },
+	{ .fc_id = 370, .cpu_id = 219, .valid = 0, .name = "" },
+	{ .fc_id = 371, .cpu_id = 220, .valid = 0, .name = "" },
+	{ .fc_id = 372, .cpu_id = 221, .valid = 0, .name = "" },
+	{ .fc_id = 373, .cpu_id = 222, .valid = 0, .name = "" },
+	{ .fc_id = 374, .cpu_id = 223, .valid = 0, .name = "" },
+	{ .fc_id = 375, .cpu_id = 224, .valid = 0, .name = "" },
+	{ .fc_id = 376, .cpu_id = 225, .valid = 0, .name = "" },
+	{ .fc_id = 377, .cpu_id = 226, .valid = 0, .name = "" },
+	{ .fc_id = 378, .cpu_id = 227, .valid = 0, .name = "" },
+	{ .fc_id = 379, .cpu_id = 228, .valid = 0, .name = "" },
+	{ .fc_id = 380, .cpu_id = 229, .valid = 1, .name = "MMU_PAGE_FAULT" },
+	{ .fc_id = 381, .cpu_id = 230, .valid = 1, .name = "MMU_WR_PERM" },
+	{ .fc_id = 382, .cpu_id = 231, .valid = 0, .name = "" },
+	{ .fc_id = 383, .cpu_id = 232, .valid = 1, .name = "DMA_BM_CH0" },
+	{ .fc_id = 384, .cpu_id = 233, .valid = 1, .name = "DMA_BM_CH1" },
+	{ .fc_id = 385, .cpu_id = 234, .valid = 1, .name = "DMA_BM_CH2" },
+	{ .fc_id = 386, .cpu_id = 235, .valid = 1, .name = "DMA_BM_CH3" },
+	{ .fc_id = 387, .cpu_id = 236, .valid = 1, .name = "DMA_BM_CH4" },
+	{ .fc_id = 388, .cpu_id = 237, .valid = 1, .name = "DMA_BM_CH5" },
+	{ .fc_id = 389, .cpu_id = 238, .valid = 1, .name = "DMA_BM_CH6" },
+	{ .fc_id = 390, .cpu_id = 239, .valid = 1, .name = "DMA_BM_CH7" },
+	{ .fc_id = 391, .cpu_id = 240, .valid = 0, .name = "" },
+	{ .fc_id = 392, .cpu_id = 241, .valid = 0, .name = "" },
+	{ .fc_id = 393, .cpu_id = 242, .valid = 0, .name = "" },
+	{ .fc_id = 394, .cpu_id = 243, .valid = 0, .name = "" },
+	{ .fc_id = 395, .cpu_id = 244, .valid = 1, .name = "HBM0_SPI_0" },
+	{ .fc_id = 396, .cpu_id = 245, .valid = 1, .name = "HBM0_SPI_1" },
+	{ .fc_id = 397, .cpu_id = 246, .valid = 0, .name = "" },
+	{ .fc_id = 398, .cpu_id = 247, .valid = 0, .name = "" },
+	{ .fc_id = 399, .cpu_id = 248, .valid = 1, .name = "HBM1_SPI_0" },
+	{ .fc_id = 400, .cpu_id = 249, .valid = 1, .name = "HBM1_SPI_1" },
+	{ .fc_id = 401, .cpu_id = 250, .valid = 0, .name = "" },
+	{ .fc_id = 402, .cpu_id = 251, .valid = 0, .name = "" },
+	{ .fc_id = 403, .cpu_id = 252, .valid = 1, .name = "HBM2_SPI_0" },
+	{ .fc_id = 404, .cpu_id = 253, .valid = 1, .name = "HBM2_SPI_1" },
+	{ .fc_id = 405, .cpu_id = 254, .valid = 0, .name = "" },
+	{ .fc_id = 406, .cpu_id = 255, .valid = 0, .name = "" },
+	{ .fc_id = 407, .cpu_id = 256, .valid = 1, .name = "HBM3_SPI_0" },
+	{ .fc_id = 408, .cpu_id = 257, .valid = 1, .name = "HBM3_SPI_1" },
+	{ .fc_id = 409, .cpu_id = 258, .valid = 0, .name = "" },
+	{ .fc_id = 410, .cpu_id = 259, .valid = 0, .name = "" },
+	{ .fc_id = 411, .cpu_id = 260, .valid = 0, .name = "" },
+	{ .fc_id = 412, .cpu_id = 261, .valid = 0, .name = "" },
+	{ .fc_id = 413, .cpu_id = 262, .valid = 0, .name = "" },
+	{ .fc_id = 414, .cpu_id = 263, .valid = 0, .name = "" },
+	{ .fc_id = 415, .cpu_id = 264, .valid = 0, .name = "" },
+	{ .fc_id = 416, .cpu_id = 265, .valid = 0, .name = "" },
+	{ .fc_id = 417, .cpu_id = 266, .valid = 0, .name = "" },
+	{ .fc_id = 418, .cpu_id = 267, .valid = 0, .name = "" },
+	{ .fc_id = 419, .cpu_id = 268, .valid = 0, .name = "" },
+	{ .fc_id = 420, .cpu_id = 269, .valid = 0, .name = "" },
+	{ .fc_id = 421, .cpu_id = 270, .valid = 1, .name = "PSOC_GPIO_U16_0" },
+	{ .fc_id = 422, .cpu_id = 271, .valid = 0, .name = "" },
+	{ .fc_id = 423, .cpu_id = 272, .valid = 0, .name = "" },
+	{ .fc_id = 424, .cpu_id = 273, .valid = 0, .name = "" },
+	{ .fc_id = 425, .cpu_id = 274, .valid = 0, .name = "" },
+	{ .fc_id = 426, .cpu_id = 275, .valid = 0, .name = "" },
+	{ .fc_id = 427, .cpu_id = 276, .valid = 0, .name = "" },
+	{ .fc_id = 428, .cpu_id = 277, .valid = 0, .name = "" },
+	{ .fc_id = 429, .cpu_id = 278, .valid = 0, .name = "" },
+	{ .fc_id = 430, .cpu_id = 279, .valid = 0, .name = "" },
+	{ .fc_id = 431, .cpu_id = 280, .valid = 0, .name = "" },
+	{ .fc_id = 432, .cpu_id = 281, .valid = 0, .name = "" },
+	{ .fc_id = 433, .cpu_id = 282, .valid = 0, .name = "" },
+	{ .fc_id = 434, .cpu_id = 283, .valid = 0, .name = "" },
+	{ .fc_id = 435, .cpu_id = 284, .valid = 0, .name = "" },
+	{ .fc_id = 436, .cpu_id = 285, .valid = 0, .name = "" },
+	{ .fc_id = 437, .cpu_id = 286, .valid = 0, .name = "" },
+	{ .fc_id = 438, .cpu_id = 287, .valid = 0, .name = "" },
+	{ .fc_id = 439, .cpu_id = 288, .valid = 0, .name = "" },
+	{ .fc_id = 440, .cpu_id = 289, .valid = 0, .name = "" },
+	{ .fc_id = 441, .cpu_id = 290, .valid = 0, .name = "" },
+	{ .fc_id = 442, .cpu_id = 291, .valid = 0, .name = "" },
+	{ .fc_id = 443, .cpu_id = 292, .valid = 0, .name = "" },
+	{ .fc_id = 444, .cpu_id = 293, .valid = 0, .name = "" },
+	{ .fc_id = 445, .cpu_id = 294, .valid = 0, .name = "" },
+	{ .fc_id = 446, .cpu_id = 295, .valid = 0, .name = "" },
+	{ .fc_id = 447, .cpu_id = 296, .valid = 0, .name = "" },
+	{ .fc_id = 448, .cpu_id = 297, .valid = 0, .name = "" },
+	{ .fc_id = 449, .cpu_id = 298, .valid = 0, .name = "" },
+	{ .fc_id = 450, .cpu_id = 299, .valid = 0, .name = "" },
+	{ .fc_id = 451, .cpu_id = 300, .valid = 0, .name = "" },
+	{ .fc_id = 452, .cpu_id = 301, .valid = 0, .name = "" },
+	{ .fc_id = 453, .cpu_id = 302, .valid = 0, .name = "" },
+	{ .fc_id = 454, .cpu_id = 303, .valid = 0, .name = "" },
+	{ .fc_id = 455, .cpu_id = 304, .valid = 0, .name = "" },
+	{ .fc_id = 456, .cpu_id = 305, .valid = 0, .name = "" },
+	{ .fc_id = 457, .cpu_id = 306, .valid = 0, .name = "" },
+	{ .fc_id = 458, .cpu_id = 307, .valid = 0, .name = "" },
+	{ .fc_id = 459, .cpu_id = 308, .valid = 0, .name = "" },
+	{ .fc_id = 460, .cpu_id = 309, .valid = 0, .name = "" },
+	{ .fc_id = 461, .cpu_id = 310, .valid = 0, .name = "" },
+	{ .fc_id = 462, .cpu_id = 311, .valid = 0, .name = "" },
+	{ .fc_id = 463, .cpu_id = 312, .valid = 0, .name = "" },
+	{ .fc_id = 464, .cpu_id = 313, .valid = 0, .name = "" },
+	{ .fc_id = 465, .cpu_id = 314, .valid = 0, .name = "" },
+	{ .fc_id = 466, .cpu_id = 315, .valid = 0, .name = "" },
+	{ .fc_id = 467, .cpu_id = 316, .valid = 0, .name = "" },
+	{ .fc_id = 468, .cpu_id = 317, .valid = 0, .name = "" },
+	{ .fc_id = 469, .cpu_id = 318, .valid = 0, .name = "" },
+	{ .fc_id = 470, .cpu_id = 319, .valid = 0, .name = "" },
+	{ .fc_id = 471, .cpu_id = 320, .valid = 0, .name = "" },
+	{ .fc_id = 472, .cpu_id = 321, .valid = 0, .name = "" },
+	{ .fc_id = 473, .cpu_id = 322, .valid = 0, .name = "" },
+	{ .fc_id = 474, .cpu_id = 323, .valid = 0, .name = "" },
+	{ .fc_id = 475, .cpu_id = 324, .valid = 0, .name = "" },
+	{ .fc_id = 476, .cpu_id = 325, .valid = 0, .name = "" },
+	{ .fc_id = 477, .cpu_id = 326, .valid = 0, .name = "" },
+	{ .fc_id = 478, .cpu_id = 327, .valid = 0, .name = "" },
+	{ .fc_id = 479, .cpu_id = 328, .valid = 0, .name = "" },
+	{ .fc_id = 480, .cpu_id = 329, .valid = 0, .name = "" },
+	{ .fc_id = 481, .cpu_id = 330, .valid = 0, .name = "" },
+	{ .fc_id = 482, .cpu_id = 331, .valid = 0, .name = "" },
+	{ .fc_id = 483, .cpu_id = 332, .valid = 0, .name = "" },
+	{ .fc_id = 484, .cpu_id = 333, .valid = 1, .name = "PI_UPDATE" },
+	{ .fc_id = 485, .cpu_id = 334, .valid = 1, .name = "HALT_MACHINE" },
+	{ .fc_id = 486, .cpu_id = 335, .valid = 1, .name = "INTS_REGISTER" },
+	{ .fc_id = 487, .cpu_id = 336, .valid = 1, .name = "SOFT_RESET" },
+	{ .fc_id = 488, .cpu_id = 337, .valid = 0, .name = "" },
+	{ .fc_id = 489, .cpu_id = 338, .valid = 0, .name = "" },
+	{ .fc_id = 490, .cpu_id = 339, .valid = 0, .name = "" },
+	{ .fc_id = 491, .cpu_id = 340, .valid = 0, .name = "" },
+	{ .fc_id = 492, .cpu_id = 341, .valid = 0, .name = "" },
+	{ .fc_id = 493, .cpu_id = 342, .valid = 0, .name = "" },
+	{ .fc_id = 494, .cpu_id = 343, .valid = 0, .name = "" },
+	{ .fc_id = 495, .cpu_id = 344, .valid = 0, .name = "" },
+	{ .fc_id = 496, .cpu_id = 345, .valid = 0, .name = "" },
+	{ .fc_id = 497, .cpu_id = 346, .valid = 0, .name = "" },
+	{ .fc_id = 498, .cpu_id = 347, .valid = 0, .name = "" },
+	{ .fc_id = 499, .cpu_id = 348, .valid = 0, .name = "" },
+	{ .fc_id = 500, .cpu_id = 349, .valid = 0, .name = "" },
+	{ .fc_id = 501, .cpu_id = 350, .valid = 0, .name = "" },
+	{ .fc_id = 502, .cpu_id = 351, .valid = 0, .name = "" },
+	{ .fc_id = 503, .cpu_id = 352, .valid = 0, .name = "" },
+	{ .fc_id = 504, .cpu_id = 353, .valid = 0, .name = "" },
+	{ .fc_id = 505, .cpu_id = 354, .valid = 0, .name = "" },
+	{ .fc_id = 506, .cpu_id = 355, .valid = 0, .name = "" },
+	{ .fc_id = 507, .cpu_id = 356, .valid = 0, .name = "" },
+	{ .fc_id = 508, .cpu_id = 357, .valid = 0, .name = "" },
+	{ .fc_id = 509, .cpu_id = 358, .valid = 0, .name = "" },
+	{ .fc_id = 510, .cpu_id = 359, .valid = 0, .name = "" },
+	{ .fc_id = 511, .cpu_id = 360, .valid = 0, .name = "" },
+	{ .fc_id = 512, .cpu_id = 361, .valid = 0, .name = "" },
+	{ .fc_id = 513, .cpu_id = 362, .valid = 0, .name = "" },
+	{ .fc_id = 514, .cpu_id = 363, .valid = 0, .name = "" },
+	{ .fc_id = 515, .cpu_id = 364, .valid = 0, .name = "" },
+	{ .fc_id = 516, .cpu_id = 365, .valid = 0, .name = "" },
+	{ .fc_id = 517, .cpu_id = 366, .valid = 0, .name = "" },
+	{ .fc_id = 518, .cpu_id = 367, .valid = 0, .name = "" },
+	{ .fc_id = 519, .cpu_id = 368, .valid = 0, .name = "" },
+	{ .fc_id = 520, .cpu_id = 369, .valid = 0, .name = "" },
+	{ .fc_id = 521, .cpu_id = 370, .valid = 0, .name = "" },
+	{ .fc_id = 522, .cpu_id = 371, .valid = 0, .name = "" },
+	{ .fc_id = 523, .cpu_id = 372, .valid = 0, .name = "" },
+	{ .fc_id = 524, .cpu_id = 373, .valid = 0, .name = "" },
+	{ .fc_id = 525, .cpu_id = 374, .valid = 0, .name = "" },
+	{ .fc_id = 526, .cpu_id = 375, .valid = 0, .name = "" },
+	{ .fc_id = 527, .cpu_id = 376, .valid = 0, .name = "" },
+	{ .fc_id = 528, .cpu_id = 377, .valid = 0, .name = "" },
+	{ .fc_id = 529, .cpu_id = 378, .valid = 0, .name = "" },
+	{ .fc_id = 530, .cpu_id = 379, .valid = 0, .name = "" },
+	{ .fc_id = 531, .cpu_id = 380, .valid = 0, .name = "" },
+	{ .fc_id = 532, .cpu_id = 381, .valid = 0, .name = "" },
+	{ .fc_id = 533, .cpu_id = 382, .valid = 0, .name = "" },
+	{ .fc_id = 534, .cpu_id = 383, .valid = 0, .name = "" },
+	{ .fc_id = 535, .cpu_id = 384, .valid = 0, .name = "" },
+	{ .fc_id = 536, .cpu_id = 385, .valid = 0, .name = "" },
+	{ .fc_id = 537, .cpu_id = 386, .valid = 0, .name = "" },
+	{ .fc_id = 538, .cpu_id = 387, .valid = 0, .name = "" },
+	{ .fc_id = 539, .cpu_id = 388, .valid = 0, .name = "" },
+	{ .fc_id = 540, .cpu_id = 389, .valid = 0, .name = "" },
+	{ .fc_id = 541, .cpu_id = 390, .valid = 0, .name = "" },
+	{ .fc_id = 542, .cpu_id = 391, .valid = 0, .name = "" },
+	{ .fc_id = 543, .cpu_id = 392, .valid = 0, .name = "" },
+	{ .fc_id = 544, .cpu_id = 393, .valid = 0, .name = "" },
+	{ .fc_id = 545, .cpu_id = 394, .valid = 0, .name = "" },
+	{ .fc_id = 546, .cpu_id = 395, .valid = 0, .name = "" },
+	{ .fc_id = 547, .cpu_id = 396, .valid = 0, .name = "" },
+	{ .fc_id = 548, .cpu_id = 397, .valid = 1, .name = "RAZWI_OR_ADC" },
+	{ .fc_id = 549, .cpu_id = 398, .valid = 0, .name = "" },
+	{ .fc_id = 550, .cpu_id = 399, .valid = 0, .name = "" },
+	{ .fc_id = 551, .cpu_id = 400, .valid = 0, .name = "" },
+	{ .fc_id = 552, .cpu_id = 401, .valid = 0, .name = "" },
+	{ .fc_id = 553, .cpu_id = 402, .valid = 0, .name = "" },
+	{ .fc_id = 554, .cpu_id = 403, .valid = 0, .name = "" },
+	{ .fc_id = 555, .cpu_id = 404, .valid = 0, .name = "" },
+	{ .fc_id = 556, .cpu_id = 405, .valid = 0, .name = "" },
+	{ .fc_id = 557, .cpu_id = 406, .valid = 0, .name = "" },
+	{ .fc_id = 558, .cpu_id = 407, .valid = 0, .name = "" },
+	{ .fc_id = 559, .cpu_id = 408, .valid = 0, .name = "" },
+	{ .fc_id = 560, .cpu_id = 409, .valid = 0, .name = "" },
+	{ .fc_id = 561, .cpu_id = 410, .valid = 0, .name = "" },
+	{ .fc_id = 562, .cpu_id = 411, .valid = 0, .name = "" },
+	{ .fc_id = 563, .cpu_id = 412, .valid = 0, .name = "" },
+	{ .fc_id = 564, .cpu_id = 413, .valid = 0, .name = "" },
+	{ .fc_id = 565, .cpu_id = 414, .valid = 0, .name = "" },
+	{ .fc_id = 566, .cpu_id = 415, .valid = 0, .name = "" },
+	{ .fc_id = 567, .cpu_id = 416, .valid = 0, .name = "" },
+	{ .fc_id = 568, .cpu_id = 417, .valid = 0, .name = "" },
+	{ .fc_id = 569, .cpu_id = 418, .valid = 0, .name = "" },
+	{ .fc_id = 570, .cpu_id = 419, .valid = 0, .name = "" },
+	{ .fc_id = 571, .cpu_id = 420, .valid = 0, .name = "" },
+	{ .fc_id = 572, .cpu_id = 421, .valid = 1, .name = "TPC0_QM" },
+	{ .fc_id = 573, .cpu_id = 422, .valid = 1, .name = "TPC1_QM" },
+	{ .fc_id = 574, .cpu_id = 423, .valid = 1, .name = "TPC2_QM" },
+	{ .fc_id = 575, .cpu_id = 424, .valid = 1, .name = "TPC3_QM" },
+	{ .fc_id = 576, .cpu_id = 425, .valid = 1, .name = "TPC4_QM" },
+	{ .fc_id = 577, .cpu_id = 426, .valid = 1, .name = "TPC5_QM" },
+	{ .fc_id = 578, .cpu_id = 427, .valid = 1, .name = "TPC6_QM" },
+	{ .fc_id = 579, .cpu_id = 428, .valid = 1, .name = "TPC7_QM" },
+	{ .fc_id = 580, .cpu_id = 429, .valid = 0, .name = "" },
+	{ .fc_id = 581, .cpu_id = 430, .valid = 1, .name = "MME0_QM" },
+	{ .fc_id = 582, .cpu_id = 431, .valid = 1, .name = "MME2_QM" },
+	{ .fc_id = 583, .cpu_id = 432, .valid = 1, .name = "DMA0_QM" },
+	{ .fc_id = 584, .cpu_id = 433, .valid = 1, .name = "DMA1_QM" },
+	{ .fc_id = 585, .cpu_id = 434, .valid = 1, .name = "DMA2_QM" },
+	{ .fc_id = 586, .cpu_id = 435, .valid = 1, .name = "DMA3_QM" },
+	{ .fc_id = 587, .cpu_id = 436, .valid = 1, .name = "DMA4_QM" },
+	{ .fc_id = 588, .cpu_id = 437, .valid = 1, .name = "DMA5_QM" },
+	{ .fc_id = 589, .cpu_id = 438, .valid = 1, .name = "DMA6_QM" },
+	{ .fc_id = 590, .cpu_id = 439, .valid = 1, .name = "DMA7_QM" },
+	{ .fc_id = 591, .cpu_id = 440, .valid = 0, .name = "" },
+	{ .fc_id = 592, .cpu_id = 441, .valid = 0, .name = "" },
+	{ .fc_id = 593, .cpu_id = 442, .valid = 0, .name = "" },
+	{ .fc_id = 594, .cpu_id = 443, .valid = 1, .name = "NIC0_QM0" },
+	{ .fc_id = 595, .cpu_id = 444, .valid = 1, .name = "NIC0_QM1" },
+	{ .fc_id = 596, .cpu_id = 445, .valid = 1, .name = "NIC1_QM0" },
+	{ .fc_id = 597, .cpu_id = 446, .valid = 1, .name = "NIC1_QM1" },
+	{ .fc_id = 598, .cpu_id = 447, .valid = 1, .name = "NIC2_QM0" },
+	{ .fc_id = 599, .cpu_id = 448, .valid = 1, .name = "NIC2_QM1" },
+	{ .fc_id = 600, .cpu_id = 449, .valid = 1, .name = "NIC3_QM0" },
+	{ .fc_id = 601, .cpu_id = 450, .valid = 1, .name = "NIC3_QM1" },
+	{ .fc_id = 602, .cpu_id = 451, .valid = 1, .name = "NIC4_QM0" },
+	{ .fc_id = 603, .cpu_id = 452, .valid = 1, .name = "NIC4_QM1" },
+	{ .fc_id = 604, .cpu_id = 453, .valid = 1, .name = "DMA0_CORE" },
+	{ .fc_id = 605, .cpu_id = 454, .valid = 1, .name = "DMA1_CORE" },
+	{ .fc_id = 606, .cpu_id = 455, .valid = 1, .name = "DMA2_CORE" },
+	{ .fc_id = 607, .cpu_id = 456, .valid = 1, .name = "DMA3_CORE" },
+	{ .fc_id = 608, .cpu_id = 457, .valid = 1, .name = "DMA4_CORE" },
+	{ .fc_id = 609, .cpu_id = 458, .valid = 1, .name = "DMA5_CORE" },
+	{ .fc_id = 610, .cpu_id = 459, .valid = 1, .name = "DMA6_CORE" },
+	{ .fc_id = 611, .cpu_id = 460, .valid = 1, .name = "DMA7_CORE" },
+	{ .fc_id = 612, .cpu_id = 461, .valid = 1, .name = "NIC0_QP0" },
+	{ .fc_id = 613, .cpu_id = 462, .valid = 1, .name = "NIC0_QP1" },
+	{ .fc_id = 614, .cpu_id = 463, .valid = 1, .name = "NIC1_QP0" },
+	{ .fc_id = 615, .cpu_id = 464, .valid = 1, .name = "NIC1_QP1" },
+	{ .fc_id = 616, .cpu_id = 465, .valid = 1, .name = "NIC2_QP0" },
+	{ .fc_id = 617, .cpu_id = 466, .valid = 1, .name = "NIC2_QP1" },
+	{ .fc_id = 618, .cpu_id = 467, .valid = 1, .name = "NIC3_QP0" },
+	{ .fc_id = 619, .cpu_id = 468, .valid = 1, .name = "NIC3_QP1" },
+	{ .fc_id = 620, .cpu_id = 469, .valid = 1, .name = "NIC4_QP0" },
+	{ .fc_id = 621, .cpu_id = 470, .valid = 1, .name = "NIC4_QP1" },
+	{ .fc_id = 622, .cpu_id = 471, .valid = 0, .name = "" },
+	{ .fc_id = 623, .cpu_id = 472, .valid = 0, .name = "" },
+	{ .fc_id = 624, .cpu_id = 473, .valid = 0, .name = "" },
+	{ .fc_id = 625, .cpu_id = 474, .valid = 0, .name = "" },
+	{ .fc_id = 626, .cpu_id = 475, .valid = 0, .name = "" },
+	{ .fc_id = 627, .cpu_id = 476, .valid = 0, .name = "" },
+	{ .fc_id = 628, .cpu_id = 477, .valid = 0, .name = "" },
+	{ .fc_id = 629, .cpu_id = 478, .valid = 0, .name = "" },
+	{ .fc_id = 630, .cpu_id = 479, .valid = 0, .name = "" },
+	{ .fc_id = 631, .cpu_id = 480, .valid = 0, .name = "" },
+	{ .fc_id = 632, .cpu_id = 481, .valid = 0, .name = "" },
+	{ .fc_id = 633, .cpu_id = 482, .valid = 0, .name = "" },
+	{ .fc_id = 634, .cpu_id = 483, .valid = 0, .name = "" },
+	{ .fc_id = 635, .cpu_id = 484, .valid = 0, .name = "" },
+	{ .fc_id = 636, .cpu_id = 485, .valid = 0, .name = "" },
+	{ .fc_id = 637, .cpu_id = 486, .valid = 0, .name = "" },
+	{ .fc_id = 638, .cpu_id = 487, .valid = 0, .name = "" },
+	{ .fc_id = 639, .cpu_id = 488, .valid = 0, .name = "" },
+	{ .fc_id = 640, .cpu_id = 489, .valid = 0, .name = "" },
+	{ .fc_id = 641, .cpu_id = 490, .valid = 0, .name = "" },
+	{ .fc_id = 642, .cpu_id = 491, .valid = 0, .name = "" },
+	{ .fc_id = 643, .cpu_id = 492, .valid = 0, .name = "" },
+	{ .fc_id = 644, .cpu_id = 493, .valid = 0, .name = "" },
+	{ .fc_id = 645, .cpu_id = 494, .valid = 0, .name = "" },
+	{ .fc_id = 646, .cpu_id = 495, .valid = 0, .name = "" },
+	{ .fc_id = 647, .cpu_id = 496, .valid = 0, .name = "" },
+	{ .fc_id = 648, .cpu_id = 497, .valid = 0, .name = "" },
+	{ .fc_id = 649, .cpu_id = 498, .valid = 0, .name = "" },
+	{ .fc_id = 650, .cpu_id = 499, .valid = 0, .name = "" },
+	{ .fc_id = 651, .cpu_id = 500, .valid = 0, .name = "" },
+	{ .fc_id = 652, .cpu_id = 501, .valid = 0, .name = "" },
+	{ .fc_id = 653, .cpu_id = 502, .valid = 0, .name = "" },
+	{ .fc_id = 654, .cpu_id = 503, .valid = 0, .name = "" },
+	{ .fc_id = 655, .cpu_id = 504, .valid = 0, .name = "" },
+	{ .fc_id = 656, .cpu_id = 505, .valid = 0, .name = "" },
+	{ .fc_id = 657, .cpu_id = 506, .valid = 0, .name = "" },
+	{ .fc_id = 658, .cpu_id = 507, .valid = 1, .name = "FIX_POWER_ENV_S" },
+	{ .fc_id = 659, .cpu_id = 508, .valid = 1, .name = "FIX_POWER_ENV_E" },
+	{ .fc_id = 660, .cpu_id = 509, .valid = 1,
+		.name = "FIX_THERMAL_ENV_S" },
+	{ .fc_id = 661, .cpu_id = 510, .valid = 1,
+		.name = "FIX_THERMAL_ENV_E" },
+	{ .fc_id = 662, .cpu_id = 511, .valid = 1, .name = "RAZWI_OR_ADC_SW" },
+};
+
+#endif /* __GAUDI_ASYNC_IDS_MAP_EVENTS_EXT_H_ */
-- 
2.17.1

