Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C70C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E2C205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgIKJur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 05:50:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:40424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgIKJuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:50:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2BD3ADE0;
        Fri, 11 Sep 2020 09:50:52 +0000 (UTC)
Date:   Fri, 11 Sep 2020 11:50:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Changki Kim <changki.kim@samsung.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        changbin.du@intel.com, masahiroy@kernel.org, rd.dunlap@gmail.com,
        gregkh@linuxfoundation.org, krzk@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [POC] printk: Convert dict ring into array
Message-ID: <20200911095035.GI3864@alley>
References: <CGME20200904082449epcas2p4420d5df2083325b328a182c79f5c0948@epcas2p4.samsung.com>
 <20200904082438.20707-1-changki.kim@samsung.com>
 <874kod6fgh.fsf@jogness.linutronix.de>
 <20200904124530.GB20558@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904124530.GB20558@alley>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is POC how the printk() code would look when dict ring
gets converted into an array of extended info structures.

It applies on top of the patchset ("[PATCH printk v4 0/6]
printk: reimplement LOG_CONT handling"), see
https://lore.kernel.org/r/20200908202859.2736-1-john.ogness@linutronix.de

It compiles and even seems to work. But it would need quite
some love and discussion to get ready for merging.


Below is the description of the patch:

The dictionary information is not stored when there is not enough
space in the dict ring. It makes perfect sense. The message itself
is more important than its extra meta data.

Though, there are requests to store and show even more metadata,
for example, timestamp from real clock, CPU, task name.

If these metadata can get dropped then they are are unreliable for use.
For example, for filtering, correlation with time stamps from user
space logs.

It brings many questions and problems how to:

    + tune the size
    + substitute missing values in output

Another problem is that storing them in the current format,
(key=value) is not ideal:

    + repeated key strings for each message
    + storing numbers as text
    + values need to get parsed and numbers converted back

A solution would be to store the dictionary in a binary form.
It would be either some universal format or some structure.

There is only small step to replace the dict ring with an array
of structures. It would have several advantages:

    + guaranteed space for each message
    + easy access
    + preserving the original type of the value

It has also few drawbacks:

    + limited lengths of stored string values
    + unused space when a string is short or missing; normal printk()
      vs. dev_printk()
    + any structure changes might break crashdump tools

Well, there is only small step to bundle these values into the existing
struct printk_info.

The main motivation to store these extra information separately
is to make them optional for crashdump tools. It might be able
to show the most important data even when the structure changes.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 drivers/base/core.c               |  45 +++----
 include/linux/dev_printk.h        |   8 ++
 include/linux/printk.h            |   6 +-
 kernel/printk/internal.h          |   4 +-
 kernel/printk/printk.c            | 181 ++++++++++++++-------------
 kernel/printk/printk_ringbuffer.c | 201 ++++++++++--------------------
 kernel/printk/printk_ringbuffer.h |  72 +++++------
 kernel/printk/printk_safe.c       |   2 +-
 8 files changed, 222 insertions(+), 297 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 05d414e9e8a4..4fd81bc06bbc 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3835,22 +3835,21 @@ void device_shutdown(void)
  */
 
 #ifdef CONFIG_PRINTK
-static int
-create_syslog_header(const struct device *dev, char *hdr, size_t hdrlen)
+static void
+set_dev_info(const struct device *dev, struct dev_printk_info *dev_info)
 {
 	const char *subsys;
-	size_t pos = 0;
+
+	memset(dev_info, 0, sizeof(*dev_info));
 
 	if (dev->class)
 		subsys = dev->class->name;
 	else if (dev->bus)
 		subsys = dev->bus->name;
 	else
-		return 0;
+		return;
 
-	pos += snprintf(hdr + pos, hdrlen - pos, "SUBSYSTEM=%s", subsys);
-	if (pos >= hdrlen)
-		goto overflow;
+	snprintf(dev_info->subsystem, sizeof(dev_info->subsystem), subsys);
 
 	/*
 	 * Add device identifier DEVICE=:
@@ -3866,41 +3865,27 @@ create_syslog_header(const struct device *dev, char *hdr, size_t hdrlen)
 			c = 'b';
 		else
 			c = 'c';
-		pos++;
-		pos += snprintf(hdr + pos, hdrlen - pos,
-				"DEVICE=%c%u:%u",
-				c, MAJOR(dev->devt), MINOR(dev->devt));
+		snprintf(dev_info->device, sizeof(dev_info->device),
+			 "%c%u:%u", c, MAJOR(dev->devt), MINOR(dev->devt));
 	} else if (strcmp(subsys, "net") == 0) {
 		struct net_device *net = to_net_dev(dev);
 
-		pos++;
-		pos += snprintf(hdr + pos, hdrlen - pos,
-				"DEVICE=n%u", net->ifindex);
+		snprintf(dev_info->device, sizeof(dev_info->device),
+			"n%u", net->ifindex);
 	} else {
-		pos++;
-		pos += snprintf(hdr + pos, hdrlen - pos,
-				"DEVICE=+%s:%s", subsys, dev_name(dev));
+		snprintf(dev_info->device, sizeof(dev_info->device),
+			"+%s:%s", subsys, dev_name(dev));
 	}
-
-	if (pos >= hdrlen)
-		goto overflow;
-
-	return pos;
-
-overflow:
-	dev_WARN(dev, "device/subsystem name too long");
-	return 0;
 }
 
 int dev_vprintk_emit(int level, const struct device *dev,
 		     const char *fmt, va_list args)
 {
-	char hdr[128];
-	size_t hdrlen;
+	struct dev_printk_info dev_info;
 
-	hdrlen = create_syslog_header(dev, hdr, sizeof(hdr));
+	set_dev_info(dev, &dev_info);
 
-	return vprintk_emit(0, level, hdrlen ? hdr : NULL, hdrlen, fmt, args);
+	return vprintk_emit(0, level, &dev_info, fmt, args);
 }
 EXPORT_SYMBOL(dev_vprintk_emit);
 
diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index 3028b644b4fb..6f009559ee54 100644
--- a/include/linux/dev_printk.h
+++ b/include/linux/dev_printk.h
@@ -21,6 +21,14 @@
 
 struct device;
 
+#define PRINTK_INFO_SUBSYSTEM_LEN	16
+#define PRINTK_INFO_DEVICE_LEN		48
+
+struct dev_printk_info {
+	char subsystem[PRINTK_INFO_SUBSYSTEM_LEN];
+	char device[PRINTK_INFO_DEVICE_LEN];
+};
+
 #ifdef CONFIG_PRINTK
 
 __printf(3, 0) __cold
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 34c1a7be3e01..55f1bf47b0f8 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -159,10 +159,12 @@ static inline void printk_nmi_direct_enter(void) { }
 static inline void printk_nmi_direct_exit(void) { }
 #endif /* PRINTK_NMI */
 
+struct dev_printk_info;
+
 #ifdef CONFIG_PRINTK
-asmlinkage __printf(5, 0)
+asmlinkage __printf(4, 0)
 int vprintk_emit(int facility, int level,
-		 const char *dict, size_t dictlen,
+		 const struct dev_printk_info *dev_info,
 		 const char *fmt, va_list args);
 
 asmlinkage __printf(1, 0)
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 660f9a6bf73a..3a8fd491758c 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -14,9 +14,9 @@
 
 extern raw_spinlock_t logbuf_lock;
 
-__printf(5, 0)
+__printf(4, 0)
 int vprintk_store(int facility, int level,
-		  const char *dict, size_t dictlen,
+		  const struct dev_printk_info *dev_info,
 		  const char *fmt, va_list args);
 
 __printf(1, 0) int vprintk_default(const char *fmt, va_list args);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6f4090ed502b..4ae3e1270ac1 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -430,7 +430,6 @@ static u32 log_buf_len = __LOG_BUF_LEN;
  * Define the average message size. This only affects the number of
  * descriptors that will be available. Underestimating is better than
  * overestimating (too many available descriptors is better than not enough).
- * The dictionary buffer will be the same size as the text buffer.
  */
 #define PRB_AVGBITS 5	/* 32 character average length */
 
@@ -438,7 +437,7 @@ static u32 log_buf_len = __LOG_BUF_LEN;
 #error CONFIG_LOG_BUF_SHIFT value too small.
 #endif
 _DEFINE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
-		 PRB_AVGBITS, PRB_AVGBITS, &__log_buf[0]);
+		 PRB_AVGBITS, &__log_buf[0]);
 
 static struct printk_ringbuffer printk_rb_dynamic;
 
