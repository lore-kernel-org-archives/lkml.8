Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47910C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F675221F7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="hLdw1dgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgDRUT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728309AbgDRUT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:19:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B718C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:19:56 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v8so7554083wma.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XXu2EOFwJavz3sK6MiIiM003uWlBfkQUW8XMZdi2rI4=;
        b=hLdw1dgXD8QL7F9IN8HjsdFrjRGya2Qu8Nt4XumpRlA0bBqDdSBqiKGPaq3qZ7ALgL
         37sEETZubQPijQtPgdKOclqxjMX8srzDounku684TU+5Hsk3JoSm9MRkAM1P6IcTtnQO
         fkG8/6FNAyJV8CljgnyqbXRz4FXg3+vKLL2Sfek5oRoQ5LL+H4FwToztD9CSV52RmOb0
         iF77J6yvfMGFpe5/wFBWMaxLcay6tFkA3UwXnW5+8o8YyTdgCCs+mU/+Tz54GxEgpSFa
         CXrGBfT5/Tq8DoADw19+8J5Z43rRHnyJJYregcIaqjoZ1hGnoMBRkYgdWpj3PqhchHGl
         vz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XXu2EOFwJavz3sK6MiIiM003uWlBfkQUW8XMZdi2rI4=;
        b=jwLCRFDKXXRuXIyjYZHG3eOBmEnESjwIs+3ZBrj9KTy9wYHOE0O6Gts1lVrFZmXpWJ
         rjXLb7Cjb7fH9kLr9wxH7kIO5Dt3nkGuJ14kdo3czbHlNamMAtggVawwieqUju/6QKSD
         JHJUyLRowwaFVAdmkBtKRJN/NUTOzqFMdzkxjgkokUePVeLIZndE03v47Q8lNICpLCZd
         jvvmiRTTP8OanxnV9X/vrPU+CqVWvzQZibFSOu+I3MzVr5lg3Jp6lBJFZAVYb8mI5YJp
         4hIX0bXshXaZyQ3kiFwUQnZP1TIHfNKuskV0fFXNjTbGVYwK68NNuP2bqVA451v9oeBp
         nOhw==
X-Gm-Message-State: AGi0PubcltOjuZOqyzKz1dQWtov02uqXPheO5fhmw+VEM7ZP9erTaNE4
        zuR8ZagnwGGxQGDy5i/GPfqapCOescs=
X-Google-Smtp-Source: APiQypJ1Cx2HyQcpiB0vGYBK/9Eka/kgnic/uwCXfZXsEXX4WDIKQFvneOrQbabjbpyl2HHgVAzBMA==
X-Received: by 2002:a1c:e284:: with SMTP id z126mr10038438wmg.32.1587241194635;
        Sat, 18 Apr 2020 13:19:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:19:54 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCHv3 03/50] arc: Add show_stack_loglvl()
Date:   Sat, 18 Apr 2020 21:18:57 +0100
Message-Id: <20200418201944.482088-4-dima@arista.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200418201944.482088-1-dima@arista.com>
References: <20200418201944.482088-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the log-level of show_stack() depends on a platform
realization. It creates situations where the headers are printed with
lower log level or higher than the stacktrace (depending on
a platform or user).

Furthermore, it forces the logic decision from user to an architecture
side. In result, some users as sysrq/kdb/etc are doing tricks with
temporary rising console_loglevel while printing their messages.
And in result it not only may print unwanted messages from other CPUs,
but also omit printing at all in the unlucky case where the printk()
was deferred.

Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
an easier approach than introducing more printk buffers.
Also, it will consolidate printings with headers.

Introduce show_stack_loglvl(), that eventually will substitute
show_stack().

As a good side-effect header "Stack Trace:" is now printed with the same
log level as the rest of backtrace.

Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arc/include/asm/bug.h     |  3 ++-
 arch/arc/kernel/stacktrace.c   | 21 +++++++++++++++------
 arch/arc/kernel/troubleshoot.c |  2 +-
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/arc/include/asm/bug.h b/arch/arc/include/asm/bug.h
index 0be19fd1a412..4c453ba96c51 100644
--- a/arch/arc/include/asm/bug.h
+++ b/arch/arc/include/asm/bug.h
@@ -13,7 +13,8 @@
 struct task_struct;
 
 void show_regs(struct pt_regs *regs);
-void show_stacktrace(struct task_struct *tsk, struct pt_regs *regs);
+void show_stacktrace(struct task_struct *tsk, struct pt_regs *regs,
+		     const char *loglvl);
 void show_kernel_fault_diag(const char *str, struct pt_regs *regs,
 			    unsigned long address);
 void die(const char *str, struct pt_regs *regs, unsigned long address);
diff --git a/arch/arc/kernel/stacktrace.c b/arch/arc/kernel/stacktrace.c
index 1e440bbfa876..24f9cd8a12c9 100644
--- a/arch/arc/kernel/stacktrace.c
+++ b/arch/arc/kernel/stacktrace.c
@@ -158,9 +158,11 @@ arc_unwind_core(struct task_struct *tsk, struct pt_regs *regs,
 /* Call-back which plugs into unwinding core to dump the stack in
  * case of panic/OOPs/BUG etc
  */
-static int __print_sym(unsigned int address, void *unused)
+static int __print_sym(unsigned int address, void *arg)
 {
-	printk("  %pS\n", (void *)address);
+	const char *loglvl = arg;
+
+	printk("%s  %pS\n", loglvl, (void *)address);
 	return 0;
 }
 
@@ -217,17 +219,24 @@ static int __get_first_nonsched(unsigned int address, void *unused)
  *-------------------------------------------------------------------------
  */
 
-noinline void show_stacktrace(struct task_struct *tsk, struct pt_regs *regs)
+noinline void show_stacktrace(struct task_struct *tsk, struct pt_regs *regs,
+			      const char *loglvl)
 {
-	pr_info("\nStack Trace:\n");
-	arc_unwind_core(tsk, regs, __print_sym, NULL);
+	printk("%s\nStack Trace:\n", loglvl);
+	arc_unwind_core(tsk, regs, __print_sym, (void *)loglvl);
 }
 EXPORT_SYMBOL(show_stacktrace);
 
 /* Expected by sched Code */
+void show_stack_loglvl(struct task_struct *tsk, unsigned long *sp,
+			const char *loglvl)
+{
+	show_stacktrace(tsk, NULL, loglvl);
+}
+
 void show_stack(struct task_struct *tsk, unsigned long *sp)
 {
-	show_stacktrace(tsk, NULL);
+	show_stack_loglvl(tsk, sp, KERN_DEFAULT);
 }
 
 /* Another API expected by schedular, shows up in "ps" as Wait Channel
diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troubleshoot.c
index d2999503fb8a..660681101523 100644
--- a/arch/arc/kernel/troubleshoot.c
+++ b/arch/arc/kernel/troubleshoot.c
@@ -242,5 +242,5 @@ void show_kernel_fault_diag(const char *str, struct pt_regs *regs,
 
 	/* Show stack trace if this Fatality happened in kernel mode */
 	if (!user_mode(regs))
-		show_stacktrace(current, regs);
+		show_stacktrace(current, regs, KERN_DEFAULT);
 }
-- 
2.26.0

