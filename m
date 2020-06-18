Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C18C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBAA020888
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbgFROt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730968AbgFROtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:49:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EF9C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:49:51 -0700 (PDT)
Received: from [5.158.153.53] (helo=g2noscherz.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jlvrC-0004Ip-8Q; Thu, 18 Jun 2020 16:49:34 +0200
From:   John Ogness <john.ogness@linutronix.de>
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
Subject: [PATCH v3 3/3] printk: use the lockless ringbuffer
Date:   Thu, 18 Jun 2020 16:55:19 +0206
Message-Id: <20200618144919.9806-4-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200618144919.9806-1-john.ogness@linutronix.de>
References: <20200618144919.9806-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the existing ringbuffer usage and implementation with
lockless ringbuffer usage. Even though the new ringbuffer does not
require locking, all existing locking is left in place. Therefore,
this change is purely replacing the underlining ringbuffer.

Changes that exist due to the ringbuffer replacement:

- The VMCOREINFO has been updated for the new structures.

- Dictionary data is now stored in a separate data buffer from the
  human-readable messages. The dictionary data buffer is set to the
  same size as the message buffer. Therefore, the total required
  memory for both dictionary and message data is
  2 * (2 ^ CONFIG_LOG_BUF_SHIFT) for the initial static buffers and
  2 * log_buf_len (the kernel parameter) for the dynamic buffers.

- Record meta-data is now stored in a separate array of descriptors.
  This is an additional 72 * (2 ^ (CONFIG_LOG_BUF_SHIFT - 5)) bytes
  for the static array and 72 * (log_buf_len >> 5) bytes for the
  dynamic array.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/kmsg_dump.h |   2 -
 kernel/printk/printk.c    | 944 ++++++++++++++++++++------------------
 2 files changed, 497 insertions(+), 449 deletions(-)

diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
index 3378bcbe585e..c9b0abe5ca91 100644
--- a/include/linux/kmsg_dump.h
+++ b/include/linux/kmsg_dump.h
@@ -45,8 +45,6 @@ struct kmsg_dumper {
 	bool registered;
 
 	/* private state of the kmsg iterator */
-	u32 cur_idx;
-	u32 next_idx;
 	u64 cur_seq;
 	u64 next_seq;
 };
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 8c14835be46c..7642ef634956 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -55,6 +55,7 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/printk.h>
 
+#include "printk_ringbuffer.h"
 #include "console_cmdline.h"
 #include "braille.h"
 #include "internal.h"
@@ -294,30 +295,24 @@ enum con_msg_format_flags {
 static int console_msg_format = MSG_FORMAT_DEFAULT;
 
 /*
- * The printk log buffer consists of a chain of concatenated variable
- * length records. Every record starts with a record header, containing
- * the overall length of the record.
+ * The printk log buffer consists of a sequenced collection of records, each
+ * containing variable length message and dictionary text. Every record
+ * also contains its own meta-data (@info).
  *
- * The heads to the first and last entry in the buffer, as well as the
- * sequence numbers of these entries are maintained when messages are
- * stored.
+ * Every record meta-data carries the timestamp in microseconds, as well as
+ * the standard userspace syslog level and syslog facility. The usual kernel
+ * messages use LOG_KERN; userspace-injected messages always carry a matching
+ * syslog facility, by default LOG_USER. The origin of every message can be
+ * reliably determined that way.
  *
- * If the heads indicate available messages, the length in the header
- * tells the start next message. A length == 0 for the next message
- * indicates a wrap-around to the beginning of the buffer.
+ * The human readable log message of a record is available in @text, the
+ * length of the message text in @text_len. The stored message is not
+ * terminated.
  *
- * Every record carries the monotonic timestamp in microseconds, as well as
- * the standard userspace syslog level and syslog facility. The usual
- * kernel messages use LOG_KERN; userspace-injected messages always carry
- * a matching syslog facility, by default LOG_USER. The origin of every
- * message can be reliably determined that way.
- *
- * The human readable log message directly follows the message header. The
- * length of the message text is stored in the header, the stored message
- * is not terminated.
- *
- * Optionally, a message can carry a dictionary of properties (key/value pairs),
- * to provide userspace with a machine-readable message context.
+ * Optionally, a record can carry a dictionary of properties (key/value
+ * pairs), to provide userspace with a machine-readable message context. The
+ * length of the dictionary is available in @dict_len. The dictionary is not
+ * terminated.
  *
  * Examples for well-defined, commonly used property names are:
  *   DEVICE=b12:8               device identifier
@@ -331,21 +326,19 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
  * follows directly after a '=' character. Every property is terminated by
  * a '\0' character. The last property is not terminated.
  *
- * Example of a message structure:
- *   0000  ff 8f 00 00 00 00 00 00      monotonic time in nsec
- *   0008  34 00                        record is 52 bytes long
- *   000a        0b 00                  text is 11 bytes long
- *   000c              1f 00            dictionary is 23 bytes long
- *   000e                    03 00      LOG_KERN (facility) LOG_ERR (level)
- *   0010  69 74 27 73 20 61 20 6c      "it's a l"
- *         69 6e 65                     "ine"
- *   001b           44 45 56 49 43      "DEVIC"
- *         45 3d 62 38 3a 32 00 44      "E=b8:2\0D"
- *         52 49 56 45 52 3d 62 75      "RIVER=bu"
- *         67                           "g"
- *   0032     00 00 00                  padding to next message header
- *
- * The 'struct printk_log' buffer header must never be directly exported to
+ * Example of record values:
+ *   record.text_buf       = "it's a line" (unterminated)
+ *   record.dict_buf       = "DEVICE=b8:2\0DRIVER=bug" (unterminated)
+ *   record.info.seq       = 56
+ *   record.info.ts_nsec   = 36863
+ *   record.info.text_len  = 11
+ *   record.info.dict_len  = 22
+ *   record.info.facility  = 0 (LOG_KERN)
+ *   record.info.flags     = 0
+ *   record.info.level     = 3 (LOG_ERR)
+ *   record.info.caller_id = 299 (task 299)
+ *
+ * The 'struct printk_info' buffer must never be directly exported to
  * userspace, it is a kernel-private implementation detail that might
  * need to be changed in the future, when the requirements change.
  *
@@ -365,23 +358,6 @@ enum log_flags {
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
 };
 
-struct printk_log {
-	u64 ts_nsec;		/* timestamp in nanoseconds */
-	u16 len;		/* length of entire record */
-	u16 text_len;		/* length of text buffer */
-	u16 dict_len;		/* length of dictionary buffer */
-	u8 facility;		/* syslog facility */
-	u8 flags:5;		/* internal record flags */
-	u8 level:3;		/* syslog level */
-#ifdef CONFIG_PRINTK_CALLER
-	u32 caller_id;            /* thread id or processor id */
-#endif
-}
-#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
-__packed __aligned(4)
-#endif
-;
-
 /*
  * The logbuf_lock protects kmsg buffer, indices, counters.  This can be taken
  * within the scheduler's rq lock. It must be released before calling
@@ -421,26 +397,16 @@ DEFINE_RAW_SPINLOCK(logbuf_lock);
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* the next printk record to read by syslog(READ) or /proc/kmsg */
 static u64 syslog_seq;
-static u32 syslog_idx;
 static size_t syslog_partial;
 static bool syslog_time;
 
-/* index and sequence number of the first record stored in the buffer */
-static u64 log_first_seq;
-static u32 log_first_idx;
-
-/* index and sequence number of the next record to store in the buffer */
-static u64 log_next_seq;
-static u32 log_next_idx;
-
 /* the next printk record to write to the console */
 static u64 console_seq;
-static u32 console_idx;
 static u64 exclusive_console_stop_seq;
+static unsigned long console_dropped;
 
 /* the next printk record to read after the last 'clear' command */
 static u64 clear_seq;
-static u32 clear_idx;
 
 #ifdef CONFIG_PRINTK_CALLER
 #define PREFIX_MAX		48
@@ -453,13 +419,28 @@ static u32 clear_idx;
 #define LOG_FACILITY(v)		((v) >> 3 & 0xff)
 
 /* record buffer */
-#define LOG_ALIGN __alignof__(struct printk_log)
+#define LOG_ALIGN __alignof__(unsigned long)
 #define __LOG_BUF_LEN (1 << CONFIG_LOG_BUF_SHIFT)
 #define LOG_BUF_LEN_MAX (u32)(1 << 31)
 static char __log_buf[__LOG_BUF_LEN] __aligned(LOG_ALIGN);
 static char *log_buf = __log_buf;
 static u32 log_buf_len = __LOG_BUF_LEN;
 
+/*
+ * Define the average message size. This only affects the number of
+ * descriptors that will be available. Underestimating is better than
+ * overestimating (too many available descriptors is better than not enough).
+ * The dictionary buffer will be the same size as the text buffer.
+ */
+#define PRB_AVGBITS 5	/* 32 character average length */
+
+_DECLARE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
+		  PRB_AVGBITS, PRB_AVGBITS, &__log_buf[0]);
+
+static struct printk_ringbuffer printk_rb_dynamic;
+
+static struct printk_ringbuffer *prb = &printk_rb_static;
+
 /*
  * We cannot access per-CPU data (e.g. per-CPU flush irq_work) before
  * per_cpu_areas are initialised. This variable is set to true when
@@ -484,108 +465,6 @@ u32 log_buf_len_get(void)
 	return log_buf_len;
 }
 
-/* human readable text of the record */
-static char *log_text(const struct printk_log *msg)
-{
-	return (char *)msg + sizeof(struct printk_log);
-}
-
-/* optional key/value pair dictionary attached to the record */
-static char *log_dict(const struct printk_log *msg)
-{
-	return (char *)msg + sizeof(struct printk_log) + msg->text_len;
-}
-
-/* get record by index; idx must point to valid msg */
-static struct printk_log *log_from_idx(u32 idx)
-{
-	struct printk_log *msg = (struct printk_log *)(log_buf + idx);
-
-	/*
-	 * A length == 0 record is the end of buffer marker. Wrap around and
-	 * read the message at the start of the buffer.
-	 */
-	if (!msg->len)
-		return (struct printk_log *)log_buf;
-	return msg;
-}
-
-/* get next record; idx must point to valid msg */
-static u32 log_next(u32 idx)
-{
-	struct printk_log *msg = (struct printk_log *)(log_buf + idx);
-
-	/* length == 0 indicates the end of the buffer; wrap */
-	/*
-	 * A length == 0 record is the end of buffer marker. Wrap around and
-	 * read the message at the start of the buffer as *this* one, and
-	 * return the one after that.
-	 */
-	if (!msg->len) {
-		msg = (struct printk_log *)log_buf;
-		return msg->len;
-	}
-	return idx + msg->len;
-}
-
-/*
- * Check whether there is enough free space for the given message.
- *
- * The same values of first_idx and next_idx mean that the buffer
- * is either empty or full.
- *
- * If the buffer is empty, we must respect the position of the indexes.
- * They cannot be reset to the beginning of the buffer.
- */
-static int logbuf_has_space(u32 msg_size, bool empty)
-{
-	u32 free;
-
-	if (log_next_idx > log_first_idx || empty)
-		free = max(log_buf_len - log_next_idx, log_first_idx);
-	else
-		free = log_first_idx - log_next_idx;
-
-	/*
-	 * We need space also for an empty header that signalizes wrapping
-	 * of the buffer.
-	 */
-	return free >= msg_size + sizeof(struct printk_log);
-}
-
-static int log_make_free_space(u32 msg_size)
-{
-	while (log_first_seq < log_next_seq &&
-	       !logbuf_has_space(msg_size, false)) {
-		/* drop old messages until we have enough contiguous space */
-		log_first_idx = log_next(log_first_idx);
-		log_first_seq++;
-	}
-
-	if (clear_seq < log_first_seq) {
-		clear_seq = log_first_seq;
-		clear_idx = log_first_idx;
-	}
-
-	/* sequence numbers are equal, so the log buffer is empty */
-	if (logbuf_has_space(msg_size, log_first_seq == log_next_seq))
-		return 0;
-
-	return -ENOMEM;
-}
-
-/* compute the message size including the padding bytes */
-static u32 msg_used_size(u16 text_len, u16 dict_len, u32 *pad_len)
-{
-	u32 size;
-
-	size = sizeof(struct printk_log) + text_len + dict_len;
-	*pad_len = (-size) & (LOG_ALIGN - 1);
-	size += *pad_len;
-
-	return size;
-}
-
 /*
  * Define how much of the log buffer we could take at maximum. The value
  * must be greater than two. Note that only half of the buffer is available
@@ -594,22 +473,26 @@ static u32 msg_used_size(u16 text_len, u16 dict_len, u32 *pad_len)
 #define MAX_LOG_TAKE_PART 4
 static const char trunc_msg[] = "<truncated>";
 
-static u32 truncate_msg(u16 *text_len, u16 *trunc_msg_len,
-			u16 *dict_len, u32 *pad_len)
+static void truncate_msg(u16 *text_len, u16 *trunc_msg_len, u16 *dict_len)
 {
 	/*
 	 * The message should not take the whole buffer. Otherwise, it might
 	 * get removed too soon.
 	 */
 	u32 max_text_len = log_buf_len / MAX_LOG_TAKE_PART;
