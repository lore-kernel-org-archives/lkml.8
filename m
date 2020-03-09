Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA77CC18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A384D20828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BbPLO03d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgCIQz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:55:58 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51918 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbgCIQz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:55:56 -0400
Received: by mail-pj1-f67.google.com with SMTP id y7so114985pjn.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 09:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vHHEfisV2sac3yFCwT8HncLiEjhV+vQXrDf+i+Lfo5s=;
        b=BbPLO03dyCa+SyiNdur03wskOA1e08hVCPGslDAS1VUBdOVZO6yyoMP9lPpTBQcmcs
         YIJMzo/kcYik2akSNkRjdEXgA6A68YhK0XKtJV+feTLUp2TBVgslgOYf4DU/h73984p6
         Lr39AvgO+AMKpJzkJXt4oHLkSiIPda9FtnVTpg909nn54MLvY8BPlnAWnAhjblrg/bni
         iJLQY1p2iilrIfTO3xwxe7Q2FfX4JGSfIQbRFSwjgKdBddKQl/bk1JaUDPiMLppDiGly
         qJMb+e5NkKIKt9emfqKxAqjXalN22WWABKOrz4V0ZGPAfQARUw10zya+lHoq9lqFhWXZ
         2RWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vHHEfisV2sac3yFCwT8HncLiEjhV+vQXrDf+i+Lfo5s=;
        b=m2UxCP0tbd0oczb84BKfMDTE93DcTDH2VeX01ax35wdi9R6WFEDcrjJI1XwCdB3KEF
         bB/MQnm3PaZqlF8ZxSFRbfS7N3ebf6qeWOz66VLiO5FU2/GAbzv31te3tYM3NuQEcnxJ
         JBBVHpp0Fbi8Y62hBfKaOV+nRmHOVsC1yS5ZNL+n76CpyVwSNE8OV05fyKXjwArZBIvD
         MOJAhD6uKDbbjviEo5m4CUXhY0EeXWKyqiGFTHIAmk7Q5z9GcJBtExCKafZZ7IK3A9yd
         odmfbH0IS9NNp/y64q0SdX1cOCrhQy9DZ9/cGeTrci/OfvAIApS21pz6bO+F5lF03GY3
         f5kA==
X-Gm-Message-State: ANhLgQ3UELyl5BX/Fjive7VNYR0NoJOd4FJYufH3d0SyeFENgaFSgDxA
        Nwu+OX3bocVsMLYH9Vbm0WILMw==
X-Google-Smtp-Source: ADFU+vugSzzgoz7P/m6okoBnNDkn/m4RKfS4UaZxqEjoQ8tY5gOY5KCpG8thfmum+g91BYz9JrNrNw==
X-Received: by 2002:a17:902:a409:: with SMTP id p9mr17015682plq.211.1583772955012;
        Mon, 09 Mar 2020 09:55:55 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id cm2sm104013pjb.23.2020.03.09.09.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 09:55:54 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 2/9] riscv: add ARCH_HAS_SET_DIRECT_MAP support
Date:   Tue, 10 Mar 2020 00:55:37 +0800
Message-Id: <e9850f9bf5a38be492fd57bbd5f1d7f8f7578cc5.1583772574.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583772574.git.zong.li@sifive.com>
References: <cover.1583772574.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add set_direct_map_*() functions for setting the direct map alias for
the page to its default permissions and to an invalid state that cannot
be cached in a TLB. (See d253ca0c ("x86/mm/cpa: Add set_direct_map_*()
functions")) Add a similar implementation for RISC-V.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/Kconfig                  |  1 +
 arch/riscv/include/asm/set_memory.h |  3 +++
 arch/riscv/mm/pageattr.c            | 24 ++++++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 9ab592aa1b5f..71fabb0ffdbe 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -60,6 +60,7 @@ config RISCV
 	select HAVE_EBPF_JIT if 64BIT
 	select EDAC_SUPPORT
 	select ARCH_HAS_GIGANTIC_PAGE
+	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
 	select SPARSEMEM_STATIC if 32BIT
diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
index 79a810f0f38b..620d81c372d9 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -21,4 +21,7 @@ static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
 #endif
 
+int set_direct_map_invalid_noflush(struct page *page);
+int set_direct_map_default_noflush(struct page *page);
+
 #endif /* _ASM_RISCV_SET_MEMORY_H */
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index fcd59ef2835b..7be6cd67e2ef 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -148,3 +148,27 @@ int set_memory_nx(unsigned long addr, int numpages)
 {
 	return __set_memory(addr, numpages, __pgprot(0), __pgprot(_PAGE_EXEC));
 }
+
+int set_direct_map_invalid_noflush(struct page *page)
+{
+	unsigned long start = (unsigned long)page_address(page);
+	unsigned long end = start + PAGE_SIZE;
+	struct pageattr_masks masks = {
+		.set_mask = __pgprot(0),
+		.clear_mask = __pgprot(_PAGE_PRESENT)
+	};
+
+	return walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
+}
+
+int set_direct_map_default_noflush(struct page *page)
+{
+	unsigned long start = (unsigned long)page_address(page);
+	unsigned long end = start + PAGE_SIZE;
+	struct pageattr_masks masks = {
+		.set_mask = PAGE_KERNEL,
+		.clear_mask = __pgprot(0)
+	};
+
+	return walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
+}
-- 
2.25.1

