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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1511C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B96D92074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3PA5nmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgFPGNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgFPGNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:13:35 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E59C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:13:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id p5so19383020wrw.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OyojEj1EmfCUdaz4s7DeoXx+cQ/+q0SxYxTCw3S324g=;
        b=c3PA5nmNMyc3gXzLAAKfereIoiN6lO/yKOc/5eh7JGw59dTxCDaIhxloJRwjEsH1tT
         OTBtViCRP4Qf/Km0Rp5EwR/PRh4271i0bFv/v6AIGnLjLWuV//mWs1xW5qj2zZeb4+tJ
         qlgnzpp8nbJJbnFdLXKSmq+WpKaWsDpelhROTrhVzDEpP90hQ0dxiOL2wnEZ6TvZUUPn
         wjo3Ghh9Ffw94YNNLHvgX0Etj4/FYB1Y5RwZFPo3e5z0dRui9ZhlmsRJLsOW4DJdcsrK
         vofL15nZL0pagloXQpQW8HD9a/EilUFaVUIf61NeChuHjTLX8A6Uky6S9gHiPCG1+y+Q
         82RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OyojEj1EmfCUdaz4s7DeoXx+cQ/+q0SxYxTCw3S324g=;
        b=t5lkaMdq2l8Bs1fKtDnPmluB8N0s1fWMCU2IcYIhvMrUBUwCQgf7yDjMcAs2Qz3qOi
         FjTbS7KTp9FTPrpXh0nOJXQrYXnbMaeZgX8rC5uMp0tvc/QDGc9pWP/iToe8xspmnpUf
         Yxyvv1EKNP9Z/4fWi3lPoKWVVuGwCaIie4D81Hmm87YW2aEG9KjxU44cWR23IChksBk7
         cRG1A2KOmbelWtoElLpR0cblUQL07kA/FZKVl3ZsR/29jpFPocvNNii57dE4CDNDIS3C
         ASgDZgQnOYcT0T6UKjgX7lUQ85p08ivHmbJHvy8+0A3hwK57c/1+uBL5rdnb6+KTk4tB
         GPgw==
X-Gm-Message-State: AOAM5303rH64EycCrr0bdXjC35WWThpryHkeXxHls5wd00srlB0USeUz
        cKmk17knQXrhOKGGfjUCxX2P3vache0=
X-Google-Smtp-Source: ABdhPJz9dC1C9N1yEDc3aoaGGp5Rt+y0IOf3qqeP6DI0FluaP4fQI4Fz2+0qm0eZmRuXbV+ofDtIJQ==
X-Received: by 2002:adf:f68d:: with SMTP id v13mr1154370wrp.291.1592288011795;
        Mon, 15 Jun 2020 23:13:31 -0700 (PDT)
Received: from ODED-MAIN.localdomain ([87.71.142.251])
        by smtp.gmail.com with ESMTPSA id s2sm2354963wmh.15.2020.06.15.23.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 23:13:30 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 1/7] habanalabs: remove rate limiters from GAUDI
Date:   Tue, 16 Jun 2020 09:13:21 +0300
Message-Id: <20200616061327.12006-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We no longer need to initialize the rate limiters in GAUDI A1.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c    | 126 +----------------------
 drivers/misc/habanalabs/habanalabs_drv.c |   1 -
 2 files changed, 1 insertion(+), 126 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 61f88e9884ce..4d69727bb53b 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1638,8 +1638,8 @@ static void gaudi_init_hbm_cred(struct hl_device *hdev)
 	uint32_t hbm0_wr, hbm1_wr, hbm0_rd, hbm1_rd;
 
 	hbm0_wr = 0x33333333;
-	hbm1_wr = 0x33333333;
 	hbm0_rd = 0x77777777;
+	hbm1_wr = 0x55555555;
 	hbm1_rd = 0xDDDDDDDD;
 
 	WREG32(mmDMA_IF_E_N_HBM0_WR_CRED_CNT, hbm0_wr);
@@ -1689,125 +1689,6 @@ static void gaudi_init_hbm_cred(struct hl_device *hdev)
 			(1 << DMA_IF_HBM_CRED_EN_WRITE_CREDIT_EN_SHIFT));
 }
 
