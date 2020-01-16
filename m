Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CECC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C593F2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgAPNzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:55:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51797 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgAPNzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:55:40 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1is5cP-0000FV-WE; Thu, 16 Jan 2020 14:55:30 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4CBAD1C086C;
        Thu, 16 Jan 2020 14:55:29 +0100 (CET)
Date:   Thu, 16 Jan 2020 13:55:29 -0000
From:   "tip-bot2 for Petr Mladek" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] watchdog/softlockup: Remove obsolete check of last
 reported task
Cc:     Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Ziljstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191024114928.15377-2-pmladek@suse.com>
References: <20191024114928.15377-2-pmladek@suse.com>
MIME-Version: 1.0
Message-ID: <157918292903.396.3828152178044862176.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/core branch of tip:

Commit-ID:     3a51449b7959f68cc45abe67298e40c7eb57167b
Gitweb:        https://git.kernel.org/tip/3a51449b7959f68cc45abe67298e40c7eb57167b
Author:        Petr Mladek <pmladek@suse.com>
AuthorDate:    Thu, 24 Oct 2019 13:49:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Jan 2020 14:52:48 +01:00

watchdog/softlockup: Remove obsolete check of last reported task

commit 9cf57731b63e ("watchdog/softlockup: Replace "watchdog/%u" threads
 with cpu_stop_work") ensures that the watchdog is reliably touched during
a task switch.

As a result the check for an unnoticed task switch is not longer needed.

Remove the relevant code, which effectively reverts commit b1a8de1f5343
("softlockup: make detector be aware of task switch of processes hogging
cpu")

Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Ziljstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20191024114928.15377-2-pmladek@suse.com
---
 kernel/watchdog.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 0621301..e3774e9 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -173,7 +173,6 @@ static DEFINE_PER_CPU(struct hrtimer, watchdog_hrtimer);
 static DEFINE_PER_CPU(bool, softlockup_touch_sync);
 static DEFINE_PER_CPU(bool, soft_watchdog_warn);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
-static DEFINE_PER_CPU(struct task_struct *, softlockup_task_ptr_saved);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
 static unsigned long soft_lockup_nmi_warn;
 
@@ -413,22 +412,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 			return HRTIMER_RESTART;
 
 		/* only warn once */
-		if (__this_cpu_read(soft_watchdog_warn) == true) {
-			/*
-			 * When multiple processes are causing softlockups the
-			 * softlockup detector only warns on the first one
-			 * because the code relies on a full quiet cycle to
-			 * re-arm.  The second process prevents the quiet cycle
-			 * and never gets reported.  Use task pointers to detect
-			 * this.
-			 */
-			if (__this_cpu_read(softlockup_task_ptr_saved) !=
-			    current) {
-				__this_cpu_write(soft_watchdog_warn, false);
-				__touch_watchdog();
-			}
+		if (__this_cpu_read(soft_watchdog_warn) == true)
 			return HRTIMER_RESTART;
-		}
 
 		if (softlockup_all_cpu_backtrace) {
 			/* Prevent multiple soft-lockup reports if one cpu is already
@@ -444,7 +429,6 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
 			smp_processor_id(), duration,
 			current->comm, task_pid_nr(current));
-		__this_cpu_write(softlockup_task_ptr_saved, current);
 		print_modules();
 		print_irqtrace_events(current);
 		if (regs)
