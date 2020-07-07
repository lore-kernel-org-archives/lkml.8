Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1D6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE78220775
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y7xAzYuV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e7hG3Rjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgGGO7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgGGO7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:59:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D69C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:59:42 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594133981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wx5sESgdmlkgcWEdFYi8qd7RF1AYzRuf+hwfUKbXbgY=;
        b=y7xAzYuVZZ7m/tPkzI8WN0dRtu6nemncv0BS8wgWLP0coQ/PXhAhF/fyDimdtJw63RIrtz
        b7U2XA9FvVsvx4bmRreQei/E6PwHxY+9OOdLVkv86+fp87HcCiGWR1p295U7/wD8Xyl4M5
        OLJierJauZQjM/4Px1l3YbdY645bTquJUZNxX0bpsoVJgZo7mSOmo8WRMFWfLewTdqBZh1
        bRI7q/YfqbDQOYZFZMhDG8IdAW+VE1ifLUu5iUEc57hXdmi408nBjauoCMLEEvQJdYkPPz
        GRolFMP/UMsSNjFGHq29LkYtyZnG6ncEE58uu47LdKkZoMpZQT2w0S93H9cgzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594133981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wx5sESgdmlkgcWEdFYi8qd7RF1AYzRuf+hwfUKbXbgY=;
        b=e7hG3Rjsm92Ax7u2fw924lXLfJZC6u076BRdeE4SXleyPb7tjyoHw1c5KzYUrxGA+ckQCu
        Jogy7lyAWMpnD7Dg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] Revert "printk: lock/unlock console only for new logbuf entries"
Date:   Tue,  7 Jul 2020 17:05:31 +0206
Message-Id: <20200707145932.8752-4-john.ogness@linutronix.de>
In-Reply-To: <20200707145932.8752-1-john.ogness@linutronix.de>
References: <20200707145932.8752-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 3ac37a93fa9217e576bebfd4ba3e80edaaeb2289.

This optimization will not apply once the transition to a lockless
printk is complete. Rather than porting this optimization through
the transition only to remove it anyway, just revert it now to
simplify the transition.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b71eaf5f5a86..1b41e1b98221 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1981,9 +1981,8 @@ asmlinkage int vprintk_emit(int facility, int level,
 			    const char *fmt, va_list args)
 {
 	int printed_len;
-	bool in_sched = false, pending_output;
+	bool in_sched = false;
 	unsigned long flags;
-	u64 curr_log_seq;
 
 	/* Suppress unimportant messages after panic happens */
 	if (unlikely(suppress_printk))
@@ -1999,13 +1998,11 @@ asmlinkage int vprintk_emit(int facility, int level,
 
 	/* This stops the holder of console_sem just where we want him */
 	logbuf_lock_irqsave(flags);
-	curr_log_seq = log_next_seq;
 	printed_len = vprintk_store(facility, level, dict, dictlen, fmt, args);
-	pending_output = (curr_log_seq != log_next_seq);
 	logbuf_unlock_irqrestore(flags);
 
 	/* If called from the scheduler, we can not call up(). */
-	if (!in_sched && pending_output) {
+	if (!in_sched) {
 		/*
 		 * Disable preemption to avoid being preempted while holding
 		 * console_sem which would prevent anyone from printing to
@@ -2022,8 +2019,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 		preempt_enable();
 	}
 
-	if (pending_output)
-		wake_up_klogd();
+	wake_up_klogd();
 	return printed_len;
 }
 EXPORT_SYMBOL(vprintk_emit);
-- 
2.20.1

