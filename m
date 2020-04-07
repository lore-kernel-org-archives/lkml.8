Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAF8C2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F78C20747
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Z95WsXja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgDGOrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:47:39 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36571 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729275AbgDGOrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:47:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id g2so1334939plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 07:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1qkEQ73ghM61/BXRvlDJEs7SEg6hkPYIpkfLFdxJqkM=;
        b=Z95WsXjaZ4R1OiZAjtFWozqj9735nUzepdNDu+Rm+ykKmZ1QhMW1WXzh4mh+TxtIUE
         3up1bhUw0eoHYPS2z8u6Mz4s5j4A2KaKT+b3o5aWzvtjB2dNihRQ+qXe8mFuGaUjOb7e
         PHR/jKA1Ybc0M0HAbqxdcQ4Id/syAJDH5PBKE8wm9I8phudmq4vsXT6ifv3WXy0nXAIB
         AH2lCtDzZ8wqQyWQ5t3ZAaLK/NdSJoIrbi78EcorwBkK9t45hMs/R6/CQqwUJ3hI8RZL
         W9QEv1DPVnBiArLheGHAnGn1vDRriUf+GqOdmk4bKQW2fK7NCvaaEyPjormnBQMmeELy
         Pchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1qkEQ73ghM61/BXRvlDJEs7SEg6hkPYIpkfLFdxJqkM=;
        b=ZHGF7sw/pAZ/SGM/OU2FMTPRKe3UCLSUjBE9yfSBOypBd395cGistjeY0aS0nGVna5
         WtAFeXkDRh0Gwfa4CNNt9NKi/gWqLB3gntpXf5XWC6QRyj7MevCRtL5BsveunWoT/LWy
         qHOUXr2nJ/SEk3hiVoPrlMFGDVgFH1yj2bczcSZuaGc+L1xqtzOdKT1TT8xQ4326FgOn
         QBSTQnrmHsfuoYVKW7lsT6ub6vmLYY+8hcQ2zVB9HBjq4PUTh06Y35FYugz96p26JnYY
         KyvXE1Co18vE1EzvdL9zgzrRScvkd2Lc03BdUPu8/nVe52qc2kLU8NZTDu/MzSSXozdD
         I3hA==
X-Gm-Message-State: AGi0PuZ5TyyRaxGMNRpMDgDL6sR0kzt2ENkextHTCJOSMzWH/k7mla7o
        RwocN9k1T3bD6AVugT/efR6JqQ==
X-Google-Smtp-Source: APiQypL0QZL2CpYGkPcslhSMRE9aqJtSat2xKN9cJ0wG3hkbm7awrwBq0Y0CDoR4ztQTWLcG3pAU6A==
X-Received: by 2002:a17:902:8609:: with SMTP id f9mr2675736plo.203.1586270828988;
        Tue, 07 Apr 2020 07:47:08 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id y15sm14190093pfc.206.2020.04.07.07.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:47:08 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v4 5/9] riscv: add ARCH_HAS_SET_DIRECT_MAP support
Date:   Tue,  7 Apr 2020 22:46:50 +0800
Message-Id: <1b9ab6009c1d70451e21a35ed7fea47c139bc65f.1586265122.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1586265122.git.zong.li@sifive.com>
References: <cover.1586265122.git.zong.li@sifive.com>
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
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/Kconfig                  |  1 +
 arch/riscv/include/asm/set_memory.h |  3 +++
 arch/riscv/mm/pageattr.c            | 24 ++++++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 9044e0dd95ea..a94d0f064d9c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -59,6 +59,7 @@ config RISCV
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
2.26.0

