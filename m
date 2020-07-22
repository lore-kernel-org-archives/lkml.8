Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E92AC433FB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C5A2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EHDURTcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbgGVQpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 12:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731298AbgGVQpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 12:45:16 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651CEC0619E1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 09:45:16 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f18so2576813wrs.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Zoc4jT5D/PnpX6Ge9Fh8+yTlt5xAHFadpjWGBF1q0w=;
        b=EHDURTcBkVhJJVi3ujf/kQeTfFBT7h/B9rxoO/V6rVCgVwVesI6SzZIa06WBR4XrFl
         EEc9WcBPE7DBmvVrqXAG2TZ6AgH9fDPkjcr/cpkZ3YeIKVPt1DBo+pvWJi6VB3G/JmeX
         fSgzbviAYvO/KtVcj8dE8gdhqC3wxBnOf4JlONMDO93pAlrrfS5v4nv9Avm7ELmCflWd
         3AltLvlQCDsboajAG8AeCOm8lC6ewgH11gH6xtNGdjO5UFpz3uUW8GRmqYaHIa02jYdR
         vH1wWLWsSKtXiU7d9T/LJrWMnSBWw2shzP30T5TVW0Z4QbYHatf6n/Uz3oyeSyz0QFKE
         7YXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Zoc4jT5D/PnpX6Ge9Fh8+yTlt5xAHFadpjWGBF1q0w=;
        b=XvvsSE3zQglYVq1SJJ/MH/u9mH06IgORKIJxw/6CvDcyM4H6vhdxowuLRxexcgE0zB
         kVIGk7AG4zST6M3Cb8EqSSryjhy2t9f+8vGFRZJPHIK7d9FPvXTgYNZ5qFYVag5ZhpXm
         xHHMSszQMuaYvWJUTxgKzfEiT4dKlnkrPS2SYG2wMUErrCXQrws9XDoZMX61bW87Culm
         YQvs9TCUrbFCRijGVE2iZWDOuUtgAaJBJKX0Rr+ysAa1Fxjx1kcSsdZypeRQf5fI0inr
         JiZ38BPyxcBbr1cffeSk4rkCvCqP18iOn7C4wk0YhFyAzLhbets7upVVxUXAHYi710Ke
         1Ekw==
X-Gm-Message-State: AOAM530BZ5HELZdAqXoA5ke1Irbx9A6fR8kw4Yvz9bCJHPFvE5TtKp0V
        85FxxdTM9zpcDf0Bn9ge5ZWpgQ==
X-Google-Smtp-Source: ABdhPJzLKmKG9pub1HFuNdCsYrh8zqcSQp68qHq5cvDc4U/7vFwUWtKwLOPhPUQibgTF3FLak/t0vg==
X-Received: by 2002:a5d:548f:: with SMTP id h15mr365969wrv.331.1595436314869;
        Wed, 22 Jul 2020 09:45:14 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:b0ee:900a:e004:b9d0])
        by smtp.gmail.com with ESMTPSA id t2sm242165wma.43.2020.07.22.09.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 09:45:14 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        kernel-team@google.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 9/9] kvm: arm64: Remove unnecessary hyp mappings
Date:   Wed, 22 Jul 2020 17:44:24 +0100
Message-Id: <20200722164424.42225-10-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722164424.42225-1-dbrazdil@google.com>
References: <20200722164424.42225-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With all nVHE per-CPU variables being part of the hyp per-CPU region,
mapping them individual is not necessary any longer. They are mapped to hyp
as part of the overall per-CPU region.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 25 +++++++------------------
 arch/arm64/kvm/arm.c             | 17 +----------------
 2 files changed, 8 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index e9e5875274cb..1a66089cf4f4 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -531,28 +531,17 @@ static inline int kvm_map_vectors(void)
 DECLARE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
 DECLARE_KVM_NVHE_PER_CPU(u64, arm64_ssbd_callback_required);
 
-static inline int hyp_init_aux_data(void)
+static inline void hyp_init_aux_data(void)
 {
-	int cpu, err;
+	int cpu;
 
-	for_each_possible_cpu(cpu) {
-		u64 *ptr;
-
-		ptr = per_cpu_ptr_nvhe(arm64_ssbd_callback_required, cpu);
-		err = create_hyp_mappings(ptr, ptr + 1, PAGE_HYP);
-		if (err)
-			return err;
-
-		/* Copy value from kernel to hyp. */
-		*ptr = per_cpu(arm64_ssbd_callback_required, cpu);
-	}
-	return 0;
+	/* Copy arm64_ssbd_callback_required values from kernel to hyp. */
+	for_each_possible_cpu(cpu)
+		*(per_cpu_ptr_nvhe(arm64_ssbd_callback_required, cpu)) =
+			per_cpu(arm64_ssbd_callback_required, cpu);
 }
 #else
-static inline int hyp_init_aux_data(void)
-{
-	return 0;
-}
+static inline void hyp_init_aux_data(void) {}
 #endif
 
 #define kvm_phys_to_vttbr(addr)		phys_to_ttbr(addr)
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index bbbc5c1519a9..f2e537d99d2b 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1628,22 +1628,7 @@ static int init_hyp_mode(void)
 		}
 	}
 
-	for_each_possible_cpu(cpu) {
-		kvm_host_data_t *cpu_data;
-
-		cpu_data = per_cpu_ptr_hyp(kvm_host_data, cpu);
-		err = create_hyp_mappings(cpu_data, cpu_data + 1, PAGE_HYP);
-
-		if (err) {
-			kvm_err("Cannot map host CPU state: %d\n", err);
-			goto out_err;
-		}
-	}
-
-	err = hyp_init_aux_data();
-	if (err)
-		kvm_err("Cannot map host auxiliary data: %d\n", err);
-
+	hyp_init_aux_data();
 	return 0;
 
 out_err:
-- 
2.27.0

