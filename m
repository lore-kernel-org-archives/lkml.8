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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F3FC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D744020771
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXYh0q5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgGENNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 09:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgGENMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 09:12:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBA6C061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 06:12:54 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 17so38753669wmo.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 06:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xhGv/8aEHje7W21UxnDPaYg64gsYOPdN+j8Yi95DPd0=;
        b=SXYh0q5/p4KvXpDsZbSM0y765XMK0/Xsx8/pqjc7ZMdlJL4zoxpxkzvWPZLhvWaN3S
         a7F6n4cCUo3ghemw5SZFd++7cP1Ys9/PChyNYR11hNvVZDvP02BCE8UUyhbv9SZoPhxz
         h+PRx3lM88CScCzLnf6yN77faRYMtLF90lEhIu5cHoYLIB5pR2gMf9aqNQdAIeDmeqV/
         2//R1WK7fYBdSqucCDylat3lpoK1gy/8eZIF0d45ulCQHw09k3bfuACoYjbpkwW8k6qZ
         5wFWDyVRkjqjbBWFnqXiCFnTJNNvmstwH9nwr8ppCpCzdHhHwhQ0UuhFMEw5PV+XOuAq
         cQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xhGv/8aEHje7W21UxnDPaYg64gsYOPdN+j8Yi95DPd0=;
        b=Up6bc/IDeFgQNvwrZ0Mt5j0KgIT5TAJaRSIA5u06fnXMVJqaMMpm9EFyGfTGgUEzQ+
         IYRRo63RX5KmR49uYFlyZ6P7Ery/1iKPC1yAV53dS5+v57qWlOYjShA4/PD5hwo/kKP3
         a8tp/uYXwyLD9K3cvPNUfbP7usdqqvfWyuxGfX1InIj3COVyQvSZ8vWlK9KnN72QXEJC
         jrXu75bC24/ohb+3MlPahydd0jKKmN8FjF48H6JN+QgrDBiE57PoPssEsc6mWsQ6Wz/i
         XjhX2yrGm+UUIHJ4tcxBxWaRxUlEenP644c861CbQm7TC8pPGN8P/fQPHiRXoIcydo8J
         p3qQ==
X-Gm-Message-State: AOAM533MokZYByyaS/P47qVreJcvE8+TELuAywyNCsVuXGW50676ZdEz
        crVhWh31KFy9vFg+qFj1+h3T+pwR
X-Google-Smtp-Source: ABdhPJyfrKyIW4Ay9cFZa2KgcBfxuws0CShp7xquZQyzdBewvUZ9RM3N+0JxYfgJJ1hYX48lTUq5HQ==
X-Received: by 2002:a1c:e088:: with SMTP id x130mr43185857wmg.14.1593954772160;
        Sun, 05 Jul 2020 06:12:52 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id 26sm19401809wmj.25.2020.07.05.06.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 06:12:51 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 5/9] habanalabs: Extract ECC information from FW
Date:   Sun,  5 Jul 2020 16:12:41 +0300
Message-Id: <20200705131245.9368-5-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200705131245.9368-1-oded.gabbay@gmail.com>
References: <20200705131245.9368-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ECC (Error Correcting Code) interrupts are going to be handled
by the FW. Hence, we define an interface in which the driver can
obtain the relevant ECC information.
This information is needed for monitoring and can also lead
to a hard reset if ECC error is not correctable.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c         | 366 ++++++------------
 drivers/misc/habanalabs/include/armcp_if.h    |  12 +-
 .../include/gaudi/asic_reg/gaudi_regs.h       |  19 +-
 3 files changed, 146 insertions(+), 251 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index aa4139626a04..888f42adee6a 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -316,6 +316,13 @@ static enum hl_queue_type gaudi_queue_type[GAUDI_QUEUE_ID_SIZE] = {
 	QUEUE_TYPE_NA,  /* GAUDI_QUEUE_ID_NIC_9_3 */
 };
 
