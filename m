Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA90C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61492075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TtvzXxSJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgDGOrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:47:22 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38371 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbgDGOrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:47:18 -0400
Received: by mail-pj1-f65.google.com with SMTP id m15so856379pje.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 07:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E4WIiXeGbKDxs9UbyyfZOjVgyCJTWA/AduHG+mw3Ozg=;
        b=TtvzXxSJ0vpaB0ZG++G2fkPig6AtFEsttCjqY2Xvv9MaF0/H7Z/pUc+9b4ouCtetSj
         4120O3V+N+4RGONMM6wYETKEPPwBodh7xtC8Aeat9tSSrhoRmifL+6stENNVtQwsGgn4
         4qdDIhygGHzmwFk2y8DpRVDHh5WpmIDnqHRLSWxY83gDpKpJjWbZh7S7P9kq1Ks1kXxI
         b3Qe2gvh2ejACDVV9xe+XJV40SBNBlygiUBuFR/PU+9KbIRTWi5fg15zt3eVXvMTByU+
         xzW7/AEiuPvSp7AYkSo4O/lwLVRR/E/a40w/7WqVXe6vnpHdE8iaICEgw4NRtXQ3zqjW
         W6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E4WIiXeGbKDxs9UbyyfZOjVgyCJTWA/AduHG+mw3Ozg=;
        b=CUIvox9mXUXQChntcXYB3laa11VLec78jN03DypySeHanexTj6PFoPBfGDOoWr6cFt
         6EC2z/24wDFwuNkrKjmss++Zp4tCRztal7z7k11eGgAY55/JRA9mfubKTQuC2XYJjXiO
         cttpuCv+huRaUDg/0ApjHm+KjGeaU6EqScK0b2i89A6g04r6W/aaBUhYpdTP5E3fhVjM
         cah7+EMqX/z5/sfrzjKy930qdydrFBiuEmpcdU0i/54bQQWTDDW4gL1iS9edOvGWoaqP
         8ZlcaAIZk1jFPo+qwv1koGmxdIBGFiSfd2/FTXM0BA7tAHfAlQ8jcOSVpsdnCPEd7kjV
         3iIw==
X-Gm-Message-State: AGi0PuYrkG8utcpggfZMJnj4vtu1+uCVE1aOvRU2PzVo94qd6pXKTMEO
        wDZpYBgQYoJqMv4zvr/K0EI/HA==
X-Google-Smtp-Source: APiQypJUKWF94J6ayuHjup8iitIs5Pg3Mufg8IUFflYhlm4L0XY+598UDR5xW3cZS1qS1UmEjpbxIw==
X-Received: by 2002:a17:90a:c207:: with SMTP id e7mr3190940pjt.117.1586270837136;
        Tue, 07 Apr 2020 07:47:17 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id y15sm14190093pfc.206.2020.04.07.07.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:47:16 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v4 9/9] riscv: add STRICT_KERNEL_RWX support
Date:   Tue,  7 Apr 2020 22:46:54 +0800
Message-Id: <933a02ac01c1ac2a5c174474d46da12e8db96d63.1586265122.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1586265122.git.zong.li@sifive.com>
References: <cover.1586265122.git.zong.li@sifive.com>
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

