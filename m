Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561F0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B12A2065D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W6LrzeX8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/ksdwPqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgGUNZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgGUNZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 09:25:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A8BC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 06:25:39 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595337935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Pe7zsAFMWY3Nr1Ws8Le2I6t2JpwIMVNPlUqhycxFlV0=;
        b=W6LrzeX8yzALB3LAjui6nx/3uXvSpjppy7ZafVph8XJCamZ9IstViIRkx++7+WAyYYfYde
        xd0gDdPrgRAoXiNvreD8508gGKk7Kk1VH/juht/g+oozxbRHtf+BY9JHqSkgUfsswEcnlj
        ywMiwRo0nENWm2uKKejRKfB67f96MOwQMflzQlGIi/I/m5vJnRAySYFL5CNOK5xhp4sr7C
        DqFe9qvlpLn7GdtlFYwoQNgX8lMZy0AErZJ2uV5H/C1mWOaSq43pRP6ZfzAZS30LUkQcQA
        Wj6t+68i6ed/0rzcTgF34q+v2yTwlhrtPX4oWKxaMjq39XoMJULnTKtVJuzaVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595337935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Pe7zsAFMWY3Nr1Ws8Le2I6t2JpwIMVNPlUqhycxFlV0=;
        b=/ksdwPqU0bAwHZXjMT6fuO8rO0OwjQkD4Z21h28muA8zNNUwGfZ/YLP2ipzrzhTlkoPP84
        6XBh7XViLPQV2dAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marco Elver <elver@google.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2][next] printk: ringbuffer: support dataless records
Date:   Tue, 21 Jul 2020 15:31:28 +0206
Message-Id: <20200721132528.9661-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit ("printk: use the lockless ringbuffer"), printk()
started silently dropping messages without text because such
records are not supported by the new printk ringbuffer.

Add support for such records.

Currently dataless records are denoted by INVALID_LPOS in order
to recognize failed prb_reserve() calls. Change the ringbuffer
to instead use two different identifiers (FAILED_LPOS and
NO_LPOS) to distinguish between failed prb_reserve() records and
successful dataless records, respectively.

Fixes: ("printk: use the lockless ringbuffer")
Fixes: https://lkml.kernel.org/r/20200718121053.GA691245@elver.google.com
Reported-by: Marco Elver <elver@google.com>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 based on next-20200721

 chages since v1:
 - Instead of handling empty text messages as special case errors,
   allow such messages to be handled as any other valid messages.
   This also allows the empty text message to be counted as a line.

 kernel/printk/printk_ringbuffer.c | 72 +++++++++++++++----------------
 kernel/printk/printk_ringbuffer.h | 15 ++++---
 2 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 7355ca99e852..0659b50872b5 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -264,6 +264,9 @@
 /* Determine how many times the data array has wrapped. */
 #define DATA_WRAPS(data_ring, lpos)	((lpos) >> (data_ring)->size_bits)
 
+/* Determine if a logical position refers to a data-less block. */
+#define LPOS_DATALESS(lpos)		((lpos) & 1UL)
+
 /* Get the logical position at index 0 of the current wrap. */
 #define DATA_THIS_WRAP_START_LPOS(data_ring, lpos) \
 ((lpos) & ~DATA_SIZE_MASK(data_ring))
@@ -320,21 +323,13 @@ static unsigned int to_blk_size(unsigned int size)
  * block does not exceed the maximum possible size that could fit within the
  * ringbuffer. This function provides that basic size check so that the
  * assumption is safe.
- *
- * Writers are also not allowed to write 0-sized (data-less) records. Such
- * records are used only internally by the ringbuffer.
  */
 static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
 {
 	struct prb_data_block *db = NULL;
 
-	/*
-	 * Writers are not allowed to write data-less records. Such records
-	 * are used only internally by the ringbuffer to denote records where
-	 * their data failed to allocate or have been lost.
-	 */
 	if (size == 0)
-		return false;
+		return true;
 
 	/*
 	 * Ensure the alignment padded size could possibly fit in the data
@@ -568,8 +563,8 @@ static bool data_push_tail(struct printk_ringbuffer *rb,
 	unsigned long tail_lpos;
 	unsigned long next_lpos;
 
-	/* If @lpos is not valid, there is nothing to do. */
-	if (lpos == INVALID_LPOS)
+	/* If @lpos is from a data-less block, there is nothing to do. */
+	if (LPOS_DATALESS(lpos))
 		return true;
 
 	/*
@@ -962,8 +957,8 @@ static char *data_alloc(struct printk_ringbuffer *rb,
 
 	if (size == 0) {
 		/* Specify a data-less block. */
-		blk_lpos->begin = INVALID_LPOS;
-		blk_lpos->next = INVALID_LPOS;
+		blk_lpos->begin = NO_LPOS;
+		blk_lpos->next = NO_LPOS;
 		return NULL;
 	}
 
