Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573D6C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36600206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgELPTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbgELPTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:19:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1AEC061A0C;
        Tue, 12 May 2020 08:19:02 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYWgM-0007DZ-Lf; Tue, 12 May 2020 17:18:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 293291C02FC;
        Tue, 12 May 2020 17:18:58 +0200 (CEST)
Date:   Tue, 12 May 2020 15:18:58 -0000
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] samples/kprobes: Add __kprobes and
 NOKPROBE_SYMBOL() for handlers.
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134059.878578033@linutronix.de>
References: <20200505134059.878578033@linutronix.de>
MIME-Version: 1.0
Message-ID: <158929673802.390.17568786891969642247.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/kprobes branch of tip:

Commit-ID:     d85eaa9411472a99de4b5732cb59c8bae629d5f1
Gitweb:        https://git.kernel.org/tip/d85eaa9411472a99de4b5732cb59c8bae629d5f1
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Thu, 26 Mar 2020 23:50:11 +09:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 May 2020 17:15:33 +02:00

samples/kprobes: Add __kprobes and NOKPROBE_SYMBOL() for handlers.

Add __kprobes and NOKPROBE_SYMBOL() for sample kprobe handlers.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134059.878578033@linutronix.de

---
 samples/kprobes/kprobe_example.c    | 6 ++++--
 samples/kprobes/kretprobe_example.c | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
index d693c23..501911d 100644
--- a/samples/kprobes/kprobe_example.c
+++ b/samples/kprobes/kprobe_example.c
@@ -25,7 +25,7 @@ static struct kprobe kp = {
 };
 
 /* kprobe pre_handler: called just before the probed instruction is executed */
-static int handler_pre(struct kprobe *p, struct pt_regs *regs)
+static int __kprobes handler_pre(struct kprobe *p, struct pt_regs *regs)
 {
 #ifdef CONFIG_X86
 	pr_info("<%s> pre_handler: p->addr = 0x%p, ip = %lx, flags = 0x%lx\n",
@@ -54,7 +54,7 @@ static int handler_pre(struct kprobe *p, struct pt_regs *regs)
 }
 
 /* kprobe post_handler: called after the probed instruction is executed */
-static void handler_post(struct kprobe *p, struct pt_regs *regs,
+static void __kprobes handler_post(struct kprobe *p, struct pt_regs *regs,
 				unsigned long flags)
 {
 #ifdef CONFIG_X86
@@ -90,6 +90,8 @@ static int handler_fault(struct kprobe *p, struct pt_regs *regs, int trapnr)
 	/* Return 0 because we don't handle the fault. */
 	return 0;
 }
+/* NOKPROBE_SYMBOL() is also available */
+NOKPROBE_SYMBOL(handler_fault);
 
 static int __init kprobe_init(void)
 {
diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
index 186315c..013e8e6 100644
--- a/samples/kprobes/kretprobe_example.c
+++ b/samples/kprobes/kretprobe_example.c
@@ -48,6 +48,7 @@ static int entry_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
 	data->entry_stamp = ktime_get();
 	return 0;
 }
+NOKPROBE_SYMBOL(entry_handler);
 
 /*
  * Return-probe handler: Log the return value and duration. Duration may turn
@@ -67,6 +68,7 @@ static int ret_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
 			func_name, retval, (long long)delta);
 	return 0;
 }
+NOKPROBE_SYMBOL(ret_handler);
 
 static struct kretprobe my_kretprobe = {
 	.handler		= ret_handler,
