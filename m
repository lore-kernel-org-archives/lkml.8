Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1363C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7BA2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Q+2PpXQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731865AbgCPOmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:42:08 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53022 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731857AbgCPOmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:42:06 -0400
Received: by mail-pj1-f65.google.com with SMTP id ng8so1480705pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eYmcsGVHR1W1SqCFJ4ogPeu1ewZBodA2GWVRUDoMM5Y=;
        b=Q+2PpXQYV65TVrpV0ysU5gZNbWXfSJ/JULE/NhC56WVY8cJhLrkEym3sZ4XRQaZOxe
         0ajTeKGwo3gfIPs6qAA1zZy3/S+wZyFIZxVATHeSHzVVTIKuJ4O34RgKGBfpYnuof2Jg
         QSPIcuPPvB8vMZeImp8TizKbhePLZBjpF//motXYw3uKRvQsxM2DN1tOChxHGhKEtTRr
         IxkfLYJRbV9Y0n+8TJ9lx9yLZXTC0TejllVtk2TzIpRRR7uUpnd4HuDjCgJXeK6IMqf7
         KCMGE2gNAWWiYQqB/8/nfYYfaxBEnk1TKC7lxGSVoLGmSCOmNebf/78EU+DofsLNwCWJ
         yGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eYmcsGVHR1W1SqCFJ4ogPeu1ewZBodA2GWVRUDoMM5Y=;
        b=nGNZ6loYo4CX0qI9OYUDlUNnKmRnERwa/MDreuGl98hSlH2kL3z0m23BcxQAnAUo4l
         VYcAXEnD29b1MaQrtclHVP+R2eGXEM5Omz9MVC4yv33WW8ag5ibABrG2uXfS2fWBLNsm
         tn1BJ4XvoR8upUwr3RQepQFGsnCn49EaDY6nOEAtn2+H9XkP8SqQAg9ryGMVJuMTtsJU
         NNDRLE3Wsy13rUUyYYaXFGT4c203/lSJo2EMKDNNhW5mOtWP0cJgCOFgCgLc3B25Rcjk
         yfoPFr1eEeg+TnK7c0L5Lz2UJ6OAaj7EOkoxpUVqRe3aX6Hp3NfD9Pa9JMIW+fEhE6FA
         Udkg==
X-Gm-Message-State: ANhLgQ3q/ZQwwRkKg2ITVKo5gSrV8TBO7dl8lIn5uliYytViouuRtpIV
        K2gLlj2wa0RO9GjhGCZFVX9K2wnZ45KWzg==
X-Google-Smtp-Source: ADFU+vtjrpq6Y+K0V2mjcCTYp/OFawavRtgpxUPSJwzs2/4CXHdGrlXy9Inwz5sMBraTg695+wY/Qw==
X-Received: by 2002:a17:902:b58b:: with SMTP id a11mr27777648pls.9.1584369725358;
        Mon, 16 Mar 2020 07:42:05 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:42:04 -0700 (PDT)
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
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCHv2 32/50] sh: Add loglvl to show_trace()
Date:   Mon, 16 Mar 2020 14:38:58 +0000
Message-Id: <20200316143916.195608-33-dima@arista.com>
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

Add log level parameter to show_trace() as a preparation to introduce
show_stack_loglvl().

Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/sh/include/asm/processor_32.h |  2 +-
 arch/sh/kernel/dumpstack.c         | 10 +++++-----
 arch/sh/kernel/process_32.c        |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/sh/include/asm/processor_32.h b/arch/sh/include/asm/processor_32.h
index 0e0ecc0132e3..d44409413418 100644
--- a/arch/sh/include/asm/processor_32.h
+++ b/arch/sh/include/asm/processor_32.h
@@ -171,7 +171,7 @@ static __inline__ void enable_fpu(void)
 #define thread_saved_pc(tsk)	(tsk->thread.pc)
 
 void show_trace(struct task_struct *tsk, unsigned long *sp,
-		struct pt_regs *regs);
+		struct pt_regs *regs, const char *loglvl);
 
 #ifdef CONFIG_DUMP_CODE
 void show_code(struct pt_regs *regs);
diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index 959064b90055..d488a47a1f0f 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -127,16 +127,16 @@ static const struct stacktrace_ops print_trace_ops = {
 };
 
 void show_trace(struct task_struct *tsk, unsigned long *sp,
-		struct pt_regs *regs)
+		struct pt_regs *regs, const char *loglvl)
 {
 	if (regs && user_mode(regs))
 		return;
 
-	printk("\nCall trace:\n");
+	printk("%s\nCall trace:\n", loglvl);
 
-	unwind_stack(tsk, regs, sp, &print_trace_ops, "");
+	unwind_stack(tsk, regs, sp, &print_trace_ops, (void *)loglvl);
 
-	printk("\n");
+	printk("%s\n", loglvl);
 
 	if (!tsk)
 		tsk = current;
@@ -158,5 +158,5 @@ void show_stack(struct task_struct *tsk, unsigned long *sp)
 	stack = (unsigned long)sp;
 	dump_mem("Stack: ", KERN_DEFAULT, stack, THREAD_SIZE +
 		 (unsigned long)task_stack_page(tsk));
-	show_trace(tsk, sp, NULL);
+	show_trace(tsk, sp, NULL, KERN_DEFAULT);
 }
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index a094633874c3..456cc8d171f7 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -59,7 +59,7 @@ void show_regs(struct pt_regs * regs)
 	printk("MACH: %08lx MACL: %08lx GBR : %08lx PR  : %08lx\n",
 	       regs->mach, regs->macl, regs->gbr, regs->pr);
 
-	show_trace(NULL, (unsigned long *)regs->regs[15], regs);
+	show_trace(NULL, (unsigned long *)regs->regs[15], regs, KERN_DEFAULT);
 	show_code(regs);
 }
 
-- 
2.25.1

