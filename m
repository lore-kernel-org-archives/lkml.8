Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296DCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0508220872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgEST7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbgEST7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:59:06 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AED7C08C5C0;
        Tue, 19 May 2020 12:59:05 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8OC-0000Dr-4B; Tue, 19 May 2020 21:59:00 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C74601C06DA;
        Tue, 19 May 2020 21:58:46 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:46 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] lib/smp_processor_id: Move it into noinstr section
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134340.902709267@linutronix.de>
References: <20200505134340.902709267@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991832672.17951.865778371645620306.tip-bot2@tip-bot2>
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

Commit-ID:     85e04f67df29915ef76c2db0fe1b7a8b44988c41
Gitweb:        https://git.kernel.org/tip/85e04f67df29915ef76c2db0fe1b7a8b44988c41
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 Mar 2020 23:47:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 15:47:22 +02:00

lib/smp_processor_id: Move it into noinstr section

That code is already not traceable. Move it into the noinstr section so the
objtool section validation does not trigger.

Annotate the warning code as "safe". While it might be not under all
circumstances, getting the information out is important enough.

Should this ever trigger from the sensitive code which is shielded against
instrumentation, e.g. low level entry, then the printk is the least of the
worries.

Addresses the objtool warnings:
 vmlinux.o: warning: objtool: context_tracking_recursion_enter()+0x7: call to __this_cpu_preempt_check() leaves .noinstr.text section
 vmlinux.o: warning: objtool: __context_tracking_exit()+0x17: call to __this_cpu_preempt_check() leaves .noinstr.text section
 vmlinux.o: warning: objtool: __context_tracking_enter()+0x2a: call to __this_cpu_preempt_check() leaves .noinstr.text section

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134340.902709267@linutronix.de


---
 lib/smp_processor_id.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index bd95716..525222e 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -8,7 +8,7 @@
 #include <linux/kprobes.h>
 #include <linux/sched.h>
 
-notrace static nokprobe_inline
+noinstr static
 unsigned int check_preemption_disabled(const char *what1, const char *what2)
 {
 	int this_cpu = raw_smp_processor_id();
@@ -37,6 +37,7 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
 	 */
 	preempt_disable_notrace();
 
+	instrumentation_begin();
 	if (!printk_ratelimit())
 		goto out_enable;
 
@@ -45,6 +46,7 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
 
 	printk("caller is %pS\n", __builtin_return_address(0));
 	dump_stack();
+	instrumentation_end();
 
 out_enable:
 	preempt_enable_no_resched_notrace();
@@ -52,16 +54,14 @@ out:
 	return this_cpu;
 }
 
-notrace unsigned int debug_smp_processor_id(void)
+noinstr unsigned int debug_smp_processor_id(void)
 {
 	return check_preemption_disabled("smp_processor_id", "");
 }
 EXPORT_SYMBOL(debug_smp_processor_id);
-NOKPROBE_SYMBOL(debug_smp_processor_id);
 
-notrace void __this_cpu_preempt_check(const char *op)
+noinstr void __this_cpu_preempt_check(const char *op)
 {
 	check_preemption_disabled("__this_cpu_", op);
 }
 EXPORT_SYMBOL(__this_cpu_preempt_check);
-NOKPROBE_SYMBOL(__this_cpu_preempt_check);
