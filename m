Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3B1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FCDC2076A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hLSKyWfW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Igi0rLwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgGILRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 07:17:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36444 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgGILRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 07:17:11 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594293428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ao77+O/q4vGUoWYOvzEJAcrus1CkOddJ+iDBLMZGTjY=;
        b=hLSKyWfWp+zYbdbMulYsXLs5SLzn+iLMwVR4cLonSWEO9eJM9l6veJTH+oAiYYFVsHv3ar
        6lKFD0huTGXD6Nr5wNDTf0l/sx1gVy/RqI/4hEscRT4/rjC62HObo3jBULQGuzJpV2OYXa
        vu9e4gLTkz6N0TlDaaxABWLzozJ7Pkz2vE0aHbQubgeS0CPkKk74zCefUnO3v0awgOoPHh
        T+mhhGn8enIv3duifbqwWSmxxGTnxMK886TPJ5jGF6c5/ZtY7U30YOsgEhLtr/8yMM/YD7
        xPXCpwDbcR+/2Rovguaxo+SHmGqQL0hsutMKR2XsND7zjR6p8cgjjuL/PCU2xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594293428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ao77+O/q4vGUoWYOvzEJAcrus1CkOddJ+iDBLMZGTjY=;
        b=Igi0rLwTHrqSXQqq99jY0cnncEm55xpcb8+V2ABh+sEMlVk2+tbABICimo+MZkSCUHfrqZ
        6V45fdpwGM8oX5DQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [printk] 18a2dc6982: ltp.kmsg01.fail
In-Reply-To: <20200709111310.GD11164@alley>
References: <20200707145932.8752-5-john.ogness@linutronix.de> <20200709071411.GR3874@shao2-debian> <20200709083323.GA572@jagdpanzerIV.localdomain> <874kqhm1v8.fsf@jogness.linutronix.de> <20200709105906.GC11164@alley> <20200709111310.GD11164@alley>
Date:   Thu, 09 Jul 2020 13:23:07 +0206
Message-ID: <87zh89kkek.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-09, Petr Mladek <pmladek@suse.com> wrote:
> I though more about it. IMHO, it will be better to modify
> prb_first_seq() to do the same cycle as prb_next_seq()
> and return seq number of the first valid entry.

Exactly!

Here is a patch that does just that. I added a prb_first_valid_seq()
function and made prb_first_seq() static. (The ringbuffer still needs
prb_first_seq() for itself.)

John Ogness


diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0b1337f4188c..fec71229169e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -775,9 +775,9 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		logbuf_lock_irq();
 	}
 
