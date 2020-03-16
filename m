Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1905C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F08320674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="j2dCzMnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbgCPOkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:40:36 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38638 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731680AbgCPOkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:40:35 -0400
Received: by mail-pj1-f68.google.com with SMTP id m15so8120258pje.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CcweBVeomVP6AVxa4B5QKeeH8QySXqKepsYVzxsSOwk=;
        b=j2dCzMnceihOn5sWeWeL5l6xY9VAtWVLa5doXR0278a9LlmBuZj9qlcgxUtO+jBkSP
         XYm0w7VAjhfXPriZ8mOInAkVO4VBZhNZuPSRpY6HR/2CtDqpZeagFhwhq8yCxC3Zd95P
         L/Hu4IEMkTMfl4FRbxlu1sgtEXwYfbOC84m7LFu203B8cUgI/gvg7L5XPobBuuSMcNxW
         tc9Zf6Ayz+FnyxvEHHQtLTf5bW9aWUX9B8YU5lltaMGEqKiKfWrjrcVjBW9tc0+DNXv5
         aQ6wtwmhskupXUV0JjmQVzdvoycP3Tss33nNhIXPcKu4o1w4O4CNBdWZ75nrjjaRljGW
         LJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CcweBVeomVP6AVxa4B5QKeeH8QySXqKepsYVzxsSOwk=;
        b=SBPigAn65wGHkRF5IFAV5RitgrIruj0ds/6Zt48CjSovkn140BppzpKbToEp64uDwF
         dwRlUi0CaoOalZZzy4TXNqhtRDJ/5g8dfX6Itqzsvg86HhDTcR8JCqx48GZWCsgFvngE
         8jdp1MB2sU5WrQuzX19JfdUtY0uqTncF1Z/hIWAJhpdsp6Jr21SSV81xhMvnoUz5qL2V
         ZcqurL5Wax2YrU2oj7SU5ChfvynKT69ogb650j8kd3UCZ+7vf2V8OxaMXExOS93TNg3o
         b8JrHW2SMj9BCLgJCRDK9PFmTb05DYOtDpPKkJyZlWhqXcx4m+yBoxocuthF4UJjIqXe
         yMPg==
X-Gm-Message-State: ANhLgQ3i4QCu0mGKUy9iF+t4a/UT2miVsPRDEaAzaIeD4bIFxaamXIFr
        ZR3RCsIb8fX5fZgRQNoCCvoND/9UFu3mzg==
X-Google-Smtp-Source: ADFU+vveadsaZVAEEdgIr29gK4eVhFLWT3pqUqNdzZrXFNkH1tu+jSRKwhOo/hYXLX5GPOIJB2hmIw==
X-Received: by 2002:a17:902:8e8b:: with SMTP id bg11mr27000880plb.138.1584369633094;
        Mon, 16 Mar 2020 07:40:33 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:40:32 -0700 (PDT)
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
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Mark Salter <msalter@redhat.com>, linux-c6x-dev@linux-c6x.org
Subject: [PATCHv2 11/50] c6x: Add show_stack_loglvl()
Date:   Mon, 16 Mar 2020 14:38:37 +0000
Message-Id: <20200316143916.195608-12-dima@arista.com>
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

Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Cc: Mark Salter <msalter@redhat.com>
Cc: linux-c6x-dev@linux-c6x.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/c6x/kernel/traps.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/c6x/kernel/traps.c b/arch/c6x/kernel/traps.c
index ec61034fdf56..4afbf48f1ce0 100644
--- a/arch/c6x/kernel/traps.c
+++ b/arch/c6x/kernel/traps.c
@@ -344,12 +344,13 @@ asmlinkage int process_exception(struct pt_regs *regs)
 
 static int kstack_depth_to_print = 48;
 
-static void show_trace(unsigned long *stack, unsigned long *endstack)
+static void show_trace(unsigned long *stack, unsigned long *endstack,
+		       const char *loglvl)
 {
 	unsigned long addr;
 	int i;
 
-	pr_debug("Call trace:");
+	printk("%sCall trace:", loglvl);
 	i = 0;
 	while (stack + 1 <= endstack) {
 		addr = *stack++;
@@ -364,16 +365,17 @@ static void show_trace(unsigned long *stack, unsigned long *endstack)
 		if (__kernel_text_address(addr)) {
 #ifndef CONFIG_KALLSYMS
 			if (i % 5 == 0)
-				pr_debug("\n	    ");
+				printk("%s\n	    ", loglvl);
 #endif
-			pr_debug(" [<%08lx>] %pS\n", addr, (void *)addr);
+			printk("%s [<%08lx>] %pS\n", loglvl, addr, (void *)addr);
 			i++;
 		}
 	}
-	pr_debug("\n");
+	printk("%s\n", loglvl);
 }
 
-void show_stack(struct task_struct *task, unsigned long *stack)
+void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
+		const char *loglvl)
 {
 	unsigned long *p, *endstack;
 	int i;
@@ -398,7 +400,12 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 		pr_cont(" %08lx", *p++);
 	}
 	pr_cont("\n");
-	show_trace(stack, endstack);
+	show_trace(stack, endstack, loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *stack)
+{
+	show_stack_loglvl(task, stack, KERN_DEBUG);
 }
 
 int is_valid_bugaddr(unsigned long addr)
-- 
2.25.1

