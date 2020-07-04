Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFB9C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 17:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC11208D5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 17:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t1tVFuSB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rOIvm74o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgGDRtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 13:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgGDRtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 13:49:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1293FC061794;
        Sat,  4 Jul 2020 10:49:13 -0700 (PDT)
Date:   Sat, 04 Jul 2020 17:49:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593884951;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YiJkfElGbiktGfP9nsOuXtJinSzKctc1/SFc3OqpmmE=;
        b=t1tVFuSB0XzeV7+7cUfLokRVNCWvV36s5YK8MftKQz9fnZAg5qYFKHrncEBBa+EBLv1w4G
        mZppMP0SmVpFkyq/CocZ+fSrcPhq4QWT+gM2JB6FCd8ldz//PgrS9vNkgXLFsEekgvtHwF
        eHTeSy+xnwvHc67PvHhvtBWaTHZWky6ezLJyvsMhVhdCfv/2+aDuYNQJj0gPDzoUQtqCpa
        51PgZqggCjQ+zdASl7LlPoTeRig/7avpmlWfcRy9i7TB58W2Lg838RmLzYhF12izYPpkxJ
        p8uEDDDzRqs1NwhflqgdNEDEGnibt+c05NnG3++Huh98j09tDD7pgFy7oSnHLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593884951;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YiJkfElGbiktGfP9nsOuXtJinSzKctc1/SFc3OqpmmE=;
        b=rOIvm74oFJTdARBjkRkzD7j5N0hQbKeDrpS2CHhtKPdeaX1+JZo/62NJ5YsJOlhkso4fDe
        HrXnthzpT1+2JvCg==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry/compat: Clear RAX high bits on Xen PV SYSENTER
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <9d33b3f3216dcab008070f1c28b6091ae7199969.1593795633.git.luto@kernel.org>
References: <9d33b3f3216dcab008070f1c28b6091ae7199969.1593795633.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <159388495100.4006.13667292237270136663.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     db5b2c5a90a111618f071d231a8b945cf522313e
Gitweb:        https://git.kernel.org/tip/db5b2c5a90a111618f071d231a8b945cf522313e
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Fri, 03 Jul 2020 10:02:53 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 04 Jul 2020 19:47:25 +02:00

x86/entry/compat: Clear RAX high bits on Xen PV SYSENTER

Move the clearing of the high bits of RAX after Xen PV joins the SYSENTER
path so that Xen PV doesn't skip it.

Arguably this code should be deleted instead, but that would belong in the
merge window.

Fixes: ffae641f5747 ("x86/entry/64/compat: Fix Xen PV SYSENTER frame setup")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/9d33b3f3216dcab008070f1c28b6091ae7199969.1593795633.git.luto@kernel.org

---
 arch/x86/entry/entry_64_compat.S | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 381a6de..541fdaf 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -57,15 +57,6 @@ SYM_CODE_START(entry_SYSENTER_compat)
 
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
-	/*
-	 * User tracing code (ptrace or signal handlers) might assume that
-	 * the saved RAX contains a 32-bit number when we're invoking a 32-bit
-	 * syscall.  Just in case the high bits are nonzero, zero-extend
-	 * the syscall number.  (This could almost certainly be deleted
-	 * with no ill effects.)
-	 */
-	movl	%eax, %eax
-
 	/* Construct struct pt_regs on stack */
 	pushq	$__USER32_DS		/* pt_regs->ss */
 	pushq	$0			/* pt_regs->sp = 0 (placeholder) */
@@ -80,6 +71,16 @@ SYM_CODE_START(entry_SYSENTER_compat)
 	pushq	$__USER32_CS		/* pt_regs->cs */
 	pushq	$0			/* pt_regs->ip = 0 (placeholder) */
 SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
+
+	/*
+	 * User tracing code (ptrace or signal handlers) might assume that
+	 * the saved RAX contains a 32-bit number when we're invoking a 32-bit
+	 * syscall.  Just in case the high bits are nonzero, zero-extend
+	 * the syscall number.  (This could almost certainly be deleted
+	 * with no ill effects.)
+	 */
+	movl	%eax, %eax
+
 	pushq	%rax			/* pt_regs->orig_ax */
 	pushq	%rdi			/* pt_regs->di */
 	pushq	%rsi			/* pt_regs->si */
