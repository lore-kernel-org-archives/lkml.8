Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641E1C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 02:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3704221741
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 02:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI2u69cA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgGSCJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 22:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgGSCJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 22:09:21 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22236C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 19:09:21 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t6so7082666plo.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 19:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QtHrNXMSpyatUvUEtvk0zy0sYC+0CsUTNDsn+37VAVw=;
        b=RI2u69cAKbx6QZ8BPbBmXTkTXkEOktawEPEaX1J+QA5VSw+EzTA9yQWF2K1pjNPjqU
         of8yPvby9LmdjPFe33L7fgxNnyC4fQPiIjK/8INhZjXsfxvrQw71eIwiqDlA+yn59WBe
         Ofp/460HjewE8QhLTVvQZzLseslWQYELmhj8karfKPF2PvazPhV0f9VZpX5Vcl6GR0xt
         QIBpCtf24Gygt2ilBMACLM3Fe9vIBQWSbqFwKpBj52WWaTLcq406+/fISbqUsgVPPC7x
         S2GNeaEFZxyQkZtvDdcZfBSyFhvh0KIi/GmO/a2KYXg4HfJ2dLVjH+LAAG7aB/IkrwiU
         eCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QtHrNXMSpyatUvUEtvk0zy0sYC+0CsUTNDsn+37VAVw=;
        b=dSiNSL/cZQJI65L5RTeIdANwfnv0R/B7NR4eX+AQVBK5jIi4OZpxhrP2sZz7VPJWWQ
         gphR4Ml9UmXJYKPvjNsX9yIgzC25eepA2HMUHIFyAlUXVJcllfqNPMJF3U7G9U3Cto2E
         O0BS8TfSl+mb0OdTefvNbj8PKA0YXxZns3RaAEY+j33hpIcbslbmlvqiawjJY2tT4LmW
         RiaE1q49naKAlUTFrTF0235UyvJFQ6fI06x8KcphPI8FClReuUYXZfFJbQr+jhQRb9hl
         veoMwqxa5EJPasS46eflGenqzj0Fyxoa5FkxVCtOVn04vNH6FXhn9DVsyBu48PzmMYs4
         B6zg==
X-Gm-Message-State: AOAM532PySygeDui63dFbHY2ujRjyeZDSOHX0hvrQRd2UihhUJKkEEj1
        lgE55IDYGFyiT0zqAd8MLSOkKQ0g
X-Google-Smtp-Source: ABdhPJyDBS0Gryauf7x/s/qj1hi1aRXGhcLlVdBWgIoatOrfH5k5B6FIAGiHE526huC4vqwg2cZ3sA==
X-Received: by 2002:a17:90a:2681:: with SMTP id m1mr15468157pje.204.1595124560587;
        Sat, 18 Jul 2020 19:09:20 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
        by smtp.gmail.com with ESMTPSA id b8sm5767459pjd.5.2020.07.18.19.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 19:09:19 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: add audit support
Date:   Sat, 18 Jul 2020 19:09:07 -0700
Message-Id: <20200719020907.25742-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All bits needed for syscall audit are present on xtensa. Add
audit_syscall_entry and audit_syscall_exit calls and select
HAVE_ARCH_AUDITSYSCALL in Kconfig.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Kconfig                   | 1 +
 arch/xtensa/include/asm/thread_info.h | 4 +++-
 arch/xtensa/kernel/ptrace.c           | 6 ++++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 3a9f1e80394a..a7def0991a01 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -21,6 +21,7 @@ config XTENSA
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_STRNCPY_FROM_USER if KASAN
+	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
 	select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/xtensa/include/asm/thread_info.h b/arch/xtensa/include/asm/thread_info.h
index f092cc3f4e66..c49cc4a1f39a 100644
--- a/arch/xtensa/include/asm/thread_info.h
+++ b/arch/xtensa/include/asm/thread_info.h
@@ -111,15 +111,17 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_RESTORE_SIGMASK	6	/* restore signal mask in do_signal() */
 #define TIF_NOTIFY_RESUME	7	/* callback before returning to user */
 #define TIF_DB_DISABLED		8	/* debug trap disabled for syscall */
+#define TIF_SYSCALL_AUDIT	9	/* syscall auditing active */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
+#define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 
 #define _TIF_WORK_MASK		(_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP | \
-				 _TIF_SYSCALL_TRACEPOINT)
+				 _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_AUDIT)
 
 #define THREAD_SIZE KERNEL_STACK_SIZE
 #define THREAD_SIZE_ORDER (KERNEL_STACK_SHIFT - PAGE_SHIFT)
diff --git a/arch/xtensa/kernel/ptrace.c b/arch/xtensa/kernel/ptrace.c
index b4c07bd890fe..0278d7dfb4d6 100644
--- a/arch/xtensa/kernel/ptrace.c
+++ b/arch/xtensa/kernel/ptrace.c
@@ -12,6 +12,7 @@
  * Marc Gauthier<marc@tensilica.com> <marc@alumni.uwaterloo.ca>
  */
 
+#include <linux/audit.h>
 #include <linux/errno.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/kernel.h>
@@ -562,6 +563,9 @@ int do_syscall_trace_enter(struct pt_regs *regs)
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, syscall_get_nr(current, regs));
 
+	audit_syscall_entry(regs->syscall, regs->areg[6],
+			    regs->areg[3], regs->areg[4],
+			    regs->areg[5]);
 	return 1;
 }
 
@@ -569,6 +573,8 @@ void do_syscall_trace_leave(struct pt_regs *regs)
 {
 	int step;
 
+	audit_syscall_exit(regs);
+
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_exit(regs, regs_return_value(regs));
 
-- 
2.20.1

