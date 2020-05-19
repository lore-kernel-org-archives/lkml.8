Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D544FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A95A820872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgEST7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgEST7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:59:10 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AFFC08C5C2;
        Tue, 19 May 2020 12:59:10 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8OH-0000HV-5t; Tue, 19 May 2020 21:59:05 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3D9E81C047E;
        Tue, 19 May 2020 21:58:50 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:50 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/doublefault: Remove memmove() call
Cc:     Borislav Petkov <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134058.863038566@linutronix.de>
References: <20200505134058.863038566@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991833013.17951.13456353153440993898.tip-bot2@tip-bot2>
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

Commit-ID:     f44e70325748c7998cf089d2ae67b4b5bc8d8ad9
Gitweb:        https://git.kernel.org/tip/f44e70325748c7998cf089d2ae67b4b5bc8d8ad9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 20 Feb 2020 13:17:27 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 15 May 2020 20:03:04 +02:00

x86/doublefault: Remove memmove() call

Use of memmove() in #DF is problematic considered tracing and other
instrumentation.

Remove the memmove() call and simply write out what needs doing; this
even clarifies the code, win-win! The code copies from the espfix64
stack to the normal task stack, there is no possible way for that to
overlap.

Survives selftests/x86, specifically sigreturn_64.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505134058.863038566@linutronix.de

---
 arch/x86/kernel/traps.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index e85561f..75fa765 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -369,6 +369,7 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsign
 		regs->ip == (unsigned long)native_irq_return_iret)
 	{
 		struct pt_regs *gpregs = (struct pt_regs *)this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
+		unsigned long *p = (unsigned long *)regs->sp;
 
 		/*
 		 * regs->sp points to the failing IRET frame on the
@@ -376,7 +377,11 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsign
 		 * in gpregs->ss through gpregs->ip.
 		 *
 		 */
-		memmove(&gpregs->ip, (void *)regs->sp, 5*8);
+		gpregs->ip	= p[0];
+		gpregs->cs	= p[1];
+		gpregs->flags	= p[2];
+		gpregs->sp	= p[3];
+		gpregs->ss	= p[4];
 		gpregs->orig_ax = 0;  /* Missing (lost) #GP error code */
 
 		/*
