Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0CCC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E4220842
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvNnPvKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgCCEm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 23:42:28 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39927 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgCCEm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 23:42:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id l7so815942pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 20:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U6duRWraf8EaQi0o/dvKzroqytjT7Ei3jM9dYO7Znh0=;
        b=mvNnPvKL2qk6jSdT/iVB8CdoDzZTE31ZGy9g/3g1FuUV7HBrgauX0+LUVlue54XNL3
         EuVrzaJQ8eZs8U1cQkhmPYXJq7YpppJjmRDennu10PiBJjcneJ2owqrYOLSQ2dAUwIK2
         3/gOfs5/108g/w/N8Ga4F50+a6Wg8m6rup7QFrAQBV3xj98+dsSa1reMogpZnc1X5mUH
         5nnb2Ghh8mWRzcDSmTBbV4PDBMmc+wce1Hlz0ZFLvJENgPuXmmqAnouLVAYG1kW3XfDM
         NCcyxrG67czwMIvexo4u8KnlYXr9t4JUdOWKZoqTJojgnhKfBD1GkAFyxzSPHZa3OPoy
         BJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U6duRWraf8EaQi0o/dvKzroqytjT7Ei3jM9dYO7Znh0=;
        b=ZU3ogD8krDkylqpOR6d2lfmxj6X92sZdm0tb7lSjLRHBbROTP/+h6Zrh4osuVWTVB+
         UmhJbHbI9YSw6s9dBoIj1sZ1K5fXlEYCgyQtwT7T8AwrVSS/gFFdT/e4SABzVSFNVA17
         eZOXaHo+KYmDQFLU0zSULpvq5KztbZOMqNwqPtRI4BxjsNMI7rO7sCDdi5EVuaEFVMFn
         pTwDUgXXlb2855yJvI0mz9EAwHw3idZVMZ3T4jU5/ZWOFUbGsYUVeqWwR6TXdb8mNtC9
         okP50A9AICkuOJBvCJZx/uKTGVLDeePjiA6H1yD4Gldocaftt6h/GpytscolxfsohVFW
         dMmg==
X-Gm-Message-State: ANhLgQ3w3RT4sL6i6Bw/tHOG6+aFV4smPjJREKx7cjq0aWbnM0a5F/2G
        IZgw7m0VK6hp6FwWwd+ZU/rB3m5u
X-Google-Smtp-Source: ADFU+vvAhmvbn+zxwYplvJTYDWCVbROZowmT6QIvRNLnCyZnul2KOVCgOIB5r4bZQgbC5V+GN0Qz2g==
X-Received: by 2002:aa7:93a6:: with SMTP id x6mr2424759pff.72.1583210546365;
        Mon, 02 Mar 2020 20:42:26 -0800 (PST)
Received: from localhost.localdomain (167.117.30.125.dy.iij4u.or.jp. [125.30.117.167])
        by smtp.gmail.com with ESMTPSA id x4sm23116465pff.143.2020.03.02.20.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 20:42:25 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH] printk: queue wake_up_klogd irq_work only if per-CPU areas are ready
Date:   Tue,  3 Mar 2020 13:40:59 +0900
Message-Id: <20200303044059.1325-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

printk_deferred(), similarly to printk_safe/printk_nmi,
does not immediately attempt to print a new message on
the consoles, avoiding calls into non-reentrant kernel
paths, e.g. scheduler or timekeeping, which potentially
can deadlock the system. Those printk() flavors, instead,
rely on per-CPU flush irq_work to print messages from
safer contexts. For same reasons (recursive scheduler or
timekeeping calls) printk() uses per-CPU irq_work in
order to wake up user space syslog/kmsg readers.

However, only printk_safe/printk_nmi do make sure that
per-CPU areas have been initialised and that it's safe
to modify per-CPU irq_work. This means that, for instance,
should printk_deferred() be invoked "too early", that
is before per-CPU areas are initialised, printk_deferred()
will perform illegal per-CPU access.

Lech Perczak [0] reports that after commit 1b710b1b10ef
("char/random: silence a lockdep splat with printk()")
user-space syslog/kmsg readers are not able to read new
kernel messages. The reason is printk_deferred() being
called too early (as was pointed out by Petr and John).

Fix printk_deferred() and do not queue per-CPU irq_work
before per-CPU areas are initialized.

