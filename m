Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE96EC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8993320658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="VBBjmFrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731765AbgCPOlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:41:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46865 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbgCPOlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:41:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id c19so10042538pfo.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mxQZWLD7ZJycSQtcTjW3rDH+hRkvx7KnYbAdTQK5KgQ=;
        b=VBBjmFrliWNWWPeKLcEesaN3ru++vhilB4PrrUmHyUf88Wu0JoPsC7U58HPISK9662
         0rvVcnfW/isi87cxtfLjFaQ7G0rVwNuk9OTTMfJeyMMC1jbUUhgC5c3HmL9Hw6jMOWGR
         fqNn7I5h72eGAaCj8odfEEOiVXPe2ucaKigOFK3du9fvxnfnNAZTztGTleBTfxnZOoEq
         cGy0a31DXsZ0GfzyZAZXuQYUxhEDDmxqnzuhaUTeL7NPtBpqRd8OG0vK14b/gcxlhP6r
         Hh+/ZF32rpUcWfTheCY2UMloyQUCIHz6pgTZbVtDlG8OgR+HRD6AORH49bbNvGgWl73j
         s8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mxQZWLD7ZJycSQtcTjW3rDH+hRkvx7KnYbAdTQK5KgQ=;
        b=WUbVmfhL0Fmesn3WhwbdMN+Uz2Nkg8HHiyB/b35pIbQWRmWXUbVDmWcjCktMooUsW2
         Je30aJUTVDVa1ay34J1xmsIk32aX4xXTlBYCo2TUUfJ37edj6DJksqmfRTfeowCMXcrA
         8p0W6wI1EAhtt437+CN/rNhYPVAp03pO6XU9sUoydwU9arvhfCFzWYUopJYviFbNTYP7
         7lLFtjjmWQSExXt5xQrBTZg/GIt7uTGrU/hPrtVOh9tCcKaGQRxEgCphkK7GHriFFIHQ
         Sl03N6VajOFAVBSSuVpKqVCm1bbbSgn2dyVyycsTO+6u8G45gJaRwXFJKOvWkB406Ibo
         hPKA==
X-Gm-Message-State: ANhLgQ0MIYq9invczti53hNlzf6LOrnYtYkXuTX+ygb91HW+eCSqNDLf
        nG5Jcq9D8leaBF3Od4QQ3ybBs7zqUApTEQ==
X-Google-Smtp-Source: ADFU+vs/PLweAzu1NAleAS3yYnv4aPH6WkXFQk3kIHhLc62Xz7ZQX0SizyDCAlSf3GH+2wmj0gR0bw==
X-Received: by 2002:a63:c445:: with SMTP id m5mr201674pgg.194.1584369663124;
        Mon, 16 Mar 2020 07:41:03 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:41:02 -0700 (PDT)
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
        Michal Simek <monstr@monstr.eu>
Subject: [PATCHv2 18/50] microblaze: Add loglvl to microblaze_unwind_inner()
Date:   Mon, 16 Mar 2020 14:38:44 +0000
Message-Id: <20200316143916.195608-19-dima@arista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316143916.195608-1-dima@arista.com>
References: <20200316143916.195608-1-dima@arista.com>
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

Add log level argument to microblaze_unwind_inner() as a preparation for
introducing show_stack_loglvl().

Cc: Michal Simek <monstr@monstr.eu>
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/microblaze/kernel/unwind.c | 38 ++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/microblaze/kernel/unwind.c b/arch/microblaze/kernel/unwind.c
index 4241cdd28ee7..804bf0c99d8b 100644
--- a/arch/microblaze/kernel/unwind.c
+++ b/arch/microblaze/kernel/unwind.c
@@ -154,7 +154,8 @@ static int lookup_prev_stack_frame(unsigned long fp, unsigned long pc,
 static void microblaze_unwind_inner(struct task_struct *task,
 				    unsigned long pc, unsigned long fp,
 				    unsigned long leaf_return,
-				    struct stack_trace *trace);
+				    struct stack_trace *trace,
+				    const char *loglvl);
 
 /**
  * unwind_trap - Unwind through a system trap, that stored previous state
@@ -162,16 +163,18 @@ static void microblaze_unwind_inner(struct task_struct *task,
  */
 #ifdef CONFIG_MMU
 static inline void unwind_trap(struct task_struct *task, unsigned long pc,
-				unsigned long fp, struct stack_trace *trace)
+				unsigned long fp, struct stack_trace *trace,
+				const char *loglvl)
 {
 	/* To be implemented */
 }
 #else
 static inline void unwind_trap(struct task_struct *task, unsigned long pc,
-				unsigned long fp, struct stack_trace *trace)
+				unsigned long fp, struct stack_trace *trace,
+				const char *loglvl)
 {
 	const struct pt_regs *regs = (const struct pt_regs *) fp;
-	microblaze_unwind_inner(task, regs->pc, regs->r1, regs->r15, trace);
+	microblaze_unwind_inner(task, regs->pc, regs->r1, regs->r15, trace, loglvl);
 }
 #endif
 
