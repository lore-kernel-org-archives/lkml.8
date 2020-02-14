Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75D0C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A22222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388086AbgBNP5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:57:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:40048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387945AbgBNP4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:56:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 96C03ADF1;
        Fri, 14 Feb 2020 15:56:40 +0000 (UTC)
Date:   Fri, 14 Feb 2020 16:56:39 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        lijiang <lijiang@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] printk: replace ringbuffer
Message-ID: <20200214155639.m5yp3rd2t3vdzfj7@pathway.suse.cz>
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <dc4ca9b5-d2a2-03af-c186-204a3aad2399@redhat.com>
 <20200205044848.GH41358@google.com>
 <20200205050204.GI41358@google.com>
 <88827ae2-7af5-347b-29fb-cffb94350f8f@redhat.com>
 <20200205063640.GJ41358@google.com>
 <877e11h0ir.fsf@linutronix.de>
 <20200205110522.GA456@jagdpanzerIV.localdomain>
 <87wo919grz.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo919grz.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-02-05 16:48:32, John Ogness wrote:
> On 2020-02-05, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> > 3BUG: KASAN: wild-memory-access in copy_data+0x129/0x220>
> > 3Write of size 4 at addr 5a5a5a5a5a5a5a5a by task cat/474>
> 
> The problem was due to an uninitialized pointer.
> 
> Very recently the ringbuffer API was expanded so that it could
> optionally count lines in a record. This made it possible for me to
> implement record_print_text_inline(), which can do all the kmsg_dump
> multi-line madness without requiring a temporary buffer. Rather than
> passing an extra argument around for the optional line count, I added
> the text_line_count pointer to the printk_record struct. And since line
> counting is rarely needed, it is only performed if text_line_count is
> non-NULL.
> 
> I oversaw that devkmsg_open() setup a printk_record and so I did not see
> to add the extra NULL initialization of text_line_count. There should be
> be an initializer function/macro to avoid this danger.
> 
> John Ogness
> 
> The quick fixup:
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index d0d24ee1d1f4..5ad67ff60cd9 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -883,6 +883,7 @@ static int devkmsg_open(struct inode *inode, struct file *file)
>  	user->record.text_buf_size = sizeof(user->text_buf);
>  	user->record.dict_buf = &user->dict_buf[0];
>  	user->record.dict_buf_size = sizeof(user->dict_buf);
> +	user->record.text_line_count = NULL;

The NULL pointer hidden in the structure also complicates the code
reading. It is less obvious when the same function is called
only to get the size/count and when real data.

I played with it and created extra function to get this information.

In addition, I had problems to follow the code in
record_print_text_inline(). So I tried to reuse the new function
and the existing record_printk_text() there.

Please, find below a patch that I ended with. I booted a system
with this patch. But I guess that I actually did not use the
record_print_text_inline(). So, it might be buggy.

Anyway, I wonder what you think about it:

From 383e608f41a2f44898e4cd0751c5ccc18c82f71e Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Fri, 14 Feb 2020 16:14:18 +0100
Subject: [PATCH] printk: Alternative approach for inline dumping

line_count in struct printk_record looks a bit error prone. It causes
a system crash when people forget to initialize it. It seems better
to read this information via a separate API, for example,
prg_read_valid_info().

record_print_text_inline() is really complicated[*]. It is yet
another variant of the tricky logic used in record_print_text().
It would be great to actually reuse the existing function.

[*] I know that you created it on my request.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c            | 134 +++++++++++++-------------------------
 kernel/printk/printk_ringbuffer.c |  55 +++++++++-------
 kernel/printk/printk_ringbuffer.h |   7 +-
 3 files changed, 84 insertions(+), 112 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5ad67ff60cd9..6b7d6716b178 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -883,7 +883,6 @@ static int devkmsg_open(struct inode *inode, struct file *file)
 	user->record.text_buf_size = sizeof(user->text_buf);
 	user->record.dict_buf = &user->dict_buf[0];
 	user->record.dict_buf_size = sizeof(user->dict_buf);
