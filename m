Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEDAC352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5260C22251
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="exa1nBGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgDRUVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728228AbgDRUUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:45 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7592BC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:44 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x4so6505013wmj.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vu+pRoqBs+RbxypstD4RRiirNsK8A0iLng3dIdjr4HU=;
        b=exa1nBGvN/wPpcMTo5SRkrZ7vL4dz6Xys7YPV4XcgIdLo1mqVXycfU2PkWMD4ZUtwN
         KgqW/kiCQ5Rj46o20VQRGoyuEhbAG99ZLrL9AFJG8DYqChpKHn5XK9EDjcRwYBjPdh7g
         JqIqgVGNsnO9QMu504aQY5XML4zWkRCwiaOVVvkhsfvgY3bDCQRkqltSTq+GPVSIfV1q
         1KE+AtLRd4k0AmoxyU5OHoj22SYC7G5jCxziD37V9bJpAv8hCLnZPb/RgGeKx2PG8EDp
         kqlvdBIDsKiYhof8ot0F9wGjIw2JdGnjN2Ql3SfVfIVrh2SacyQwttfMr+WoIY5MmQnJ
         Ld3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vu+pRoqBs+RbxypstD4RRiirNsK8A0iLng3dIdjr4HU=;
        b=THExPkRMl8FmnpEFjy3cIUeC/qtWCHNAjbc96R9C3tW9dAhJZVm6YMXF+RswDbkNLc
         ixe/AkA/ezZVRwiyk40NQlhci6IMpol+zf/Ufnpj+KKSlVh1A8MQMly1+BXAfiFEwLS/
         NDJKYntYb2vtmmpRhJRN5ldeQ9XHlBqXom9hUPFsu6PJcTPTUj3M/LeQK7or4LN9fpO4
         V/xIhPW6nYcz7qmX9UMoUA8YVa+9J1P0ahl4cRlv/NT4aCJRcwT8IniGaB2hgCNYGzk8
         dHmrpVzmV6gGlMyi38v+QP9YX9fLNfO5cSrPukRozgt+vLbv9qqyiEWWKdSFipJ+hZwR
         zTXw==
X-Gm-Message-State: AGi0Pua1ni1tWR5TfdRE7wCiWQ1kXB6sYnCZn7kgt4DkWUa9ewnrlbfK
        qmV8EzY5LJ5vozQToveZjWAT0VAG/d4=
X-Google-Smtp-Source: APiQypI/aiMQS7BxkJemipn+7L8Bm9xmiyXnjGpgMmQ9v5KukpQjBV/aQ4n4vzgwijuMxxMjTPOlUw==
X-Received: by 2002:a1c:bb08:: with SMTP id l8mr10460143wmf.168.1587241242976;
        Sat, 18 Apr 2020 13:20:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:42 -0700 (PDT)
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
Subject: [PATCHv3 39/50] unicore32: Add show_stack_loglvl()
Date:   Sat, 18 Apr 2020 21:19:33 +0100
Message-Id: <20200418201944.482088-40-dima@arista.com>
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
2.26.0

