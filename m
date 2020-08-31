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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02258C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A52207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RRzom932";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="merKHP1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgHaBLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 21:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgHaBLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 21:11:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3811C061239
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 18:11:03 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598836262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qwHkdn41e6e5GbO9ZWSYldsTSfQir+jKX8VEmrPEaHY=;
        b=RRzom932ccFxt8jojlQ9WNCn6WwoV/sT2nYIkqCODdEs/tgtA5jeD7NEupbKhjFuT+Lk08
        xPrzI+t+8Bki3T+PfnQlyjwXzrShUI6kj8tvVCUC3+VNdeiocRSCYoCYrE6kRsHlArTk9i
        DAeTydZRM36iP8DqgJRaInLpTDOzoHhCkO+vImXufDjWfayf+KhNy2k6C7bOGuUYgkWoQR
        mt6acetOVVoEksICITA8HtVUj0SzT/eCGJ1xmYp/kmTesxSv0OjI0+7MFP6YTTCE680OBE
        alLMFxkq8M0cpEx6CjUoQXDT9BBnFWRA14SIy7m0Fpp7Q2xBzAWRPlTAaFS08g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598836262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qwHkdn41e6e5GbO9ZWSYldsTSfQir+jKX8VEmrPEaHY=;
        b=merKHP1a2pq3ieGWJpO9mGtE+kSJ/ZsfDUQNnIGoxHe3tpfxxWQOxu+AFbeYHN35HId0NI
        4Bn+yu5caAKyXNAA==
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
Subject: [PATCH next v3 5/8] printk: ringbuffer: clear initial reserved fields
Date:   Mon, 31 Aug 2020 03:16:55 +0206
Message-Id: <20200831011058.6286-6-john.ogness@linutronix.de>
In-Reply-To: <20200831011058.6286-1-john.ogness@linutronix.de>
References: <20200831011058.6286-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prb_reserve() will set some meta data values and leave others
uninitialized (or rather, containing the values of the previous
wrap). Simplify the API by always clearing out all the fields.
Only the sequence number is filled in. The caller is now
responsible for filling in the rest of the meta data fields.
In particular, for correctly filling in text and dict lengths.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c            |  7 ++++++-
 kernel/printk/printk_ringbuffer.c | 29 +++++++++++++++++++----------
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ad8d1dfe5fbe..7e7d596c8878 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -520,8 +520,11 @@ static int log_store(u32 caller_id, int facility, int level,
 	memcpy(&r.text_buf[0], text, text_len);
 	if (trunc_msg_len)
 		memcpy(&r.text_buf[text_len], trunc_msg, trunc_msg_len);
-	if (r.dict_buf)
+	r.info->text_len = text_len + trunc_msg_len;
+	if (r.dict_buf) {
 		memcpy(&r.dict_buf[0], dict, dict_len);
+		r.info->dict_len = dict_len;
+	}
 	r.info->facility = facility;
 	r.info->level = level & 7;
 	r.info->flags = flags & 0x1f;
@@ -1078,9 +1081,11 @@ static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
 		return 0;
 
 	memcpy(&dest_r.text_buf[0], &r->text_buf[0], dest_r.text_buf_size);
+	dest_r.info->text_len = r->info->text_len;
 	if (dest_r.dict_buf) {
 		memcpy(&dest_r.dict_buf[0], &r->dict_buf[0],
 		       dest_r.dict_buf_size);
+		dest_r.info->dict_len = r->info->dict_len;
 	}
 	dest_r.info->facility = r->info->facility;
 	dest_r.info->level = r->info->level;
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index d66718e74aae..da54d4fadf96 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -146,10 +146,13 @@
  *
  *	if (prb_reserve(&e, &test_rb, &r)) {
  *		snprintf(r.text_buf, r.text_buf_size, "%s", textstr);
+ *		r.info->text_len = strlen(textstr);
  *
  *		// dictionary allocation may have failed
- *		if (r.dict_buf)
+ *		if (r.dict_buf) {
  *			snprintf(r.dict_buf, r.dict_buf_size, "%s", dictstr);
+ *			r.info->dict_len = strlen(dictstr);
+ *		}
  *
  *		r.info->ts_nsec = local_clock();
  *
@@ -1125,9 +1128,9 @@ static const char *get_data(struct prb_data_ring *data_ring,
  * @dict_buf_size is set to 0. Writers must check this before writing to
  * dictionary space.
  *
- * @info->text_len and @info->dict_len will already be set to @text_buf_size
- * and @dict_buf_size, respectively. If dictionary space reservation fails,
- * @info->dict_len is set to 0.
+ * Important: @info->text_len and @info->dict_len need to be set correctly by
+ *            the writer in order for data to be readable and/or extended.
+ *            Their values are initialized to 0.
  */
 bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 		 struct printk_record *r)
@@ -1159,6 +1162,18 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 
 	d = to_desc(desc_ring, id);
 
+	/*
+	 * Clear all @info fields except for @seq, which is used to determine
+	 * the new sequence number. The writer must fill in new values.
+	 */
+	d->info.ts_nsec = 0;
+	d->info.text_len = 0;
+	d->info.dict_len = 0;
+	d->info.facility = 0;
+	d->info.flags = 0;
+	d->info.level = 0;
+	d->info.caller_id = 0;
+
 	/*
 	 * Set the @e fields here so that prb_commit() can be used if
 	 * text data allocation fails.
@@ -1186,8 +1201,6 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 				 &d->text_blk_lpos, id);
 	/* If text data allocation fails, a data-less record is committed. */
 	if (r->text_buf_size && !r->text_buf) {
-		d->info.text_len = 0;
-		d->info.dict_len = 0;
 		prb_commit(e);
 		/* prb_commit() re-enabled interrupts. */
 		goto fail;
@@ -1204,10 +1217,6 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 
 	r->info = &d->info;
 
-	/* Set default values for the sizes. */
-	d->info.text_len = r->text_buf_size;
-	d->info.dict_len = r->dict_buf_size;
-
 	/* Record full text space used by record. */
 	e->text_space = space_used(&rb->text_data_ring, &d->text_blk_lpos);
 
-- 
2.20.1

