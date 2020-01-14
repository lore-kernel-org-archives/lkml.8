Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AE4C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6F02467C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XeCJbWOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgANMtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 07:49:33 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:54570 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgANMtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 07:49:32 -0500
Received: by mail-pl1-f202.google.com with SMTP id f10so5061469plr.21
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 04:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=sVzqQ6fMFKvf6/qthqEQJR/jG26iiS1B70RE5p8wL2Q=;
        b=XeCJbWOqSEczoE2tQGeAvmGiJmdv3zXmRDHm7cv2GSw1oo1q3ipd0z9QRe1tH91jkV
         YoPkeAYKhKWsqL1IgLleBqozcJjZfD8JIwv3FfXULMfULCk5rD81GW5/qSJaH6GgGkkR
         OZIE+O+YdkgHrJwAASQ2yvCBtaWzBGvKYvQUUu2HecwXmWcSNenYGRn+TPeLuIPH1ONy
         FpJ56xA/LTwpvINV4q9weDS428a49ut0SzpJao2au5LX8OY/mQJJIiD6hn9zTxNUdz20
         1FVklAQXkVcWxkDiqD4viiwiej1Gb+K+oLNWF4+a6eNlvIRFt6HuCK0FcD4SM1KPWmsi
         mAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=sVzqQ6fMFKvf6/qthqEQJR/jG26iiS1B70RE5p8wL2Q=;
        b=ZIhCIR4Kr9ER19XK1rGj8MToofg5GEoxAEvFc66QtGv2ka9UZW9Wo//HQ/U8flNvd6
         kaELNbQAwafklpxgDQm4dQ/ll/f+yuPgVekAYRpnAE8EADEc0EYgMbcFeMbXs8YT8fVl
         LKE/wT10XtwvUJeOM5ApIvwNR7Qup29aCj2utRDQ2rvwN4SoXFE+a06mvx5uZyENlOyV
         xeAAfGNoS25tw/Q4DB0ttE+TWU8xu8x+r3OoUfyYVxFWPksob3Ov0xujHq10IIwS/GVi
         gzScmJkrx+tnldkA+9dUdPBH0zFAoG5hEnI7XqJ00ze7ln/EYbzgt6Mt4v4SCzCaFeR1
         Sn0Q==
X-Gm-Message-State: APjAAAUOhWsKSUZB8tuccZ/uk6UPKnMSmimOm7oA/imv9yCMsmHOZA3x
        CRjbuBpwfIaX80Aknnvgvnb8O4SgQw==
X-Google-Smtp-Source: APXvYqyKtqX1dzLhnKhTlay39QcxJWkTJlPLPZOql44JeZt1IPifijPT/DiSLdDm2lWFZa1OFcI+KXDi+g==
X-Received: by 2002:a67:1447:: with SMTP id 68mr1189159vsu.76.1579006170515;
 Tue, 14 Jan 2020 04:49:30 -0800 (PST)
Date:   Tue, 14 Jan 2020 13:49:19 +0100
Message-Id: <20200114124919.11891-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH -rcu] kcsan: Make KCSAN compatible with lockdep
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid unexpected reentry into lockdep's IRQ tracing code via KCSAN
(if TRACE_IRQFLAGS is enabled), (1) use raw versions of
local_irq_{save,restore} in kcsan_setup_watchpoint(), and (2) disable
lockdep in kcsan_report() to avoid IRQ flags tracing upon generating the
report.

Tested with:

  CONFIG_LOCKDEP=y
  CONFIG_DEBUG_LOCKDEP=y

Where previously, the following warning (and variants with different
stack traces) was consistently generated, with the fix introduced in
this patch, the warning cannot be reproduced.

    WARNING: CPU: 0 PID: 2 at kernel/locking/lockdep.c:4406 check_flags.part.0+0x101/0x220
    Modules linked in:
    CPU: 0 PID: 2 Comm: kthreadd Not tainted 5.5.0-rc1+ #11
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
    RIP: 0010:check_flags.part.0+0x101/0x220
    <snip>
    Call Trace:
     lock_is_held_type+0x69/0x150
     freezer_fork+0x20b/0x370
     cgroup_post_fork+0x2c9/0x5c0
     copy_process+0x2675/0x3b40
     _do_fork+0xbe/0xa30
     ? _raw_spin_unlock_irqrestore+0x40/0x50
     ? match_held_lock+0x56/0x250
     ? kthread_park+0xf0/0xf0
     kernel_thread+0xa6/0xd0
     ? kthread_park+0xf0/0xf0
     kthreadd+0x321/0x3d0
     ? kthread_create_on_cpu+0x130/0x130
     ret_from_fork+0x3a/0x50
    irq event stamp: 64
    hardirqs last  enabled at (63): [<ffffffff9a7995d0>] _raw_spin_unlock_irqrestore+0x40/0x50
    hardirqs last disabled at (64): [<ffffffff992a96d2>] kcsan_setup_watchpoint+0x92/0x460
    softirqs last  enabled at (32): [<ffffffff990489b8>] fpu__copy+0xe8/0x470
    softirqs last disabled at (30): [<ffffffff99048939>] fpu__copy+0x69/0x470

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/core.c     |  4 ++--
 kernel/kcsan/report.c   | 11 +++++++++++
 kernel/locking/Makefile |  3 +++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 87bf857c8893..e75f3dbf627e 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -337,7 +337,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 *      detection point of view) to simply disable preemptions to ensure
 	 *      as many tasks as possible run on other CPUs.
 	 */
-	local_irq_save(irq_flags);
+	raw_local_irq_save(irq_flags);
 
 	watchpoint = insert_watchpoint((unsigned long)ptr, size, is_write);
 	if (watchpoint == NULL) {
@@ -429,7 +429,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 
 	kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
 out_unlock:
-	local_irq_restore(irq_flags);
+	raw_local_irq_restore(irq_flags);
 out:
 	user_access_restore(ua_flags);
 }
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index b5b4feea49de..57ab7ef9786c 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -2,6 +2,7 @@
 
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/lockdep.h>
 #include <linux/preempt.h>
 #include <linux/printk.h>
 #include <linux/sched.h>
@@ -410,6 +411,14 @@ void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 {
 	unsigned long flags = 0;
 
+	/*
+	 * With TRACE_IRQFLAGS, lockdep's internal IRQ flags state becomes
+	 * corrupted if we do not turn off lockdep. The likely cause is
+	 * unexpected reentry into IRQ tracing code via KCSAN if we detect a
+	 * data race.
+	 */
+	lockdep_off();
+
 	kcsan_disable_current();
 	if (prepare_report(&flags, ptr, size, access_type, cpu_id, type)) {
 		if (print_report(ptr, size, access_type, value_change, cpu_id, type) && panic_on_warn)
@@ -418,4 +427,6 @@ void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 		release_report(&flags, type);
 	}
 	kcsan_enable_current();
+
+	lockdep_on();
 }
diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 45452facff3b..6d11cfb9b41f 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -5,6 +5,9 @@ KCOV_INSTRUMENT		:= n
 
 obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o
 
+# Avoid recursion lockdep -> KCSAN -> ... -> lockdep.
+KCSAN_SANITIZE_lockdep.o := n
+
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_lockdep.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_lockdep_proc.o = $(CC_FLAGS_FTRACE)
-- 
2.25.0.rc1.283.g88dfdc4193-goog

