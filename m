Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39F3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2953206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgFAJwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFAJwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:52:20 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629FDC03E96F;
        Mon,  1 Jun 2020 02:52:20 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jfh7C-0003eF-Ox; Mon, 01 Jun 2020 11:52:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 34C321C0244;
        Mon,  1 Jun 2020 11:52:18 +0200 (CEST)
Date:   Mon, 01 Jun 2020 09:52:18 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Split out open-coded prototypes into
 kernel/sched/smp.h
Cc:     Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159100513800.17951.18103491836045415816.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1f8db4150536431b031585ecc2a6793f69245de2
Gitweb:        https://git.kernel.org/tip/1f8db4150536431b031585ecc2a6793f69245de2
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 28 May 2020 11:01:34 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 May 2020 11:03:20 +02:00

sched/headers: Split out open-coded prototypes into kernel/sched/smp.h

Move the prototypes for sched_ttwu_pending() and send_call_function_single_ipi()
into the newly created kernel/sched/smp.h header, to make sure they are all
the same, and to architectures happy that use -Wmissing-prototypes.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c |  1 +
 kernel/sched/smp.h  |  9 +++++++++
 kernel/smp.c        |  5 +----
 3 files changed, 11 insertions(+), 4 deletions(-)
 create mode 100644 kernel/sched/smp.h

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b3c64c6..43ba2d4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -20,6 +20,7 @@
 #include "../smpboot.h"
 
 #include "pelt.h"
+#include "smp.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/sched.h>
diff --git a/kernel/sched/smp.h b/kernel/sched/smp.h
new file mode 100644
index 0000000..9620e32
--- /dev/null
+++ b/kernel/sched/smp.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Scheduler internal SMP callback types and methods between the scheduler
+ * and other internal parts of the core kernel:
+ */
+
+extern void sched_ttwu_pending(void *arg);
+
+extern void send_call_function_single_ipi(int cpu);
diff --git a/kernel/smp.c b/kernel/smp.c
index 0d61dc0..4dec04f 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -22,7 +22,7 @@
 #include <linux/hypervisor.h>
 
 #include "smpboot.h"
-
+#include "sched/smp.h"
 
 #define CSD_TYPE(_csd)	((_csd)->flags & CSD_FLAG_TYPE_MASK)
 
@@ -133,8 +133,6 @@ static __always_inline void csd_unlock(call_single_data_t *csd)
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
 
-extern void send_call_function_single_ipi(int cpu);
-
 void __smp_call_single_queue(int cpu, struct llist_node *node)
 {
 	/*
@@ -196,7 +194,6 @@ void generic_smp_call_function_single_interrupt(void)
 	flush_smp_call_function_queue(true);
 }
 
-extern void sched_ttwu_pending(void *);
 extern void irq_work_single(void *);
 
 /**
