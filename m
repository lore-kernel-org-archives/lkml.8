Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97452C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C86E21531
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387821AbgE0IMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729571AbgE0IMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:12:07 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30091C03E97A;
        Wed, 27 May 2020 01:12:07 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAT-0002hA-E3; Wed, 27 May 2020 10:12:05 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 737AF1C0833;
        Wed, 27 May 2020 10:12:01 +0200 (CEST)
Date:   Wed, 27 May 2020 08:12:01 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] nmi, tracing: Make hardware latency tracing noinstr safe
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202116.904176298@linutronix.de>
References: <20200521202116.904176298@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056712130.17951.10124412775142065203.tip-bot2@tip-bot2>
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

Commit-ID:     1e826b1d2265d1e8ba5f51827a8dba2aa0295f6c
Gitweb:        https://git.kernel.org/tip/1e826b1d2265d1e8ba5f51827a8dba2aa0295f6c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:14 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:27 +02:00

nmi, tracing: Make hardware latency tracing noinstr safe

The hardware latency tracer calls into instrumentable functions. Move the
calls into the RCU watching sections and annotate them.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20200521202116.904176298@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/hardirq.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index e07cf85..29b862a 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -87,20 +87,24 @@ extern void rcu_nmi_exit(void);
 		arch_nmi_enter();				\
 		printk_nmi_enter();				\
 		lockdep_off();					\
-		ftrace_nmi_enter();				\
 		BUG_ON(in_nmi() == NMI_MASK);			\
 		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
 		rcu_nmi_enter();				\
 		lockdep_hardirq_enter();			\
+		instrumentation_begin();			\
+		ftrace_nmi_enter();				\
+		instrumentation_end();				\
 	} while (0)
 
 #define nmi_exit()						\
 	do {							\
+		instrumentation_begin();			\
+		ftrace_nmi_exit();				\
+		instrumentation_end();				\
 		lockdep_hardirq_exit();				\
 		rcu_nmi_exit();					\
 		BUG_ON(!in_nmi());				\
 		__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
-		ftrace_nmi_exit();				\
 		lockdep_on();					\
 		printk_nmi_exit();				\
 		arch_nmi_exit();				\
