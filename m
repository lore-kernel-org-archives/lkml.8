Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A61C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFE020674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="GtMFmdpE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbgCPOlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:41:22 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55598 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731601AbgCPOlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:41:22 -0400
Received: by mail-pj1-f67.google.com with SMTP id mj6so8324458pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dwG4xY1vmJP4LBqy4rZZHCmHEIoQWfUEH/I9u86med8=;
        b=GtMFmdpESs7l/RZTuTYctqnTUGkzhbbX6uHr8O+pfZt/zmEVXndfMrtUZePxZh8K4u
         46rDdJ2lW2jSZD7H6PeukSbzy62GjDn91IxK46ky0BBcnPmb0kzOl2JMOj4IGtUVXM11
         zYaypOxUgo+Bmw+scF7C+EM0w461+J/KHtG0y4MKJb3R+hRNacBt3wwgWq8e1uv3S1qm
         rDeY1gY/nKcQANVBMPSGxaM5WJlaocDoXaviK6u+Sj3MiLdWpDEV4db6z9uL4I3oAsm1
         hzWmtr7yFTCXD5q1sqTcX3MOsFSLxWRIZwpAXgeJbEQIgDNo/zJG4j+sw9Sat3l00XJW
         cKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dwG4xY1vmJP4LBqy4rZZHCmHEIoQWfUEH/I9u86med8=;
        b=YU66teh5jTuuiddl0twJDMkocGOMQV4d2sSd/FcDNzUtxdc19jirdikZ7bVyOQYvnR
         4BeTsV314tbxVVdgIG61oCa5sm5AkPpAwQ2NL2SppkqBp11+dY9n5/7vXdk7flNi9TWp
         WLspeGK0ex/w+M4jUqev93B1DDXeU6KNNhe0/ZRJoDV1jOcbnJ+tEpk4mdU2n103CiQf
         p5Q7wALDzyLUlaun3iAjos7FgL/Eu7l1PTu4SlfvT88nHqeS2r/yycs6lQNi896aNgwg
         Uchb6hkYgHDnny9Wmt/Xp1yuPbe+qLqZjHor1TiB9Q9NBlttfus2W3PvidbGPYKVnGtP
         qz5A==
X-Gm-Message-State: ANhLgQ2IfohqfCrh5SB9JFouUtxKMDRUUpMp5YNtKP08oXkpelY+ZSC8
        Iupa9uTdlxafNRxQbBXOdrlLAjUH9asSUA==
X-Google-Smtp-Source: ADFU+vuE83OnO2cD0mIhCbDbtEK8LJDmiZHkQ/aSHIzBBVYO2QS78g2DUS2B1b5zpPyI1yf20Wa4Yw==
X-Received: by 2002:a17:902:fe83:: with SMTP id x3mr27368604plm.310.1584369680533;
        Mon, 16 Mar 2020 07:41:20 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:41:19 -0700 (PDT)
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
Subject: [PATCHv2 22/50] nds32: Add show_stack_loglvl()
Date:   Mon, 16 Mar 2020 14:38:48 +0000
Message-Id: <20200316143916.195608-23-dima@arista.com>
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
2.25.1