+struct ecc_info_extract_params {
+	u64 block_address;
+	u32 num_memories;
+	bool derr;
+	bool disable_clock_gating;
+};
+
 static int gaudi_mmu_update_asid_hop0_addr(struct hl_device *hdev, u32 asid,
 								u64 phys_addr);
 static int gaudi_send_job_on_qman0(struct hl_device *hdev,
@@ -5117,62 +5124,75 @@ static void gaudi_print_mmu_error_info(struct hl_device *hdev)
  *  |                   |0xF4C memory wrappers 127:96                          |
  *  +-------------------+------------------------------------------------------+
  */
-static void gaudi_print_ecc_info_generic(struct hl_device *hdev,
-					const char *block_name,
-					u64 block_address, int num_memories,
-					bool derr, bool disable_clock_gating)
+static int gaudi_extract_ecc_info(struct hl_device *hdev,
+		struct ecc_info_extract_params *params, u64 *ecc_address,
+		u64 *ecc_syndrom, u8 *memory_wrapper_idx)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
-	int num_mem_regs = num_memories / 32 + ((num_memories % 32) ? 1 : 0);
+	u32 i, num_mem_regs, reg, err_bit;
+	u64 err_addr, err_word = 0;
+	int rc = 0;
 
-	if (block_address >= CFG_BASE)
-		block_address -= CFG_BASE;
+	num_mem_regs = params->num_memories / 32 +
+			((params->num_memories % 32) ? 1 : 0);
 
-	if (derr)
-		block_address += GAUDI_ECC_DERR0_OFFSET;
+	if (params->block_address >= CFG_BASE)
+		params->block_address -= CFG_BASE;
+
+	if (params->derr)
+		err_addr = params->block_address + GAUDI_ECC_DERR0_OFFSET;
 	else
-		block_address += GAUDI_ECC_SERR0_OFFSET;
+		err_addr = params->block_address + GAUDI_ECC_SERR0_OFFSET;
 
-	if (disable_clock_gating) {
+	if (params->disable_clock_gating) {
 		mutex_lock(&gaudi->clk_gate_mutex);
 		hdev->asic_funcs->disable_clock_gating(hdev);
 	}
 
-	switch (num_mem_regs) {
-	case 1:
-		dev_err(hdev->dev,
-			"%s ECC indication: 0x%08x\n",
-			block_name, RREG32(block_address));
-		break;
-	case 2:
-		dev_err(hdev->dev,
-			"%s ECC indication: 0x%08x 0x%08x\n",
-			block_name,
-			RREG32(block_address), RREG32(block_address + 4));
-		break;
-	case 3:
-		dev_err(hdev->dev,
-			"%s ECC indication: 0x%08x 0x%08x 0x%08x\n",
-			block_name,
-			RREG32(block_address), RREG32(block_address + 4),
-			RREG32(block_address + 8));
-		break;
-	case 4:
-		dev_err(hdev->dev,
-			"%s ECC indication: 0x%08x 0x%08x 0x%08x 0x%08x\n",
-			block_name,
-			RREG32(block_address), RREG32(block_address + 4),
-			RREG32(block_address + 8), RREG32(block_address + 0xc));
-		break;
-	default:
-		break;
+	/* Set invalid wrapper index */
+	*memory_wrapper_idx = 0xFF;
+
+	/* Iterate through memory wrappers, a single bit must be set */
+	for (i = 0 ; i > num_mem_regs ; i++) {
+		err_addr += i * 4;
+		err_word = RREG32(err_addr);
+		if (err_word) {
+			err_bit = __ffs(err_word);
+			*memory_wrapper_idx = err_bit + (32 * i);
+			break;
+		}
+	}
 
+	if (*memory_wrapper_idx == 0xFF) {
+		dev_err(hdev->dev, "ECC error information cannot be found\n");
+		rc = -EINVAL;
+		goto enable_clk_gate;
 	}
 
-	if (disable_clock_gating) {
+	WREG32(params->block_address + GAUDI_ECC_MEM_SEL_OFFSET,
+			*memory_wrapper_idx);
+
+	*ecc_address =
+		RREG32(params->block_address + GAUDI_ECC_ADDRESS_OFFSET);
+	*ecc_syndrom =
+		RREG32(params->block_address + GAUDI_ECC_SYNDROME_OFFSET);
+
+	/* Clear error indication */
+	reg = RREG32(params->block_address + GAUDI_ECC_MEM_INFO_CLR_OFFSET);
+	if (params->derr)
+		reg |= FIELD_PREP(GAUDI_ECC_MEM_INFO_CLR_DERR_MASK, 1);
+	else
+		reg |= FIELD_PREP(GAUDI_ECC_MEM_INFO_CLR_SERR_MASK, 1);
+
+	WREG32(params->block_address + GAUDI_ECC_MEM_INFO_CLR_OFFSET, reg);
+
+enable_clk_gate:
+	if (params->disable_clock_gating) {
 		hdev->asic_funcs->enable_clock_gating(hdev);
 		mutex_unlock(&gaudi->clk_gate_mutex);
 	}
+
+	return rc;
 }
 
 static void gaudi_handle_qman_err_generic(struct hl_device *hdev,
@@ -5225,239 +5245,99 @@ static void gaudi_handle_qman_err_generic(struct hl_device *hdev,
 	}
 }
 
-static void gaudi_print_ecc_info(struct hl_device *hdev, u16 event_type)
+static void gaudi_handle_ecc_event(struct hl_device *hdev, u16 event_type,
+		struct hl_eq_ecc_data *ecc_data)
 {
-	u64 block_address;
-	u8 index;
-	int num_memories;
-	char desc[32];
-	bool derr;
-	bool disable_clock_gating;
+	struct ecc_info_extract_params params;
+	u64 ecc_address = 0, ecc_syndrom = 0;
+	u8 index, memory_wrapper_idx = 0;
+	bool extract_info_from_fw;
+	int rc;
 
 	switch (event_type) {
-	case GAUDI_EVENT_PCIE_CORE_SERR:
-		snprintf(desc, ARRAY_SIZE(desc), "%s", "PCIE_CORE");
-		block_address = mmPCIE_CORE_BASE;
-		num_memories = 51;
-		derr = false;
-		disable_clock_gating = false;
-		break;
-	case GAUDI_EVENT_PCIE_CORE_DERR:
-		snprintf(desc, ARRAY_SIZE(desc), "%s", "PCIE_CORE");
-		block_address = mmPCIE_CORE_BASE;
-		num_memories = 51;
-		derr = true;
-		disable_clock_gating = false;
-		break;
-	case GAUDI_EVENT_PCIE_IF_SERR:
-		snprintf(desc, ARRAY_SIZE(desc), "%s", "PCIE_WRAP");
-		block_address = mmPCIE_WRAP_BASE;
-		num_memories = 11;
-		derr = false;
-		disable_clock_gating = false;
-		break;
-	case GAUDI_EVENT_PCIE_IF_DERR:
-		snprintf(desc, ARRAY_SIZE(desc), "%s", "PCIE_WRAP");
-		block_address = mmPCIE_WRAP_BASE;
-		num_memories = 11;
-		derr = true;
-		disable_clock_gating = false;
-		break;
-	case GAUDI_EVENT_PCIE_PHY_SERR:
-		snprintf(desc, ARRAY_SIZE(desc), "%s", "PCIE_PHY");
-		block_address = mmPCIE_PHY_BASE;
-		num_memories = 4;
-		derr = false;
-		disable_clock_gating = false;
-		break;
-	case GAUDI_EVENT_PCIE_PHY_DERR:
-		snprintf(desc, ARRAY_SIZE(desc), "%s", "PCIE_PHY");
-		block_address = mmPCIE_PHY_BASE;
-		num_memories = 4;
-		derr = true;
-		disable_clock_gating = false;
+	case GAUDI_EVENT_PCIE_CORE_SERR ... GAUDI_EVENT_PCIE_PHY_DERR:
+	case GAUDI_EVENT_DMA0_SERR_ECC ... GAUDI_EVENT_MMU_DERR:
+		extract_info_from_fw = true;
 		break;
 	case GAUDI_EVENT_TPC0_SERR ... GAUDI_EVENT_TPC7_SERR:
 		index = event_type - GAUDI_EVENT_TPC0_SERR;
-		block_address = mmTPC0_CFG_BASE + index * TPC_CFG_OFFSET;
-		snprintf(desc, ARRAY_SIZE(desc), "%s%d", "TPC", index);
-		num_memories = 90;
-		derr = false;
-		disable_clock_gating = true;
+		params.block_address = mmTPC0_CFG_BASE + index * TPC_CFG_OFFSET;
+		params.num_memories = 90;
+		params.derr = false;
+		params.disable_clock_gating = true;
+		extract_info_from_fw = false;
 		break;
 	case GAUDI_EVENT_TPC0_DERR ... GAUDI_EVENT_TPC7_DERR:
 		index = event_type - GAUDI_EVENT_TPC0_DERR;
-		block_address =
+		params.block_address =
 			mmTPC0_CFG_BASE + index * TPC_CFG_OFFSET;
-		snprintf(desc, ARRAY_SIZE(desc), "%s%d", "TPC", index);
-		num_memories = 90;
-		derr = true;
-		disable_clock_gating = true;
+		params.num_memories = 90;
+		params.derr = true;
+		params.disable_clock_gating = true;
+		extract_info_from_fw = false;
 		break;
 	case GAUDI_EVENT_MME0_ACC_SERR:
 	case GAUDI_EVENT_MME1_ACC_SERR:
 	case GAUDI_EVENT_MME2_ACC_SERR:
 	case GAUDI_EVENT_MME3_ACC_SERR:
 		index = (event_type - GAUDI_EVENT_MME0_ACC_SERR) / 4;
-		block_address = mmMME0_ACC_BASE + index * MME_ACC_OFFSET;
-		snprintf(desc, ARRAY_SIZE(desc), "MME%d_ACC", index);
-		num_memories = 128;
-		derr = false;
-		disable_clock_gating = true;
+		params.block_address = mmMME0_ACC_BASE + index * MME_ACC_OFFSET;
+		params.num_memories = 128;
+		params.derr = false;
+		params.disable_clock_gating = true;
+		extract_info_from_fw = false;
 		break;
 	case GAUDI_EVENT_MME0_ACC_DERR:
 	case GAUDI_EVENT_MME1_ACC_DERR:
 	case GAUDI_EVENT_MME2_ACC_DERR:
 	case GAUDI_EVENT_MME3_ACC_DERR:
 		index = (event_type - GAUDI_EVENT_MME0_ACC_DERR) / 4;
-		block_address = mmMME0_ACC_BASE + index * MME_ACC_OFFSET;
-		snprintf(desc, ARRAY_SIZE(desc), "MME%d_ACC", index);
-		num_memories = 128;
-		derr = true;
-		disable_clock_gating = true;
+		params.block_address = mmMME0_ACC_BASE + index * MME_ACC_OFFSET;
+		params.num_memories = 128;
+		params.derr = true;
+		params.disable_clock_gating = true;
+		extract_info_from_fw = false;
 		break;
 	case GAUDI_EVENT_MME0_SBAB_SERR:
 	case GAUDI_EVENT_MME1_SBAB_SERR:
 	case GAUDI_EVENT_MME2_SBAB_SERR:
 	case GAUDI_EVENT_MME3_SBAB_SERR:
 		index = (event_type - GAUDI_EVENT_MME0_SBAB_SERR) / 4;
-		block_address = mmMME0_SBAB_BASE + index * MME_ACC_OFFSET;
-		snprintf(desc, ARRAY_SIZE(desc), "MME%d_SBAB", index);
-		num_memories = 33;
-		derr = false;
-		disable_clock_gating = true;
+		params.block_address =
+			mmMME0_SBAB_BASE + index * MME_ACC_OFFSET;
+		params.num_memories = 33;
+		params.derr = false;
+		params.disable_clock_gating = true;
+		extract_info_from_fw = false;
 		break;
 	case GAUDI_EVENT_MME0_SBAB_DERR:
 	case GAUDI_EVENT_MME1_SBAB_DERR:
 	case GAUDI_EVENT_MME2_SBAB_DERR:
 	case GAUDI_EVENT_MME3_SBAB_DERR:
 		index = (event_type - GAUDI_EVENT_MME0_SBAB_DERR) / 4;
-		block_address = mmMME0_SBAB_BASE + index * MME_ACC_OFFSET;
-		snprintf(desc, ARRAY_SIZE(desc), "MME%d_SBAB", index);
-		num_memories = 33;
-		derr = true;
-		disable_clock_gating = true;
-		break;
-	case GAUDI_EVENT_DMA0_SERR_ECC ... GAUDI_EVENT_DMA7_SERR_ECC:
-		index = event_type - GAUDI_EVENT_DMA0_SERR_ECC;
-		block_address = mmDMA0_CORE_BASE + index * DMA_CORE_OFFSET;
-		snprintf(desc, ARRAY_SIZE(desc), "DMA%d_CORE", index);
-		num_memories = 16;
-		derr = false;
-		disable_clock_gating = false;
-		break;
-	case GAUDI_EVENT_DMA0_DERR_ECC ... GAUDI_EVENT_DMA7_DERR_ECC:
-		index = event_type - GAUDI_EVENT_DMA0_DERR_ECC;
-		block_address = mmDMA0_CORE_BASE + index * DMA_CORE_OFFSET;
-		snprintf(desc, ARRAY_SIZE(desc), "DMA%d_CORE", index);
-		num_memories = 16;
-		derr = true;
-		disable_clock_gating = false;
-		break;
-	case GAUDI_EVENT_CPU_IF_ECC_SERR:
-		block_address = mmCPU_IF_BASE;
-		snprintf(desc, ARRAY_SIZE(desc), "%s", "CPU");
-		num_memories = 4;
-		derr = false;
-		disable_clock_gating = false;
-		break;
-	case GAUDI_EVENT_CPU_IF_ECC_DERR:
-		block_address = mmCPU_IF_BASE;
-		snprintf(desc, ARRAY_SIZE(desc), "%s", "CPU");
-		num_memories = 4;
-		derr = true;
-		disable_clock_gating = false;
-		break;
-	case GAUDI_EVENT_PSOC_MEM_SERR:
-		block_address = mmPSOC_GLOBAL_CONF_BASE;
-		snprintf(desc, ARRAY_SIZE(desc), "%s", "CPU");
-		num_memories = 4;
-		derr = false;
-		disable_clock_gating = false;
-		break;
-	case GAUDI_EVENT_PSOC_MEM_DERR:
-		block_address = mmPSOC_GLOBAL_CONF_BASE;
-		snprintf(desc, ARRAY_SIZE(desc), "%s", "CPU");
-		num_memories = 4;
-		derr = true;
-		disable_clock_gating = false;
-		break;
-	case GAUDI_EVENT_PSOC_CORESIGHT_SERR:
-		block_address = mmPSOC_CS_TRACE_BASE;
-		snprintf(desc, ARRAY_SIZE(desc), "%s", "CPU");
-		num_memories = 2;
-		derr = false;
-		disable_clock_gating = false;
-		break;
-	case GAUDI_EVENT_PSOC_CORESIGHT_DERR:
-		block_address = mmPSOC_CS_TRACE_BASE;
-		snprintf(desc, ARRAY_SIZE(desc), "%s", "CPU");
-		num_memories = 2;
-		derr = true;
-		disable_clock_gating = false;
-		break;
-	case GAUDI_EVENT_SRAM0_SERR ... GAUDI_EVENT_SRAM28_SERR:
-		index = event_type - GAUDI_EVENT_SRAM0_SERR;
-		block_address =
-			mmSRAM_Y0_X0_BANK_BASE + index * SRAM_BANK_OFFSET;
-		snprintf(desc, ARRAY_SIZE(desc), "SRAM%d", index);
-		num_memories = 2;
-		derr = false;
-		disable_clock_gating = false;
-		break;
-	case GAUDI_EVENT_SRAM0_DERR ... GAUDI_EVENT_SRAM28_DERR:
-		index = event_type - GAUDI_EVENT_SRAM0_DERR;
-		block_address =
-			mmSRAM_Y0_X0_BANK_BASE + index * SRAM_BANK_OFFSET;
-		snprintf(desc, ARRAY_SIZE(desc), "SRAM%d", index);
-		num_memories = 2;
-		derr = true;
-		disable_clock_gating = false;
-		break;
-	case GAUDI_EVENT_DMA_IF0_SERR ... GAUDI_EVENT_DMA_IF3_SERR:
-		index = event_type - GAUDI_EVENT_DMA_IF0_SERR;
-		block_address = mmDMA_IF_W_S_BASE +
-				index * (mmDMA_IF_E_S_BASE - mmDMA_IF_W_S_BASE);
-		snprintf(desc, ARRAY_SIZE(desc), "DMA_IF%d", index);
-		num_memories = 60;
-		derr = false;
-		disable_clock_gating = false;
-		break;
-	case GAUDI_EVENT_DMA_IF0_DERR ... GAUDI_EVENT_DMA_IF3_DERR:
-		index = event_type - GAUDI_EVENT_DMA_IF0_DERR;
-		block_address = mmDMA_IF_W_S_BASE +
-				index * (mmDMA_IF_E_S_BASE - mmDMA_IF_W_S_BASE);
-		snprintf(desc, ARRAY_SIZE(desc), "DMA_IF%d", index);
-		derr = true;
-		num_memories = 60;
-		disable_clock_gating = false;
-		break;
-	case GAUDI_EVENT_HBM_0_SERR ... GAUDI_EVENT_HBM_3_SERR:
-		index = event_type - GAUDI_EVENT_HBM_0_SERR;
-		/* HBM Registers are at different offsets */
-		block_address = mmHBM0_BASE + 0x8000 +
-				index * (mmHBM1_BASE - mmHBM0_BASE);
-		snprintf(desc, ARRAY_SIZE(desc), "HBM%d", index);
-		derr = false;
-		num_memories = 64;
-		disable_clock_gating = false;
-		break;
-	case GAUDI_EVENT_HBM_0_DERR ... GAUDI_EVENT_HBM_3_DERR:
-		index = event_type - GAUDI_EVENT_HBM_0_SERR;
-		/* HBM Registers are at different offsets */
-		block_address = mmHBM0_BASE + 0x8000 +
-				index * (mmHBM1_BASE - mmHBM0_BASE);
-		snprintf(desc, ARRAY_SIZE(desc), "HBM%d", index);
-		derr = true;
-		num_memories = 64;
-		disable_clock_gating = false;
-		break;
+		params.block_address =
+			mmMME0_SBAB_BASE + index * MME_ACC_OFFSET;
+		params.num_memories = 33;
+		params.derr = true;
+		params.disable_clock_gating = true;
 	default:
 		return;
 	}
 
-	gaudi_print_ecc_info_generic(hdev, desc, block_address, num_memories,
-					derr, disable_clock_gating);
+	if (extract_info_from_fw) {
+		ecc_address = le64_to_cpu(ecc_data->ecc_address);
+		ecc_syndrom = le64_to_cpu(ecc_data->ecc_syndrom);
+		memory_wrapper_idx = ecc_data->memory_wrapper_idx;
+	} else {
+		rc = gaudi_extract_ecc_info(hdev, &params, &ecc_address,
+				&ecc_syndrom, &memory_wrapper_idx);
+		if (rc)
+			return;
+	}
+
+	dev_err(hdev->dev,
+		"ECC error detected. address: %#llx. Syndrom: %#llx. block id %u\n",
+		ecc_address, ecc_syndrom, memory_wrapper_idx);
 }
 
 static void gaudi_handle_qman_err(struct hl_device *hdev, u16 event_type)
@@ -5507,8 +5387,6 @@ static void gaudi_print_irq_info(struct hl_device *hdev, u16 event_type,
 	dev_err_ratelimited(hdev->dev, "Received H/W interrupt %d [\"%s\"]\n",
 		event_type, desc);
 
-	gaudi_print_ecc_info(hdev, event_type);
-
 	if (razwi) {
 		gaudi_print_razwi_info(hdev);
 		gaudi_print_mmu_error_info(hdev);
@@ -5738,10 +5616,15 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	case GAUDI_EVENT_PSOC_CORESIGHT_DERR:
 	case GAUDI_EVENT_SRAM0_DERR ... GAUDI_EVENT_SRAM28_DERR:
 	case GAUDI_EVENT_DMA_IF0_DERR ... GAUDI_EVENT_DMA_IF3_DERR:
-		fallthrough;
-	case GAUDI_EVENT_GIC500:
 	case GAUDI_EVENT_HBM_0_DERR ... GAUDI_EVENT_HBM_3_DERR:
 	case GAUDI_EVENT_MMU_DERR:
+		gaudi_print_irq_info(hdev, event_type, true);
+		gaudi_handle_ecc_event(hdev, event_type, &eq_entry->ecc_data);
+		if (hdev->hard_reset_on_fw_events)
+			hl_device_reset(hdev, true, false);
+		break;
+
+	case GAUDI_EVENT_GIC500:
 	case GAUDI_EVENT_AXI_ECC:
 	case GAUDI_EVENT_L2_RAM_ECC:
 	case GAUDI_EVENT_PLL0 ... GAUDI_EVENT_PLL17:
@@ -5837,6 +5720,11 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	case GAUDI_EVENT_HBM_0_SERR ... GAUDI_EVENT_HBM_3_SERR:
 		fallthrough;
 	case GAUDI_EVENT_MMU_SERR:
+		gaudi_print_irq_info(hdev, event_type, true);
+		gaudi_handle_ecc_event(hdev, event_type, &eq_entry->ecc_data);
+		hl_fw_unmask_irq(hdev, event_type);
+		break;
+
 	case GAUDI_EVENT_PCIE_DEC:
 	case GAUDI_EVENT_MME0_WBC_RSP:
 	case GAUDI_EVENT_MME0_SBAB0_RSP:
diff --git a/drivers/misc/habanalabs/include/armcp_if.h b/drivers/misc/habanalabs/include/armcp_if.h
index dea7c90faafa..07f9972db28d 100644
--- a/drivers/misc/habanalabs/include/armcp_if.h
+++ b/drivers/misc/habanalabs/include/armcp_if.h
@@ -19,9 +19,19 @@ struct hl_eq_header {
 	__le32 ctl;
 };
 
+struct hl_eq_ecc_data {
+	__le64 ecc_address;
+	__le64 ecc_syndrom;
+	__u8 memory_wrapper_idx;
+	__u8 pad[7];
+};
+
 struct hl_eq_entry {
 	struct hl_eq_header hdr;
-	__le64 data[7];
+	union {
+		struct hl_eq_ecc_data ecc_data;
+		__le64 data[7];
+	};
 };
 
 #define HL_EQ_ENTRY_SIZE		sizeof(struct hl_eq_entry)
diff --git a/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h b/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
index 62078077aee5..0c75d43532bd 100644
--- a/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
+++ b/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
@@ -93,17 +93,14 @@
 #include "psoc_hbm_pll_regs.h"
 #include "psoc_cpu_pll_regs.h"
 
-#define GAUDI_ECC_MEM_SEL_OFFSET	0xF18
-#define GAUDI_ECC_ADDRESS_OFFSET	0xF1C
-#define GAUDI_ECC_SYNDROME_OFFSET	0xF20
-#define GAUDI_ECC_SERR0_OFFSET		0xF30
-#define GAUDI_ECC_SERR1_OFFSET		0xF34
-#define GAUDI_ECC_SERR2_OFFSET		0xF38
-#define GAUDI_ECC_SERR3_OFFSET		0xF3C
-#define GAUDI_ECC_DERR0_OFFSET		0xF40
-#define GAUDI_ECC_DERR1_OFFSET		0xF44
-#define GAUDI_ECC_DERR2_OFFSET		0xF48
-#define GAUDI_ECC_DERR3_OFFSET		0xF4C
+#define GAUDI_ECC_MEM_SEL_OFFSET		0xF18
+#define GAUDI_ECC_ADDRESS_OFFSET		0xF1C
+#define GAUDI_ECC_SYNDROME_OFFSET		0xF20
+#define GAUDI_ECC_MEM_INFO_CLR_OFFSET		0xF28
+#define GAUDI_ECC_MEM_INFO_CLR_SERR_MASK	BIT(8)
+#define GAUDI_ECC_MEM_INFO_CLR_DERR_MASK	BIT(9)
+#define GAUDI_ECC_SERR0_OFFSET			0xF30
+#define GAUDI_ECC_DERR0_OFFSET			0xF40
 
 #define mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_SOB_OBJ_0                     0x492000
 #define mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0               0x494000
-- 
2.17.1

