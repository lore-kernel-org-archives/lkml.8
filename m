Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CE9C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE56D20658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="WcARDgCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbgCPOl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:41:27 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37118 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731614AbgCPOl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:41:26 -0400
Received: by mail-pj1-f68.google.com with SMTP id ca13so8822426pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nFIu3HtDNXH0iQBucFifCkfE8DWgtr+IIuGyp7RGPsw=;
        b=WcARDgCXLVrUY1PBK+i4e225qDQMHuPFFkWms278mGL8GJ6OYrkD/HYauCkBWBNl5q
         ffi+SgUb34taCzxK06iONPzE5nXGZ5mmtKLS0Onswl8Y9VifTJ7xkLTyBOqd+9XPteOy
         zg4xP1EmcWlmSHIjP5rTbD5nwNqPTwbrw2dqgey3Do892Ff/+tcqi8p4uEDNI0jqSvSF
         o5GOA/Gwk/SRnODHlj6cSngEqn7Qdkp0tPm0fl2DOruKKy1zShHgAmD6tfi24wUwjntE
         wTGGMrOYLKNEqMxc+3O+LFDmM2lnaStSIoSKgguJIsipzOhVc9wCsKkL0bvXuLglz+a9
         gRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nFIu3HtDNXH0iQBucFifCkfE8DWgtr+IIuGyp7RGPsw=;
        b=TYff7neg7YU2zhohvvhVVD0dCloJvtUhFT25sFIUsi+bm4RvYFqLQsTKyXGS4uFiVJ
         2yaujgXmJEssjuLP+WndgDQNmXxhjVwOItYmcC54UX0Q+ZhaS4AdP9qPXpUP3XH6C/XM
         XeISPu0xduVUnuRQOYjDNwM6UdR0XFYQPMh5OMvhMVP5d5C8r5OucKJkF+1cK27RqSdV
         wQc7/hMSEeMJAPox1/hugySO90fwxtGVWGmzFq6dgzqL8tL1IzAnXJ9A98H8byWxw/pt
         UWLJBF6YMt2scttoqCN+AMlV3UQirjYJXmqLZAkEfupL3K6FjxFrrm0qH/3rErIh0fnv
         CQcw==
X-Gm-Message-State: ANhLgQ2eV5BwL13ieLDE5+QxoPMTf8ljcwO/3FDgro4KlZBIjCUhQf5a
        CD6wjCySxio4MDmr+vLoEJaEPjLx2hq2mA==
X-Google-Smtp-Source: ADFU+vsYPq/o7ElaoSiIC5rmLjqmt6NcSF14lo/hnJuiVDuSvlzzU9po76vXhVAu3F0Au+u3o++0DQ==
X-Received: by 2002:a17:90a:b94a:: with SMTP id f10mr1370813pjw.62.1584369684881;
        Mon, 16 Mar 2020 07:41:24 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:41:24 -0700 (PDT)
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
Subject: [PATCHv2 23/50] nios2: Add show_stack_loglvl()
Date:   Mon, 16 Mar 2020 14:38:49 +0000
Message-Id: <20200316143916.195608-24-dima@arista.com>
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
2.25.1

