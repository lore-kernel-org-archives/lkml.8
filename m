Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A55C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CE322078D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r3Pq4Nw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbgHNR23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgHNR2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:28:14 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A4EC061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:13 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id d6so3591552wrv.23
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Riwx46dUdQZCUBoIKFQK30aeY6nxibjjbFZQvhGTSVk=;
        b=r3Pq4Nw/CaoWG6G6om2TkSeS2q3clDVrI1jCJZUuPgJWrFW56RmBaxQJTKiw8RDwkv
         SXknHXxNubQ/xsH4JUduXI8P7Ao0rNKHTmxWSLd6+rR3L+eMVGvfYsQZCNJcqno+0SvU
         tQTCc0IaZnYqxsGgZIWb6dR600zBkz4ATNFlZXN0oodOskMVMbwApFhSiSS8Hc5kEo1o
         2keQXF4RswsJN9aziL4F/HMIxE1tLyJyZehyXq70N4BsfEQC2/qJApII530XcFa6vDo9
         umF+SAHHeQEUyeUJl91ZaJnkzhY9dZLQUxwtVJNYU4o96vxe2Ib/F+vtqvgmZyDaI9I/
         HVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Riwx46dUdQZCUBoIKFQK30aeY6nxibjjbFZQvhGTSVk=;
        b=RHYRnOWPv/lY25tY+4Z9k28BaQUUOXI4TFdI3dun4QhGj5noI+OcmUClF80sCCZbDz
         tFjy0vm69PQ7z88vbQeokxa9/eBAzDsiF6oId9ha3SFaep9QHLB3Bz9NrNxSUypKGavv
         6dXuiz4WxdpcOMdkwc4impOCf/V1hK95yDxWFUBaQWUupPxE5hwfesQJErSxmYrKKDp/
         +fp2nlSHv89uA53oFsfWjJZXctYQWQ/VW7EOAnBXEEqDFo51yjm7JIzuFBq9wPl72sXJ
         kV7C1sTPdbOxvDM5PSTrb+gmlT4mYjTmrcyGA1+6xmfM0Yzu1oaBAy6lDj0FHBH3/Utl
         jjOg==
X-Gm-Message-State: AOAM5324p9/R0FRHfSuomuGpvbUGZRxxwPn6Bt6Ug7xcWxepDFcxb3pk
        /hdAqzZqTADNN652nS249uewzQ55EzSyiXHr
X-Google-Smtp-Source: ABdhPJw/jNH9QPIZc2t+4rbadjLlOE44b7TKGySp7yNB+Ni/K8pn2eaB/l/BXc2r60vcjhzOsBbB8v3UAMZ+9JJW
X-Received: by 2002:a05:600c:c3:: with SMTP id u3mr424057wmm.1.1597426091488;
 Fri, 14 Aug 2020 10:28:11 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:27:02 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <2cf260bdc20793419e32240d2a3e692b0adf1f80.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 20/35] arm64: mte: Add in-kernel MTE helpers
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

Provide helper functions to manipulate allocation and pointer tags for
kernel addresses.

Low-level helper functions (mte_assign_*, written in assembly) operate
tag values from the [0x0, 0xF] range. High-level helper functions
(mte_get/set_*) use the [0xF0, 0xFF] range to preserve compatibility
with normal kernel pointers that have 0xFF in their top byte.

MTE_GRANULE_SIZE definition is moved to mte_asm.h header that doesn't
have any dependencies and is safe to include into any low-level header.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Co-developed-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/esr.h     |  1 +
 arch/arm64/include/asm/mte.h     | 46 +++++++++++++++++++++++++++++---
 arch/arm64/include/asm/mte_asm.h | 10 +++++++
 arch/arm64/kernel/mte.c          | 43 +++++++++++++++++++++++++++++
 arch/arm64/lib/mte.S             | 41 ++++++++++++++++++++++++++++
 5 files changed, 138 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/include/asm/mte_asm.h

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 035003acfa87..bc0dc66a6a27 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -103,6 +103,7 @@
 #define ESR_ELx_FSC		(0x3F)
 #define ESR_ELx_FSC_TYPE	(0x3C)
 #define ESR_ELx_FSC_EXTABT	(0x10)
+#define ESR_ELx_FSC_MTE		(0x11)
 #define ESR_ELx_FSC_SERROR	(0x11)
 #define ESR_ELx_FSC_ACCESS	(0x08)
 #define ESR_ELx_FSC_FAULT	(0x04)
diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 1c99fcadb58c..733be1cb5c95 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -5,14 +5,19 @@
 #ifndef __ASM_MTE_H
 #define __ASM_MTE_H
 
-#define MTE_GRANULE_SIZE	UL(16)
+#include <asm/mte_asm.h>
+
 #define MTE_GRANULE_MASK	(~(MTE_GRANULE_SIZE - 1))
 #define MTE_TAG_SHIFT		56
 #define MTE_TAG_SIZE		4
+#define MTE_TAG_MASK		GENMASK((MTE_TAG_SHIFT + (MTE_TAG_SIZE - 1)), MTE_TAG_SHIFT)
+#define MTE_TAG_MAX		(MTE_TAG_MASK >> MTE_TAG_SHIFT)
 
 #ifndef __ASSEMBLY__
 
+#include <linux/bitfield.h>
 #include <linux/page-flags.h>
+#include <linux/types.h>
 
 #include <asm/pgtable-types.h>
 
@@ -45,7 +50,16 @@ long get_mte_ctrl(struct task_struct *task);
 int mte_ptrace_copy_tags(struct task_struct *child, long request,
 			 unsigned long addr, unsigned long data);
 
