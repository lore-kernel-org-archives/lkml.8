Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69CCC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC23124673
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgAWTKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:10:34 -0500
Received: from mga09.intel.com ([134.134.136.24]:39995 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728827AbgAWTKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:10:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2020 11:06:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,354,1574150400"; 
   d="scan'208";a="222428406"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga008.fm.intel.com with ESMTP; 23 Jan 2020 11:06:03 -0800
Subject: [PATCH 3/5] x86/mpx: remove bounds exception code
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, peterz@infradead.org,
        luto@kernel.org, x86@kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 23 Jan 2020 11:05:01 -0800
References: <20200123190456.8E05ADE6@viggo.jf.intel.com>
In-Reply-To: <20200123190456.8E05ADE6@viggo.jf.intel.com>
Message-Id: <20200123190501.12D2A68C@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

MPX is being removed from the kernel due to a lack of support
in the toolchain going forward (gcc).

Remove the other user-visible ABI: signal handling.  This code
should basically have been inactive after the prctl()s were
removed, but there may be some small ABI remnants from this code.
Remove it.

Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: x86@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/traps.c |   74 ----------------------------------------------
 1 file changed, 74 deletions(-)

diff -puN arch/x86/kernel/traps.c~mpx-remove-do_bounds arch/x86/kernel/traps.c
--- a/arch/x86/kernel/traps.c~mpx-remove-do_bounds	2020-01-23 10:41:05.994942437 -0800
+++ b/arch/x86/kernel/traps.c	2020-01-23 10:41:05.998942437 -0800
@@ -57,8 +57,6 @@
 #include <asm/mach_traps.h>
 #include <asm/alternative.h>
 #include <asm/fpu/xstate.h>
-#include <asm/trace/mpx.h>
-#include <asm/mpx.h>
 #include <asm/vm86.h>
 #include <asm/umip.h>
 
@@ -430,8 +428,6 @@ dotraplinkage void do_double_fault(struc
 
 dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 {
-	const struct mpx_bndcsr *bndcsr;
-
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 	if (notify_die(DIE_TRAP, "bounds", regs, error_code,
 			X86_TRAP_BR, SIGSEGV) == NOTIFY_STOP)
@@ -441,76 +437,6 @@ dotraplinkage void do_bounds(struct pt_r
 	if (!user_mode(regs))
 		die("bounds", regs, error_code);
 
-	if (!cpu_feature_enabled(X86_FEATURE_MPX)) {
-		/* The exception is not from Intel MPX */
-		goto exit_trap;
-	}
-
-	/*
-	 * We need to look at BNDSTATUS to resolve this exception.
-	 * A NULL here might mean that it is in its 'init state',
-	 * which is all zeros which indicates MPX was not
-	 * responsible for the exception.
-	 */
-	bndcsr = get_xsave_field_ptr(XFEATURE_BNDCSR);
-	if (!bndcsr)
-		goto exit_trap;
-
-	trace_bounds_exception_mpx(bndcsr);
-	/*
-	 * The error code field of the BNDSTATUS register communicates status
-	 * information of a bound range exception #BR or operation involving
-	 * bound directory.
-	 */
-	switch (bndcsr->bndstatus & MPX_BNDSTA_ERROR_CODE) {
-	case 2:	/* Bound directory has invalid entry. */
-		if (mpx_handle_bd_fault())
-			goto exit_trap;
-		break; /* Success, it was handled */
-	case 1: /* Bound violation. */
-	{
-		struct task_struct *tsk = current;
-		struct mpx_fault_info mpx;
-
-		if (mpx_fault_info(&mpx, regs)) {
-			/*
-			 * We failed to decode the MPX instruction.  Act as if
-			 * the exception was not caused by MPX.
-			 */
-			goto exit_trap;
-		}
-		/*
-		 * Success, we decoded the instruction and retrieved
-		 * an 'mpx' containing the address being accessed
-		 * which caused the exception.  This information
-		 * allows and application to possibly handle the
-		 * #BR exception itself.
-		 */
-		if (!do_trap_no_signal(tsk, X86_TRAP_BR, "bounds", regs,
-				       error_code))
-			break;
-
-		show_signal(tsk, SIGSEGV, "trap ", "bounds", regs, error_code);
-
-		force_sig_bnderr(mpx.addr, mpx.lower, mpx.upper);
-		break;
-	}
-	case 0: /* No exception caused by Intel MPX operations. */
-		goto exit_trap;
-	default:
-		die("bounds", regs, error_code);
-	}
-
-	return;
-
-exit_trap:
-	/*
-	 * This path out is for all the cases where we could not
-	 * handle the exception in some way (like allocating a
-	 * table or telling userspace about it.  We will also end
-	 * up here if the kernel has MPX turned off at compile
-	 * time..
-	 */
 	do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, 0, NULL);
 }
 
_
