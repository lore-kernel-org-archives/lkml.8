Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B876C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45D532223F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Y4bGS6hI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgDRUUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728097AbgDRUUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:49 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA174C061A10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:48 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k11so7173661wrp.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xn0V6B7rOrMeB1WATzDK2oUBmWV+AxirN6LrXtaO9xI=;
        b=Y4bGS6hI7V4xsm54BOfkBHx3PF/hwiWI+JmCBEHiZdBsCI74a8OOsaauOhKhzf8Cjg
         Yb13XlaazXfJMlKqzgbE/yNsXhlA9Ixlz+Kn32Jc9DoFRXIY2qiuyVLy9GnNVAC1rX8x
         4DZdWo8/Ex6NL+mmNoeQqv97RlaYsXqVvOOuMYVfUXcbARPbb2pC6g4JuZ8nqDw4Q3Ps
         /upTcYhiy3h2Mw0LF8xFDaaYjAGgoo+kcgpvlJsCK6D4YTmWD9m3sfT1s+1M4paGyzS+
         BZ1COwuHKGIUIkl9/ydKxmomgqWxQLwWI2BzkXeMLnFnqA8wlSha8puc0drwbTyI7/P8
         Lv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xn0V6B7rOrMeB1WATzDK2oUBmWV+AxirN6LrXtaO9xI=;
        b=sXmpinhskBiLslZzT36B2hc4g6EamSo+KWc+nCz5q6YSrHEbDHvXGjB2WPw5nPUO3n
         qyyWeFTajRB9iokVHVyAIFmIlrwpHNt8EbFff/xUNNGgNxrE7rRvqx00ZxJShIq02z4o
         LxGhpSzecnV+upsiwitTZ1ncGKGF7IEu9/qt7QfUzn+HA+PX3hhR8DqjSpmORpgtLhuk
         4VUxgIvUCV4VkvJhTsvF9ml/a2rPI2FjuqvgHyEj+oUdYjWXPbLoInu2kX4ls0kfONVZ
         xK3eEuoKNMF2TpyBtOpg69npS2+7ovMq9ncXpVTQvYdg0JbMISHzCmMC+vRxMxSJ0Iqs
         TOvw==
X-Gm-Message-State: AGi0PuZ4Iq/zXPSnvSk/RL/MK6TVlY3U0vHRrcTY6Z9axou9D/x7SZus
        wKhvv8bWtB14lvM1SbrhBKvQ9QHTwAQ=
X-Google-Smtp-Source: APiQypJ9nRQaYYtzpugf4SYZIllnvMmyqQLK9c3rNeiglt5XhcUhnAYNqKgri3RN46NdZfBNdopp6w==
X-Received: by 2002:a05:6000:162c:: with SMTP id v12mr11091951wrb.313.1587241247174;
        Sat, 18 Apr 2020 13:20:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:46 -0700 (PDT)
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
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCHv3 42/50] xtensa: Add loglvl to show_trace()
Date:   Sat, 18 Apr 2020 21:19:36 +0100
Message-Id: <20200418201944.482088-43-dima@arista.com>
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

Add log level argument to show_trace() as a preparation for introducing
show_stack_loglvl().

Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/xtensa/kernel/traps.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 0976e27b8d5d..c397a02457bc 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -479,18 +479,22 @@ void show_regs(struct pt_regs * regs)
 
 static int show_trace_cb(struct stackframe *frame, void *data)
 {
+	const char *loglvl = data;
+
 	if (kernel_text_address(frame->pc))
-		pr_cont(" [<%08lx>] %pB\n", frame->pc, (void *)frame->pc);
+		printk("%s [<%08lx>] %pB\n",
+			loglvl, frame->pc, (void *)frame->pc);
 	return 0;
 }
 
-void show_trace(struct task_struct *task, unsigned long *sp)
+static void show_trace(struct task_struct *task, unsigned long *sp,
+		       const char *loglvl)
 {
 	if (!sp)
 		sp = stack_pointer(task);
 
-	pr_info("Call Trace:\n");
-	walk_stackframe(sp, show_trace_cb, NULL);
+	printk("%sCall Trace:\n", loglvl);
+	walk_stackframe(sp, show_trace_cb, (void *)loglvl);
 }
 
 #define STACK_DUMP_ENTRY_SIZE 4
@@ -511,7 +515,7 @@ void show_stack(struct task_struct *task, unsigned long *sp)
 	print_hex_dump(KERN_INFO, " ", DUMP_PREFIX_NONE,
 		       STACK_DUMP_LINE_SIZE, STACK_DUMP_ENTRY_SIZE,
 		       sp, len, false);
-	show_trace(task, sp);
+	show_trace(task, stack, KERN_INFO);
 }
 
 DEFINE_SPINLOCK(die_lock);
-- 
2.26.0