@@ -498,19 +497,19 @@ static void truncate_msg(u16 *text_len, u16 *trunc_msg_len)
 /* insert record into the buffer, discard old ones, update heads */
 static int log_store(u32 caller_id, int facility, int level,
 		     enum log_flags flags, u64 ts_nsec,
-		     const char *dict, u16 dict_len,
+		     const struct dev_printk_info *dev_info,
 		     const char *text, u16 text_len)
 {
 	struct prb_reserved_entry e;
 	struct printk_record r;
 	u16 trunc_msg_len = 0;
 
-	prb_rec_init_wr(&r, text_len, dict_len);
+	prb_rec_init_wr(&r, text_len);
 
 	if (!prb_reserve(&e, prb, &r)) {
 		/* truncate the message if it is too long for empty buffer */
 		truncate_msg(&text_len, &trunc_msg_len);
-		prb_rec_init_wr(&r, text_len + trunc_msg_len, dict_len);
+		prb_rec_init_wr(&r, text_len + trunc_msg_len);
 		/* survive when the log buffer is too small for trunc_msg */
 		if (!prb_reserve(&e, prb, &r))
 			return 0;
@@ -521,10 +520,6 @@ static int log_store(u32 caller_id, int facility, int level,
 	if (trunc_msg_len)
 		memcpy(&r.text_buf[text_len], trunc_msg, trunc_msg_len);
 	r.info->text_len = text_len + trunc_msg_len;
-	if (r.dict_buf) {
-		memcpy(&r.dict_buf[0], dict, dict_len);
-		r.info->dict_len = dict_len;
-	}
 	r.info->facility = facility;
 	r.info->level = level & 7;
 	r.info->flags = flags & 0x1f;
@@ -534,6 +529,9 @@ static int log_store(u32 caller_id, int facility, int level,
 		r.info->ts_nsec = local_clock();
 	r.info->caller_id = caller_id;
 
+	if (dev_info)
+		r.ext_info->dev_info = *dev_info;
+
 	/* insert message */
 	if ((flags & LOG_CONT) || !(flags & LOG_NEWLINE))
 		prb_commit(&e);
@@ -613,9 +611,9 @@ static ssize_t info_print_ext_header(char *buf, size_t size,
 			 ts_usec, info->flags & LOG_CONT ? 'c' : '-', caller);
 }
 
-static ssize_t msg_print_ext_body(char *buf, size_t size,
-				  char *dict, size_t dict_len,
-				  char *text, size_t text_len)
+static ssize_t msg_add_ext_text(char *buf, size_t size,
+				const char *text, size_t text_len,
+				unsigned char endc)
 {
 	char *p = buf, *e = buf + size;
 	size_t i;
@@ -629,36 +627,47 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 		else
 			append_char(&p, e, c);
 	}
-	append_char(&p, e, '\n');
 
-	if (dict_len) {
-		bool line = true;
+	append_char(&p, e, endc);
 
-		for (i = 0; i < dict_len; i++) {
-			unsigned char c = dict[i];
+	return p - buf;
+}
 
-			if (line) {
-				append_char(&p, e, ' ');
-				line = false;
-			}
+static ssize_t msg_add_dict_text(char *buf, size_t size,
+				 const char *key, const char *val)
+{
+	size_t val_len = strlen(val);
+	ssize_t len;
 
-			if (c == '\0') {
-				append_char(&p, e, '\n');
-				line = true;
-				continue;
-			}
+	if (!val_len)
+		return 0;
 
-			if (c < ' ' || c >= 127 || c == '\\') {
-				p += scnprintf(p, e - p, "\\x%02x", c);
-				continue;
-			}
+	len = msg_add_ext_text(buf, size, key, strlen(key), '=');
+	len += msg_add_ext_text(buf + len, size - len, val, val_len, '\n');
 
-			append_char(&p, e, c);
-		}
-		append_char(&p, e, '\n');
-	}
+	return len;
+}
 
-	return p - buf;
+
+static ssize_t msg_print_ext_body(char *buf, size_t size,
+				  char *text, size_t text_len,
+				  struct printk_ext_info *ext_info)
+{
+	ssize_t len;
+
+	len = msg_add_ext_text(buf, size, text, text_len, '\n');
+
+	if (!ext_info)
+		goto out;
+
+	len += msg_add_dict_text(buf + len, size - len, "SUBSYSTEM",
+				 ext_info->dev_info.subsystem);
+
+	len += msg_add_dict_text(buf + len, size - len, "DEVICE",
+				 ext_info->dev_info.device);
+
+out:
+	return len;
 }
 
 /* /dev/kmsg - userspace message inject/listen interface */
@@ -669,8 +678,8 @@ struct devkmsg_user {
 	char buf[CONSOLE_EXT_LOG_MAX];
 
 	struct printk_info info;
+	struct printk_ext_info ext_info;
 	char text_buf[CONSOLE_EXT_LOG_MAX];
-	char dict_buf[CONSOLE_EXT_LOG_MAX];
 	struct printk_record record;
 };
 
@@ -681,7 +690,7 @@ int devkmsg_emit(int facility, int level, const char *fmt, ...)
 	int r;
 
 	va_start(args, fmt);
-	r = vprintk_emit(facility, level, NULL, 0, fmt, args);
+	r = vprintk_emit(facility, level, NULL, fmt, args);
 	va_end(args);
 
 	return r;
@@ -791,8 +800,8 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 
 	len = info_print_ext_header(user->buf, sizeof(user->buf), r->info);
 	len += msg_print_ext_body(user->buf + len, sizeof(user->buf) - len,
-				  &r->dict_buf[0], r->info->dict_len,
-				  &r->text_buf[0], r->info->text_len);
+				  &r->text_buf[0], r->info->text_len,
+				  r->ext_info);
 
 	user->seq = r->info->seq + 1;
 	logbuf_unlock_irq();
@@ -903,9 +912,8 @@ static int devkmsg_open(struct inode *inode, struct file *file)
 
 	mutex_init(&user->lock);
 
-	prb_rec_init_rd(&user->record, &user->info,
-			&user->text_buf[0], sizeof(user->text_buf),
-			&user->dict_buf[0], sizeof(user->dict_buf));
+	prb_rec_init_rd(&user->record, &user->info, &user->ext_info,
+			&user->text_buf[0], sizeof(user->text_buf));
 
 	logbuf_lock_irq();
 	user->seq = prb_first_valid_seq(prb);
@@ -961,12 +969,12 @@ void log_buf_vmcoreinfo_setup(void)
 	VMCOREINFO_STRUCT_SIZE(printk_ringbuffer);
 	VMCOREINFO_OFFSET(printk_ringbuffer, desc_ring);
 	VMCOREINFO_OFFSET(printk_ringbuffer, text_data_ring);
-	VMCOREINFO_OFFSET(printk_ringbuffer, dict_data_ring);
 	VMCOREINFO_OFFSET(printk_ringbuffer, fail);
 
 	VMCOREINFO_STRUCT_SIZE(prb_desc_ring);
 	VMCOREINFO_OFFSET(prb_desc_ring, count_bits);
 	VMCOREINFO_OFFSET(prb_desc_ring, descs);
+	VMCOREINFO_OFFSET(prb_desc_ring, ext_infos);
 	VMCOREINFO_OFFSET(prb_desc_ring, head_id);
 	VMCOREINFO_OFFSET(prb_desc_ring, tail_id);
 
@@ -974,7 +982,6 @@ void log_buf_vmcoreinfo_setup(void)
 	VMCOREINFO_OFFSET(prb_desc, info);
 	VMCOREINFO_OFFSET(prb_desc, state_var);
 	VMCOREINFO_OFFSET(prb_desc, text_blk_lpos);
-	VMCOREINFO_OFFSET(prb_desc, dict_blk_lpos);
 
 	VMCOREINFO_STRUCT_SIZE(prb_data_blk_lpos);
 	VMCOREINFO_OFFSET(prb_data_blk_lpos, begin);
@@ -984,9 +991,15 @@ void log_buf_vmcoreinfo_setup(void)
 	VMCOREINFO_OFFSET(printk_info, seq);
 	VMCOREINFO_OFFSET(printk_info, ts_nsec);
 	VMCOREINFO_OFFSET(printk_info, text_len);
-	VMCOREINFO_OFFSET(printk_info, dict_len);
 	VMCOREINFO_OFFSET(printk_info, caller_id);
 
+	VMCOREINFO_STRUCT_SIZE(printk_ext_info);
+	VMCOREINFO_OFFSET(printk_ext_info, dev_info);
+
+	VMCOREINFO_STRUCT_SIZE(dev_printk_info);
+	VMCOREINFO_OFFSET(dev_printk_info, subsystem);
+	VMCOREINFO_OFFSET(dev_printk_info, device);
+
 	VMCOREINFO_STRUCT_SIZE(prb_data_ring);
 	VMCOREINFO_OFFSET(prb_data_ring, size_bits);
 	VMCOREINFO_OFFSET(prb_data_ring, data);
@@ -1078,40 +1091,39 @@ static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
 	struct prb_reserved_entry e;
 	struct printk_record dest_r;
 
-	prb_rec_init_wr(&dest_r, r->info->text_len, r->info->dict_len);
+	prb_rec_init_wr(&dest_r, r->info->text_len);
 
 	if (!prb_reserve(&e, rb, &dest_r))
 		return 0;
 
 	memcpy(&dest_r.text_buf[0], &r->text_buf[0], r->info->text_len);
 	dest_r.info->text_len = r->info->text_len;
-	if (dest_r.dict_buf) {
-		memcpy(&dest_r.dict_buf[0], &r->dict_buf[0], r->info->dict_len);
-		dest_r.info->dict_len = r->info->dict_len;
-	}
 	dest_r.info->facility = r->info->facility;
 	dest_r.info->level = r->info->level;
 	dest_r.info->flags = r->info->flags;
 	dest_r.info->ts_nsec = r->info->ts_nsec;
 	dest_r.info->caller_id = r->info->caller_id;
 
+	*dest_r.ext_info = *r->ext_info;
+
 	prb_final_commit(&e);
 
 	return prb_record_text_space(&e);
 }
 
 static char setup_text_buf[CONSOLE_EXT_LOG_MAX] __initdata;
-static char setup_dict_buf[CONSOLE_EXT_LOG_MAX] __initdata;
 
 void __init setup_log_buf(int early)
 {
 	unsigned int new_descs_count;
 	struct prb_desc *new_descs;
+	struct printk_ext_info *new_ext_infos;
 	struct printk_info info;
+	struct printk_ext_info ext_info;
 	struct printk_record r;
 	size_t new_descs_size;
+	size_t new_ext_infos_size;
 	unsigned long flags;
-	char *new_dict_buf;
 	char *new_log_buf;
 	unsigned int free;
 	u64 seq;
@@ -1146,10 +1158,11 @@ void __init setup_log_buf(int early)
 		return;
 	}
 
-	new_dict_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);
-	if (unlikely(!new_dict_buf)) {
+	new_ext_infos_size = new_descs_count * sizeof(struct printk_ext_info);
+	new_ext_infos = memblock_alloc(new_ext_infos_size, LOG_ALIGN);
+	if (unlikely(!new_ext_infos)) {
 		pr_err("log_buf_len: %lu dict bytes not available\n",
-		       new_log_buf_len);
+		       new_ext_infos_size);
 		memblock_free(__pa(new_log_buf), new_log_buf_len);
 		return;
 	}
@@ -1159,19 +1172,17 @@ void __init setup_log_buf(int early)
 	if (unlikely(!new_descs)) {
 		pr_err("log_buf_len: %zu desc bytes not available\n",
 		       new_descs_size);
-		memblock_free(__pa(new_dict_buf), new_log_buf_len);
+		memblock_free(__pa(new_ext_infos), new_ext_infos_size);
 		memblock_free(__pa(new_log_buf), new_log_buf_len);
 		return;
 	}
 
-	prb_rec_init_rd(&r, &info,
-			&setup_text_buf[0], sizeof(setup_text_buf),
-			&setup_dict_buf[0], sizeof(setup_dict_buf));
+	prb_rec_init_rd(&r, &info, &ext_info,
+			&setup_text_buf[0], sizeof(setup_text_buf));
 
 	prb_init(&printk_rb_dynamic,
 		 new_log_buf, ilog2(new_log_buf_len),
-		 new_dict_buf, ilog2(new_log_buf_len),
-		 new_descs, ilog2(new_descs_count));
+		 new_descs, new_ext_infos, ilog2(new_descs_count));
 
 	logbuf_lock_irqsave(flags);
 
@@ -1448,7 +1459,7 @@ static int syslog_print(char __user *buf, int size)
 	if (!text)
 		return -ENOMEM;
 
-	prb_rec_init_rd(&r, &info, text, LOG_LINE_MAX + PREFIX_MAX, NULL, 0);
+	prb_rec_init_rd(&r, &info, NULL, text, LOG_LINE_MAX + PREFIX_MAX);
 
 	while (size > 0) {
 		size_t n;
@@ -1535,7 +1546,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 		len -= get_record_print_text_size(&info, line_count, true, time);
 	}
 
-	prb_rec_init_rd(&r, &info, text, LOG_LINE_MAX + PREFIX_MAX, NULL, 0);
+	prb_rec_init_rd(&r, &info, NULL, text, LOG_LINE_MAX + PREFIX_MAX);
 
 	len = 0;
 	prb_for_each_record(seq, prb, seq, &r) {
@@ -1895,7 +1906,9 @@ static inline u32 printk_caller_id(void)
 		0x80000000 + raw_smp_processor_id();
 }
 
