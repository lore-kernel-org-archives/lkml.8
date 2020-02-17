Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D951FC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 22:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985E520725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 22:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnqO/A6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgBQWby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 17:31:54 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42281 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgBQWby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 17:31:54 -0500
Received: by mail-oi1-f195.google.com with SMTP id j132so18198571oih.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 14:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=B0lEUkPsP9/q2h0+ZuiYNjS6O3pHjIXbnd7W1+Eb6eA=;
        b=AnqO/A6GcBpYBzuIE8HqU/KWxmwAUzAzufnTEupJvBlpVYA63mZYs3t0xC4j/HYVxi
         TTBuv583hpl2rDw3A0uQM623T4LsZLVqGIP8ThNkEhYXt7PBBr3gEL0CZx7qdb15+zaR
         qqBmTrgDFu3SCagwxwfzX80OW0akFMyMaDdPbQfcd5y+01fu2xdAVDSvTOCyOHYZgFg7
         oLgVXv70hg3DgaWOtySHGNNFa81MRTU8ULXNcctSrzWsCV4Al9fA3CgoqXQ1FHYzpO3X
         c2os1oHUvXNm/jQfoQqoN7VvMkEBtD9DC8dxg8ueFaHL+pgLDLmnoF1tQYMjIok942F3
         sEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=B0lEUkPsP9/q2h0+ZuiYNjS6O3pHjIXbnd7W1+Eb6eA=;
        b=k+QpcQL5EiBvy4VFBei1XrlV/M+VhanXVvYtnZKS9cFFxgkP1J8XrF/JnZbFXCEf6v
         mks8y/r5CYA2whPMhNti8D6UIkgZeFrK53iUOR+ourWrN+dKU6CDonI1DcqLfs/kab4V
         jiqOQp5x1zN9yglkfE+/YNygOwxgmGKno/lp0XPT7KIyCdOxzXRdsHbEaZ3YmLbvnYi5
         hRUZ4waEIJmQN3CsJkCiNm45ZhJwIGFHUeKN4AqPm0KqCEeHVucvLVQXdzoX4jrlunQ1
         Pi93OHX3j7PzvFZKYSgWcx1katGOMIh654Wvb7l/6QUQV+hsc/5uVEOamGgp3PIOKQte
         1EdQ==
X-Gm-Message-State: APjAAAWceAFcFFBZ0kiSSFBrRtzJAfEBz6dZ+m5f/G8arcSBbz9+yrgL
        wB6FKM0ZIgbL+lV1wsYkeQ==
X-Google-Smtp-Source: APXvYqyq6XtQ+bHsWfPYX+2GztQLhg8f1VFMUciVZnEx7DFukGijtHQQbYqlSU4IVSdUVEF4ixroeA==
X-Received: by 2002:a05:6808:8ee:: with SMTP id d14mr753245oic.138.1581978712229;
        Mon, 17 Feb 2020 14:31:52 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id w6sm639107otp.69.2020.02.17.14.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 14:31:51 -0800 (PST)
Received: from t560.minyard.net (unknown [IPv6:2001:470:b8f6:1b:3904:1a7:d573:1ea3])
        by serve.minyard.net (Postfix) with ESMTPA id D249A18016D;
        Mon, 17 Feb 2020 22:31:50 +0000 (UTC)
From:   minyard@acm.org
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH] arm64:kgdb: Fix kernel single-stepping
Date:   Mon, 17 Feb 2020 16:31:45 -0600
Message-Id: <20200217223145.1856-1-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

I was working on a single-step bug on kgdb on an ARM64 system, and I saw
this scenario:

* A single step is setup to return to el1
* The ERET return to el1
* An interrupt is pending and runs before the instruction
* As soon as PSTATE.D (the debug disable bit) is cleared, the single
    step happens in that location, not where it should have.

This appears to be due to PSTATE.SS not being cleared when the exception
happens.  Per section D.2.12.5 of the ARMv8 reference manual, that
appears to be incorrect, it says "As part of exception entry, the PE
does all of the following: ...  Sets PSTATE.SS to 0."

However, I appear to not be the first person who has noticed this.  In
the el0-only portion of the kernel_entry macro in entry.S, I found the
following comment: "Ensure MDSCR_EL1.SS is clear, since we can unmask
debug exceptions when scheduling."  Exactly the same scenario, except
coming from a userland single step, not a kernel one.

As I was studying this, though, I realized that the following scenario
had an issue:

