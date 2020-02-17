Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AB0C7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A1C20801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eQQeKcdM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgBQIcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:32:42 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34097 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgBQIcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:32:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id i6so8457816pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 00:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QTMbWbDe6JanNw6u4MeuGT5ws10dOAmOeRDr+Sp99wY=;
        b=eQQeKcdMqubXH5C7G7os3FSraqPPJ10JrzYI9+flCRSLyytHFSVXYxzijDY19pTj5H
         1L1Q0IEJsKliwl3DumyPauUq4BjxxOzKgoqaH2mv8FgIUboZZ6h4rF4lpcJAm0HXyN3F
         LFP5Mk1B89rkT0Fj6znGrUwA+q7ulC87QPS5zpAwrddum3cqjEUZlHvG3faZvElwiNpw
         FeXa2/dxwVYuHCggoDQ4avz/+x8RgCPRzpARtEv2Wg8ETFs5708/I+gKsJ21ZnA5qa5o
         Wrpo8rYWvQGWcW9e4jE6C1wW8SgK92RpLMk75nFdUKISuRyZmCsiNulyoFE9SMIY+Nwp
         wwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QTMbWbDe6JanNw6u4MeuGT5ws10dOAmOeRDr+Sp99wY=;
        b=G5V9l0MnFvYYSekO+MlezUjRHSMKpYUXNwvRDpgb8UWzrlzIeWwo9EopCK4u4ab1GA
         zulq7k/W7YWshet4QQu1owYSE9mAlfTIb1XxBL8i2cBojmOTVdvVYfwNnA3kvj/0UqZC
         9QC9hPcganEvkFxKDs3rHmx/XybKG/en3H/+3tk2r/Cf5zk/GGDkABw9ULQ0DlRTUuOF
         0uE3ovpJyEGeiy4mcEiXEXKoGodDDVGTG9GN5koKbPJnOWEYb8L7q9xbvhxBgLrB/Oea
         ZIMZglXUNEokk+vRTM/+24h8n9870mziFdA/cjzLjGHq51ChIkmbjoOOMriMdvlbEz9k
         GEpg==
X-Gm-Message-State: APjAAAV/VZ/gZab9rqZiUVYCQyYo614pus0MZtTVDHiOiX6vBHwS+AC6
        0UmgvB9JHy+aKTmSgto+QfRpfg==
X-Google-Smtp-Source: APXvYqwEo9hQppMoVvCzBwoZ7FwJSMTjAKclQg2rNt8CO271V0G0hmme0StOIdWiQD9cwM2p1VKfYg==
X-Received: by 2002:a63:3449:: with SMTP id b70mr16648042pga.242.1581928359090;
        Mon, 17 Feb 2020 00:32:39 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id z10sm16989319pgz.88.2020.02.17.00.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 00:32:38 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 6/8] riscv: add STRICT_KERNEL_RWX support
Date:   Mon, 17 Feb 2020 16:32:21 +0800
Message-Id: <20200217083223.2011-7-zong.li@sifive.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217083223.2011-1-zong.li@sifive.com>
References: <20200217083223.2011-1-zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit contains that make text section as non-writable, rodata
section as read-only, and data section as non-executable.

The init section should be changed to non-executable.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/Kconfig                  |  1 +
 arch/riscv/include/asm/set_memory.h |  8 +++++
 arch/riscv/mm/init.c                | 45 +++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index f524d7e60648..308a4dbc0b39 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -62,6 +62,7 @@ config RISCV
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_SET_MEMORY
+	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
 	select SPARSEMEM_STATIC if 32BIT
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
index a91f192063c2..d3076087cb34 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -15,6 +15,14 @@ int set_memory_rw(unsigned long addr, int numpages);
 int set_memory_x(unsigned long addr, int numpages);
 int set_memory_nx(unsigned long addr, int numpages);
 
+#ifdef CONFIG_STRICT_KERNEL_RWX
+void set_kernel_text_ro(void);
+void set_kernel_text_rw(void);
+#else
+static inline void set_kernel_text_ro(void) { }
+static inline void set_kernel_text_rw(void) { }
+#endif
+
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 965a8cf4829c..09fa643e079c 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -12,11 +12,13 @@
 #include <linux/sizes.h>
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
+#include <linux/set_memory.h>
 
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
 #include <asm/pgtable.h>
+#include <asm/ptdump.h>
 #include <asm/io.h>
 
 #include "../kernel/head.h"
@@ -477,6 +479,49 @@ static void __init setup_vm_final(void)
 	csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | SATP_MODE);
 	local_flush_tlb_all();
 }
+
+#ifdef CONFIG_STRICT_KERNEL_RWX
+void set_kernel_text_rw(void)
+{
+	unsigned long text_start = (unsigned long)_text;
+	unsigned long text_end = (unsigned long)_etext;
+
+	set_memory_rw(text_start, (text_end - text_start) >> PAGE_SHIFT);
+}
+
+void set_kernel_text_ro(void)
+{
+	unsigned long text_start = (unsigned long)_text;
+	unsigned long text_end = (unsigned long)_etext;
+
+	set_memory_ro(text_start, (text_end - text_start) >> PAGE_SHIFT);
+}
+
+void mark_rodata_ro(void)
+{
+	unsigned long text_start = (unsigned long)_text;
+	unsigned long text_end = (unsigned long)_etext;
+	unsigned long rodata_start = (unsigned long)__start_rodata;
+	unsigned long data_start = (unsigned long)_sdata;
+	unsigned long max_low = (unsigned long)(__va(PFN_PHYS(max_low_pfn)));
+
+	set_memory_ro(text_start, (text_end - text_start) >> PAGE_SHIFT);
+	set_memory_ro(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
+	set_memory_nx(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
+	set_memory_nx(data_start, (max_low - data_start) >> PAGE_SHIFT);
+}
+#endif
+
+void free_initmem(void)
+{
+	unsigned long init_begin = (unsigned long)__init_begin;
+	unsigned long init_end = (unsigned long)__init_end;
+
+	/* Make the region as non-execuatble. */
+	set_memory_nx(init_begin, (init_end - init_begin) >> PAGE_SHIFT);
+	free_initmem_default(POISON_FREE_INITMEM);
+}
+
 #else
 asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 {
-- 
2.25.0

