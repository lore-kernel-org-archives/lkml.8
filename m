Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C02DCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66F020740
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gbPQahkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbgEMLLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 07:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgEMLLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 07:11:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90605C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 04:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2oiM69eTTutAkem1WDzgl0Co5n4dcgJPU67C5d1mbC4=; b=gbPQahkZQcTuv3WIRuLt9hX5yq
        E2sbM2JVp8nNjKTFRlSTdO40Zz7dhwg0KUpQ2Pp48oEfTrvLEx4nuZZrYk317BI0H3CcK36VDMVD6
        NgZxcRyz3Yryjsqciqbjvd10dEbkz7QNnoOVgGRzpXD1XGZzQA3vw5h5wVTASWqE2z4z76jjEwe8d
        3+TPz8mUMrBeZ+LsQcb6ojsWUufPzDamxNiuu/4J3lj5JW7ZWKqLSdfoY0P7UWuRrAzDtdIEgt4fA
        F2GKjBp+/8ghUMvVvnWCv1s3Wy62FT8+XJS7O4fVKhshryl1D1adgxrCXJpaEFKk/tc3TAbhxhhIF
        NldG+TSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYpHw-0004SK-6P; Wed, 13 May 2020 11:11:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 89CB8305EEF;
        Wed, 13 May 2020 13:10:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 715BD24C0C642; Wed, 13 May 2020 13:10:57 +0200 (CEST)
Date:   Wed, 13 May 2020 13:10:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, dvyukov@google.com
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200513111057.GN2957@hirez.programming.kicks-ass.net>
References: <20200511204150.27858-1-will@kernel.org>
 <20200512081826.GE2978@hirez.programming.kicks-ass.net>
 <CANpmjNNo3rhwqG=xEbpP9JiSd8-Faw8fkoUhYJjesHK5S5_KQQ@mail.gmail.com>
 <20200512190755.GL2957@hirez.programming.kicks-ass.net>
 <CANpmjNNeSnrAgfkskE5Y0NNu3-DS6hk+SwjkBunrr8FRxwwT-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNeSnrAgfkskE5Y0NNu3-DS6hk+SwjkBunrr8FRxwwT-Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 10:31:44PM +0200, Marco Elver wrote:
> On Tue, 12 May 2020 at 21:08, Peter Zijlstra <peterz@infradead.org> wrote:

> > data_race() will include active calls to kcsan_{dis,en}able_current(),
> > and this must not happen.
> 
> Only if instrumentation is enabled for the compilation unit. If you
> have KCSAN_SANITIZE_foo.c := n, no calls are emitted not even to
> kcsan_{dis,en}able_current(). Does that help?
> 
> By default, right now __READ_ONCE() will still generate a call due to
> instrumentation (call to __tsan_readX).

Ah, so looking at:

#define data_race(expr)							\
({									\
	__kcsan_disable_current();					\
	({								\
		__unqual_scalar_typeof(({ expr; })) __v = ({ expr; });	\
		__kcsan_enable_current();				\
		__v;							\
	});								\
})

had me confused, but then you've got this squirreled away in another
header:

#ifdef __SANITIZE_THREAD__
/*
 * Only calls into the runtime when the particular compilation unit has KCSAN
 * instrumentation enabled. May be used in header files.
 */
#define kcsan_check_access __kcsan_check_access

/*
 * Only use these to disable KCSAN for accesses in the current compilation unit;
 * calls into libraries may still perform KCSAN checks.
 */
#define __kcsan_disable_current kcsan_disable_current
#define __kcsan_enable_current kcsan_enable_current_nowarn
#else
static inline void kcsan_check_access(const volatile void *ptr, size_t size,
				      int type) { }
static inline void __kcsan_enable_current(void)  { }
static inline void __kcsan_disable_current(void) { }
#endif

And I suppose KCSAN_SANITIZE := n, results in __SANITIZE_THREAD__ not
being defined.

I really hate the function attribute situation, that is some ill
considered trainwreck.

Looking at this more, I found you already have:

arch/x86/kernel/Makefile:KCSAN_SANITIZE := n
arch/x86/kernel/Makefile:KCOV_INSTRUMENT                := n
arch/x86/mm/Makefile:KCSAN_SANITIZE := n

So how about I complete that and kill everhthing for all arch/x86/ that
has DEFINE_IDTENTRY*() in.

That avoids me having to do a lot of work to split up the tricky bits.
You didn't think it was important, so why should I bother.

So then I end up with something like the below, and I've validated that
does not generate instrumentation... HOWEVER, I now need ~10g of memory
and many seconds to compile each file in arch/x86/kernel/.

That is, when I do 'make arch/x86/kernel/ -j8', it is slow enough that I
can run top and grab:

31249 root      20   0 6128580   4.1g  13092 R 100.0  13.1   0:16.29 cc1
31278 root      20   0 6259456   4.4g  12932 R 100.0  13.9   0:16.27 cc1
31286 root      20   0 7243160   4.9g  13028 R 100.0  15.5   0:16.26 cc1
31289 root      20   0 5933824   4.0g  12936 R 100.0  12.8   0:16.26 cc1
31331 root      20   0 4250924   2.9g  13016 R 100.0   9.3   0:09.54 cc1
31346 root      20   0 1939552   1.3g  13028 R 100.0   4.1   0:07.01 cc1
31238 root      20   0 6293524   4.1g  13008 R 100.0  13.0   0:16.29 cc1
31259 root      20   0 6817076   4.7g  12956 R 100.0  14.9   0:16.27 cc1

and it then triggers OOMs, while previously I could build kernels with
-j80 on that machine:

31289 root      20   0   10.8g   6.2g    884 R 100.0  19.7   1:01.56 cc1
31249 root      20   0   10.2g   6.1g    484 R 100.0  19.3   1:00.10 cc1
31331 root      20   0   10.3g   7.2g    496 R 100.0  23.1   0:53.95 cc1

Only 3 left, because the others OOM'ed.

This is gcc-8.3, the situation with gcc-10 seems marginally better, but
still atrocious.

---
diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index b7a5790d8d63..ff959f0209e7 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -6,6 +6,7 @@
 KASAN_SANITIZE := n
 UBSAN_SANITIZE := n
 KCOV_INSTRUMENT := n
+KCSAN_INSTRUMENT := n
 
 CFLAGS_REMOVE_common.o = $(CC_FLAGS_FTRACE) -fstack-protector -fstack-protector-strong
 CFLAGS_REMOVE_syscall_32.o = $(CC_FLAGS_FTRACE) -fstack-protector -fstack-protector-strong
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index d6d61c4455fa..f2a46a87026e 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -22,15 +22,18 @@ CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_head64.o = -pg
 endif
 
-KASAN_SANITIZE_head$(BITS).o				:= n
-KASAN_SANITIZE_dumpstack.o				:= n
-KASAN_SANITIZE_dumpstack_$(BITS).o			:= n
-KASAN_SANITIZE_stacktrace.o				:= n
-KASAN_SANITIZE_paravirt.o				:= n
-
-# With some compiler versions the generated code results in boot hangs, caused
-# by several compilation units. To be safe, disable all instrumentation.
-KCSAN_SANITIZE := n
+#
+# You cannot instrument entry code, that results in definite problems.
+# In particular, anything with DEFINE_IDTENTRY*() in must not have
+# instrumentation on.
+#
+# If only function attributes and inlining would work properly, without
+# that untangling this is a giant trainwreck, don't attempt.
+#
+KASAN_SANITIZE := n
+UBSAN_SANITIZE := n
+KCOV_INSTRUMENT := n
+KCSAN_INSTRUMENT := n
 
 OBJECT_FILES_NON_STANDARD_test_nx.o			:= y
 OBJECT_FILES_NON_STANDARD_paravirt_patch.o		:= y
@@ -39,11 +42,6 @@ ifdef CONFIG_FRAME_POINTER
 OBJECT_FILES_NON_STANDARD_ftrace_$(BITS).o		:= y
 endif
 
-# If instrumentation of this dir is enabled, boot hangs during first second.
-# Probably could be more selective here, but note that files related to irqs,
-# boot, dumpstack/stacktrace, etc are either non-interesting or can lead to
-# non-deterministic coverage.
-KCOV_INSTRUMENT		:= n
 
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index f7fd0e868c9c..f8d7e7432847 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -1,15 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0
-# Kernel does not boot with instrumentation of tlb.c and mem_encrypt*.c
-KCOV_INSTRUMENT_tlb.o			:= n
-KCOV_INSTRUMENT_mem_encrypt.o		:= n
-KCOV_INSTRUMENT_mem_encrypt_identity.o	:= n
 
-KASAN_SANITIZE_mem_encrypt.o		:= n
-KASAN_SANITIZE_mem_encrypt_identity.o	:= n
-
-# Disable KCSAN entirely, because otherwise we get warnings that some functions
-# reference __initdata sections.
-KCSAN_SANITIZE := n
+#
+# You cannot instrument entry code, that results in definite problems.
+# In particular, anything with DEFINE_IDTENTRY*() in must not have
+# instrumentation on.
+#
+# If only function attributes and inlining would work properly, without
+# that untangling this is a giant trainwreck, don't attempt.
+#
+KASAN_SANITIZE := n
+UBSAN_SANITIZE := n
+KCOV_INSTRUMENT := n
+KCSAN_INSTRUMENT := n
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_mem_encrypt.o		= -pg
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 3bb962959d8b..48f85d1d2db6 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -241,7 +241,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * atomicity or dependency ordering guarantees. Note that this may result
  * in tears!
  */
-#define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
+#define __READ_ONCE(x)	data_race((*(const volatile __unqual_scalar_typeof(x) *)&(x)))
 
 #define __READ_ONCE_SCALAR(x)						\
 ({									\
@@ -260,7 +260,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 
 #define __WRITE_ONCE(x, val)						\
 do {									\
-	*(volatile typeof(x) *)&(x) = (val);				\
+	data_race(*(volatile typeof(x) *)&(x) = (val));			\
 } while (0)
 
 #define __WRITE_ONCE_SCALAR(x, val)					\


