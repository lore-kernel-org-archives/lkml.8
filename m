Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D999C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 225F720658
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qrzGpgAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgIGRY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729620AbgIGNlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:41:17 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D885C061757
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 06:41:16 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id f18so5708770wrv.19
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 06:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=5z/J5FmpUih5AunXUZcBxXMftgMmrnQQb5zqsYk89+U=;
        b=qrzGpgAIyNh1w1WAX6xz+D6eDKW3iGZQ1odGklPBY1aEhgeSVmHjibiYQHRsi5BhX7
         pWGz513RdHCeDJcsAUIfZx/ErEkDGQP7Qh4xkOrC+juyvDNQJJuJEk3ym5W4ZN/odjpb
         5eALUP8QxT/DyRhXS9wsBeQEG//vhpbeu9gkeqghAjUcgWpka7slfkhqVxqnO76Muijy
         eK/nm9eX2JWYZb1c5Ms682TiF/naUxEjIKpKgJElOceA1rM2RyBOGCviCKDiaxu5Hcgj
         KDBgU+km4pVvAncOD/zNAe7BpyvroPLAnErSVIbLQrPeBJ8PR0PyR53TNz6OZgIHFWjF
         oafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5z/J5FmpUih5AunXUZcBxXMftgMmrnQQb5zqsYk89+U=;
        b=H0KGXYegp+hki+w1GQdFZQtMawQJqt7VILh9e3aua61+noRO21bi8AlzNId+6jrjGG
         UTHGSHNHrZHvn1ZSi6owmKsae97K1ZsUhZubL45dAUmV00ldYs7LD81fZnptR5kM7UJz
         HT1fDXVV98PtCWi5pZhllySTarOgDzkZgH15yQd+LFHi9Hsa3Dr2WlqpX7UmvWJrq8nP
         7ft0hOS3bZ3cIVHzqsrt+zMtLYe9hUwyzaloZ9YFCpgg6RCcqkJS00XQmWpQjf/AJOCA
         OdfYDYPcDAwC73FaMi5l7NogOgIdORoMIWMRvaklfCJlhq/7i8WvPjAOnbDRmhf1azOA
         mvJw==
X-Gm-Message-State: AOAM532RSqz0tIAPumFdme88eW4o74thEx2IS1hFywfItdCT2jLCydzE
        N1L3x4MdxkugBryc04lLMSd4vkbcMA==
X-Google-Smtp-Source: ABdhPJxhActcecvve95wvtZfEwTJHuDIR+XsqED/73NlG4rCv/rWU9g+NLwhYgxlkuyB59M81PWVbgm4Nw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a7b:c14f:: with SMTP id z15mr9137wmi.1.1599486074403;
 Mon, 07 Sep 2020 06:41:14 -0700 (PDT)
Date:   Mon,  7 Sep 2020 15:40:47 +0200
In-Reply-To: <20200907134055.2878499-1-elver@google.com>
Message-Id: <20200907134055.2878499-3-elver@google.com>
Mime-Version: 1.0
References: <20200907134055.2878499-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH RFC 02/10] x86, kfence: enable KFENCE for x86
From:   Marco Elver <elver@google.com>
To:     elver@google.com, glider@google.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, cl@linux.com, rientjes@google.com,
        iamjoonsoo.kim@lge.com, mark.rutland@arm.com, penberg@kernel.org
Cc:     hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, dvyukov@google.com,
        edumazet@google.com, gregkh@linuxfoundation.org, mingo@redhat.com,
        jannh@google.com, corbet@lwn.net, keescook@chromium.org,
        peterz@infradead.org, cai@lca.pw, tglx@linutronix.de,
        will@kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Potapenko <glider@google.com>

Add architecture specific implementation details for KFENCE and enable
KFENCE for the x86 architecture. In particular, this implements the
required interface in <asm/kfence.h> for setting up the pool and
providing helper functions for protecting and unprotecting pages.

For x86, we need to ensure that the pool uses 4K pages, which is done
using the set_memory_4k() helper function.

Co-developed-by: Marco Elver <elver@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 arch/x86/Kconfig              |  2 ++
 arch/x86/include/asm/kfence.h | 60 +++++++++++++++++++++++++++++++++++
 arch/x86/mm/fault.c           |  4 +++
 3 files changed, 66 insertions(+)
 create mode 100644 arch/x86/include/asm/kfence.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7101ac64bb20..e22dc722698c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -144,6 +144,8 @@ config X86
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN			if X86_64
 	select HAVE_ARCH_KASAN_VMALLOC		if X86_64
+	select HAVE_ARCH_KFENCE
+	select HAVE_ARCH_KFENCE_STATIC_POOL
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS		if MMU
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if MMU && COMPAT
diff --git a/arch/x86/include/asm/kfence.h b/arch/x86/include/asm/kfence.h
new file mode 100644
index 000000000000..cf09e377faf9
--- /dev/null
+++ b/arch/x86/include/asm/kfence.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_X86_KFENCE_H
+#define _ASM_X86_KFENCE_H
+
+#include <linux/bug.h>
+#include <linux/kfence.h>
+
+#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
+#include <asm/set_memory.h>
+#include <asm/tlbflush.h>
+
+/* The alignment should be at least a 4K page. */
+#define KFENCE_POOL_ALIGNMENT PAGE_SIZE
+
+/*
+ * The page fault handler entry function, up to which the stack trace is
+ * truncated in reports.
+ */
+#define KFENCE_SKIP_ARCH_FAULT_HANDLER "asm_exc_page_fault"
+
+/* Force 4K pages for __kfence_pool. */
+static inline bool arch_kfence_initialize_pool(void)
+{
+	unsigned long addr;
+
+	for (addr = (unsigned long)__kfence_pool; is_kfence_address((void *)addr);
+	     addr += PAGE_SIZE) {
+		unsigned int level;
+
+		if (!lookup_address(addr, &level))
+			return false;
+
+		if (level != PG_LEVEL_4K)
+			set_memory_4k(addr, 1);
+	}
+
+	return true;
+}
+
+/* Protect the given page and flush TLBs. */
+static inline bool kfence_protect_page(unsigned long addr, bool protect)
+{
+	unsigned int level;
+	pte_t *pte = lookup_address(addr, &level);
+
+	if (!pte || level != PG_LEVEL_4K)
+		return false;
+
+	if (protect)
+		set_pte(pte, __pte(pte_val(*pte) & ~_PAGE_PRESENT));
+	else
+		set_pte(pte, __pte(pte_val(*pte) | _PAGE_PRESENT));
+
+	flush_tlb_one_kernel(addr);
+	return true;
+}
+
+#endif /* _ASM_X86_KFENCE_H */
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 6e3e8a124903..423e15ad5eb6 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -9,6 +9,7 @@
 #include <linux/kdebug.h>		/* oops_begin/end, ...		*/
 #include <linux/extable.h>		/* search_exception_tables	*/
 #include <linux/memblock.h>		/* max_low_pfn			*/
+#include <linux/kfence.h>		/* kfence_handle_page_fault	*/
 #include <linux/kprobes.h>		/* NOKPROBE_SYMBOL, ...		*/
 #include <linux/mmiotrace.h>		/* kmmio_handler, ...		*/
 #include <linux/perf_event.h>		/* perf_sw_event		*/
@@ -701,6 +702,9 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	}
 #endif
 
+	if (kfence_handle_page_fault(address))
+		return;
+
 	/*
 	 * 32-bit:
 	 *
-- 
2.28.0.526.ge36021eeef-goog

