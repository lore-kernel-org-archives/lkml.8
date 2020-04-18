Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE82C352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC3C322263
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="TfIZtphF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgDRUT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728289AbgDRUTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:19:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCCDC061A0F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:19:54 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v4so1390601wme.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jm4GkFHQF1Q0S/B+KUYWFb+gzMhFBchEH6dpMzDFppU=;
        b=TfIZtphFbDCvNNoUBEh6Qjg4+p/om4NLEeEMJqMvVZVfBlF4GiuZ4dTeHEdVt5XBEg
         jD4HjGZsDehfolrvSbTi3FbF94U6F3FqG1p02yDZgTj15rIe/K8E48itbYWH7n7L0Ae9
         nJxPGcZW6kUL/i8MgDzsBT8WDklGSaWLLMkYzIX25NPDHxdCFH5M0Kr5KUfSvPPK0iXU
         9CBdGG2TVGhli5nFz/fZT1bBcnJ4Ly+mUGBZ48E8AlfSqPxodo+bmRhu0a6mzHhYJiWT
         ef48erC2KeKOxBm5ejvxIjnMtsCj5ECcRXN4X85gfLnkXT6X1VROSGy6prHgqLCbATnM
         z0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jm4GkFHQF1Q0S/B+KUYWFb+gzMhFBchEH6dpMzDFppU=;
        b=natxBlDFtzDol/gmyj0l5EgrFDKPhK2R86PyaiH5B9P94dVCxUI7M7XOpoPO2v0VSg
         Wv3cVcZIGmof9PjZXSKEre7R0jC+5Vq/BL4anLM4xwH9M6cp/rgSQbYEqFixJlbB11oW
         pc4tPM1fECcFVOb2kFvJKzFJRC2PbKZmNujgiPS8flKjhu4NnIdl7VZnq3DcNs7daF9q
         L1GAkdfahVtqFlG1QZ4QVtgvWEeeqzKoNGsgtM/h0PSGKAYqX8ftPkJ8MLqGE6QJPd0q
         9aIvGYHnKr96W7yNdcESDKrpe1rn12NCqHYV/yUB1SboOnSfc9wrxljbX5STDANpgeU8
         h2mA==
X-Gm-Message-State: AGi0PuYhe5OT9cdSm9tihX62rMMzt2IjbYdh4phyJHKdZ+xEUSRFxcaF
        3zKs0uAgHyU4GMlBgv2Mx9vtjmRrRM0=
X-Google-Smtp-Source: APiQypLHtJ/gwiqY+5MEksA92z603puyy7mnU2OEsis9uYAoLy8rA5YU0NNQhB3vIGcYGvtqd5lwcg==
X-Received: by 2002:a1c:bb08:: with SMTP id l8mr10457186wmf.168.1587241193352;
        Sat, 18 Apr 2020 13:19:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:19:52 -0700 (PDT)
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
Subject: [PATCHv3 02/50] alpha: Add show_stack_loglvl()
Date:   Sat, 18 Apr 2020 21:18:56 +0100
Message-Id: <20200418201944.482088-3-dima@arista.com>
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
2.26.0

