Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D184C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E92592145D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MSosw5qP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgE2RIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 13:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgE2RIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 13:08:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21272C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 10:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TFvRXAcR53qFccB0D5t7OoqWfRiUV7I+frw7I0E1gOo=; b=MSosw5qPD7HkBFYzw4Q7ZL3YTp
        PqCfckOIFNYgAieF6n8XCXH5DzSAdFyqhQ9fFzgiUkoCt2IbwE1BhrdESMR8+bfwypAW0xHXrVtGO
        tdVZFCe2P+hR3ZbZ3g7NTJsymGafZa0A9WIpHBiLwM8at6IRZhTq9/Uw6IdBo21yTGzLvVCNRaQD7
        Mq30XrNRSeBEh42AT/FAAce/BIgaO/s2WV+LLgdlkeiCe9gzep6z2rIyWC9+23pXPeOwJLX2KGGwj
        NFIt3pabM7YQvVsrDAWTuCmUCrnAAVibdFBihqm/RbP2PoPJ7tqPoZe+YgaASAfORjVz7R4FBkQvo
        X7dvksjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeiUA-0001rc-PT; Fri, 29 May 2020 17:07:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C01BD3011FF;
        Fri, 29 May 2020 19:07:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AC7DB2BB51407; Fri, 29 May 2020 19:07:55 +0200 (CEST)
Date:   Fri, 29 May 2020 19:07:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        will@kernel.org, clang-built-linux@googlegroups.com, bp@alien8.de
Subject: Re: [PATCH -tip v3 05/11] kcsan: Remove 'noinline' from
 __no_kcsan_or_inline
Message-ID: <20200529170755.GN706495@hirez.programming.kicks-ass.net>
References: <20200521142047.169334-1-elver@google.com>
 <20200521142047.169334-6-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521142047.169334-6-elver@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 04:20:41PM +0200, Marco Elver wrote:
> Some compilers incorrectly inline small __no_kcsan functions, which then
> results in instrumenting the accesses. For this reason, the 'noinline'
> attribute was added to __no_kcsan_or_inline. All known versions of GCC
> are affected by this. Supported version of Clang are unaffected, and
> never inlines a no_sanitize function.
> 
> However, the attribute 'noinline' in __no_kcsan_or_inline causes
> unexpected code generation in functions that are __no_kcsan and call a
> __no_kcsan_or_inline function.
> 
> In certain situations it is expected that the __no_kcsan_or_inline
> function is actually inlined by the __no_kcsan function, and *no* calls
> are emitted. By removing the 'noinline' attribute we give the compiler
> the ability to inline and generate the expected code in __no_kcsan
> functions.


Doesn't this mean we can do the below?

---
 Documentation/dev-tools/kcsan.rst |  6 ------
 arch/x86/include/asm/bitops.h     |  6 +-----
 include/linux/compiler_types.h    | 14 ++++----------
 kernel/kcsan/kcsan-test.c         |  4 ++--
 4 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index ce4bbd918648..b38379f06194 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -114,12 +114,6 @@ functions, compilation units, or entire subsystems.  For static blacklisting,
   To dynamically limit for which functions to generate reports, see the
   `DebugFS interface`_ blacklist/whitelist feature.
 
-  For ``__always_inline`` functions, replace ``__always_inline`` with
-  ``__no_kcsan_or_inline`` (which implies ``__always_inline``)::
-
-    static __no_kcsan_or_inline void foo(void) {
-        ...
-
 * To disable data race detection for a particular compilation unit, add to the
   ``Makefile``::
 
diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 35460fef39b8..0367efdc5b7a 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -201,12 +201,8 @@ arch_test_and_change_bit(long nr, volatile unsigned long *addr)
 	return GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(btc), *addr, c, "Ir", nr);
 }
 
-static __no_kcsan_or_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
+static __always_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
 {
-	/*
-	 * Because this is a plain access, we need to disable KCSAN here to
-	 * avoid double instrumentation via instrumented bitops.
-	 */
 	return ((1UL << (nr & (BITS_PER_LONG-1))) &
 		(addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
 }
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 4e4982d6f3b0..6a2c0f857ac3 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -118,10 +118,6 @@ struct ftrace_likely_data {
 #define notrace			__attribute__((__no_instrument_function__))
 #endif
 
-/* Section for code which can't be instrumented at all */
-#define noinstr								\
-	noinline notrace __attribute((__section__(".noinstr.text")))
-
 /*
  * it doesn't make sense on ARM (currently the only user of __naked)
  * to trace naked functions because then mcount is called without
@@ -192,17 +188,15 @@ struct ftrace_likely_data {
 #endif
 
 #define __no_kcsan __no_sanitize_thread
-#ifdef __SANITIZE_THREAD__
-# define __no_kcsan_or_inline __no_kcsan notrace __maybe_unused
-# define __no_sanitize_or_inline __no_kcsan_or_inline
-#else
-# define __no_kcsan_or_inline __always_inline
-#endif
 
 #ifndef __no_sanitize_or_inline
 #define __no_sanitize_or_inline __always_inline
 #endif
 
+/* Section for code which can't be instrumented at all */
+#define noinstr								\
+	noinline notrace __attribute((__section__(".noinstr.text"))) __no_kcsan
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
diff --git a/kernel/kcsan/kcsan-test.c b/kernel/kcsan/kcsan-test.c
index a8c11506dd2a..374263ddffe2 100644
--- a/kernel/kcsan/kcsan-test.c
+++ b/kernel/kcsan/kcsan-test.c
@@ -43,7 +43,7 @@ static struct {
 };
 
 /* Setup test checking loop. */
-static __no_kcsan_or_inline void
+static __no_kcsan inline void
 begin_test_checks(void (*func1)(void), void (*func2)(void))
 {
 	kcsan_disable_current();
@@ -60,7 +60,7 @@ begin_test_checks(void (*func1)(void), void (*func2)(void))
 }
 
 /* End test checking loop. */
-static __no_kcsan_or_inline bool
+static __no_kcsan inline bool
 end_test_checks(bool stop)
 {
 	if (!stop && time_before(jiffies, end_time)) {
