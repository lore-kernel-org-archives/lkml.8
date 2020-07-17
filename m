Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CD0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31A732074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XDM9mHx+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IJZ2jbxy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgGQXtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbgGQXs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:48:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D668C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 16:48:57 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595029735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9emTC2wDuiMAZA+bMo2kWigvqNulhIFmjLwP+t/JBgo=;
        b=XDM9mHx+j6/GTKAEa53mTmU0yV+yCHzLl6xcyLMhiIEWxNS3Il1hYlS7+VUeomJVCFm3M6
        qPotGprnGE3KMQkdDILjwanEznGDNT/Xhq/1PTQAMoR7gavXYqlDyXqk/DS1IW0Q9miq0L
        BpRXdU7nc2T6C41J9lIfb0yuQgXUThVZaEGvjmT7LfZlzRRo+m+JdLbWodg5m+XK2vb5+O
        tfCvDMtwkxhXBHRBufoLY2h1tY6iLdwZqOG0gQfyNhGXxpid8YSQfKRFUYJuFLniglOICq
        tR8USdpYuIGucB1HbzzjGXaXn9Ml/cL7dOyhWE1cGajuDtdsIFQiowkqdI/JCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595029735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9emTC2wDuiMAZA+bMo2kWigvqNulhIFmjLwP+t/JBgo=;
        b=IJZ2jbxyF4TJMLm4jS8eg/J9+kn132NNe1Oei+WEfv0CyyfimPy/yKhMD2UigvKjfZ0rSV
        lgZo9UQIfUWBPkBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] printk: store instead of processing cont parts
Date:   Sat, 18 Jul 2020 01:54:16 +0206
Message-Id: <20200717234818.8622-3-john.ogness@linutronix.de>
In-Reply-To: <20200717234818.8622-1-john.ogness@linutronix.de>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of buffering continuous line parts before storing the full
line into the ringbuffer, store each part as its own record.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 114 ++++-------------------------------------
 1 file changed, 11 insertions(+), 103 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fec71229169e..c4274c867771 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -495,9 +495,14 @@ static void truncate_msg(u16 *text_len, u16 *trunc_msg_len)
 		*trunc_msg_len = 0;
 }
 
+static inline u32 printk_caller_id(void)
+{
+	return in_task() ? task_pid_nr(current) :
+		0x80000000 + raw_smp_processor_id();
+}
+
 /* insert record into the buffer, discard old ones, update heads */
-static int log_store(u32 caller_id, int facility, int level,
-		     enum log_flags flags, u64 ts_nsec,
+static int log_store(int facility, int level, enum log_flags flags,
 		     const char *dict, u16 dict_len,
 		     const char *text, u16 text_len)
 {
@@ -525,11 +530,8 @@ static int log_store(u32 caller_id, int facility, int level,
 	r.info->facility = facility;
 	r.info->level = level & 7;
 	r.info->flags = flags & 0x1f;
-	if (ts_nsec > 0)
-		r.info->ts_nsec = ts_nsec;
-	else
-		r.info->ts_nsec = local_clock();
-	r.info->caller_id = caller_id;
+	r.info->ts_nsec = local_clock();
+	r.info->caller_id = printk_caller_id();
 
 	/* insert message */
 	prb_commit(&e);
@@ -1874,100 +1876,6 @@ static inline void printk_delay(void)
 	}
 }
 
-static inline u32 printk_caller_id(void)
-{
-	return in_task() ? task_pid_nr(current) :
-		0x80000000 + raw_smp_processor_id();
-}
-
-/*
- * Continuation lines are buffered, and not committed to the record buffer
- * until the line is complete, or a race forces it. The line fragments
- * though, are printed immediately to the consoles to ensure everything has
- * reached the console in case of a kernel crash.
- */
-static struct cont {
-	char buf[LOG_LINE_MAX];
-	size_t len;			/* length == 0 means unused buffer */
-	u32 caller_id;			/* printk_caller_id() of first print */
-	u64 ts_nsec;			/* time of first print */
-	u8 level;			/* log level of first message */
-	u8 facility;			/* log facility of first message */
-	enum log_flags flags;		/* prefix, newline flags */
-} cont;
-
-static void cont_flush(void)
-{
-	if (cont.len == 0)
-		return;
-
-	log_store(cont.caller_id, cont.facility, cont.level, cont.flags,
-		  cont.ts_nsec, NULL, 0, cont.buf, cont.len);
-	cont.len = 0;
-}
-
-static bool cont_add(u32 caller_id, int facility, int level,
-		     enum log_flags flags, const char *text, size_t len)
-{
-	/* If the line gets too long, split it up in separate records. */
-	if (cont.len + len > sizeof(cont.buf)) {
-		cont_flush();
-		return false;
-	}
-
-	if (!cont.len) {
-		cont.facility = facility;
-		cont.level = level;
-		cont.caller_id = caller_id;
-		cont.ts_nsec = local_clock();
-		cont.flags = flags;
-	}
-
-	memcpy(cont.buf + cont.len, text, len);
-	cont.len += len;
-
-	// The original flags come from the first line,
-	// but later continuations can add a newline.
-	if (flags & LOG_NEWLINE) {
-		cont.flags |= LOG_NEWLINE;
-		cont_flush();
-	}
-
-	return true;
-}
-
-static size_t log_output(int facility, int level, enum log_flags lflags, const char *dict, size_t dictlen, char *text, size_t text_len)
-{
-	const u32 caller_id = printk_caller_id();
-
-	/*
-	 * If an earlier line was buffered, and we're a continuation
-	 * write from the same context, try to add it to the buffer.
-	 */
-	if (cont.len) {
-		if (cont.caller_id == caller_id && (lflags & LOG_CONT)) {
-			if (cont_add(caller_id, facility, level, lflags, text, text_len))
-				return text_len;
-		}
-		/* Otherwise, make sure it's flushed */
-		cont_flush();
-	}
-
-	/* Skip empty continuation lines that couldn't be added - they just flush */
-	if (!text_len && (lflags & LOG_CONT))
-		return 0;
-
-	/* If it doesn't end in a newline, try to buffer the current line */
-	if (!(lflags & LOG_NEWLINE)) {
-		if (cont_add(caller_id, facility, level, lflags, text, text_len))
-			return text_len;
-	}
-
-	/* Store it in the record log */
-	return log_store(caller_id, facility, level, lflags, 0,
-			 dict, dictlen, text, text_len);
-}
-
 /* Must be called under logbuf_lock. */
 int vprintk_store(int facility, int level,
 		  const char *dict, size_t dictlen,
@@ -2015,8 +1923,8 @@ int vprintk_store(int facility, int level,
 	if (dict)
 		lflags |= LOG_NEWLINE;
 
-	return log_output(facility, level, lflags,
-			  dict, dictlen, text, text_len);
+	return log_store(facility, level, lflags, dict, dictlen,
+			 text, text_len);
 }
 
 asmlinkage int vprintk_emit(int facility, int level,
-- 
2.20.1

