Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A059C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F91E2076C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iod7zEfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgIJSUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgIJSPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:15:55 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FD7C061786
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:15:41 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id nw23so10121016ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=voYR5muBlLbTVdG6m15hKxjJNNGpvc6FUli5ewyzpv0=;
        b=Iod7zEfabBVVCSca6KQ7ZovDtE7lL5zlGxXMtprkOpOOx2JTBG7T27itE116bwbSut
         ll6fZk0Ttv7hi3TZ47+piCNPl5JaQgWFyCHTWXOfGJFSJID1DqJdGRGrnm518Wb86WXU
         lXgFGM6VFuxqGwrqM3VUltDlxmQtemH8ueuH9tdASZqioc1UpaTWiQFHZ/+hRF06cCXA
         CPbh7z597QB+hR3DUIFpr4AktWjcC1nq3QC9/q7fgYE/M/ylm+ryZwFhv+PAxWmwL1eW
         fOYf0TqQnX8ZR7szGxiFcAN+ctIIUCcGIdfQirPZ/nPksRlhaupGR5pZYdusgqzHsYjD
         8cHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=voYR5muBlLbTVdG6m15hKxjJNNGpvc6FUli5ewyzpv0=;
        b=TKK7pFr6NdIZIYeMyt00DI2Ea5Bqtz4Ls2vVPm6sTG2PmQ8YYVq+7ipbVaIR+ZVPR+
         DV88W/HCo5BHDVNct8l0K3+GbiJWUliqrqWm5vOEPSumGqkFesKUZsClSLIikA3nXQ6S
         lggfh8+0CM4XvNdbhIzG95mmR/tP8Ir054zWWi5ll5vKZy70CFqwtMbm43qoA/OITlao
         bDTmLjnh7V+e4lXisAnuLisUyisyIUBbXZZjIJK5vgl5d9cbzVp6rdfv0h6IXqSQ52sg
         4tejpsPvfXhm/qz04rNa5AUpxpA5/0v8q4pjNAn0AIiR6eNVJe0d/eKXI9t6swklgUQT
         w42A==
X-Gm-Message-State: AOAM532rogqvZlCp/KGtN8AkhIsN5h99E7NDlvr2hOsOGnC/DPbUXJWh
        nnF8dbSqqhgJ5NXh+JI1xiSBT1M7cvQ=
X-Google-Smtp-Source: ABdhPJxuWuTUkTyk5EwTyK+or4QHGX4423i67UqhcdHmGRNqOcdjG7yuT1M7EnD17pMULfnEDxKcSA==
X-Received: by 2002:a17:906:4956:: with SMTP id f22mr9596001ejt.62.1599761738514;
        Thu, 10 Sep 2020 11:15:38 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id y6sm8636117edj.50.2020.09.10.11.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 11:15:37 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org, Moti Haimovski <mhaimovski@habana.ai>
Subject: [PATCH 05/11] habanalabs: add debugfs support for MMU with 6 HOPs
Date:   Thu, 10 Sep 2020 21:15:18 +0300
Message-Id: <20200910181524.21460-5-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910181524.21460-1-oded.gabbay@gmail.com>
References: <20200910181524.21460-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moti Haimovski <mhaimovski@habana.ai>

This commit modify the existing debugfs code to support future devices that
have a 6 HOPs MMU implementation instead of 5 HOPs implementation.

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/debugfs.c | 70 ++++++++++++++++++++----
 1 file changed, 60 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 9398a21e0398..7b1fb49c3501 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -354,6 +354,14 @@ static inline u64 get_hop4_pte_addr(struct hl_ctx *ctx,
 					mmu_specs->hop4_shift);
 }
 
