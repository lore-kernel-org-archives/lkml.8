Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A111C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 21:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7546B20720
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 21:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgHWVZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 17:25:55 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36334 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgHWVZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 17:25:54 -0400
Received: by mail-qt1-f196.google.com with SMTP id t23so4944663qto.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 14:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jPzxTWmkt7DcrtrR8h9gNnnSXms3kOfVlguXP9QdfeE=;
        b=s3Mj83CoLjZQtQvrXUG0u+bCxBJlqpHJ6WcTs3ATwmV0s5N2mT0zpQgnLUYs5ui0GB
         8hxarKEQEMN8xGnZoPP+Ha4U1PaQRjyagt8pwjpQ6IucOEwY0DdUeT+ntD4R0bEyaYTj
         3r9m3EW7O8UhUnNY40RjJ0PWD5KoNTwvYP6+eeOglaYpWIFYLp/UzpgkdeUAnrVtI/e6
         Ae3eFENwYu1j+WUvXPIsR/K0s14PD5J146zP199o+mbIqL2sAlbUrZgojUeY9TxxiW/v
         DMFpCiy3n3CX6ODzcoJ1AnwMJZ1gjkgfYbiwc+pMwrkdJy2QdKuDClLyHl+TmKRtAcJj
         jY9A==
X-Gm-Message-State: AOAM530tVT/qAvVt7hVuHdw8h9IdLFSLP6OdIxBEufUsBQurfK4COcQa
        N/Wf+qkAgUqHLUWrKNIOVK1A/4LzbQU=
X-Google-Smtp-Source: ABdhPJwIo3KcYPUzKoCqRIa5463Z28RkU6EnbpZgfYl8Rwu1i65QNFvoWReqpamKhJSTlap4fpDEGQ==
X-Received: by 2002:ac8:4243:: with SMTP id r3mr2400191qtm.368.1598217952116;
        Sun, 23 Aug 2020 14:25:52 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id y24sm9253606qtv.71.2020.08.23.14.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 14:25:51 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH] x86/asm: Replace __force_order with memory clobber
Date:   Sun, 23 Aug 2020 17:25:50 -0400
Message-Id: <20200823212550.3377591-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200823011652.GA1910689@rani.riverdale.lan>
References: <20200823011652.GA1910689@rani.riverdale.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CRn accessor functions use __force_order as a dummy operand to
prevent the compiler from reordering the inline asm.

The fact that the asm is volatile should be enough to prevent this
already, however older versions of GCC had a bug that could sometimes
result in reordering. This was fixed in 8.1, 7.3 and 6.5.

There are some issues with __force_order as implemented:
- It is used only as an input operand for the write functions, and hence
  doesn't do anything additional to prevent reordering writes.
- It allows memory accesses to be cached/reordered across write
  functions, but CRn writes affect the semantics of memory accesses, so
  this could be dangerous.
- __force_order is not actually defined in the kernel proper, but the
  LLVM toolchain can in some cases require a definition: LLVM (as well
  as GCC 4.9) requires it for PIE code, which is why the compressed
  kernel has a definition, but also the clang integrated assembler may
  consider the address of __force_order to be significant, resulting in
  a reference that requires a definition.

Fix this by:
- Using a memory clobber for the write functions to additionally prevent
  caching/reordering memory accesses across CRn writes.
- Using a dummy input operand with an arbitrary constant address for the
  read functions, instead of a global variable. This will prevent reads
  from being reordered across writes, while allowing memory loads to be
  cached/reordered across CRn reads, which should be safe.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82602
---
 arch/x86/boot/compressed/pgtable_64.c |  9 ---------
 arch/x86/include/asm/special_insns.h  | 27 ++++++++++++++-------------
 arch/x86/kernel/cpu/common.c          |  4 ++--
 3 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index c8862696a47b..7d0394f4ebf9 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -5,15 +5,6 @@
 #include "pgtable.h"
 #include "../string.h"
 
