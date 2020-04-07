Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339ADC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E134020719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="KBH26cJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgDGBNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:13:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36362 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgDGBNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:13:06 -0400
Received: by mail-qt1-f195.google.com with SMTP id m33so1524472qtb.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CeJ1kRL2HCbJqIiZy3QM176LcPoZy3F54dnXT6/duZw=;
        b=KBH26cJPS9g9UUcSEx0O1X1YjdkUVTUlODqWjdavZGDOh4JjKOO16uPVcPqBVUyU3x
         uahbH7dYTvSv7uukbYPHZ/4MsxzRLx3wtXmJllv4xum1qhw6IFjzksKBWdwP3kLBD7r5
         7dyxyk2trhGjB2S7Byw/PstnOwh4zBw4yjDdkE0uwWkmHDaT2zYZlQ4VYskoZdl2W4AC
         AEZFN7H3uaXGrS6c88QsgJbCZOfsgXM1RxCf7lvaAGSVSjZqTcx3H1nQmJ0cc/YshmsS
         rW2aU2EpYYLaZaGady3vIId99NNnxToy0HMY+bYbaegCVV/igmnD1j2Og5fPfq+kkemS
         WRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CeJ1kRL2HCbJqIiZy3QM176LcPoZy3F54dnXT6/duZw=;
        b=geXBVZ6HXsdMV395/FfXny64NfF+2GCZ5xJ+lH9ij9SYutbgsVwh/DJb6WHfpBtrSo
         iM/IYedvNzxRiNf6mh/TcXKR7HsweRkU9rc70oHeebiVlh395PZGGVgWOCdGH8MKAi8u
         fdqt+5bwOHnJR4U87NgmrcLICm/nmPzcHjp8cBIXOWeNNlnNN9mhLIwvCptUFW9hrNfu
         qZKHQSB/++j/KXykwiHFEQ6KvuJQoEIIlqojaZUV8GPyvYNxPi4FS2GtFcKj3XILZttD
         rMnzgAaF6eoqniyWNFRCLOp/NEuFdiav5ymE/jYVdijSEF9sfH1NG/XmPXps1B5tnih4
         vNpw==
X-Gm-Message-State: AGi0PuaR3RwD4bv0j9G9oUEi9AwdWaRafzp1TBdIw6HUqMvhWbziYaPp
        nPef1XODi4Av458z5lAIAISFh/2xULvbRA==
X-Google-Smtp-Source: APiQypJs8pUcxuneSkl0ZTufuxyPomR/JFmjUu6CE2onYB6Vf6N/pz5uVQ9I1viZlJJ7SouuRoFY4g==
X-Received: by 2002:aed:3fef:: with SMTP id w44mr43039qth.387.1586221982706;
        Mon, 06 Apr 2020 18:13:02 -0700 (PDT)
Received: from juliacomputing.com (c-76-24-28-244.hsd1.ma.comcast.net. [76.24.28.244])
        by smtp.gmail.com with ESMTPSA id h10sm9197528qtp.93.2020.04.06.18.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2020 18:13:02 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:12:59 -0400
From:   Keno Fischer <keno@juliacomputing.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Kyle Huey <khuey@kylehuey.com>,
        Robert O'Callahan <robert@ocallahan.org>
Subject: [RFC PATCH v2] x86/arch_prctl: Add ARCH_SET_XCR0 to set XCR0
 per-thread
Message-ID: <20200407011259.GA72735@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up to my from two-years ago [1]. I've been using
rebased versions of that patch locally for my needs, but I've had
more people ask me about this patch recently, so I figured, I'd
have another go at this. Even if this doesn't make it into mainline,
I figure I can at least improve the quality of the patch for others
who want to use it. That's said, here's how this version is
different from v1:

The major flaw in v1 was that the modified XCR0 would change the
layout of the in-kernel xsave state, which was not considered,
acceptable. What this patch does instead is to restore XCR0 before
any kernel xsave(s)/xrstor(s) operation. XCR0 is then restored together
with the FPU state on return to userspace if necessary.
Of course, this code path, is extremely hot, so I additionally added
a static_key flag that disables the extra check for XCR0-restoring
unless there is a process in the system that has requested a modified
XCR0. To summarize, the performance impact in the hot-path is:

a) In the general case (no thread running with modified XCR0), an extra
   5-byte nop for ever xstate operation. This should be essentially free.
