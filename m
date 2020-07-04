Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D664C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 17:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F08C82070B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 17:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bhMK5ABe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="byBborah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgGDRtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 13:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbgGDRtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 13:49:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A8DC08C5DE;
        Sat,  4 Jul 2020 10:49:12 -0700 (PDT)
Date:   Sat, 04 Jul 2020 17:49:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593884951;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q3qZ6HD4Yvwj4pLZUr0jNKiF5GRzv8DV98fxeDcLRBU=;
        b=bhMK5ABeRXUU31ASKy3B1Q3fThBERQh3GWUV0uulfDLP0/eEzyq2rGNGZVwNxQj7zf2o0M
        tJTVFeI1GKQo8O9L08rR2D7ocQO7KOSOPpIOxKUM1BTkTsDPp1ItBz8jBrGCvz0EHwgbTE
        Cdz/an2JoZ9IjmZPrypiWallcA9pVbnNJvF1Ylj8n7fFrdXf+MMfBWGcPoIssxlyr7JSNT
        6+m+kHByapeHZCFb/CAG44+UmhvOuPfIV+zXUJ4xeR1HzkNEg6mcxSdMQ/gAJXwwn9msWa
        dWDOzLcubMrCfsxM4DxW+zZxFOKs2L+Pd6UOP6tvtvDYVp3C9la36eqESoN7EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593884951;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q3qZ6HD4Yvwj4pLZUr0jNKiF5GRzv8DV98fxeDcLRBU=;
        b=byBborah4Pf4KqlOkmdVlCk/GfGs3LQ8m++E3Z+qQJCQdfC+6r3o8oK/dAmLmk2EEWw0Nu
        2zKI7pkogDzlUXDQ==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry, selftests: Further improve user entry
 sanity checks
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <881de09e786ab93ce56ee4a2437ba2c308afe7a9.1593795633.git.luto@kernel.org>
References: <881de09e786ab93ce56ee4a2437ba2c308afe7a9.1593795633.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <159388495037.4006.7851835406474127743.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3c73b81a9164d0c1b6379d6672d2772a9e95168e
Gitweb:        https://git.kernel.org/tip/3c73b81a9164d0c1b6379d6672d2772a9e95168e
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Fri, 03 Jul 2020 10:02:54 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 04 Jul 2020 19:47:25 +02:00

x86/entry, selftests: Further improve user entry sanity checks

Chasing down a Xen bug caused me to realize that the new entry sanity
checks are still fairly weak.  Add some more checks.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/881de09e786ab93ce56ee4a2437ba2c308afe7a9.1593795633.git.luto@kernel.org

---
 arch/x86/entry/common.c                  | 19 +++++++++++++++++++
 tools/testing/selftests/x86/syscall_nt.c | 11 +++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index f392a8b..e83b3f1 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -49,6 +49,23 @@
 static void check_user_regs(struct pt_regs *regs)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_ENTRY)) {
+		/*
+		 * Make sure that the entry code gave us a sensible EFLAGS
+		 * register.  Native because we want to check the actual CPU
+		 * state, not the interrupt state as imagined by Xen.
+		 */
+		unsigned long flags = native_save_fl();
+		WARN_ON_ONCE(flags & (X86_EFLAGS_AC | X86_EFLAGS_DF |
+				      X86_EFLAGS_NT));
+
+		/* We think we came from user mode. Make sure pt_regs agrees. */
+		WARN_ON_ONCE(!user_mode(regs));
+
+		/*
+		 * All entries from user mode (except #DF) should be on the
+		 * normal thread stack and should have user pt_regs in the
+		 * correct location.
+		 */
 		WARN_ON_ONCE(!on_thread_stack());
 		WARN_ON_ONCE(regs != task_pt_regs(current));
 	}
@@ -577,6 +594,7 @@ SYSCALL_DEFINE0(ni_syscall)
 bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
+		check_user_regs(regs);
 		enter_from_user_mode();
 		return false;
 	}
@@ -710,6 +728,7 @@ void noinstr idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit)
  */
 void noinstr idtentry_enter_user(struct pt_regs *regs)
 {
+	check_user_regs(regs);
 	enter_from_user_mode();
 }
 
diff --git a/tools/testing/selftests/x86/syscall_nt.c b/tools/testing/selftests/x86/syscall_nt.c
index 970e5e1..a108b80 100644
--- a/tools/testing/selftests/x86/syscall_nt.c
+++ b/tools/testing/selftests/x86/syscall_nt.c
@@ -81,5 +81,16 @@ int main(void)
 	printf("[RUN]\tSet NT|AC|TF and issue a syscall\n");
 	do_it(X86_EFLAGS_NT | X86_EFLAGS_AC | X86_EFLAGS_TF);
 
+	/*
+	 * Now try DF.  This is evil and it's plausible that we will crash
+	 * glibc, but glibc would have to do something rather surprising
+	 * for this to happen.
+	 */
+	printf("[RUN]\tSet DF and issue a syscall\n");
+	do_it(X86_EFLAGS_DF);
+
+	printf("[RUN]\tSet TF|DF and issue a syscall\n");
+	do_it(X86_EFLAGS_TF | X86_EFLAGS_DF);
+
 	return nerrs == 0 ? 0 : 1;
 }