@@ -976,8 +971,8 @@ static char *data_alloc(struct printk_ringbuffer *rb,
 
 		if (!data_push_tail(rb, data_ring, next_lpos - DATA_SIZE(data_ring))) {
 			/* Failed to allocate, specify a data-less block. */
-			blk_lpos->begin = INVALID_LPOS;
-			blk_lpos->next = INVALID_LPOS;
+			blk_lpos->begin = FAILED_LPOS;
+			blk_lpos->next = FAILED_LPOS;
 			return NULL;
 		}
 
@@ -1025,6 +1020,10 @@ static char *data_alloc(struct printk_ringbuffer *rb,
 static unsigned int space_used(struct prb_data_ring *data_ring,
 			       struct prb_data_blk_lpos *blk_lpos)
 {
+	/* Data-less blocks take no space. */
+	if (LPOS_DATALESS(blk_lpos->begin))
+		return 0;
+
 	if (DATA_WRAPS(data_ring, blk_lpos->begin) == DATA_WRAPS(data_ring, blk_lpos->next)) {
 		/* Data block does not wrap. */
 		return (DATA_INDEX(data_ring, blk_lpos->next) -
@@ -1080,11 +1079,8 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 	if (!data_check_size(&rb->text_data_ring, r->text_buf_size))
 		goto fail;
 
-	/* Records are allowed to not have dictionaries. */
-	if (r->dict_buf_size) {
-		if (!data_check_size(&rb->dict_data_ring, r->dict_buf_size))
-			goto fail;
-	}
+	if (!data_check_size(&rb->dict_data_ring, r->dict_buf_size))
+		goto fail;
 
 	/*
 	 * Descriptors in the reserved state act as blockers to all further
@@ -1205,15 +1201,18 @@ void prb_commit(struct prb_reserved_entry *e)
  * values to possibly detect bugs in the writer code. A WARN_ON_ONCE() is
  * triggered if an internal error is detected.
  */
-static char *get_data(struct prb_data_ring *data_ring,
-		      struct prb_data_blk_lpos *blk_lpos,
-		      unsigned int *data_size)
+static const char *get_data(struct prb_data_ring *data_ring,
+			    struct prb_data_blk_lpos *blk_lpos,
+			    unsigned int *data_size)
 {
 	struct prb_data_block *db;
 
 	/* Data-less data block description. */
-	if (blk_lpos->begin == INVALID_LPOS &&
-	    blk_lpos->next == INVALID_LPOS) {
+	if (LPOS_DATALESS(blk_lpos->begin) && LPOS_DATALESS(blk_lpos->next)) {
+		if (blk_lpos->begin == NO_LPOS && blk_lpos->next == NO_LPOS) {
+			*data_size = 0;
+			return "";
+		}
 		return NULL;
 	}
 
@@ -1256,11 +1255,11 @@ static char *get_data(struct prb_data_ring *data_ring,
  * (even if @text_size is 0). Each '\n' processed is counted as an additional
  * line.
  */
-static unsigned int count_lines(char *text, unsigned int text_size)
+static unsigned int count_lines(const char *text, unsigned int text_size)
 {
 	unsigned int next_size = text_size;
 	unsigned int line_count = 1;
-	char *next = text;
+	const char *next = text;
 
 	while (next_size) {
 		next = memchr(next, '\n', next_size);
@@ -1287,7 +1286,7 @@ static bool copy_data(struct prb_data_ring *data_ring,
 		      unsigned int buf_size, unsigned int *line_count)
 {
 	unsigned int data_size;
-	char *data;
+	const char *data;
 
 	/* Caller might not want any data. */
 	if ((!buf || !buf_size) && !line_count)
@@ -1317,8 +1316,7 @@ static bool copy_data(struct prb_data_ring *data_ring,
 
 	data_size = min_t(u16, buf_size, len);
 
-	if (!WARN_ON_ONCE(!data_size))
-		memcpy(&buf[0], data, data_size); /* LMM(copy_data:A) */
+	memcpy(&buf[0], data, data_size); /* LMM(copy_data:A) */
 	return true;
 }
 
@@ -1355,11 +1353,11 @@ static int desc_read_committed_seq(struct prb_desc_ring *desc_ring,
 
 	/*
 	 * A descriptor in the reusable state may no longer have its data
-	 * available; report it as a data-less record. Or the record may
-	 * actually be a data-less record.
+	 * available; report it as existing but with lost data. Or the record
+	 * may actually be a record with lost data.
 	 */
 	if (d_state == desc_reusable ||
-	    (blk_lpos->begin == INVALID_LPOS && blk_lpos->next == INVALID_LPOS)) {
+	    (blk_lpos->begin == FAILED_LPOS && blk_lpos->next == FAILED_LPOS)) {
 		return -ENOENT;
 	}
 
@@ -1659,10 +1657,10 @@ void prb_init(struct printk_ringbuffer *rb,
 
 	descs[_DESCS_COUNT(descbits) - 1].info.seq = 0;
 	atomic_long_set(&(descs[_DESCS_COUNT(descbits) - 1].state_var), DESC0_SV(descbits));
-	descs[_DESCS_COUNT(descbits) - 1].text_blk_lpos.begin = INVALID_LPOS;
-	descs[_DESCS_COUNT(descbits) - 1].text_blk_lpos.next = INVALID_LPOS;
-	descs[_DESCS_COUNT(descbits) - 1].dict_blk_lpos.begin = INVALID_LPOS;
-	descs[_DESCS_COUNT(descbits) - 1].dict_blk_lpos.next = INVALID_LPOS;
+	descs[_DESCS_COUNT(descbits) - 1].text_blk_lpos.begin = FAILED_LPOS;
+	descs[_DESCS_COUNT(descbits) - 1].text_blk_lpos.next = FAILED_LPOS;
+	descs[_DESCS_COUNT(descbits) - 1].dict_blk_lpos.begin = FAILED_LPOS;
+	descs[_DESCS_COUNT(descbits) - 1].dict_blk_lpos.next = FAILED_LPOS;
 }
 
 /**
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 3e46a7423c13..e6302da041f9 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -120,12 +120,13 @@ struct prb_reserved_entry {
 #define DESC_FLAGS_MASK			(DESC_COMMITTED_MASK | DESC_REUSE_MASK)
 #define DESC_ID_MASK			(~DESC_FLAGS_MASK)
 #define DESC_ID(sv)			((sv) & DESC_ID_MASK)
-#define INVALID_LPOS			1
+#define FAILED_LPOS			0x1
+#define NO_LPOS				0x3
 
-#define INVALID_BLK_LPOS	\
+#define FAILED_BLK_LPOS	\
 {				\
-	.begin	= INVALID_LPOS,	\
-	.next	= INVALID_LPOS,	\
+	.begin	= FAILED_LPOS,	\
+	.next	= FAILED_LPOS,	\
 }
 
 /*
@@ -147,7 +148,7 @@ struct prb_reserved_entry {
  *
  * To satisfy Req1, the tail initially points to a descriptor that is
  * minimally initialized (having no data block, i.e. data-less with the
- * data block's lpos @begin and @next values set to INVALID_LPOS).
+ * data block's lpos @begin and @next values set to FAILED_LPOS).
  *
  * To satisfy Req2, the initial tail descriptor is initialized to the
  * reusable state. Readers recognize reusable descriptors as existing
@@ -242,8 +243,8 @@ static struct prb_desc _##name##_descs[_DESCS_COUNT(descbits)] = {				\
 		/* reusable */									\
 		.state_var	= ATOMIC_INIT(DESC0_SV(descbits)),				\
 		/* no associated data block */							\
-		.text_blk_lpos	= INVALID_BLK_LPOS,						\
-		.dict_blk_lpos	= INVALID_BLK_LPOS,						\
+		.text_blk_lpos	= FAILED_BLK_LPOS,						\
+		.dict_blk_lpos	= FAILED_BLK_LPOS,						\
 	},											\
 };												\
 static struct printk_ringbuffer name = {							\
-- 
2.20.1