b) If some process in the system is running with a modified XCR0, an extra
   xgetbv and conditional branch. My understanding is that xgetbv is quite
   cheap at around 10 cycles or so (though obviously more expensive than a
   nop), so it's used to guard the xsetbv call for the common case that the
   XCR0 was not modified. If there is some situation that I did not think of
   in which xgetbv is expensive, this could instead look at the value in the
   thread_struct, but I thought the xgetbv would probably be cheaper.
   Additionally, we incur one additional conditional branch on return to
   user space if the FPU state needs to be reloaded.
c) For the process that's running with the modified XCR0, we incur an
   extra xsetbv for every kernel xstate operation.

Obviously point c) means that processes with active XCR0 modification will
incur noticeable overhead (an xsetbv may be expensive, or even incur a vmexit
if running under virtual hardware), even when switching between two threads
with the same (modified) XCR0 value. Note though that this only happens if
the xstate gets moved to memory. For simple round trips through the kernel
(e.g. simple syscalls or signals) that do not use the FPU from the kernel
and that do not cause a context switch, no additional instruction is executed
compared to the usual case.

I think these performance characteristics have the right character for this kind
of a feature, shifting the performance impact to users of the feature as much
as possible. I had hoped it might perhaps be possible to indicate
non-supervisor state components in the IA32_XSS MSR, but those bits are documented
as faulting if set on current-generation CPUs. If that were changed to allow such
user components, it could avoid the necessity of the extra xsetbv operations.
That said, given the hardware we have today, the scheme I implemented here
is the best I could come up with.

Thank you in advance for any review comments - I thought the comments
on v1 were quite helpful. I understand this is a tall ask for mainline
inclusion, but the feature is just too useful for me to give up ;).

[1] https://lkml.org/lkml/2018/6/16/134

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---
 arch/x86/include/asm/fpu/internal.h |  65 ++++++++++-------
 arch/x86/include/asm/fpu/xstate.h   |   2 +
 arch/x86/include/asm/processor.h    |   2 +
 arch/x86/include/uapi/asm/prctl.h   |   2 +
 arch/x86/kernel/fpu/core.c          |   5 ++
 arch/x86/kernel/fpu/xstate.c        |  11 ++-
 arch/x86/kernel/process.c           | 106 ++++++++++++++++++++++++++--
 7 files changed, 161 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 44c48e34d799..2db28f084206 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -15,6 +15,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
+#include <linux/jump_label_ratelimit.h>
 
 #include <asm/user.h>
 #include <asm/fpu/api.h>
@@ -314,6 +315,41 @@ static inline void copy_kernel_to_xregs_booting(struct xregs_state *xstate)
 	WARN_ON_FPU(err);
 }
 
+/*
+ * MXCSR and XCR definitions:
+ */
+
+extern unsigned int mxcsr_feature_mask;
+
+#define XCR_XFEATURE_ENABLED_MASK	0x00000000
+
+static inline u64 xgetbv(u32 index)
+{
+	u32 eax, edx;
+
+	asm volatile(".byte 0x0f,0x01,0xd0" /* xgetbv */
+		     : "=a" (eax), "=d" (edx)
+		     : "c" (index));
+	return eax + ((u64)edx << 32);
+}
+
+static inline void xsetbv(u32 index, u64 value)
+{
+	u32 eax = value;
+	u32 edx = value >> 32;
+
+	asm volatile(".byte 0x0f,0x01,0xd1" /* xsetbv */
+		     : : "a" (eax), "d" (edx), "c" (index));
+}
+
+static inline void reset_xcr0(u64 value)
+{
+	if (static_branch_unlikely(&xcr0_switching_active.key)) {
+		if (unlikely(xgetbv(XCR_XFEATURE_ENABLED_MASK) != value))
+			xsetbv(XCR_XFEATURE_ENABLED_MASK, value);
+	}
+}
+
 /*
  * Save processor xstate to xsave area.
  */
@@ -326,6 +362,7 @@ static inline void copy_xregs_to_kernel(struct xregs_state *xstate)
 
 	WARN_ON_FPU(!alternatives_patched);
 
+	reset_xcr0(xfeatures_mask);
 	XSTATE_XSAVE(xstate, lmask, hmask, err);
 
 	/* We should never fault when copying to a kernel buffer: */
@@ -340,6 +377,7 @@ static inline void copy_kernel_to_xregs(struct xregs_state *xstate, u64 mask)
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 
+	reset_xcr0(xfeatures_mask);
 	XSTATE_XRESTORE(xstate, lmask, hmask);
 }
 
