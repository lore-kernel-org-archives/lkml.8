Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D46C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB812074B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zoAF8Sjh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KBLIkamN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgGINX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:23:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37586 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgGINX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:23:56 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594301034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyAI9EeAgyHSOaZxI2FVt0Pf/93iA3CeRJVEU6Dw0F0=;
        b=zoAF8Sjh3hhdEB7n/bwuT1eJTY6nBP5TPHGTsii6FtJzk57CPv5hSsWjkrn3jkca+AFxnH
        Id3aW1WmoauTviiW5bDu6KHAUadi8HRtWj/CqDDnCUr1qoUWKdxEL1B0U/Nc5z/vV9V7My
        GQlgrlnMsV6ZdXplyUln6BTqXdhSvdqS0v1YZVU5B21PL/WOn+UxQ8p5djvEKUuJ1rI1i1
        Nw2lNvydVW4onpoYcFj+M7vM6GvJuyxQti2Anu50bGAgka3re8bVEDKUR9cdlCQaHKrTkM
        MIyfVV0r9IVjYZUyw+Ej/zAILMhl2+h0XzX2neKxDXrHC32x8JPJsqnk5KpKfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594301034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyAI9EeAgyHSOaZxI2FVt0Pf/93iA3CeRJVEU6Dw0F0=;
        b=KBLIkamNmTgmTWyPwyPWmT8yJpWhi5aL4O8Pqs+uPhfvPI8XQ4GJsdsDKsjh4UmEP7tRLp
        Ze+OfmjeuyLzfODg==
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
Subject: [PATCH v5 3/4] Revert "printk: lock/unlock console only for new logbuf entries"
Date:   Thu,  9 Jul 2020 15:29:43 +0206
Message-Id: <20200709132344.760-4-john.ogness@linutronix.de>
In-Reply-To: <20200709132344.760-1-john.ogness@linutronix.de>
References: <20200709132344.760-1-john.ogness@linutronix.de>
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
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
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

