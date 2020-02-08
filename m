Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233DAC35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 15:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EE521775
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 15:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="h3GujHny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgBHPSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 10:18:42 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:46135 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgBHPSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 10:18:41 -0500
Received: by mail-il1-f196.google.com with SMTP id t17so2079798ilm.13
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 07:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=05UDqHMnFIGZNgMWaZBRQc+rDkhyjL/hx+HfcwVpWsc=;
        b=h3GujHnyiWTV/I6mqt9uzTsay5S6PnglQ16sNw6zqsb4xLDwc+VUme5MkRnNIQdxrv
         gtD0HpLqijYksayvj5Nv8bng6BGg8HPVXkT1DiNqse8IdMWsU/GCqoLd3UllIY6kW+pn
         OuVQBu6TMTTrmJzMTVrPjLmASwMBAEhkGuBZeN+EnXE3B389avC1jnWpMAKqrm7A8XRr
         kneo1EU5eRU0gmJhgjDIgXVRFupalci4IK4js7jY0pURMqLMxGWThymTcclPOhu/bTuL
         sb8Pg79bA1IdjVcYY6+aet3r+JI/BWvXuXw96ynHHFhzxIYgVlQYT+LWfrhnp1IBaBDj
         yTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=05UDqHMnFIGZNgMWaZBRQc+rDkhyjL/hx+HfcwVpWsc=;
        b=K450nJocnZVqTUzUI/eZJOCb/55DQFlWpAkc92cqaBxfKK7TwBrsFxVOiHLcuYkw+y
         BsM+ib020Yv2UecORWZxj83Nk6BphyNJCySxqJ3AlJY69Kh8JtTO+QVBH8bac2HC9VYu
         Q9XYMWqJDiPpkRmw47Qj/cT2inNmMrncKz2ZsDcjTlPhvNF+9bjKmMHi2RS8Kxl+jcbS
         z3sR92k+XZwt5+uwR01R7pdKl+77KvlxSkMgabwsrWrijP2DoeBeXRJqHtWiSV2lfDbI
         t4A3XvRqj2hfFIS/TwC4JQ6H7oUMgevg7zk+K81BOuQQSxtMy6O9/Gu83TKfGldm4MF9
         elTw==
X-Gm-Message-State: APjAAAUvNCQjqG53R08t6tg2l0byxo2L5hv76oCX11k2jMhI1jOcGKDZ
        li/QfeaeVIYfZ4YHpTuwSw3XXCSocFA=
X-Google-Smtp-Source: APXvYqyEPDVduHlbFnluY7x7/a3DVkQCxei50+7tpz5mbPU+DcR+UkX1VpcOT+KiOvX27Gh/wEZVMw==
X-Received: by 2002:a92:2907:: with SMTP id l7mr4647042ilg.140.1581175120348;
        Sat, 08 Feb 2020 07:18:40 -0800 (PST)
Received: from cisco.hsd1.co.comcast.net ([2601:282:902:b340:d5ba:eb69:38d6:3b10])
        by smtp.gmail.com with ESMTPSA id h6sm1867794iom.43.2020.02.08.07.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2020 07:18:39 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Tycho Andersen <tycho@tycho.ws>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH] riscv: fix seccomp reject syscall code path
Date:   Sat,  8 Feb 2020 08:18:17 -0700
Message-Id: <20200208151817.12383-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If secure_computing() rejected a system call, we were previously setting
the system call number to -1, to indicate to later code that the syscall
failed. However, if something (e.g. a user notification) was sleeping, and
received a signal, we may set a0 to -ERESTARTSYS and re-try the system call
again.

In this case, seccomp "denies" the syscall (because of the signal), and we
would set a7 to -1, thus losing the value of the system call we want to
restart.

Instead, let's return -1 from do_syscall_trace_enter() to indicate that the
syscall was rejected, so we don't clobber the value in case of -ERESTARTSYS
or whatever.

This commit fixes the user_notification_signal seccomp selftest on riscv to
no longer hang. That test expects the system call to be re-issued after the
signal, and it wasn't due to the above bug. Now that it is, everything
works normally.

Note that in the ptrace (tracer) case, the tracer can set the register
values to whatever they want, so we still need to keep the code that
handles out-of-bounds syscalls. However, we can drop the comment.