@@ -615,31 +653,4 @@ static inline void switch_fpu_finish(struct fpu *new_fpu)
 	__write_pkru(pkru_val);
 }
 
-/*
- * MXCSR and XCR definitions:
- */
-
-extern unsigned int mxcsr_feature_mask;
-
-#define XCR_XFEATURE_ENABLED_MASK	0x00000000
-
-static inline u64 xgetbv(u32 index)
-{
-	u32 eax, edx;
-
-	asm volatile(".byte 0x0f,0x01,0xd0" /* xgetbv */
-		     : "=a" (eax), "=d" (edx)
-		     : "c" (index));
-	return eax + ((u64)edx << 32);
-}
-
-static inline void xsetbv(u32 index, u64 value)
-{
-	u32 eax = value;
-	u32 edx = value >> 32;
-
-	asm volatile(".byte 0x0f,0x01,0xd1" /* xsetbv */
-		     : : "a" (eax), "d" (edx), "c" (index));
-}
-
 #endif /* _ASM_X86_FPU_INTERNAL_H */
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index c6136d79f8c0..521ca7a5d2d2 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -43,11 +43,13 @@
 
 extern u64 xfeatures_mask;
 extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
+extern struct static_key_false_deferred xcr0_switching_active;
 
 extern void __init update_regset_xstate_info(unsigned int size,
 					     u64 xstate_mask);
 
 void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
+int xfeature_size(int xfeature_nr);
 const void *get_xsave_field_ptr(int xfeature_nr);
 int using_compacted_format(void);
 int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int offset, unsigned int size);
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 3bcf27caf6c9..28caba95d553 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -521,6 +521,8 @@ struct thread_struct {
 	unsigned long           debugreg6;
 	/* Keep track of the exact dr7 value set by the user */
 	unsigned long           ptrace_dr7;
+	/* Keep track of the exact XCR0 set by the user */
+	unsigned long           xcr0;
 	/* Fault info: */
 	unsigned long		cr2;
 	unsigned long		trap_nr;
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 5a6aac9fa41f..e9ca8facf1f6 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -10,6 +10,8 @@
 #define ARCH_GET_CPUID		0x1011
 #define ARCH_SET_CPUID		0x1012
 
+#define ARCH_SET_XCR0		0x1021
+
 #define ARCH_MAP_VDSO_X32	0x2001
 #define ARCH_MAP_VDSO_32	0x2002
 #define ARCH_MAP_VDSO_64	0x2003
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 12c70840980e..c66ae73988d5 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -341,6 +341,11 @@ void switch_fpu_return(void)
 		return;
 
 	__fpregs_load_activate();
+
+	if (static_branch_unlikely(&xcr0_switching_active.key)) {
+		if (unlikely(current->thread.xcr0))
+			reset_xcr0(current->thread.xcr0);
+	}
 }
 EXPORT_SYMBOL_GPL(switch_fpu_return);
 
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 32b153d38748..506d78dda9cb 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -57,6 +57,14 @@ static short xsave_cpuid_features[] __initdata = {
  * Mask of xstate features supported by the CPU and the kernel:
  */
 u64 xfeatures_mask __read_mostly;
+EXPORT_SYMBOL_GPL(xfeatures_mask);
+
+/*
+ * If true, some threads are running with a modified xcr0, so the current value
+ * of xcr0 should be checked before performing kernel xstate operations
+ */
+DEFINE_STATIC_KEY_DEFERRED_FALSE(xcr0_switching_active, HZ);
+EXPORT_SYMBOL_GPL(xcr0_switching_active);
 
 static unsigned int xstate_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_sizes[XFEATURE_MAX]   = { [ 0 ... XFEATURE_MAX - 1] = -1};
@@ -448,7 +456,7 @@ static int xfeature_uncompacted_offset(int xfeature_nr)
 	return ebx;
 }
 
-static int xfeature_size(int xfeature_nr)
+int xfeature_size(int xfeature_nr)
 {
 	u32 eax, ebx, ecx, edx;
 
@@ -456,6 +464,7 @@ static int xfeature_size(int xfeature_nr)
 	cpuid_count(XSTATE_CPUID, xfeature_nr, &eax, &ebx, &ecx, &edx);
 	return eax;
 }
