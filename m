Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E336CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42563206B5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kBP+hi0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbgHFRZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729447AbgHFRC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:02:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C6CC034614
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 06:17:11 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y3so43975387wrl.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 06:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C+eYpjO9tZjVIJJgZzQi1cMIXwcXEBDu4nry89JkOG4=;
        b=kBP+hi0Qq1lASdndGc9TwGlcTEsQtMAruql90jWjNa+KHWlJxz9VyPAtY3r4xk2shA
         HAaNxAH8ofgwSMfVludF/QCMr+gtDr+RHY9GNu8atIJ8pFmIGK5RIQB97t9koh2j7bea
         B2SwMjl08xCkBRFrvj1jlrGiJp/xH7Fnw3e0UociQxDltXfqZxAdMBMcJpZf+NlwUeHl
         cHSW94hBu+08pE46xwr/rTNJQ207g7CI262swiSxflzYBqcrrApHipL1PnxFAVThjhZr
         u/Y9C49mfU7x07rVohPN2X0dDpnVxgGzND6EvSu1+X/2uTUzk4sPjmIQsGJiNeGesE+Q
         DWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C+eYpjO9tZjVIJJgZzQi1cMIXwcXEBDu4nry89JkOG4=;
        b=O9jqoIpGIAz3aIJfqV1cK9Gek7td9FQa3W5rPUo8Xm3EFybLQamKFq3e6b4+8+7p7s
         rmyTAhansd3mywX9+mIbTHKNttnU11fy9AldlDi/g/LnBXiOoZ3xX7XvpiHOxfS1+ZQt
         ZRoi+LrKOsZ+NyvgE/FI1D2dcNfUF42RM/aUpgjxHvU5UqSbUDMyVmdSHaIOnetrACMm
         F7BwkQRgaIJt0IFyat1x4JAxrL0Fir/lkOIPxafwB4i4Ji3mRLTH+PP0sIU6XQJ///H2
         0GLc+A2iy3RzxwsNCs/FoVvU2FVFbPgbfnCV61/Ldp6pv/py+AcrfGDa7BWaoQYDv22P
         OFlQ==
X-Gm-Message-State: AOAM530LFwXon5e8ZlfPqwMgtgn8x9XVcZcOrX4Jcuw5iwk0gBUbxJkI
        ilxGd4PsGGOaBnnly89Mby5ODA==
X-Google-Smtp-Source: ABdhPJy0gYJlF2jm5jVqNCatcnexGp8DMCWE30pPCQznWyFGq6DTjo+CQiXzPcJ4SGKs9EX2nGXU/w==
X-Received: by 2002:a5d:5682:: with SMTP id f2mr7283059wrv.248.1596719829770;
        Thu, 06 Aug 2020 06:17:09 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id a10sm6529088wrx.15.2020.08.06.06.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 06:17:07 -0700 (PDT)
Date:   Thu, 6 Aug 2020 15:17:02 +0200
From:   Marco Elver <elver@google.com>
To:     peterz@infradead.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        fenghua.yu@intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        yu-cheng.yu@intel.com, jgross@suse.com, sdeep@vmware.com,
        virtualization@lists.linux-foundation.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*()
 helpers
Message-ID: <20200806131702.GA3029162@elver.google.com>
References: <0000000000007d3b2d05ac1c303e@google.com>
 <20200805132629.GA87338@elver.google.com>
 <20200805134232.GR2674@hirez.programming.kicks-ass.net>
 <20200805135940.GA156343@elver.google.com>
 <20200805141237.GS2674@hirez.programming.kicks-ass.net>
 <20200805141709.GD35926@hirez.programming.kicks-ass.net>
 <CANpmjNN6FWZ+MsAn3Pj+WEez97diHzqF8hjONtHG15C2gSpSgw@mail.gmail.com>
 <CANpmjNNy3XKQqgrjGPPKKvXhAoF=mae7dk8hmoS4k4oNnnB=KA@mail.gmail.com>
 <20200806074723.GA2364872@elver.google.com>
 <20200806113236.GZ2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806113236.GZ2674@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 01:32PM +0200, peterz@infradead.org wrote:
> On Thu, Aug 06, 2020 at 09:47:23AM +0200, Marco Elver wrote:
> > Testing my hypothesis that raw then nested non-raw
> > local_irq_save/restore() breaks IRQ state tracking -- see the reproducer
> > below. This is at least 1 case I can think of that we're bound to hit.
...
> 
> /me goes ponder things...
> 
> How's something like this then?
> 
> ---
>  include/linux/sched.h |  3 ---
>  kernel/kcsan/core.c   | 62 ++++++++++++++++++++++++++++++++++++---------------
>  2 files changed, 44 insertions(+), 21 deletions(-)

Thank you! That approach seems to pass syzbot (also with
CONFIG_PARAVIRT) and kcsan-test tests.

I had to modify it some, so that report.c's use of the restore logic
works and not mess up the IRQ trace printed on KCSAN reports (with
CONFIG_KCSAN_VERBOSE).

I still need to fully convince myself all is well now and we don't end
up with more fixes. :-) If it passes further testing, I'll send it as a
real patch (I want to add you as Co-developed-by, but would need your
Signed-off-by for the code you pasted, I think.)

Thanks,
-- Marco

