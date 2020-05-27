Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A989BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FB832145D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387681AbgE0IMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729387AbgE0IMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:12:06 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED66AC061A0F;
        Wed, 27 May 2020 01:12:05 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAS-0002gJ-Cs; Wed, 27 May 2020 10:12:04 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 87C481C03A9;
        Wed, 27 May 2020 10:12:00 +0200 (CEST)
Date:   Wed, 27 May 2020 08:12:00 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Provide idtentry_enter/exit_user()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202117.289548561@linutronix.de>
References: <20200521202117.289548561@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056712040.17951.6873299758021366290.tip-bot2@tip-bot2>
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

Commit-ID:     d4b1f51731fd10a836e46f54c96a8913d945735b
Gitweb:        https://git.kernel.org/tip/d4b1f51731fd10a836e46f54c96a8913d945735b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:18 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:27 +02:00

x86/entry: Provide idtentry_enter/exit_user()

As there are exceptions which already handle entry from user mode and from
kernel mode separately, providing explicit user entry/exit handling callbacks
makes sense and makes the code easier to understand.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200521202117.289548561@linutronix.de
---
 arch/x86/entry/common.c         | 31 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/idtentry.h |  3 +++
 2 files changed, 34 insertions(+)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index a7f5846..b7fcb13 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -658,3 +658,34 @@ void noinstr idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit)
 			rcu_irq_exit();
 	}
 }
+
+/**
+ * idtentry_enter_user - Handle state tracking on idtentry from user mode
+ * @regs:	Pointer to pt_regs of interrupted context
+ *
+ * Invokes enter_from_user_mode() to establish the proper context for
+ * NOHZ_FULL. Otherwise scheduling on exit would not be possible.
+ */
+void noinstr idtentry_enter_user(struct pt_regs *regs)
+{
+	enter_from_user_mode();
+}
+
+/**
+ * idtentry_exit_user - Handle return from exception to user mode
+ * @regs:	Pointer to pt_regs (exception entry regs)
+ *
+ * Runs the necessary preemption and work checks and returns to the caller
+ * with interrupts disabled and no further work pending.
+ *
+ * This is the last action before returning to the low level ASM code which
+ * just needs to return to the appropriate context.
+ *
+ * Counterpart to idtentry_enter_user().
+ */
+void noinstr idtentry_exit_user(struct pt_regs *regs)
+{
+	lockdep_assert_irqs_disabled();
+
+	prepare_exit_to_usermode(regs);
+}
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index a116b80..b3aca72 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -7,6 +7,9 @@
 
 #ifndef __ASSEMBLY__
 
+void idtentry_enter_user(struct pt_regs *regs);
+void idtentry_exit_user(struct pt_regs *regs);
+
 bool idtentry_enter_cond_rcu(struct pt_regs *regs, bool cond_rcu);
 void idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit);
 