[0] https://lore.kernel.org/lkml/aa0732c6-5c4e-8a8b-a1c1-75ebe3dca05b@camlintechnologies.com/

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Reported-by: Lech Perczak <l.perczak@camlintechnologies.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h    |  3 +++
 kernel/printk/printk.c      | 31 +++++++++++++++++++++++++++++++
 kernel/printk/printk_safe.c | 11 +----------
 3 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index c8e6ab689d42..8ed2b7737063 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -23,6 +23,8 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args);
 void __printk_safe_enter(void);
 void __printk_safe_exit(void);
 
+bool printk_percpu_data_ready(void);
+
 #define printk_safe_enter_irqsave(flags)	\
 	do {					\
 		local_irq_save(flags);		\
@@ -64,4 +66,5 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
 #define printk_safe_enter_irq() local_irq_disable()
 #define printk_safe_exit_irq() local_irq_enable()
 
+bool printk_percpu_data_ready(void) { return false; }
 #endif /* CONFIG_PRINTK */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ad4606234545..d951d35a0786 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -461,6 +461,18 @@ static char __log_buf[__LOG_BUF_LEN] __aligned(LOG_ALIGN);
 static char *log_buf = __log_buf;
 static u32 log_buf_len = __LOG_BUF_LEN;
 
+/*
+ * We cannot access per-CPU data (e.g. per-CPU flush irq_work) before
+ * per_cpu_areas are initialised. This variable is set to true when
+ * it's safe to access per-CPU data.
+ */
+static bool __printk_percpu_data_ready __read_mostly;
+
+bool printk_percpu_data_ready(void)
+{
+	return __printk_percpu_data_ready;
+}
+
 /* Return log buffer address */
 char *log_buf_addr_get(void)
 {
@@ -1147,12 +1159,25 @@ static void __init log_buf_add_cpu(void)
 static inline void log_buf_add_cpu(void) {}
 #endif /* CONFIG_SMP */
 
+static void __init set_percpu_data_ready(void)
+{
+	__printk_percpu_data_ready = true;
+}
+
 void __init setup_log_buf(int early)
 {
 	unsigned long flags;
 	char *new_log_buf;
 	unsigned int free;
 
+	/*
+	 * Some archs call setup_log_buf() multiple times - first is very
+	 * early, e.g. from setup_arch(), and second - when percpu_areas
+	 * are initialised.
+	 */
+	if (!early)
+		set_percpu_data_ready();
+
 	if (log_buf != __log_buf)
 		return;
 
@@ -3009,6 +3034,9 @@ static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) = {
 
 void wake_up_klogd(void)
 {
+	if (!printk_percpu_data_ready())
+		return;
+
 	preempt_disable();
 	if (waitqueue_active(&log_wait)) {
 		this_cpu_or(printk_pending, PRINTK_PENDING_WAKEUP);
@@ -3019,6 +3047,9 @@ void wake_up_klogd(void)
 
 void defer_console_output(void)
 {
+	if (!printk_percpu_data_ready())
+		return;
+
 	preempt_disable();
 	__this_cpu_or(printk_pending, PRINTK_PENDING_OUTPUT);
 	irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index b4045e782743..d9a659a686f3 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -27,7 +27,6 @@
  * There are situations when we want to make sure that all buffers
  * were handled or when IRQs are blocked.
  */
-static int printk_safe_irq_ready __read_mostly;
 
 #define SAFE_LOG_BUF_LEN ((1 << CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT) -	\
 				sizeof(atomic_t) -			\
@@ -51,7 +50,7 @@ static DEFINE_PER_CPU(struct printk_safe_seq_buf, nmi_print_seq);
 /* Get flushed in a more safe context. */
 static void queue_flush_work(struct printk_safe_seq_buf *s)
 {
-	if (printk_safe_irq_ready)
+	if (printk_percpu_data_ready())
 		irq_work_queue(&s->work);
 }
 
@@ -402,14 +401,6 @@ void __init printk_safe_init(void)
 #endif
 	}
 
-	/*
-	 * In the highly unlikely event that a NMI were to trigger at
-	 * this moment. Make sure IRQ work is set up before this
-	 * variable is set.
-	 */
-	barrier();
-	printk_safe_irq_ready = 1;
-
 	/* Flush pending messages that did not have scheduled IRQ works. */
 	printk_safe_flush();
 }
-- 
2.25.1

