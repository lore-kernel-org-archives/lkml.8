Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19084C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9633207DF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAvkIgqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgH2K0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 06:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgH2K0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 06:26:04 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACA2C061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 03:26:04 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a17so563923wrn.6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 03:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ltTUbIuRZsrIRmnfDl4oOGfDwCUW3HnUfo8Gx3vlIWk=;
        b=CAvkIgqp4jrvXnLmabDfE4e6P4hkIk818P+wegv/a8jArglH2exYGoVOoWhaKYepez
         TGHFsnmP4dID9ifg0Kw9Yo3Bx5nurIHhXFvWuys79je32yVSZ/82j72Z5NUsf0sC2X4A
         /Tk0Kp8Kx4TRc2Y+999gq2USeiXH7XZQOjSJO0p/825BykEPbMHza74/441FCgyjAfC2
         F/GOc77csiXcxREHu/3ZyPgE6nu1GITuOJaF8U+thfzEr4N2rE0rkepxgc8AWFLJESZH
         imOKUlBIBg/3v+LngFIsosfxvysxExdchdP9SZ8AAUgwd2SGGnlyRwU/8IRIlw+G2njl
         TQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ltTUbIuRZsrIRmnfDl4oOGfDwCUW3HnUfo8Gx3vlIWk=;
        b=oc8X5MlMhqf/dGRQW0Qms/6//Yrob6kidqwFS2/IegY9MPmJ+CALicYweCNcnngpfu
         ZBCZRvB8XvVl35T2bQXS+bHJNJM74cRyho8n6YIk783UWoLhu3mK6YJ3vUkGi2HGseDM
         D/JNIh8AK2QxFlqUIMEMBbxaf92WKRXA+iZ8thTI6wGIGvuId28RnCZ3nvpPvjWnSDH0
         1vyuZwd/kkawoth9HBpffauvNGfwjqa1sJsezlLcdgS7V3GhUDipcYOrQvp5ahIbotQR
         tZdLM5urXUY/ToEa0Em2/7IlffhVlls0c+N2piJXnuVE5aShMigVWKd9QyQhdJ5amlyC
         53jA==
X-Gm-Message-State: AOAM530jvrhRx9H2zcyHCYQdeSWjAufIxhpTklX3/noTbI0DEs10k7Qw
        oTkXnze1Lr6VmLbcjR77Kp0djYaoqag=
X-Google-Smtp-Source: ABdhPJxjsWVCZmOoi22HO+6DBGtOz3Tvh9Qlrt9CC42NHW3VYy+DMIi/Yd+L21Zy78yxe5VfYDsjEQ==
X-Received: by 2002:adf:e6c2:: with SMTP id y2mr3184023wrm.117.1598696762132;
        Sat, 29 Aug 2020 03:26:02 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id l9sm2796162wmh.1.2020.08.29.03.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 03:26:01 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH 2/2] habanalabs: cast to u64 before shift > 31 bits
Date:   Sat, 29 Aug 2020 13:25:56 +0300
Message-Id: <20200829102556.21895-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829102556.21895-1-oded.gabbay@gmail.com>
References: <20200829102556.21895-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When shifting a boolean variable by more than 31 bits and putting the
result into a u64 variable, we need to cast the boolean into unsigned 64
bits to prevent possible overflow.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 8 +++++---
 drivers/misc/habanalabs/goya/goya.c   | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 076a7697f85d..084019788e11 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6114,7 +6114,7 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask,
 		is_idle &= is_eng_idle;
 
 		if (mask)
-			*mask |= !is_eng_idle <<
+			*mask |= ((u64) !is_eng_idle) <<
 					(GAUDI_ENGINE_ID_DMA_0 + dma_id);
 		if (s)
 			seq_printf(s, fmt, dma_id,
@@ -6137,7 +6137,8 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask,
 		is_idle &= is_eng_idle;
 
 		if (mask)
-			*mask |= !is_eng_idle << (GAUDI_ENGINE_ID_TPC_0 + i);
+			*mask |= ((u64) !is_eng_idle) <<
+						(GAUDI_ENGINE_ID_TPC_0 + i);
 		if (s)
 			seq_printf(s, fmt, i,
 				is_eng_idle ? "Y" : "N",
@@ -6165,7 +6166,8 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask,
 		is_idle &= is_eng_idle;
 
 		if (mask)
-			*mask |= !is_eng_idle << (GAUDI_ENGINE_ID_MME_0 + i);
+			*mask |= ((u64) !is_eng_idle) <<
+						(GAUDI_ENGINE_ID_MME_0 + i);
 		if (s) {
 			if (!is_slave)
 				seq_printf(s, fmt, i,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index c41f2917863b..88847eb1b472 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5173,7 +5173,8 @@ static bool goya_is_device_idle(struct hl_device *hdev, u64 *mask,
 		is_idle &= is_eng_idle;
 
 		if (mask)
-			*mask |= !is_eng_idle << (GOYA_ENGINE_ID_DMA_0 + i);
+			*mask |= ((u64) !is_eng_idle) <<
+						(GOYA_ENGINE_ID_DMA_0 + i);
 		if (s)
 			seq_printf(s, dma_fmt, i, is_eng_idle ? "Y" : "N",
 					qm_glbl_sts0, dma_core_sts0);
@@ -5196,7 +5197,8 @@ static bool goya_is_device_idle(struct hl_device *hdev, u64 *mask,
 		is_idle &= is_eng_idle;
 
 		if (mask)
-			*mask |= !is_eng_idle << (GOYA_ENGINE_ID_TPC_0 + i);
+			*mask |= ((u64) !is_eng_idle) <<
+						(GOYA_ENGINE_ID_TPC_0 + i);
 		if (s)
 			seq_printf(s, fmt, i, is_eng_idle ? "Y" : "N",
 				qm_glbl_sts0, cmdq_glbl_sts0, tpc_cfg_sts);
@@ -5216,7 +5218,7 @@ static bool goya_is_device_idle(struct hl_device *hdev, u64 *mask,
 	is_idle &= is_eng_idle;
 
 	if (mask)
-		*mask |= !is_eng_idle << GOYA_ENGINE_ID_MME_0;
+		*mask |= ((u64) !is_eng_idle) << GOYA_ENGINE_ID_MME_0;
 	if (s) {
 		seq_printf(s, fmt, 0, is_eng_idle ? "Y" : "N", qm_glbl_sts0,
 				cmdq_glbl_sts0, mme_arch_sts);
-- 
2.17.1

