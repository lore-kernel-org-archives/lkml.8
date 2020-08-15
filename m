Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F082BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B28204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8j/VuFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgHOVzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbgHOVwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:25 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70A2C0F26E4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 10:59:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so11070645wrl.4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 10:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=e3wIjVJIPxn0b5sqpNG3aDwl4cPSXa+cHYjW7Mk1O04=;
        b=O8j/VuFovcSeFdWHsL5nQiRf1CrbSsDh+ft/pIWXpYu6LsyObY8HoH5H+/OfQnOOX+
         Ukn3yV3yKElIkPQAP8vaYit+HHrs9UWCtAUc33gGZImai9OdG/9ImXWaLcVqKX1jP3Ss
         m6Y3rpZ8NcUuRJc2BM3VrJw9df/O0zDBycB0cosHxsNScEhxK7L1PMsyGT7FwzRRWahF
         nc+5NTmtU8ym+EhwG9D2EJ2tPsrklKU+20IYKyvhPldTQUy+VQB9Oj/9tJHfKRtTJzOc
         cgmhvTl6v0VInSADnCNPwoHB07jwokpS6aSi/EwNxZ6dAxVIbODJP/np/JQUyi+WTE7z
         htTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=e3wIjVJIPxn0b5sqpNG3aDwl4cPSXa+cHYjW7Mk1O04=;
        b=loYLDhKxUHfs2QetqqgmyT8zPNO44fl4KKjlsWtKjLaP5fLmvM6WNONWiz6jnV5kll
         v81MdmKsKbArZVCxc+z6gk03D3OJB7G4RAMa+6l6Au1TmgW33QOnvU7aUnvNkmiEPpqm
         JxbJLMmaf4L4PWj4m9eXFHCas7e0+vAnUOAQY2MJz2M8+QRz4qwLOcIijScF6tgb2CFz
         A1H4lI8c3F93SSRRSo7MqaswWnjzEHTHG6iANdF+yB2w/1xRYIyI+gjjpiNlwzykwV1g
         RZ3stq0RyT+H6Vbhnx2XW/TH9RcNPiwy6FAiJlOzyEgIiInxqRmAyjNOkAzstgMcEPDk
         oErw==
X-Gm-Message-State: AOAM531uw/o/mAPCvu2Sum4Ia42//HhGE7/02bVxjvxg6dgfdhCXG3NM
        9IZr3HzbZ4YJGcAdif+hhIgy3sjDq1g=
X-Google-Smtp-Source: ABdhPJwUDhZdffBpG13tnNXnbopFy35Hg+istA1OSHe/8nCVjA64Ym33usMl26Co3dhFN6C0MF4Axg==
X-Received: by 2002:a5d:558a:: with SMTP id i10mr7230545wrv.146.1597514386837;
        Sat, 15 Aug 2020 10:59:46 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id e5sm24460775wrc.37.2020.08.15.10.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 10:59:46 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH 5/9] habanalabs: use FIELD_PREP() instead of <<
Date:   Sat, 15 Aug 2020 20:59:34 +0300
Message-Id: <20200815175938.16619-5-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200815175938.16619-1-oded.gabbay@gmail.com>
References: <20200815175938.16619-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the standard FIELD_PREP() macro instead of << operator to perform
bitmask operations. This ensures type check safety and eliminate compiler
warnings.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/hw_queue.c     |   9 +-
 drivers/misc/habanalabs/gaudi/gaudi.c         |  50 ++--
 .../habanalabs/include/gaudi/gaudi_masks.h    | 274 ++++++++----------
 3 files changed, 154 insertions(+), 179 deletions(-)

diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index 65b9aa69a83e..e2f9ba04b32d 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -8,6 +8,7 @@
 #include "habanalabs.h"
 
 #include <linux/slab.h>
