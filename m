Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F412C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A306207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgESTwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgESTwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:52:40 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D212C08C5C1;
        Tue, 19 May 2020 12:52:40 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Hw-0007p6-8j; Tue, 19 May 2020 21:52:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BEB811C0178;
        Tue, 19 May 2020 21:52:31 +0200 (CEST)
Date:   Tue, 19 May 2020 19:52:31 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Provide __rcu_is_watching()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200512213810.518709291@linutronix.de>
References: <20200512213810.518709291@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991795162.17951.17450818248144000977.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b1fcf9b83c4149c63d1e0c699e85f93cbe28e211
Gitweb:        https://git.kernel.org/tip/b1fcf9b83c4149c63d1e0c699e85f93cbe28e211
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 12 May 2020 09:44:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 15:51:21 +02:00

rcu: Provide __rcu_is_watching()

Same as rcu_is_watching() but without the preempt_disable/enable() pair
inside the function. It is merked noinstr so it ends up in the
non-instrumentable text section.

This is useful for non-preemptible code especially in the low level entry
section. Using rcu_is_watching() there results in a call to the
preempt_schedule_notrace() thunk which triggers noinstr section warnings in
objtool.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200512213810.518709291@linutronix.de

---
 include/linux/rcutiny.h | 1 +
 include/linux/rcutree.h | 1 +
 kernel/rcu/tree.c       | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 980eb78..c869fb2 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -86,6 +86,7 @@ static inline void rcu_scheduler_starting(void) { }
 static inline void rcu_end_inkernel_boot(void) { }
 static inline bool rcu_inkernel_boot_has_ended(void) { return true; }
 static inline bool rcu_is_watching(void) { return true; }
+static inline bool __rcu_is_watching(void) { return true; }
 static inline void rcu_momentary_dyntick_idle(void) { }
 static inline void kfree_rcu_scheduler_running(void) { }
 static inline bool rcu_gp_might_be_stalled(void) { return false; }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 02016e0..9366fa4 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -58,6 +58,7 @@ extern int rcu_scheduler_active __read_mostly;
 void rcu_end_inkernel_boot(void);
 bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
+bool __rcu_is_watching(void);
 #ifndef CONFIG_PREEMPTION
 void rcu_all_qs(void);
 #endif
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 62ee012..90c8be2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -985,6 +985,11 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
 	}
 }
 
+noinstr bool __rcu_is_watching(void)
+{
+	return !rcu_dynticks_curr_cpu_in_eqs();
+}
+
 /**
  * rcu_is_watching - see if RCU thinks that the current CPU is not idle
  *
