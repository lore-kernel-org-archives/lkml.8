Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FE1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF6C2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kwoF/VYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgHNR2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgHNR2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:28:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633C7C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k11so10786041ybp.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yvYQszTRrx8ntvEq6Qcrq8fyLKT0lW9ZP3vFTaTmLjo=;
        b=kwoF/VYNH81Wq5oxRmBS/t6isOHxSA1+nk7yFG/ctYk1dMtUFAssZRouR3ifCgmied
         HCuEfscJx4hXYpJpUou/VViHr9lanozcwuQm1U5u/0tDMytMBVr7C8d3mDNs3ibggKNp
         F/Aa5FlHOPTTPcn5j5e2zwGLlVXP9Ll9g9T+ipgxhJUMkl1ptNNMmDug0rxj6JlAFAOT
         a/xbumJfdyTXcP7pFh7kRQ0Ob427pQyR3lIsHts4xkPbcD6fbKyHIow4+xI8eO260iTH
         LH7GmsWk+GAk8LKF2Ys6149+2tlLyQMH3ULlSvp4zlDgna+xDAWU8z5T0qW5jPMCinRM
         kLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yvYQszTRrx8ntvEq6Qcrq8fyLKT0lW9ZP3vFTaTmLjo=;
        b=WwIO6t6FX5DnSPGR+j1F+kj/YqtNuhLpaBsuOLXeMfJwTHfIVIAh2FiaJbRu2ies1w
         r5gEEQ9YFe3ptDed8znsT+4BCr6RWJtzWxDXOujDmvQsun5tIcoagtXPaF/iGxP+oxJP
         x4FwDm8Fn4PqnJRJrgTfihEHlrTDKmY9JPuNcwyLosjWE/z9lyA5Dkg4BQ+U7iLLmWFE
         iBoJgeOBYkyV1rUTlYhUHoYBw6dq+R52MKFp2HqaFK/jwTd2Wt3MZa0zVCz4NCs3/q6t
         /pZEzXgIL5gwk7hipGOY/bk+RPzUCHl1hcYneeiIapAxhF6dfLoCwrSzE3VYTIgqkpmV
         APHw==
X-Gm-Message-State: AOAM531iPX5XPOchjx55p37JeP821bIU1aduI0sSuCs8WU5FHm0GjChH
        tGmMJI8vd0efQ/Mc4Tb+UZIkDSIcok2YKxyl
X-Google-Smtp-Source: ABdhPJxMkNkayXmom9Crca+A9DYJPsn/opssoVn4Ch8j5PCmvAli8vL+/pOquIkx8fK6lqFW2m8WxnJcR6fmeb+3
X-Received: by 2002:a25:7310:: with SMTP id o16mr5154152ybc.415.1597426114537;
 Fri, 14 Aug 2020 10:28:34 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:27:12 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <33118d2b5d458fab42db9485389b5e8159ca3b02.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 30/35] kasan, arm64: expand CONFIG_KASAN checks
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

Some #ifdef CONFIG_KASAN checks are only relevant for software KASAN
modes (either related to shadow memory or compiler instrumentation).
Expand those into CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/Kconfig                 |  2 +-
 arch/arm64/Makefile                |  2 +-
 arch/arm64/include/asm/assembler.h |  2 +-
 arch/arm64/include/asm/memory.h    |  2 +-
 arch/arm64/include/asm/string.h    |  5 +++--
 arch/arm64/kernel/head.S           |  2 +-
 arch/arm64/kernel/image-vars.h     |  2 +-
 arch/arm64/mm/dump.c               |  6 +++---
 include/linux/kasan-checks.h       |  2 +-
 include/linux/kasan.h              |  7 ++++---
 include/linux/moduleloader.h       |  3 ++-
 include/linux/string.h             |  2 +-
 mm/ptdump.c                        | 13 ++++++++-----
 scripts/Makefile.lib               |  2 ++
 14 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 32ceff21acc1..70a7880d5145 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -320,7 +320,7 @@ config BROKEN_GAS_INST
 
 config KASAN_SHADOW_OFFSET
 	hex
-	depends on KASAN
+	depends on KASAN_GENERIC || KASAN_SW_TAGS
 	default 0xdfffa00000000000 if (ARM64_VA_BITS_48 || ARM64_VA_BITS_52) && !KASAN_SW_TAGS
 	default 0xdfffd00000000000 if ARM64_VA_BITS_47 && !KASAN_SW_TAGS
 	default 0xdffffe8000000000 if ARM64_VA_BITS_42 && !KASAN_SW_TAGS
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index a0d94d063fa8..89df029a3cff 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -125,7 +125,7 @@ TEXT_OFFSET := 0x0
 
 ifeq ($(CONFIG_KASAN_SW_TAGS), y)
 KASAN_SHADOW_SCALE_SHIFT := 4
