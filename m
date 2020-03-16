Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4A3C3F2CE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2ACA20674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="WEXipQvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbgCPOlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:41:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35300 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbgCPOlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:41:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id 7so9884390pgr.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XVNpRwDg0MuGmzFxA36r33yCChtq9x1Gs5FT6H3M82A=;
        b=WEXipQvsuTlA0+MY4ArVFZJj4l0UkPQaEjj3vrMcJd3GX5u8yEAuYFyBVI9RQ9IDPz
         5Fo7qeycvpKHWlY/HUV+IsnFJ3bkDlIfnIyxi5UPWuP0F5fuGMwudZTEtjqYKwDXLMS0
         nuxObP2Ffm72vHA19VklehkDeaxdIF3c4RL9jGzCS8ZI/Yf532YM/wHkgmkyhcesGfEw
         KQ8dgZhY3wY9uKSsdXMVwpD9Jh3+O3nFAzKizD+NKrzNkqIUjGivmjNag/fpBSEmAN4H
         buq0eqsj9cvwmkHqPmrI73OtdqL3jnbAKHpTEq1yLwWl/zgDupeG/Af+77Kj3fUwU75o
         WAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XVNpRwDg0MuGmzFxA36r33yCChtq9x1Gs5FT6H3M82A=;
        b=T43R0pl4GZ3bDh1sg9ewe+4D1hw2aQ3hMr2IxFgbxXwVsMlcqUukHieRYFRVudvumG
         f5ifRnuru8OqYtU1m1aKNqu3E2U26HVlm2zMhwUE0dXNjLOIucDprCrjYPC3RSq95pwH
         audyvA6lRkD9RhdvqhzeMF8FDlyrQW/o+DTIzAzbGJxXbC4glm0cghZ4/jtYnRvqiHM5
         ugv8NGDhaAdd47b/hiL9n1whLIbDfxDBsgl8bKCFJjCH9gYxAE4XIy2zeReS4746bXpN
         1umCfMV0wSCdc9oZWl6K4xlRgwgfkaOsK7WHz2w6pOo7ngJjTrQiXSCaLjrDrokPFNmg
         ZAtA==
X-Gm-Message-State: ANhLgQ0Xg2W0hHKjhjsA7w/HolbQ1zqHsRlfTxjhkxyS4v0qL2g/4PEc
        8gacjOWQs6AeiJVKaAcoGneyYCFDqYFhyA==
X-Google-Smtp-Source: ADFU+vt3yredXLeDqKfiogW0YZXQQCh4jnp+OwYD5kx6CmCzMga/XGXLSbII9gENZrBDjAJ0uuh4Iw==
X-Received: by 2002:a63:7c54:: with SMTP id l20mr212877pgn.158.1584369667011;
        Mon, 16 Mar 2020 07:41:07 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:41:06 -0700 (PDT)
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
Subject: [PATCHv2 19/50] microblaze: Add loglvl to microblaze_unwind()
Date:   Mon, 16 Mar 2020 14:38:45 +0000
Message-Id: <20200316143916.195608-20-dima@arista.com>
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
index d248b7de4b13..7c28f8d5a243 100644
--- a/arch/microblaze/include/asm/unwind.h
+++ b/arch/microblaze/include/asm/unwind.h
@@ -23,7 +23,8 @@ extern struct trap_handler_info microblaze_trap_handlers;
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
2.25.1