We can also drop syscall_set_nr(), since it is no longer used anywhere, and
the code that re-loads the value in a7 because of it.

Reported in: https://lore.kernel.org/bpf/CAEn-LTp=ss0Dfv6J00=rCAy+N78U2AmhqJNjfqjr2FDpPYjxEQ@mail.gmail.com/

Reported-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
Signed-off-by: Tycho Andersen <tycho@tycho.ws>
CC: Kees Cook <keescook@chromium.org>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Oleg Nesterov <oleg@redhat.com>
---
 arch/riscv/include/asm/syscall.h |  7 -------
 arch/riscv/kernel/entry.S        | 11 +++--------
 arch/riscv/kernel/ptrace.c       | 11 +++++------
 3 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index 42347d0981e7..49350c8bd7b0 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -28,13 +28,6 @@ static inline int syscall_get_nr(struct task_struct *task,
 	return regs->a7;
 }
 
-static inline void syscall_set_nr(struct task_struct *task,
-				  struct pt_regs *regs,
-				  int sysno)
-{
-	regs->a7 = sysno;
-}
-
 static inline void syscall_rollback(struct task_struct *task,
 				    struct pt_regs *regs)
 {
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index bad4d85b5e91..208702d8c18e 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -228,20 +228,13 @@ check_syscall_nr:
 	/* Check to make sure we don't jump to a bogus syscall number. */
 	li t0, __NR_syscalls
 	la s0, sys_ni_syscall
-	/*
-	 * The tracer can change syscall number to valid/invalid value.
-	 * We use syscall_set_nr helper in syscall_trace_enter thus we
-	 * cannot trust the current value in a7 and have to reload from
-	 * the current task pt_regs.
-	 */
-	REG_L a7, PT_A7(sp)
 	/*
 	 * Syscall number held in a7.
 	 * If syscall number is above allowed value, redirect to ni_syscall.
 	 */
 	bge a7, t0, 1f
 	/*
-	 * Check if syscall is rejected by tracer or seccomp, i.e., a7 == -1.
+	 * Check if syscall is rejected by tracer, i.e., a7 == -1.
 	 * If yes, we pretend it was executed.
 	 */
 	li t1, -1
@@ -334,6 +327,7 @@ work_resched:
 handle_syscall_trace_enter:
 	move a0, sp
 	call do_syscall_trace_enter
+	move t0, a0
 	REG_L a0, PT_A0(sp)
 	REG_L a1, PT_A1(sp)
 	REG_L a2, PT_A2(sp)
@@ -342,6 +336,7 @@ handle_syscall_trace_enter:
 	REG_L a5, PT_A5(sp)
 	REG_L a6, PT_A6(sp)
 	REG_L a7, PT_A7(sp)
+	bnez t0, ret_from_syscall_rejected
 	j check_syscall_nr
 handle_syscall_trace_exit:
 	move a0, sp
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 407464201b91..444dc7b0fd78 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -148,21 +148,19 @@ long arch_ptrace(struct task_struct *child, long request,
  * Allows PTRACE_SYSCALL to work.  These are called from entry.S in
  * {handle,ret_from}_syscall.
  */
-__visible void do_syscall_trace_enter(struct pt_regs *regs)
+__visible int do_syscall_trace_enter(struct pt_regs *regs)
 {
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		if (tracehook_report_syscall_entry(regs))
-			syscall_set_nr(current, regs, -1);
+			return -1;
 
 	/*
 	 * Do the secure computing after ptrace; failures should be fast.
 	 * If this fails we might have return value in a0 from seccomp
 	 * (via SECCOMP_RET_ERRNO/TRACE).
 	 */
-	if (secure_computing() == -1) {
-		syscall_set_nr(current, regs, -1);
-		return;
-	}
+	if (secure_computing() == -1)
+		return -1;
 
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
@@ -170,6 +168,7 @@ __visible void do_syscall_trace_enter(struct pt_regs *regs)
 #endif
 
 	audit_syscall_entry(regs->a7, regs->a0, regs->a1, regs->a2, regs->a3);
+	return 0;
 }
 
 __visible void do_syscall_trace_exit(struct pt_regs *regs)
-- 
2.20.1

