Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F28C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 636E9214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5SYjDTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgDRIYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 04:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgDRIYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 04:24:51 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08635C061A0F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 01:24:51 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g12so5330800wmh.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 01:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I0Ki/vBt3O6VAfSQlBFLYo1JpMezse5hkj4ROLsiFAk=;
        b=N5SYjDTQpO02KB0wlteMCsUVNd69DZXSL06UQ2L/9aWaWeJXHCJRbZyA5OhAfhAV8v
         Hl111fC8FvfRdbe58ZSolhTKQNB1gm0WhKwjd3JslvQ0garRbPbh33JwqMhD2qSGz2YF
         1vY33uzdwK5x79E0E8zQ5j3M4v0ieV4VV7P1em/oDomEecwBrB97gF++sVGqMzPNhS4Y
         +w8xmay6Qfl8u8sMMtPYMbiI8lOqxrwHjLaE29aBaOBDZtTlBFZDlx1QgotxqEXUnFCr
         OSgy8h9u/7p7DmUzdREkNCTv7GcSHG3hp6SdRjfOgtY+nERWyT6wX4eFZP1zD4L1FFjb
         rv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I0Ki/vBt3O6VAfSQlBFLYo1JpMezse5hkj4ROLsiFAk=;
        b=kpBgPgk+FnVaCO4VCQ5pondDJPptGpNdYKpXWKUEhkWAX36o15oOCcjLeY8FHeGQAd
         I14MSIPAzDHOKBr9QdbqRqQULKtRCb1CLsH8Yuwd8fLDfXALSciCrvZTKctv6gqWlJs1
         B6b7DDSgnxwkh4MNg7ekM7M0nSv26pn7AajOAWb0POZqRFVIbB1untbQf5aAMgvDyBzz
         3nNUky4UklVuO9X18+piTdGvXiBLOBImFlBH50UxMV2kXLDLUPMYCD/dcVNeKqePnzYZ
         e0yraxDJfmlIsqm87FWWh6YOCwHdN47RbRgY+RCPg6Fnd/2QSln7+oTflffMdQA/4oJ6
         uRbQ==
X-Gm-Message-State: AGi0PuZGC999fN7K+WC/iAB47Z1jdQEMlw957QbSA6TJJRFbWcpPPWE2
        1KJFYWazl5jitwKRiJSZMYNt5lYj
X-Google-Smtp-Source: APiQypIflF7FNvCpnbxqLfMcfAq6V6z+IY+CP/xv9ACiIuXYIkMM0aBe5Ldi5sAlschyguD/nxrNZg==
X-Received: by 2002:a1c:41d7:: with SMTP id o206mr7245536wma.89.1587198289215;
        Sat, 18 Apr 2020 01:24:49 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id c190sm10898087wme.4.2020.04.18.01.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 01:24:48 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 3/5] habanalabs: Align protection bits configuration of all TPCs
Date:   Sat, 18 Apr 2020 11:24:38 +0300
Message-Id: <20200418082440.21277-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200418082440.21277-1-oded.gabbay@gmail.com>
References: <20200418082440.21277-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Align the protection bits configuration of all TPC cores to be as of TPC
core 0.

Fixes: a513f9a7eca5 ("habanalabs: make tpc registers secured")

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya_security.c | 99 +++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/goya/goya_security.c b/drivers/misc/habanalabs/goya/goya_security.c
index 2dfdfbb07905..de8297001fea 100644
--- a/drivers/misc/habanalabs/goya/goya_security.c
+++ b/drivers/misc/habanalabs/goya/goya_security.c
@@ -694,7 +694,6 @@ static void goya_init_tpc_protection_bits(struct hl_device *hdev)
 	mask |= 1 << ((mmTPC0_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC0_CFG_SM_BASE_ADDRESS_LOW & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC0_CFG_SM_BASE_ADDRESS_HIGH & 0x7F) >> 2);
-	mask |= 1 << ((mmTPC0_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC0_CFG_TPC_STALL & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC0_CFG_MSS_CONFIG & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC0_CFG_TPC_INTR_CAUSE & 0x7F) >> 2);
@@ -874,6 +873,16 @@ static void goya_init_tpc_protection_bits(struct hl_device *hdev)
 	goya_pb_set_block(hdev, mmTPC1_RD_REGULATOR_BASE);
 	goya_pb_set_block(hdev, mmTPC1_WR_REGULATOR_BASE);
 