* Kernel enables MDSCR.SS, MDSCR.KDE, MDSCR.MDE (unnecessary), and
  PSTATE.SS to enable a single step in el1, for kgdb or kprobes,
  on the current CPU's MDSCR register and the process' PSTATE.SS
  register.
* Kernel returns from the exception with ERET.
* An interrupt or page fault happens on the instruction, causing the
  instruction to not be run, but the exception handler runs.
* The exception causes the task to migrate to a new core.
* The return from the exception runs on a different processor now,
  where the MDSCR values are not set up for a single step.
* The single step fails to happen.

This is bad for kgdb, of course, but it seems really bad for kprobes if
this happens.

To fix both these problems, rework the handling of single steps to clear
things out upon entry to the kernel from el1, and then to set up single
step when returning to el1, and not do the setup in debug-monitors.c.
This means that single stepping does not use
enable/disable_debug_monitors(); it is no longer necessary to track
those flags for single stepping.  This is much like single stepping is
handled for el0.  A new flag is added in pt_regs to enable single
stepping from el1.  Unfortunately, the old value of PSTATE.SS cannot be
used for this because of the hardware bug mentioned earlier.

As part of this, there is an interaction between single stepping and the
other users of debug monitors with the MDSCR.KDE bit.  That bit has to
be set for both hardware breakpoints at el1 and single stepping at el1.
A new variable was created to store the cpu-wide value of MDSCR.KDE; the
single stepping code makes sure not to clear that bit on kernel entry if
it's set in the per-cpu variable.

After fixing this and doing some more testing, I ran into another issue:

* Kernel enables the pt_regs single step
* Kernel returns from the exception with ERET.
* An interrupt or page fault happens on the instruction, causing the
  instruction to not be run, but the exception handler runs.
* The exception handling hits a breakpoint and stops.
* The user continues from the breakpoint, so the kernel is no longer
  expecting a single step.
* On the return from the first exception, the single step flag in
  pt_regs is still set, so a single step trap happens.
* The kernel keels over from an unexpected single step.

There's no easy way to find the pt_regs that has the single step flag
set.  So a thread info flag was added so that the single step could be
disabled in this case.  Both that flag and the flag in pt_regs must be
set to enable a single step.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
This patch is not a hack like the previous one, I think it covers all
the bases and works correctly in all cases.

In response to the first patch, Will said:

> This should all be handled by kgdb itself, not by changing the low-level
> debug exception handling. For example, the '&kgdb_step_hook' can take
> care of re-arming the step state machine and kgdb can also simply disable
> interrupts during the step if it doesn't want to step into the handler.

To answer these, I think if you read the scenarios above you will see
that kgdb cannot handle this in kgdb_step_hook.  The trouble is that
the step hook doesn't run.  Plus, even if it could be fixed there,
 kprobes will still have the issue.

As far as disabling interrupts during the step, well, that's changing
the behaviour of the system.  Plus, it won't help for a page fault.

-corey

 arch/arm64/include/asm/debug-monitors.h |  3 +-
 arch/arm64/include/asm/ptrace.h         |  4 +-
 arch/arm64/include/asm/thread_info.h    |  1 +
 arch/arm64/kernel/asm-offsets.c         |  1 +
 arch/arm64/kernel/debug-monitors.c      | 61 ++++++++++++++++++++++---
 arch/arm64/kernel/entry.S               | 37 +++++++++++++++
 arch/arm64/kernel/kgdb.c                |  6 ++-
 7 files changed, 102 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 7619f473155f..02842fef74bb 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -13,7 +13,8 @@
 #include <asm/ptrace.h>
 
 /* Low-level stepping controls. */
-#define DBG_MDSCR_SS		(1 << 0)
+#define DBG_MDSCR_SS_BIT	0
+#define DBG_MDSCR_SS		(1 << DBG_MDSCR_SS_BIT)
 #define DBG_SPSR_SS		(1 << 21)
 
 /* MDSCR_EL1 enabling bits */
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index bf57308fcd63..61b69f1f7c26 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -169,11 +169,11 @@ struct pt_regs {
 	};
 	u64 orig_x0;
 #ifdef __AARCH64EB__
-	u32 unused2;
+	u32 ss_enable; /* Kernel single-step for a task */
 	s32 syscallno;
 #else
 	s32 syscallno;
