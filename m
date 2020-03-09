Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC8CC10F28
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8390B20863
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YS4VWjcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgCIIWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:22:46 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54334 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgCIIWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:22:43 -0400
Received: by mail-pj1-f68.google.com with SMTP id np16so4039832pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 01:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FB/FaS6maNFx1G9rifhLlVqm/rM7x/H1XFd6gLMSMDU=;
        b=YS4VWjcIzeXzEasAyfAvYoSY4xprd+s7Wos2ERuoNAlrVKG7Fx0HIv0sqNsBwuLcad
         YwyAQno4NvMm0cuwXi8xX4qbwAq24e9BHJULt7K4znUU1XTyqlpe4/Ku86KvfuBm5RCt
         JkXAfaFtDTKMpYAVjVpTcHdSaKRw6r17IZY8qKK3BkfD4ah5HbhY4k94YgkAPb42tUFk
         QHApoeA/VpcE5xNVrCm6RFlcxgAfGEurGZPdnxxhmmjqgAsptqKwrUCgUXJxVeTtp1gB
         ArQ3R3kgsumnWJy/3jts4vRoWOhf6l2rdrTcZSYOgn0gMGBTgB1qhIHnFh3N9tFad5dW
         H2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FB/FaS6maNFx1G9rifhLlVqm/rM7x/H1XFd6gLMSMDU=;
        b=mzoRePPHbP8oqQpUzPElg+6KL5m2jqSbZ62l4IAapI3r8zg8VKyrcF+aESPpPJAHCm
         4cm05gvr1L+WpZ3X0ApOAXuAOLWxIwTuQeWfrsH+fmxgbrfcnHp7Yd3uvNsTjChsbCOK
         KpwaZ7BSH6ww4AkMj8p4+qd+Uqx+t/Ca1C99FqDiwpuRQ+Z2F0HSQCWWzd2k+dfD5152
         ioNTbJ+8n+jFE4+VWTzNCC9KNLJf/kNafCQngKdjH4NqBqtUJp6K8dW5mYGUVXksqcLL
         XZOC/sWW3Do7XeyTI2GqYH9PN3W10IKRo/QTxdyqAQSf83RKiaJPpN3YcvjaaDqXUHcd
         AMlQ==
X-Gm-Message-State: ANhLgQ0GkkxQHTQpdltxzqWGylykoJ8T8cb/Rw5iFYPTIDvjO1wK9RfZ
        0WtyuXBpV790WDfDNt+E2od1GScvVIA=
X-Google-Smtp-Source: ADFU+vtYBlYnlDmnFgHYWW0c9/rw3sUEXeJnbKVGnTIceDYQXrhIh+B4aSQk5qInCE+mA6QZ1Hy5Tg==
X-Received: by 2002:a17:902:7d8f:: with SMTP id a15mr14993550plm.107.1583742161781;
        Mon, 09 Mar 2020 01:22:41 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id v5sm18364779pfn.64.2020.03.09.01.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 01:22:41 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 2/9] riscv: add ARCH_HAS_SET_DIRECT_MAP support
Date:   Mon,  9 Mar 2020 16:22:22 +0800
Message-Id: <3875093ee6a6e980919009bb86b7193def05e2e8.1583741997.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583741997.git.zong.li@sifive.com>
References: <cover.1583741997.git.zong.li@sifive.com>
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
index 76ed36543b3a..07bf1a7c0dd2 100644
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
index 936f08063566..a9783a878dca 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -14,4 +14,7 @@ int set_memory_rw(unsigned long addr, int numpages);
 int set_memory_x(unsigned long addr, int numpages);
 int set_memory_nx(unsigned long addr, int numpages);
 
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

