Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A258DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F4132072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pV2tIk2i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eLV4a7uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgHXQWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:22:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43672 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHXQWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:22:31 -0400
Date:   Mon, 24 Aug 2020 16:22:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598286148;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aU6nrsbVrPhbNwxpDNiAxzaxHk6gDD++MMmQJ8cUbSQ=;
        b=pV2tIk2iklR1jXVfeC0cJPcqoh1DbiCmdDMkq853UpTeZoAZ2VW5oxCf3ixo2M4iT6BkB5
        8UZH7wSYedxoe23fUtdR9C0uvdncxF2mt732o1wpZH0yGogJmRSQAT7VRqQWhGRjX3ydkr
        u9eQU5FXWcM4AoQmQE99gNbeezk2pwNf+udnY6RkY8imp99ycBpL5SO9eQjN+Vwong60Hz
        UGYb81FG7W5LUxkSgfgqcrxbXyCvWVkU0NP03Xfipc4iHjx6ioCYPKtCrzLn7r5nKUW0nx
        vO4vXDJniyAUKUn3v8pfjsXKIb3LZh8bQEMBWRIauDyz/No6Y7LjpEEtMHJG1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598286148;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aU6nrsbVrPhbNwxpDNiAxzaxHk6gDD++MMmQJ8cUbSQ=;
        b=eLV4a7ucMRouolD/LwYXGZF0plZGEDY50gaIb3sWaNKKQflu8FqiDunFvDxD12ItGVl3PL
        0mTSWL7XxlSPELBA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fsgsbase] x86/fsgsbase: Replace static_cpu_has() with
 boot_cpu_has()
Cc:     Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200818103715.32736-1-bp@alien8.de>
References: <20200818103715.32736-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <159828614748.389.3888049416727618189.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/fsgsbase branch of tip:

Commit-ID:     5f1dd4dda5c8796c405e856aaa11e187f6885924
Gitweb:        https://git.kernel.org/tip/5f1dd4dda5c8796c405e856aaa11e187f6885924
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 18 Aug 2020 12:28:31 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 24 Aug 2020 18:18:32 +02:00

x86/fsgsbase: Replace static_cpu_has() with boot_cpu_has()

ptrace and prctl() are not really fast paths to warrant the use of
static_cpu_has() and cause alternatives patching for no good reason.
Replace with boot_cpu_has() which is simple and fast enough.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200818103715.32736-1-bp@alien8.de
---
 arch/x86/include/asm/fsgsbase.h | 4 ++--
 arch/x86/kernel/process_64.c    | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index d552646..35cff5f 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -57,7 +57,7 @@ static inline unsigned long x86_fsbase_read_cpu(void)
 {
 	unsigned long fsbase;
 
-	if (static_cpu_has(X86_FEATURE_FSGSBASE))
+	if (boot_cpu_has(X86_FEATURE_FSGSBASE))
 		fsbase = rdfsbase();
 	else
 		rdmsrl(MSR_FS_BASE, fsbase);
@@ -67,7 +67,7 @@ static inline unsigned long x86_fsbase_read_cpu(void)
 
 static inline void x86_fsbase_write_cpu(unsigned long fsbase)
 {
-	if (static_cpu_has(X86_FEATURE_FSGSBASE))
+	if (boot_cpu_has(X86_FEATURE_FSGSBASE))
 		wrfsbase(fsbase);
 	else
 		wrmsrl(MSR_FS_BASE, fsbase);
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 9afefe3..df342be 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -407,7 +407,7 @@ unsigned long x86_gsbase_read_cpu_inactive(void)
 {
 	unsigned long gsbase;
 
-	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+	if (boot_cpu_has(X86_FEATURE_FSGSBASE)) {
 		unsigned long flags;
 
 		local_irq_save(flags);
@@ -422,7 +422,7 @@ unsigned long x86_gsbase_read_cpu_inactive(void)
 
 void x86_gsbase_write_cpu_inactive(unsigned long gsbase)
 {
-	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+	if (boot_cpu_has(X86_FEATURE_FSGSBASE)) {
 		unsigned long flags;
 
 		local_irq_save(flags);
@@ -439,7 +439,7 @@ unsigned long x86_fsbase_read_task(struct task_struct *task)
 
 	if (task == current)
 		fsbase = x86_fsbase_read_cpu();
-	else if (static_cpu_has(X86_FEATURE_FSGSBASE) ||
+	else if (boot_cpu_has(X86_FEATURE_FSGSBASE) ||
 		 (task->thread.fsindex == 0))
 		fsbase = task->thread.fsbase;
 	else
@@ -454,7 +454,7 @@ unsigned long x86_gsbase_read_task(struct task_struct *task)
 
 	if (task == current)
 		gsbase = x86_gsbase_read_cpu_inactive();
-	else if (static_cpu_has(X86_FEATURE_FSGSBASE) ||
+	else if (boot_cpu_has(X86_FEATURE_FSGSBASE) ||
 		 (task->thread.gsindex == 0))
 		gsbase = task->thread.gsbase;
 	else