@@ -184,11 +187,13 @@ static inline void unwind_trap(struct task_struct *task, unsigned long pc,
  *				  the caller's return address.
  * @trace : Where to store stack backtrace (PC values).
  *	    NULL == print backtrace to kernel log
+ * @loglvl : Used for printk log level if (trace == NULL).
  */
 static void microblaze_unwind_inner(struct task_struct *task,
 			     unsigned long pc, unsigned long fp,
 			     unsigned long leaf_return,
-			     struct stack_trace *trace)
+			     struct stack_trace *trace,
+			     const char *loglvl)
 {
 	int ofs = 0;
 
@@ -214,11 +219,11 @@ static void microblaze_unwind_inner(struct task_struct *task,
 			const struct pt_regs *regs =
 				(const struct pt_regs *) fp;
 #endif
-			pr_info("HW EXCEPTION\n");
+			printk("%sHW EXCEPTION\n", loglvl);
 #ifndef CONFIG_MMU
 			microblaze_unwind_inner(task, regs->r17 - 4,
 						fp + EX_HANDLER_STACK_SIZ,
-						regs->r15, trace);
+						regs->r15, trace, loglvl);
 #endif
 			return;
 		}
@@ -228,8 +233,8 @@ static void microblaze_unwind_inner(struct task_struct *task,
 			if ((return_to >= handler->start_addr)
 			    && (return_to <= handler->end_addr)) {
 				if (!trace)
-					pr_info("%s\n", handler->trap_name);
-				unwind_trap(task, pc, fp, trace);
+					printk("%s%s\n", loglvl, handler->trap_name);
+				unwind_trap(task, pc, fp, trace, loglvl);
 				return;
 			}
 		}
@@ -248,13 +253,13 @@ static void microblaze_unwind_inner(struct task_struct *task,
 		} else {
 			/* Have we reached userland? */
 			if (unlikely(pc == task_pt_regs(task)->pc)) {
-				pr_info("[<%p>] PID %lu [%s]\n",
-					(void *) pc,
+				printk("%s[<%p>] PID %lu [%s]\n",
+					loglvl, (void *) pc,
 					(unsigned long) task->pid,
 					task->comm);
 				break;
 			} else
-				print_ip_sym(KERN_INFO, pc);
+				print_ip_sym(loglvl, pc);
 		}
 
 		/* Stop when we reach anything not part of the kernel */
@@ -285,11 +290,13 @@ static void microblaze_unwind_inner(struct task_struct *task,
  */
 void microblaze_unwind(struct task_struct *task, struct stack_trace *trace)
 {
+	const char *loglvl = KERN_INFO;
+
 	if (task) {
 		if (task == current) {
 			const struct pt_regs *regs = task_pt_regs(task);
 			microblaze_unwind_inner(task, regs->pc, regs->r1,
-						regs->r15, trace);
+						regs->r15, trace, loglvl);
 		} else {
 			struct thread_info *thread_info =
 				(struct thread_info *)(task->stack);
@@ -299,7 +306,8 @@ void microblaze_unwind(struct task_struct *task, struct stack_trace *trace)
 			microblaze_unwind_inner(task,
 						(unsigned long) &_switch_to,
 						cpu_context->r1,
-						cpu_context->r15, trace);
+						cpu_context->r15,
+						trace, loglvl);
 		}
 	} else {
 		unsigned long pc, fp;
@@ -314,7 +322,7 @@ void microblaze_unwind(struct task_struct *task, struct stack_trace *trace)
 		);
 
 		/* Since we are not a leaf function, use leaf_return = 0 */
-		microblaze_unwind_inner(current, pc, fp, 0, trace);
+		microblaze_unwind_inner(current, pc, fp, 0, trace, loglvl);
 	}
 }
 
-- 
2.25.1

