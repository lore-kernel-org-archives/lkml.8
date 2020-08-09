Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA20C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 11:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ACF0206B5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 11:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ec4dCaBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgHILxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 07:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgHILxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 07:53:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58761C061A27
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 04:53:45 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a15so5624351wrh.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 04:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wg2mx5XLw7YGTacmy7JbLEorCe2+a2jIFmam2/ZLH90=;
        b=Ec4dCaBh06qQZsBwZb9fu4thjBNbwKEu2rgmDDAclcf2RlLMjUjuJQZhHV3X0t/Mox
         M7kr/67wiEUhPJ5CVNYc+LoMnj8Wk901ZcmyLi4hnDeyUj0nwPU9r2MTu63Xih48yctA
         lLZjiD8PjQUlwokFJ/IhYy9AoT+CZDr99detzeHFnNrOy8F0UVzBIgndAqH7lo9CWpS/
         TTA+xvh2cROFBfW+T3y7Tx7Z8qG4fiqkIQh1Tx/t0NHMm0ofYZyigw0/6AFNpXAlWqqy
         bdXPK+zgv8/X6V9kkVWrUNqFe9vLiKpp64gQnTT6+7zm73qUH5ZVFHvpL5m/hXx/4q+N
         BTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wg2mx5XLw7YGTacmy7JbLEorCe2+a2jIFmam2/ZLH90=;
        b=g1Z13/pJnrhbMquj0fW0XWjZY9UOpBw/A3KkjbW9bXX9INHDPJGIB47WDpbah5EZU0
         Yd78r56t1xspD74+SfAYUqsoSltX2ErExhMtspA5FaOUgaCBh3uySLbsg8RViA0fkm35
         o6qohTsF/emA2KDJB81kgtiKtrHsWBsjuznFOR6AjL0XG8gqyq3iLEg+MMmsJB06gO5u
         6bu1BQoxTQxE0cnPUhg7wn2xKo6BbxCaLeTIWRcwuh2CAiVM8Iq9+94UwXpq9k1xoDk9
         h+iYAYinCPsKnXAtmCzJCOBH9HNKh4tc1S447BLu+5SB0+cIBpKItltg0N9Vcm243MtJ
         8O2w==
X-Gm-Message-State: AOAM533Q9aJq/9dSmSR5VXxwWfyGbuAay/lG7iWVz/jy/VOTTwJBwBhg
        0xG6BpSwVtMC/woTiODtOMejlfCQ
X-Google-Smtp-Source: ABdhPJyxGgRBdJUKWzUMku7nVs4ZjPHqQ2ENprHoGGAKhcvt+gHCGDIFZeS5SrCz0IgJgKx5x241xw==
X-Received: by 2002:adf:e902:: with SMTP id f2mr19856678wrm.174.1596974022962;
        Sun, 09 Aug 2020 04:53:42 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id f12sm17376932wmc.46.2020.08.09.04.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 04:53:42 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 2/4] habanalabs: set clock gating according to mask
Date:   Sun,  9 Aug 2020 14:53:35 +0300
Message-Id: <20200809115337.23402-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200809115337.23402-1-oded.gabbay@gmail.com>
References: <20200809115337.23402-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Once clock gating is set we enable clock gating according to mask,
we should also disable clock gating according to relevant bits.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 44 +++++++++++++--------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 08124873483f..7e0f9f64ffcb 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -2508,6 +2508,7 @@ static void gaudi_set_clock_gating(struct hl_device *hdev)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
 	u32 qman_offset;
+	bool enable;
 	int i;
 
 	/* In case we are during debug session, don't enable the clock gate
@@ -2517,46 +2518,43 @@ static void gaudi_set_clock_gating(struct hl_device *hdev)
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
2.17.1

