Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71034C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F65920776
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgCUPan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:30:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38871 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgCUPae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:30:34 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFg50-0004wI-Rb; Sat, 21 Mar 2020 16:30:30 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 53D841C22E5;
        Sat, 21 Mar 2020 16:30:30 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:30:30 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] lockdep: Rename trace_softirqs_{on,off}()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320115859.119434738@infradead.org>
References: <20200320115859.119434738@infradead.org>
MIME-Version: 1.0
Message-ID: <158480463002.28353.16464317745293998156.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     0d38453c85b426e47375346812d2271680c47988
Gitweb:        https://git.kernel.org/tip/0d38453c85b426e47375346812d2271680c47988
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 20 Mar 2020 12:56:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 16:03:54 +01:00

lockdep: Rename trace_softirqs_{on,off}()

Continue what commit:

  d820ac4c2fa8 ("locking: rename trace_softirq_[enter|exit] => lockdep_softirq_[enter|exit]")

started, rename these to avoid confusing them with tracepoints.

git grep -l "trace_softirqs_\(on\|off\)" | while read file;
do
	sed -ie 's/trace_softirqs_\(on\|off\)/lockdep_softirqs_\1/g' $file;
done

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/r/20200320115859.119434738@infradead.org

---
 include/linux/irqflags.h | 10 +++++-----
 kernel/locking/lockdep.c |  4 ++--
 kernel/softirq.c         |  6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 7c4e645..7ca1f21 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -15,15 +15,15 @@
 #include <linux/typecheck.h>
 #include <asm/irqflags.h>
 
-/* Currently trace_softirqs_on/off is used only by lockdep */
+/* Currently lockdep_softirqs_on/off is used only by lockdep */
 #ifdef CONFIG_PROVE_LOCKING
-  extern void trace_softirqs_on(unsigned long ip);
-  extern void trace_softirqs_off(unsigned long ip);
+  extern void lockdep_softirqs_on(unsigned long ip);
+  extern void lockdep_softirqs_off(unsigned long ip);
   extern void lockdep_hardirqs_on(unsigned long ip);
   extern void lockdep_hardirqs_off(unsigned long ip);
 #else
-  static inline void trace_softirqs_on(unsigned long ip) { }
-  static inline void trace_softirqs_off(unsigned long ip) { }
+  static inline void lockdep_softirqs_on(unsigned long ip) { }
+  static inline void lockdep_softirqs_off(unsigned long ip) { }
   static inline void lockdep_hardirqs_on(unsigned long ip) { }
   static inline void lockdep_hardirqs_off(unsigned long ip) { }
 #endif
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 32406ef..26ef412 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3468,7 +3468,7 @@ NOKPROBE_SYMBOL(lockdep_hardirqs_off);
 /*
  * Softirqs will be enabled:
  */
-void trace_softirqs_on(unsigned long ip)
+void lockdep_softirqs_on(unsigned long ip)
 {
 	struct task_struct *curr = current;
 
@@ -3508,7 +3508,7 @@ void trace_softirqs_on(unsigned long ip)
 /*
  * Softirqs were disabled:
  */
-void trace_softirqs_off(unsigned long ip)
+void lockdep_softirqs_off(unsigned long ip)
 {
 	struct task_struct *curr = current;
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index b328689..0112ca0 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -126,7 +126,7 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 	 * Were softirqs turned off above:
 	 */
 	if (softirq_count() == (cnt & SOFTIRQ_MASK))
-		trace_softirqs_off(ip);
+		lockdep_softirqs_off(ip);
 	raw_local_irq_restore(flags);
 
 	if (preempt_count() == cnt) {
@@ -147,7 +147,7 @@ static void __local_bh_enable(unsigned int cnt)
 		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 
 	if (softirq_count() == (cnt & SOFTIRQ_MASK))
-		trace_softirqs_on(_RET_IP_);
+		lockdep_softirqs_on(_RET_IP_);
 
 	__preempt_count_sub(cnt);
 }
@@ -174,7 +174,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	 * Are softirqs going to be turned on now:
 	 */
 	if (softirq_count() == SOFTIRQ_DISABLE_OFFSET)
-		trace_softirqs_on(ip);
+		lockdep_softirqs_on(ip);
 	/*
 	 * Keep preemption disabled until we are done with
 	 * softirq processing:
