Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222DBC2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED49720658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="WKf5Gnvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731595AbgCPOjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:39:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37165 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731572AbgCPOjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:39:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id f16so8109525plj.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zku3gYtegdivuyVdz79vHefY5lOBMVX+wXMMYAiZ+NE=;
        b=WKf5GnvmXhvVA4DxzPPfzsd2Rc2/Z1+VTXY1J3w+oW9gKuJCYU02BAFddRUuh4qEKK
         6BxpN+0SaP/s32hujCUWhaFAygo0o+dRCw9H53gUijl07I6sc7xuF8k8GEcnkhFwhRdA
         tpAFN2ANcbdUbvmkxVZQsSArHyJ6qvpYiMQp4gOk1fG3ntONRL0KO2K6tNpixvBVohKw
         di8QqXauNo2B9I3ryAhYbVR6tYzbpPGUbPmcfT8SGmOEEBjTasvH5wQ4dIlX7KvpotOk
         BXDsiLZiozCsL9YohSMaLgXKfQB/eAEzxZr1ZwVh8U8fb3Fk+FIgp7e9NINrSGDwCAcP
         JvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zku3gYtegdivuyVdz79vHefY5lOBMVX+wXMMYAiZ+NE=;
        b=KkYxpRRwEEwXKwyPqTKWIYPXEwIHoSm2eg5PcokJnkhVUuUJFI+2q4ULa1/KsO8aFk
         9egkebaOGXn8wL/I1NCjOG8qKv9X6LLYjpNy4HQp5IpMBzaTIQMu2KMherGlqY91Oagg
         Y22h31z4s9/m9r4KP8QMrDRpey1n4KfoOq9LRUBbtKjoNoJHq8jgWADEski5JNRcwKa6
         MA2rp0cCVTZbWFF5Hi3x9At+o4O98/xzPfGrsj8JzXhwnpjWFzMJ/TQpNwe3sLtPSKka
         yXU0FvFenUxvM/aZh8WRRlO6bTIFTGXbkvowQ01pTkzx9XtlcJekj0Ms4kdOA0hN31WQ
         F6BQ==
X-Gm-Message-State: ANhLgQ2nxn2cyKGUhOEpaXwuOv7yPJ3H+doaUYPc7AnOxGaDH4aCXdwA
        3mv5Ast2k9nn0HTX3OdlhIwyRPM0Ze2xVg==
X-Google-Smtp-Source: ADFU+vtiKGNSRYoPM3pTwE6au0ABiF7VSY7Yq/xvnLVs4MaGZeWn+VEDdXf7tZqlXXOlOj9M9cuJww==
X-Received: by 2002:a17:90b:14c2:: with SMTP id jz2mr25747348pjb.152.1584369591646;
        Mon, 16 Mar 2020 07:39:51 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:39:51 -0700 (PDT)
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
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Richard Henderson <rth@twiddle.net>,
        linux-alpha@vger.kernel.org
Subject: [PATCHv2 02/50] alpha: Add show_stack_loglvl()
Date:   Mon, 16 Mar 2020 14:38:28 +0000
Message-Id: <20200316143916.195608-3-dima@arista.com>
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

Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: linux-alpha@vger.kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/alpha/kernel/traps.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
index f6b9664ac504..2402f1777f54 100644
--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -121,10 +121,10 @@ dik_show_code(unsigned int *pc)
 }
 
 static void
-dik_show_trace(unsigned long *sp)
+dik_show_trace(unsigned long *sp, const char *loglvl)
 {
 	long i = 0;
-	printk("Trace:\n");
+	printk("%sTrace:\n", loglvl);
 	while (0x1ff8 & (unsigned long) sp) {
 		extern char _stext[], _etext[];
 		unsigned long tmp = *sp;
@@ -133,24 +133,25 @@ dik_show_trace(unsigned long *sp)
 			continue;
 		if (tmp >= (unsigned long) &_etext)
 			continue;
-		printk("[<%lx>] %pSR\n", tmp, (void *)tmp);
+		printk("%s[<%lx>] %pSR\n", loglvl, tmp, (void *)tmp);
 		if (i > 40) {
-			printk(" ...");
+			printk("%s ...", loglvl);
 			break;
 		}
 	}
-	printk("\n");
+	printk("%s\n", loglvl);
 }
 
 static int kstack_depth_to_print = 24;
 
-void show_stack(struct task_struct *task, unsigned long *sp)
+void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
+			const char *loglvl)
 {
 	unsigned long *stack;
 	int i;
 
 	/*
-	 * debugging aid: "show_stack(NULL);" prints the
+	 * debugging aid: "show_stack(NULL, NULL, KERN_EMERG);" prints the
 	 * back trace for this cpu.
 	 */
 	if(sp==NULL)
@@ -163,14 +164,19 @@ void show_stack(struct task_struct *task, unsigned long *sp)
 		if ((i % 4) == 0) {
 			if (i)
 				pr_cont("\n");
-			printk("       ");
+			printk("%s       ", loglvl);
 		} else {
 			pr_cont(" ");
 		}
 		pr_cont("%016lx", *stack++);
 	}
 	pr_cont("\n");
-	dik_show_trace(sp);
+	dik_show_trace(sp, loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *sp)
+{
+	show_stack_loglvl(task, sp, KERN_DEFAULT);
 }
 
 void
@@ -184,7 +190,7 @@ die_if_kernel(char * str, struct pt_regs *regs, long err, unsigned long *r9_15)
 	printk("%s(%d): %s %ld\n", current->comm, task_pid_nr(current), str, err);
 	dik_show_regs(regs, r9_15);
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
-	dik_show_trace((unsigned long *)(regs+1));
+	dik_show_trace((unsigned long *)(regs+1), KERN_DEFAULT);
 	dik_show_code((unsigned int *)regs->pc);
 
 	if (test_and_set_thread_flag (TIF_DIE_IF_KERNEL)) {
@@ -625,7 +631,7 @@ do_entUna(void * va, unsigned long opcode, unsigned long reg,
 	printk("gp = %016lx  sp = %p\n", regs->gp, regs+1);
 
 	dik_show_code((unsigned int *)pc);
-	dik_show_trace((unsigned long *)(regs+1));
+	dik_show_trace((unsigned long *)(regs+1), KERN_DEFAULT);
 
 	if (test_and_set_thread_flag (TIF_DIE_IF_KERNEL)) {
 		printk("die_if_kernel recursion detected.\n");
-- 
2.25.1