------ >8 ------

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 9147ff6a12e5..b1d5dca10aa5 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -4,6 +4,7 @@
 #include <linux/bug.h>
 #include <linux/delay.h>
 #include <linux/export.h>
+#include <linux/ftrace.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -291,13 +292,28 @@ static inline unsigned int get_delay(void)
 				0);
 }
 
-void kcsan_save_irqtrace(struct task_struct *task)
-{
+/*
+ * KCSAN instrumentation is everywhere, which means we must treat the hooks
+ * NMI-like for interrupt tracing. In order to present a 'normal' as possible
+ * context to the code called by KCSAN when reporting errors we need to update
+ * the IRQ-tracing state.
+ *
+ * Save and restore the IRQ state trace touched by KCSAN, since KCSAN's
+ * runtime is entered for every memory access, and potentially useful
+ * information is lost if dirtied by KCSAN.
+ */
+
+struct kcsan_irq_state {
+	unsigned long		flags;
 #ifdef CONFIG_TRACE_IRQFLAGS
-	task->kcsan_save_irqtrace = task->irqtrace;
+	int			hardirqs;
 #endif
-}
+};
 
+/*
+ * This is also called by the reporting task for the other task, to generate the
+ * right report with CONFIG_KCSAN_VERBOSE. No harm in restoring more than once.
+ */
 void kcsan_restore_irqtrace(struct task_struct *task)
 {
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -305,6 +321,34 @@ void kcsan_restore_irqtrace(struct task_struct *task)
 #endif
 }
 
+static void kcsan_irq_save(struct kcsan_irq_state *irq_state) {
+#ifdef CONFIG_TRACE_IRQFLAGS
+	current->kcsan_save_irqtrace = current->irqtrace;
+	irq_state->hardirqs = lockdep_hardirqs_enabled();
+#endif
+	if (!kcsan_interrupt_watcher) {
+		raw_local_irq_save(irq_state->flags);
+		kcsan_disable_current(); /* Lockdep might WARN. */
+		lockdep_hardirqs_off(CALLER_ADDR0);
+		kcsan_enable_current();
+	}
+}
+
+static void kcsan_irq_restore(struct kcsan_irq_state *irq_state) {
+	if (!kcsan_interrupt_watcher) {
+#ifdef CONFIG_TRACE_IRQFLAGS
+		if (irq_state->hardirqs) {
+			kcsan_disable_current(); /* Lockdep might WARN. */
+			lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+			lockdep_hardirqs_on(CALLER_ADDR0);
+			kcsan_enable_current();
+		}
+#endif
+		raw_local_irq_restore(irq_state->flags);
+	}
+	kcsan_restore_irqtrace(current);
+}
+
 /*
  * Pull everything together: check_access() below contains the performance
  * critical operations; the fast-path (including check_access) functions should
@@ -350,11 +394,13 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 	flags = user_access_save();
 
 	if (consumed) {
-		kcsan_save_irqtrace(current);
+		struct kcsan_irq_state irqstate;
+
+		kcsan_irq_save(&irqstate);
 		kcsan_report(ptr, size, type, KCSAN_VALUE_CHANGE_MAYBE,
 			     KCSAN_REPORT_CONSUMED_WATCHPOINT,
 			     watchpoint - watchpoints);
-		kcsan_restore_irqtrace(current);
+		kcsan_irq_restore(&irqstate);
 	} else {
 		/*
 		 * The other thread may not print any diagnostics, as it has
@@ -387,7 +433,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	unsigned long access_mask;
 	enum kcsan_value_change value_change = KCSAN_VALUE_CHANGE_MAYBE;
 	unsigned long ua_flags = user_access_save();
-	unsigned long irq_flags = 0;
+	struct kcsan_irq_state irqstate;
 
 	/*
 	 * Always reset kcsan_skip counter in slow-path to avoid underflow; see
@@ -412,14 +458,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		goto out;
 	}
 
-	/*
-	 * Save and restore the IRQ state trace touched by KCSAN, since KCSAN's
-	 * runtime is entered for every memory access, and potentially useful
-	 * information is lost if dirtied by KCSAN.
-	 */
-	kcsan_save_irqtrace(current);
-	if (!kcsan_interrupt_watcher)
-		local_irq_save(irq_flags);
+	kcsan_irq_save(&irqstate);
 
 	watchpoint = insert_watchpoint((unsigned long)ptr, size, is_write);
 	if (watchpoint == NULL) {
@@ -559,9 +598,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	remove_watchpoint(watchpoint);
 	kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
 out_unlock:
-	if (!kcsan_interrupt_watcher)
-		local_irq_restore(irq_flags);
-	kcsan_restore_irqtrace(current);
+	kcsan_irq_restore(&irqstate);
 out:
 	user_access_restore(ua_flags);
 }
diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
index 29480010dc30..6eb35a9514d8 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -24,9 +24,8 @@ extern unsigned int kcsan_udelay_interrupt;
 extern bool kcsan_enabled;
 
 /*
- * Save/restore IRQ flags state trace dirtied by KCSAN.
+ * Restore IRQ flags state trace dirtied by KCSAN.
  */
-void kcsan_save_irqtrace(struct task_struct *task);
 void kcsan_restore_irqtrace(struct task_struct *task);
 
 /*