+	pb_addr = (mmTPC1_CFG_SEMAPHORE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_CFG_SEMAPHORE & PROT_BITS_OFFS) >> 7) << 2;
+
+	mask = 1 << ((mmTPC1_CFG_SEMAPHORE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_VFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_SFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_STATUS & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
 	pb_addr = (mmTPC1_CFG_CFG_BASE_ADDRESS_HIGH & ~0xFFF) + PROT_BITS_OFFS;
 	word_offset = ((mmTPC1_CFG_CFG_BASE_ADDRESS_HIGH &
 			PROT_BITS_OFFS) >> 7) << 2;
@@ -881,6 +890,10 @@ static void goya_init_tpc_protection_bits(struct hl_device *hdev)
 	mask |= 1 << ((mmTPC1_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC1_CFG_SM_BASE_ADDRESS_LOW & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC1_CFG_SM_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_TPC_STALL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_MSS_CONFIG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_TPC_INTR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_TPC_INTR_MASK & 0x7F) >> 2);
 
 	WREG32(pb_addr + word_offset, ~mask);
 
@@ -1056,6 +1069,16 @@ static void goya_init_tpc_protection_bits(struct hl_device *hdev)
 	goya_pb_set_block(hdev, mmTPC2_RD_REGULATOR_BASE);
 	goya_pb_set_block(hdev, mmTPC2_WR_REGULATOR_BASE);
 
+	pb_addr = (mmTPC2_CFG_SEMAPHORE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_CFG_SEMAPHORE & PROT_BITS_OFFS) >> 7) << 2;
+
+	mask = 1 << ((mmTPC2_CFG_SEMAPHORE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_VFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_SFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_STATUS & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
 	pb_addr = (mmTPC2_CFG_CFG_BASE_ADDRESS_HIGH & ~0xFFF) + PROT_BITS_OFFS;
 	word_offset = ((mmTPC2_CFG_CFG_BASE_ADDRESS_HIGH &
 			PROT_BITS_OFFS) >> 7) << 2;
@@ -1063,6 +1086,10 @@ static void goya_init_tpc_protection_bits(struct hl_device *hdev)
 	mask |= 1 << ((mmTPC2_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC2_CFG_SM_BASE_ADDRESS_LOW & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC2_CFG_SM_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_TPC_STALL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_MSS_CONFIG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_TPC_INTR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_TPC_INTR_MASK & 0x7F) >> 2);
 
 	WREG32(pb_addr + word_offset, ~mask);
 
@@ -1238,6 +1265,16 @@ static void goya_init_tpc_protection_bits(struct hl_device *hdev)
 	goya_pb_set_block(hdev, mmTPC3_RD_REGULATOR_BASE);
 	goya_pb_set_block(hdev, mmTPC3_WR_REGULATOR_BASE);
 
+	pb_addr = (mmTPC3_CFG_SEMAPHORE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_CFG_SEMAPHORE & PROT_BITS_OFFS) >> 7) << 2;
+
+	mask = 1 << ((mmTPC3_CFG_SEMAPHORE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_VFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_SFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_STATUS & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
 	pb_addr = (mmTPC3_CFG_CFG_BASE_ADDRESS_HIGH & ~0xFFF) + PROT_BITS_OFFS;
 	word_offset = ((mmTPC3_CFG_CFG_BASE_ADDRESS_HIGH
 			& PROT_BITS_OFFS) >> 7) << 2;
@@ -1245,6 +1282,10 @@ static void goya_init_tpc_protection_bits(struct hl_device *hdev)
 	mask |= 1 << ((mmTPC3_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC3_CFG_SM_BASE_ADDRESS_LOW & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC3_CFG_SM_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_TPC_STALL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_MSS_CONFIG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_TPC_INTR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_TPC_INTR_MASK & 0x7F) >> 2);
 
 	WREG32(pb_addr + word_offset, ~mask);
 
@@ -1420,6 +1461,16 @@ static void goya_init_tpc_protection_bits(struct hl_device *hdev)
 	goya_pb_set_block(hdev, mmTPC4_RD_REGULATOR_BASE);
 	goya_pb_set_block(hdev, mmTPC4_WR_REGULATOR_BASE);
 
+	pb_addr = (mmTPC4_CFG_SEMAPHORE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_CFG_SEMAPHORE & PROT_BITS_OFFS) >> 7) << 2;
+
+	mask = 1 << ((mmTPC4_CFG_SEMAPHORE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_VFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_SFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_STATUS & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
 	pb_addr = (mmTPC4_CFG_CFG_BASE_ADDRESS_HIGH & ~0xFFF) + PROT_BITS_OFFS;
 	word_offset = ((mmTPC4_CFG_CFG_BASE_ADDRESS_HIGH &
 			PROT_BITS_OFFS) >> 7) << 2;
@@ -1427,6 +1478,10 @@ static void goya_init_tpc_protection_bits(struct hl_device *hdev)
 	mask |= 1 << ((mmTPC4_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC4_CFG_SM_BASE_ADDRESS_LOW & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC4_CFG_SM_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_TPC_STALL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_MSS_CONFIG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_TPC_INTR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_TPC_INTR_MASK & 0x7F) >> 2);
 
 	WREG32(pb_addr + word_offset, ~mask);
 
@@ -1602,6 +1657,16 @@ static void goya_init_tpc_protection_bits(struct hl_device *hdev)
 	goya_pb_set_block(hdev, mmTPC5_RD_REGULATOR_BASE);
 	goya_pb_set_block(hdev, mmTPC5_WR_REGULATOR_BASE);
 
+	pb_addr = (mmTPC5_CFG_SEMAPHORE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_CFG_SEMAPHORE & PROT_BITS_OFFS) >> 7) << 2;
+
+	mask = 1 << ((mmTPC5_CFG_SEMAPHORE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_VFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_SFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_STATUS & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
 	pb_addr = (mmTPC5_CFG_CFG_BASE_ADDRESS_HIGH & ~0xFFF) + PROT_BITS_OFFS;
 	word_offset = ((mmTPC5_CFG_CFG_BASE_ADDRESS_HIGH &
 			PROT_BITS_OFFS) >> 7) << 2;
@@ -1609,6 +1674,10 @@ static void goya_init_tpc_protection_bits(struct hl_device *hdev)
 	mask |= 1 << ((mmTPC5_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC5_CFG_SM_BASE_ADDRESS_LOW & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC5_CFG_SM_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_TPC_STALL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_MSS_CONFIG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_TPC_INTR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_TPC_INTR_MASK & 0x7F) >> 2);
 
 	WREG32(pb_addr + word_offset, ~mask);
 
@@ -1784,6 +1853,16 @@ static void goya_init_tpc_protection_bits(struct hl_device *hdev)
 	goya_pb_set_block(hdev, mmTPC6_RD_REGULATOR_BASE);
 	goya_pb_set_block(hdev, mmTPC6_WR_REGULATOR_BASE);
 
+	pb_addr = (mmTPC6_CFG_SEMAPHORE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_CFG_SEMAPHORE & PROT_BITS_OFFS) >> 7) << 2;
+
+	mask = 1 << ((mmTPC6_CFG_SEMAPHORE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_VFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_SFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_STATUS & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
 	pb_addr = (mmTPC6_CFG_CFG_BASE_ADDRESS_HIGH & ~0xFFF) + PROT_BITS_OFFS;
 	word_offset = ((mmTPC6_CFG_CFG_BASE_ADDRESS_HIGH &
 			PROT_BITS_OFFS) >> 7) << 2;
@@ -1791,6 +1870,10 @@ static void goya_init_tpc_protection_bits(struct hl_device *hdev)
 	mask |= 1 << ((mmTPC6_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC6_CFG_SM_BASE_ADDRESS_LOW & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC6_CFG_SM_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_TPC_STALL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_MSS_CONFIG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_TPC_INTR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_TPC_INTR_MASK & 0x7F) >> 2);
 
 	WREG32(pb_addr + word_offset, ~mask);
 
@@ -1966,6 +2049,16 @@ static void goya_init_tpc_protection_bits(struct hl_device *hdev)
 	goya_pb_set_block(hdev, mmTPC7_RD_REGULATOR_BASE);
 	goya_pb_set_block(hdev, mmTPC7_WR_REGULATOR_BASE);
 
+	pb_addr = (mmTPC7_CFG_SEMAPHORE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_CFG_SEMAPHORE & PROT_BITS_OFFS) >> 7) << 2;
+
+	mask = 1 << ((mmTPC7_CFG_SEMAPHORE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_VFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_SFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_STATUS & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
 	pb_addr = (mmTPC7_CFG_CFG_BASE_ADDRESS_HIGH & ~0xFFF) +	PROT_BITS_OFFS;
 	word_offset = ((mmTPC7_CFG_CFG_BASE_ADDRESS_HIGH &
 			PROT_BITS_OFFS) >> 7) << 2;
@@ -1973,6 +2066,10 @@ static void goya_init_tpc_protection_bits(struct hl_device *hdev)
 	mask |= 1 << ((mmTPC7_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC7_CFG_SM_BASE_ADDRESS_LOW & 0x7F) >> 2);
 	mask |= 1 << ((mmTPC7_CFG_SM_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_TPC_STALL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_MSS_CONFIG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_TPC_INTR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_TPC_INTR_MASK & 0x7F) >> 2);
 
 	WREG32(pb_addr + word_offset, ~mask);
 
-- 
2.17.1

