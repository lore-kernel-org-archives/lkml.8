Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53434C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B3D2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="knovKfyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgDGOrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:47:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32952 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbgDGOrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:47:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay1so1347172plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 07:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bdvS3ImXktegIGIUSt7DM4X3H//vtPG1T5XbtOqEIxE=;
        b=knovKfyo4UZfNQvLumQh4YiND2YiuKKF1VEMXbmrk4DNL7JyU0zDLLAK12VKAzO69V
         No6OSJ5iiap2sww6JWv44GLP4xJ+EX6DctkaBBRIt1gJ4AIIO+Zny1L5JP+6vrtoyaGy
         5xVmUOuerxLVWASbltXa4kMFmXTwckiw+dW6hmMzOdB/P6s4VgwcW+hJObtRQdoNuLG4
         OiIbO+Ae757Uw9/9jPS3G+ZJT1DeYCWo7vXXQl1UaGlMOq5jwdNZuKfgz8VG0LatfZsc
         BtmTwRWewPKaw5Gj3ak0a9SFf3WY6jm4uRydCBo7ONIV/TeVBlkXGpJrsvxksFx6Mh4y
         J6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bdvS3ImXktegIGIUSt7DM4X3H//vtPG1T5XbtOqEIxE=;
        b=rim8AkHyp5wePeEekCT1Wz8jIfCCDxBK4b+DnNOiBQkmwi+7CLMfms2eahK/qfzhwQ
         MZPIaxeq2mEI9FY16O7His/eEOdxWUQ70WjHWdk9uPzQHjH8Eahy2jDQKSAPVmXao3Et
         Aw54hsoN0MbCfpZFosMZLbQxSLhTgRXBhD+jisqnPmxbFt6ME9p6vkpD04odcSmVtmIf
         kEk6vWL8Asi9VIaTZ+Cit5WCmSDUdUrqPXqHeWx43n2crOtM9cIdgSYvYPsEb/KIu7mH
         gjQgkPAY64c15QuDJUDxvfT2VOnzbP75YxbIbGHHVF0ZQdR/L0F0UQzIv7dkdjHQ+kGF
         47eg==
X-Gm-Message-State: AGi0PubjG3Ar8SbT6HSC7nY+sQbjPjya+VjfE+RNKusrZQDs1+HH79aK
        jJQw20Kmitvl3liH10VUAwoe0w==
X-Google-Smtp-Source: APiQypIjFwaw5F3CH133qsTVtPyL2XcdUIhQdqvu9Da4WywKjh+qJ7nnuc1kM1SSwgc9X3T8sZQNXw==
X-Received: by 2002:a17:90a:e387:: with SMTP id b7mr3168370pjz.93.1586270826426;
        Tue, 07 Apr 2020 07:47:06 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id y15sm14190093pfc.206.2020.04.07.07.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:47:06 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v4 4/9] riscv: add ARCH_HAS_SET_MEMORY support
Date:   Tue,  7 Apr 2020 22:46:49 +0800
Message-Id: <783cadc46560fe173ac4900f36375b511185887e.1586265122.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1586265122.git.zong.li@sifive.com>
References: <cover.1586265122.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add set_memory_ro/rw/x/nx architecture hooks to change the page
attribution.

Use own set_memory.h rather than generic set_memory.h
(i.e. include/asm-generic/set_memory.h), because we want to add other
function prototypes here.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/Kconfig                  |   1 +
 arch/riscv/include/asm/set_memory.h |  24 +++++
 arch/riscv/mm/Makefile              |   2 +-
 arch/riscv/mm/pageattr.c            | 150 ++++++++++++++++++++++++++++
 4 files changed, 176 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/set_memory.h
 create mode 100644 arch/riscv/mm/pageattr.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 39c93ddff0cb..9044e0dd95ea 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -59,6 +59,7 @@ config RISCV
 	select HAVE_EBPF_JIT if 64BIT
 	select EDAC_SUPPORT
 	select ARCH_HAS_GIGANTIC_PAGE
+	select ARCH_HAS_SET_MEMORY
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
 	select SPARSEMEM_STATIC if 32BIT
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
new file mode 100644
index 000000000000..79a810f0f38b
--- /dev/null
+++ b/arch/riscv/include/asm/set_memory.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2019 SiFive
+ */
+
+#ifndef _ASM_RISCV_SET_MEMORY_H
+#define _ASM_RISCV_SET_MEMORY_H
+
+/*
+ * Functions to change memory attributes.
+ */
+#ifdef CONFIG_MMU
+int set_memory_ro(unsigned long addr, int numpages);
+int set_memory_rw(unsigned long addr, int numpages);
+int set_memory_x(unsigned long addr, int numpages);
+int set_memory_nx(unsigned long addr, int numpages);
+#else
+static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
+static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
+static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
+static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
+#endif
+
+#endif /* _ASM_RISCV_SET_MEMORY_H */
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 814e16a8d68a..363ef01c30b1 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -7,7 +7,7 @@ endif
 
 obj-y += init.o
 obj-y += extable.o
