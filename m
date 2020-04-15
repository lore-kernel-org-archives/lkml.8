Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB7BC2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F23120775
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895970AbgDOJvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895900AbgDOJuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:50:01 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAF6C061A0C;
        Wed, 15 Apr 2020 02:50:01 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOefz-0005rO-1R; Wed, 15 Apr 2020 11:49:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7ACFF1C0081;
        Wed, 15 Apr 2020 11:49:46 +0200 (CEST)
Date:   Wed, 15 Apr 2020 09:49:46 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Fixup exception only for the correct MCEs
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200407163414.18058-10-bp@alien8.de>
References: <20200407163414.18058-10-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <158694418608.28353.4166689107383983190.tip-bot2@tip-bot2>
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

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     1df73b2131e3b33d518609769636b41ce00212de
Gitweb:        https://git.kernel.org/tip/1df73b2131e3b33d518609769636b41ce00212de
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 07 Apr 2020 13:49:58 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Apr 2020 16:01:49 +02:00

x86/mce: Fixup exception only for the correct MCEs

The severity grading code returns IN_KERNEL_RECOV error context for
errors which have happened in kernel space but from which the kernel can
recover. Whether the recovery can happen is determined by the exception
table entry having as handler ex_handler_fault() and which has been
declared at build time using _ASM_EXTABLE_FAULT().

IN_KERNEL_RECOV is used in mce_severity_intel() to lookup the
corresponding error severity in the severities table.

However, the mapping back from error severity to whether the error is
IN_KERNEL_RECOV is ambiguous and in the very paranoid case - which
might not be possible right now - but be better safe than sorry later,
an exception fixup could be attempted for another MCE whose address
is in the exception table and has the proper severity. Which would be
unfortunate, to say the least.

Therefore, mark such MCEs explicitly as MCE_IN_KERNEL_RECOV so that the
recovery attempt is done only for them.

Document the whole handling, while at it, as it is not trivial.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20200407163414.18058-10-bp@alien8.de
---
 arch/x86/include/asm/mce.h         |  1 +
 arch/x86/kernel/cpu/mce/core.c     | 15 +++++++++++++--
 arch/x86/kernel/cpu/mce/severity.c |  6 +++++-
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 5f04a24..c598aaa 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -136,6 +136,7 @@
 #define	MCE_HANDLED_NFIT	BIT_ULL(3)
 #define	MCE_HANDLED_EDAC	BIT_ULL(4)
 #define	MCE_HANDLED_MCELOG	BIT_ULL(5)
+#define MCE_IN_KERNEL_RECOV	BIT_ULL(6)
 
 /*
  * This structure contains all data related to the MCE log.  Also
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4efe6c1..02e1f16 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1331,8 +1331,19 @@ void notrace do_machine_check(struct pt_regs *regs, long error_code)
 		local_irq_disable();
 		ist_end_non_atomic();
 	} else {
-		if (!fixup_exception(regs, X86_TRAP_MC, error_code, 0))
-			mce_panic("Failed kernel mode recovery", &m, msg);
+		/*
+		 * Handle an MCE which has happened in kernel space but from
+		 * which the kernel can recover: ex_has_fault_handler() has
+		 * already verified that the rIP at which the error happened is
+		 * a rIP from which the kernel can recover (by jumping to
+		 * recovery code specified in _ASM_EXTABLE_FAULT()) and the
+		 * corresponding exception handler which would do that is the
+		 * proper one.
+		 */
+		if (m.kflags & MCE_IN_KERNEL_RECOV) {
+			if (!fixup_exception(regs, X86_TRAP_MC, error_code, 0))
+				mce_panic("Failed kernel mode recovery", &m, msg);
+		}
 	}
 
 out_ist:
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 87bcdc6..e1da619 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -213,8 +213,12 @@ static int error_context(struct mce *m)
 {
 	if ((m->cs & 3) == 3)
 		return IN_USER;
-	if (mc_recoverable(m->mcgstatus) && ex_has_fault_handler(m->ip))
+
+	if (mc_recoverable(m->mcgstatus) && ex_has_fault_handler(m->ip)) {
+		m->kflags |= MCE_IN_KERNEL_RECOV;
 		return IN_KERNEL_RECOV;
+	}
+
 	return IN_KERNEL;
 }
 
