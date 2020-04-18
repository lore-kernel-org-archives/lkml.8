Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34839C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC34C22240
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ajwF4hxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgDRUUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728628AbgDRUUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:41 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEDEC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:40 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x4so6504918wmj.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XGIhy+u2aeIy2Yn7CXXmbETFux33ENbBve0AwwnOWUA=;
        b=ajwF4hxvSC1PI6Bk2wj33DGrRVwhcg50Fh2Z3O2Lf3v1+V6EeYmdPocxoSCItJd/CG
         VshA9IfaQPJ4/Vqgf/pJzvLfDzEdkO4MKfQdVYIF5SpO+L5RVpdHY26a/FqJehxFLw+A
         L1p3/Zwomr6DzpEvY1n6+zGVs+q4NuPkO7s2D+tkzJgPuxiK754YiIuLtfJ9toKgM7Jx
         amicsza0muUYSbK5ynwnssZcIdwNNkKZsVDyPRxHqdLgAcnWvDzHztaRlQfB2sON6YXM
         VLW99Y0RKrX/Gr8KAd3EIoWnYeORx0z52VxQX3oe4SWT3sGP+Cf4s+/cVF6w494MJc9A
         m9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XGIhy+u2aeIy2Yn7CXXmbETFux33ENbBve0AwwnOWUA=;
        b=enzGFaVYMp2vA7Fir6HpXpqUHLilLWcRKQg2c/k7bPVpqinjVRD+wSOmURshA2nrc6
         3RX7qNcie5Zufx5z4l0KCqYtlqrbRy+lsWC+6+cGTn8/qteh6DKUcr4NzNM3cC1h5F15
         64pHdhqkHNjRaDl7oA+BmDOrcyTZb0DRYrKy1vzTxN8Cnan71m8n1c645nmWLOyu9SnK
         nj3CGhlqEEvQSkASmkDUN9+pBJgNc4aVAV2R5F+6J4sGyQmiNdkWQYTyXOEOWt0/XB44
         mRok/QsBLx6m7m1Urgz+RpGbkSDjhzOIaUFl2Puumjm5Cmkm3+Isz+WDh3C0/dqxQFvY
         4RNA==
X-Gm-Message-State: AGi0Pubd4V1mB7+2sQewmbZSCFq9+2eFRj5unbzzsgWDKQ+bRC3Bpe4n
        lPwct0G0NWl7ZpJoJXpObTuVXL7dpig=
X-Google-Smtp-Source: APiQypIpj/gI4LC71uUybC6QcQ3CCA6sPVcTkkoE2WQ7LbPrX3D0bZMrmgi7rs7Kg6yURpaz4gekTw==
X-Received: by 2002:a7b:c459:: with SMTP id l25mr9312266wmi.52.1587241239311;
        Sat, 18 Apr 2020 13:20:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:38 -0700 (PDT)
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
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org
Subject: [PATCHv3 36/50] um: Add show_stack_loglvl()
Date:   Sat, 18 Apr 2020 21:19:30 +0100
Message-Id: <20200418201944.482088-37-dima@arista.com>
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

Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-um@lists.infradead.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/um/kernel/sysrq.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index c831a1c2eb94..1b54b6431499 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -17,7 +17,9 @@
 
 static void _print_addr(void *data, unsigned long address, int reliable)
 {
-	pr_info(" [<%08lx>] %s%pS\n", address, reliable ? "" : "? ",
+	const char *loglvl = data;
+
+	printk("%s [<%08lx>] %s%pS\n", loglvl, address, reliable ? "" : "? ",
 		(void *)address);
 }
 
@@ -25,7 +27,8 @@ static const struct stacktrace_ops stackops = {
 	.address = _print_addr
 };
 
-void show_stack(struct task_struct *task, unsigned long *stack)
+void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
+		       const char *loglvl)
 {
 	struct pt_regs *segv_regs = current->thread.segv_regs;
 	int i;
@@ -39,17 +42,22 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 	if (!stack)
 		stack = get_stack_pointer(task, segv_regs);
 
-	pr_info("Stack:\n");
+	printk("%sStack:\n", loglvl);
 	for (i = 0; i < 3 * STACKSLOTS_PER_LINE; i++) {
 		if (kstack_end(stack))
 			break;
 		if (i && ((i % STACKSLOTS_PER_LINE) == 0))
-			pr_cont("\n");
+			printk("%s\n", loglvl);
 		pr_cont(" %08lx", *stack++);
 	}
-	pr_cont("\n");
+	printk("%s\n", loglvl);
+
+	printk("%sCall Trace:\n", loglvl);
+	dump_trace(current, &stackops, (void *)loglvl);
+	printk("%s\n", loglvl);
+}
 
-	pr_info("Call Trace:\n");
-	dump_trace(current, &stackops, NULL);
-	pr_info("\n");
+void show_stack(struct task_struct *task, unsigned long *stack)
+{
+	show_stack_loglvl(task, stack, KERN_INFO);
 }
-- 
2.26.0