-	u32 unused2;
+	u32 ss_enable;
 #endif
 
 	u64 orig_addr_limit;
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index f0cec4160136..445519a5d2c9 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -78,6 +78,7 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define TIF_SVE_VL_INHERIT	24	/* Inherit sve_vl_onexec across exec */
 #define TIF_SSBD		25	/* Wants SSB mitigation */
 #define TIF_TAGGED_ADDR		26	/* Allow tagged user addresses */
+#define TIF_KERNEL_SINGLESTEP	27	/* Single-stepping in EL1. */
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index a5bdce8af65b..038e76d2f0c4 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -62,6 +62,7 @@ int main(void)
   DEFINE(S_PSTATE,		offsetof(struct pt_regs, pstate));
   DEFINE(S_PC,			offsetof(struct pt_regs, pc));
   DEFINE(S_SYSCALLNO,		offsetof(struct pt_regs, syscallno));
+  DEFINE(S_SS_ENABLE,		offsetof(struct pt_regs, ss_enable));
   DEFINE(S_ORIG_ADDR_LIMIT,	offsetof(struct pt_regs, orig_addr_limit));
   DEFINE(S_PMR_SAVE,		offsetof(struct pt_regs, pmr_save));
   DEFINE(S_STACKFRAME,		offsetof(struct pt_regs, stackframe));
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 48222a4760c2..9260f1cfe985 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -77,6 +77,14 @@ early_param("nodebugmon", early_debug_disable);
 static DEFINE_PER_CPU(int, mde_ref_count);
 static DEFINE_PER_CPU(int, kde_ref_count);
 
+/*
+ * The KDE bit must be set for hardware breakpoints or single stepping
+ * to work in the kernel.  So when a kernel single-step finishes, it
+ * will clear the SS bit and the KDE bit.  It uses the below to restore
+ * the KDE bit if we need it set for hardware breakpoints.
+ */
+DEFINE_PER_CPU_READ_MOSTLY(u64, mdscr_debug_bits);
+
 void enable_debug_monitors(enum dbg_active_el el)
 {
 	u32 mdscr, enable = 0;
@@ -94,6 +102,7 @@ void enable_debug_monitors(enum dbg_active_el el)
 		mdscr = mdscr_read();
 		mdscr |= enable;
 		mdscr_write(mdscr);
+		__this_cpu_write(mdscr_debug_bits, mdscr & DBG_MDSCR_KDE);
 	}
 }
 NOKPROBE_SYMBOL(enable_debug_monitors);
@@ -115,6 +124,7 @@ void disable_debug_monitors(enum dbg_active_el el)
 		mdscr = mdscr_read();
 		mdscr &= disable;
 		mdscr_write(mdscr);
+		__this_cpu_write(mdscr_debug_bits, mdscr & DBG_MDSCR_KDE);
 	}
 }
 NOKPROBE_SYMBOL(disable_debug_monitors);
@@ -405,27 +415,66 @@ void user_fastforward_single_step(struct task_struct *task)
 }
 
 /* Kernel API */