+#include <linux/bitfield.h>
 
 /*
  * hl_queue_add_ptr - add to pi or ci and checks if it wraps around
@@ -288,10 +289,10 @@ static void ext_queue_schedule_job(struct hl_cs_job *job)
 	ptr = cb->bus_address;
 
 	cq_pkt.data = cpu_to_le32(
-				((q->pi << CQ_ENTRY_SHADOW_INDEX_SHIFT)
-					& CQ_ENTRY_SHADOW_INDEX_MASK) |
-				(1 << CQ_ENTRY_SHADOW_INDEX_VALID_SHIFT) |
-				(1 << CQ_ENTRY_READY_SHIFT));
+			((q->pi << CQ_ENTRY_SHADOW_INDEX_SHIFT)
+				& CQ_ENTRY_SHADOW_INDEX_MASK) |
+			FIELD_PREP(CQ_ENTRY_SHADOW_INDEX_VALID_MASK, 1) |
+			FIELD_PREP(CQ_ENTRY_READY_MASK, 1));
 
 	/*
 	 * No need to protect pi_offset because scheduling to the
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 6febfe4fdd81..ed289a6ed622 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -659,10 +659,10 @@ static int _gaudi_init_tpc_mem(struct hl_device *hdev,
 
 	init_tpc_mem_pkt->tsize = cpu_to_le32(tpc_kernel_size);
 
-	ctl = ((PACKET_LIN_DMA << GAUDI_PKT_CTL_OPCODE_SHIFT) |
-			(1 << GAUDI_PKT_LIN_DMA_CTL_LIN_SHIFT) |
-			(1 << GAUDI_PKT_CTL_RB_SHIFT) |
-			(1 << GAUDI_PKT_CTL_MB_SHIFT));
+	ctl = FIELD_PREP(GAUDI_PKT_CTL_OPCODE_MASK, PACKET_LIN_DMA);
+	ctl |= FIELD_PREP(GAUDI_PKT_LIN_DMA_CTL_LIN_MASK, 1);
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_RB_MASK, 1);
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_MB_MASK, 1);
 
 	init_tpc_mem_pkt->ctl = cpu_to_le32(ctl);
 
@@ -2305,7 +2305,8 @@ static void gaudi_init_tpc_qmans(struct hl_device *hdev)
 
 		tpc_offset += mmTPC1_QM_GLBL_CFG0 - mmTPC0_QM_GLBL_CFG0;
 
-		gaudi->hw_cap_initialized |= 1 << (HW_CAP_TPC_SHIFT + tpc_id);
+		gaudi->hw_cap_initialized |=
+				FIELD_PREP(HW_CAP_TPC_MASK, 1 << tpc_id);
 	}
 }
 
@@ -2886,13 +2887,13 @@ static void gaudi_pre_hw_init(struct hl_device *hdev)
 					(CFG_RST_H_DMA_MASK |
 					CFG_RST_H_MME_MASK |
 					CFG_RST_H_SM_MASK |
-					CFG_RST_H_TPC_MASK));
+					CFG_RST_H_TPC_7_MASK));
 
 	WREG32(mmPSOC_GLOBAL_CONF_SOFT_RST_CFG_L, CFG_RST_L_TPC_MASK);
 
 	WREG32(mmPSOC_GLOBAL_CONF_SW_ALL_RST_CFG_H,
 					(CFG_RST_H_HBM_MASK |
-					CFG_RST_H_TPC_MASK |
+					CFG_RST_H_TPC_7_MASK |
 					CFG_RST_H_NIC_MASK |
 					CFG_RST_H_SM_MASK |
 					CFG_RST_H_DMA_MASK |
@@ -3445,9 +3446,10 @@ static int gaudi_test_queue(struct hl_device *hdev, u32 hw_queue_id)
 		goto free_fence_ptr;
 	}
 
-	tmp = (PACKET_MSG_PROT << GAUDI_PKT_CTL_OPCODE_SHIFT) |
-			(1 << GAUDI_PKT_CTL_EB_SHIFT) |
-			(1 << GAUDI_PKT_CTL_MB_SHIFT);
+	tmp = FIELD_PREP(GAUDI_PKT_CTL_OPCODE_MASK, PACKET_MSG_PROT);
+	tmp |= FIELD_PREP(GAUDI_PKT_CTL_EB_MASK, 1);
+	tmp |= FIELD_PREP(GAUDI_PKT_CTL_MB_MASK, 1);
+
 	fence_pkt->ctl = cpu_to_le32(tmp);
 	fence_pkt->value = cpu_to_le32(fence_val);
 	fence_pkt->addr = cpu_to_le64(fence_dma_addr);
@@ -4252,11 +4254,11 @@ static void gaudi_add_end_of_cb_packets(struct hl_device *hdev,
 	cq_pkt = (struct packet_msg_prot *) (uintptr_t)
 		(kernel_address + len - (sizeof(struct packet_msg_prot) * 2));
 
-	tmp = (PACKET_MSG_PROT << GAUDI_PKT_CTL_OPCODE_SHIFT) |
-			(1 << GAUDI_PKT_CTL_MB_SHIFT);
+	tmp = FIELD_PREP(GAUDI_PKT_CTL_OPCODE_MASK, PACKET_MSG_PROT);
+	tmp |= FIELD_PREP(GAUDI_PKT_CTL_MB_MASK, 1);
 
 	if (eb)
-		tmp |= (1 << GAUDI_PKT_CTL_EB_SHIFT);
+		tmp |= FIELD_PREP(GAUDI_PKT_CTL_EB_MASK, 1);
 
 	cq_pkt->ctl = cpu_to_le32(tmp);
 	cq_pkt->value = cpu_to_le32(cq_val);
@@ -4264,8 +4266,8 @@ static void gaudi_add_end_of_cb_packets(struct hl_device *hdev,
 
 	cq_pkt++;
 
-	tmp = (PACKET_MSG_PROT << GAUDI_PKT_CTL_OPCODE_SHIFT) |
-			(1 << GAUDI_PKT_CTL_MB_SHIFT);
+	tmp = FIELD_PREP(GAUDI_PKT_CTL_OPCODE_MASK, PACKET_MSG_PROT);
+	tmp |= FIELD_PREP(GAUDI_PKT_CTL_MB_MASK, 1);
 	cq_pkt->ctl = cpu_to_le32(tmp);
 	cq_pkt->value = cpu_to_le32(1);
 
@@ -4297,11 +4299,12 @@ static int gaudi_memset_device_memory(struct hl_device *hdev, u64 addr,
 	memset(lin_dma_pkt, 0, sizeof(*lin_dma_pkt));
 	cb_size = sizeof(*lin_dma_pkt);
 
-	ctl = ((PACKET_LIN_DMA << GAUDI_PKT_CTL_OPCODE_SHIFT) |
-			(1 << GAUDI_PKT_LIN_DMA_CTL_MEMSET_SHIFT) |
-			(1 << GAUDI_PKT_LIN_DMA_CTL_LIN_SHIFT) |
-			(1 << GAUDI_PKT_CTL_RB_SHIFT) |
-			(1 << GAUDI_PKT_CTL_MB_SHIFT));
+	ctl = FIELD_PREP(GAUDI_PKT_CTL_OPCODE_MASK, PACKET_LIN_DMA);
+	ctl |= FIELD_PREP(GAUDI_PKT_LIN_DMA_CTL_MEMSET_MASK, 1);
+	ctl |= FIELD_PREP(GAUDI_PKT_LIN_DMA_CTL_LIN_MASK, 1);
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_MB_MASK, 1);
+	ctl |= FIELD_PREP(GAUDI_PKT_CTL_RB_MASK, 1);
+
 	lin_dma_pkt->ctl = cpu_to_le32(ctl);
 	lin_dma_pkt->src_addr = cpu_to_le64(val);
 	lin_dma_pkt->dst_addr |= cpu_to_le64(addr);
@@ -4907,9 +4910,10 @@ static int gaudi_send_job_on_qman0(struct hl_device *hdev,
 	fence_pkt = (struct packet_msg_prot *) (uintptr_t) (cb->kernel_address +
 			job->job_cb_size - sizeof(struct packet_msg_prot));
 
-	tmp = (PACKET_MSG_PROT << GAUDI_PKT_CTL_OPCODE_SHIFT) |
-			(1 << GAUDI_PKT_CTL_EB_SHIFT) |
-			(1 << GAUDI_PKT_CTL_MB_SHIFT);
+	tmp = FIELD_PREP(GAUDI_PKT_CTL_OPCODE_MASK, PACKET_MSG_PROT);
+	tmp |= FIELD_PREP(GAUDI_PKT_CTL_EB_MASK, 1);
+	tmp |= FIELD_PREP(GAUDI_PKT_CTL_MB_MASK, 1);
+
 	fence_pkt->ctl = cpu_to_le32(tmp);
 	fence_pkt->value = cpu_to_le32(GAUDI_QMAN0_FENCE_VAL);
 	fence_pkt->addr = cpu_to_le64(fence_dma_addr);
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h b/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
index 13ef6b2887fd..3d4f9aed41f1 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
@@ -9,194 +9,164 @@
 #define GAUDI_MASKS_H_
 
 #include "asic_reg/gaudi_regs.h"
+#include <linux/bitfield.h>
 
 /* Useful masks for bits in various registers */
 #define PCI_DMA_QMAN_ENABLE		(\
