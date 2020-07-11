Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF392C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 10:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD7982075F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 10:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rIGCq9FE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UUOy9kad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgGKKKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 06:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgGKKKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 06:10:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8C8C08C5DD;
        Sat, 11 Jul 2020 03:10:00 -0700 (PDT)
Date:   Sat, 11 Jul 2020 10:09:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594462198;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XJhx+S97F1+veS6j8aEiNWX/YWDZ0ndlNss5kMBbCi4=;
        b=rIGCq9FE88ToE9FL5iinp17I+dfNBLyP8qEcgTQfLtuXXPG0YsCXlf25mnShd77e08A5bP
        kOJgq2rntLfjOAeRuM0IMWFS17W4mAaur85fBGZ4pDsSD2W6M+G6eThejGlrxqifebm+qd
        ph7JN22KLVpaZfw+FLANJQATbYgSj6SYCH7ye0ykD1MUZGRLYKu8atd+xScb23ingm6Jf/
        99sxHGyHMJ6I0e3bZCQpvStOVTqrglk/Qs5Mw9Ibhwlb3WjJP3gpmeWx+8OpaPVrYccLIx
        QcK9jvbzpkNegIDgS/WDIwxJCpD+sjNWRSKl1ycZtJldCt6wHnISvSP8b7VckQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594462198;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XJhx+S97F1+veS6j8aEiNWX/YWDZ0ndlNss5kMBbCi4=;
        b=UUOy9kadE1/+txeRoTsHZyFwXF0G+Gcif6H/jspygOkeUBqnDM3TMcswPjaW66LHfw1zTv
        zotSCzwESlQnn2Dw==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kcsan: Make KCSAN compatible with new IRQ state tracking
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200624113246.GA170324@elver.google.com>
References: <20200624113246.GA170324@elver.google.com>
MIME-Version: 1.0
Message-ID: <159446219784.4006.13350341271966090231.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     248591f5d257a19c1cba9ab9da3536bfbc2f0149
Gitweb:        https://git.kernel.org/tip/248591f5d257a19c1cba9ab9da3536bfbc2f0149
Author:        Marco Elver <elver@google.com>
AuthorDate:    Wed, 24 Jun 2020 13:32:46 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 10 Jul 2020 12:00:00 +02:00

kcsan: Make KCSAN compatible with new IRQ state tracking

The new IRQ state tracking code does not honor lockdep_off(), and as
such we should again permit tracing by using non-raw functions in
core.c. Update the lockdep_off() comment in report.c, to reflect the
fact there is still a potential risk of deadlock due to using printk()
from scheduler code.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200624113246.GA170324@elver.google.com
---
 kernel/kcsan/core.c   |  5 ++---
 kernel/kcsan/report.c |  9 +++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 15f6794..732623c 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -397,8 +397,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	}
 
 	if (!kcsan_interrupt_watcher)
-		/* Use raw to avoid lockdep recursion via IRQ flags tracing. */
-		raw_local_irq_save(irq_flags);
+		local_irq_save(irq_flags);
 
 	watchpoint = insert_watchpoint((unsigned long)ptr, size, is_write);
 	if (watchpoint == NULL) {
@@ -539,7 +538,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
 out_unlock:
 	if (!kcsan_interrupt_watcher)
-		raw_local_irq_restore(irq_flags);
+		local_irq_restore(irq_flags);
 out:
 	user_access_restore(ua_flags);
 }
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index ac5f834..6b2fb1a 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -606,10 +606,11 @@ void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 		goto out;
 
 	/*
-	 * With TRACE_IRQFLAGS, lockdep's IRQ trace state becomes corrupted if
-	 * we do not turn off lockdep here; this could happen due to recursion
-	 * into lockdep via KCSAN if we detect a race in utilities used by
-	 * lockdep.
+	 * Because we may generate reports when we're in scheduler code, the use
+	 * of printk() could deadlock. Until such time that all printing code
+	 * called in print_report() is scheduler-safe, accept the risk, and just
+	 * get our message out. As such, also disable lockdep to hide the
+	 * warning, and avoid disabling lockdep for the rest of the kernel.
 	 */
 	lockdep_off();
 
