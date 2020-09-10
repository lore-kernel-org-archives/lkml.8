Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64306C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0444F20BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OZZuvrCM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgIJIYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730131AbgIJINl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:13:41 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414B1C0617A1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:13:17 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d16so529724pll.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XVF1RkRlNyjr4ZwKxBdakcqACyTLVz5RhfVby+r/t60=;
        b=OZZuvrCM/fVMSzDsPqGkcs1Ug1kb60GjZWJgGPcxppiDKKwMnzcrRnUsA5dPYnUB/K
         B37Qj9Ch3z+WfZzhg8cj+xYFZVBy6HQrls549qeKzHvptK/I2tXv2z00p7wO6r8m1cau
         TUobCL4MFOFdgMajtXCVjPg5V/F3yGL3ePOTAINZtP/iymisM8ch9Mt3GFQNq9k13x9R
         nGtsL8NJSZiVy6k3FJjFx+EcqLodkh6hRxdtcyxDxdRq2KtS3gmNEQuYUH7/5Q49g7IQ
         3wgiuAcDuA1+1iWh97dCClfXjK7MyE4UVu/lRwBBXUut/Vx3t7oXwO+VLOLCoN3TmJMj
         8cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XVF1RkRlNyjr4ZwKxBdakcqACyTLVz5RhfVby+r/t60=;
        b=mBcWRsFgqMYUuk7Y8Q3V3DYb35/spXOXtJyFwuZ8dYWq/di5OZij0B0mXKaHk35oqu
         Y2jotsM1Jo2a5hMV3Qy7O9vO4CQavnvmY4IT6JQU1HG34ShmtXfiDP/NyUIpncMtK2KV
         caRJmbFyGTT4lWapUQ2xYtyywwdwikLiSOPYwvG58P+6nvaGC2l3FPdUlgCugFqeRyW+
         hS4A1winJdIFQLNx1tfuKEmRZZeYjEqOgzsmJZC5ppeZqvdGXZC4RWyOMLQ+egutHzJb
         rUh/RuCHPfJ1R9Re34/HN4wngmwFRq6fwh0KHjEM8sCT3VS/lo6y5lGyFvV0Wlr0rz0m
         Ps+Q==
X-Gm-Message-State: AOAM530lQQtn04DTKMCt2LQD/gbwEdIt9f8ErB4MESbfgc+wg6FN9sW0
        l7G1k9rA6DW6QYo2ZpZy3l0lzA==
X-Google-Smtp-Source: ABdhPJw19dAMc6BvCbvY2jkMxRJgSyngavAZ97Abc7uvsChgqFJWKFt+a0ixzwFgdzHyCRXh1ObWBw==
X-Received: by 2002:a17:902:59d8:b029:d0:89f1:9e2d with SMTP id d24-20020a17090259d8b02900d089f19e2dmr4668405plj.9.1599725596763;
        Thu, 10 Sep 2020 01:13:16 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id e1sm2196056pfl.162.2020.09.10.01.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:13:16 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: [RFC PATCH v7 19/21] riscv: Fix an illegal instruction exception when accessing vlenb without enable vector first
Date:   Thu, 10 Sep 2020 16:12:14 +0800
Message-Id: <bb610d92b2cfc510b7deca3b2484598a10d88b5c.1599719352.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599719352.git.greentime.hu@sifive.com>
References: <cover.1599719352.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It triggered an illegal instruction exception when accessing vlenb CSR
without enable vector first. To fix this issue, we should enable vector
before using it and disable vector after using it.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/vector.h        | 2 ++
 arch/riscv/kernel/cpufeature.c         | 3 +++
 arch/riscv/kernel/kernel_mode_vector.c | 6 ++++--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index 3fc8d84e23c6..a99bbda7f4ba 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -10,6 +10,8 @@
 
 #include <linux/types.h>
 
+void rvv_enable(void);
+void rvv_disable(void);
 void kernel_rvv_begin(void);
 void kernel_rvv_end(void);
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 4d4f78f6a5db..817980d38603 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -22,6 +22,7 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 bool has_fpu __read_mostly;
 #endif
 #ifdef CONFIG_VECTOR
+#include <asm/vector.h>
 bool has_vector __read_mostly;
 unsigned long riscv_vsize __read_mostly;
 #endif
@@ -158,7 +159,9 @@ void riscv_fill_hwcap(void)
 	if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
 		has_vector = true;
 		/* There are 32 vector registers with vlenb length. */
+		rvv_enable();
 		riscv_vsize = csr_read(CSR_VLENB) * 32;
+		rvv_disable();
 	}
 #endif
 }
diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
index b84618630edf..0d990bd8b8dd 100644
--- a/arch/riscv/kernel/kernel_mode_vector.c
+++ b/arch/riscv/kernel/kernel_mode_vector.c
@@ -71,15 +71,17 @@ static void put_cpu_vector_context(void)
 	preempt_enable();
 }
 
-static void rvv_enable(void)
+void rvv_enable(void)
 {
 	csr_set(CSR_STATUS, SR_VS);
 }
+EXPORT_SYMBOL(rvv_enable);
 
-static void rvv_disable(void)
+void rvv_disable(void)
 {
 	csr_clear(CSR_STATUS, SR_VS);
 }
+EXPORT_SYMBOL(rvv_disable);
 
 static void vector_flush_cpu_state(void)
 {
-- 
2.28.0

