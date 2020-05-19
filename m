Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62121C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 354DC2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgESTxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgESTwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:52:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20103C08C5C0;
        Tue, 19 May 2020 12:52:47 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8I6-0007sk-3P; Tue, 19 May 2020 21:52:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BF15F1C04D1;
        Tue, 19 May 2020 21:52:36 +0200 (CEST)
Date:   Tue, 19 May 2020 19:52:36 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] printk: Disallow instrumenting print_nmi_enter()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134101.139720912@linutronix.de>
References: <20200505134101.139720912@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991795665.17951.2179685164369351471.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b0f51883f551b900a04a80f49fb0886caf7e9a12
Gitweb:        https://git.kernel.org/tip/b0f51883f551b900a04a80f49fb0886caf7e9a12
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 24 Feb 2020 22:25:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 15:51:16 +02:00

printk: Disallow instrumenting print_nmi_enter()

It happens early in nmi_enter(), no tracing, probing or other funnies
allowed. Specifically as nmi_enter() will be used in do_debug(), which
would cause recursive exceptions when kprobed.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Link: https://lkml.kernel.org/r/20200505134101.139720912@linutronix.de


---
 kernel/printk/printk_safe.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index e8791f2..4242403 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -10,6 +10,7 @@
 #include <linux/cpumask.h>
 #include <linux/irq_work.h>
 #include <linux/printk.h>
+#include <linux/kprobes.h>
 
 #include "internal.h"
 
@@ -293,12 +294,12 @@ static __printf(1, 0) int vprintk_nmi(const char *fmt, va_list args)
 	return printk_safe_log_store(s, fmt, args);
 }
 
-void notrace printk_nmi_enter(void)
+void noinstr printk_nmi_enter(void)
 {
 	this_cpu_add(printk_context, PRINTK_NMI_CONTEXT_OFFSET);
 }
 
-void notrace printk_nmi_exit(void)
+void noinstr printk_nmi_exit(void)
 {
 	this_cpu_sub(printk_context, PRINTK_NMI_CONTEXT_OFFSET);
 }