-	user->record.text_line_count = NULL;
 
 	logbuf_lock_irq();
 	user->seq = prb_first_seq(prb);
@@ -1283,87 +1282,50 @@ static size_t record_print_text(const struct printk_record *r, bool syslog,
 	return len;
 }
 
-static size_t record_print_text_inline(struct printk_record *r, bool syslog,
-				       bool time)
+static size_t
+get_record_text_size(struct printk_info *info, unsigned int line_count,
+			   bool syslog, bool time)
 {
-	size_t text_len = r->info->text_len;
-	size_t buf_size = r->text_buf_size;
-	char *text = r->text_buf;
-	char prefix[PREFIX_MAX];
-	bool truncated = false;
 	size_t prefix_len;
-	size_t len = 0;
 
-	prefix_len = info_print_prefix(r->info, syslog, time, prefix);
-
-	if (!text) {
-		/* SYSLOG_ACTION_* buffer size only calculation */
-		unsigned int line_count = 1;
-
-		if (r->text_line_count)
-			line_count = *(r->text_line_count);
-		/*
-		 * Each line will be preceded with a prefix. The intermediate
-		 * newlines are already within the text, but a final trailing
-		 * newline will be added.
-		 */
-		return ((prefix_len * line_count) + r->info->text_len + 1);
-	}
+	prefix_len = info_print_prefix(info, syslog, time, NULL);
 
 	/*
-	 * Add the prefix for each line by shifting the rest of the text to
-	 * make room for the prefix. If the buffer is not large enough for all
-	 * the prefixes, then drop the trailing text and report the largest
-	 * length that includes full lines with their prefixes.
+	 * Each line will be preceded with a prefix. The intermediate
+	 * newlines are already within the text, but a final trailing
+	 * newline will be added.
 	 */
-	while (text_len) {
-		size_t line_len;
-		char *next;
-
-		next = memchr(text, '\n', text_len);
-		if (next) {
-			line_len = next - text;
-		} else {
-			/*
-			 * If the text has been truncated, assume this line
-			 * was truncated and do not include this text.
-			 */
-			if (truncated)
-				break;
-			line_len = text_len;
-		}
+	return ((prefix_len * line_count) + info->text_len + 1);
+}
 
-		/*
-		 * Is there enough buffer available to shift this line
-		 * (and add a newline at the end)?
-		 */
-		if (len + prefix_len + line_len >= buf_size)
-			break;
+static size_t record_print_text_inline(struct printk_record *r, bool syslog,
+				       bool time)
+{
+	size_t text_len = r->info->text_len;
+	size_t text_buf_size = r->text_buf_size;
+	struct printk_info *info = r->info;
+	size_t record_len;
+	char *text = r->text_buf;
+	char *text_moved;
+	unsigned int line_count;
+	size_t len = 0;
 
-		/*
-		 * Is there enough buffer available to shift all remaining
-		 * text (and add a newline at the end)?
-		 */
-		if (len + prefix_len + text_len >= buf_size) {
-			text_len = (buf_size - len) - prefix_len;
-			truncated = true;
-		}
+	if (!text)
+		return 0;
 
-		memmove(text + prefix_len, text, text_len);
-		memcpy(text, prefix, prefix_len);
+	line_count = prb_count_lines(text, text_len);
+	record_len = get_record_text_size(info, line_count, syslog, time);
 
-		text += prefix_len + line_len;
-		text_len -= line_len;
+	if (text_buf_size < record_len)
+		return 0;
 
-		if (text_len) {
-			text_len--;
-			text++;
-		} else {
-			*text = '\n';
-		}
+	/* Make space for timestamps */
+	text_moved = text + (record_len - text_len);
+	memmove(text_moved, text, text_len);
 
-		len += prefix_len + line_len + 1;
-	}
+	r->text_buf = text_moved;
+	len = record_print_text(r, syslog, time, text, text_buf_size);
+	r->text_buf = text;
 
 	return len;
 }
