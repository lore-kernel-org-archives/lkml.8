Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE95EC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59282214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="tEB6hgo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgBJJtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 04:49:02 -0500
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:40806 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727429AbgBJJtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:49:02 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 142872E14CF;
        Mon, 10 Feb 2020 12:48:59 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id EXKRWkEGQ8-mwSGRORj;
        Mon, 10 Feb 2020 12:48:58 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1581328139; bh=nlEiTmRWnBMnIBquBPmSwQ+RDrKamX9+LCClKFUVVcw=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=tEB6hgo2YoQSSy6OpOYUXCxHaZyC9ApDEOviF12YMejP4X5IjByureM+60Mu9eFDE
         JUuF6Jph0OJKpMKwHWjyMQwIAdIzhz3hbl3pXooXFM9BZBd2vLd78uzgfOu/37Oen0
         dObjzvj7CPK33HvrBi2fHmPL1sKcYCa2QThF/zoY=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8448:fbcc:1dac:c863])
        by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 81C7F7JaUU-mvWKmi8C;
        Mon, 10 Feb 2020 12:48:57 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] kernel/watchdog: flush all printk nmi buffers when
 hardlockup detected
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Date:   Mon, 10 Feb 2020 12:48:57 +0300
Message-ID: <158132813726.1980.17382047082627699898.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In NMI context printk() could save messages into per-cpu buffers and
schedule flush by irq_work when IRQ are unblocked. This means message
about hardlockup appears in kernel log only when/if lockup is gone.

Comment in irq_work_queue_on() states that remote IPI aren't NMI safe
thus printk() cannot schedule flush work to another cpu.

This patch adds simple atomic counter of detected hardlockups and
flushes all per-cpu printk buffers in context softlockup watchdog
at any other cpu when it sees changes of this counter.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 include/linux/nmi.h   |    1 +
 kernel/watchdog.c     |   22 ++++++++++++++++++++++
 kernel/watchdog_hld.c |    1 +
 3 files changed, 24 insertions(+)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 9003e29cde46..8406df72ae5a 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -84,6 +84,7 @@ static inline void reset_hung_task_detector(void) { }
 #if defined(CONFIG_HARDLOCKUP_DETECTOR)
 extern void hardlockup_detector_disable(void);
 extern unsigned int hardlockup_panic;
+extern atomic_t hardlockup_detected;
 #else
 static inline void hardlockup_detector_disable(void) {}
 #endif
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index b6b1f54a7837..9f5c68fababe 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -92,6 +92,26 @@ static int __init hardlockup_all_cpu_backtrace_setup(char *str)
 }
 __setup("hardlockup_all_cpu_backtrace=", hardlockup_all_cpu_backtrace_setup);
 # endif /* CONFIG_SMP */
+
+atomic_t hardlockup_detected = ATOMIC_INIT(0);
+
+static inline void flush_hardlockup_messages(void)
+{
+	static atomic_t flushed = ATOMIC_INIT(0);
+
+	/* flush messages from hard lockup detector */
+	if (atomic_read(&hardlockup_detected) != atomic_read(&flushed)) {
+		atomic_set(&flushed, atomic_read(&hardlockup_detected));
+		printk_safe_flush();
+	}
+}
+
+#else /* CONFIG_HARDLOCKUP_DETECTOR */
+
+static inline void flush_hardlockup_messages(void)
+{
+}
+
 #endif /* CONFIG_HARDLOCKUP_DETECTOR */
 
 /*
@@ -370,6 +390,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	/* kick the hardlockup detector */
 	watchdog_interrupt_count();
 
+	flush_hardlockup_messages();
+
 	/* kick the softlockup detector */
 	if (completion_done(this_cpu_ptr(&softlockup_completion))) {
 		reinit_completion(this_cpu_ptr(&softlockup_completion));
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582c..a546bc54f6ff 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -154,6 +154,7 @@ static void watchdog_overflow_callback(struct perf_event *event,
 
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");
+		atomic_inc(&hardlockup_detected);
 
 		__this_cpu_write(hard_watchdog_warn, true);
 		return;

