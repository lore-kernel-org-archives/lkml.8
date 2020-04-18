Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9D2C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF25F21D93
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="gNS9qIbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgDRUWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728505AbgDRUUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:23 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EA0C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:23 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id h2so6497455wmb.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bgkQndVSPCAXAdk55lj3SsyWy6EW/wW9GxO05KKgdOE=;
        b=gNS9qIbIUIxrAJ8f0EREItvYgAmDrw9JMzuL9QhLLTRuGwWPLANT8JscbeNe7Ob8w7
         AxUZBQjN0jubvGxly9D+ctqyrZaUPnpdw4B7579o4F7ZspjcczB106qsb7QE/VACRxXW
         cSVbOA1Zu7jo2gjimWV92T5+7pXFG6mqs52kRRvVvlliLUR3HmE2xWubOA5F0NL/tP1l
         e+5Ix71XxKexIDBxR4cjnyEpiHPTZug0JWaxRfPBvH8JkVZjzLPqdCWoX26GheEtnQSf
         VC9LgqNuU+83n5z7LWXv9VpoQiLFQf5Cw9iPKcHqUoyQuf6zTwR/qvb3URzgzKFdvTf5
         fixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bgkQndVSPCAXAdk55lj3SsyWy6EW/wW9GxO05KKgdOE=;
        b=RwmTHEhPdrKc4qD3DlWpbiUXMR0xrUTDppfWJcr+ETqn9JYTKXFS5jcCW6X7e/pTdH
         gwqafvr+uc11oM6O48odiIQzZxUAKf9O6O37jCGqgtshsKMy5bJv5Hog/dAni9Pssqph
         At/XGh8wXs8ktHK+xKSXK/YxcqawIK1cMVRlwk61KKELsEYRMDe4/lV5FgbxTf3pKbbL
         i0cLcfrpO0QcTO0rz6KMMZ2QURa4q3QABTZ82WaBeP6r1LPnvRVgtGDiD1t2QYLS95p/
         Y8QX8ni9TAIxLI0b7L3wKVuksIs4kVrXKMAmmfFiyMTJmEpvySZCCjhvSKhkybLPgKRz
         Qegg==
X-Gm-Message-State: AGi0Puas/Fz9Z0kc7qM1CYWIfGPifk/HkmRJ52F2okPZkKy3p03EJBKF
        IyxEl9SyhDVW6IdYnovu85rsPEbR8CY=
X-Google-Smtp-Source: APiQypJxgZcfu1FPcrZ9G99YQ7RXLzWjDi9OvAmWUQQcF7ddUfc/mMNCCwzs1DT48sX/VY5VFwl9+w==
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr10116596wmg.183.1587241221553;
        Sat, 18 Apr 2020 13:20:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:21 -0700 (PDT)
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
        Ley Foon Tan <lftan@altera.com>,
        nios2-dev@lists.rocketboards.org
Subject: [PATCHv3 23/50] nios2: Add show_stack_loglvl()
Date:   Sat, 18 Apr 2020 21:19:17 +0100
Message-Id: <20200418201944.482088-24-dima@arista.com>
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

Cc: Ley Foon Tan <lftan@altera.com>
Cc: nios2-dev@lists.rocketboards.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/nios2/kernel/traps.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/nios2/kernel/traps.c b/arch/nios2/kernel/traps.c
index 486db793923c..08071caa9b36 100644
--- a/arch/nios2/kernel/traps.c
+++ b/arch/nios2/kernel/traps.c
@@ -52,12 +52,14 @@ void _exception(int signo, struct pt_regs *regs, int code, unsigned long addr)
 }
 
 /*
- * The show_stack is an external API which we do not use ourselves.
+ * The show_stack(), show_stack_loglvl() are external API
+ * which we do not use ourselves.
  */
 
 int kstack_depth_to_print = 48;
 
-void show_stack(struct task_struct *task, unsigned long *stack)
+void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
+		       const char *loglvl)
 {
 	unsigned long *endstack, addr;
 	int i;
@@ -72,16 +74,16 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 	addr = (unsigned long) stack;
 	endstack = (unsigned long *) PAGE_ALIGN(addr);
 
-	pr_emerg("Stack from %08lx:", (unsigned long)stack);
+	printk("%sStack from %08lx:", loglvl, (unsigned long)stack);
 	for (i = 0; i < kstack_depth_to_print; i++) {
 		if (stack + 1 > endstack)
 			break;
 		if (i % 8 == 0)
-			pr_emerg("\n       ");
-		pr_emerg(" %08lx", *stack++);
+			printk("%s\n       ", loglvl);
+		printk("%s %08lx", loglvl, *stack++);
 	}
 
-	pr_emerg("\nCall Trace:");
+	printk("%s\nCall Trace:", loglvl);
 	i = 0;
 	while (stack + 1 <= endstack) {
 		addr = *stack++;
@@ -97,11 +99,16 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 		     (addr <= (unsigned long) _etext))) {
 			if (i % 4 == 0)
 				pr_emerg("\n       ");
-			pr_emerg(" [<%08lx>]", addr);
+			printk("%s [<%08lx>]", loglvl, addr);
 			i++;
 		}
 	}
-	pr_emerg("\n");
+	printk("%s\n", loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *stack)
+{
+	show_stack_loglvl(task, stack, KERN_EMERG);
 }
 
 void __init trap_init(void)
-- 
2.26.0