-	(0xF << DMA0_QM_GLBL_CFG0_PQF_EN_SHIFT) | \
-	(0xF << DMA0_QM_GLBL_CFG0_CQF_EN_SHIFT) | \
-	(0xF << DMA0_QM_GLBL_CFG0_CP_EN_SHIFT))
+	(FIELD_PREP(DMA0_QM_GLBL_CFG0_PQF_EN_MASK, 0xF)) | \
+	(FIELD_PREP(DMA0_QM_GLBL_CFG0_CQF_EN_MASK, 0xF)) | \
+	(FIELD_PREP(DMA0_QM_GLBL_CFG0_CP_EN_MASK, 0xF)))
 
 #define QMAN_EXTERNAL_MAKE_TRUSTED	(\
-	(0xF << DMA0_QM_GLBL_PROT_PQF_SHIFT) | \
-	(0xF << DMA0_QM_GLBL_PROT_CQF_SHIFT) | \
-	(0xF << DMA0_QM_GLBL_PROT_CP_SHIFT) | \
-	(0x1 << DMA0_QM_GLBL_PROT_ERR_SHIFT))
+	(FIELD_PREP(DMA0_QM_GLBL_PROT_PQF_MASK, 0xF)) | \
+	(FIELD_PREP(DMA0_QM_GLBL_PROT_CQF_MASK, 0xF)) | \
+	(FIELD_PREP(DMA0_QM_GLBL_PROT_CP_MASK, 0xF)) | \
+	(FIELD_PREP(DMA0_QM_GLBL_PROT_ERR_MASK, 0x1)))
 
 #define QMAN_INTERNAL_MAKE_TRUSTED	(\
