Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB55C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEE92051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="cG1oNaQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbgCPOmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:42:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45154 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731641AbgCPOmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:42:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id b22so8094152pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KuQhCrL1AnxBKkhqu9ymbS1TR8sXzvk0G8XiatbtpAU=;
        b=cG1oNaQdr4Z4HL7/xbAV2umFtbgNNFpXKE4CcV/rBndCVGVm8liQ/uw0T/iX+qXrQo
         xRzNToPF/LId0hxmw+xfbtp+g5WgEl0Cw2duTfk1qjY8wlg+yapS8V57xIQGpa4xhhgB
         IOoUejVTHrZ2aK2BcOMKuOw+JVVDkROshKxHf/uAOF2BbC1+Ku+x0GDXozotx/ls1+gd
         QJngA4AmUIGhd4VUKa5HLo9lcitvUdoazOAOJbjdwPtxE3vVK5s1bJzEQVgb/cJLdANe
         wy7ytJ412R4OQ/T9sch96uPgIaS0eBfV1HR63bW+ZH41B+y6prkNyCurEZPAxDiOOfas
         g5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KuQhCrL1AnxBKkhqu9ymbS1TR8sXzvk0G8XiatbtpAU=;
        b=ncyG1J//Hd6m4bhih+63MiVC24EQTmQH0w1V3/ZI/HseF0KIwlFsfD4rKXD2bAjvT1
         PD2Er+q9KyixzPoh4sKlKdTr5QohNDqX1sbNA4UL4hK5Rz+p0sz5dbGLIv+Ee5kmVas4
         QpAt+ApRV6C2+5ev8XRIpaNhBp1CGvDEJo7qdX4KmYpNtUg/irm4OOdUFDFFFNhH/Ui6
         e1iPZSPLnApM9+HCJJpXiPSQ2nvrnj2ukecR+PIzU7f2zMNahZWl5gWQoVgkk+Wjcdpz
         KgcY+N0XlrEpLsXQuLWOkpVW7xjInNCSKEg99Wctp/N/56aVHfjsrvmPLTWQnqn1dnvG
         1Rcw==
X-Gm-Message-State: ANhLgQ2KavcGKDW0tVH1iMQPxRM/gzl87JJ7G0HckiOvJJNZQ5wYvxxb
        pCzfb/ZgBUEgYlSG4kv7Ud7So/DguaWx0A==
X-Google-Smtp-Source: ADFU+vu6rgaDbMfaOHPkDkFN3OHzKVahYTLCgoiQcjTuy5U7ImcsTehlObRkXtfWpkcQwKSRf1yDhA==
X-Received: by 2002:a17:90a:23cc:: with SMTP id g70mr11023960pje.122.1584369755335;
        Mon, 16 Mar 2020 07:42:35 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:42:34 -0700 (PDT)
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
        Guan Xuetao <gxt@pku.edu.cn>
Subject: [PATCHv2 39/50] unicore32: Add show_stack_loglvl()
Date:   Mon, 16 Mar 2020 14:39:05 +0000
Message-Id: <20200316143916.195608-40-dima@arista.com>
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

As a nice side-effect - print backtrace in __die() with the same log
level as the rest of function.

Cc: Guan Xuetao <gxt@pku.edu.cn>
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/unicore32/kernel/traps.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/unicore32/kernel/traps.c b/arch/unicore32/kernel/traps.c
index 2b7d73456865..8b1335997f50 100644
--- a/arch/unicore32/kernel/traps.c
+++ b/arch/unicore32/kernel/traps.c
@@ -135,12 +135,13 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
 	set_fs(fs);
 }
 
-static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
+static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
+			   const char *loglvl)
 {
 	unsigned int fp;
 	int ok = 1;
 
-	printk(KERN_DEFAULT "Backtrace: ");
+	printk("%sBacktrace: ", loglvl);
 
 	if (!tsk)
 		tsk = current;
@@ -153,25 +154,31 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 		asm("mov %0, fp" : "=r" (fp) : : "cc");
 
 	if (!fp) {
-		printk("no frame pointer");
+		printk("%sno frame pointer", loglvl);
 		ok = 0;
 	} else if (verify_stack(fp)) {
-		printk("invalid frame pointer 0x%08x", fp);
+		printk("%sinvalid frame pointer 0x%08x", loglvl, fp);
 		ok = 0;
 	} else if (fp < (unsigned long)end_of_stack(tsk))
-		printk("frame pointer underflow");
-	printk("\n");
+		printk("%sframe pointer underflow", loglvl);
+	printk("%s\n", loglvl);
 
 	if (ok)
-		c_backtrace(fp, KERN_DEFAULT);
+		c_backtrace(fp, loglvl);
 }
 
-void show_stack(struct task_struct *tsk, unsigned long *sp)
+void show_stack_loglvl(struct task_struct *tsk, unsigned long *sp,
+		       const char *loglvl)
 {
-	dump_backtrace(NULL, tsk);
+	dump_backtrace(NULL, tsk, loglvl);
 	barrier();
 }
 
+void show_stack(struct task_struct *tsk, unsigned long *sp)
+{
+	show_stack_loglvl(tsk, sp, KERN_DEFAULT)
+}
+
 static int __die(const char *str, int err, struct thread_info *thread,
 		struct pt_regs *regs)
 {
@@ -196,7 +203,7 @@ static int __die(const char *str, int err, struct thread_info *thread,
 	if (!user_mode(regs) || in_interrupt()) {
 		dump_mem(KERN_EMERG, "Stack: ", regs->UCreg_sp,
 			 THREAD_SIZE + (unsigned long)task_stack_page(tsk));
-		dump_backtrace(regs, tsk);
+		dump_backtrace(regs, tsk, KERN_EMERG);
 		dump_instr(KERN_EMERG, regs);
 	}
 
-- 
2.25.1