-/*
- * __force_order is used by special_insns.h asm code to force instruction
- * serialization.
- *
- * It is not referenced from the code, but GCC < 5 with -fPIE would fail
- * due to an undefined symbol. Define it to make these ancient GCCs work.
- */
-unsigned long __force_order;
-
 #define BIOS_START_MIN		0x20000U	/* 128K, less than this is insane */
 #define BIOS_START_MAX		0x9f000U	/* 640K, absolute maximum */
 
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 59a3e13204c3..8f7791217ef4 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -11,45 +11,46 @@
 #include <linux/jump_label.h>
 
 /*
- * Volatile isn't enough to prevent the compiler from reordering the
- * read/write functions for the control registers and messing everything up.
- * A memory clobber would solve the problem, but would prevent reordering of
- * all loads stores around it, which can hurt performance. Solution is to
- * use a variable and mimic reads and writes to it to enforce serialization
+ * The compiler should not reorder volatile asm, however older versions of GCC
+ * had a bug (which was fixed in 8.1, 7.3 and 6.5) where they could sometimes
+ * reorder volatile asm. The write functions are not a problem since they have
+ * memory clobbers preventing reordering. To prevent reads from being reordered
+ * with respect to writes, use a dummy memory operand.
  */
-extern unsigned long __force_order;
+
+#define __FORCE_ORDER "m"(*(unsigned int *)0x1000UL)
 
 void native_write_cr0(unsigned long val);
 
 static inline unsigned long native_read_cr0(void)
 {
 	unsigned long val;
-	asm volatile("mov %%cr0,%0\n\t" : "=r" (val), "=m" (__force_order));
+	asm volatile("mov %%cr0,%0\n\t" : "=r" (val) : __FORCE_ORDER);
 	return val;
 }
 
 static __always_inline unsigned long native_read_cr2(void)
 {
 	unsigned long val;
-	asm volatile("mov %%cr2,%0\n\t" : "=r" (val), "=m" (__force_order));
+	asm volatile("mov %%cr2,%0\n\t" : "=r" (val) : __FORCE_ORDER);
 	return val;
 }
 
 static __always_inline void native_write_cr2(unsigned long val)
 {
-	asm volatile("mov %0,%%cr2": : "r" (val), "m" (__force_order));
+	asm volatile("mov %0,%%cr2": : "r" (val) : "memory");
 }
 
 static inline unsigned long __native_read_cr3(void)
 {
 	unsigned long val;
-	asm volatile("mov %%cr3,%0\n\t" : "=r" (val), "=m" (__force_order));
+	asm volatile("mov %%cr3,%0\n\t" : "=r" (val) : __FORCE_ORDER);
 	return val;
 }
 
 static inline void native_write_cr3(unsigned long val)
 {
-	asm volatile("mov %0,%%cr3": : "r" (val), "m" (__force_order));
+	asm volatile("mov %0,%%cr3": : "r" (val) : "memory");
 }
 
 static inline unsigned long native_read_cr4(void)
@@ -64,10 +65,10 @@ static inline unsigned long native_read_cr4(void)
 	asm volatile("1: mov %%cr4, %0\n"
 		     "2:\n"
 		     _ASM_EXTABLE(1b, 2b)
-		     : "=r" (val), "=m" (__force_order) : "0" (0));
+		     : "=r" (val) : "0" (0), __FORCE_ORDER);
 #else
 	/* CR4 always exists on x86_64. */
-	asm volatile("mov %%cr4,%0\n\t" : "=r" (val), "=m" (__force_order));
+	asm volatile("mov %%cr4,%0\n\t" : "=r" (val) : __FORCE_ORDER);
 #endif
 	return val;
 }
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c5d6f17d9b9d..178499f90366 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -359,7 +359,7 @@ void native_write_cr0(unsigned long val)
 	unsigned long bits_missing = 0;
 
 set_register:
-	asm volatile("mov %0,%%cr0": "+r" (val), "+m" (__force_order));
+	asm volatile("mov %0,%%cr0": "+r" (val) : : "memory");
 
 	if (static_branch_likely(&cr_pinning)) {
 		if (unlikely((val & X86_CR0_WP) != X86_CR0_WP)) {
@@ -378,7 +378,7 @@ void native_write_cr4(unsigned long val)
 	unsigned long bits_changed = 0;
 
 set_register:
-	asm volatile("mov %0,%%cr4": "+r" (val), "+m" (cr4_pinned_bits));
+	asm volatile("mov %0,%%cr4": "+r" (val) : : "memory");
 
 	if (static_branch_likely(&cr_pinning)) {
 		if (unlikely((val & cr4_pinned_mask) != cr4_pinned_bits)) {
-- 
2.26.2

