Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047F6C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB10821D93
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Qh1eKuj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgDRUWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728472AbgDRUUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:17 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FDEC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:17 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x25so6514906wmc.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ckiWY+lC4SQS0j1rXwGNcckYdMT6/ueR+De9QprAHk=;
        b=Qh1eKuj+3p6jIyd/Z93zStqKEFquwt3zcqpeaF02feFM9tj9J9PN8wFc2oImHqWSh9
         z7HCFyxgfErcDkGdVf/+0YgdY2To0I2itZcc4zgCh+TlhkUsTG+pEZKiayxZTbSO5cy6
         N1gLdKLjejgOSfxs53fjhwslAja81RG+TR01vBksarvDc3VDB1qX09kI+9mKRtnF4Mtr
         IR/5mT1LURUvbiPHXCpjuS7nGreU4q2frbhxKbBhl23WcTCUMxY9WGyCUxw/wZy1d0Xy
         feuhXx/F6fKSkJxfIACcF6eQpy57pCPYfhpscGgFK+bIG4WwsYJEo9+wB+hI2QuzhTuC
         y4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ckiWY+lC4SQS0j1rXwGNcckYdMT6/ueR+De9QprAHk=;
        b=hRnIF4G9xo/Aku8eX8PzF35sbbeh5UU46hXy3RdkNwPlw/A2y/t01oISpCrXuixJKo
         Sm1Zqxhc+jjSM9cME7OnTdSm6RNRAYJtKFk/STNMzJYxHcCU5VxLhVVXWBrQ/UvrbTys
         VZ1AiyHDqIalH0HZD1yflkbxOm2DqPXERlf0wbOoYPQZQ8ASIr7ntLkwo4uOk07WlYsp
         +RTr1JjO+XbcRwyVOOTbXZHbLHGIwjW1sH8jr2UXBaBcaKHR57F3ZvJnkoJ+IeZJpwM2
         QOgjpHU6sG/PzqIe7biRSkz4WS7rE5EYHDg4g9Pe3YDzXoZevPo4Ur01Tk7BrlisTqIo
         zHrA==
X-Gm-Message-State: AGi0PubMJDLlueHXN8jCqsc9gPASk4vCw7o9MhFTq3jk1MiTzE2IsSq5
        4zoh2FC9p5L6abhlbwpsNrfc432kxG0=
X-Google-Smtp-Source: APiQypKl8SBo31RW8xxPaBVV8bWhYKYORHum1IiJtx1d/TaB+O95pgl1/vlA0dfG88kbvFwW6owrCQ==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr9389141wmh.120.1587241215468;
        Sat, 18 Apr 2020 13:20:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:15 -0700 (PDT)
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
        Michal Simek <monstr@monstr.eu>
Subject: [PATCHv3 19/50] microblaze: Add loglvl to microblaze_unwind()
Date:   Sat, 18 Apr 2020 21:19:13 +0100
Message-Id: <20200418201944.482088-20-dima@arista.com>
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

Add log level parameter to microblaze_unwind() as a preparation to add
show_stack_loglvl().

Cc: Michal Simek <monstr@monstr.eu>
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/microblaze/include/asm/unwind.h | 3 ++-
 arch/microblaze/kernel/stacktrace.c  | 4 ++--
 arch/microblaze/kernel/traps.c       | 2 +-
 arch/microblaze/kernel/unwind.c      | 6 +++---
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/microblaze/include/asm/unwind.h b/arch/microblaze/include/asm/unwind.h
index c327d673622a..3db81777a887 100644
--- a/arch/microblaze/include/asm/unwind.h
+++ b/arch/microblaze/include/asm/unwind.h
@@ -20,7 +20,8 @@ extern struct trap_handler_info microblaze_trap_handlers;
 extern const char _hw_exception_handler;
 extern const char ex_handler_unhandled;
 
-void microblaze_unwind(struct task_struct *task, struct stack_trace *trace);
+void microblaze_unwind(struct task_struct *task, struct stack_trace *trace,
+		       const char *loglvl);
 
 #endif	/* __MICROBLAZE_UNWIND_H */
 
diff --git a/arch/microblaze/kernel/stacktrace.c b/arch/microblaze/kernel/stacktrace.c
index b4debe283a79..b266c4d6ed9d 100644
--- a/arch/microblaze/kernel/stacktrace.c
+++ b/arch/microblaze/kernel/stacktrace.c
@@ -20,12 +20,12 @@ void save_stack_trace(struct stack_trace *trace)
 {
 	/* Exclude our helper functions from the trace*/
 	trace->skip += 2;
-	microblaze_unwind(NULL, trace);
+	microblaze_unwind(NULL, trace, "");
 }
 EXPORT_SYMBOL_GPL(save_stack_trace);
 
 void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 {
-	microblaze_unwind(tsk, trace);
+	microblaze_unwind(tsk, trace, "");
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
diff --git a/arch/microblaze/kernel/traps.c b/arch/microblaze/kernel/traps.c
index 45bbba9d919f..be726ee120fb 100644
--- a/arch/microblaze/kernel/traps.c
+++ b/arch/microblaze/kernel/traps.c
@@ -68,7 +68,7 @@ void show_stack(struct task_struct *task, unsigned long *sp)
 	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_ADDRESS, 32, 4, (void *)fp,
 		       words_to_show << 2, 0);
 	pr_info("\n\nCall Trace:\n");
-	microblaze_unwind(task, NULL);
+	microblaze_unwind(task, NULL, KERN_INFO);
 	pr_info("\n");
 
 	if (!task)
diff --git a/arch/microblaze/kernel/unwind.c b/arch/microblaze/kernel/unwind.c
index 804bf0c99d8b..778a761af0a7 100644
--- a/arch/microblaze/kernel/unwind.c
+++ b/arch/microblaze/kernel/unwind.c
@@ -287,11 +287,11 @@ static void microblaze_unwind_inner(struct task_struct *task,
  * @task  : Task whose stack we are to unwind (NULL == current)
  * @trace : Where to store stack backtrace (PC values).
  *	    NULL == print backtrace to kernel log
+ * @loglvl : Used for printk log level if (trace == NULL).
  */
-void microblaze_unwind(struct task_struct *task, struct stack_trace *trace)
+void microblaze_unwind(struct task_struct *task, struct stack_trace *trace,
+		       const char *loglvl)
 {
-	const char *loglvl = KERN_INFO;
-
 	if (task) {
 		if (task == current) {
 			const struct pt_regs *regs = task_pt_regs(task);
-- 
2.26.0

