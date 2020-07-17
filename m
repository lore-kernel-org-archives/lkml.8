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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9346C43457
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3BED20717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k3S67j97";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/8xQm90v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgGQXtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbgGQXs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:48:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86C7C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 16:48:57 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595029736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Plbo9LaRbyku+El1tLoXbayi1FbSNnlyBnfWLnbFK/I=;
        b=k3S67j97qA7w6MxdMFlo79atnRvTgVAyY49GP6L+Lo/iq9XtmXHhWLnFXcR7liL3E2ah/Q
        IfdNppwQIubbnxxJEm7q0rMVUEDhjphC45mm4ADM4BMy2kASPCUeo2h51hPs6JiwJtc3Ez
        pcdcUmGOcVA2n8lNvVXki4y4M970syoRQ/LLkpLkcWoZA4LlXIJCdzeI+T6w08B8p/AyR0
        UPdY002nC2/dtTM0dcg75jwxJPxUp6dSB7LVCrwjJEqH6U7Lq0SLXYP6bVZeFgZcN7WtlI
        g5HaSOEtoPPU2bHbE9dSyCAPMF3PTdmmnQ0L7CjG/Y7MXc5/4xlhUrLoHvUD4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595029736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Plbo9LaRbyku+El1tLoXbayi1FbSNnlyBnfWLnbFK/I=;
        b=/8xQm90vzItLZNEtVwUQjYilGlWioJRf0uBh+zT7KOWmOjZTQ8b6UebrdJyGlzs2m3PDrO
        Qz3aaObCIGMPBqDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] printk: process cont records during reading
Date:   Sat, 18 Jul 2020 01:54:17 +0206
Message-Id: <20200717234818.8622-4-john.ogness@linutronix.de>
In-Reply-To: <20200717234818.8622-1-john.ogness@linutronix.de>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Readers of the printk ringbuffer can use the continuous line interface
to read full lines. The interface buffers continuous line parts until
the full line is available or that line was interrupted by a writer
from another context.

The continuous line interface automatically throws out partial lines if
a reader jumps to older sequence numbers. If a reader jumps to higher
sequence numbers, any cached partial lines are flushed.

The continuous line interface is used by:

  - console printing
  - syslog
  - devkmsg

devkmsg has the additional requirement that it must show a line for
every sequence number if the corresponding continuous line record was
not dropped. The continuous line interface supports this by allowing
the reader to provide a printk_record struct that will be filled in
with placeholder information (but no text) in case a full line is not
yet available.

Note that kmsg_dump does not use the continuous line interface.

The continuous line interface discards dictionaries of continuous lines.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 455 +++++++++++++++++++++++++++++++++--------
 1 file changed, 371 insertions(+), 84 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c4274c867771..363ef290f313 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -657,6 +657,287 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 	return p - buf;
 }
 
