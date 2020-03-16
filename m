Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16237C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D796020674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Gne+q2gY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbgCPOk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:40:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36774 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731653AbgCPOk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:40:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id g2so5600616plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kscgl6LMW8fnhvnht43GSfN2W2mDU+MdbGlTg6HKa0I=;
        b=Gne+q2gYLPZmQpw2g8GRgQzskeppT1C+fJCqkoXNdVYmIZQjpev41BEdLNF1jjIQjG
         bGjjMFxo5Gkn1Q6mgz4J6CKJTMSKDZbkqxPsKKCyL04HIEt0Sil53pBRzeTo6GIXZMq0
         /o+sZrqei2DdmSDlTsng/iEneFCOSu/ri3/3ZvVa64ByrypgmIPwqhdio/XJZJ3akJcK
         v+Eyy3Tivuc/8IbuEDxriEyeuOjFT1/o70jxvSmW+LjyHiOiCv3pL/yxTHjm3ewO+Kdf
         GVr9RSJWpKaWctz4YEi5W/j4l93ItRFd4l+7ZK+rQP8/nEqazAWa2tUwHrzQiJgwWZ9W
         AvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kscgl6LMW8fnhvnht43GSfN2W2mDU+MdbGlTg6HKa0I=;
        b=QEhgxjd1SqLj7pjQbQRr2XVt1tuu74BJXzU7kui51veYmCE6eWO33AslImD+DGIOlv
         N2NciOjB98+3Va08uLiqAEAH+M9O5oUd4YHGYSNwx+4Y71LQugMj/t5aY8XrVWnhSZOd
         pQ6oYIQSW5lwHeuckP9Nr+vUj1X7yofUhFMKZgbZyy557wL5I+FKFcN0ty8Q6a8X5Iqt
         Ev2aQv7nAAfxVuo0eMPM5ZUT9NaAMenlKHkAeMNG2NEdI+HeCzBc6i7Hx7XcxPJJ+sZA
         qubzNUqodggAKw2CfWIf2V8NVfpxNbERccxIy/pfZJ/0559bqKjRlRA31ksC0lHWK0h0
         1uYA==
X-Gm-Message-State: ANhLgQ1AYPipYQ9tgnK47f07dTSI3trDqnp7pgEctg+B3Vw4Cgn5HlHF
        AD2sClo55BzsCOLDGjeFio0Pfrjnfh28Yw==
X-Google-Smtp-Source: ADFU+vsPJUeIS/9K8JoSoRdTLtr8Qnr3nNiYpumTfiHTDVGAp6UAnWBdhmDA7OEr/ZotrD9OuoakaQ==
X-Received: by 2002:a17:902:724c:: with SMTP id c12mr3070339pll.60.1584369623471;
        Mon, 16 Mar 2020 07:40:23 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:40:22 -0700 (PDT)
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCHv2 09/50] arm64: Add loglvl to dump_backtrace()
Date:   Mon, 16 Mar 2020 14:38:35 +0000
Message-Id: <20200316143916.195608-10-dima@arista.com>
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

Add log level argument to dump_backtrace() as a preparation for
introducing show_stack_loglvl().

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm64/include/asm/stacktrace.h |  3 ++-
 arch/arm64/kernel/process.c         |  2 +-
 arch/arm64/kernel/traps.c           | 15 ++++++++-------
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 4d9b1f48dc39..fdb913cc0bcb 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -64,7 +64,8 @@ struct stackframe {
 extern int unwind_frame(struct task_struct *tsk, struct stackframe *frame);
 extern void walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
 			    int (*fn)(struct stackframe *, void *), void *data);
-extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk);
+extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
+			   const char *loglvl);
 
 DECLARE_PER_CPU(unsigned long *, irq_stack_ptr);
 
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 00626057a384..2ee44d95f023 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -291,7 +291,7 @@ void __show_regs(struct pt_regs *regs)
 void show_regs(struct pt_regs * regs)
 {
 	__show_regs(regs);
-	dump_backtrace(regs, NULL);
+	dump_backtrace(regs, NULL, KERN_DEFAULT);
 }
 
 static void tls_thread_flush(void)
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index cf402be5c573..6e777cbd4eb5 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -53,9 +53,9 @@ static const char *handler[]= {
 
 int show_unhandled_signals = 0;
 
-static void dump_backtrace_entry(unsigned long where)
+static void dump_backtrace_entry(unsigned long where, const char *loglvl)
 {
-	printk(" %pS\n", (void *)where);
+	printk("%s %pS\n", loglvl, (void *)where);
 }
 
 static void dump_kernel_instr(const char *lvl, struct pt_regs *regs)
@@ -83,7 +83,8 @@ static void dump_kernel_instr(const char *lvl, struct pt_regs *regs)
 	printk("%sCode: %s\n", lvl, str);
 }
 
-void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
+void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
+		    const char *loglvl)
 {
 	struct stackframe frame;
 	int skip = 0;
@@ -115,11 +116,11 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 				thread_saved_pc(tsk));
 	}
 
-	printk("Call trace:\n");
+	printk("%sCall trace:\n", loglvl);
 	do {
 		/* skip until specified stack frame */
 		if (!skip) {
-			dump_backtrace_entry(frame.pc);
+			dump_backtrace_entry(frame.pc, loglvl);
 		} else if (frame.fp == regs->regs[29]) {
 			skip = 0;
 			/*
@@ -129,7 +130,7 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 			 * at which an exception has taken place, use regs->pc
 			 * instead.
 			 */
-			dump_backtrace_entry(regs->pc);
+			dump_backtrace_entry(regs->pc, loglvl);
 		}
 	} while (!unwind_frame(tsk, &frame));
 
@@ -138,7 +139,7 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 
 void show_stack(struct task_struct *tsk, unsigned long *sp)
 {
-	dump_backtrace(NULL, tsk);
+	dump_backtrace(NULL, tsk, KERN_DEFAULT);
 	barrier();
 }
 
-- 
2.25.1

