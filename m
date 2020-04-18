Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDE4C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCB992223F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="gpLS8Ewu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgDRUUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728460AbgDRUUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:15 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD111C061A0F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:14 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id h2so6497216wmb.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QrHQbPVpZh2FaeLoZU8UpiHrNtVlKp5oAf8aH7UjyVU=;
        b=gpLS8Ewu8rTqFjDXqwC396UGf3GmpWh47zGnsHV2dc97Mkp3uqebUyYWftFaxpPa3L
         eB9KoV7LjusaTdDyJS2DW+WBozO34gzFVd1WxpZI1960fJCQKvOqk7McNFaW2ED3MTq7
         E73SUQ3Id0UDKvIrlPI1SAfo8yvME7Z5RaY5LWdcep2pjAzDVb/TtyEKtuWiRXmueoZ3
         RCmnwifMmHUUK1o9j5v5PLImx3+iSrzqXC4MUDMdcL4P4aEwYPNSRoOXMW5KROShdvR0
         DZd6ADl8B4c7u+AGhTT5Ax49mcXLqp15h4JD2TrXCTW4DOOaXldDb9SYqFCTOblbbUK+
         0GDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QrHQbPVpZh2FaeLoZU8UpiHrNtVlKp5oAf8aH7UjyVU=;
        b=hqygvKaVVuKpTtE5uAqMaty2odLKWgBf434deTPD2p2KdB+0U1JXnT8J5Y/mOtZQpF
         Trer0OSfoWNUpnXXRQe8unqOBLzMWtmAQj3NDzZWKHKFG5RiEJPek+SP1zx6UcgoFhAS
         wOOlGNquSnWSGWoTXlkDDOumT3Kw6ck9eVT0p3MiYq36jNDDAJpJG+4njxFkWGRiRj50
         WjdV5LgRRGnd+Gofk/fFm363LJUvCpdg0CTShS7DoYcWDcnpry5y55/D+I/eFiftbuHq
         X++ZnY4aO26+F2rFUae2oT6FJZJ7RYvv9MjN9Z85kcug7yu8DRiPkWrRF3vxf6glgVVK
         63PA==
X-Gm-Message-State: AGi0PuaA423SqDLis9rs1zqXb9gvcIUMAGsvsfWyKdEKwYbgYTXthQUJ
        zS35tS5iP2vhAcx0dG4kJd96eYsbXZg=
X-Google-Smtp-Source: APiQypK59/5HF7i2jx9o/nYmq1sWGMPc6Pc6yRZ//ZZxqzHqJ/671k7rWnj1C6OVGn9HQbVciLTvXw==
X-Received: by 2002:a7b:c459:: with SMTP id l25mr9310931wmi.52.1587241213358;
        Sat, 18 Apr 2020 13:20:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:12 -0700 (PDT)
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
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCHv3 17/50] m68k: Add show_stack_loglvl()
Date:   Sat, 18 Apr 2020 21:19:11 +0100
Message-Id: <20200418201944.482088-18-dima@arista.com>
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

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/m68k/kernel/traps.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index 344f93d36a9a..ffcc5ec4fac3 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -811,13 +811,13 @@ asmlinkage void buserr_c(struct frame *fp)
 
 static int kstack_depth_to_print = 48;
 
-void show_trace(unsigned long *stack)
+static void show_trace(unsigned long *stack, const char *loglvl)
 {
 	unsigned long *endstack;
 	unsigned long addr;
 	int i;
 
-	pr_info("Call Trace:");
+	printk("%sCall Trace:", loglvl);
 	addr = (unsigned long)stack + THREAD_SIZE - 1;
 	endstack = (unsigned long *)(addr & -THREAD_SIZE);
 	i = 0;
@@ -935,7 +935,8 @@ void show_registers(struct pt_regs *regs)
 	pr_cont("\n");
 }
 
-void show_stack(struct task_struct *task, unsigned long *stack)
+void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
+		       const char *loglvl)
 {
 	unsigned long *p;
 	unsigned long *endstack;
@@ -949,7 +950,7 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 	}
 	endstack = (unsigned long *)(((unsigned long)stack + THREAD_SIZE - 1) & -THREAD_SIZE);
 
-	pr_info("Stack from %08lx:", (unsigned long)stack);
+	printk("%sStack from %08lx:", loglvl, (unsigned long)stack);
 	p = stack;
 	for (i = 0; i < kstack_depth_to_print; i++) {
 		if (p + 1 > endstack)
@@ -959,7 +960,12 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 		pr_cont(" %08lx", *p++);
 	}
 	pr_cont("\n");
-	show_trace(stack);
+	show_trace(stack, loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *stack)
+{
+	show_stack_loglvl(task, stack, KERN_INFO);
 }
 
 /*
-- 
2.26.0

