Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BD1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAA1220899
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m66E90HB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389508AbgFXIje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388276AbgFXIjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:39:33 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F073FC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:39:32 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h15so1397878wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kyuzSJ+zSyOew8Gu2fEZImboOCEZH6hUeCFJWJHgt7E=;
        b=m66E90HBKSxS0u5rU8kdHg9Z9vc9ul9wMkD31XW+AxI1WCLoTPh1ysXeRM5tQ+dN//
         Kikmg9HnnpMYfikaUeVlW3jc4UZa2JWROZ7Kbqh7n2txJTyONU3ZXezZsGvavGuILGQB
         4SGOOF4juD9mHCI+wGW8lvu2+sDnOyE4We+qw/F8P6mGiMJyfOeN4kOvpAHrBXYvRVIu
         HKvECidd29eqQeTvd+CuxkRzC/3heT7NRjmoCarKgi6ZaSK4dKUIMMr6cDixNo0mdYdq
         V1UI5uUkEmzSOnVKGkWgQYqo9qET4ShoOfiCH5MyJrPKHxpnVehmTUAkKe2MD+RwLyc4
         RdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kyuzSJ+zSyOew8Gu2fEZImboOCEZH6hUeCFJWJHgt7E=;
        b=oP5HDo4w/C3PMeq8bkvf9kOdR/HAv5bchxR5m1T9dLwyHHDuWKK7X8JRzf5cj009am
         MQ/9QaNAUDtHj3WKtaMhiU5v33Kd7vKOOTkZrW/XuUWs6h8D7lN6n9EkKPM/6Kx56im3
         kePx7uFhdZh+TCm2V10Wvr1a9RhR3xqEx9+2ykVJ3htHkpPoG/ETyrAOqdMt6maPQUEy
         ABnrTCwDUX0tUkxU2axidloE96hYo6oFRLhQo25wLhryoDAge8av8on8AfNAuQHc9cWA
         b7giKZ9IOHM4nCR2mbrJ4U7/qyTTYBPx7zUsnSZIrurV1z7HuUXdl6x2tWQJ95znb5gj
         TRDg==
X-Gm-Message-State: AOAM531RMBHE5b5NQGrnTEvMBg9MW3iIii9gumQtZeRwvbGyBXBMNgKv
        HnBRl85B9f74SeaRxGDBWAOUhbNk
X-Google-Smtp-Source: ABdhPJxxwle8hBJ+V9kED+fnL5hLN5Ng/Yl2wbebhZLTI9Uf6pUoJvGlK7KMgzEuqDm1FDtXVXdenA==
X-Received: by 2002:adf:e901:: with SMTP id f1mr22636685wrm.80.1592987971218;
        Wed, 24 Jun 2020 01:39:31 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id e5sm24486544wrs.33.2020.06.24.01.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 01:39:30 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org, Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH] habanalabs: increase h/w timer when checking idle
Date:   Wed, 24 Jun 2020 12:45:34 +0300
Message-Id: <20200624094534.3549-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

In GAUDI the current timer value for the hardware to check if it is
in IDLE state is too low. As a result, there are occasions where the H/W
wrongly reports it is not IDLE. The driver checks that before submitting
work on behalf of the driver during initialization, so a false report might
cause the driver to fail during device initialization.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 69317d2ebdfa..834470d10b46 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1893,6 +1893,8 @@ static void gaudi_init_pci_dma_qman(struct hl_device *hdev, int dma_id,
 	WREG32(mmDMA0_QM_CP_MSG_BASE3_ADDR_LO_0 + q_off, so_base_ws_lo);
 	WREG32(mmDMA0_QM_CP_MSG_BASE3_ADDR_HI_0 + q_off, so_base_ws_hi);
 
+	WREG32(mmDMA0_QM_CP_BARRIER_CFG_0 + q_off, 0x100);
+
 	/* The following configuration is needed only once per QMAN */
 	if (qman_id == 0) {
 		/* Configure RAZWI IRQ */
-- 
2.17.1

