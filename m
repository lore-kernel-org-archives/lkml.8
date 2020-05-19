Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4377C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC90A207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgESTwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbgESTws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:52:48 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB22EC08C5C1;
        Tue, 19 May 2020 12:52:47 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8I1-0007tD-Kg; Tue, 19 May 2020 21:52:37 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2F0D41C047E;
        Tue, 19 May 2020 21:52:37 +0200 (CEST)
Date:   Tue, 19 May 2020 19:52:37 -0000
From:   "tip-bot2 for Petr Mladek" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] printk: Prepare for nested printk_nmi_enter()
Cc:     Petr Mladek <pmladek@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134100.681374113@linutronix.de>
References: <20200505134100.681374113@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991795708.17951.10946630610236060760.tip-bot2@tip-bot2>
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

Commit-ID:     8c4e93c362ff114def211d4629b120af86eb1275
Gitweb:        https://git.kernel.org/tip/8c4e93c362ff114def211d4629b120af86eb1275
Author:        Petr Mladek <pmladek@suse.com>
AuthorDate:    Mon, 24 Feb 2020 13:13:31 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 15:51:16 +02:00

printk: Prepare for nested printk_nmi_enter()

There is plenty of space in the printk_context variable. Reserve one byte
there for the NMI context to be on the safe side.

It should never overflow. The BUG_ON(in_nmi() == NMI_MASK) in nmi_enter()
will trigger much earlier.

Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Link: https://lkml.kernel.org/r/20200505134100.681374113@linutronix.de



---
 kernel/printk/internal.h    | 8 +++++---
 kernel/printk/printk_safe.c | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index b2b0f52..660f9a6 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -6,9 +6,11 @@
 
 #ifdef CONFIG_PRINTK
 
-#define PRINTK_SAFE_CONTEXT_MASK	 0x3fffffff
-#define PRINTK_NMI_DIRECT_CONTEXT_MASK	 0x40000000
-#define PRINTK_NMI_CONTEXT_MASK		 0x80000000
+#define PRINTK_SAFE_CONTEXT_MASK	0x007ffffff
+#define PRINTK_NMI_DIRECT_CONTEXT_MASK	0x008000000
+#define PRINTK_NMI_CONTEXT_MASK		0xff0000000
+
+#define PRINTK_NMI_CONTEXT_OFFSET	0x010000000
 
 extern raw_spinlock_t logbuf_lock;
 
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index d9a659a..e8791f2 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -295,12 +295,12 @@ static __printf(1, 0) int vprintk_nmi(const char *fmt, va_list args)
 
 void notrace printk_nmi_enter(void)
 {
-	this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
+	this_cpu_add(printk_context, PRINTK_NMI_CONTEXT_OFFSET);
 }
 
 void notrace printk_nmi_exit(void)
 {
-	this_cpu_and(printk_context, ~PRINTK_NMI_CONTEXT_MASK);
+	this_cpu_sub(printk_context, PRINTK_NMI_CONTEXT_OFFSET);
 }
 
 /*
