Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE844C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88ED12078E
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pWVTUby8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rCGQDit2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgIDNTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbgIDNQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:16:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17DAC06124F;
        Fri,  4 Sep 2020 06:16:16 -0700 (PDT)
Date:   Fri, 04 Sep 2020 13:16:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599225370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UY1p6yq3ZDUmy1qcbaqGZSl9bMNQDfJH0GtbEeYpc8E=;
        b=pWVTUby8hgsCzHYcR3rDktbq6BzC4rRwtHfklMuQA60hCJIRTWAANZifKtrUWBURUQF7mh
        4AgT6FZqP4Z7V6B8Vk5MvujwtZGbMIgYzwUbebyv9+hUZ1WC7J9Nlky8kVm6S9JliHl+pf
        JnkZkbSYJktEtNslGIe9hF1uguN4TCJt85LLoUNuWkZHaw6+EoRhkUlmzWi4kzwtdrKYQX
        j90BUQ+Wyr0+d5gTHsxpTW0/e0KG9LVMFmz5R7HjqbWyV4T+c/2YDWWdbfp5IP5CXfMsjS
        wPp0CpYk1UAHMjSH01W0X7aTDpHgNQ4WVKpcZOQ576a4fbsx2Dy8fDKIVOMtrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599225370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UY1p6yq3ZDUmy1qcbaqGZSl9bMNQDfJH0GtbEeYpc8E=;
        b=rCGQDit2A9dNAq21vwFJzy6Emt9CBfLB2o4Q3cVA1pFbOjJFXafnmva9wjcrKMnIqstCXB
        eK7e+xyzXyiwZ3AQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/debug: Remove handle_debug(.user) argument
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200902133200.907020598@infradead.org>
References: <20200902133200.907020598@infradead.org>
MIME-Version: 1.0
Message-ID: <159922536990.20229.9758250207614521377.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     7043679a989af969e9f20cc7d90195b36f54036f
Gitweb:        https://git.kernel.org/tip/7043679a989af969e9f20cc7d90195b36f54036f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 02 Sep 2020 15:25:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Sep 2020 15:12:52 +02:00

x86/debug: Remove handle_debug(.user) argument

The handle_debug(.user) argument is used to terminate the #DB handler early
for the INT1-from-kernel case, since the kernel doesn't use INT1.

Remove the argument and handle this explicitly in #DB-from-kernel.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200902133200.907020598@infradead.org

---
 arch/x86/kernel/traps.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9cb39d3..58bc434 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -783,25 +783,18 @@ static __always_inline unsigned long debug_read_clear_dr6(void)
  *
  * May run on IST stack.
  */
-static void handle_debug(struct pt_regs *regs, unsigned long dr6, bool user)
+static void handle_debug(struct pt_regs *regs, unsigned long dr6)
 {
 	struct task_struct *tsk = current;
 	bool user_icebp;
 	int si_code;
 
 	/*
-	 * If DR6 is zero, no point in trying to handle it. The kernel is
-	 * not using INT1.
-	 */
-	if (!user && !dr6)
-		return;
-
-	/*
 	 * If dr6 has no reason to give us about the origin of this trap,
 	 * then it's very likely the result of an icebp/int01 trap.
 	 * User wants a sigtrap for that.
 	 */
-	user_icebp = user && !dr6;
+	user_icebp = !dr6;
 
 	/* Store the virtualized DR6 value */
 	tsk->thread.debugreg6 = dr6;
@@ -874,7 +867,13 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	if (kprobe_debug_handler(regs))
 		goto out;
 
-	handle_debug(regs, dr6, false);
+	/*
+	 * The kernel doesn't use INT1
+	 */
+	if (!dr6)
+		goto out;
+
+	handle_debug(regs, dr6);
 
 out:
 	instrumentation_end();
@@ -904,7 +903,7 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
 
-	handle_debug(regs, dr6, true);
+	handle_debug(regs, dr6);
 
 	instrumentation_end();
 	irqentry_exit_to_user_mode(regs);
