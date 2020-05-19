Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F344DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C78A620849
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgEST6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgEST6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:24 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600DEC08C5C0;
        Tue, 19 May 2020 12:58:24 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8NX-00088i-8Q; Tue, 19 May 2020 21:58:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C86141C047E;
        Tue, 19 May 2020 21:58:18 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:18 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/traps: Address objtool noinstr complaints in #DB
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505135315.380927730@linutronix.de>
References: <20200505135315.380927730@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991829872.17951.14197480828804200628.tip-bot2@tip-bot2>
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

Commit-ID:     467a8425d10508886eb5bcc0b80e0c73da4751c4
Gitweb:        https://git.kernel.org/tip/467a8425d10508886eb5bcc0b80e0c73da4751c4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 30 Apr 2020 11:07:20 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:13 +02:00

x86/traps: Address objtool noinstr complaints in #DB

The functions invoked from handle_debug() can be instrumented. Tell objtool
about it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505135315.380927730@linutronix.de


---
 arch/x86/kernel/traps.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index b62e962..41bb0cb 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -784,14 +784,19 @@ static void noinstr handle_debug(struct pt_regs *regs, unsigned long dr6,
 	/* Store the virtualized DR6 value */
 	tsk->thread.debugreg6 = dr6;
 
+	instrumentation_begin();
 #ifdef CONFIG_KPROBES
-	if (kprobe_debug_handler(regs))
+	if (kprobe_debug_handler(regs)) {
+		instrumentation_end();
 		return;
+	}
 #endif
 
 	if (notify_die(DIE_DEBUG, "debug", regs, (long)&dr6, 0,
-		       SIGTRAP) == NOTIFY_STOP)
+		       SIGTRAP) == NOTIFY_STOP) {
+		instrumentation_end();
 		return;
+	}
 
 	/*
 	 * Let others (NMI) know that the debug stack is in use
@@ -827,6 +832,7 @@ static void noinstr handle_debug(struct pt_regs *regs, unsigned long dr6,
 out:
 	cond_local_irq_disable(regs);
 	debug_stack_usage_dec();
+	instrumentation_end();
 }
 
 static __always_inline void exc_debug_kernel(struct pt_regs *regs,
