Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F23C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E66D214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BaDVylXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbgGBPDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgGBPDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:03:16 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3D4C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 08:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9GqeEnwkAqHsgBWKwxmrirDR71p/Vge6NVyXyAYx/0E=; b=BaDVylXRZL0pdJE5czcfL4wmwv
        qfULwWYJKq73NIrRzbGZDSvsvN2oEGD3uctDfVJefjgfIdTbEHg3NJ5LLEQO79nvIfz4DvEKRMi1p
        P5xjbOZ4S3teL17sTOkiJMO8ymXRRGgPHKiCmtr95vVz+J9M/6+7wUQY9XGXnQrpwidjNv6dPn8WY
        sIuYbZy/UYdxPeT6/COktMQ3mfxoNjHWKygiJuFotUukMiL7J5E+DpkumINLFsCOeoQaUgfEllbKk
        aU9xsnKo7JLNK+kEg7sCmhk3l6N188vUTpvOdeJ7g9EX4tRSaQP3Fqms5GFRWODPNtfxUfQNPF+NA
        3BiVMjkg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jr0jm-0005xW-C6; Thu, 02 Jul 2020 15:02:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5DFAE3013E5;
        Thu,  2 Jul 2020 17:02:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4124925F1BEE2; Thu,  2 Jul 2020 17:02:50 +0200 (CEST)
Date:   Thu, 2 Jul 2020 17:02:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, cj.chengjian@huawei.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        lkft-triage@lists.linaro.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: Perf: WARNING: arch/x86/entry/common.c:624
 idtentry_exit_cond_rcu+0x92/0xc0
Message-ID: <20200702150250.GS4800@hirez.programming.kicks-ass.net>
References: <87imfwd5f6.fsf@nanos.tec.linutronix.de>
 <8DD3180E-0E69-4FD6-92C3-311AAB3F688F@amacapital.net>
 <87d064d13p.fsf@nanos.tec.linutronix.de>
 <CA+G9fYvVEMVaF=qzhCpJ8NMb1-VN4cEh6sw8P_eNFCLQYOjCzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvVEMVaF=qzhCpJ8NMb1-VN4cEh6sw8P_eNFCLQYOjCzA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 07:57:54PM +0530, Naresh Kamboju wrote:
> I have reported this warning on linux-next and now it is happening on
> linux mainline tree.
> May I know , are we missing a fix patch on linus 's tree ?
> 
> - Naresh
> ---
> While running selftest x86 single_step_syscall_32 on
> i386 kernel linux 5.8.0-rc3 kernel warning noticed.
> 
> steps to reproduce:
> --------------------------
> perf test
> and
> cd /opt/kselftests/default-in-kernel/x86
> ./single_step_syscall_32
> 
> crash dump,
> [ 1324.774385] kselftest: Running tests in x86
> [ 1324.830187] ------------[ cut here ]------------
> [ 1324.834820] IRQs not disabled as expected
> [ 1324.838838] WARNING: CPU: 2 PID: 5365 at
> /usr/src/kernel/arch/x86/entry/common.c:645
> idtentry_exit_cond_rcu+0x92/0xc0

How's this?

DEFINE_IDTENTRY_DEBUG() is DEFINE_IDTENTRY_RAW on x86_64
                           DEFINE_IDTENTRY on i386

calling exc_debug_*() from DEFINE_IDTENTRY() does a double layer of
idtentry_{enter,exit}*() functions.

Also, handle_debug() is still a trainwreck, we should never get to
cond_local_irq_enable() when !user.

Completely untested...

---
 arch/x86/kernel/traps.c | 49 +++++++++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index b0195771c932..47d6b46e1564 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -806,8 +806,17 @@ static void handle_debug(struct pt_regs *regs, unsigned long dr6, bool user)
 	 * If DR6 is zero, no point in trying to handle it. The kernel is
 	 * not using INT1.
 	 */
-	if (!user && !dr6)
-		return;
+	if (!user) {
+		/*
+		 * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
+		 * watchpoint at the same time then that will still be handled.
+		 */
+		if ((dr6 & DR_STEP) && is_sysenter_singlestep(regs))
+			dr6 &= ~DR_STEP;
+
+		if (!dr6)
+			return;
+	}
 
 	/*
 	 * If dr6 has no reason to give us about the origin of this trap,
@@ -859,25 +868,29 @@ static void handle_debug(struct pt_regs *regs, unsigned long dr6, bool user)
 	cond_local_irq_disable(regs);
 }
 
+#ifdef CONFIG_X86_64
 static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 					     unsigned long dr6)
 {
 	bool irq_state = idtentry_enter_nmi(regs);
 	instrumentation_begin();
 
-	/*
-	 * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
-	 * watchpoint at the same time then that will still be handled.
-	 */
-	if ((dr6 & DR_STEP) && is_sysenter_singlestep(regs))
-		dr6 &= ~DR_STEP;
-
 	handle_debug(regs, dr6, false);
 
 	instrumentation_end();
 	idtentry_exit_nmi(regs, irq_state);
 }
 
+/* IST stack entry */
+DEFINE_IDTENTRY_DEBUG(exc_debug)
+{
+	unsigned long dr6, dr7;
+
+	debug_enter(&dr6, &dr7);
+	exc_debug_kernel(regs, dr6);
+	debug_exit(dr7);
+}
+
 static __always_inline void exc_debug_user(struct pt_regs *regs,
 					   unsigned long dr6)
 {
@@ -890,17 +903,6 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 	idtentry_exit_user(regs);
 }
 
-#ifdef CONFIG_X86_64
-/* IST stack entry */
-DEFINE_IDTENTRY_DEBUG(exc_debug)
-{
-	unsigned long dr6, dr7;
-
-	debug_enter(&dr6, &dr7);
-	exc_debug_kernel(regs, dr6);
-	debug_exit(dr7);
-}
-
 /* User entry, runs on regular task stack */
 DEFINE_IDTENTRY_DEBUG_USER(exc_debug)
 {
@@ -917,12 +919,7 @@ DEFINE_IDTENTRY_DEBUG(exc_debug)
 	unsigned long dr6, dr7;
 
 	debug_enter(&dr6, &dr7);
-
-	if (user_mode(regs))
-		exc_debug_user(regs, dr6);
-	else
-		exc_debug_kernel(regs, dr6);
-
+	handle_debug(regs, dr6, user_mode(regs));
 	debug_exit(dr7);
 }
 #endif