-	(0xF << DMA0_QM_GLBL_PROT_PQF_SHIFT) | \
-	(0x1 << DMA0_QM_GLBL_PROT_ERR_SHIFT))
+	(FIELD_PREP(DMA0_QM_GLBL_PROT_PQF_MASK, 0xF)) | \
+	(FIELD_PREP(DMA0_QM_GLBL_PROT_ERR_MASK, 0x1)))
 
 #define HBM_DMA_QMAN_ENABLE		(\
-	(0xF << DMA0_QM_GLBL_CFG0_PQF_EN_SHIFT) | \
-	(0x1F << DMA0_QM_GLBL_CFG0_CQF_EN_SHIFT) | \
-	(0x1F << DMA0_QM_GLBL_CFG0_CP_EN_SHIFT))
+	(FIELD_PREP(DMA0_QM_GLBL_CFG0_PQF_EN_MASK, 0xF)) | \
+	(FIELD_PREP(DMA0_QM_GLBL_CFG0_CQF_EN_MASK, 0x1F)) | \
+	(FIELD_PREP(DMA0_QM_GLBL_CFG0_CP_EN_MASK, 0x1F)))
 
 #define QMAN_MME_ENABLE		(\
-	(0xF << MME0_QM_GLBL_CFG0_PQF_EN_SHIFT) | \
-	(0x1F << MME0_QM_GLBL_CFG0_CQF_EN_SHIFT) | \
-	(0x1F << MME0_QM_GLBL_CFG0_CP_EN_SHIFT))
+	(FIELD_PREP(MME0_QM_GLBL_CFG0_PQF_EN_MASK, 0xF)) | \
+	(FIELD_PREP(MME0_QM_GLBL_CFG0_CQF_EN_MASK, 0x1F)) | \
+	(FIELD_PREP(MME0_QM_GLBL_CFG0_CP_EN_MASK, 0x1F)))
 
 #define QMAN_TPC_ENABLE		(\
-	(0xF << TPC0_QM_GLBL_CFG0_PQF_EN_SHIFT) | \
-	(0x1F << TPC0_QM_GLBL_CFG0_CQF_EN_SHIFT) | \
-	(0x1F << TPC0_QM_GLBL_CFG0_CP_EN_SHIFT))
+	(FIELD_PREP(TPC0_QM_GLBL_CFG0_PQF_EN_MASK, 0xF)) | \
+	(FIELD_PREP(TPC0_QM_GLBL_CFG0_CQF_EN_MASK, 0x1F)) | \
+	(FIELD_PREP(TPC0_QM_GLBL_CFG0_CP_EN_MASK, 0x1F)))
 
 #define QMAN_UPPER_CP_CGM_PWR_GATE_EN	(\
-	(0x20 << DMA0_QM_CGM_CFG_IDLE_TH_SHIFT) | \
-	(0xA << DMA0_QM_CGM_CFG_G2F_TH_SHIFT) | \
-	(0x10 << DMA0_QM_CGM_CFG_CP_IDLE_MASK_SHIFT) | \
-	(1 << DMA0_QM_CGM_CFG_EN_SHIFT))
+	(FIELD_PREP(DMA0_QM_CGM_CFG_IDLE_TH_MASK, 0x20)) | \
+	(FIELD_PREP(DMA0_QM_CGM_CFG_G2F_TH_MASK, 0xA)) | \
+	(FIELD_PREP(DMA0_QM_CGM_CFG_CP_IDLE_MASK_MASK, 0x10)) | \
+	(FIELD_PREP(DMA0_QM_CGM_CFG_EN_MASK, 0x1)))
 
 #define QMAN_COMMON_CP_CGM_PWR_GATE_EN	(\
-	(0x20 << DMA0_QM_CGM_CFG_IDLE_TH_SHIFT) | \
-	(0xA << DMA0_QM_CGM_CFG_G2F_TH_SHIFT) | \
-	(0xF << DMA0_QM_CGM_CFG_CP_IDLE_MASK_SHIFT) | \
-	(1 << DMA0_QM_CGM_CFG_EN_SHIFT))
+	(FIELD_PREP(DMA0_QM_CGM_CFG_IDLE_TH_MASK, 0x20)) | \
+	(FIELD_PREP(DMA0_QM_CGM_CFG_G2F_TH_MASK, 0xA)) | \
+	(FIELD_PREP(DMA0_QM_CGM_CFG_CP_IDLE_MASK_MASK, 0xF)) | \
+	(FIELD_PREP(DMA0_QM_CGM_CFG_EN_MASK, 0x1)))
 
 #define PCI_DMA_QMAN_GLBL_ERR_CFG_MSG_EN_MASK	(\
