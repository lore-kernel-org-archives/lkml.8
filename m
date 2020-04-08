Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9727C2BA16
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF9220771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TOZYTN0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgDHH5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:57:30 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33055 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbgDHH52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 03:57:28 -0400
Received: by mail-pj1-f66.google.com with SMTP id cp9so1952645pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 00:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E4WIiXeGbKDxs9UbyyfZOjVgyCJTWA/AduHG+mw3Ozg=;
        b=TOZYTN0ZmTo7tkdrjh0d1AhqQRXNkDEiNfrJu4HSuIaIiOkXzgv343+X9uduChlxuH
         5GPD/mmxsXBoBB14GTJKfsYkmdbX+iUL+dCVfbt+u75yXYegqNi1SrMLOcTYAi4T88lv
         qtT4EPWIizz8lTpXFwCmAj5VEUJfA30aJ5B+himyfvXRvcepspXbnZEigEMTMyxBRsI1
         rCfbOUbOO2fuhdV2fehBFtONQJoNk61FccNMvakWX+2TCphrgANZ1IFSPA42eCeWa9OG
         M+RbsCIz3G7evFBUt61IGLqkg9rI5gPYiJuMTj5URYLiZTZW/IrnKhHTcL/h5ex2W4c1
         2vRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E4WIiXeGbKDxs9UbyyfZOjVgyCJTWA/AduHG+mw3Ozg=;
        b=drAT3cDZ9RWWUtVeBk06ZXpajPno+IkJeRs85YRSoonkqom2VHaglcNio3DqAjD/Nc
         QGR5AYfGNMlx6L6Or5aLnwanxrVFpc5GjL4a5cg3tjz0YFvRHPoJZoY3S64LzM2RfXmf
         zRWxTil59GSn4IrtvESFDkncLmU8pN9Omrtl1QYihAmrL5rPlnGG/AOy1FoKJR24YEYK
         AYwQ2Gwct3i1MvNidvAP01Ftj2L5EkklIsDUys6vbTSpJ8itg7zkeACyg/0iK7khcAKA
         eSBWosfAn6vh/4yFNnP5pyL2q0H7aLQ/vxdYMWFZepgPYhInymCSKKNRrcSIh3S674r2
         KNSQ==
X-Gm-Message-State: AGi0PuZLTzexvEw7CAQR1fGc/iRu9yxWHEEQ7skLYunAEEwZUE4AJHg9
        fL7fCgRmGKHy0X4pdQqHSpP2xw==
X-Google-Smtp-Source: APiQypIgaMKX49GV/U1HjE4l3Up0jhdZCobmLhyfkuxFpjq9sh+MzskfqRAcr1tN8QgE7gggnLep2w==
X-Received: by 2002:a17:90a:714b:: with SMTP id g11mr3741642pjs.17.1586332646601;
        Wed, 08 Apr 2020 00:57:26 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id d85sm485599pfd.157.2020.04.08.00.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 00:57:26 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v5 9/9] riscv: add STRICT_KERNEL_RWX support
Date:   Wed,  8 Apr 2020 15:57:04 +0800
Message-Id: <100e739c5fd722a96fcc640c8ee0c82fe34fcb6a.1586332296.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1586332296.git.zong.li@sifive.com>
References: <cover.1586332296.git.zong.li@sifive.com>
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
 arch/riscv/include/asm/set_memory.h |  8 ++++++
 arch/riscv/mm/init.c                | 44 +++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 1e1efc998baf..58b556167d59 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -61,6 +61,7 @@ config RISCV
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_SET_MEMORY
+	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
 	select SPARSEMEM_STATIC if 32BIT
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
index 4c5bae7ca01c..c38df4771c09 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -22,6 +22,14 @@ static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
 #endif
 
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
index fab855963c73..b55be44ff9bd 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -12,6 +12,7 @@
 #include <linux/sizes.h>
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
+#include <linux/set_memory.h>
 
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
@@ -477,6 +478,17 @@ static void __init setup_vm_final(void)
 	csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | SATP_MODE);
 	local_flush_tlb_all();
 }
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
@@ -488,6 +500,38 @@ static inline void setup_vm_final(void)
 }
 #endif /* CONFIG_MMU */
 
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
+	unsigned long data_start = (unsigned long)_data;
+	unsigned long max_low = (unsigned long)(__va(PFN_PHYS(max_low_pfn)));
+
+	set_memory_ro(text_start, (text_end - text_start) >> PAGE_SHIFT);
+	set_memory_ro(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
+	set_memory_nx(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
+	set_memory_nx(data_start, (max_low - data_start) >> PAGE_SHIFT);
+}
+#endif
+
 void __init paging_init(void)
 {
 	setup_vm_final();
-- 
2.26.0