+static inline u64 get_hop5_pte_addr(struct hl_ctx *ctx,
+					struct hl_mmu_properties *mmu_specs,
+					u64 hop_addr, u64 vaddr)
+{
+	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_specs->hop5_mask,
+					mmu_specs->hop5_shift);
+}
+
 static inline u64 get_next_hop_addr(u64 curr_pte)
 {
 	if (curr_pte & PAGE_PRESENT_MASK)
@@ -377,6 +385,7 @@ static int mmu_show(struct seq_file *s, void *data)
 		hop2_addr = 0, hop2_pte_addr = 0, hop2_pte = 0,
 		hop3_addr = 0, hop3_pte_addr = 0, hop3_pte = 0,
 		hop4_addr = 0, hop4_pte_addr = 0, hop4_pte = 0,
+		hop5_addr = 0, hop5_pte_addr = 0, hop5_pte = 0,
 		virt_addr = dev_entry->mmu_addr;
 
 	if (!hdev->mmu_enable)
@@ -428,20 +437,49 @@ static int mmu_show(struct seq_file *s, void *data)
 	hop3_pte_addr = get_hop3_pte_addr(ctx, mmu_prop, hop3_addr, virt_addr);
 	hop3_pte = hdev->asic_funcs->read_pte(hdev, hop3_pte_addr);
 
-	if (!(hop3_pte & LAST_MASK)) {
+	if (mmu_prop->num_hops == MMU_ARCH_5_HOPS) {
+		if (!(hop3_pte & LAST_MASK)) {
+			hop4_addr = get_next_hop_addr(hop3_pte);
+
+			if (hop4_addr == ULLONG_MAX)
+				goto not_mapped;
+
+			hop4_pte_addr = get_hop4_pte_addr(ctx, mmu_prop,
+							hop4_addr, virt_addr);
+			hop4_pte = hdev->asic_funcs->read_pte(hdev,
+								hop4_pte_addr);
+			if (!(hop4_pte & PAGE_PRESENT_MASK))
+				goto not_mapped;
+		} else {
+			if (!(hop3_pte & PAGE_PRESENT_MASK))
+				goto not_mapped;
+		}
+	} else {
 		hop4_addr = get_next_hop_addr(hop3_pte);
 
 		if (hop4_addr == ULLONG_MAX)
 			goto not_mapped;
 
-		hop4_pte_addr = get_hop4_pte_addr(ctx, mmu_prop, hop4_addr,
-							virt_addr);
-		hop4_pte = hdev->asic_funcs->read_pte(hdev, hop4_pte_addr);
-		if (!(hop4_pte & PAGE_PRESENT_MASK))
-			goto not_mapped;
-	} else {
-		if (!(hop3_pte & PAGE_PRESENT_MASK))
-			goto not_mapped;
+		hop4_pte_addr = get_hop4_pte_addr(ctx, mmu_prop,
+						hop4_addr, virt_addr);
+		hop4_pte = hdev->asic_funcs->read_pte(hdev,
+							hop4_pte_addr);
+		if (!(hop4_pte & LAST_MASK)) {
+			hop5_addr = get_next_hop_addr(hop4_pte);
+
+			if (hop5_addr == ULLONG_MAX)
+				goto not_mapped;
+
+			hop5_pte_addr = get_hop5_pte_addr(ctx, mmu_prop,
+							hop5_addr, virt_addr);
+			hop5_pte = hdev->asic_funcs->read_pte(hdev,
+								hop5_pte_addr);
+			if (!(hop5_pte & PAGE_PRESENT_MASK))
+				goto not_mapped;
+		} else {
+			if (!(hop4_pte & PAGE_PRESENT_MASK))
+				goto not_mapped;
+		}
 	}
 
 	seq_printf(s, "asid: %u, virt_addr: 0x%llx\n",
@@ -463,10 +501,22 @@ static int mmu_show(struct seq_file *s, void *data)
 	seq_printf(s, "hop3_pte_addr: 0x%llx\n", hop3_pte_addr);
 	seq_printf(s, "hop3_pte: 0x%llx\n", hop3_pte);
 
-	if (!(hop3_pte & LAST_MASK)) {
+	if (mmu_prop->num_hops == MMU_ARCH_5_HOPS) {
+		if (!(hop3_pte & LAST_MASK)) {
+			seq_printf(s, "hop4_addr: 0x%llx\n", hop4_addr);
+			seq_printf(s, "hop4_pte_addr: 0x%llx\n", hop4_pte_addr);
+			seq_printf(s, "hop4_pte: 0x%llx\n", hop4_pte);
+		}
+	} else {
 		seq_printf(s, "hop4_addr: 0x%llx\n", hop4_addr);
 		seq_printf(s, "hop4_pte_addr: 0x%llx\n", hop4_pte_addr);
 		seq_printf(s, "hop4_pte: 0x%llx\n", hop4_pte);
+
+		if (!(hop4_pte & LAST_MASK)) {
+			seq_printf(s, "hop5_addr: 0x%llx\n", hop5_addr);
+			seq_printf(s, "hop5_pte_addr: 0x%llx\n", hop5_pte_addr);
+			seq_printf(s, "hop5_pte: 0x%llx\n", hop5_pte);
+		}
 	}
 
 	goto out;
-- 
2.17.1

