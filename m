Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9533FC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 585332078B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599593270;
	bh=2S3ivuzEZGfnY77yUs2AAU8aYTRtxOGZowmybDPmTt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TGaTHbCkvLXRJfXpkGRnCtRXtXikGmfXv1in8X6d3pwGwm7ueWy6bfPgHtZA6DWDW
	 Ul15BcL4J7S4vXQkbJKt8gOf1aqvHdyQBmEMJDaa8YRrb3+2B/OdkFsKTDvOHANfJh
	 FoUzmn7PldlmgwKZkDMCnKyFbZHDBcWPf1J1/NY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732195AbgIHT1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731064AbgIHQAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:00:04 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51F5E22B2A;
        Tue,  8 Sep 2020 15:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579348;
        bh=2S3ivuzEZGfnY77yUs2AAU8aYTRtxOGZowmybDPmTt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Om2Tj7dATFSAPmiEOtz4FCN6rH38bRSo2ueD9vlGsWt04xtr7vxWgHT0O79g17Q6c
         R3Uq/v7PTgpusdPMWvaVa7xF8exTr/j7z3haXa5JGwV3dR643hkdYIY63Wv6PIsB71
         inR0//sZmTJxgQepUy5SdwJxmPYyXDKXjsVm1/Xw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ofir Bitton <obitton@habana.ai>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 013/186] habanalabs: set clock gating according to mask
Date:   Tue,  8 Sep 2020 17:22:35 +0200
Message-Id: <20200908152242.296583945@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

[ Upstream commit f44d23b9095abd91dad9f5f3add2a3149833ec83 ]

Once clock gating is set we enable clock gating according to mask,
we should also disable clock gating according to relevant bits.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 44 +++++++++++++--------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 0261f60df5633..8b6cf722ddf8e 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -2564,6 +2564,7 @@ static void gaudi_set_clock_gating(struct hl_device *hdev)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
 	u32 qman_offset;
+	bool enable;
 	int i;
 
 	/* In case we are during debug session, don't enable the clock gate
@@ -2573,46 +2574,43 @@ static void gaudi_set_clock_gating(struct hl_device *hdev)
 		return;
 
 	for (i = GAUDI_PCI_DMA_1, qman_offset = 0 ; i < GAUDI_HBM_DMA_1 ; i++) {
-		if (!(hdev->clock_gating_mask &
-					(BIT_ULL(gaudi_dma_assignment[i]))))
-			continue;
+		enable = !!(hdev->clock_gating_mask &
+				(BIT_ULL(gaudi_dma_assignment[i])));
 
 		qman_offset = gaudi_dma_assignment[i] * DMA_QMAN_OFFSET;
-		WREG32(mmDMA0_QM_CGM_CFG1 + qman_offset, QMAN_CGM1_PWR_GATE_EN);
+		WREG32(mmDMA0_QM_CGM_CFG1 + qman_offset,
+				enable ? QMAN_CGM1_PWR_GATE_EN : 0);
 		WREG32(mmDMA0_QM_CGM_CFG + qman_offset,
-				QMAN_UPPER_CP_CGM_PWR_GATE_EN);
+				enable ? QMAN_UPPER_CP_CGM_PWR_GATE_EN : 0);
 	}
 
 	for (i = GAUDI_HBM_DMA_1 ; i < GAUDI_DMA_MAX ; i++) {
-		if (!(hdev->clock_gating_mask &
-					(BIT_ULL(gaudi_dma_assignment[i]))))
-			continue;
+		enable = !!(hdev->clock_gating_mask &
+				(BIT_ULL(gaudi_dma_assignment[i])));
 
 		qman_offset = gaudi_dma_assignment[i] * DMA_QMAN_OFFSET;
-		WREG32(mmDMA0_QM_CGM_CFG1 + qman_offset, QMAN_CGM1_PWR_GATE_EN);
+		WREG32(mmDMA0_QM_CGM_CFG1 + qman_offset,
+				enable ? QMAN_CGM1_PWR_GATE_EN : 0);
 		WREG32(mmDMA0_QM_CGM_CFG + qman_offset,
-				QMAN_COMMON_CP_CGM_PWR_GATE_EN);
+				enable ? QMAN_COMMON_CP_CGM_PWR_GATE_EN : 0);
 	}
 
-	if (hdev->clock_gating_mask & (BIT_ULL(GAUDI_ENGINE_ID_MME_0))) {
-		WREG32(mmMME0_QM_CGM_CFG1, QMAN_CGM1_PWR_GATE_EN);
-		WREG32(mmMME0_QM_CGM_CFG, QMAN_COMMON_CP_CGM_PWR_GATE_EN);
-	}
+	enable = !!(hdev->clock_gating_mask & (BIT_ULL(GAUDI_ENGINE_ID_MME_0)));
+	WREG32(mmMME0_QM_CGM_CFG1, enable ? QMAN_CGM1_PWR_GATE_EN : 0);
+	WREG32(mmMME0_QM_CGM_CFG, enable ? QMAN_COMMON_CP_CGM_PWR_GATE_EN : 0);
 
-	if (hdev->clock_gating_mask & (BIT_ULL(GAUDI_ENGINE_ID_MME_2))) {
-		WREG32(mmMME2_QM_CGM_CFG1, QMAN_CGM1_PWR_GATE_EN);
-		WREG32(mmMME2_QM_CGM_CFG, QMAN_COMMON_CP_CGM_PWR_GATE_EN);
-	}
+	enable = !!(hdev->clock_gating_mask & (BIT_ULL(GAUDI_ENGINE_ID_MME_2)));
+	WREG32(mmMME2_QM_CGM_CFG1, enable ? QMAN_CGM1_PWR_GATE_EN : 0);
+	WREG32(mmMME2_QM_CGM_CFG, enable ? QMAN_COMMON_CP_CGM_PWR_GATE_EN : 0);
 
 	for (i = 0, qman_offset = 0 ; i < TPC_NUMBER_OF_ENGINES ; i++) {
-		if (!(hdev->clock_gating_mask &
-					(BIT_ULL(GAUDI_ENGINE_ID_TPC_0 + i))))
-			continue;
+		enable = !!(hdev->clock_gating_mask &
+				(BIT_ULL(GAUDI_ENGINE_ID_TPC_0 + i)));
 
 		WREG32(mmTPC0_QM_CGM_CFG1 + qman_offset,
-				QMAN_CGM1_PWR_GATE_EN);
+				enable ? QMAN_CGM1_PWR_GATE_EN : 0);
 		WREG32(mmTPC0_QM_CGM_CFG + qman_offset,
-				QMAN_COMMON_CP_CGM_PWR_GATE_EN);
+				enable ? QMAN_COMMON_CP_CGM_PWR_GATE_EN : 0);
 
 		qman_offset += TPC_QMAN_OFFSET;
 	}
-- 
2.25.1



