Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B14C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DED2C21D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlK8EmEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgIJSoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgIJSPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:15:55 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B92EC0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:15:38 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id z23so10063472ejr.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dpeyEcDpp+tdLYiXqxBt04Txn74dP5HFy6bcYEPj1k0=;
        b=mlK8EmEUcnGOyiufRMBwl0dllryQy2OTkXcHGa3sKbWqNIZQaVpy6fdRBnn0qaYBPw
         FrGUmbekInIsVEPE6yazmwhzQjzAFEi4k7z1v10WFkA17w5YvVkXgNAaombdABbdkmGl
         f0s/gOxYMmMhd9sHHQYDmPcFZuRewfExWFpyLx8W7HjTR1BBbGvrv4fxTM6vt8h/Q0Y7
         xXY8tpdqisACUjRSyk27L57rRekBAWdwzVSZpKcP/ZzPVHJ3g+ynPsp2efhMy5ZZYuuv
         /T2qTDuqj+LqvSHNDJjdMLR0sFjG+KIfQxNTYYSuIUAIILFKRGFkIJXDohHJrPq8RQiq
         Sj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dpeyEcDpp+tdLYiXqxBt04Txn74dP5HFy6bcYEPj1k0=;
        b=ZpVLIhXznnPMyTKK6mGLcdH1U2YJi+3DYq25DYTfLD6jqVZj8boxSimKOFFx7zUfc8
         Psn35utWQNozsAd7hVh+NBhmf+xl2+zaZD4W8Wvwr91AeO2rMI77bDVQoJxiBgQjDCA3
         lP+SMQcvSRGMVLccj7h/NfshlqK6sPCKbZ7Fcwen0ZX0fVPVGA9e1f3GZEWWQDLkhmcQ
         OnpJeKbLkmXa95IRONnRuY+VBhp72yCdwL+O5OQAumzutCwvtBhuqsuP5PlTtuAzrIzZ
         FPe6km8VV73VGsvc0kxOUTIZs+TQECpdMrunoefh12yyGSfOPjBw8A5LcE7TS6h9RZDz
         noVw==
X-Gm-Message-State: AOAM531OeMEdDVRrC0wAJGsvOMhIENVzDcH0LElBOEzo+6cpFS6Q+nzi
        CULDacCmwbx8W93gE6GX644fzkl1jsQ=
X-Google-Smtp-Source: ABdhPJw1NqDSZClSIHq78TSGasiHSLzJif68HGkHAGm6csWkHWvpDYJUepJtM3g46C5p0EjSl0j1gg==
X-Received: by 2002:a17:906:c830:: with SMTP id dd16mr10513092ejb.196.1599761736445;
        Thu, 10 Sep 2020 11:15:36 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id y6sm8636117edj.50.2020.09.10.11.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 11:15:34 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org, Moti Haimovski <mhaimovski@habana.ai>
Subject: [PATCH 04/11] habanalabs: add num_hops to hl_mmu_properties
Date:   Thu, 10 Sep 2020 21:15:17 +0300
Message-Id: <20200910181524.21460-4-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910181524.21460-1-oded.gabbay@gmail.com>
References: <20200910181524.21460-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moti Haimovski <mhaimovski@habana.ai>

This commit adds the number of HOPs supported by the device to the
device MMU properties.

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/habanalabs.h             | 6 ++++++
 drivers/misc/habanalabs/gaudi/gaudi.c                   | 1 +
 drivers/misc/habanalabs/goya/goya.c                     | 2 ++
 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h | 2 ++
 4 files changed, 11 insertions(+)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 15e746a5fe35..8ef61926ed3b 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -236,12 +236,15 @@ enum hl_device_hw_state {
  * @hop2_shift: shift of hop 2 mask.
  * @hop3_shift: shift of hop 3 mask.
  * @hop4_shift: shift of hop 4 mask.
+ * @hop5_shift: shift of hop 5 mask.
  * @hop0_mask: mask to get the PTE address in hop 0.
  * @hop1_mask: mask to get the PTE address in hop 1.
  * @hop2_mask: mask to get the PTE address in hop 2.
  * @hop3_mask: mask to get the PTE address in hop 3.
  * @hop4_mask: mask to get the PTE address in hop 4.
+ * @hop5_mask: mask to get the PTE address in hop 5.
  * @page_size: default page size used to allocate memory.
+ * @num_hops: The amount of hops supported by the translation table.
  */
 struct hl_mmu_properties {
 	u64	start_addr;
@@ -251,12 +254,15 @@ struct hl_mmu_properties {
 	u64	hop2_shift;
 	u64	hop3_shift;
 	u64	hop4_shift;
+	u64	hop5_shift;
 	u64	hop0_mask;
 	u64	hop1_mask;
 	u64	hop2_mask;
 	u64	hop3_mask;
 	u64	hop4_mask;
+	u64	hop5_mask;
 	u32	page_size;
+	u32	num_hops;
 };
 
 /**
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 483989500863..bf010ff31ced 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -441,6 +441,7 @@ static int gaudi_get_fixed_properties(struct hl_device *hdev)
 	prop->pmmu.end_addr =
 			(VA_HOST_SPACE_START + VA_HOST_SPACE_SIZE / 2) - 1;
 	prop->pmmu.page_size = PAGE_SIZE_4KB;
+	prop->pmmu.num_hops = MMU_ARCH_5_HOPS;
 
 	/* PMMU and HPMMU are the same except of page size */
 	memcpy(&prop->pmmu_huge, &prop->pmmu, sizeof(prop->pmmu));
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 46a900fb3ef8..6f831cc54d37 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -426,12 +426,14 @@ int goya_get_fixed_properties(struct hl_device *hdev)
 	prop->dmmu.start_addr = VA_DDR_SPACE_START;
 	prop->dmmu.end_addr = VA_DDR_SPACE_END;
 	prop->dmmu.page_size = PAGE_SIZE_2MB;
+	prop->dmmu.num_hops = MMU_ARCH_5_HOPS;
 
 	/* shifts and masks are the same in PMMU and DMMU */
 	memcpy(&prop->pmmu, &prop->dmmu, sizeof(prop->dmmu));
 	prop->pmmu.start_addr = VA_HOST_SPACE_START;
 	prop->pmmu.end_addr = VA_HOST_SPACE_END;
 	prop->pmmu.page_size = PAGE_SIZE_4KB;
+	prop->pmmu.num_hops = MMU_ARCH_5_HOPS;
 
 	/* PMMU and HPMMU are the same except of page size */
 	memcpy(&prop->pmmu_huge, &prop->pmmu, sizeof(prop->pmmu));
diff --git a/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h b/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
index 468bb045fbd1..dedf20e8f956 100644
--- a/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
+++ b/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
@@ -29,6 +29,8 @@
 #define HOP3_SHIFT			21
 #define HOP4_SHIFT			12
 
+#define MMU_ARCH_5_HOPS			5
+
 #define HOP_PHYS_ADDR_MASK		(~FLAGS_MASK)
 
 #define HL_PTE_SIZE			sizeof(u64)
-- 
2.17.1