+
 	if (*text_len > max_text_len)
 		*text_len = max_text_len;
-	/* enable the warning message */
+
+	/* enable the warning message (if there is room) */
 	*trunc_msg_len = strlen(trunc_msg);
+	if (*text_len >= *trunc_msg_len)
+		*text_len -= *trunc_msg_len;
+	else
+		*trunc_msg_len = 0;
+
 	/* disable the "dict" completely */
 	*dict_len = 0;
-	/* compute the size again, count also the warning message */
-	return msg_used_size(*text_len + *trunc_msg_len, 0, pad_len);
 }
 
 /* insert record into the buffer, discard old ones, update heads */
@@ -618,60 +501,40 @@ static int log_store(u32 caller_id, int facility, int level,
 		     const char *dict, u16 dict_len,
 		     const char *text, u16 text_len)
 {
-	struct printk_log *msg;
-	u32 size, pad_len;
+	struct prb_reserved_entry e;
+	struct printk_record r;
 	u16 trunc_msg_len = 0;
 
-	/* number of '\0' padding bytes to next message */
-	size = msg_used_size(text_len, dict_len, &pad_len);
+	prb_rec_init_wr(&r, text_len, dict_len);
 
-	if (log_make_free_space(size)) {
+	if (!prb_reserve(&e, prb, &r)) {
 		/* truncate the message if it is too long for empty buffer */
-		size = truncate_msg(&text_len, &trunc_msg_len,
-				    &dict_len, &pad_len);
+		truncate_msg(&text_len, &trunc_msg_len, &dict_len);
+		prb_rec_init_wr(&r, text_len + trunc_msg_len, dict_len);
 		/* survive when the log buffer is too small for trunc_msg */
-		if (log_make_free_space(size))
+		if (!prb_reserve(&e, prb, &r))
 			return 0;
 	}
 
-	if (log_next_idx + size + sizeof(struct printk_log) > log_buf_len) {
-		/*
-		 * This message + an additional empty header does not fit
-		 * at the end of the buffer. Add an empty header with len == 0
-		 * to signify a wrap around.
-		 */
-		memset(log_buf + log_next_idx, 0, sizeof(struct printk_log));
-		log_next_idx = 0;
-	}
-
 	/* fill message */
-	msg = (struct printk_log *)(log_buf + log_next_idx);
-	memcpy(log_text(msg), text, text_len);
-	msg->text_len = text_len;
-	if (trunc_msg_len) {
-		memcpy(log_text(msg) + text_len, trunc_msg, trunc_msg_len);
-		msg->text_len += trunc_msg_len;
-	}
-	memcpy(log_dict(msg), dict, dict_len);
-	msg->dict_len = dict_len;
-	msg->facility = facility;
-	msg->level = level & 7;
-	msg->flags = flags & 0x1f;
+	memcpy(&r.text_buf[0], text, text_len);
+	if (trunc_msg_len)
+		memcpy(&r.text_buf[text_len], trunc_msg, trunc_msg_len);
+	if (r.dict_buf)
+		memcpy(&r.dict_buf[0], dict, dict_len);
+	r.info->facility = facility;
+	r.info->level = level & 7;
+	r.info->flags = flags & 0x1f;
 	if (ts_nsec > 0)
-		msg->ts_nsec = ts_nsec;
+		r.info->ts_nsec = ts_nsec;
 	else
-		msg->ts_nsec = local_clock();
-#ifdef CONFIG_PRINTK_CALLER
-	msg->caller_id = caller_id;
-#endif
-	memset(log_dict(msg) + dict_len, 0, pad_len);
-	msg->len = size;
+		r.info->ts_nsec = local_clock();
+	r.info->caller_id = caller_id;
 
 	/* insert message */
-	log_next_idx += msg->len;
-	log_next_seq++;
+	prb_commit(&e);
 
-	return msg->text_len;
+	return (text_len + trunc_msg_len);
 }
 
 int dmesg_restrict = IS_ENABLED(CONFIG_SECURITY_DMESG_RESTRICT);
@@ -723,13 +586,13 @@ static void append_char(char **pp, char *e, char c)
 		*(*pp)++ = c;
 }
 