+
+/*
+ * The task that is currently being single-stepped.  There can be only
+ * one.
+ */
+struct task_struct *single_step_task;
+
+/*
+ * Why, you may ask, does this have both regs->ss_enable and
+ * TIF_KERNEL_SINGLESTEP to enable single stepping?  The trouble lies
+ * in nested exceptions in the kernel.  If an interrupt is pending
+ * when a single-step occurs, it will happen before the single step,
+ * and it will go through the el1 kernel entry.
+ *
+ * One scenario is that another exception may occur during this
+ * interrupt processing.  If you only had TIF_KERNEL_SINGLESTEP, single
+ * stepping would be enabled there, but that's the wrong place.  So you
+ * have to rely on regs->ss_enabled to tell you if that is the case,
+ * since it won't be enabled in the second interrupt handler.
+ *
+ * A breakpoint may be hit during this interrupt, and the kernel will
+ * stop there.  But if you only had regs->ss_enabled, you couldn't
+ * disable the single stepping since you have no idea where regs is
+ * you return from kgdb.  So when it returned, it would hit the single
+ * step, and the kernel would die from an unknown single step source.
+ * So you have TIF_KERNEL_SINGLESTEP to prevent that problem.  The
+ * task being single-stepped is saved and the flag cleared when it is
+ * disabled.
+ *
+ * It would be nice to be able to use SPSR.SS instead of having a
+ * separate regs->ss_enable flag.  However, some processors don't
+ * clear PSTATE.SS on an exception, so SPSR.SS will be set in
+ * subsequent exception handlers.
+ */
 void kernel_enable_single_step(struct pt_regs *regs)
 {
 	WARN_ON(!irqs_disabled());
-	set_regs_spsr_ss(regs);
-	mdscr_write(mdscr_read() | DBG_MDSCR_SS);
-	enable_debug_monitors(DBG_ACTIVE_EL1);
+	regs->ss_enable = DBG_MDSCR_SS;
+	set_ti_thread_flag(task_thread_info(current), TIF_KERNEL_SINGLESTEP);
+	get_task_struct(current);
+	single_step_task = current;
 }
 NOKPROBE_SYMBOL(kernel_enable_single_step);
 
 void kernel_disable_single_step(void)
 {
 	WARN_ON(!irqs_disabled());
-	mdscr_write(mdscr_read() & ~DBG_MDSCR_SS);
-	disable_debug_monitors(DBG_ACTIVE_EL1);
+	if (single_step_task) {
+		clear_ti_thread_flag(task_thread_info(single_step_task),
+				     TIF_KERNEL_SINGLESTEP);
+		put_task_struct(single_step_task);
+		single_step_task = NULL;
+	}
 }
 NOKPROBE_SYMBOL(kernel_disable_single_step);
 
 int kernel_active_single_step(void)
 {
 	WARN_ON(!irqs_disabled());
-	return mdscr_read() & DBG_MDSCR_SS;
+	return single_step_task != NULL;
 }
 NOKPROBE_SYMBOL(kernel_active_single_step);
 
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 9461d812ae27..b1f98a81a226 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -25,6 +25,7 @@
 #include <asm/thread_info.h>
 #include <asm/asm-uaccess.h>
 #include <asm/unistd.h>
+#include <asm/debug-monitors.h>
 
 /*
  * Context tracking subsystem.  Used to instrument transitions
@@ -191,6 +192,25 @@ alternative_cb_end
 	mrs	x23, spsr_el1
 	stp	lr, x21, [sp, #S_LR]
 
+	.if \el != 0
+	/*
+	 * If single-step was enabled, save it off and disable it,
+	 * or it will trap on enable_dbg.
+	 * The restore code will re-enable it if necessary.
+	 */
+	mrs	x20, mdscr_el1
+	tbz	x20, #DBG_MDSCR_SS_BIT, 1f
+	ldr_this_cpu x19, mdscr_debug_bits, x21
+	bic	x21, x20, #DBG_MDSCR_SS
+	bic	x21, x21, #DBG_MDSCR_KDE
+	orr	x21, x21, x19
+	msr	mdscr_el1, x21
+1:
+	and	x20, x20, #DBG_MDSCR_SS
+	str	w20, [sp, #S_SS_ENABLE]
+	bic	x23, x23, #DBG_SPSR_SS
+	.endif /* \el != 0 */
+
 	/*
 	 * In order to be able to dump the contents of struct pt_regs at the
 	 * time the exception was taken (in case we attempt to walk the call
@@ -344,6 +364,23 @@ alternative_else_nop_endif
 	apply_ssbd 0, x0, x1
 	.endif
 
+	.if	\el != 0
+	/* Restore the single-step bit. */
+	ldr	w20, [sp, #S_SS_ENABLE]
+	tbz	w20, #DBG_MDSCR_SS_BIT, 6f
+	ldr	x20, [tsk, #TSK_TI_FLAGS]
+	tbz	x20, #TIF_KERNEL_SINGLESTEP, 6f
+	disable_daif
+	mrs	x20, mdscr_el1
+	orr	x20, x20, #DBG_MDSCR_SS // Enable single step
+	/* KDE must be set for SS in EL1 */
+	orr     x20, x20, #DBG_MDSCR_KDE
+	msr	mdscr_el1, x20
+	orr	x22, x22, #DBG_SPSR_SS
+6:
+	/* PSTATE.D and PSTATE.SS will be restored from SPSR_EL1. */
+	.endif
+
 	msr	elr_el1, x21			// set up the return data
 	msr	spsr_el1, x22
 	ldp	x0, x1, [sp, #16 * 0]
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 43119922341f..5b40f190f455 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -221,8 +221,10 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		/*
 		 * Enable single step handling
 		 */
-		if (!kernel_active_single_step())
-			kernel_enable_single_step(linux_regs);
+		if (kernel_active_single_step())
+			/* Clear out the old one */
+			kernel_disable_single_step();
+		kernel_enable_single_step(linux_regs);
 		err = 0;
 		break;
 	default:
-- 
2.17.1