-	(0xF << DMA0_QM_GLBL_ERR_CFG_PQF_ERR_MSG_EN_SHIFT) | \
-	(0xF << DMA0_QM_GLBL_ERR_CFG_CQF_ERR_MSG_EN_SHIFT) | \
-	(0xF << DMA0_QM_GLBL_ERR_CFG_CP_ERR_MSG_EN_SHIFT))
+	(FIELD_PREP(DMA0_QM_GLBL_ERR_CFG_PQF_ERR_MSG_EN_MASK, 0xF)) | \
+	(FIELD_PREP(DMA0_QM_GLBL_ERR_CFG_CQF_ERR_MSG_EN_MASK, 0xF)) | \
+	(FIELD_PREP(DMA0_QM_GLBL_ERR_CFG_CP_ERR_MSG_EN_MASK, 0xF)))
 
 #define PCI_DMA_QMAN_GLBL_ERR_CFG_STOP_ON_ERR_EN_MASK	(\
-	(0xF << DMA0_QM_GLBL_ERR_CFG_PQF_STOP_ON_ERR_SHIFT) | \
-	(0xF << DMA0_QM_GLBL_ERR_CFG_CQF_STOP_ON_ERR_SHIFT) | \
-	(0xF << DMA0_QM_GLBL_ERR_CFG_CP_STOP_ON_ERR_SHIFT))
+	(FIELD_PREP(DMA0_QM_GLBL_ERR_CFG_PQF_STOP_ON_ERR_MASK, 0xF)) | \
+	(FIELD_PREP(DMA0_QM_GLBL_ERR_CFG_CQF_STOP_ON_ERR_MASK, 0xF)) | \
+	(FIELD_PREP(DMA0_QM_GLBL_ERR_CFG_CP_STOP_ON_ERR_MASK, 0xF)))
 
 #define HBM_DMA_QMAN_GLBL_ERR_CFG_MSG_EN_MASK	(\
-	(0xF << DMA0_QM_GLBL_ERR_CFG_PQF_ERR_MSG_EN_SHIFT) | \
-	(0x1F << DMA0_QM_GLBL_ERR_CFG_CQF_ERR_MSG_EN_SHIFT) | \
-	(0x1F << DMA0_QM_GLBL_ERR_CFG_CP_ERR_MSG_EN_SHIFT))
+	(FIELD_PREP(DMA0_QM_GLBL_ERR_CFG_PQF_ERR_MSG_EN_MASK, 0xF)) | \
+	(FIELD_PREP(DMA0_QM_GLBL_ERR_CFG_CQF_ERR_MSG_EN_MASK, 0x1F)) | \
+	(FIELD_PREP(DMA0_QM_GLBL_ERR_CFG_CP_ERR_MSG_EN_MASK, 0x1F)))
 
 #define HBM_DMA_QMAN_GLBL_ERR_CFG_STOP_ON_ERR_EN_MASK	(\
-	(0xF << DMA0_QM_GLBL_ERR_CFG_PQF_STOP_ON_ERR_SHIFT) | \
-	(0x1F << DMA0_QM_GLBL_ERR_CFG_CQF_STOP_ON_ERR_SHIFT) | \
-	(0x1F << DMA0_QM_GLBL_ERR_CFG_CP_STOP_ON_ERR_SHIFT))
+	(FIELD_PREP(DMA0_QM_GLBL_ERR_CFG_PQF_STOP_ON_ERR_MASK, 0xF)) | \
+	(FIELD_PREP(DMA0_QM_GLBL_ERR_CFG_CQF_STOP_ON_ERR_MASK, 0x1F)) | \
+	(FIELD_PREP(DMA0_QM_GLBL_ERR_CFG_CP_STOP_ON_ERR_MASK, 0x1F)))
 
 #define TPC_QMAN_GLBL_ERR_CFG_MSG_EN_MASK	(\
-	(0xF << TPC0_QM_GLBL_ERR_CFG_PQF_ERR_MSG_EN_SHIFT) | \
-	(0x1F << TPC0_QM_GLBL_ERR_CFG_CQF_ERR_MSG_EN_SHIFT) | \
-	(0x1F << TPC0_QM_GLBL_ERR_CFG_CP_ERR_MSG_EN_SHIFT))
+	(FIELD_PREP(TPC0_QM_GLBL_ERR_CFG_PQF_ERR_MSG_EN_MASK, 0xF)) | \
+	(FIELD_PREP(TPC0_QM_GLBL_ERR_CFG_CQF_ERR_MSG_EN_MASK, 0x1F)) | \
+	(FIELD_PREP(TPC0_QM_GLBL_ERR_CFG_CP_ERR_MSG_EN_MASK, 0x1F)))
 
 #define TPC_QMAN_GLBL_ERR_CFG_STOP_ON_ERR_EN_MASK	(\
