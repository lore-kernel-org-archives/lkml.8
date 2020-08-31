Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9221EC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D2A120782
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S4hEnlQL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L3EE61tX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgHaBL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 21:11:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57824 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgHaBLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 21:11:05 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598836263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8CyQ36olm1OV0ZzLx2j1lTX3Kj6oeTfR0IqC4W8J5eo=;
        b=S4hEnlQLBxmdovC6aS1ROgbm1/LuwM9fwPCDvNnaXBaBr46eKFgRhL2VkTYiZG36rsPJhU
        A9bXG0LUa0dCNj3d8bsyQ/i4jHyQ0Qzi5atPGuIGA7HOIbSWVu0ctwNa5ERpfKTgZxR5MJ
        v0o4Kz1Mxton10xaDF7BW26MLJQ2N4g9MUw7cTeQqgrIOKUmWxm5cIoI+z6vn5TMDOWvKi
        +dqwFiZKWNQtHf3idr3kTgVF0UE2sEuPgifPsUK6vSf6pzw68veiNhbeVv96kmdFd5Paqo
        OAU3wqSPnz+Nwc2qxuYbhsMPo14hWVnTJGweJJDtHElgRZ5BnFgMSkz6wtc7+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598836263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8CyQ36olm1OV0ZzLx2j1lTX3Kj6oeTfR0IqC4W8J5eo=;
        b=L3EE61tXi9S9x07bBTdpMi5moXglvrn8FeOf28PbPXja0ESmgYHSHTvRgGiX8UEz8KYKqh
        vKOQOMlG9TjmexBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v3 7/8] printk: reimplement log_cont using record extension
Date:   Mon, 31 Aug 2020 03:16:57 +0206
Message-Id: <20200831011058.6286-8-john.ogness@linutronix.de>
In-Reply-To: <20200831011058.6286-1-john.ogness@linutronix.de>
References: <20200831011058.6286-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the record extending feature of the ringbuffer to implement
continuous messages. This preserves the existing continuous message
behavior.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 98 +++++++++---------------------------------
 1 file changed, 20 insertions(+), 78 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7e7d596c8878..d0b2bea1fd81 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -535,7 +535,10 @@ static int log_store(u32 caller_id, int facility, int level,
 	r.info->caller_id = caller_id;
 
 	/* insert message */
-	prb_commit(&e);
+	if ((flags & LOG_CONT) || !(flags & LOG_NEWLINE))
+		prb_commit(&e);
+	else
+		prb_final_commit(&e);
 
 	return (text_len + trunc_msg_len);
 }
@@ -1093,7 +1096,7 @@ static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
 	dest_r.info->ts_nsec = r->info->ts_nsec;
 	dest_r.info->caller_id = r->info->caller_id;
 
-	prb_commit(&e);
+	prb_final_commit(&e);
 
 	return prb_record_text_space(&e);
 }
@@ -1893,87 +1896,26 @@ static inline u32 printk_caller_id(void)
 		0x80000000 + raw_smp_processor_id();
 }
 
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
 static size_t log_output(int facility, int level, enum log_flags lflags, const char *dict, size_t dictlen, char *text, size_t text_len)
 {
 	const u32 caller_id = printk_caller_id();
 
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
+	if (lflags & LOG_CONT) {
+		struct prb_reserved_entry e;
+		struct printk_record r;
+
+		prb_rec_init_wr(&r, text_len, 0);
+		if (prb_reserve_in_last(&e, prb, &r, caller_id)) {
+			memcpy(&r.text_buf[r.info->text_len], text, text_len);
+			r.info->text_len += text_len;
+			if (lflags & LOG_NEWLINE) {
+				r.info->flags |= LOG_NEWLINE;
+				prb_final_commit(&e);
+			} else {
+				prb_commit(&e);
+			}
 			return text_len;
+		}
 	}
 
 	/* Store it in the record log */
-- 
2.20.1