-#else
+void *mte_assign_valid_ptr_tag(void *ptr);
+void *mte_assign_random_ptr_tag(void *ptr);
+void mte_assign_mem_tag_range(void *addr, size_t size);
+
+#define mte_get_ptr_tag(ptr)	((u8)(((u64)(ptr)) >> MTE_TAG_SHIFT))
+u8 mte_get_mem_tag(void *addr);
+u8 mte_get_random_tag(void);
+void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag);
+
+#else /* CONFIG_ARM64_MTE */
 
 /* unused if !CONFIG_ARM64_MTE, silence the compiler */
 #define PG_mte_tagged	0
@@ -80,7 +94,33 @@ static inline int mte_ptrace_copy_tags(struct task_struct *child,
 	return -EIO;
 }
 
-#endif
+static inline void *mte_assign_valid_ptr_tag(void *ptr)
+{
+	return ptr;
+}
+static inline void *mte_assign_random_ptr_tag(void *ptr)
+{
+	return ptr;
+}
+static inline void mte_assign_mem_tag_range(void *addr, size_t size)
+{
+}
+
+#define mte_get_ptr_tag(ptr)	0xFF
+static inline u8 mte_get_mem_tag(void *addr)
+{
+	return 0xFF;
+}
+static inline u8 mte_get_random_tag(void)
+{
+	return 0xFF;
+}
+static inline void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
+{
+	return addr;
+}
+
+#endif /* CONFIG_ARM64_MTE */
 
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_MTE_H  */
diff --git a/arch/arm64/include/asm/mte_asm.h b/arch/arm64/include/asm/mte_asm.h
new file mode 100644
index 000000000000..aa532c1851e1
--- /dev/null
+++ b/arch/arm64/include/asm/mte_asm.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 ARM Ltd.
+ */
+#ifndef __ASM_MTE_ASM_H
+#define __ASM_MTE_ASM_H
+
+#define MTE_GRANULE_SIZE	UL(16)
+
+#endif /* __ASM_MTE_ASM_H  */
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index eb39504e390a..e2d708b4583d 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -13,8 +13,10 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/thread_info.h>
+#include <linux/types.h>
 #include <linux/uio.h>
 
+#include <asm/barrier.h>
 #include <asm/cpufeature.h>
 #include <asm/mte.h>
 #include <asm/ptrace.h>
@@ -72,6 +74,47 @@ int memcmp_pages(struct page *page1, struct page *page2)
 	return ret;
 }
 
+u8 mte_get_mem_tag(void *addr)
+{
+	if (system_supports_mte())
+		addr = mte_assign_valid_ptr_tag(addr);
+
+	return 0xF0 | mte_get_ptr_tag(addr);
+}
+
+u8 mte_get_random_tag(void)
+{
+	u8 tag = 0xF;
+
+	if (system_supports_mte())
+		tag = mte_get_ptr_tag(mte_assign_random_ptr_tag(NULL));
+
+	return 0xF0 | tag;
+}
+
+void * __must_check mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
+{
+	void *ptr = addr;
+
+	if ((!system_supports_mte()) || (size == 0))
+		return addr;
+
+	tag = 0xF0 | (tag & 0xF);
+	ptr = (void *)__tag_set(ptr, tag);
+	size = ALIGN(size, MTE_GRANULE_SIZE);
+
+	mte_assign_mem_tag_range(ptr, size);
+
+	/*
+	 * mte_assign_mem_tag_range() can be invoked in a multi-threaded
+	 * context, ensure that tags are written in memory before the
+	 * reference is used.
+	 */
+	smp_wmb();
+
+	return ptr;
+}
+
 static void update_sctlr_el1_tcf0(u64 tcf0)
 {
 	/* ISB required for the kernel uaccess routines */
diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
index 03ca6d8b8670..8c743540e32c 100644
--- a/arch/arm64/lib/mte.S
+++ b/arch/arm64/lib/mte.S
@@ -149,3 +149,44 @@ SYM_FUNC_START(mte_restore_page_tags)
 
 	ret
 SYM_FUNC_END(mte_restore_page_tags)
+
+/*
+ * Assign pointer tag based on the allocation tag
+ *   x0 - source pointer
+ * Returns:
+ *   x0 - pointer with the correct tag to access memory
+ */
+SYM_FUNC_START(mte_assign_valid_ptr_tag)
+	ldg	x0, [x0]
+	ret
+SYM_FUNC_END(mte_assign_valid_ptr_tag)
+
+/*
+ * Assign random pointer tag
+ *   x0 - source pointer
+ * Returns:
+ *   x0 - pointer with a random tag
+ */
+SYM_FUNC_START(mte_assign_random_ptr_tag)
+	irg	x0, x0
+	ret
+SYM_FUNC_END(mte_assign_random_ptr_tag)
+
+/*
+ * Assign allocation tags for a region of memory based on the pointer tag
+ *   x0 - source pointer
+ *   x1 - size
+ *
+ * Note: size is expected to be MTE_GRANULE_SIZE aligned
+ */
+SYM_FUNC_START(mte_assign_mem_tag_range)
+	/* if (src == NULL) return; */
+	cbz	x0, 2f
+	/* if (size == 0) return; */
+	cbz	x1, 2f
+1:	stg	x0, [x0]
+	add	x0, x0, #MTE_GRANULE_SIZE
+	sub	x1, x1, #MTE_GRANULE_SIZE
+	cbnz	x1, 1b
+2:	ret
+SYM_FUNC_END(mte_assign_mem_tag_range)
-- 
2.28.0.220.ged08abb693-goog