-static size_t log_output(int facility, int level, enum log_flags lflags, const char *dict, size_t dictlen, char *text, size_t text_len)
+static size_t log_output(int facility, int level, enum log_flags lflags,
+			 const struct dev_printk_info *dev_info,
+			 char *text, size_t text_len)
 {
 	const u32 caller_id = printk_caller_id();
 
@@ -1903,7 +1916,7 @@ static size_t log_output(int facility, int level, enum log_flags lflags, const c
 		struct prb_reserved_entry e;
 		struct printk_record r;
 
-		prb_rec_init_wr(&r, text_len, 0);
+		prb_rec_init_wr(&r, text_len);
 		if (prb_reserve_in_last(&e, prb, &r, caller_id)) {
 			memcpy(&r.text_buf[r.info->text_len], text, text_len);
 			r.info->text_len += text_len;
@@ -1919,12 +1932,12 @@ static size_t log_output(int facility, int level, enum log_flags lflags, const c
 
 	/* Store it in the record log */
 	return log_store(caller_id, facility, level, lflags, 0,
-			 dict, dictlen, text, text_len);
+			 dev_info, text, text_len);
 }
 
 /* Must be called under logbuf_lock. */
 int vprintk_store(int facility, int level,
-		  const char *dict, size_t dictlen,
+		  const struct dev_printk_info *dev_info,
 		  const char *fmt, va_list args)
 {
 	static char textbuf[LOG_LINE_MAX];
@@ -1966,15 +1979,14 @@ int vprintk_store(int facility, int level,
 	if (level == LOGLEVEL_DEFAULT)
 		level = default_message_loglevel;
 
-	if (dict)
+	if (dev_info)
 		lflags |= LOG_NEWLINE;
 
-	return log_output(facility, level, lflags,
-			  dict, dictlen, text, text_len);
+	return log_output(facility, level, lflags, dev_info, text, text_len);
 }
 
 asmlinkage int vprintk_emit(int facility, int level,
-			    const char *dict, size_t dictlen,
+			    const struct dev_printk_info *dev_info,
 			    const char *fmt, va_list args)
 {
 	int printed_len;
@@ -1995,7 +2007,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 
 	/* This stops the holder of console_sem just where we want him */
 	logbuf_lock_irqsave(flags);
-	printed_len = vprintk_store(facility, level, dict, dictlen, fmt, args);
+	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 	logbuf_unlock_irqrestore(flags);
 
 	/* If called from the scheduler, we can not call up(). */
@@ -2029,7 +2041,7 @@ EXPORT_SYMBOL(vprintk);
 
 int vprintk_default(const char *fmt, va_list args)
 {
-	return vprintk_emit(0, LOGLEVEL_DEFAULT, NULL, 0, fmt, args);
+	return vprintk_emit(0, LOGLEVEL_DEFAULT, NULL, fmt, args);
 }
 EXPORT_SYMBOL_GPL(vprintk_default);
 
@@ -2092,7 +2104,7 @@ static ssize_t info_print_ext_header(char *buf, size_t size,
 	return 0;
 }
 static ssize_t msg_print_ext_body(char *buf, size_t size,
-				  char *dict, size_t dict_len,
+				  struct printk_ext_info *ext_info,
 				  char *text, size_t text_len) { return 0; }
 static void console_lock_spinning_enable(void) { }
 static int console_lock_spinning_disable_and_check(void) { return 0; }
@@ -2382,10 +2394,10 @@ void console_unlock(void)
 {
 	static char ext_text[CONSOLE_EXT_LOG_MAX];
 	static char text[LOG_LINE_MAX + PREFIX_MAX];
-	static char dict[LOG_LINE_MAX];
 	unsigned long flags;
 	bool do_cond_resched, retry;
 	struct printk_info info;
+	struct printk_ext_info ext_info;
 	struct printk_record r;
 
 	if (console_suspended) {
@@ -2393,7 +2405,7 @@ void console_unlock(void)
 		return;
 	}
 
-	prb_rec_init_rd(&r, &info, text, sizeof(text), dict, sizeof(dict));
+	prb_rec_init_rd(&r, &info, &ext_info, text, sizeof(text));
 
 	/*
 	 * Console drivers are called with interrupts disabled, so
@@ -2464,11 +2476,10 @@ void console_unlock(void)
 						sizeof(ext_text),
 						r.info);
 			ext_len += msg_print_ext_body(ext_text + ext_len,
-						sizeof(ext_text) - ext_len,
-						&r.dict_buf[0],
-						r.info->dict_len,
-						&r.text_buf[0],
-						r.info->text_len);
+						      sizeof(ext_text) - ext_len,
+						      &r.text_buf[0],
+						      r.info->text_len,
+						      r.ext_info);
 		}
 		len = record_print_text(&r,
 				console_msg_format & MSG_FORMAT_SYSLOG,
@@ -3047,7 +3058,7 @@ int vprintk_deferred(const char *fmt, va_list args)
 {
 	int r;
 
-	r = vprintk_emit(0, LOGLEVEL_SCHED, NULL, 0, fmt, args);
+	r = vprintk_emit(0, LOGLEVEL_SCHED, NULL, fmt, args);
 	defer_console_output();
 
 	return r;
@@ -3252,7 +3263,7 @@ bool kmsg_dump_get_line_nolock(struct kmsg_dumper *dumper, bool syslog,
 	size_t l = 0;
 	bool ret = false;
 
-	prb_rec_init_rd(&r, &info, line, size, NULL, 0);
+	prb_rec_init_rd(&r, &info, NULL, line, size);
 
 	if (!dumper->active)
 		goto out;
@@ -3343,7 +3354,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 	bool ret = false;
 	bool time = printk_time;
 
-	prb_rec_init_rd(&r, &info, buf, size, NULL, 0);
+	prb_rec_init_rd(&r, &info, NULL, buf, size);
 
 	if (!dumper->active || !buf || !size)
 		goto out;
@@ -3391,7 +3402,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 		l += record_print_text(&r, syslog, time);
 
 		/* adjust record to store to remaining buffer space */
-		prb_rec_init_rd(&r, &info, buf + l, size - l, NULL, 0);
+		prb_rec_init_rd(&r, &info, NULL, buf + l, size - l);
 
 		seq = r.info->seq + 1;
 	}
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index f1fab8c82819..36f0bf68546f 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -18,18 +18,13 @@
  *     A ring of descriptors. A descriptor contains all record meta data
  *     (sequence number, timestamp, loglevel, etc.) as well as internal state
  *     information about the record and logical positions specifying where in
- *     the other ringbuffers the text and dictionary strings are located.
+ *     the other ringbuffers the text strings are located.
  *
  *   text_data_ring
  *     A ring of data blocks. A data block consists of an unsigned long
  *     integer (ID) that maps to a desc_ring index followed by the text
  *     string of the record.
  *
- *   dict_data_ring
- *     A ring of data blocks. A data block consists of an unsigned long
- *     integer (ID) that maps to a desc_ring index followed by the dictionary
- *     string of the record.
- *
  * The internal state information of a descriptor is the key element to allow
  * readers and writers to locklessly synchronize access to the data.
  *
@@ -40,11 +35,11 @@
  * ~~~~~~~~~~~~~~~
  * The descriptor ring is an array of descriptors. A descriptor contains all
  * the meta data of a printk record as well as blk_lpos structs pointing to
- * associated text and dictionary data blocks (see "Data Rings" below). Each
- * descriptor is assigned an ID that maps directly to index values of the
- * descriptor array and has a state. The ID and the state are bitwise combined
- * into a single descriptor field named @state_var, allowing ID and state to
- * be synchronously and atomically updated.
+ * associated text data blocks (see "Data Ring" below). Each descriptor is
+ * assigned an ID that maps directly to index values of the descriptor array
+ *  and has a state. The ID and the state are bitwise combined into a single
+ * descriptor field named @state_var, allowing ID and state to be synchronously
+ * and atomically updated.
  *
  * Descriptors have four states:
  *
@@ -61,8 +56,7 @@
  *     writer cannot reopen the descriptor.
  *
  *   reusable
- *     The record exists, but its text and/or dictionary data may no longer
- *     be available.
+ *     The record exists, but its text data may no longer be available.
  *
  * Querying the @state_var of a record requires providing the ID of the
  * descriptor to query. This can yield a possible fifth (pseudo) state:
@@ -76,10 +70,9 @@
  * When a new descriptor should be created (and the ring is full), the tail
  * descriptor is invalidated by first transitioning to the reusable state and
  * then invalidating all tail data blocks up to and including the data blocks
- * associated with the tail descriptor (for text and dictionary rings). Then
- * @tail_id is advanced, followed by advancing @head_id. And finally the
- * @state_var of the new descriptor is initialized to the new ID and reserved
- * state.
+ * associated with the tail descriptor (for text ring). Then @tail_id is
+ * advanced, followed by advancing @head_id. And finally the @state_var of
+ * the new descriptor is initialized to the new ID and reserved state.
  *
  * The @tail_id can only be advanced if the new @tail_id would be in the
  * committed or reusable queried state. This makes it possible that a valid
@@ -107,13 +100,9 @@
  *   3) When a record is committed via prb_commit() and a newer record
  *      already exists, the record being committed is automatically finalized.
  *
- * Data Rings
- * ~~~~~~~~~~
- * The two data rings (text and dictionary) function identically. They exist
- * separately so that their buffer sizes can be individually set and they do
- * not affect one another.
- *
- * Data rings are byte arrays composed of data blocks. Data blocks are
+ * Data Ring
+ * ~~~~~~~~~
+ * The data ring is a byte arrays composed of data blocks. Data blocks are
  * referenced by blk_lpos structs that point to the logical position of the
  * beginning of a data block and the beginning of the next adjacent data
  * block. Logical positions are mapped directly to index values of the byte
@@ -159,29 +148,20 @@
  *	DEFINE_PRINTKRB(test_rb, 15, 5, 3);
  *
  * This ringbuffer allows up to 32768 records (2 ^ 15) and has a size of
- * 1 MiB (2 ^ (15 + 5)) for text data and 256 KiB (2 ^ (15 + 3)) for
- * dictionary data.
+ * 1 MiB (2 ^ (15 + 5)) for text data.
  *
  * Sample writer code::
  *
- *	const char *dictstr = "dictionary text";
  *	const char *textstr = "message text";
  *	struct prb_reserved_entry e;
  *	struct printk_record r;
  *
  *	// specify how much to allocate
- *	prb_rec_init_wr(&r, strlen(textstr) + 1, strlen(dictstr) + 1);
+ *	prb_rec_init_wr(&r, strlen(textstr) + 1);
  *
  *	if (prb_reserve(&e, &test_rb, &r)) {
  *		snprintf(r.text_buf, r.text_buf_size, "%s", textstr);
  *		r.info->text_len = strlen(textstr);
- *
- *		// dictionary allocation may have failed
- *		if (r.dict_buf) {
- *			snprintf(r.dict_buf, r.dict_buf_size, "%s", dictstr);
- *			r.info->dict_len = strlen(dictstr);
- *		}
- *
  *		r.info->ts_nsec = local_clock();
  *
  *		prb_final_commit(&e);
@@ -219,13 +199,12 @@
  * Sample reader code::
  *
  *	struct printk_info info;
+ *	struct printk_ext_info ext_info;
  *	struct printk_record r;
  *	char text_buf[32];
- *	char dict_buf[32];
  *	u64 seq;
  *
- *	prb_rec_init_rd(&r, &info, &text_buf[0], sizeof(text_buf),
- *			&dict_buf[0], sizeof(dict_buf));
+ *	prb_rec_init_rd(&r, &info, &ext_info, &text_buf[0], sizeof(text_buf));
  *
  *	prb_for_each_record(0, &test_rb, &seq, &r) {
  *		if (info.seq != seq)
@@ -236,13 +215,8 @@
  *			text_buf[r.text_buf_size - 1] = 0;
  *		}
  *
- *		if (info.dict_len > r.dict_buf_size) {
- *			pr_warn("record %llu dict truncated\n", info.seq);
- *			dict_buf[r.dict_buf_size - 1] = 0;
- *		}
- *
- *		pr_info("%llu: %llu: %s;%s\n", info.seq, info.ts_nsec,
- *			&text_buf[0], info.dict_len ? &dict_buf[0] : "");
+ *		pr_info("%llu: %llu: %s\n", info.seq, info.ts_nsec,
+ *			&text_buf[0]);
  *	}
  *
  * Note that additional less convenient reader functions are available to
@@ -367,6 +341,16 @@ static struct prb_desc *to_desc(struct prb_desc_ring *desc_ring, u64 n)
 	return &desc_ring->descs[DESC_INDEX(desc_ring, n)];
 }
 
+/*
+ * Return struct printk_ext_info associated with @n. @n can be either a
+ * descriptor ID or a sequence number.
+ */
+static struct printk_ext_info *
+to_ext_info(struct prb_desc_ring *desc_ring, u64 n)
+{
+	return &desc_ring->ext_infos[DESC_INDEX(desc_ring, n)];
+}
+
 static struct prb_data_block *to_block(struct prb_data_ring *data_ring,
 				       unsigned long begin_lpos)
 {
@@ -534,13 +518,12 @@ static void desc_make_reusable(struct prb_desc_ring *desc_ring,
 }
 
 /*
- * Given a data ring (text or dict), put the associated descriptor of each
- * data block from @lpos_begin until @lpos_end into the reusable state.
- *
- * If there is any problem making the associated descriptor reusable, either
- * the descriptor has not yet been finalized or another writer context has
- * already pushed the tail lpos past the problematic data block. Regardless,
- * on error the caller can re-load the tail lpos to determine the situation.
+ * Given a data ring, put the associated descriptor of each data block from
+ * @lpos_begin until @lpos_end into the reusable state. If there is any problem
+ * making the associated descriptor reusable, either the descriptor has not yet
+ * been finalized or another writer context has already pushed the tail lpos
+ * past the problematic data block. Regardless, on error the caller can re-load
+ * the tail lpos to determine the situation.
  */
 static bool data_make_reusable(struct printk_ringbuffer *rb,
 			       struct prb_data_ring *data_ring,
@@ -549,21 +532,11 @@ static bool data_make_reusable(struct printk_ringbuffer *rb,
 			       unsigned long *lpos_out)
 {
 	struct prb_desc_ring *desc_ring = &rb->desc_ring;
-	struct prb_data_blk_lpos *blk_lpos;
 	struct prb_data_block *blk;
 	enum desc_state d_state;
 	struct prb_desc desc;
 	unsigned long id;
 
-	/*
-	 * Using the provided @data_ring, point @blk_lpos to the correct
-	 * blk_lpos within the local copy of the descriptor.
-	 */
-	if (data_ring == &rb->text_data_ring)
-		blk_lpos = &desc.text_blk_lpos;
-	else
-		blk_lpos = &desc.dict_blk_lpos;
-
 	/* Loop until @lpos_begin has advanced to or beyond @lpos_end. */
 	while ((lpos_end - lpos_begin) - 1 < DATA_SIZE(data_ring)) {
 		blk = to_block(data_ring, lpos_begin);
@@ -590,7 +563,7 @@ static bool data_make_reusable(struct printk_ringbuffer *rb,
 			 * This data block is invalid if the descriptor
 			 * does not point back to it.
 			 */
-			if (blk_lpos->begin != lpos_begin)
+			if (desc.text_blk_lpos.begin != lpos_begin)
 				return false;
 			desc_make_reusable(desc_ring, id);
 			break;
@@ -599,13 +572,13 @@ static bool data_make_reusable(struct printk_ringbuffer *rb,
 			 * This data block is invalid if the descriptor
 			 * does not point back to it.
 			 */
-			if (blk_lpos->begin != lpos_begin)
+			if (desc.text_blk_lpos.begin != lpos_begin)
 				return false;
 			break;
 		}
 
 		/* Advance @lpos_begin to the next data block. */
-		lpos_begin = blk_lpos->next;
+		lpos_begin = desc.text_blk_lpos.next;
 	}
 
 	*lpos_out = lpos_begin;
@@ -801,8 +774,6 @@ static bool desc_push_tail(struct printk_ringbuffer *rb,
 
 	if (!data_push_tail(rb, &rb->text_data_ring, desc.text_blk_lpos.next))
 		return false;
-	if (!data_push_tail(rb, &rb->dict_data_ring, desc.dict_blk_lpos.next))
-		return false;
 
 	/*
 	 * Check the next descriptor after @tail_id before pushing the tail
@@ -1310,9 +1281,8 @@ static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
  * data.
  *
  * The writer specifies the text size to extend (not the new total size) by
- * setting the @text_buf_size field of @r. Extending dictionaries is not
- * supported, so @dict_buf_size of @r should be set to 0. To ensure proper
- * initialization of @r, prb_rec_init_wr() should be used.
+ * setting the @text_buf_size field of @r. To ensure proper initialization
+ * of @r, prb_rec_init_wr() should be used.
  *
  * This function will fail if @caller_id does not match the caller ID of the
  * newest record. In that case the caller must reserve new data using
@@ -1327,9 +1297,6 @@ static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
  *
  *   - @r->text_buf_size is set to the new total size of the buffer.
  *
- *   - @r->dict_buf and @r->dict_buf_size are cleared because extending
- *     the dict buffer is not supported.
- *
  *   - @r->info is not touched so that @r->info->text_len could be used
  *     to append the text.
  *
@@ -1338,8 +1305,7 @@ static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
  *
  * Important: All @r->info fields will already be set with the current values
  *            for the record. I.e. @r->info->text_len will be less than
- *            @text_buf_size and @r->info->dict_len may be set, even though
- *            @dict_buf_size is 0. Writers can use @r->info->text_len to know
+ *            @text_buf_size.. Writers can use @r->info->text_len to know
  *            where concatenation begins and writers should update
  *            @r->info->text_len after concatenating.
  */
@@ -1409,11 +1375,8 @@ bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer
 	if (r->text_buf_size && !r->text_buf)
 		goto fail;
 
-	/* Although dictionary data may be in use, it cannot be extended. */
-	r->dict_buf = NULL;
-	r->dict_buf_size = 0;
-
 	r->info = &d->info;
+	r->ext_info = to_ext_info(&rb->desc_ring, id);
 
 	e->text_space = space_used(&rb->text_data_ring, &d->text_blk_lpos);
 
@@ -1449,32 +1412,27 @@ static void desc_make_final(struct prb_desc_ring *desc_ring, unsigned long id)
  *
  * This is the public function available to writers to reserve data.
  *
- * The writer specifies the text and dict sizes to reserve by setting the
- * @text_buf_size and @dict_buf_size fields of @r, respectively. Dictionaries
- * are optional, so @dict_buf_size is allowed to be 0. To ensure proper
- * initialization of @r, prb_rec_init_wr() should be used.
+ * The writer specifies the text size to reserve by setting the @text_buf_size
+ * field of @r, respectively.  To ensure proper initialization of @r,
+ * prb_rec_init_wr() should be used.
  *
  * Context: Any context. Disables local interrupts on success.
  * Return: true if at least text data could be allocated, otherwise false.
  *
- * On success, the fields @info, @text_buf, @dict_buf of @r will be set by
+ * On success, the fields @info, @ext_info, @text_buf, of @r will be set by
  * this function and should be filled in by the writer before committing. Also
  * on success, prb_record_text_space() can be used on @e to query the actual
  * space used for the text data block.
  *
- * If the function fails to reserve dictionary space (but all else succeeded),
- * it will still report success. In that case @dict_buf is set to NULL and
- * @dict_buf_size is set to 0. Writers must check this before writing to
- * dictionary space.
- *
- * Important: @info->text_len and @info->dict_len need to be set correctly by
- *            the writer in order for data to be readable and/or extended.
- *            Their values are initialized to 0.
+ * Important: @info->text_len need to be set correctly by the writer in order
+ *	      for data to be readable and/or extended. The values is
+ *	      initialized to 0.
  */
 bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 		 struct printk_record *r)
 {
 	struct prb_desc_ring *desc_ring = &rb->desc_ring;
+	struct printk_ext_info *ext_info;
 	struct prb_desc *d;
 	unsigned long id;
 	u64 seq;
@@ -1482,9 +1440,6 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 	if (!data_check_size(&rb->text_data_ring, r->text_buf_size))
 		goto fail;
 
-	if (!data_check_size(&rb->dict_data_ring, r->dict_buf_size))
-		goto fail;
-
 	/*
 	 * Descriptors in the reserved state act as blockers to all further
 	 * reservations once the desc_ring has fully wrapped. Disable
@@ -1501,6 +1456,7 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 	}
 
 	d = to_desc(desc_ring, id);
+	ext_info = to_ext_info(desc_ring, id);
 
 	/*
 	 * All @info fields (except @seq) are cleared and must be filled in
@@ -1509,6 +1465,7 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 	 */
 	seq = d->info.seq;
 	memset(&d->info, 0, sizeof(d->info));
+	memset(ext_info, 0, sizeof(*ext_info));
 
 	/*
 	 * Set the @e fields here so that prb_commit() can be used if
@@ -1551,16 +1508,8 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 		goto fail;
 	}
 
-	r->dict_buf = data_alloc(rb, &rb->dict_data_ring, r->dict_buf_size,
-				 &d->dict_blk_lpos, id);
-	/*
-	 * If dict data allocation fails, the caller can still commit
-	 * text. But dictionary information will not be available.
-	 */
-	if (r->dict_buf_size && !r->dict_buf)
-		r->dict_buf_size = 0;
-
 	r->info = &d->info;
+	r->ext_info = ext_info;
 
 	/* Record full text space used by record. */
 	e->text_space = space_used(&rb->text_data_ring, &d->text_blk_lpos);
@@ -1814,23 +1763,16 @@ static int prb_read(struct printk_ringbuffer *rb, u64 seq,
 	if (r->info)
 		memcpy(r->info, &desc.info, sizeof(*(r->info)));
 
+	if (r->ext_info)
+		memcpy(r->ext_info, to_ext_info(desc_ring, seq),
+		       sizeof(*(r->ext_info)));
+
 	/* Copy text data. If it fails, this is a data-less record. */
 	if (!copy_data(&rb->text_data_ring, &desc.text_blk_lpos, desc.info.text_len,
 		       r->text_buf, r->text_buf_size, line_count)) {
 		return -ENOENT;
 	}
 
-	/*
-	 * Copy dict data. Although this should not fail, dict data is not
-	 * important. So if it fails, modify the copied meta data to report
-	 * that there is no dict data, thus silently dropping the dict data.
-	 */
-	if (!copy_data(&rb->dict_data_ring, &desc.dict_blk_lpos, desc.info.dict_len,
-		       r->dict_buf, r->dict_buf_size, NULL)) {
-		if (r->info)
-			r->info->dict_len = 0;
-	}
-
 	/* Ensure the record is still finalized and has the same @seq. */
 	return desc_read_finalized_seq(desc_ring, id, seq, &desc);
 }
@@ -1924,7 +1866,7 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
  *
  * This is the public function available to readers to read a record.
  *
- * The reader provides the @info, @text_buf, @dict_buf buffers of @r to be
+ * The reader provides the @info, @ext_info, @text_buf, buffers of @r to be
  * filled in. Any of the buffer pointers can be set to NULL if the reader
  * is not interested in that data. To ensure proper initialization of @r,
  * prb_rec_init_rd() should be used.
@@ -1972,7 +1914,7 @@ bool prb_read_valid_info(struct printk_ringbuffer *rb, u64 seq,
 {
 	struct printk_record r;
 
-	prb_rec_init_rd(&r, info, NULL, 0, NULL, 0);
+	prb_rec_init_rd(&r, info, NULL, NULL, 0);
 
 	return _prb_read_valid(rb, &seq, &r, line_count);
 }
@@ -2031,13 +1973,12 @@ u64 prb_next_seq(struct printk_ringbuffer *rb)
 /**
  * prb_init() - Initialize a ringbuffer to use provided external buffers.
  *
- * @rb:       The ringbuffer to initialize.
- * @text_buf: The data buffer for text data.
- * @textbits: The size of @text_buf as a power-of-2 value.
- * @dict_buf: The data buffer for dictionary data.
- * @dictbits: The size of @dict_buf as a power-of-2 value.
- * @descs:    The descriptor buffer for ringbuffer records.
- * @descbits: The count of @descs items as a power-of-2 value.
+ * @rb:        The ringbuffer to initialize.
+ * @text_buf:  The data buffer for text data.
+ * @textbits:  The size of @text_buf as a power-of-2 value.
+ * @descs:     The descriptor buffer for ringbuffer records.
+ * @ext_infos: The buffer for printk extended info structures.
+ * @descbits:  The count of @descs items as a power-of-2 value.
  *
  * This is the public function available to writers to setup a ringbuffer
  * during runtime using provided buffers.
@@ -2048,13 +1989,14 @@ u64 prb_next_seq(struct printk_ringbuffer *rb)
  */
 void prb_init(struct printk_ringbuffer *rb,
 	      char *text_buf, unsigned int textbits,
-	      char *dict_buf, unsigned int dictbits,
-	      struct prb_desc *descs, unsigned int descbits)
+	      struct prb_desc *descs, struct printk_ext_info *ext_infos,
+	      unsigned int descbits)
 {
 	memset(descs, 0, _DESCS_COUNT(descbits) * sizeof(descs[0]));
 
 	rb->desc_ring.count_bits = descbits;
 	rb->desc_ring.descs = descs;
+	rb->desc_ring.ext_infos = ext_infos;
 	atomic_long_set(&rb->desc_ring.head_id, DESC0_ID(descbits));
 	atomic_long_set(&rb->desc_ring.tail_id, DESC0_ID(descbits));
 
@@ -2063,11 +2005,6 @@ void prb_init(struct printk_ringbuffer *rb,
 	atomic_long_set(&rb->text_data_ring.head_lpos, BLK0_LPOS(textbits));
 	atomic_long_set(&rb->text_data_ring.tail_lpos, BLK0_LPOS(textbits));
 
-	rb->dict_data_ring.size_bits = dictbits;
-	rb->dict_data_ring.data = dict_buf;
-	atomic_long_set(&rb->dict_data_ring.head_lpos, BLK0_LPOS(dictbits));
-	atomic_long_set(&rb->dict_data_ring.tail_lpos, BLK0_LPOS(dictbits));
-
 	atomic_long_set(&rb->fail, 0);
 
 	descs[0].info.seq = -(u64)_DESCS_COUNT(descbits);
@@ -2076,8 +2013,6 @@ void prb_init(struct printk_ringbuffer *rb,
 	atomic_long_set(&(descs[_DESCS_COUNT(descbits) - 1].state_var), DESC0_SV(descbits));
 	descs[_DESCS_COUNT(descbits) - 1].text_blk_lpos.begin = FAILED_LPOS;
 	descs[_DESCS_COUNT(descbits) - 1].text_blk_lpos.next = FAILED_LPOS;
-	descs[_DESCS_COUNT(descbits) - 1].dict_blk_lpos.begin = FAILED_LPOS;
-	descs[_DESCS_COUNT(descbits) - 1].dict_blk_lpos.next = FAILED_LPOS;
 }
 
 /**
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 853ea62dc5f2..337f26a9f573 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -4,46 +4,49 @@
 #define _KERNEL_PRINTK_RINGBUFFER_H
 
 #include <linux/atomic.h>
+#include <linux/dev_printk.h>
 
 /*
  * Meta information about each stored message.
  *
  * All fields are set and used by the printk code except for
- * @seq, @text_len, @dict_len, which are set and/or modified
+ * @seq, @text_len, which are set and/or modified
  * by the ringbuffer code.
  */
 struct printk_info {
 	u64	seq;		/* sequence number */
 	u64	ts_nsec;	/* timestamp in nanoseconds */
 	u16	text_len;	/* length of text message */
-	u16	dict_len;	/* length of dictionary message */
 	u8	facility;	/* syslog facility */
 	u8	flags:5;	/* internal record flags */
 	u8	level:3;	/* syslog level */
 	u32	caller_id;	/* thread id or processor id */
 };
 
+struct printk_ext_info {
+	struct dev_printk_info dev_info;
+};
+
 /*
  * A structure providing the buffers, used by writers and readers.
  *
  * Writers:
- * Using prb_rec_init_wr(), a writer sets @text_buf_size and @dict_buf_size
- * before calling prb_reserve(). On success, prb_reserve() sets @info,
- * @text_buf, @dict_buf to buffers reserved for that writer.
+ * Using prb_rec_init_wr(), a writer sets @text_buf_size before
+ * calling prb_reserve(). On success, prb_reserve() sets @info,
+ * @ext_info, @text_buf to buffers reserved for that writer.
  *
  * Readers:
  * Using prb_rec_init_rd(), a reader sets all fields before calling
- * prb_read_valid(). Note that the reader provides the @info, @text_buf,
- * @dict_buf buffers. On success, the struct pointed to by @info will be
- * filled and the char arrays pointed to by @text_buf and @dict_buf will
- * be filled with text and dict data.
+ * prb_read_valid(). Note that the reader provides the @info, @ext_info,
+ * @text_buf buffers. On success, the struct pointed to by @info and
+ * @ext_info will be filled and the char array pointed to by @text_buf
+ * will be filled with text data.
  */
 struct printk_record {
 	struct printk_info	*info;
+	struct printk_ext_info	*ext_info;
 	char			*text_buf;
-	char			*dict_buf;
 	unsigned int		text_buf_size;
-	unsigned int		dict_buf_size;
 };
 
 /* Specifies the logical position and span of a data block. */
@@ -61,7 +64,6 @@ struct prb_desc {
 	struct printk_info		info;
 	atomic_long_t			state_var;
 	struct prb_data_blk_lpos	text_blk_lpos;
-	struct prb_data_blk_lpos	dict_blk_lpos;
 };
 
 /* A ringbuffer of "ID + data" elements. */
@@ -76,6 +78,7 @@ struct prb_data_ring {
 struct prb_desc_ring {
 	unsigned int		count_bits;
 	struct prb_desc		*descs;
+	struct printk_ext_info	*ext_infos;
 	atomic_long_t		head_id;
 	atomic_long_t		tail_id;
 };
@@ -89,7 +92,6 @@ struct prb_desc_ring {
 struct printk_ringbuffer {
 	struct prb_desc_ring	desc_ring;
 	struct prb_data_ring	text_data_ring;
-	struct prb_data_ring	dict_data_ring;
 	atomic_long_t		fail;
 };
 
@@ -233,9 +235,8 @@ enum desc_state {
  * Note: The specified external buffer must be of the size:
  *       2 ^ (descbits + avgtextbits)
  */
-#define _DEFINE_PRINTKRB(name, descbits, avgtextbits, avgdictbits, text_buf)			\
-static char _##name##_dict[1U << ((avgdictbits) + (descbits))]					\
-			__aligned(__alignof__(unsigned long));					\
+#define _DEFINE_PRINTKRB(name, descbits, avgtextbits, text_buf)			\
+static struct printk_ext_info _##name##_ext_infos[_DESCS_COUNT(descbits)];			\
 static struct prb_desc _##name##_descs[_DESCS_COUNT(descbits)] = {				\
 	/* this will be the first record reserved by a writer */				\
 	[0] = {											\
@@ -254,13 +255,13 @@ static struct prb_desc _##name##_descs[_DESCS_COUNT(descbits)] = {				\
 		.state_var	= ATOMIC_INIT(DESC0_SV(descbits)),				\
 		/* no associated data block */							\
 		.text_blk_lpos	= FAILED_BLK_LPOS,						\
-		.dict_blk_lpos	= FAILED_BLK_LPOS,						\
 	},											\
 };												\
 static struct printk_ringbuffer name = {							\
 	.desc_ring = {										\
 		.count_bits	= descbits,							\
 		.descs		= &_##name##_descs[0],						\
+		.ext_infos	= &_##name##_ext_infos[0],					\
 		.head_id	= ATOMIC_INIT(DESC0_ID(descbits)),				\
 		.tail_id	= ATOMIC_INIT(DESC0_ID(descbits)),				\
 	},											\
@@ -270,12 +271,6 @@ static struct printk_ringbuffer name = {							\
 		.head_lpos	= ATOMIC_LONG_INIT(BLK0_LPOS((avgtextbits) + (descbits))),	\
 		.tail_lpos	= ATOMIC_LONG_INIT(BLK0_LPOS((avgtextbits) + (descbits))),	\
 	},											\
-	.dict_data_ring = {									\
-		.size_bits	= (avgtextbits) + (descbits),					\
-		.data		= &_##name##_dict[0],						\
-		.head_lpos	= ATOMIC_LONG_INIT(BLK0_LPOS((avgtextbits) + (descbits))),	\
-		.tail_lpos	= ATOMIC_LONG_INIT(BLK0_LPOS((avgtextbits) + (descbits))),	\
-	},											\
 	.fail			= ATOMIC_LONG_INIT(0),						\
 }
 
@@ -285,17 +280,15 @@ static struct printk_ringbuffer name = {							\
  * @name:        The name of the ringbuffer variable.
  * @descbits:    The number of descriptors as a power-of-2 value.
  * @avgtextbits: The average text data size per record as a power-of-2 value.
- * @avgdictbits: The average dictionary data size per record as a
- *               power-of-2 value.
  *
  * This is a macro for defining a ringbuffer and all internal structures
  * such that it is ready for immediate use. See _DEFINE_PRINTKRB() for a
  * variant where the text data buffer can be specified externally.
  */
-#define DEFINE_PRINTKRB(name, descbits, avgtextbits, avgdictbits)		\
+#define DEFINE_PRINTKRB(name, descbits, avgtextbits)				\
 static char _##name##_text[1U << ((avgtextbits) + (descbits))]			\
 			__aligned(__alignof__(unsigned long));			\
-_DEFINE_PRINTKRB(name, descbits, avgtextbits, avgdictbits, &_##name##_text[0])
+_DEFINE_PRINTKRB(name, descbits, avgtextbits, &_##name##_text[0])
 
 /* Writer Interface */
 
@@ -304,11 +297,6 @@ _DEFINE_PRINTKRB(name, descbits, avgtextbits, avgdictbits, &_##name##_text[0])
  *
  * @r:             The record to initialize.
  * @text_buf_size: The needed text buffer size.
- * @dict_buf_size: The needed dictionary buffer size.
- *
- * Initialize all the fields that a writer is interested in. If
- * @dict_buf_size is 0, a dictionary buffer will not be reserved.
- * @text_buf_size must be greater than 0.
  *
  * Note that although @dict_buf_size may be initialized to non-zero,
  * its value must be rechecked after a successful call to prb_reserve()
@@ -316,14 +304,12 @@ _DEFINE_PRINTKRB(name, descbits, avgtextbits, avgdictbits, &_##name##_text[0])
  * reservation is allowed to fail.
  */
 static inline void prb_rec_init_wr(struct printk_record *r,
-				   unsigned int text_buf_size,
-				   unsigned int dict_buf_size)
+				   unsigned int text_buf_size)
 {
 	r->info = NULL;
+	r->ext_info = NULL;
 	r->text_buf = NULL;
-	r->dict_buf = NULL;
 	r->text_buf_size = text_buf_size;
-	r->dict_buf_size = dict_buf_size;
 }
 
 bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
@@ -335,8 +321,8 @@ void prb_final_commit(struct prb_reserved_entry *e);
 
 void prb_init(struct printk_ringbuffer *rb,
 	      char *text_buf, unsigned int text_buf_size,
-	      char *dict_buf, unsigned int dict_buf_size,
-	      struct prb_desc *descs, unsigned int descs_count_bits);
+	      struct prb_desc *descs, struct printk_ext_info *ext_infos,
+	      unsigned int descs_count_bits);
 unsigned int prb_record_text_space(struct prb_reserved_entry *e);
 
 /* Reader Interface */
@@ -346,10 +332,9 @@ unsigned int prb_record_text_space(struct prb_reserved_entry *e);
  *
  * @r:             The record to initialize.
  * @info:          A buffer to store record meta-data.
+ * @ext_info:	   A buffer to store record extended meta-data.
  * @text_buf:      A buffer to store text data.
  * @text_buf_size: The size of @text_buf.
- * @dict_buf:      A buffer to store dictionary data.
- * @dict_buf_size: The size of @dict_buf.
  *
  * Initialize all the fields that a reader is interested in. All arguments
  * (except @r) are optional. Only record data for arguments that are
@@ -357,14 +342,13 @@ unsigned int prb_record_text_space(struct prb_reserved_entry *e);
  */
 static inline void prb_rec_init_rd(struct printk_record *r,
 				   struct printk_info *info,
-				   char *text_buf, unsigned int text_buf_size,
-				   char *dict_buf, unsigned int dict_buf_size)
+				   struct printk_ext_info *ext_info,
+				   char *text_buf, unsigned int text_buf_size)
 {
 	r->info = info;
+	r->ext_info = ext_info;
 	r->text_buf = text_buf;
-	r->dict_buf = dict_buf;
 	r->text_buf_size = text_buf_size;
-	r->dict_buf_size = dict_buf_size;
 }
 
 /**
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 50aeae770434..5dbc40160990 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -375,7 +375,7 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
 	    raw_spin_trylock(&logbuf_lock)) {
 		int len;
 
-		len = vprintk_store(0, LOGLEVEL_DEFAULT, NULL, 0, fmt, args);
+		len = vprintk_store(0, LOGLEVEL_DEFAULT, NULL, fmt, args);
 		raw_spin_unlock(&logbuf_lock);
 		defer_console_output();
 		return len;
-- 
2.26.2