-else
+else ifeq ($(CONFIG_KASAN_GENERIC), y)
 KASAN_SHADOW_SCALE_SHIFT := 3
 endif
 
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 54d181177656..bc9ace1e5f3a 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -464,7 +464,7 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 #define NOKPROBE(x)
 #endif
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 #define EXPORT_SYMBOL_NOKASAN(name)
 #else
 #define EXPORT_SYMBOL_NOKASAN(name)	EXPORT_SYMBOL(name)
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 770535b7ca35..8881849929e3 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -75,7 +75,7 @@
  * address space for the shadow region respectively. They can bloat the stack
  * significantly, so double the (minimum) stack size when they are in use.
  */
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 #define KASAN_SHADOW_OFFSET	_AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
 #define KASAN_SHADOW_END	((UL(1) << (64 - KASAN_SHADOW_SCALE_SHIFT)) \
 					+ KASAN_SHADOW_OFFSET)
diff --git a/arch/arm64/include/asm/string.h b/arch/arm64/include/asm/string.h
index b31e8e87a0db..3a3264ff47b9 100644
--- a/arch/arm64/include/asm/string.h
+++ b/arch/arm64/include/asm/string.h
@@ -5,7 +5,7 @@
 #ifndef __ASM_STRING_H
 #define __ASM_STRING_H
 
-#ifndef CONFIG_KASAN
+#if !(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
 #define __HAVE_ARCH_STRRCHR
 extern char *strrchr(const char *, int c);
 
@@ -48,7 +48,8 @@ extern void *__memset(void *, int, __kernel_size_t);
 void memcpy_flushcache(void *dst, const void *src, size_t cnt);
 #endif
 
-#if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
+#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
+	!defined(__SANITIZE_ADDRESS__)
 
 /*
  * For files that are not instrumented (e.g. mm/slub.c) we
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 037421c66b14..427ded9e68e8 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -452,7 +452,7 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 	bl	__pi_memset
 	dsb	ishst				// Make zero page visible to PTW
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	bl	kasan_early_init
 #endif
 #ifdef CONFIG_RANDOMIZE_BASE
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index be0a63ffed23..b85372eba2d6 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -37,7 +37,7 @@ __efistub_strncmp		= __pi_strncmp;
 __efistub_strrchr		= __pi_strrchr;
 __efistub___clean_dcache_area_poc = __pi___clean_dcache_area_poc;
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 __efistub___memcpy		= __pi_memcpy;
 __efistub___memmove		= __pi_memmove;
 __efistub___memset		= __pi_memset;
diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index ba6d1d89f9b2..bf8ddeac5d8f 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -29,7 +29,7 @@
 enum address_markers_idx {
 	PAGE_OFFSET_NR = 0,
 	PAGE_END_NR,
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	KASAN_START_NR,
 #endif
 };
@@ -37,7 +37,7 @@ enum address_markers_idx {
 static struct addr_marker address_markers[] = {
 	{ PAGE_OFFSET,			"Linear Mapping start" },
 	{ 0 /* PAGE_END */,		"Linear Mapping end" },
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	{ 0 /* KASAN_SHADOW_START */,	"Kasan shadow start" },
 	{ KASAN_SHADOW_END,		"Kasan shadow end" },
 #endif
