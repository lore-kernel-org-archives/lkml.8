Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFB4C7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35D420836
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BNGkX/+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgBQIcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:32:36 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33816 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbgBQIcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:32:33 -0500
Received: by mail-pl1-f196.google.com with SMTP id j7so6423990plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 00:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QV05nl1zAojbiLTVKnGFtXrM2l5IHlEM0aaK8Qpllr0=;
        b=BNGkX/+PNF9RrOz6P/Y6buFJK2xKWgREEdOZvQ+I1uGvbmA6GCcw5m7IrkzMBUJwab
         KJpUCn9lE8gwmhWqZI/C/5Xao5cBTD/fPTfRhvMN0pXBmxWTDI84GO7oHsXURPJsu2TF
         ym4mvOQdmPj9/utlRvsanB8cgN9dD6seW49s14szKlYozUXNR0MJY9zqJ5y5enlWJsdk
         Bs4WhCnozkqTT6VcA3pJkCeX6sYW1e8zDO0BCAkMeNuZrD7mgPZK8EKxyZoKMmy6CyLG
         axVCXifesrfol+pHH6KaJlfQvSYpuRy64DeAwabzTfFZ5WLxxlwM2AZoNU2P4/IhSTwq
         M2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QV05nl1zAojbiLTVKnGFtXrM2l5IHlEM0aaK8Qpllr0=;
        b=k0oG4Ii4JQ9Pqx3CoXlryAXo+9oZFdWU+Uh7rP87bLssjtjAXZRpzvi1IwTyEvJHGG
         7z+5TFP5yqJCCiAxPv5MFGTG3L2/Qdw2F44LSvOmo+/RYLJmnUBSqhHGxB03wXjuZ8RG
         Ofa+C/Y7vk6cAdKE43mnJ4yJD80sFoWo2O1d5v5Iqh+9gltaMBdwFOXKqTPAn8J5Ykyr
         +zuzAthwF8QgzSKp/5MHbdd0Ke7SeQkJaulxw7uPHWJ+UULJnrQhgX91Ndp1eZeO4blT
         XQ7WL/gKYFFj9m/EqNJBRRo8FEeB28jKY5bTaHCbFRvYS6DMV3RB4YMWlJ6ic+NvaFbB
         V6TQ==
X-Gm-Message-State: APjAAAXQ9iFRdtnWQcO1S0gp4HN67tHZxIprtCaGYnFTxiMWxN4Itj7B
        WrGCaCt6Kf6gf7j94CkDKOlNNA==
X-Google-Smtp-Source: APXvYqydROiyBhUZtlVN72Fe7TPNNBjcp6x58zxguFrmVQMWPOO9xgPGygDk/r8mmo8ephQKtYQ0gA==
X-Received: by 2002:a17:90a:191:: with SMTP id 17mr18926233pjc.88.1581928352545;
        Mon, 17 Feb 2020 00:32:32 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id z10sm16989319pgz.88.2020.02.17.00.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 00:32:32 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 2/8] riscv: add ARCH_HAS_SET_DIRECT_MAP support
Date:   Mon, 17 Feb 2020 16:32:17 +0800
Message-Id: <20200217083223.2011-3-zong.li@sifive.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217083223.2011-1-zong.li@sifive.com>
References: <20200217083223.2011-1-zong.li@sifive.com>
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
2.25.0

