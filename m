Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1CCC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B8B12075D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqJbBh7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgGENNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 09:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgGENM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 09:12:58 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A41C08C5DE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 06:12:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so36332861wmh.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 06:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=vej+l2IpLbi9RU67p++xAqOB8zg+Wg0nDVkr9lLzT2A=;
        b=NqJbBh7Ixm8myD+2ijELsnFIU0hRSWYtGTwHo0TVzPTogHNMPjrDqLVWa0+ee8ph57
         jwE2tKoZvr3UkfTOdfONJoyJ95Dhe4CWJgfuKEnRVlkiyTA0hhlLu+A2hVi5zIfAnQ8K
         M7/m1wGzWBTVnbxXfUY5fus6aqhEf2+3l6oLfUvSWidXPL7zbtchbFpdPuMDYB+XQDMF
         wVpsMJ5VpcAV8DGfwiyCsIkrbwogZrPwoMeg+govrVsVSvHkjKVTEGu6OkggnnkwbdwR
         uw7sXQ3P+7eMwgzxUZ0syag3a84NuzkhY9Dxz22JyJsQkH0RvSKUXqeL3GUY9+RDxi/Z
         bOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=vej+l2IpLbi9RU67p++xAqOB8zg+Wg0nDVkr9lLzT2A=;
        b=aBZGJkvJ4GmAxuiP5e3nTRv/yO/iMAANMhm5UL/wb1gaDMk5odJWO8XkyBXFvlHPVQ
         wZ8voEMRCMkmrJrrCJZRNzr/Ns07nJLP4YvjpZOABoBvgdXlcAqU8awjkjTXBDBnPDKa
         2UINocqpJ1zVjlP9iBW5iXHQhTEzNKwTPYbl50/mvtYzuNJzEq40ixher/hEwShTlaQn
         vBDHXB1Xa9KdL3tl0Oeb0L9qlJvIV943AvJ8fDIUDYlw0PV0anR1GDI4aGSh74OiELxn
         TYrR0oxNZt0fn0/zh+fG1KNLQKEwRZxcAAzZXlZ+3a8MMt1ZfGNUnVcEhiVEbD66NKxk
         eDFw==
X-Gm-Message-State: AOAM531HwCvq5r9bMMA8RKWga7IifMVObsOEpzhujOm1BuKDIeI9JKK1
        FjoWl0M9rXKsx8xv0KpSMSBvk0Wg
X-Google-Smtp-Source: ABdhPJzCg36ItE2fRX0cdZlfX++YZIAIPJK81rjKnA9GshLP8/KelEeg2kChugvMALK0ZwI8a55PTA==
X-Received: by 2002:a1c:f616:: with SMTP id w22mr46762552wmc.155.1593954776102;
        Sun, 05 Jul 2020 06:12:56 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id 26sm19401809wmj.25.2020.07.05.06.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 06:12:55 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH 7/9] habanalabs: remove soft-reset support from GAUDI
Date:   Sun,  5 Jul 2020 16:12:43 +0300
Message-Id: <20200705131245.9368-7-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200705131245.9368-1-oded.gabbay@gmail.com>
References: <20200705131245.9368-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Soft-reset isn't supported in GAUDI. Remove the code that performs it and
print error in case the user wants to do it via sysfs.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 76 ++++++++++-----------------
 1 file changed, 27 insertions(+), 49 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index a6e40dec3cd2..d3869209dbc6 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -75,7 +75,6 @@
 
 #define GAUDI_PLDM_RESET_WAIT_MSEC	1000		/* 1s */
 #define GAUDI_PLDM_HRESET_TIMEOUT_MSEC	20000		/* 20s */
-#define GAUDI_PLDM_SRESET_TIMEOUT_MSEC	14000		/* 14s */
 #define GAUDI_PLDM_TEST_QUEUE_WAIT_USEC	1000000		/* 1s */
 #define GAUDI_PLDM_MMU_TIMEOUT_USEC	(MMU_CONFIG_TIMEOUT_USEC * 100)
 #define GAUDI_PLDM_QMAN0_TIMEOUT_USEC	(HL_DEVICE_TIMEOUT_USEC * 30)
@@ -2969,46 +2968,37 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 	struct gaudi_device *gaudi = hdev->asic_specific;
 	u32 status, reset_timeout_ms, boot_strap = 0;
 