+/*
+ * Readers of the printk ringbuffer can use the continuous line interface
+ * to read full lines. The interface buffers continuous line parts until
+ * the full line is available or that line was interrupted by a writer
+ * from another context.
+ *
+ * The continuous line interface automatically throws out partial lines if a
+ * reader jumps to older sequence numbers. If a reader jumps to higher
+ * sequence numbers, any cached partial lines are flushed.
+ *
+ * The continuous line interface is used by:
+ *
+ *   - console printing
+ *   - syslog
+ *   - devkmsg
+ *
+ * devkmsg has the additional requirement that it must show a line for every
+ * sequence number if the corresponding continuous line record was not dropped.
+ * The continuous line interface supports this by allowing the reader to
+ * provide a printk_record struct that will be filled in with placeholder
+ * information (but no text) in case a full line is not yet available.
+ *
+ * Note that kmsg_dump does not use the continuous line interface.
+ *
+ * The continuous line interface discards dictionaries of continuous lines.
+ */
+
+struct cont_record {
+	struct printk_record	r;
+	struct printk_info	info;
+	char			text[LOG_LINE_MAX + PREFIX_MAX];
+	bool			set;
+};
+
+/*
+ * The continuous line buffer manager.
+ *
+ * @cr:        record buffers for reading and caching continuous lines
+ * @dict:      the dictionary used when reading a record
+ * @cache_ind: index of the cache record in @cr
+ * @begin_seq: the minimal sequence number of the current continuous line
+ * @end_seq:   the maximal sequence number of the current continuous line
+ * @dropped:   count of dropped records during the current continuous line
+ */
+struct cont {
+	struct cont_record	cr[2];
+	char			dict[LOG_LINE_MAX];
+	int			cache_ind;
+	u64			begin_seq;
+	u64			end_seq;
+	unsigned long		dropped;
+};
+
+/*
+ * Initialize the continuous line manager. As an alternative, it is also
+ * acceptable if the structure is set to all zeros.
+ */
+static void cont_init(struct cont *c, u64 seq)
+{
+	c->cr[0].set = false;
+	c->cr[1].set = false;
+	c->cache_ind = 0;
+	c->begin_seq = seq;
+	c->end_seq = seq;
+	c->dropped = 0;
+}
+
+/* Get the continuous line cache, if one exists. */
+static struct printk_record *cont_cache(struct cont *c)
+{
+	struct cont_record *cr = &c->cr[c->cache_ind];
+
+	if (!cr->set)
+		return NULL;
+	return &cr->r;
+}
+
+/*
+ * Like cont_cache(), but also flushes the dropped count, clears the
+ * dictionary, and switches to the other record buffer for future caching.
+ */
+static struct printk_record *cont_flush(struct cont *c, unsigned long *dropped)
+{
+	struct cont_record *cr = &c->cr[c->cache_ind];
+
+	c->cache_ind ^= 1;
+
+	if (!cr->set)
+		return NULL;
+
+	if (dropped)
+		*dropped = c->dropped;
+	c->dropped = 0;
+
+	c->begin_seq = cr->info.seq;
+	cr->info.dict_len = 0;
+	cr->set = false;
+
+	return &cr->r;
+}
+
+/*
+ * Wrapper for prb_read_valid() that reads a new record into the
+ * non-caching record buffer.
+ */
+static struct printk_record *cont_read(struct cont *c, u64 seq)
+{
+	struct cont_record *cr = &c->cr[c->cache_ind ^ 1];
+	struct printk_record *r = &cr->r;
+
+	prb_rec_init_rd(r, &cr->info, cr->text, sizeof(cr->text),
+			c->dict, sizeof(c->dict));
+
+	if (!prb_read_valid(prb, seq, r))
+		return NULL;
+
+	cr->set = true;
+
+	/*
+	 * After a successful read, the reader is allowed to request the
+	 * next sequential record.
+	 */
+	c->end_seq = r->info->seq + 1;
+
+	return r;
+}
+
+/*
+ * Add a record to the cache. If there is no cache, @new becomes the cache.
+ * Note that @new must be a record returned by cont_read().
+ */
+static bool cont_add(struct cont *c, struct printk_record *new)
+{
+	struct printk_record *cache;
+
+	cache = cont_cache(c);
+	if (!cache) {
+		/* No cache? This record is now the cache. */
+		c->cache_ind ^= 1;
+		return true;
+	}
+
+	/*
+	 * If an earlier line was buffered, and this is a continuation
+	 * write from the same context, try to add it to the buffer.
+	 */
+
+	if (new->info->caller_id != cache->info->caller_id)
+		return false;
+
+	if (!(new->info->flags & LOG_CONT))
+		return false;
+
+	/* If the line gets too long, split it up in separate records. */
+	if (cache->info->text_len + new->info->text_len > cache->text_buf_size)
+		return false;
+
+	memcpy(cache->text_buf + cache->info->text_len,
+	       new->text_buf, new->info->text_len);
+
+	cache->info->text_len += new->info->text_len;
+
+	/*
+	 * The original flags come from the first line,
+	 * but later continuations can add a newline.
+	 */
+	if (new->info->flags & LOG_NEWLINE)
+		cache->info->flags |= LOG_NEWLINE;
+
+	/* The cache always has the sequence number of its newest part. */
+	cache->info->seq = new->info->seq;
+
+	/* Data copied, the non-cache buffer now available for reuse. */
+	container_of(new, struct cont_record, r)->set = false;
+
+	return true;
+}
+
+/*
+ * Get the next continuous full line.
+ *
+ * Optionally the reader can provide @r to be used to store placeholder
+ * information in case all read sequence numbers need to be shown. Only the
+ * meta-data of @r will be set and the fields @text_len and @dict_len will
+ * be set to 0. So @r does not require text and dictionary buffers.
+ *
+ * If @r is provided and no continuous full line is available, @r is filled
+ * and @r is returned (rather than returning an internal buffer of @c).
+ */
+static struct printk_record *next_record(struct cont *c, u64 seq,
+					 unsigned long *dropped,
+					 struct printk_record *r)
+{
+	struct printk_record *cache;
+	struct printk_record *new;
+
+	if (dropped)
+		*dropped = 0;
+
+	cache = cont_cache(c);
+
+	/*
+	 * Re-initialize @c if the reader is jumping back or forward.
+	 * For the forward case, flush any existing cache first.
+	 */
+	if (seq < c->begin_seq) {
+		cont_init(c, seq);
+	} else if (seq > c->end_seq) {
+		if (cache)
+			goto flush;
+		else
+			cont_init(c, seq);
+	}
+
+	for (;;) {
+		/* If a full line is already cached, no need to read. */
+		if (cache && (cache->info->flags & LOG_NEWLINE))
+			goto flush;
+
+		/*
+		 * The reader is not aware that some records may be cached
+		 * already. Always read the next sequential record beyond
+		 * the cache contents.
+		 */
+		seq = c->end_seq;
+
+		new = cont_read(c, seq);
+		if (!new)
+			return NULL;
+
+		if (new->info->seq > seq) {
+			/* Some records were lost. */
+			c->dropped += new->info->seq - seq;
+			if (cache)
+				goto flush;
+		}
+
+		if (r && cache) {
+			/*
+			 * The caller wants a placeholder in case there is no
+			 * full line ready. Copy the cache meta-data now in
+			 * case the current record is added to the cache.
+			 */
+			memcpy(r->info, cache->info, sizeof(*(r->info)));
+			r->info->text_len = 0;
+			r->info->dict_len = 0;
+			r->info->level = 7;
+			r->info->flags = LOG_CONT | LOG_NEWLINE;
+		}
+
+		if (!cont_add(c, new))
+			goto flush;
+
+		if (r && cache) {
+			/*
+			 * The record was added to an existing cache and the
+			 * caller wants a place holder.
+			 */
+			return r;
+		}
+
+		cache = cont_cache(c);
+	}
+flush:
+	return cont_flush(c, dropped);
+}
+
+/*
+ * A continuous line variant of prb_for_each_record().
+ *
+ * @from: The sequence number to begin with.
+ * @c:    A continuous line manager to use.
+ * @s:    A u64 to store the sequence number on each iteration.
+ * @r:    A printk_record to store the record on each iteration.
+ * @d:    The @dropped argument for next_record().
+ */
+#define cont_for_each_record(from, c, s, r, d) \
+for ((s) = from, cont_init(c, s); \
+	((r) = next_record(c, s, d, NULL)); \
+	(s) = (r)->info->seq + 1)
+
 /* /dev/kmsg - userspace message inject/listen interface */
 struct devkmsg_user {
 	u64 seq;
@@ -664,10 +945,9 @@ struct devkmsg_user {
 	struct mutex lock;
 	char buf[CONSOLE_EXT_LOG_MAX];
 
+	struct cont cont;
+	struct printk_record r;
 	struct printk_info info;
-	char text_buf[CONSOLE_EXT_LOG_MAX];
-	char dict_buf[CONSOLE_EXT_LOG_MAX];
-	struct printk_record record;
 };
 
 static __printf(3, 4) __cold
@@ -750,7 +1030,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 			    size_t count, loff_t *ppos)
 {
 	struct devkmsg_user *user = file->private_data;
-	struct printk_record *r = &user->record;
+	struct printk_record *r;
 	size_t len;
 	ssize_t ret;
 
@@ -762,7 +1042,8 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		return ret;
 
 	logbuf_lock_irq();
-	if (!prb_read_valid(prb, user->seq, r)) {
+	r = next_record(&user->cont, user->seq, NULL, &user->r);
+	if (!r) {
 		if (file->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
 			logbuf_unlock_irq();
@@ -771,7 +1052,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 
 		logbuf_unlock_irq();
 		ret = wait_event_interruptible(log_wait,
-					prb_read_valid(prb, user->seq, r));
+			(r = next_record(&user->cont, user->seq, NULL, &user->r)));
 		if (ret)
 			goto out;
 		logbuf_lock_irq();
@@ -780,6 +1061,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 	if (user->seq < prb_first_valid_seq(prb)) {
 		/* our last seen message is gone, return error and reset */
 		user->seq = prb_first_valid_seq(prb);
+		cont_init(&user->cont, user->seq);
 		ret = -EPIPE;
 		logbuf_unlock_irq();
 		goto out;
@@ -787,8 +1069,8 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 
 	len = info_print_ext_header(user->buf, sizeof(user->buf), r->info);
 	len += msg_print_ext_body(user->buf + len, sizeof(user->buf) - len,
-				  &r->dict_buf[0], r->info->dict_len,
-				  &r->text_buf[0], r->info->text_len);
+				  r->dict_buf, r->info->dict_len,
+				  r->text_buf, r->info->text_len);
 
 	user->seq = r->info->seq + 1;
 	logbuf_unlock_irq();
@@ -823,6 +1105,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 	case SEEK_SET:
 		/* the first record */
 		user->seq = prb_first_valid_seq(prb);
+		cont_init(&user->cont, user->seq);
 		break;
 	case SEEK_DATA:
 		/*
@@ -831,10 +1114,12 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 		 * changes no global state, and does not clear anything.
 		 */
 		user->seq = clear_seq;
+		cont_init(&user->cont, user->seq);
 		break;
 	case SEEK_END:
 		/* after the last record */
 		user->seq = prb_next_seq(prb);
+		cont_init(&user->cont, user->seq);
 		break;
 	default:
 		ret = -EINVAL;
@@ -891,9 +1176,8 @@ static int devkmsg_open(struct inode *inode, struct file *file)
 
 	mutex_init(&user->lock);
 
-	prb_rec_init_rd(&user->record, &user->info,
-			&user->text_buf[0], sizeof(user->text_buf),
-			&user->dict_buf[0], sizeof(user->dict_buf));
+	cont_init(&user->cont, 0);
+	prb_rec_init_rd(&user->r, &user->info, NULL, 0, NULL, 0);
 
 	logbuf_lock_irq();
 	user->seq = prb_first_valid_seq(prb);
@@ -1426,29 +1710,30 @@ static size_t get_record_print_text_size(struct printk_info *info,
 
 static int syslog_print(char __user *buf, int size)
 {
-	struct printk_info info;
-	struct printk_record r;
-	char *text;
+	struct printk_record *r;
+	struct cont *cont;
 	int len = 0;
 
-	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
-	if (!text)
+	cont = kmalloc(sizeof(*cont), GFP_KERNEL);
+	if (!cont)
 		return -ENOMEM;
 
-	prb_rec_init_rd(&r, &info, text, LOG_LINE_MAX + PREFIX_MAX, NULL, 0);
+	cont_init(cont, 0);
 
 	while (size > 0) {
+		unsigned long dropped;
 		size_t n;
 		size_t skip;
 
 		logbuf_lock_irq();
-		if (!prb_read_valid(prb, syslog_seq, &r)) {
+		r = next_record(cont, syslog_seq, &dropped, NULL);
+		if (!r) {
 			logbuf_unlock_irq();
 			break;
 		}
-		if (r.info->seq != syslog_seq) {
+
+		if (dropped) {
 			/* message is gone, move to next valid one */
-			syslog_seq = r.info->seq;
 			syslog_partial = 0;
 		}
 
@@ -1460,10 +1745,10 @@ static int syslog_print(char __user *buf, int size)
 			syslog_time = printk_time;
 
 		skip = syslog_partial;
-		n = record_print_text(&r, true, syslog_time);
+		n = record_print_text(r, true, syslog_time);
 		if (n - syslog_partial <= size) {
 			/* message fits into buffer, move forward */
-			syslog_seq = r.info->seq + 1;
+			syslog_seq = r->info->seq + 1;
 			n -= syslog_partial;
 			syslog_partial = 0;
 		} else if (!len){
@@ -1477,7 +1762,7 @@ static int syslog_print(char __user *buf, int size)
 		if (!n)
 			break;
 
-		if (copy_to_user(buf, text + skip, n)) {
+		if (copy_to_user(buf, r->text_buf + skip, n)) {
 			if (!len)
 				len = -EFAULT;
 			break;
@@ -1488,22 +1773,21 @@ static int syslog_print(char __user *buf, int size)
 		buf += n;
 	}
 
-	kfree(text);
+	kfree(cont);
 	return len;
 }
 
 static int syslog_print_all(char __user *buf, int size, bool clear)
 {
-	struct printk_info info;
-	unsigned int line_count;
-	struct printk_record r;
-	char *text;
+	struct printk_record *r;
+	struct cont *c;
 	int len = 0;
+	u64 lastseq;
 	u64 seq;
 	bool time;
 
-	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
-	if (!text)
+	c = kmalloc(sizeof(*c), GFP_KERNEL);
+	if (!c)
 		return -ENOMEM;
 
 	time = printk_time;
@@ -1512,31 +1796,31 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	 * Find first record that fits, including all following records,
 	 * into the user-provided buffer for this dump.
 	 */
-	prb_for_each_info(clear_seq, prb, seq, &info, &line_count)
-		len += get_record_print_text_size(&info, line_count, true, time);
+	cont_for_each_record(clear_seq, c, seq, r, NULL)
+		len += record_print_text(r, true, time);
 
 	/* move first record forward until length fits into the buffer */
-	prb_for_each_info(clear_seq, prb, seq, &info, &line_count) {
+	cont_for_each_record(clear_seq, c, seq, r, NULL) {
 		if (len <= size)
 			break;
-		len -= get_record_print_text_size(&info, line_count, true, time);
+		len -= record_print_text(r, true, time);
 	}
 
-	prb_rec_init_rd(&r, &info, text, LOG_LINE_MAX + PREFIX_MAX, NULL, 0);
-
+	lastseq = clear_seq;
 	len = 0;
-	prb_for_each_record(seq, prb, seq, &r) {
+	cont_for_each_record(seq, c, seq, r, NULL) {
 		int textlen;
 
-		textlen = record_print_text(&r, true, time);
+		textlen = record_print_text(r, true, time);
 
 		if (len + textlen > size) {
-			seq--;
+			seq = lastseq;
 			break;
 		}
+		lastseq = seq;
 
 		logbuf_unlock_irq();
-		if (copy_to_user(buf + len, text, textlen))
+		if (copy_to_user(buf + len, r->text_buf, textlen))
 			len = -EFAULT;
 		else
 			len += textlen;
@@ -1550,7 +1834,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 		clear_seq = seq;
 	logbuf_unlock_irq();
 
-	kfree(text);
+	kfree(c);
 	return len;
 }
 
@@ -1563,6 +1847,9 @@ static void syslog_clear(void)
 
 int do_syslog(int type, char __user *buf, int len, int source)
 {
+	struct printk_record *r;
+	struct cont *c;
+	u64 seq;
 	bool clear = false;
 	static int saved_console_loglevel = LOGLEVEL_DEFAULT;
 	int error;
@@ -1632,6 +1919,11 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		break;
 	/* Number of chars in the log buffer */
 	case SYSLOG_ACTION_SIZE_UNREAD:
+		c = kmalloc(sizeof(*c), GFP_KERNEL);
+		if (!c) {
+			error = -ENOMEM;
+			break;
+		}
 		logbuf_lock_irq();
 		if (syslog_seq < prb_first_valid_seq(prb)) {
 			/* messages are gone, move to first one */
@@ -1640,26 +1932,27 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		}
 		if (source == SYSLOG_FROM_PROC) {
 			/*
-			 * Short-cut for poll(/"proc/kmsg") which simply checks
-			 * for pending data, not the size; return the count of
-			 * records, not the length.
+			 * Short-cut for poll("/proc/kmsg") which simply checks
+			 * for pending data, not the size.
 			 */
-			error = prb_next_seq(prb) - syslog_seq;
+			cont_init(c, syslog_seq);
+			error = !!next_record(c, syslog_seq, NULL, NULL);
 		} else {
 			bool time = syslog_partial ? syslog_time : printk_time;
-			struct printk_info info;
-			unsigned int line_count;
-			u64 seq;
-
-			prb_for_each_info(syslog_seq, prb, seq, &info,
-					  &line_count) {
-				error += get_record_print_text_size(&info, line_count,
-								    true, time);
+			bool use_partial = true;
+			unsigned long dropped;
+
+			cont_for_each_record(syslog_seq, c, seq, r, &dropped) {
+				error += record_print_text(r, true, time);
 				time = printk_time;
+				if (dropped)
+					use_partial = false;
 			}
-			error -= syslog_partial;
+			if (use_partial)
+				error -= syslog_partial;
 		}
 		logbuf_unlock_irq();
+		kfree(c);
 		break;
 	/* Size of the log buffer */
 	case SYSLOG_ACTION_SIZE_BUFFER:
@@ -2335,20 +2628,17 @@ static inline int can_use_console(void)
 void console_unlock(void)
 {
 	static char ext_text[CONSOLE_EXT_LOG_MAX];
-	static char text[LOG_LINE_MAX + PREFIX_MAX];
-	static char dict[LOG_LINE_MAX];
-	unsigned long flags;
 	bool do_cond_resched, retry;
-	struct printk_info info;
-	struct printk_record r;
+	struct printk_record *r;
+	static struct cont cont;
+	unsigned long dropped;
+	unsigned long flags;
 
 	if (console_suspended) {
 		up_console_sem();
 		return;
 	}
 
-	prb_rec_init_rd(&r, &info, text, sizeof(text), dict, sizeof(dict));
-
 	/*
 	 * Console drivers are called with interrupts disabled, so
 	 * @console_may_schedule should be cleared before; however, we may
@@ -2385,30 +2675,28 @@ void console_unlock(void)
 		printk_safe_enter_irqsave(flags);
 		raw_spin_lock(&logbuf_lock);
 skip:
-		if (!prb_read_valid(prb, console_seq, &r))
+		r = next_record(&cont, console_seq, &dropped, NULL);
+		if (!r)
 			break;
 
-		if (console_seq != r.info->seq) {
-			console_dropped += r.info->seq - console_seq;
-			console_seq = r.info->seq;
+		/* Output to all consoles once old messages replayed. */
+		if (unlikely(exclusive_console &&
+			     r->info->seq >= exclusive_console_stop_seq)) {
+			exclusive_console = NULL;
 		}
 
-		if (suppress_message_printing(r.info->level)) {
+		console_dropped += dropped;
+		console_seq = r->info->seq + 1;
+
+		if (suppress_message_printing(r->info->level)) {
 			/*
 			 * Skip record we have buffered and already printed
 			 * directly to the console when we received it, and
 			 * record that has level above the console loglevel.
 			 */
-			console_seq++;
 			goto skip;
 		}
 
-		/* Output to all consoles once old messages replayed. */
-		if (unlikely(exclusive_console &&
-			     console_seq >= exclusive_console_stop_seq)) {
-			exclusive_console = NULL;
-		}
-
 		/*
 		 * Handle extended console text first because later
 		 * record_print_text() will modify the record buffer in-place.
@@ -2416,18 +2704,17 @@ void console_unlock(void)
 		if (nr_ext_console_drivers) {
 			ext_len = info_print_ext_header(ext_text,
 						sizeof(ext_text),
-						r.info);
+						r->info);
 			ext_len += msg_print_ext_body(ext_text + ext_len,
 						sizeof(ext_text) - ext_len,
-						&r.dict_buf[0],
-						r.info->dict_len,
-						&r.text_buf[0],
-						r.info->text_len);
+						r->dict_buf,
+						r->info->dict_len,
+						r->text_buf,
+						r->info->text_len);
 		}
-		len = record_print_text(&r,
-				console_msg_format & MSG_FORMAT_SYSLOG,
-				printk_time);
-		console_seq++;
+		len = record_print_text(r,
+					console_msg_format & MSG_FORMAT_SYSLOG,
+					printk_time);
 		raw_spin_unlock(&logbuf_lock);
 
 		/*
@@ -2439,7 +2726,7 @@ void console_unlock(void)
 		console_lock_spinning_enable();
 
 		stop_critical_timings();	/* don't trace print latency */
-		call_console_drivers(ext_text, ext_len, text, len);
+		call_console_drivers(ext_text, ext_len, r->text_buf, len);
 		start_critical_timings();
 
 		if (console_lock_spinning_disable_and_check()) {
@@ -2466,7 +2753,7 @@ void console_unlock(void)
 	 * flush, no worries.
 	 */
 	raw_spin_lock(&logbuf_lock);
-	retry = prb_read_valid(prb, console_seq, NULL);
+	retry = next_record(&cont, console_seq, NULL, NULL);
 	raw_spin_unlock(&logbuf_lock);
 	printk_safe_exit_irqrestore(flags);
 
-- 
2.20.1

