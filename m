Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3214C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C286A206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgFBLlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgFBLlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:41:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9299C061A0E;
        Tue,  2 Jun 2020 04:41:07 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jg5Hr-00049A-J1; Tue, 02 Jun 2020 13:40:55 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2D2431C0475;
        Tue,  2 Jun 2020 13:40:55 +0200 (CEST)
Date:   Tue, 02 Jun 2020 11:40:55 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] irq_work: Define irq_work_single() on !CONFIG_IRQ_WORK too
Cc:     kbuild test robot <lkp@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86 <x86@kernel.org>
MIME-Version: 1.0
Message-ID: <159109805502.17951.3309823805480161693.tip-bot2@tip-bot2>
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

Commit-ID:     25de110d148666752dc0e0da7a0b69de31cd7098
Gitweb:        https://git.kernel.org/tip/25de110d148666752dc0e0da7a0b69de31cd7098
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 02 Jun 2020 12:08:39 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 02 Jun 2020 12:34:45 +02:00

irq_work: Define irq_work_single() on !CONFIG_IRQ_WORK too

Some SMP platforms don't have CONFIG_IRQ_WORK defined, resulting in a link
error at build time.

Define a stub and clean up the prototype definitions.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/irq_work.h | 2 ++
 kernel/smp.c             | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index f23a359..2735da5 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -58,9 +58,11 @@ void irq_work_sync(struct irq_work *work);
 
 void irq_work_run(void);
 bool irq_work_needs_cpu(void);
+void irq_work_single(void *arg);
 #else
 static inline bool irq_work_needs_cpu(void) { return false; }
 static inline void irq_work_run(void) { }
+static inline void irq_work_single(void *arg) { }
 #endif
 
 #endif /* _LINUX_IRQ_WORK_H */
diff --git a/kernel/smp.c b/kernel/smp.c
index 4dec04f..c80486a 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -194,8 +194,6 @@ void generic_smp_call_function_single_interrupt(void)
 	flush_smp_call_function_queue(true);
 }
 
-extern void irq_work_single(void *);
-
 /**
  * flush_smp_call_function_queue - Flush pending smp-call-function callbacks
  *