-obj-$(CONFIG_MMU) += fault.o
+obj-$(CONFIG_MMU) += fault.o pageattr.o
 obj-y += cacheflush.o
 obj-y += context.o
 
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
new file mode 100644
index 000000000000..fcd59ef2835b
--- /dev/null
+++ b/arch/riscv/mm/pageattr.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2019 SiFive
+ */
+
+#include <linux/pagewalk.h>
+#include <asm/pgtable.h>
+#include <asm/tlbflush.h>
+#include <asm/bitops.h>
+
+struct pageattr_masks {
+	pgprot_t set_mask;
+	pgprot_t clear_mask;
+};
+
+static unsigned long set_pageattr_masks(unsigned long val, struct mm_walk *walk)
+{
+	struct pageattr_masks *masks = walk->private;
+	unsigned long new_val = val;
+
+	new_val &= ~(pgprot_val(masks->clear_mask));
+	new_val |= (pgprot_val(masks->set_mask));
+
+	return new_val;
+}
+
+static int pageattr_pgd_entry(pgd_t *pgd, unsigned long addr,
+			      unsigned long next, struct mm_walk *walk)
+{
+	pgd_t val = READ_ONCE(*pgd);
+
+	if (pgd_leaf(val)) {
+		val = __pgd(set_pageattr_masks(pgd_val(val), walk));
+		set_pgd(pgd, val);
+	}
+
+	return 0;
+}
+
+static int pageattr_p4d_entry(p4d_t *p4d, unsigned long addr,
+			      unsigned long next, struct mm_walk *walk)
+{
+	p4d_t val = READ_ONCE(*p4d);
+
+	if (p4d_leaf(val)) {
+		val = __p4d(set_pageattr_masks(p4d_val(val), walk));
+		set_p4d(p4d, val);
+	}
+
+	return 0;
+}
+
+static int pageattr_pud_entry(pud_t *pud, unsigned long addr,
+			      unsigned long next, struct mm_walk *walk)
+{
+	pud_t val = READ_ONCE(*pud);
+
+	if (pud_leaf(val)) {
+		val = __pud(set_pageattr_masks(pud_val(val), walk));
+		set_pud(pud, val);
+	}
+
+	return 0;
+}
+
+static int pageattr_pmd_entry(pmd_t *pmd, unsigned long addr,
+			      unsigned long next, struct mm_walk *walk)
+{
+	pmd_t val = READ_ONCE(*pmd);
+
+	if (pmd_leaf(val)) {
+		val = __pmd(set_pageattr_masks(pmd_val(val), walk));
+		set_pmd(pmd, val);
+	}
+
+	return 0;
+}
+
+static int pageattr_pte_entry(pte_t *pte, unsigned long addr,
+			      unsigned long next, struct mm_walk *walk)
+{
+	pte_t val = READ_ONCE(*pte);
+
+	val = __pte(set_pageattr_masks(pte_val(val), walk));
+	set_pte(pte, val);
+
+	return 0;
+}
+
+static int pageattr_pte_hole(unsigned long addr, unsigned long next,
+			     int depth, struct mm_walk *walk)
+{
+	/* Nothing to do here */
+	return 0;
+}
+
+const static struct mm_walk_ops pageattr_ops = {
+	.pgd_entry = pageattr_pgd_entry,
+	.p4d_entry = pageattr_p4d_entry,
+	.pud_entry = pageattr_pud_entry,
+	.pmd_entry = pageattr_pmd_entry,
+	.pte_entry = pageattr_pte_entry,
+	.pte_hole = pageattr_pte_hole,
+};
+
+static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
+			pgprot_t clear_mask)
+{
+	int ret;
+	unsigned long start = addr;
+	unsigned long end = start + PAGE_SIZE * numpages;
+	struct pageattr_masks masks = {
+		.set_mask = set_mask,
+		.clear_mask = clear_mask
+	};
+
+	if (!numpages)
+		return 0;
+
+	down_read(&init_mm.mmap_sem);
+	ret =  walk_page_range_novma(&init_mm, start, end, &pageattr_ops, NULL,
+				     &masks);
+	up_read(&init_mm.mmap_sem);
+
+	flush_tlb_kernel_range(start, end);
+
+	return ret;
+}
+
+int set_memory_ro(unsigned long addr, int numpages)
+{
+	return __set_memory(addr, numpages, __pgprot(_PAGE_READ),
+			    __pgprot(_PAGE_WRITE));
+}
+
+int set_memory_rw(unsigned long addr, int numpages)
+{
+	return __set_memory(addr, numpages, __pgprot(_PAGE_READ | _PAGE_WRITE),
+			    __pgprot(0));
+}
+
+int set_memory_x(unsigned long addr, int numpages)
+{
+	return __set_memory(addr, numpages, __pgprot(_PAGE_EXEC), __pgprot(0));
+}
+
+int set_memory_nx(unsigned long addr, int numpages)
+{
+	return __set_memory(addr, numpages, __pgprot(0), __pgprot(_PAGE_EXEC));
+}
-- 
2.26.0