@@ -381,7 +381,7 @@ void ptdump_check_wx(void)
 static int ptdump_init(void)
 {
 	address_markers[PAGE_END_NR].start_address = PAGE_END;
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	address_markers[KASAN_START_NR].start_address = KASAN_SHADOW_START;
 #endif
 	ptdump_initialize();
diff --git a/include/linux/kasan-checks.h b/include/linux/kasan-checks.h
index ac6aba632f2d..ca5e89fb10d3 100644
--- a/include/linux/kasan-checks.h
+++ b/include/linux/kasan-checks.h
@@ -9,7 +9,7 @@
  * even in compilation units that selectively disable KASAN, but must use KASAN
  * to validate access to an address.   Never use these in header files!
  */
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 bool __kasan_check_read(const volatile void *p, unsigned int size);
 bool __kasan_check_write(const volatile void *p, unsigned int size);
 #else
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 894f4d9163ee..875bbcedd994 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -232,7 +232,8 @@ static inline void kasan_release_vmalloc(unsigned long start,
 
 #endif /* CONFIG_KASAN_VMALLOC */
 
-#if defined(CONFIG_KASAN) && !defined(CONFIG_KASAN_VMALLOC)
+#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
+		!defined(CONFIG_KASAN_VMALLOC)
 
 /*
  * These functions provide a special case to support backing module
@@ -242,12 +243,12 @@ static inline void kasan_release_vmalloc(unsigned long start,
 int kasan_module_alloc(void *addr, size_t size);
 void kasan_free_shadow(const struct vm_struct *vm);
 
-#else /* CONFIG_KASAN && !CONFIG_KASAN_VMALLOC */
+#else /* (CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) && !CONFIG_KASAN_VMALLOC */
 
 static inline int kasan_module_alloc(void *addr, size_t size) { return 0; }
 static inline void kasan_free_shadow(const struct vm_struct *vm) {}
 
-#endif /* CONFIG_KASAN && !CONFIG_KASAN_VMALLOC */
+#endif /* (CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) && !CONFIG_KASAN_VMALLOC */
 
 #ifdef CONFIG_KASAN_INLINE
 void kasan_non_canonical_hook(unsigned long addr);
diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 4fa67a8b2265..9e09d11ffe5b 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -96,7 +96,8 @@ void module_arch_cleanup(struct module *mod);
 /* Any cleanup before freeing mod->module_init */
 void module_arch_freeing_init(struct module *mod);
 
-#if defined(CONFIG_KASAN) && !defined(CONFIG_KASAN_VMALLOC)
+#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
+		!defined(CONFIG_KASAN_VMALLOC)
 #include <linux/kasan.h>
 #define MODULE_ALIGN (PAGE_SIZE << KASAN_SHADOW_SCALE_SHIFT)
 #else
diff --git a/include/linux/string.h b/include/linux/string.h
index 9b7a0632e87a..607322616363 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -273,7 +273,7 @@ void __write_overflow(void) __compiletime_error("detected write beyond size of o
 
 #if !defined(__NO_FORTIFY) && defined(__OPTIMIZE__) && defined(CONFIG_FORTIFY_SOURCE)
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
 extern int __underlying_memcmp(const void *p, const void *q, __kernel_size_t size) __RENAME(memcmp);
 extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(memcpy);
diff --git a/mm/ptdump.c b/mm/ptdump.c
index ba88ec43ff21..4354c1422d57 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -4,7 +4,7 @@
 #include <linux/ptdump.h>
 #include <linux/kasan.h>
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 /*
  * This is an optimization for KASAN=y case. Since all kasan page tables
  * eventually point to the kasan_early_shadow_page we could call note_page()
@@ -31,7 +31,8 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long addr,
 	struct ptdump_state *st = walk->private;
 	pgd_t val = READ_ONCE(*pgd);
 
-#if CONFIG_PGTABLE_LEVELS > 4 && defined(CONFIG_KASAN)
+#if CONFIG_PGTABLE_LEVELS > 4 && \
+		(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
 	if (pgd_page(val) == virt_to_page(lm_alias(kasan_early_shadow_p4d)))
 		return note_kasan_page_table(walk, addr);
 #endif
@@ -51,7 +52,8 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long addr,
 	struct ptdump_state *st = walk->private;
 	p4d_t val = READ_ONCE(*p4d);
 
-#if CONFIG_PGTABLE_LEVELS > 3 && defined(CONFIG_KASAN)
+#if CONFIG_PGTABLE_LEVELS > 3 && \
+		(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
 	if (p4d_page(val) == virt_to_page(lm_alias(kasan_early_shadow_pud)))
 		return note_kasan_page_table(walk, addr);
 #endif
@@ -71,7 +73,8 @@ static int ptdump_pud_entry(pud_t *pud, unsigned long addr,
 	struct ptdump_state *st = walk->private;
 	pud_t val = READ_ONCE(*pud);
 
-#if CONFIG_PGTABLE_LEVELS > 2 && defined(CONFIG_KASAN)
+#if CONFIG_PGTABLE_LEVELS > 2 && \
+		(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
 	if (pud_page(val) == virt_to_page(lm_alias(kasan_early_shadow_pmd)))
 		return note_kasan_page_table(walk, addr);
 #endif
@@ -91,7 +94,7 @@ static int ptdump_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct ptdump_state *st = walk->private;
 	pmd_t val = READ_ONCE(*pmd);
 
-#if defined(CONFIG_KASAN)
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	if (pmd_page(val) == virt_to_page(lm_alias(kasan_early_shadow_pte)))
 		return note_kasan_page_table(walk, addr);
 #endif
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 99ac59c59826..e527d06b9da8 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -135,10 +135,12 @@ endif
 # we don't want to check (depends on variables KASAN_SANITIZE_obj.o, KASAN_SANITIZE)
 #
 ifeq ($(CONFIG_KASAN),y)
+ifneq ($(CONFIG_KASAN_HW_TAGS),y)
 _c_flags += $(if $(patsubst n%,, \
 		$(KASAN_SANITIZE_$(basetarget).o)$(KASAN_SANITIZE)y), \
 		$(CFLAGS_KASAN), $(CFLAGS_KASAN_NOSANITIZE))
 endif
+endif
 
 ifeq ($(CONFIG_UBSAN),y)
 _c_flags += $(if $(patsubst n%,, \
-- 
2.28.0.220.ged08abb693-goog

