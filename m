Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57C0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 02:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86BD825343
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 02:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgFVCFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 22:05:10 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:46928 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbgFVCFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 22:05:09 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 5E3CD125675DA9057D73;
        Mon, 22 Jun 2020 10:05:03 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id 05M24bra071947;
        Mon, 22 Jun 2020 10:04:37 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020062210043948-4034274 ;
          Mon, 22 Jun 2020 10:04:39 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     pmladek@suse.com
Cc:     sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        keescook@chromium.org, will@kernel.org, mchehab+samsung@kernel.org,
        dianders@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        jiang.xuexin@zte.com.cn, wangyong <wang.yong12@zte.com.cn>
Subject: [RFC PATCH RT] when panic use prink_flush_buffer to dump printk_ringbuffer
Date:   Mon, 22 Jun 2020 10:07:01 +0800
Message-Id: <1592791621-45694-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-06-22 10:04:39,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-06-22 10:04:38,
        Serialize complete at 2020-06-22 10:04:38
X-MAIL: mse-fl1.zte.com.cn 05M24bra071947
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wangyong <wang.yong12@zte.com.cn>

echo  c > proc/sysrq-trigger to trigger system panic, there is no debug
information.
I think the  reason is using printk_kthread_func, since panic will call
local_irq_disable to disable interrupts, and then call smp_send_stop to 
stop other cpus, the printk thread probably is not waken up by irq_work
and can't print messages during panic.

Using printk_flush_buffer to force flush printk_ringbuffer after all 
messages are added to printk_ringbuffer by printk.
Because printk_kthread_func may call console_lock and be blocked when
cpus stop, so printk_flush_buffer does't call console_lock.

Signed-off-by: wangyong <wang.yong12@zte.com.cn>
---
 include/linux/printk.h |  1 +
 kernel/panic.c         |  2 +
 kernel/printk/printk.c | 99 ++++++++++++++++++++++++++++++++++++++------------
 3 files changed, 78 insertions(+), 24 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index bbfe04c..66a5acf 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -193,6 +193,7 @@ void dump_stack_print_info(const char *log_lvl);
 void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack(void) __cold;
 struct wait_queue_head *printk_wait_queue(void);
+void printk_flush_buffer(void);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
diff --git a/kernel/panic.c b/kernel/panic.c
index 4d893b6..c19b84b 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -301,6 +301,7 @@ void panic(const char *fmt, ...)
 		 * We can't use the "normal" timers since we just panicked.
 		 */
 		pr_emerg("Rebooting in %d seconds..\n", panic_timeout);
+		printk_flush_buffer();
 
 		for (i = 0; i < panic_timeout * 1000; i += PANIC_TIMER_STEP) {
 			touch_nmi_watchdog();
@@ -334,6 +335,7 @@ void panic(const char *fmt, ...)
 	disabled_wait();
 #endif
 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
+	printk_flush_buffer();
 
 	/* Do not scroll important messages printed above */
 	suppress_printk = 1;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6296d34..96e7f07 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1875,6 +1875,59 @@ static void cont_add(int ctx, int cpu, u32 caller_id, int facility, int level,
 	}
 }
 
