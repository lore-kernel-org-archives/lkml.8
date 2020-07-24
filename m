Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96646C433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 711532070E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zEFRqOM/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B4rDe8bl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGXULx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgGXULq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:11:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1150FC0619D3;
        Fri, 24 Jul 2020 13:11:46 -0700 (PDT)
Date:   Fri, 24 Jul 2020 20:11:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595621504;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z150dKpBqAjDmluNwFwDPx+9ho6AAnp0vEZHmBCE3Ck=;
        b=zEFRqOM/HCdK2ifuEfE7k9fEC50fK2Q9/0Xmr7haIp4RZkCPyL/RgkkGBqqHcOAg/ludRg
        7esCTSPI+4ZTpnWpwkGM0KUERU+aST98LAnqOEK0SUTqqYIHPX07NsaD8iGm6VbWwOJyX7
        63Gs3NgsMyHiaBvEJ53mmtMIxKfn9cOys/98p373wpn0TSIDDicVh4zsxI7yzJ5hLcfHKo
        Zfm+9/oJGkjv92rf4a98oyJOuVIy+GX2xN0HoaeNFkbAKSAVR+zHwd/JlRiSK+qrRY0G0K
        6MEcuXnhgzW2VXhFWfg7qTESb6ihoRQp1Tf/C9zwTWdt8olPPj8ijKk5UjfADg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595621504;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z150dKpBqAjDmluNwFwDPx+9ho6AAnp0vEZHmBCE3Ck=;
        b=B4rDe8blpz6JoxAqoKtqFV+Oix4UzHJclhNHrjyvYdbirSdZfTmGOTPjtu+RvZLvbmwiTL
        6kwBCYyFcvN/8KBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Consolidate check_user_regs()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200722220519.943016204@linutronix.de>
References: <20200722220519.943016204@linutronix.de>
MIME-Version: 1.0
Message-ID: <159562150324.4006.3990914186367201441.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     8d5ea35c5e9139dbd19a3d73985d008d36c9968f
Gitweb:        https://git.kernel.org/tip/8d5ea35c5e9139dbd19a3d73985d008d36c9968f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 23 Jul 2020 00:00:00 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Jul 2020 15:04:57 +02:00

x86/entry: Consolidate check_user_regs()

The user register sanity check is sprinkled all over the place. Move it
into enter_from_user_mode().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200722220519.943016204@linutronix.de


---
 arch/x86/entry/common.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 4eae4c1..ab6cb86 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -82,10 +82,11 @@ static noinstr void check_user_regs(struct pt_regs *regs)
  * 2) Invoke context tracking if enabled to reactivate RCU
  * 3) Trace interrupts off state
  */
-static noinstr void enter_from_user_mode(void)
+static noinstr void enter_from_user_mode(struct pt_regs *regs)
 {
 	enum ctx_state state = ct_state();
 
+	check_user_regs(regs);
 	lockdep_hardirqs_off(CALLER_ADDR0);
 	user_exit_irqoff();
 
@@ -95,8 +96,9 @@ static noinstr void enter_from_user_mode(void)
 	instrumentation_end();
 }
 #else
-static __always_inline void enter_from_user_mode(void)
+static __always_inline void enter_from_user_mode(struct pt_regs *regs)
 {
+	check_user_regs(regs);
 	lockdep_hardirqs_off(CALLER_ADDR0);
 	instrumentation_begin();
 	trace_hardirqs_off_finish();
@@ -369,9 +371,7 @@ __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
 	struct thread_info *ti;
 
-	check_user_regs(regs);
-
-	enter_from_user_mode();
+	enter_from_user_mode(regs);
 	instrumentation_begin();
 
 	local_irq_enable();
@@ -434,9 +434,7 @@ static void do_syscall_32_irqs_on(struct pt_regs *regs)
 /* Handles int $0x80 */
 __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 {
-	check_user_regs(regs);
-
-	enter_from_user_mode();
+	enter_from_user_mode(regs);
 	instrumentation_begin();
 
 	local_irq_enable();
@@ -487,8 +485,6 @@ __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 					vdso_image_32.sym_int80_landing_pad;
 	bool success;
 
-	check_user_regs(regs);
-
 	/*
 	 * SYSENTER loses EIP, and even SYSCALL32 needs us to skip forward
 	 * so that 'regs->ip -= 2' lands back on an int $0x80 instruction.
@@ -496,7 +492,7 @@ __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 	 */
 	regs->ip = landing_pad;
 
-	enter_from_user_mode();
+	enter_from_user_mode(regs);
 	instrumentation_begin();
 
 	local_irq_enable();
@@ -599,8 +595,7 @@ idtentry_state_t noinstr idtentry_enter(struct pt_regs *regs)
 	};
 
 	if (user_mode(regs)) {
-		check_user_regs(regs);
-		enter_from_user_mode();
+		enter_from_user_mode(regs);
 		return ret;
 	}
 
@@ -733,8 +728,7 @@ void noinstr idtentry_exit(struct pt_regs *regs, idtentry_state_t state)
  */
 void noinstr idtentry_enter_user(struct pt_regs *regs)
 {
-	check_user_regs(regs);
-	enter_from_user_mode();
+	enter_from_user_mode(regs);
 }
 
 /**
