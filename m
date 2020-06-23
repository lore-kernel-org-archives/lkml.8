Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271B8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F30BE206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Hnbgt/iY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732962AbgFWQaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732224AbgFWQaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:30:18 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5BAC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 09:30:17 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b5so10320258pfp.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 09:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=svQFMTGxDMos7Zg8tKertS+W+IUiIlT4OnjxClBcA7o=;
        b=Hnbgt/iYZulJU0UG1e1axloyahEfWVwa6iyBdAeBlH6S3DEtEHGI1PdtLhPZEZFZya
         Gg4xgEP7jmI5LhIXcQv2UUPKx/kh6lxT34Zp9gkugyu0pgl2pOqEpB97v/sL/DinDfXM
         vWJmdd11YB34y2uj+QgcM0yUwY3Jf9rxyg+E8zSf8RLSzr8btXvIq4fiMTy4MmVko0ou
         QxqanqUE/+yrR8/3HBcgKfXrFkyOw783tdlQqCPccg5XyzdNwqDHUi8sTAqETFQikjut
         jGUjDbifDaSCFn+z7whYp+5hS3mTuua2C3UA6+DCh7TiVBcHf5L8STH9to3H0CyEDJBk
         Jpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=svQFMTGxDMos7Zg8tKertS+W+IUiIlT4OnjxClBcA7o=;
        b=S+YZS4qGr0bCWDzte4/xB09Vdzng/rYiRXYG4rhHmzejcctislVcDSJMIwS/AlqmTC
         WmL9eu0XLDF+EngVJIJBouNBNoJJF44cdxP3foOxC75pNhR8y8voT+bOCqpqC67UFRu9
         KtKKFUTFAZgHya+dk3UWSPOAN2o1b1Lc9R2jtbcrjCYsRoTgh7oEgAOPwZijBgyJWYzw
         ZbOcphsfblsptPIDvYYrleRgq/LxjAAM3hvZIVvRozDb59NteNvAHTs9Iz5o6/+EJzz3
         mdS/zgDd/Q5loE1cqOaxAo7A4XaK5qd0k/C/oyhPAmFzY/cgFa71I9V+6ePySfcvr7t+
         F4hA==
X-Gm-Message-State: AOAM5326/73JdBtiJRcWP1NG3AU9RM6TnyagVb8PhDrpp1ZLoZmCgi/J
        FS95s0w2RvyNulPfbr7h4Wz2SpfHBjWAJraP
X-Google-Smtp-Source: ABdhPJw+EwJo7J4RFH/fthH8Ugwgydgg7palbmvLh1eGCxgExlyhbEQV8Ph+jbpwHFdcSAxn/3YB/Q==
X-Received: by 2002:a62:780c:: with SMTP id t12mr24384306pfc.317.1592929816188;
        Tue, 23 Jun 2020 09:30:16 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id n12sm13753969pgr.88.2020.06.23.09.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 09:30:15 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [PATCH 3/3] x86/dumpstack: Show registers dump with trace's log level
Date:   Tue, 23 Jun 2020 17:29:58 +0100
Message-Id: <20200623162958.331051-4-dima@arista.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623162958.331051-1-dima@arista.com>
References: <20200623162958.331051-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

show_trace_log_lvl() provides x86 platform-specific way to unwind
backtrace with a given log level. Unfortunately, registers dump(s) are
not printed with the same log level - instead, KERN_DEFAULT is always
used.

Arista's switches uses quite common setup with rsyslog, where only
urgent messages goes to console (console_log_level=KERN_ERR), everything
else goes into /var/log/ as the console baud-rate often is indecently
slow (9600 bps).

Backtrace dumps without registers printed have proven to be as useful as
morning standups. Furthermore, in order to introduce KERN_UNSUPPRESSED
(which I believe is still the most elegant way to fix raciness of sysrq[1])
the log level should be passed down the stack to register dumping
functions. Besides, I have a potential use-case for printing traces
with KERN_DEBUG level [2] (where registers dump shouldn't appear with
higher log level).

After all preparations are done, provide log_lvl parameter for
show_regs_if_on_stack() and wire up to actual log level used as
an argument for show_trace_log_lvl().

[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/
[2]: https://lore.kernel.org/linux-doc/20190724170249.9644-1-dima@arista.com/
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/kernel/dumpstack.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index ec90d71979f4..6b00964d5873 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -134,7 +134,7 @@ void show_iret_regs(struct pt_regs *regs, const char *log_lvl)
 }
 
 static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
-				  bool partial)
+				  bool partial, const char *log_lvl)
 {
 	/*
 	 * These on_stack() checks aren't strictly necessary: the unwind code
@@ -146,7 +146,7 @@ static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
 	 * they can be printed in the right context.
 	 */
 	if (!partial && on_stack(info, regs, sizeof(*regs))) {
-		__show_regs(regs, SHOW_REGS_SHORT, KERN_DEFAULT);
+		__show_regs(regs, SHOW_REGS_SHORT, log_lvl);
 
 	} else if (partial && on_stack(info, (void *)regs + IRET_FRAME_OFFSET,
 				       IRET_FRAME_SIZE)) {
@@ -155,7 +155,7 @@ static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
 		 * full pt_regs might not have been saved yet.  In that case
 		 * just print the iret frame.
 		 */
-		show_iret_regs(regs, KERN_DEFAULT);
+		show_iret_regs(regs, log_lvl);
 	}
 }
 
@@ -210,7 +210,7 @@ void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 			printk("%s <%s>\n", log_lvl, stack_name);
 
 		if (regs)
-			show_regs_if_on_stack(&stack_info, regs, partial);
+			show_regs_if_on_stack(&stack_info, regs, partial, log_lvl);
 
 		/*
 		 * Scan the stack, printing any text addresses we find.  At the
@@ -271,7 +271,7 @@ void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 			/* if the frame has entry regs, print them */
 			regs = unwind_get_entry_regs(&state, &partial);
 			if (regs)
-				show_regs_if_on_stack(&stack_info, regs, partial);
+				show_regs_if_on_stack(&stack_info, regs, partial, log_lvl);
 		}
 
 		if (stack_name)
-- 
2.27.0

