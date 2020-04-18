Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17319C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F0B22240
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="RXn6QPls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgDRUU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728460AbgDRUUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6A1C0610D5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:21 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a25so7199207wrd.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Za+ZBc1E6egbSGqLb5KlV+I4/m0tErkutwX7BYqMJ9Q=;
        b=RXn6QPls7kA7TAI1U0AD70utSQA//s29Fl6Px9HhyOV3SuDORk56N/FKxuhngn7LLc
         wYdcv2l9/mDuMMa1RYz/kw1dBxHGRjjRESL5MRebJZXZHanlqgnbG/EfB4yka6sIfX3k
         L4THY3M4qlLiYsfbMviSayMU1bTqYjtAhOKbinPPO15tF95xt3k4uU50LpDPtTAmFNaO
         CShP6iWyoGZXLhN+slLL1fDr5Yruz3d/F3HU/NEm8E71EOC4ej4wlhgV6WM3pbVMTGZe
         dBB/Xqz40pAAT95b/Ejzm5OSBqh7/qISerUvpD+F0S8qp95MyZymTvccsyNDWurwRmhG
         H9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Za+ZBc1E6egbSGqLb5KlV+I4/m0tErkutwX7BYqMJ9Q=;
        b=AnvSKaZlTsgj63GVnJEvQVU6MmHynlWTByhcOGRQRz5vFaJOrwb5bQEXLYUWKdez3M
         Djytu0iCwjQfBN67cxy6XmBuP84hDTEphhP0/iz4b/G38n2jdNHmh5+AzT8t3yAELJK3
         5o+0tPTopyy9V7ljsaH40DsAUVbpnJnusKDZUsp4vpFqPRAD3/btvJ4Q+kROJYWG0ENa
         x05ETdyjD/mE1RU6Oxak4sVFo/9sJoH2tAazxk/08ViWij8C56jgxsBYPHAL10AbhG/s
         M1vVTpW89BvWrYcg5wUSPmCoowx9EDt0VZktCYhRkL+GdF7rK1IMpW0TCFSOb4vJS6p6
         bqcw==
X-Gm-Message-State: AGi0PubDs10WzpGX+F11+oQ+u4AVw6CwyRSpy7Qy40OSjPFwuImgOPNQ
        bvQgltnGKH4a2L5L+i5iDNkvdcMGM1g=
X-Google-Smtp-Source: APiQypJcrmT0/dqAgYAzaD6ydDjgkiMc+wrv5r9Qe9dvRhq8APtd8ic9KfqdrqTaL26glf9YrQLOEQ==
X-Received: by 2002:a5d:6148:: with SMTP id y8mr10207917wrt.236.1587241219596;
        Sat, 18 Apr 2020 13:20:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:18 -0700 (PDT)
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
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: [PATCHv3 22/50] nds32: Add show_stack_loglvl()
Date:   Sat, 18 Apr 2020 21:19:16 +0100
Message-Id: <20200418201944.482088-23-dima@arista.com>
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

Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/nds32/kernel/traps.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index 40625760a125..90f12582c218 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -97,18 +97,19 @@ static void dump_instr(struct pt_regs *regs)
 }
 
 #define LOOP_TIMES (100)
-static void __dump(struct task_struct *tsk, unsigned long *base_reg)
+static void __dump(struct task_struct *tsk, unsigned long *base_reg,
+		   const char *loglvl)
 {
 	unsigned long ret_addr;
 	int cnt = LOOP_TIMES, graph = 0;
-	pr_emerg("Call Trace:\n");
+	printk("%sCall Trace:\n", loglvl);
 	if (!IS_ENABLED(CONFIG_FRAME_POINTER)) {
 		while (!kstack_end(base_reg)) {
 			ret_addr = *base_reg++;
 			if (__kernel_text_address(ret_addr)) {
 				ret_addr = ftrace_graph_ret_addr(
 						tsk, &graph, ret_addr, NULL);
-				print_ip_sym(KERN_EMERG, ret_addr);
+				print_ip_sym(loglvl, ret_addr);
 			}
 			if (--cnt < 0)
 				break;
@@ -124,17 +125,18 @@ static void __dump(struct task_struct *tsk, unsigned long *base_reg)
 
 				ret_addr = ftrace_graph_ret_addr(
 						tsk, &graph, ret_addr, NULL);
-				print_ip_sym(KERN_EMERG, ret_addr);
+				print_ip_sym(loglvl, ret_addr);
 			}
 			if (--cnt < 0)
 				break;
 			base_reg = (unsigned long *)next_fp;
 		}
 	}
-	pr_emerg("\n");
+	printk("%s\n", loglvl);
 }
 
-void show_stack(struct task_struct *tsk, unsigned long *sp)
+void show_stack_loglvl(struct task_struct *tsk, unsigned long *sp,
+		       const char *loglvl)
 {
 	unsigned long *base_reg;
 
@@ -151,10 +153,15 @@ void show_stack(struct task_struct *tsk, unsigned long *sp)
 		else
 			__asm__ __volatile__("\tori\t%0, $fp, #0\n":"=r"(base_reg));
 	}
-	__dump(tsk, base_reg);
+	__dump(tsk, base_reg, loglvl);
 	barrier();
 }
 
+void show_stack(struct task_struct *tsk, unsigned long *sp)
+{
+	show_stack_loglvl(tsk, sp, KERN_EMERG);
+}
+
 DEFINE_SPINLOCK(die_lock);
 
 /*
-- 
2.26.0