+/*
+ * Record key parameters used to print printk_ringbuffer
+ */
+static struct prb_info {
+	struct prb_iterator iter;
+	char *ext_text;
+	char *text;
+	char *buf;
+	u64 master_seq;
+} prb_info;
+void printk_flush_buffer(void)
+{
+	int ret;
+	size_t len;
+	size_t ext_len;
+	struct printk_log *msg;
+	struct prb_info *info;
+
+	info = &prb_info;
+	if (!info->ext_text || !info->text || !info->buf)
+		return;
+
+	do {
+		ret = prb_iter_next(&info->iter, info->buf,
+					 PRINTK_RECORD_MAX, &info->master_seq);
+		if (ret == -ERESTARTSYS) {
+			continue;
+		} else if (ret < 0) {
+			/* iterator invalid, start over */
+			prb_iter_init(&info->iter, &printk_rb, NULL);
+			continue;
+		} else if (ret == 0) {
+			break;
+		}
+
+		msg = (struct printk_log *)info->buf;
+		format_text(msg, info->master_seq, info->ext_text, &ext_len,
+				info->text, &len, printk_time);
+
+		//console_lock(); since printk thread may hold lock
+		call_console_drivers(info->master_seq, info->ext_text, ext_len,
+				info->text, len, msg->level, msg->facility);
+
+		if (len > 0 || ext_len > 0)
+			printk_delay(msg->level);
+	} while (ret != 0);
+
+	kfree(info->ext_text);
+	kfree(info->text);
+	kfree(info->buf);
+}
+EXPORT_SYMBOL(printk_flush_buffer);
+
 /* ring buffer used as memory allocator for temporary sprint buffers */
 DECLARE_STATIC_PRINTKRB(sprint_rb,
 			ilog2(PRINTK_RECORD_MAX + sizeof(struct prb_entry) +
@@ -2681,52 +2734,50 @@ late_initcall(printk_late_init);
 #if defined CONFIG_PRINTK
 static int printk_kthread_func(void *data)
 {
-	struct prb_iterator iter;
-	struct printk_log *msg;
-	size_t ext_len;
-	char *ext_text;
-	u64 master_seq;
-	size_t len;
-	char *text;
-	char *buf;
+
 	int ret;
+	size_t len;
+	size_t ext_len;
+	struct printk_log *msg;
+	struct prb_info *info;
 
-	ext_text = kmalloc(CONSOLE_EXT_LOG_MAX, GFP_KERNEL);
-	text = kmalloc(PRINTK_SPRINT_MAX, GFP_KERNEL);
-	buf = kmalloc(PRINTK_RECORD_MAX, GFP_KERNEL);
-	if (!ext_text || !text || !buf)
+	info = &prb_info;
+	info->ext_text = kmalloc(CONSOLE_EXT_LOG_MAX, GFP_KERNEL);
+	info->text = kmalloc(PRINTK_SPRINT_MAX, GFP_KERNEL);
+	info->buf = kmalloc(PRINTK_RECORD_MAX, GFP_KERNEL);
+	if (!info->ext_text || !info->text || !info->buf)
 		return -1;
 
-	prb_iter_init(&iter, &printk_rb, NULL);
+	prb_iter_init(&info->iter, &printk_rb, NULL);
 
 	/* the printk kthread never exits */
 	for (;;) {
-		ret = prb_iter_wait_next(&iter, buf,
-					 PRINTK_RECORD_MAX, &master_seq);
+		ret = prb_iter_wait_next(&info->iter, info->buf,
+					 PRINTK_RECORD_MAX, &info->master_seq);
 		if (ret == -ERESTARTSYS) {
 			continue;
 		} else if (ret < 0) {
 			/* iterator invalid, start over */
-			prb_iter_init(&iter, &printk_rb, NULL);
+			prb_iter_init(&info->iter, &printk_rb, NULL);
 			continue;
 		}
 
-		msg = (struct printk_log *)buf;
-		format_text(msg, master_seq, ext_text, &ext_len, text,
-			    &len, printk_time);
+		msg = (struct printk_log *)info->buf;
+		format_text(msg, info->master_seq, info->ext_text, &ext_len,
+				info->text, &len, printk_time);
 
 		console_lock();
 		console_may_schedule = 0;
-		call_console_drivers(master_seq, ext_text, ext_len, text, len,
-				     msg->level, msg->facility);
+		call_console_drivers(info->master_seq, info->ext_text, ext_len,
+				info->text, len, msg->level, msg->facility);
 		if (len > 0 || ext_len > 0)
 			printk_delay(msg->level);
 		console_unlock();
 	}
 
-	kfree(ext_text);
-	kfree(text);
-	kfree(buf);
+	kfree(info->ext_text);
+	kfree(info->text);
+	kfree(info->buf);
 
 	return 0;
 }
-- 
2.15.2