-	if (user->seq < prb_first_seq(prb)) {
+	if (user->seq < prb_first_valid_seq(prb)) {
 		/* our last seen message is gone, return error and reset */
-		user->seq = prb_first_seq(prb);
+		user->seq = prb_first_valid_seq(prb);
 		ret = -EPIPE;
 		logbuf_unlock_irq();
 		goto out;
@@ -820,7 +820,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 	switch (whence) {
 	case SEEK_SET:
 		/* the first record */
-		user->seq = prb_first_seq(prb);
+		user->seq = prb_first_valid_seq(prb);
 		break;
 	case SEEK_DATA:
 		/*
@@ -854,7 +854,7 @@ static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
 	logbuf_lock_irq();
 	if (prb_read_valid(prb, user->seq, NULL)) {
 		/* return error when data has vanished underneath us */
-		if (user->seq < prb_first_seq(prb))
+		if (user->seq < prb_first_valid_seq(prb))
 			ret = EPOLLIN|EPOLLRDNORM|EPOLLERR|EPOLLPRI;
 		else
 			ret = EPOLLIN|EPOLLRDNORM;
@@ -894,7 +894,7 @@ static int devkmsg_open(struct inode *inode, struct file *file)
 			&user->dict_buf[0], sizeof(user->dict_buf));
 
 	logbuf_lock_irq();
-	user->seq = prb_first_seq(prb);
+	user->seq = prb_first_valid_seq(prb);
 	logbuf_unlock_irq();
 
 	file->private_data = user;
@@ -1631,9 +1631,9 @@ int do_syslog(int type, char __user *buf, int len, int source)
 	/* Number of chars in the log buffer */
 	case SYSLOG_ACTION_SIZE_UNREAD:
 		logbuf_lock_irq();
-		if (syslog_seq < prb_first_seq(prb)) {
+		if (syslog_seq < prb_first_valid_seq(prb)) {
 			/* messages are gone, move to first one */
-			syslog_seq = prb_first_seq(prb);
+			syslog_seq = prb_first_valid_seq(prb);
 			syslog_partial = 0;
 		}
 		if (source == SYSLOG_FROM_PROC) {
@@ -2120,7 +2120,7 @@ EXPORT_SYMBOL(printk);
 #define printk_time		false
 
 #define prb_read_valid(rb, seq, r)	false
-#define prb_first_seq(rb)		0
+#define prb_first_valid_seq(rb)		0
 
 static u64 syslog_seq;
 static u64 console_seq;
@@ -2627,7 +2627,7 @@ void console_flush_on_panic(enum con_flush_mode mode)
 		unsigned long flags;
 
 		logbuf_lock_irqsave(flags);
-		console_seq = prb_first_seq(prb);
+		console_seq = prb_first_valid_seq(prb);
 		logbuf_unlock_irqrestore(flags);
 	}
 	console_unlock();
@@ -3395,9 +3395,9 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 		goto out;
 
 	logbuf_lock_irqsave(flags);
-	if (dumper->cur_seq < prb_first_seq(prb)) {
+	if (dumper->cur_seq < prb_first_valid_seq(prb)) {
 		/* messages are gone, move to first available one */
-		dumper->cur_seq = prb_first_seq(prb);
+		dumper->cur_seq = prb_first_valid_seq(prb);
 	}
 
 	/* last entry */
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index f4a670f7289d..70ad5a091e96 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1420,22 +1420,8 @@ static int prb_read(struct printk_ringbuffer *rb, u64 seq,
 	return desc_read_committed_seq(desc_ring, id, seq, &desc);
 }
 
-/**
- * prb_first_seq() - Get the sequence number of the tail descriptor.
- *
- * @rb:  The ringbuffer to get the sequence number from.
- *
- * This is the public function available to readers to see what the
- * first/oldest sequence number is.
- *
- * This provides readers a starting point to begin iterating the ringbuffer.
- * Note that the returned sequence number might not belong to a valid record.
- *
- * Context: Any context.
- * Return: The sequence number of the first/oldest record or, if the
- *         ringbuffer is empty, 0 is returned.
- */
-u64 prb_first_seq(struct printk_ringbuffer *rb)
+/* Get the sequence number of the tail descriptor. */
+static u64 prb_first_seq(struct printk_ringbuffer *rb)
 {
 	struct prb_desc_ring *desc_ring = &rb->desc_ring;
 	enum desc_state d_state;
@@ -1576,6 +1562,31 @@ bool prb_read_valid_info(struct printk_ringbuffer *rb, u64 seq,
 	return _prb_read_valid(rb, &seq, &r, line_count);
 }
 
+/**
+ * prb_first_valid_seq() - Get the sequence number of the oldest available
+ *                         record.
+ *
+ * @rb: The ringbuffer to get the sequence number from.
+ *
+ * This is the public function available to readers to see what the
+ * first/oldest sequence number is.
+ *
+ * This provides readers a starting point to begin iterating the ringbuffer.
+ *
+ * Context: Any context.
+ * Return: The sequence number of the first/oldest record or, if the
+ *         ringbuffer is empty, 0 is returned.
+ */
+u64 prb_first_valid_seq(struct printk_ringbuffer *rb)
+{
+	u64 seq = 0;
+
+	if (!_prb_read_valid(rb, &seq, NULL, NULL))
+		return 0;
+
+	return seq;
+}
+
 /**
  * prb_next_seq() - Get the sequence number after the last available record.
  *
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 711ced305cc7..3e46a7423c13 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -393,7 +393,7 @@ bool prb_read_valid(struct printk_ringbuffer *rb, u64 seq,
 bool prb_read_valid_info(struct printk_ringbuffer *rb, u64 seq,
 			 struct printk_info *info, unsigned int *line_count);
 
-u64 prb_first_seq(struct printk_ringbuffer *rb);
+u64 prb_first_valid_seq(struct printk_ringbuffer *rb);
 u64 prb_next_seq(struct printk_ringbuffer *rb);
 
 #endif /* _KERNEL_PRINTK_RINGBUFFER_H */