-	(0xF << TPC0_QM_GLBL_ERR_CFG_PQF_STOP_ON_ERR_SHIFT) | \
-	(0x1F << TPC0_QM_GLBL_ERR_CFG_CQF_STOP_ON_ERR_SHIFT) | \
-	(0x1F << TPC0_QM_GLBL_ERR_CFG_CP_STOP_ON_ERR_SHIFT))
+	(FIELD_PREP(TPC0_QM_GLBL_ERR_CFG_PQF_STOP_ON_ERR_MASK, 0xF)) | \
+	(FIELD_PREP(TPC0_QM_GLBL_ERR_CFG_CQF_STOP_ON_ERR_MASK, 0x1F)) | \
+	(FIELD_PREP(TPC0_QM_GLBL_ERR_CFG_CP_STOP_ON_ERR_MASK, 0x1F)))
 
 #define MME_QMAN_GLBL_ERR_CFG_MSG_EN_MASK	(\
-	(0xF << MME0_QM_GLBL_ERR_CFG_PQF_ERR_MSG_EN_SHIFT) | \
-	(0x1F << MME0_QM_GLBL_ERR_CFG_CQF_ERR_MSG_EN_SHIFT) | \
-	(0x1F << MME0_QM_GLBL_ERR_CFG_CP_ERR_MSG_EN_SHIFT))
+	(FIELD_PREP(MME0_QM_GLBL_ERR_CFG_PQF_ERR_MSG_EN_MASK, 0xF)) | \
+	(FIELD_PREP(MME0_QM_GLBL_ERR_CFG_CQF_ERR_MSG_EN_MASK, 0x1F)) | \
+	(FIELD_PREP(MME0_QM_GLBL_ERR_CFG_CP_ERR_MSG_EN_MASK, 0x1F)))
 
 #define MME_QMAN_GLBL_ERR_CFG_STOP_ON_ERR_EN_MASK	(\
-	(0xF << MME0_QM_GLBL_ERR_CFG_PQF_STOP_ON_ERR_SHIFT) | \
-	(0x1F << MME0_QM_GLBL_ERR_CFG_CQF_STOP_ON_ERR_SHIFT) | \
-	(0x1F << MME0_QM_GLBL_ERR_CFG_CP_STOP_ON_ERR_SHIFT))
+	(FIELD_PREP(MME0_QM_GLBL_ERR_CFG_PQF_STOP_ON_ERR_MASK, 0xF)) | \
+	(FIELD_PREP(MME0_QM_GLBL_ERR_CFG_CQF_STOP_ON_ERR_MASK, 0x1F)) | \
+	(FIELD_PREP(MME0_QM_GLBL_ERR_CFG_CP_STOP_ON_ERR_MASK, 0x1F)))
 
-#define QMAN_CGM1_PWR_GATE_EN	(0xA << DMA0_QM_CGM_CFG1_MASK_TH_SHIFT)
+#define QMAN_CGM1_PWR_GATE_EN	(FIELD_PREP(DMA0_QM_CGM_CFG1_MASK_TH_MASK, 0xA))
 
 /* RESET registers configuration */