@@ -3167,13 +3129,15 @@ bool kmsg_dump_get_line_nolock(struct kmsg_dumper *dumper, bool syslog,
 		goto out;
 
 	/* Count text lines instead of reading text? */
-	if (!line)
-		r.text_line_count = &line_count;
-
-	if (!prb_read_valid(prb, dumper->cur_seq, &r))
-		goto out;
-
-	l = record_print_text_inline(&r, syslog, printk_time);
+	if (!line) {
+		if (!prb_read_valid_info(prb, dumper->cur_seq, &info, &line_count))
+			goto out;
+		l = get_record_text_size(&info, line_count, syslog, printk_time);
+	} else {
+		if (!prb_read_valid(prb, dumper->cur_seq, &r))
+			goto out;
+		l = record_print_text_inline(&r, syslog, printk_time);
+	}
 
 	dumper->cur_seq = r.info->seq + 1;
 	ret = true;
@@ -3241,7 +3205,8 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 	/* initially, only count text lines */
 	struct printk_record r = {
 		.info = &info,
-		.text_line_count = &line_count,
+		.text_buf = buf,
+		.text_buf_size = size,
 	};
 	unsigned long flags;
 	u64 seq;
@@ -3267,30 +3232,25 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 
 	/* calculate length of entire buffer */
 	seq = dumper->cur_seq;
-	while (prb_read_valid(prb, seq, &r)) {
+	while (prb_read_valid_info(prb, seq, &info, &line_count)) {
 		if (r.info->seq >= dumper->next_seq)
 			break;
-		l += record_print_text_inline(&r, true, time);
+		l += get_record_text_size(&info, line_count, true, time);
 		seq = r.info->seq + 1;
 	}
 
 	/* move first record forward until length fits into the buffer */
 	seq = dumper->cur_seq;
-	while (l >= size && prb_read_valid(prb, seq, &r)) {
+	while (l >= size && prb_read_valid_info(prb, seq, &info, &line_count)) {
 		if (r.info->seq >= dumper->next_seq)
 			break;
-		l -= record_print_text_inline(&r, true, time);
+		l -= get_record_text_size(&info, line_count, true, time);
 		seq = r.info->seq + 1;
 	}
 
 	/* last message in next interation */
 	next_seq = seq;
 
-	/* actually read data into the buffer now */
-	r.text_buf = buf;
-	r.text_buf_size = size;
-	r.text_line_count = NULL;
-
 	l = 0;
 	while (prb_read_valid(prb, seq, &r)) {
 		if (r.info->seq >= dumper->next_seq)
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 796257f226ee..69976a49f828 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -893,7 +893,6 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 		r->dict_buf_size = 0;
 
 	r->info = &d->info;
-	r->text_line_count = NULL;
 
 	/* Set default values for the sizes. */
 	d->info.text_len = r->text_buf_size;
@@ -1002,6 +1001,21 @@ static char *get_data(struct prb_data_ring *data_ring,
 	return &db->data[0];
 }
 
+unsigned long prb_count_lines(char *text, unsigned int text_size)
+{
+	unsigned int line_count;
+	char *next;
+
+	line_count = 1;
+	while ((next = memchr(text, '\n', text_size)) != NULL) {
+		text_size -= (next - text);
+		text = next;
+		line_count++;
+	}
+
+	return line_count;
+}
+
 /*
  * Given @blk_lpos, copy an expected @len of data into the provided buffer.
  * If @line_count is provided, count the number of lines in the data.
@@ -1034,21 +1048,8 @@ static bool copy_data(struct prb_data_ring *data_ring,
 	}
 
 	/* Caller interested in the line count? */
-	if (line_count) {
-		unsigned long next_size = data_size;
-		char *next = data;
-
-		*line_count = 0;
-
-		while (next_size) {
-			(*line_count)++;
-			next = memchr(next, '\n', next_size);
-			if (!next)
-				break;
-			next++;
-			next_size = data_size - (next - data);
-		}
-	}
+	if (line_count)
+		*line_count = prb_count_lines(data, data_size);
 
 	/* Caller interested in the data content? */
 	if (!buf || !buf_size)
@@ -1094,7 +1095,7 @@ static int desc_read_committed(struct prb_desc_ring *desc_ring,
  * See desc_read_committed() for error return values.
  */
 static int prb_read(struct printk_ringbuffer *rb, u64 seq,
-		    struct printk_record *r)
+		    struct printk_record *r, unsigned int *line_count)
 {
 	struct prb_desc_ring *desc_ring = &rb->desc_ring;
 	struct prb_desc *rdesc = to_desc(desc_ring, seq);
@@ -1121,7 +1122,7 @@ static int prb_read(struct printk_ringbuffer *rb, u64 seq,
 	/* Copy text data. If it fails, this is a data-less descriptor. */
 	if (!copy_data(&rb->text_data_ring, &desc.text_blk_lpos,
 		       desc.info.text_len, r->text_buf, r->text_buf_size,
-		       r->text_line_count)) {
+		       line_count)) {
 		return -ENOENT;
 	}
 
@@ -1212,12 +1213,12 @@ EXPORT_SYMBOL(prb_first_seq);
  * See the description of prb_read_valid() for details.
  */
 bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
-		     struct printk_record *r)
+		     struct printk_record *r, unsigned int *line_count)
 {
 	u64 tail_seq;
 	int err;
 
-	while ((err = prb_read(rb, *seq, r))) {
+	while ((err = prb_read(rb, *seq, r, line_count))) {
 		tail_seq = prb_first_seq(rb);
 
 		if (*seq < tail_seq) {
@@ -1264,10 +1265,20 @@ bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 bool prb_read_valid(struct printk_ringbuffer *rb, u64 seq,
 		    struct printk_record *r)
 {
-	return _prb_read_valid(rb, &seq, r);
+	return _prb_read_valid(rb, &seq, r, NULL);
 }
 EXPORT_SYMBOL(prb_read_valid);
 
+bool prb_read_valid_info(struct printk_ringbuffer *rb, u64 seq,
+			 struct printk_info *info, unsigned int *line_count)
+{
+	struct printk_record r = {
+		.info = info,
+	};
+
+	return _prb_read_valid(rb, &seq, &r, line_count);
+}
+
 /**
  * prb_next_seq() - Get the sequence number after the last available record.
  *
@@ -1287,7 +1298,7 @@ u64 prb_next_seq(struct printk_ringbuffer *rb)
 
 	do {
 		/* Search forward from the oldest descriptor. */
-		if (!_prb_read_valid(rb, &seq, NULL))
+		if (!_prb_read_valid(rb, &seq, NULL, NULL))
 			return seq;
 		seq++;
 	} while (seq);
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 4dc428427e7f..005b000fdb5b 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -28,8 +28,6 @@ struct printk_info {
  * the reader provides the @info, @text_buf, @dict_buf buffers. On success,
  * the struct pointed to by @info will be filled and the char arrays pointed
  * to by @text_buf and @dict_buf will be filled with text and dict data.
- * If @text_line_count is provided, the number of lines in @text_buf will
- * be counted.
  */
 struct printk_record {
 	struct printk_info	*info;
@@ -37,7 +35,6 @@ struct printk_record {
 	char			*dict_buf;
 	unsigned int		text_buf_size;
 	unsigned int		dict_buf_size;
-	unsigned int		*text_line_count;
 };
 
 /* Specifies the position/span of a data block. */
@@ -288,6 +285,8 @@ struct printk_record name = {				\
 	.dict_buf_size	= buf_size,			\
 }
 
+unsigned long prb_count_lines(char *text, unsigned int text_size);
+
 /* Writer Interface */
 
 bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
@@ -304,6 +303,8 @@ unsigned int prb_record_text_space(struct prb_reserved_entry *e);
 
 bool prb_read_valid(struct printk_ringbuffer *rb, u64 seq,
 		    struct printk_record *r);
+bool prb_read_valid_info(struct printk_ringbuffer *rb, u64 seq,
+			 struct printk_info *info, unsigned int *line_count);
 
 u64 prb_first_seq(struct printk_ringbuffer *rb);
 u64 prb_next_seq(struct printk_ringbuffer *rb);
-- 
2.16.4