-static ssize_t msg_print_ext_header(char *buf, size_t size,
-				    struct printk_log *msg, u64 seq)
+static ssize_t info_print_ext_header(char *buf, size_t size,
+				     struct printk_info *info)
 {
-	u64 ts_usec = msg->ts_nsec;
+	u64 ts_usec = info->ts_nsec;
 	char caller[20];
 #ifdef CONFIG_PRINTK_CALLER
-	u32 id = msg->caller_id;
+	u32 id = info->caller_id;
 
 	snprintf(caller, sizeof(caller), ",caller=%c%u",
 		 id & 0x80000000 ? 'C' : 'T', id & ~0x80000000);
@@ -740,8 +603,8 @@ static ssize_t msg_print_ext_header(char *buf, size_t size,
 	do_div(ts_usec, 1000);
 
 	return scnprintf(buf, size, "%u,%llu,%llu,%c%s;",
-			 (msg->facility << 3) | msg->level, seq, ts_usec,
-			 msg->flags & LOG_CONT ? 'c' : '-', caller);
+			 (info->facility << 3) | info->level, info->seq,
+			 ts_usec, info->flags & LOG_CONT ? 'c' : '-', caller);
 }
 
 static ssize_t msg_print_ext_body(char *buf, size_t size,
@@ -795,10 +658,14 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 /* /dev/kmsg - userspace message inject/listen interface */
 struct devkmsg_user {
 	u64 seq;
-	u32 idx;
 	struct ratelimit_state rs;
 	struct mutex lock;
 	char buf[CONSOLE_EXT_LOG_MAX];
+
+	struct printk_info info;
+	char text_buf[CONSOLE_EXT_LOG_MAX];
+	char dict_buf[CONSOLE_EXT_LOG_MAX];
+	struct printk_record record;
 };
 
 static __printf(3, 4) __cold
@@ -881,7 +748,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 			    size_t count, loff_t *ppos)
 {
 	struct devkmsg_user *user = file->private_data;
-	struct printk_log *msg;
+	struct printk_record *r = &user->record;
 	size_t len;
 	ssize_t ret;
 
@@ -893,7 +760,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		return ret;
 
 	logbuf_lock_irq();
-	while (user->seq == log_next_seq) {
+	if (!prb_read_valid(prb, user->seq, r)) {
 		if (file->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
 			logbuf_unlock_irq();
@@ -902,30 +769,26 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 
 		logbuf_unlock_irq();
 		ret = wait_event_interruptible(log_wait,
-					       user->seq != log_next_seq);
+					prb_read_valid(prb, user->seq, r));
 		if (ret)
 			goto out;
 		logbuf_lock_irq();
 	}
 
-	if (user->seq < log_first_seq) {
+	if (user->seq < prb_first_seq(prb)) {
 		/* our last seen message is gone, return error and reset */
-		user->idx = log_first_idx;
-		user->seq = log_first_seq;
+		user->seq = prb_first_seq(prb);
 		ret = -EPIPE;
 		logbuf_unlock_irq();
 		goto out;
 	}
 
-	msg = log_from_idx(user->idx);
-	len = msg_print_ext_header(user->buf, sizeof(user->buf),
-				   msg, user->seq);
+	len = info_print_ext_header(user->buf, sizeof(user->buf), r->info);
 	len += msg_print_ext_body(user->buf + len, sizeof(user->buf) - len,
-				  log_dict(msg), msg->dict_len,
-				  log_text(msg), msg->text_len);
+				  &r->dict_buf[0], r->info->dict_len,
+				  &r->text_buf[0], r->info->text_len);
 
-	user->idx = log_next(user->idx);
-	user->seq++;
+	user->seq = r->info->seq + 1;
 	logbuf_unlock_irq();
 
 	if (len > count) {
@@ -957,8 +820,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 	switch (whence) {
 	case SEEK_SET:
 		/* the first record */
-		user->idx = log_first_idx;
-		user->seq = log_first_seq;
+		user->seq = prb_first_seq(prb);
 		break;
 	case SEEK_DATA:
 		/*
@@ -966,13 +828,11 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 		 * like issued by 'dmesg -c'. Reading /dev/kmsg itself
 		 * changes no global state, and does not clear anything.
 		 */
-		user->idx = clear_idx;
 		user->seq = clear_seq;
 		break;
 	case SEEK_END:
 		/* after the last record */
-		user->idx = log_next_idx;
-		user->seq = log_next_seq;
+		user->seq = prb_next_seq(prb);
 		break;
 	case SEEK_CUR:
 		/*
@@ -1002,9 +862,9 @@ static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
 	poll_wait(file, &log_wait, wait);
 
 	logbuf_lock_irq();
-	if (user->seq < log_next_seq) {
+	if (prb_read_valid(prb, user->seq, NULL)) {
 		/* return error when data has vanished underneath us */
-		if (user->seq < log_first_seq)
+		if (user->seq < prb_first_seq(prb))
 			ret = EPOLLIN|EPOLLRDNORM|EPOLLERR|EPOLLPRI;
 		else
 			ret = EPOLLIN|EPOLLRDNORM;
@@ -1039,9 +899,12 @@ static int devkmsg_open(struct inode *inode, struct file *file)
 
 	mutex_init(&user->lock);
 
+	prb_rec_init_rd(&user->record, &user->info,
+			&user->text_buf[0], sizeof(user->text_buf),
+			&user->dict_buf[0], sizeof(user->dict_buf));
+
 	logbuf_lock_irq();
-	user->idx = log_first_idx;
-	user->seq = log_first_seq;
+	user->seq = prb_first_seq(prb);
 	logbuf_unlock_irq();
 
 	file->private_data = user;
@@ -1082,23 +945,52 @@ const struct file_operations kmsg_fops = {
  */
 void log_buf_vmcoreinfo_setup(void)
 {
-	VMCOREINFO_SYMBOL(log_buf);
-	VMCOREINFO_SYMBOL(log_buf_len);
-	VMCOREINFO_SYMBOL(log_first_idx);
-	VMCOREINFO_SYMBOL(clear_idx);
-	VMCOREINFO_SYMBOL(log_next_idx);
+	VMCOREINFO_SYMBOL(prb);
+	VMCOREINFO_SYMBOL(printk_rb_static);
+	VMCOREINFO_SYMBOL(clear_seq);
+
 	/*
-	 * Export struct printk_log size and field offsets. User space tools can
+	 * Export struct size and field offsets. User space tools can
 	 * parse it and detect any changes to structure down the line.
 	 */
-	VMCOREINFO_STRUCT_SIZE(printk_log);
-	VMCOREINFO_OFFSET(printk_log, ts_nsec);
-	VMCOREINFO_OFFSET(printk_log, len);
-	VMCOREINFO_OFFSET(printk_log, text_len);
-	VMCOREINFO_OFFSET(printk_log, dict_len);
-#ifdef CONFIG_PRINTK_CALLER
-	VMCOREINFO_OFFSET(printk_log, caller_id);
-#endif
+
+	VMCOREINFO_STRUCT_SIZE(printk_ringbuffer);
+	VMCOREINFO_OFFSET(printk_ringbuffer, desc_ring);
+	VMCOREINFO_OFFSET(printk_ringbuffer, text_data_ring);
+	VMCOREINFO_OFFSET(printk_ringbuffer, dict_data_ring);
+	VMCOREINFO_OFFSET(printk_ringbuffer, fail);
+
+	VMCOREINFO_STRUCT_SIZE(prb_desc_ring);
+	VMCOREINFO_OFFSET(prb_desc_ring, count_bits);
+	VMCOREINFO_OFFSET(prb_desc_ring, descs);
+	VMCOREINFO_OFFSET(prb_desc_ring, head_id);
+	VMCOREINFO_OFFSET(prb_desc_ring, tail_id);
+
+	VMCOREINFO_STRUCT_SIZE(prb_desc);
+	VMCOREINFO_OFFSET(prb_desc, info);
+	VMCOREINFO_OFFSET(prb_desc, state_var);
+	VMCOREINFO_OFFSET(prb_desc, text_blk_lpos);
+	VMCOREINFO_OFFSET(prb_desc, dict_blk_lpos);
+
+	VMCOREINFO_STRUCT_SIZE(prb_data_blk_lpos);
+	VMCOREINFO_OFFSET(prb_data_blk_lpos, begin);
+	VMCOREINFO_OFFSET(prb_data_blk_lpos, next);
+
+	VMCOREINFO_STRUCT_SIZE(printk_info);
+	VMCOREINFO_OFFSET(printk_info, seq);
+	VMCOREINFO_OFFSET(printk_info, ts_nsec);
+	VMCOREINFO_OFFSET(printk_info, text_len);
+	VMCOREINFO_OFFSET(printk_info, dict_len);
+	VMCOREINFO_OFFSET(printk_info, caller_id);
+
+	VMCOREINFO_STRUCT_SIZE(prb_data_ring);
+	VMCOREINFO_OFFSET(prb_data_ring, size_bits);
+	VMCOREINFO_OFFSET(prb_data_ring, data);
+	VMCOREINFO_OFFSET(prb_data_ring, head_lpos);
+	VMCOREINFO_OFFSET(prb_data_ring, tail_lpos);
+
+	VMCOREINFO_SIZE(atomic_long_t);
+	VMCOREINFO_TYPE_OFFSET(atomic_long_t, counter);
 }
 #endif
 
@@ -1176,11 +1068,46 @@ static void __init set_percpu_data_ready(void)
 	__printk_percpu_data_ready = true;
 }
 
+static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
+				     struct printk_record *r)
+{
+	struct prb_reserved_entry e;
+	struct printk_record dest_r;
+
+	prb_rec_init_wr(&dest_r, r->info->text_len, r->info->dict_len);
+
+	if (!prb_reserve(&e, rb, &dest_r))
+		return 0;
+
+	memcpy(&dest_r.text_buf[0], &r->text_buf[0], dest_r.text_buf_size);
+	if (dest_r.dict_buf) {
+		memcpy(&dest_r.dict_buf[0], &r->dict_buf[0],
+		       dest_r.dict_buf_size);
+	}
+	dest_r.info->facility = r->info->facility;
+	dest_r.info->level = r->info->level;
+	dest_r.info->flags = r->info->flags;
+	dest_r.info->ts_nsec = r->info->ts_nsec;
+	dest_r.info->caller_id = r->info->caller_id;
+
+	prb_commit(&e);
+
+	return prb_record_text_space(&e);
+}
+
+static char setup_text_buf[CONSOLE_EXT_LOG_MAX] __initdata;
+static char setup_dict_buf[CONSOLE_EXT_LOG_MAX] __initdata;
+
 void __init setup_log_buf(int early)
 {
+	struct prb_desc *new_descs;
+	struct printk_info info;
+	struct printk_record r;
 	unsigned long flags;
+	char *new_dict_buf;
 	char *new_log_buf;
 	unsigned int free;
+	u64 seq;
 
 	/*
 	 * Some archs call setup_log_buf() multiple times - first is very
@@ -1201,17 +1128,50 @@ void __init setup_log_buf(int early)
 
 	new_log_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);
 	if (unlikely(!new_log_buf)) {
-		pr_err("log_buf_len: %lu bytes not available\n",
+		pr_err("log_buf_len: %lu text bytes not available\n",
 			new_log_buf_len);
 		return;
 	}
 
+	new_dict_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);
+	if (unlikely(!new_dict_buf)) {
+		/* dictionary failure is allowed */
+		pr_err("log_buf_len: %lu dict bytes not available\n",
+			new_log_buf_len);
+	}
+
+	new_descs = memblock_alloc((new_log_buf_len >> PRB_AVGBITS) *
+				   sizeof(struct prb_desc), LOG_ALIGN);
+	if (unlikely(!new_descs)) {
+		pr_err("log_buf_len: %lu desc bytes not available\n",
+			new_log_buf_len >> PRB_AVGBITS);
+		if (new_dict_buf)
+			memblock_free(__pa(new_dict_buf), new_log_buf_len);
+		memblock_free(__pa(new_log_buf), new_log_buf_len);
+		return;
+	}
+
+	prb_rec_init_rd(&r, &info,
+			&setup_text_buf[0], sizeof(setup_text_buf),
+			&setup_dict_buf[0], sizeof(setup_dict_buf));
+
 	logbuf_lock_irqsave(flags);
+
+	prb_init(&printk_rb_dynamic,
+		 new_log_buf, bits_per(new_log_buf_len) - 1,
+		 new_dict_buf, bits_per(new_log_buf_len) - 1,
+		 new_descs, (bits_per(new_log_buf_len) - 1) - PRB_AVGBITS);
+
 	log_buf_len = new_log_buf_len;
 	log_buf = new_log_buf;
 	new_log_buf_len = 0;
-	free = __LOG_BUF_LEN - log_next_idx;
-	memcpy(log_buf, __log_buf, __LOG_BUF_LEN);
+
+	free = __LOG_BUF_LEN;
+	prb_for_each_record(0, &printk_rb_static, seq, &r)
+		free -= add_to_rb(&printk_rb_dynamic, &r);
+
+	prb = &printk_rb_dynamic;
+
 	logbuf_unlock_irqrestore(flags);
 
 	pr_info("log_buf_len: %u bytes\n", log_buf_len);
@@ -1323,18 +1283,18 @@ static size_t print_caller(u32 id, char *buf)
 #define print_caller(id, buf) 0
 #endif
 
-static size_t print_prefix(const struct printk_log *msg, bool syslog,
-			   bool time, char *buf)
+static size_t info_print_prefix(const struct printk_info  *info, bool syslog,
+				bool time, char *buf)
 {
 	size_t len = 0;
 
 	if (syslog)
-		len = print_syslog((msg->facility << 3) | msg->level, buf);
+		len = print_syslog((info->facility << 3) | info->level, buf);
 
 	if (time)
-		len += print_time(msg->ts_nsec, buf + len);
+		len += print_time(info->ts_nsec, buf + len);
 
-	len += print_caller(msg->caller_id, buf + len);
+	len += print_caller(info->caller_id, buf + len);
 
 	if (IS_ENABLED(CONFIG_PRINTK_CALLER) || time) {
 		buf[len++] = ' ';
@@ -1344,72 +1304,150 @@ static size_t print_prefix(const struct printk_log *msg, bool syslog,
 	return len;
 }
 
-static size_t msg_print_text(const struct printk_log *msg, bool syslog,
-			     bool time, char *buf, size_t size)
+static size_t record_print_text(struct printk_record *r, bool syslog,
+				bool time)
 {
-	const char *text = log_text(msg);
-	size_t text_size = msg->text_len;
-	size_t len = 0;
+	size_t text_len = r->info->text_len;
+	size_t buf_size = r->text_buf_size;
+	char *text = r->text_buf;
 	char prefix[PREFIX_MAX];
-	const size_t prefix_len = print_prefix(msg, syslog, time, prefix);
+	bool truncated = false;
+	size_t prefix_len;
+	size_t line_len;
+	size_t len = 0;
+	char *next;
 
-	do {
-		const char *next = memchr(text, '\n', text_size);
-		size_t text_len;
+	prefix_len = info_print_prefix(r->info, syslog, time, prefix);
 
+	/*
+	 * Add the prefix for each line by shifting the rest of the text to
+	 * make room for each prefix. If the buffer is not large enough for
+	 * all the prefixes, then drop the trailing text and report the
+	 * largest length that includes full lines with their prefixes.
+	 *
+	 * @text_len: bytes of unprocessed text
+	 * @line_len: bytes of current line (newline _not_ included)
+	 * @text:     pointer to beginning of current line
+	 * @len:      number of bytes processed (size of r->text_buf done)
+	 */
+	for (;;) {
+		next = memchr(text, '\n', text_len);
 		if (next) {
-			text_len = next - text;
-			next++;
-			text_size -= next - text;
+			line_len = next - text;
 		} else {
-			text_len = text_size;
+			/*
+			 * No newline. If the text was previously truncated,
+			 * assume this line was truncated and do not include
+			 * it.
+			 */
+			if (truncated)
+				break;
+			line_len = text_len;
 		}
 
-		if (buf) {
-			if (prefix_len + text_len + 1 >= size - len)
+		/*
+		 * Ensure there is enough buffer available to shift this line
+		 * (and add a newline at the end).
+		 */
+		if (len + prefix_len + line_len + 1 > buf_size)
+			break;
+
+		/*
+		 * Ensure there is enough buffer available to shift all
+		 * remaining text (and add a newline at the end). If this
+		 * test fails, then there must be a newline (i.e.
+		 * text_len > line_len because the previous test succeeded).
+		 */
+		if (len + prefix_len + text_len + 1 > buf_size) {
+			/*
+			 * Truncate @text_len so that there is enough space
+			 * for a prefix. A newline will not be added because
+			 * the last line of the text is now truncated and
+			 * will not be included.
+			 */
+			text_len = (buf_size - len) - prefix_len;
+
+			/*
+			 * Ensure there is still a newline. Otherwise this
+			 * line may have been truncated and will not be
+			 * included.
+			 */
+			if (memchr(text, '\n', text_len) == NULL)
 				break;
 
-			memcpy(buf + len, prefix, prefix_len);
-			len += prefix_len;
-			memcpy(buf + len, text, text_len);
-			len += text_len;
-			buf[len++] = '\n';
-		} else {
-			/* SYSLOG_ACTION_* buffer size only calculation */
-			len += prefix_len + text_len + 1;
+			/* Note that the last line will not be included. */
+			truncated = true;
 		}
 
-		text = next;
-	} while (text);
+		memmove(text + prefix_len, text, text_len);
+		memcpy(text, prefix, prefix_len);
+
+		/* Advance beyond the newly added prefix and existing line. */
+		text += prefix_len + line_len;
+
+		/* The remaining text has only decreased by the line. */
+		text_len -= line_len;
+
+		len += prefix_len + line_len + 1;
+
+		if (text_len) {
+			/* Advance past the newline. */
+			text++;
+			text_len--;
+		} else {
+			/* The final line, add a newline. */
+			*text = '\n';
+			break;
+		}
+	}
 
 	return len;
 }
 
+static size_t get_record_text_size(struct printk_info *info,
+				   unsigned int line_count,
+				   bool syslog, bool time)
+{
+	char prefix[PREFIX_MAX];
+	size_t prefix_len;
+
+	prefix_len = info_print_prefix(info, syslog, time, prefix);
+
+	/*
+	 * Each line will be preceded with a prefix. The intermediate
+	 * newlines are already within the text, but a final trailing
+	 * newline will be added.
+	 */
+	return ((prefix_len * line_count) + info->text_len + 1);
+}
+
 static int syslog_print(char __user *buf, int size)
 {
+	struct printk_info info;
+	struct printk_record r;
 	char *text;
-	struct printk_log *msg;
 	int len = 0;
 
 	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
 	if (!text)
 		return -ENOMEM;
 
+	prb_rec_init_rd(&r, &info, text, LOG_LINE_MAX + PREFIX_MAX, NULL, 0);
+
 	while (size > 0) {
 		size_t n;
 		size_t skip;
 
 		logbuf_lock_irq();
-		if (syslog_seq < log_first_seq) {
-			/* messages are gone, move to first one */
-			syslog_seq = log_first_seq;
-			syslog_idx = log_first_idx;
-			syslog_partial = 0;
-		}
-		if (syslog_seq == log_next_seq) {
+		if (!prb_read_valid(prb, syslog_seq, &r)) {
 			logbuf_unlock_irq();
 			break;
 		}
+		if (r.info->seq != syslog_seq) {
+			/* message is gone, move to next valid one */
+			syslog_seq = r.info->seq;
+			syslog_partial = 0;
+		}
 
 		/*
 		 * To keep reading/counting partial line consistent,
@@ -1419,13 +1457,10 @@ static int syslog_print(char __user *buf, int size)
 			syslog_time = printk_time;
 
 		skip = syslog_partial;
-		msg = log_from_idx(syslog_idx);
-		n = msg_print_text(msg, true, syslog_time, text,
-				   LOG_LINE_MAX + PREFIX_MAX);
+		n = record_print_text(&r, true, syslog_time);
 		if (n - syslog_partial <= size) {
 			/* message fits into buffer, move forward */
-			syslog_idx = log_next(syslog_idx);
-			syslog_seq++;
+			syslog_seq = r.info->seq + 1;
 			n -= syslog_partial;
 			syslog_partial = 0;
 		} else if (!len){
@@ -1456,55 +1491,49 @@ static int syslog_print(char __user *buf, int size)
 
 static int syslog_print_all(char __user *buf, int size, bool clear)
 {
+	struct printk_info info;
+	unsigned int line_count;
+	struct printk_record r;
 	char *text;
 	int len = 0;
-	u64 next_seq;
 	u64 seq;
-	u32 idx;
 	bool time;
 
 	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
 	if (!text)
 		return -ENOMEM;
 
+	prb_rec_init_rd(&r, &info, text, LOG_LINE_MAX + PREFIX_MAX, NULL, 0);
+
 	time = printk_time;
 	logbuf_lock_irq();
 	/*
 	 * Find first record that fits, including all following records,
 	 * into the user-provided buffer for this dump.
 	 */
-	seq = clear_seq;
-	idx = clear_idx;
-	while (seq < log_next_seq) {
-		struct printk_log *msg = log_from_idx(idx);
-
-		len += msg_print_text(msg, true, time, NULL, 0);
-		idx = log_next(idx);
-		seq++;
+	prb_for_each_record(clear_seq, prb, seq, &r) {
+		line_count = prb_count_lines(text, r.info->text_len);
+		len += get_record_text_size(r.info, line_count, true, time);
 	}
 
 	/* move first record forward until length fits into the buffer */
-	seq = clear_seq;
-	idx = clear_idx;
-	while (len > size && seq < log_next_seq) {
-		struct printk_log *msg = log_from_idx(idx);
-
-		len -= msg_print_text(msg, true, time, NULL, 0);
-		idx = log_next(idx);
-		seq++;
+	prb_for_each_record(clear_seq, prb, seq, &r) {
+		if (len <= size)
+			break;
+		line_count = prb_count_lines(text, r.info->text_len);
+		len -= get_record_text_size(r.info, line_count, true, time);
 	}
 
-	/* last message fitting into this dump */
-	next_seq = log_next_seq;
-
 	len = 0;
-	while (len >= 0 && seq < next_seq) {
-		struct printk_log *msg = log_from_idx(idx);
-		int textlen = msg_print_text(msg, true, time, text,
-					     LOG_LINE_MAX + PREFIX_MAX);
+	prb_for_each_record(seq, prb, seq, &r) {
+		int textlen;
 
-		idx = log_next(idx);
-		seq++;
+		textlen = record_print_text(&r, true, time);
+
+		if (len + textlen > size) {
+			seq--;
+			break;
+		}
 
 		logbuf_unlock_irq();
 		if (copy_to_user(buf + len, text, textlen))
@@ -1513,17 +1542,12 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 			len += textlen;
 		logbuf_lock_irq();
 
-		if (seq < log_first_seq) {
-			/* messages are gone, move to next one */
-			seq = log_first_seq;
-			idx = log_first_idx;
-		}
+		if (len < 0)
+			break;
 	}
 
-	if (clear) {
-		clear_seq = log_next_seq;
-		clear_idx = log_next_idx;
-	}
+	if (clear)
+		clear_seq = seq;
 	logbuf_unlock_irq();
 
 	kfree(text);
@@ -1533,8 +1557,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 static void syslog_clear(void)
 {
 	logbuf_lock_irq();
-	clear_seq = log_next_seq;
-	clear_idx = log_next_idx;
+	clear_seq = prb_next_seq(prb);
 	logbuf_unlock_irq();
 }
 
@@ -1542,6 +1565,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 {
 	bool clear = false;
 	static int saved_console_loglevel = LOGLEVEL_DEFAULT;
+	char *text = NULL;
 	int error;
 
 	error = check_syslog_permissions(type, source);
@@ -1561,7 +1585,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		if (!access_ok(buf, len))
 			return -EFAULT;
 		error = wait_event_interruptible(log_wait,
-						 syslog_seq != log_next_seq);
+				prb_read_valid(prb, syslog_seq, NULL));
 		if (error)
 			return error;
 		error = syslog_print(buf, len);
@@ -1609,11 +1633,15 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		break;
 	/* Number of chars in the log buffer */
 	case SYSLOG_ACTION_SIZE_UNREAD:
+		if (source != SYSLOG_FROM_PROC) {
+			text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
+			if (!text)
+				return -ENOMEM;
+		}
 		logbuf_lock_irq();
-		if (syslog_seq < log_first_seq) {
+		if (syslog_seq < prb_first_seq(prb)) {
 			/* messages are gone, move to first one */
-			syslog_seq = log_first_seq;
-			syslog_idx = log_first_idx;
+			syslog_seq = prb_first_seq(prb);
 			syslog_partial = 0;
 		}
 		if (source == SYSLOG_FROM_PROC) {
@@ -1622,24 +1650,29 @@ int do_syslog(int type, char __user *buf, int len, int source)
 			 * for pending data, not the size; return the count of
 			 * records, not the length.
 			 */
-			error = log_next_seq - syslog_seq;
+			error = prb_next_seq(prb) - syslog_seq;
 		} else {
-			u64 seq = syslog_seq;
-			u32 idx = syslog_idx;
 			bool time = syslog_partial ? syslog_time : printk_time;
-
-			while (seq < log_next_seq) {
-				struct printk_log *msg = log_from_idx(idx);
-
-				error += msg_print_text(msg, true, time, NULL,
-							0);
+			struct printk_info info;
+			unsigned int line_count;
+			struct printk_record r;
+			u64 seq;
+
+			prb_rec_init_rd(&r, &info, text,
+					LOG_LINE_MAX + PREFIX_MAX, NULL, 0);
+
+			prb_for_each_record(syslog_seq, prb, seq, &r) {
+				line_count = prb_count_lines(text,
+							r.info->text_len);
+				error += get_record_text_size(r.info,
+							      line_count,
+							      true, time);
 				time = printk_time;
-				idx = log_next(idx);
-				seq++;
 			}
 			error -= syslog_partial;
 		}
 		logbuf_unlock_irq();
+		kfree(text);
 		break;
 	/* Size of the log buffer */
 	case SYSLOG_ACTION_SIZE_BUFFER:
@@ -1806,10 +1839,22 @@ static int console_trylock_spinning(void)
 static void call_console_drivers(const char *ext_text, size_t ext_len,
 				 const char *text, size_t len)
 {
+	static char dropped_text[64];
+	size_t dropped_len = 0;
 	struct console *con;
 
 	trace_console_rcuidle(text, len);
 
+	if (!console_drivers)
+		return;
+
+	if (console_dropped) {
+		dropped_len = snprintf(dropped_text, sizeof(dropped_text),
+				       "** %lu printk messages dropped **\n",
+				       console_dropped);
+		console_dropped = 0;
+	}
+
 	for_each_console(con) {
 		if (exclusive_console && con != exclusive_console)
 			continue;
@@ -1822,8 +1867,11 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
 			continue;
 		if (con->flags & CON_EXTENDED)
 			con->write(con, ext_text, ext_len);
-		else
+		else {
+			if (dropped_len)
+				con->write(con, dropped_text, dropped_len);
 			con->write(con, text, len);
+		}
 	}
 }
 
@@ -1993,7 +2041,6 @@ asmlinkage int vprintk_emit(int facility, int level,
 	int printed_len;
 	bool in_sched = false, pending_output;
 	unsigned long flags;
-	u64 curr_log_seq;
 
 	/* Suppress unimportant messages after panic happens */
 	if (unlikely(suppress_printk))
@@ -2009,9 +2056,9 @@ asmlinkage int vprintk_emit(int facility, int level,
 
 	/* This stops the holder of console_sem just where we want him */
 	logbuf_lock_irqsave(flags);
-	curr_log_seq = log_next_seq;
+	pending_output = !prb_read_valid(prb, console_seq, NULL);
 	printed_len = vprintk_store(facility, level, dict, dictlen, fmt, args);
-	pending_output = (curr_log_seq != log_next_seq);
+	pending_output &= prb_read_valid(prb, console_seq, NULL);
 	logbuf_unlock_irqrestore(flags);
 
 	/* If called from the scheduler, we can not call up(). */
@@ -2090,21 +2137,24 @@ EXPORT_SYMBOL(printk);
 #define PREFIX_MAX		0
 #define printk_time		false
 
+#define prb_read_valid(rb, seq, r)	false
+#define prb_first_seq(rb)		0
+
 static u64 syslog_seq;
-static u32 syslog_idx;
 static u64 console_seq;
-static u32 console_idx;
 static u64 exclusive_console_stop_seq;
-static u64 log_first_seq;
-static u32 log_first_idx;
-static u64 log_next_seq;
-static char *log_text(const struct printk_log *msg) { return NULL; }
-static char *log_dict(const struct printk_log *msg) { return NULL; }
-static struct printk_log *log_from_idx(u32 idx) { return NULL; }
-static u32 log_next(u32 idx) { return 0; }
-static ssize_t msg_print_ext_header(char *buf, size_t size,
-				    struct printk_log *msg,
-				    u64 seq) { return 0; }
+static unsigned long console_dropped;
+
+static size_t record_print_text(const struct printk_record *r,
+				bool syslog, bool time)
+{
+	return 0;
+}
+static ssize_t info_print_ext_header(char *buf, size_t size,
+				     struct printk_info *info)
+{
+	return 0;
+}
 static ssize_t msg_print_ext_body(char *buf, size_t size,
 				  char *dict, size_t dict_len,
 				  char *text, size_t text_len) { return 0; }
@@ -2112,8 +2162,6 @@ static void console_lock_spinning_enable(void) { }
 static int console_lock_spinning_disable_and_check(void) { return 0; }
 static void call_console_drivers(const char *ext_text, size_t ext_len,
 				 const char *text, size_t len) {}
-static size_t msg_print_text(const struct printk_log *msg, bool syslog,
-			     bool time, char *buf, size_t size) { return 0; }
 static bool suppress_message_printing(int level) { return false; }
 
 #endif /* CONFIG_PRINTK */
@@ -2398,14 +2446,19 @@ void console_unlock(void)
 {
 	static char ext_text[CONSOLE_EXT_LOG_MAX];
 	static char text[LOG_LINE_MAX + PREFIX_MAX];
+	static char dict[LOG_LINE_MAX];
 	unsigned long flags;
 	bool do_cond_resched, retry;
+	struct printk_info info;
+	struct printk_record r;
 
 	if (console_suspended) {
 		up_console_sem();
 		return;
 	}
 
+	prb_rec_init_rd(&r, &info, text, sizeof(text), dict, sizeof(dict));
+
 	/*
 	 * Console drivers are called with interrupts disabled, so
 	 * @console_may_schedule should be cleared before; however, we may
@@ -2436,35 +2489,26 @@ void console_unlock(void)
 	}
 
 	for (;;) {
-		struct printk_log *msg;
 		size_t ext_len = 0;
 		size_t len;
 
 		printk_safe_enter_irqsave(flags);
 		raw_spin_lock(&logbuf_lock);
-		if (console_seq < log_first_seq) {
-			len = snprintf(text, sizeof(text),
-				       "** %llu printk messages dropped **\n",
-				       log_first_seq - console_seq);
-
-			/* messages are gone, move to first one */
-			console_seq = log_first_seq;
-			console_idx = log_first_idx;
-		} else {
-			len = 0;
-		}
 skip:
-		if (console_seq == log_next_seq)
+		if (!prb_read_valid(prb, console_seq, &r))
 			break;
 
-		msg = log_from_idx(console_idx);
-		if (suppress_message_printing(msg->level)) {
+		if (console_seq != r.info->seq) {
+			console_dropped += r.info->seq - console_seq;
+			console_seq = r.info->seq;
+		}
+
+		if (suppress_message_printing(r.info->level)) {
 			/*
 			 * Skip record we have buffered and already printed
 			 * directly to the console when we received it, and
 			 * record that has level above the console loglevel.
 			 */
-			console_idx = log_next(console_idx);
 			console_seq++;
 			goto skip;
 		}
@@ -2475,19 +2519,24 @@ void console_unlock(void)
 			exclusive_console = NULL;
 		}
 
-		len += msg_print_text(msg,
-				console_msg_format & MSG_FORMAT_SYSLOG,
-				printk_time, text + len, sizeof(text) - len);
+		/*
+		 * Handle extended console text first because later
+		 * record_print_text() will modify the record buffer in-place.
+		 */
 		if (nr_ext_console_drivers) {
-			ext_len = msg_print_ext_header(ext_text,
+			ext_len = info_print_ext_header(ext_text,
 						sizeof(ext_text),
-						msg, console_seq);
+						r.info);
 			ext_len += msg_print_ext_body(ext_text + ext_len,
 						sizeof(ext_text) - ext_len,
-						log_dict(msg), msg->dict_len,
-						log_text(msg), msg->text_len);
+						&r.dict_buf[0],
+						r.info->dict_len,
+						&r.text_buf[0],
+						r.info->text_len);
 		}
-		console_idx = log_next(console_idx);
+		len = record_print_text(&r,
+				console_msg_format & MSG_FORMAT_SYSLOG,
+				printk_time);
 		console_seq++;
 		raw_spin_unlock(&logbuf_lock);
 
@@ -2527,7 +2576,7 @@ void console_unlock(void)
 	 * flush, no worries.
 	 */
 	raw_spin_lock(&logbuf_lock);
-	retry = console_seq != log_next_seq;
+	retry = prb_read_valid(prb, console_seq, NULL);
 	raw_spin_unlock(&logbuf_lock);
 	printk_safe_exit_irqrestore(flags);
 
@@ -2596,8 +2645,7 @@ void console_flush_on_panic(enum con_flush_mode mode)
 		unsigned long flags;
 
 		logbuf_lock_irqsave(flags);
-		console_seq = log_first_seq;
-		console_idx = log_first_idx;
+		console_seq = prb_first_seq(prb);
 		logbuf_unlock_irqrestore(flags);
 	}
 	console_unlock();
@@ -2840,7 +2888,6 @@ void register_console(struct console *newcon)
 		exclusive_console = newcon;
 		exclusive_console_stop_seq = console_seq;
 		console_seq = syslog_seq;
-		console_idx = syslog_idx;
 		logbuf_unlock_irqrestore(flags);
 	}
 	console_unlock();
@@ -3229,9 +3276,7 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 
 		logbuf_lock_irqsave(flags);
 		dumper->cur_seq = clear_seq;
-		dumper->cur_idx = clear_idx;
-		dumper->next_seq = log_next_seq;
-		dumper->next_idx = log_next_idx;
+		dumper->next_seq = prb_next_seq(prb);
 		logbuf_unlock_irqrestore(flags);
 
 		/* invoke dumper which will iterate over records */
@@ -3265,28 +3310,33 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 bool kmsg_dump_get_line_nolock(struct kmsg_dumper *dumper, bool syslog,
 			       char *line, size_t size, size_t *len)
 {
-	struct printk_log *msg;
+	struct printk_info info;
+	unsigned int line_count;
+	struct printk_record r;
 	size_t l = 0;
 	bool ret = false;
 
+	prb_rec_init_rd(&r, &info, line, size, NULL, 0);
+
 	if (!dumper->active)
 		goto out;
 
-	if (dumper->cur_seq < log_first_seq) {
-		/* messages are gone, move to first available one */
-		dumper->cur_seq = log_first_seq;
-		dumper->cur_idx = log_first_idx;
-	}
-
-	/* last entry */
-	if (dumper->cur_seq >= log_next_seq)
-		goto out;
+	/* Read text or count text lines? */
+	if (line) {
+		if (!prb_read_valid(prb, dumper->cur_seq, &r))
+			goto out;
+		l = record_print_text(&r, syslog, printk_time);
+	} else {
+		if (!prb_read_valid_info(prb, dumper->cur_seq,
+					 &info, &line_count)) {
+			goto out;
+		}
+		l = get_record_text_size(&info, line_count, syslog,
+					 printk_time);
 
-	msg = log_from_idx(dumper->cur_idx);
-	l = msg_print_text(msg, syslog, printk_time, line, size);
+	}
 
-	dumper->cur_idx = log_next(dumper->cur_idx);
-	dumper->cur_seq++;
+	dumper->cur_seq = r.info->seq + 1;
 	ret = true;
 out:
 	if (len)
@@ -3347,23 +3397,25 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_line);
 bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 			  char *buf, size_t size, size_t *len)
 {
+	struct printk_info info;
+	unsigned int line_count;
+	struct printk_record r;
 	unsigned long flags;
 	u64 seq;
-	u32 idx;
 	u64 next_seq;
-	u32 next_idx;
 	size_t l = 0;
 	bool ret = false;
 	bool time = printk_time;
 
-	if (!dumper->active)
+	prb_rec_init_rd(&r, &info, buf, size, NULL, 0);
+
+	if (!dumper->active || !buf || !size)
 		goto out;
 
 	logbuf_lock_irqsave(flags);
-	if (dumper->cur_seq < log_first_seq) {
+	if (dumper->cur_seq < prb_first_seq(prb)) {
 		/* messages are gone, move to first available one */
-		dumper->cur_seq = log_first_seq;
-		dumper->cur_idx = log_first_idx;
+		dumper->cur_seq = prb_first_seq(prb);
 	}
 
 	/* last entry */
@@ -3374,41 +3426,41 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 
 	/* calculate length of entire buffer */
 	seq = dumper->cur_seq;
-	idx = dumper->cur_idx;
-	while (seq < dumper->next_seq) {
-		struct printk_log *msg = log_from_idx(idx);
-
-		l += msg_print_text(msg, true, time, NULL, 0);
-		idx = log_next(idx);
-		seq++;
+	while (prb_read_valid_info(prb, seq, &info, &line_count)) {
+		if (r.info->seq >= dumper->next_seq)
+			break;
+		l += get_record_text_size(&info, line_count, true, time);
+		seq = r.info->seq + 1;
 	}
 
 	/* move first record forward until length fits into the buffer */
 	seq = dumper->cur_seq;
-	idx = dumper->cur_idx;
-	while (l >= size && seq < dumper->next_seq) {
-		struct printk_log *msg = log_from_idx(idx);
-
-		l -= msg_print_text(msg, true, time, NULL, 0);
-		idx = log_next(idx);
-		seq++;
+	while (l >= size && prb_read_valid_info(prb, seq,
+						&info, &line_count)) {
+		if (r.info->seq >= dumper->next_seq)
+			break;
+		l -= get_record_text_size(&info, line_count, true, time);
+		seq = r.info->seq + 1;
 	}
 
 	/* last message in next interation */
 	next_seq = seq;
-	next_idx = idx;
 
+	/* actually read text into the buffer now */
 	l = 0;
-	while (seq < dumper->next_seq) {
-		struct printk_log *msg = log_from_idx(idx);
+	while (prb_read_valid(prb, seq, &r)) {
+		if (r.info->seq >= dumper->next_seq)
+			break;
+
+		l += record_print_text(&r, syslog, time);
+
+		/* adjust record to store to remaining buffer space */
+		prb_rec_init_rd(&r, &info, buf + l, size - l, NULL, 0);
 
-		l += msg_print_text(msg, syslog, time, buf + l, size - l);
-		idx = log_next(idx);
-		seq++;
+		seq = r.info->seq + 1;
 	}
 
 	dumper->next_seq = next_seq;
-	dumper->next_idx = next_idx;
 	ret = true;
 	logbuf_unlock_irqrestore(flags);
 out:
@@ -3431,9 +3483,7 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
 void kmsg_dump_rewind_nolock(struct kmsg_dumper *dumper)
 {
 	dumper->cur_seq = clear_seq;
-	dumper->cur_idx = clear_idx;
-	dumper->next_seq = log_next_seq;
-	dumper->next_idx = log_next_idx;
+	dumper->next_seq = prb_next_seq(prb);
 }
 
 /**
-- 
2.20.1