+EXPORT_SYMBOL_GPL(xfeature_size);
 
 /*
  * 'XSAVES' implies two different things:
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 9da70b279dad..30da1b923b1d 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -92,6 +92,9 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	dst->thread.vm86 = NULL;
 #endif
 
+	if (unlikely(dst->thread.xcr0))
+		static_branch_deferred_inc(&xcr0_switching_active);
+
 	return fpu__copy(dst, src);
 }
 
@@ -108,6 +111,9 @@ void exit_thread(struct task_struct *tsk)
 
 	free_vm86(t);
 
+	if (unlikely(t->xcr0))
+		static_branch_slow_dec_deferred(&xcr0_switching_active);
+
 	fpu__drop(fpu);
 }
 
@@ -980,15 +986,107 @@ unsigned long get_wchan(struct task_struct *p)
 	return ret;
 }
 
+static int xcr0_is_legal(unsigned long xcr0)
+{
+	/* Conservatively disallow anything above bit 9,
+	 * to avoid accidentally allowing the disabling of
+	 * new features without updating these checks
+	 */
+	if (xcr0 & ~((1 << 10) - 1))
+		return 0;
+	if (!(xcr0 & XFEATURE_MASK_FP))
+		return 0;
+	if ((xcr0 & XFEATURE_MASK_YMM) && !(xcr0 & XFEATURE_MASK_SSE))
+		return 0;
+	if ((!(xcr0 & XFEATURE_MASK_BNDREGS)) !=
+		(!(xcr0 & XFEATURE_MASK_BNDCSR)))
+		return 0;
+	if (xcr0 & XFEATURE_MASK_AVX512) {
+		if (!(xcr0 & XFEATURE_MASK_YMM))
+			return 0;
+		if ((xcr0 & XFEATURE_MASK_AVX512) != XFEATURE_MASK_AVX512)
+			return 0;
+	}
+	return 1;
+}
+
+static int xstate_is_initial(unsigned long mask)
+{
+	int i, j;
+	unsigned long max_bit = __ffs(mask);
+
+	for (i = 0; i < max_bit; ++i) {
+		if (mask & (1 << i)) {
+			char *xfeature_addr = (char *)get_xsave_addr(
+				&current->thread.fpu.state.xsave,
+				1 << i);
+			unsigned long feature_size = xfeature_size(i);
+
+			for (j = 0; j < feature_size; ++j) {
+				if (xfeature_addr[j] != 0)
+					return 0;
+			}
+		}
+	}
+	return 1;
+}
+
 long do_arch_prctl_common(struct task_struct *task, int option,
-			  unsigned long cpuid_enabled)
+			  unsigned long arg2)
 {
 	switch (option) {
 	case ARCH_GET_CPUID:
 		return get_cpuid_mode();
 	case ARCH_SET_CPUID:
-		return set_cpuid_mode(task, cpuid_enabled);
-	}
+		return set_cpuid_mode(task, arg2);
+	case ARCH_SET_XCR0: {
+		if (!use_xsave())
+			return -ENODEV;
+
+		/* Do not allow enabling xstate components that the kernel doesn't
+		 * know about
+		 */
+		if (arg2 & ~xfeatures_mask)
+			return -ENODEV;
+
+		/* Do not allow xcr0 values that the hardware would refuse to load later
+		 */
+		if (!xcr0_is_legal(arg2))
+			return -EINVAL;
 
-	return -EINVAL;
+		/*
+		* We require that any state components being disabled by
+		* this prctl be currently in their initial state.
+		*/
+		if (!xstate_is_initial(arg2))
+			return -EPERM;
+
+		if (arg2 == xfeatures_mask) {
+			if (!current->thread.xcr0)
+				return 0;
+
+			/* A value of zero here means to use the kernel's xfeature mask,
+			 * so restore that value here
+			 */
+			current->thread.xcr0 = 0;
+			xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask);
+			static_branch_slow_dec_deferred(&xcr0_switching_active);
+		} else {
+			if (arg2 == current->thread.xcr0)
+				return 0;
+			if (!current->thread.xcr0)
+				static_branch_deferred_inc(&xcr0_switching_active);
+
+			current->thread.xcr0 = arg2;
+			/* Ask to restore the FPU on userspace exit, which will restore our
+			 * requested XCR0 value
+			 */
+			set_thread_flag(TIF_NEED_FPU_LOAD);
+		}
+
+		return 0;
+	}
+	default:
+		return -EINVAL;
+	}
 }
-- 
2.25.1