-#define CFG_RST_L_PSOC_SHIFT		0
-#define CFG_RST_L_PCIE_SHIFT		1
-#define CFG_RST_L_PCIE_IF_SHIFT		2
-#define CFG_RST_L_HBM_S_PLL_SHIFT	3
-#define CFG_RST_L_TPC_S_PLL_SHIFT	4
-#define CFG_RST_L_MME_S_PLL_SHIFT	5
-#define CFG_RST_L_CPU_PLL_SHIFT		6
-#define CFG_RST_L_PCIE_PLL_SHIFT	7
-#define CFG_RST_L_NIC_S_PLL_SHIFT	8
-#define CFG_RST_L_HBM_N_PLL_SHIFT	9
-#define CFG_RST_L_TPC_N_PLL_SHIFT	10
-#define CFG_RST_L_MME_N_PLL_SHIFT	11
-#define CFG_RST_L_NIC_N_PLL_SHIFT	12
-#define CFG_RST_L_DMA_W_PLL_SHIFT	13
-#define CFG_RST_L_SIF_W_PLL_SHIFT	14
-#define CFG_RST_L_MESH_W_PLL_SHIFT	15
-#define CFG_RST_L_SRAM_W_PLL_SHIFT	16
-#define CFG_RST_L_DMA_E_PLL_SHIFT	17
-#define CFG_RST_L_SIF_E_PLL_SHIFT	18
-#define CFG_RST_L_MESH_E_PLL_SHIFT	19
-#define CFG_RST_L_SRAM_E_PLL_SHIFT	20
-#define CFG_RST_L_IF_1_SHIFT		21
-#define CFG_RST_L_IF_0_SHIFT		22
-#define CFG_RST_L_IF_2_SHIFT		23
-#define CFG_RST_L_IF_3_SHIFT		24
-#define CFG_RST_L_TPC_0_SHIFT		25
-#define CFG_RST_L_TPC_1_SHIFT		26
-#define CFG_RST_L_TPC_2_SHIFT		27
-#define CFG_RST_L_TPC_3_SHIFT		28
-#define CFG_RST_L_TPC_4_SHIFT		29
-#define CFG_RST_L_TPC_5_SHIFT		30
-#define CFG_RST_L_TPC_6_SHIFT		31
-#define CFG_RST_H_TPC_7_SHIFT		0
-#define CFG_RST_H_MME_0_SHIFT		1
-#define CFG_RST_H_MME_1_SHIFT		2
-#define CFG_RST_H_MME_2_SHIFT		3
-#define CFG_RST_H_MME_3_SHIFT		4
-#define CFG_RST_H_HBM_0_SHIFT		5
-#define CFG_RST_H_HBM_1_SHIFT		6
-#define CFG_RST_H_HBM_2_SHIFT		7
-#define CFG_RST_H_HBM_3_SHIFT		8
-#define CFG_RST_H_NIC_0_SHIFT		9
-#define CFG_RST_H_NIC_1_SHIFT		10
-#define CFG_RST_H_NIC_2_SHIFT		11
-#define CFG_RST_H_NIC_3_SHIFT		12
-#define CFG_RST_H_NIC_4_SHIFT		13
-#define CFG_RST_H_SM_0_SHIFT		14
-#define CFG_RST_H_SM_1_SHIFT		15
-#define CFG_RST_H_SM_2_SHIFT		16
-#define CFG_RST_H_SM_3_SHIFT		17
-#define CFG_RST_H_DMA_0_SHIFT		18
-#define CFG_RST_H_DMA_1_SHIFT		19
-#define CFG_RST_H_CPU_SHIFT		20
-#define CFG_RST_H_MMU_SHIFT		21
-
-
-#define CFG_RST_H_DMA_MASK		((1 << CFG_RST_H_DMA_0_SHIFT) | \
-					(1 << CFG_RST_H_DMA_1_SHIFT))
-
-#define CFG_RST_H_CPU_MASK		(1 << CFG_RST_H_CPU_SHIFT)
-#define CFG_RST_H_MMU_MASK		(1 << CFG_RST_H_MMU_SHIFT)
-
-#define CFG_RST_H_HBM_MASK		((1 << CFG_RST_H_HBM_0_SHIFT) | \
-					(1 << CFG_RST_H_HBM_1_SHIFT) | \
-					(1 << CFG_RST_H_HBM_2_SHIFT) | \
-					(1 << CFG_RST_H_HBM_3_SHIFT))
-
-#define CFG_RST_H_NIC_MASK		((1 << CFG_RST_H_NIC_0_SHIFT) | \
-					(1 << CFG_RST_H_NIC_1_SHIFT) | \
-					(1 << CFG_RST_H_NIC_2_SHIFT) | \
-					(1 << CFG_RST_H_NIC_3_SHIFT) | \
-					(1 << CFG_RST_H_NIC_4_SHIFT))
-
-#define CFG_RST_H_SM_MASK		((1 << CFG_RST_H_SM_0_SHIFT) | \
-					(1 << CFG_RST_H_SM_1_SHIFT) | \
-					(1 << CFG_RST_H_SM_2_SHIFT) | \
-					(1 << CFG_RST_H_SM_3_SHIFT))
-
-#define CFG_RST_H_MME_MASK		((1 << CFG_RST_H_MME_0_SHIFT) | \
-					(1 << CFG_RST_H_MME_1_SHIFT) | \
-					(1 << CFG_RST_H_MME_2_SHIFT) | \
-					(1 << CFG_RST_H_MME_3_SHIFT))
-
-#define CFG_RST_L_PSOC_MASK		(1 << CFG_RST_L_PSOC_SHIFT)
-
-#define CFG_RST_L_IF_MASK		((1 << CFG_RST_L_IF_0_SHIFT) | \
-					(1 << CFG_RST_L_IF_1_SHIFT) | \
-					(1 << CFG_RST_L_IF_2_SHIFT) | \
-					(1 << CFG_RST_L_IF_3_SHIFT))
-
-#define CFG_RST_L_TPC_MASK		((1 << CFG_RST_L_TPC_0_SHIFT) | \
-					(1 << CFG_RST_L_TPC_1_SHIFT) | \
-					(1 << CFG_RST_L_TPC_2_SHIFT) | \
-					(1 << CFG_RST_L_TPC_3_SHIFT) | \
-					(1 << CFG_RST_L_TPC_4_SHIFT) | \
-					(1 << CFG_RST_L_TPC_5_SHIFT) | \
-					(1 << CFG_RST_L_TPC_6_SHIFT))
-
-#define CFG_RST_H_TPC_MASK		(1 << CFG_RST_H_TPC_7_SHIFT)
-
-#define CA53_RESET			(1 << CFG_RST_H_CPU_SHIFT)
+#define CFG_RST_L_PSOC_MASK		BIT_MASK(0)
+#define CFG_RST_L_PCIE_MASK		BIT_MASK(1)
+#define CFG_RST_L_PCIE_IF_MASK		BIT_MASK(2)
+#define CFG_RST_L_HBM_S_PLL_MASK	BIT_MASK(3)
+#define CFG_RST_L_TPC_S_PLL_MASK	BIT_MASK(4)
+#define CFG_RST_L_MME_S_PLL_MASK	BIT_MASK(5)
+#define CFG_RST_L_CPU_PLL_MASK		BIT_MASK(6)
+#define CFG_RST_L_PCIE_PLL_MASK		BIT_MASK(7)
+#define CFG_RST_L_NIC_S_PLL_MASK	BIT_MASK(8)
+#define CFG_RST_L_HBM_N_PLL_MASK	BIT_MASK(9)
+#define CFG_RST_L_TPC_N_PLL_MASK	BIT_MASK(10)
+#define CFG_RST_L_MME_N_PLL_MASK	BIT_MASK(11)
+#define CFG_RST_L_NIC_N_PLL_MASK	BIT_MASK(12)
+#define CFG_RST_L_DMA_W_PLL_MASK	BIT_MASK(13)
+#define CFG_RST_L_SIF_W_PLL_MASK	BIT_MASK(14)
+#define CFG_RST_L_MESH_W_PLL_MASK	BIT_MASK(15)
+#define CFG_RST_L_SRAM_W_PLL_MASK	BIT_MASK(16)
+#define CFG_RST_L_DMA_E_PLL_MASK	BIT_MASK(17)
+#define CFG_RST_L_SIF_E_PLL_MASK	BIT_MASK(18)
+#define CFG_RST_L_MESH_E_PLL_MASK	BIT_MASK(19)
+#define CFG_RST_L_SRAM_E_PLL_MASK	BIT_MASK(20)
+
+#define CFG_RST_L_IF_1_MASK		BIT_MASK(21)
+#define CFG_RST_L_IF_0_MASK		BIT_MASK(22)
+#define CFG_RST_L_IF_2_MASK		BIT_MASK(23)
+#define CFG_RST_L_IF_3_MASK		BIT_MASK(24)
+#define CFG_RST_L_IF_MASK		GENMASK(24, 21)
+
+#define CFG_RST_L_TPC_0_MASK		BIT_MASK(25)
+#define CFG_RST_L_TPC_1_MASK		BIT_MASK(26)
+#define CFG_RST_L_TPC_2_MASK		BIT_MASK(27)
+#define CFG_RST_L_TPC_3_MASK		BIT_MASK(28)
+#define CFG_RST_L_TPC_4_MASK		BIT_MASK(29)
+#define CFG_RST_L_TPC_5_MASK		BIT_MASK(30)
+#define CFG_RST_L_TPC_6_MASK		BIT_MASK(31)
+#define CFG_RST_L_TPC_MASK		GENMASK(31, 25)
+
+#define CFG_RST_H_TPC_7_MASK		BIT_MASK(0)
+
+#define CFG_RST_H_MME_0_MASK		BIT_MASK(1)
+#define CFG_RST_H_MME_1_MASK		BIT_MASK(2)
+#define CFG_RST_H_MME_2_MASK		BIT_MASK(3)
+#define CFG_RST_H_MME_3_MASK		BIT_MASK(4)
+#define CFG_RST_H_MME_MASK		GENMASK(4, 1)
+
+#define CFG_RST_H_HBM_0_MASK		BIT_MASK(5)
+#define CFG_RST_H_HBM_1_MASK		BIT_MASK(6)
+#define CFG_RST_H_HBM_2_MASK		BIT_MASK(7)
+#define CFG_RST_H_HBM_3_MASK		BIT_MASK(8)
+#define CFG_RST_H_HBM_MASK		GENMASK(8, 5)
+
+#define CFG_RST_H_NIC_0_MASK		BIT_MASK(9)
+#define CFG_RST_H_NIC_1_MASK		BIT_MASK(10)
+#define CFG_RST_H_NIC_2_MASK		BIT_MASK(11)
+#define CFG_RST_H_NIC_3_MASK		BIT_MASK(12)
+#define CFG_RST_H_NIC_4_MASK		BIT_MASK(13)
+#define CFG_RST_H_NIC_MASK		GENMASK(13, 9)
+
+#define CFG_RST_H_SM_0_MASK		BIT_MASK(14)
+#define CFG_RST_H_SM_1_MASK		BIT_MASK(15)
+#define CFG_RST_H_SM_2_MASK		BIT_MASK(16)
+#define CFG_RST_H_SM_3_MASK		BIT_MASK(17)
+#define CFG_RST_H_SM_MASK		GENMASK(17, 14)
+
+#define CFG_RST_H_DMA_0_MASK		BIT_MASK(18)
+#define CFG_RST_H_DMA_1_MASK		BIT_MASK(19)
+#define CFG_RST_H_DMA_MASK		GENMASK(19, 18)
+
+#define CFG_RST_H_CPU_MASK		BIT_MASK(20)
+#define CFG_RST_H_MMU_MASK		BIT_MASK(21)
 
 #define UNIT_RST_L_PSOC_SHIFT		0
 #define UNIT_RST_L_PCIE_SHIFT		1
-- 
2.17.1