-static void gaudi_init_rate_limiter(struct hl_device *hdev)
-{
-	u32 nr, nf, od, sat, rst, timeout;
-	u64 freq;
-
-	nr = RREG32(mmPSOC_HBM_PLL_NR);
-	nf = RREG32(mmPSOC_HBM_PLL_NF);
-	od = RREG32(mmPSOC_HBM_PLL_OD);
-	freq = (50 * (nf + 1)) / ((nr + 1) * (od + 1));
-
-	dev_dbg(hdev->dev, "HBM frequency is %lluMHz\n", freq);
-
-	/* Configuration is for five (5) DDMA channels */
-	if (freq == 800) {
-		sat = 4;
-		rst = 11;
-		timeout = 15;
-	} else if (freq == 900) {
-		sat = 4;
-		rst = 15;
-		timeout = 16;
-	} else if (freq == 950) {
-		sat = 4;
-		rst = 15;
-		timeout = 15;
-	} else {
-		dev_warn(hdev->dev,
-			"unsupported HBM frequency %lluMHz, no rate-limiters\n",
-			freq);
-		return;
-	}
-
-	WREG32(mmDMA_IF_W_S_DOWN_RSP_MID_WGHT_0, 0x111);
-	WREG32(mmDMA_IF_W_S_DOWN_RSP_MID_WGHT_1, 0x111);
-	WREG32(mmDMA_IF_E_S_DOWN_RSP_MID_WGHT_0, 0x111);
-	WREG32(mmDMA_IF_E_S_DOWN_RSP_MID_WGHT_1, 0x111);
-	WREG32(mmDMA_IF_W_N_DOWN_RSP_MID_WGHT_0, 0x111);
-	WREG32(mmDMA_IF_W_N_DOWN_RSP_MID_WGHT_1, 0x111);
-	WREG32(mmDMA_IF_E_N_DOWN_RSP_MID_WGHT_0, 0x111);
-	WREG32(mmDMA_IF_E_N_DOWN_RSP_MID_WGHT_1, 0x111);
-
-	if (!hdev->rl_enable) {
-		dev_info(hdev->dev, "Rate limiters disabled\n");
-		return;
-	}
-
-	WREG32(mmDMA_IF_W_S_DOWN_CH0_RL_HBM_SAT, sat);
-	WREG32(mmDMA_IF_W_S_DOWN_CH1_RL_HBM_SAT, sat);
-	WREG32(mmDMA_IF_E_S_DOWN_CH0_RL_HBM_SAT, sat);
-	WREG32(mmDMA_IF_E_S_DOWN_CH1_RL_HBM_SAT, sat);
-	WREG32(mmDMA_IF_W_N_DOWN_CH0_RL_HBM_SAT, sat);
-	WREG32(mmDMA_IF_W_N_DOWN_CH1_RL_HBM_SAT, sat);
-	WREG32(mmDMA_IF_E_N_DOWN_CH0_RL_HBM_SAT, sat);
-	WREG32(mmDMA_IF_E_N_DOWN_CH1_RL_HBM_SAT, sat);
-
-	WREG32(mmDMA_IF_W_S_DOWN_CH0_RL_HBM_RST, rst);
-	WREG32(mmDMA_IF_W_S_DOWN_CH1_RL_HBM_RST, rst);
-	WREG32(mmDMA_IF_E_S_DOWN_CH0_RL_HBM_RST, rst);
-	WREG32(mmDMA_IF_E_S_DOWN_CH1_RL_HBM_RST, rst);
-	WREG32(mmDMA_IF_W_N_DOWN_CH0_RL_HBM_RST, rst);
-	WREG32(mmDMA_IF_W_N_DOWN_CH1_RL_HBM_RST, rst);
-	WREG32(mmDMA_IF_E_N_DOWN_CH0_RL_HBM_RST, rst);
-	WREG32(mmDMA_IF_E_N_DOWN_CH1_RL_HBM_RST, rst);
-
-	WREG32(mmDMA_IF_W_S_DOWN_CH0_RL_HBM_TIMEOUT, timeout);
-	WREG32(mmDMA_IF_W_S_DOWN_CH1_RL_HBM_TIMEOUT, timeout);
-	WREG32(mmDMA_IF_E_S_DOWN_CH0_RL_HBM_TIMEOUT, timeout);
-	WREG32(mmDMA_IF_E_S_DOWN_CH1_RL_HBM_TIMEOUT, timeout);
-	WREG32(mmDMA_IF_W_N_DOWN_CH0_RL_HBM_TIMEOUT, timeout);
-	WREG32(mmDMA_IF_W_N_DOWN_CH1_RL_HBM_TIMEOUT, timeout);
-	WREG32(mmDMA_IF_E_N_DOWN_CH0_RL_HBM_TIMEOUT, timeout);
-	WREG32(mmDMA_IF_E_N_DOWN_CH1_RL_HBM_TIMEOUT, timeout);
-
-	WREG32(mmDMA_IF_W_S_DOWN_CH0_RL_HBM_EN, 1);
-	WREG32(mmDMA_IF_W_S_DOWN_CH1_RL_HBM_EN, 1);
-	WREG32(mmDMA_IF_E_S_DOWN_CH0_RL_HBM_EN, 1);
-	WREG32(mmDMA_IF_E_S_DOWN_CH1_RL_HBM_EN, 1);
-	WREG32(mmDMA_IF_W_N_DOWN_CH0_RL_HBM_EN, 1);
-	WREG32(mmDMA_IF_W_N_DOWN_CH1_RL_HBM_EN, 1);
-	WREG32(mmDMA_IF_E_N_DOWN_CH0_RL_HBM_EN, 1);
-	WREG32(mmDMA_IF_E_N_DOWN_CH1_RL_HBM_EN, 1);
-
-	WREG32(mmDMA_IF_W_S_DOWN_CH0_RL_SRAM_SAT, sat);
-	WREG32(mmDMA_IF_W_S_DOWN_CH1_RL_SRAM_SAT, sat);
-	WREG32(mmDMA_IF_E_S_DOWN_CH0_RL_SRAM_SAT, sat);
-	WREG32(mmDMA_IF_E_S_DOWN_CH1_RL_SRAM_SAT, sat);
-	WREG32(mmDMA_IF_W_N_DOWN_CH0_RL_SRAM_SAT, sat);
-	WREG32(mmDMA_IF_W_N_DOWN_CH1_RL_SRAM_SAT, sat);
-	WREG32(mmDMA_IF_E_N_DOWN_CH0_RL_SRAM_SAT, sat);
-	WREG32(mmDMA_IF_E_N_DOWN_CH1_RL_SRAM_SAT, sat);
-
-	WREG32(mmDMA_IF_W_S_DOWN_CH0_RL_SRAM_RST, rst);
-	WREG32(mmDMA_IF_W_S_DOWN_CH1_RL_SRAM_RST, rst);
-	WREG32(mmDMA_IF_E_S_DOWN_CH0_RL_SRAM_RST, rst);
-	WREG32(mmDMA_IF_E_S_DOWN_CH1_RL_SRAM_RST, rst);
-	WREG32(mmDMA_IF_W_N_DOWN_CH0_RL_SRAM_RST, rst);
-	WREG32(mmDMA_IF_W_N_DOWN_CH1_RL_SRAM_RST, rst);
-	WREG32(mmDMA_IF_E_N_DOWN_CH0_RL_SRAM_RST, rst);
-	WREG32(mmDMA_IF_E_N_DOWN_CH1_RL_SRAM_RST, rst);
-
-	WREG32(mmDMA_IF_W_S_DOWN_CH0_RL_SRAM_TIMEOUT, timeout);
-	WREG32(mmDMA_IF_W_S_DOWN_CH1_RL_SRAM_TIMEOUT, timeout);
-	WREG32(mmDMA_IF_E_S_DOWN_CH0_RL_SRAM_TIMEOUT, timeout);
-	WREG32(mmDMA_IF_E_S_DOWN_CH1_RL_SRAM_TIMEOUT, timeout);
-	WREG32(mmDMA_IF_W_N_DOWN_CH0_RL_SRAM_TIMEOUT, timeout);
-	WREG32(mmDMA_IF_W_N_DOWN_CH1_RL_SRAM_TIMEOUT, timeout);
-	WREG32(mmDMA_IF_E_N_DOWN_CH0_RL_SRAM_TIMEOUT, timeout);
-	WREG32(mmDMA_IF_E_N_DOWN_CH1_RL_SRAM_TIMEOUT, timeout);
-
-	WREG32(mmDMA_IF_W_S_DOWN_CH0_RL_SRAM_EN, 1);
-	WREG32(mmDMA_IF_W_S_DOWN_CH1_RL_SRAM_EN, 1);
-	WREG32(mmDMA_IF_E_S_DOWN_CH0_RL_SRAM_EN, 1);
-	WREG32(mmDMA_IF_E_S_DOWN_CH1_RL_SRAM_EN, 1);
-	WREG32(mmDMA_IF_W_N_DOWN_CH0_RL_SRAM_EN, 1);
-	WREG32(mmDMA_IF_W_N_DOWN_CH1_RL_SRAM_EN, 1);
-	WREG32(mmDMA_IF_E_N_DOWN_CH0_RL_SRAM_EN, 1);
-	WREG32(mmDMA_IF_E_N_DOWN_CH1_RL_SRAM_EN, 1);
-}
-
 static void gaudi_init_golden_registers(struct hl_device *hdev)
 {
 	u32 tpc_offset;
@@ -1817,8 +1698,6 @@ static void gaudi_init_golden_registers(struct hl_device *hdev)
 
 	gaudi_init_hbm_cred(hdev);
 
-	gaudi_init_rate_limiter(hdev);
-
 	gaudi_disable_clock_gating(hdev);
 
 	for (tpc_id = 0, tpc_offset = 0;
@@ -1839,9 +1718,6 @@ static void gaudi_init_golden_registers(struct hl_device *hdev)
 	WREG32(mmMME1_CTRL_EUS_ROLLUP_CNT_ADD, 3);
 	WREG32(mmMME2_CTRL_EUS_ROLLUP_CNT_ADD, 3);
 	WREG32(mmMME3_CTRL_EUS_ROLLUP_CNT_ADD, 3);
-
-	/* WA for H3-2081 */
-	WREG32(mmPCIE_WRAP_MAX_OUTSTAND, 0x10ff);
 }
 
 static void gaudi_init_pci_dma_qman(struct hl_device *hdev, int dma_id,
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index 8652c7e5d7f1..f38664b03865 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -238,7 +238,6 @@ static void set_driver_behavior_per_device(struct hl_device *hdev)
 	hdev->axi_drain = 0;
 	hdev->sram_scrambler_enable = 1;
 	hdev->dram_scrambler_enable = 1;
-	hdev->rl_enable = 1;
 	hdev->bmc_enable = 1;
 	hdev->hard_reset_on_fw_events = 1;
 }
-- 
2.17.1