-	if (hdev->pldm) {
-		if (hard_reset)
-			reset_timeout_ms = GAUDI_PLDM_HRESET_TIMEOUT_MSEC;
-		else
-			reset_timeout_ms = GAUDI_PLDM_SRESET_TIMEOUT_MSEC;
-	} else {
-		reset_timeout_ms = GAUDI_RESET_TIMEOUT_MSEC;
+	if (!hard_reset) {
+		dev_err(hdev->dev, "GAUDI doesn't support soft-reset\n");
+		return;
 	}
 
-	if (hard_reset) {
-		/* Tell ASIC not to re-initialize PCIe */
-		WREG32(mmPREBOOT_PCIE_EN, LKD_HARD_RESET_MAGIC);
+	if (hdev->pldm)
+		reset_timeout_ms = GAUDI_PLDM_HRESET_TIMEOUT_MSEC;
+	else
+		reset_timeout_ms = GAUDI_RESET_TIMEOUT_MSEC;
 
-		boot_strap = RREG32(mmPSOC_GLOBAL_CONF_BOOT_STRAP_PINS);
-		/* H/W bug WA:
-		 * rdata[31:0] = strap_read_val;
-		 * wdata[31:0] = rdata[30:21],1'b0,rdata[20:0]
-		 */
-		boot_strap = (((boot_strap & 0x7FE00000) << 1) |
-				(boot_strap & 0x001FFFFF));
-		WREG32(mmPSOC_GLOBAL_CONF_BOOT_STRAP_PINS, boot_strap & ~0x2);
-
-		/* Restart BTL/BLR upon hard-reset */
-		WREG32(mmPSOC_GLOBAL_CONF_BOOT_SEQ_RE_START, 1);
-
-		WREG32(mmPSOC_GLOBAL_CONF_SW_ALL_RST,
-				1 << PSOC_GLOBAL_CONF_SW_ALL_RST_IND_SHIFT);
-		dev_info(hdev->dev,
-			"Issued HARD reset command, going to wait %dms\n",
-			reset_timeout_ms);
-	} else {
-		/* Don't restart BTL/BLR upon soft-reset */
-		WREG32(mmPSOC_GLOBAL_CONF_BOOT_SEQ_RE_START, 0);
+	/* Tell ASIC not to re-initialize PCIe */
+	WREG32(mmPREBOOT_PCIE_EN, LKD_HARD_RESET_MAGIC);
 
-		WREG32(mmPSOC_GLOBAL_CONF_SOFT_RST,
-				1 << PSOC_GLOBAL_CONF_SOFT_RST_IND_SHIFT);
-		dev_info(hdev->dev,
-			"Issued SOFT reset command, going to wait %dms\n",
-			reset_timeout_ms);
-	}
+	boot_strap = RREG32(mmPSOC_GLOBAL_CONF_BOOT_STRAP_PINS);
+
+	/* H/W bug WA:
+	 * rdata[31:0] = strap_read_val;
+	 * wdata[31:0] = rdata[30:21],1'b0,rdata[20:0]
+	 */
+	boot_strap = (((boot_strap & 0x7FE00000) << 1) |
+			(boot_strap & 0x001FFFFF));
+	WREG32(mmPSOC_GLOBAL_CONF_BOOT_STRAP_PINS, boot_strap & ~0x2);
+
+	/* Restart BTL/BLR upon hard-reset */
+	WREG32(mmPSOC_GLOBAL_CONF_BOOT_SEQ_RE_START, 1);
+
+	WREG32(mmPSOC_GLOBAL_CONF_SW_ALL_RST,
+			1 << PSOC_GLOBAL_CONF_SW_ALL_RST_IND_SHIFT);
+	dev_info(hdev->dev,
+		"Issued HARD reset command, going to wait %dms\n",
+		reset_timeout_ms);
 
 	/*
 	 * After hard reset, we can't poll the BTM_FSM register because the PSOC
@@ -3022,18 +3012,6 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 			"Timeout while waiting for device to reset 0x%x\n",
 			status);
 
-	if (!hard_reset) {
-		gaudi->hw_cap_initialized &= ~(HW_CAP_PCI_DMA | HW_CAP_MME |
-						HW_CAP_TPC_MASK |
-						HW_CAP_HBM_DMA);
-
-		WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR,
-				GAUDI_EVENT_SOFT_RESET);
-		return;
-	}
-
-	/* We continue here only for hard-reset */
-
 	WREG32(mmPSOC_GLOBAL_CONF_BOOT_STRAP_PINS, boot_strap);
 
 	gaudi->hw_cap_initialized &= ~(HW_CAP_CPU | HW_CAP_CPU_Q |
-- 
2.17.1

