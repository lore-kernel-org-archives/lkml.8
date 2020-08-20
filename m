Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BECC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 708C52078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgHTIrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:47:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:54708 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgHTIrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:47:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7033AAFFD;
        Thu, 20 Aug 2020 08:48:06 +0000 (UTC)
Date:   Thu, 20 Aug 2020 10:47:38 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, kexec@lists.infradead.org
Subject: Re: [patch 0/2] timekeeping: NMI safe timekeeper enhancements
Message-ID: <20200820084738.GD4353@alley>
References: <20200814101933.574326079@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814101933.574326079@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-08-14 12:19:33, Thomas Gleixner wrote:
> printk intends to store various timestamps (MONOTONIC, REALTIME, BOOTTIME)
> to make correlation of dmesg accross different machines easier.
> 
> The NMI safe timekeeper allows to retrieve these timestamps from any
> context.

For both patches:

Tested-by: Petr Mladek <pmladek@suse.com>

I am not familiar with the timekeeping code so that I could not
provide a valuable review. Anyway, the patches seem to work
as expected.

The interface is perfectly fine for printk() needs.


I tested them with the patch below. The first timestamps appear
as early as before:

[    0.000000] [    0.000000][1970-01-01T00:00:00][    T0] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] [    0.000000][1970-01-01T00:00:00][    T0] kvm-clock: cpu 0, msr 129c01001, primary cpu clock
[    0.000000] [    0.000000][1970-01-01T00:00:00][    T0] kvm-clock: using sched offset of 56519600356309 cycles
[    0.000008] [    0.000008][1970-01-01T00:00:00][    T0] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000022] [    0.000022][1970-01-01T00:00:00][    T0] tsc: Detected 2112.000 MHz processor
[    0.000835] [    0.000835][1970-01-01T00:00:00][    T0] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved

The realtime timestamps get ready later as expected:

[    0.073075] [    0.073075][1970-01-01T00:00:00][    T0] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=3
[    0.075847] [    0.075847][1970-01-01T00:00:00][    T0] NR_IRQS: 524544, nr_irqs: 448, preallocated irqs: 16
[    0.076014] [    0.076014][2020-08-20T07:58:46][    T0] Console: colour dummy device 80x25
[    0.076014] [    0.076014][2020-08-20T07:58:46][    T0] printk: console [tty0] enabled

Also suspend resume seems to work as expected. I tested it the follwing way:

echo core > /sys/power/pm_test
echo reboot > /sys/power/disk
echo disk > /sys/power/state

and the result is:

[  224.422540] [  224.422540][2020-08-20T08:02:31][ T5124] Disabling non-boot CPUs ...
[  224.424171] [  224.424171][2020-08-20T08:02:31][   T15] IRQ fixup: irq 21 move in progress, old vector 36
[  224.425304] [  224.425304][2020-08-20T08:02:31][ T5124] smpboot: CPU 1 is now offline
[  224.426664] [  224.426664][2020-08-20T08:02:31][   T20] IRQ 21: no longer affine to CPU2
[  224.426685] [  224.426685][2020-08-20T08:02:31][   T20] IRQ 24: no longer affine to CPU2
[  224.426717] [  224.426717][2020-08-20T08:02:31][   T20] IRQ 27: no longer affine to CPU2
[  224.427765] [  224.427765][2020-08-20T08:02:31][ T5124] smpboot: CPU 2 is now offline
[  224.428016] [  224.428016][2020-08-20T08:02:31][ T5124] PM: hibernation: debug: Waiting for 5 seconds.
[  224.428218] [  229.618141][2020-08-20T08:02:36][ T5124] Enabling non-boot CPUs ...
   ^^^            ^^^                          ^^
[  224.428560] [  229.618483][2020-08-20T08:02:36][ T5124] x86: Booting SMP configuration:
[  224.428564] [  229.618486][2020-08-20T08:02:36][ T5124] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  224.428766] [  229.618688][2020-08-20T08:02:36][    T0] kvm-clock: cpu 1, msr 129c01041, secondary cpu clock
[  224.449192] [  229.639115][2020-08-20T08:02:36][   T14] kvm-guest: stealtime: cpu 1, msr 17fbf2080


And here is the patch that I used for testing:

From 39bdfebfa94fc55616fe23f2f0b80e06479b65e0 Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Thu, 20 Aug 2020 10:18:57 +0200
Subject: [PATCH] printk: Test using all three timestamps: mono, boot, real

Test timekeeper enhancements proposed at
https://lore.kernel.org/r/20200814101933.574326079@linutronix.de

Allow to store and show all three timestamp (mono, boot, real).

It is not final solution. The prefix takes 83 characters that might
make the real text invisible or hard to read. Fragments of seconds
are lost in when printing real time timestamp. Offset is not provided
for crashdump tools.

Only syslog interface is supported. The log can be seen on consoles
or via:

    dmesg -S

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9b75f6bfc333..329f3595b024 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -366,7 +366,7 @@ enum log_flags {
 };
 
 struct printk_log {
-	u64 ts_nsec;		/* timestamp in nanoseconds */
+	struct ktime_timestamps ts; /* timestamps */
 	u16 len;		/* length of entire record */
 	u16 text_len;		/* length of text buffer */
 	u16 dict_len;		/* length of dictionary buffer */
@@ -443,7 +443,7 @@ static u64 clear_seq;
 static u32 clear_idx;
 
 #ifdef CONFIG_PRINTK_CALLER
-#define PREFIX_MAX		48
+#define PREFIX_MAX		48+14+21
 #else
 #define PREFIX_MAX		32
 #endif
@@ -614,7 +614,7 @@ static u32 truncate_msg(u16 *text_len, u16 *trunc_msg_len,
 
 /* insert record into the buffer, discard old ones, update heads */
 static int log_store(u32 caller_id, int facility, int level,
-		     enum log_flags flags, u64 ts_nsec,
+		     enum log_flags flags, struct ktime_timestamps *ts,
 		     const char *dict, u16 dict_len,
 		     const char *text, u16 text_len)
 {
@@ -657,10 +657,10 @@ static int log_store(u32 caller_id, int facility, int level,
 	msg->facility = facility;
 	msg->level = level & 7;
 	msg->flags = flags & 0x1f;
-	if (ts_nsec > 0)
-		msg->ts_nsec = ts_nsec;
+	if (ts)
+		msg->ts = *ts;
 	else
-		msg->ts_nsec = local_clock();
+		ktime_get_fast_timestamps(&msg->ts);
 #ifdef CONFIG_PRINTK_CALLER
 	msg->caller_id = caller_id;
 #endif
@@ -726,7 +726,7 @@ static void append_char(char **pp, char *e, char c)
 static ssize_t msg_print_ext_header(char *buf, size_t size,
 				    struct printk_log *msg, u64 seq)
 {
-	u64 ts_usec = msg->ts_nsec;
+	u64 ts_usec = msg->ts.mono;
 	char caller[20];
 #ifdef CONFIG_PRINTK_CALLER
 	u32 id = msg->caller_id;
@@ -1090,8 +1090,8 @@ void log_buf_vmcoreinfo_setup(void)
 	 * parse it and detect any changes to structure down the line.
 	 */
 	VMCOREINFO_STRUCT_SIZE(printk_log);
-	VMCOREINFO_OFFSET(printk_log, ts_nsec);
-	VMCOREINFO_OFFSET(printk_log, len);
+/*	VMCOREINFO_OFFSET(printk_log, ts);
+ */	VMCOREINFO_OFFSET(printk_log, len);
 	VMCOREINFO_OFFSET(printk_log, text_len);
 	VMCOREINFO_OFFSET(printk_log, dict_len);
 #ifdef CONFIG_PRINTK_CALLER
@@ -1308,6 +1308,14 @@ static size_t print_time(u64 ts, char *buf)
 		       (unsigned long)ts, rem_nsec / 1000);
 }
 
+static size_t print_real_time(u64 ts, char *buf)
+{
+	u64 ts_nsec = ts / 1000000000;
+
+	return sprintf(buf, "[%ptT]", &ts_nsec);
+}
+
+
 #ifdef CONFIG_PRINTK_CALLER
 static size_t print_caller(u32 id, char *buf)
 {
@@ -1329,8 +1337,12 @@ static size_t print_prefix(const struct printk_log *msg, bool syslog,
 	if (syslog)
 		len = print_syslog((msg->facility << 3) | msg->level, buf);
 
-	if (time)
-		len += print_time(msg->ts_nsec, buf + len);
+
+	if (time) {
+		len += print_time(msg->ts.mono, buf + len);
+		len += print_time(msg->ts.boot, buf + len);
+		len += print_real_time(msg->ts.real, buf + len);
+	}
 
 	len += print_caller(msg->caller_id, buf + len);
 
@@ -1855,7 +1867,7 @@ static struct cont {
 	char buf[LOG_LINE_MAX];
 	size_t len;			/* length == 0 means unused buffer */
 	u32 caller_id;			/* printk_caller_id() of first print */
-	u64 ts_nsec;			/* time of first print */
+	struct ktime_timestamps ts;	/* time of first print */
 	u8 level;			/* log level of first message */
 	u8 facility;			/* log facility of first message */
 	enum log_flags flags;		/* prefix, newline flags */
@@ -1867,7 +1879,7 @@ static void cont_flush(void)
 		return;
 
 	log_store(cont.caller_id, cont.facility, cont.level, cont.flags,
-		  cont.ts_nsec, NULL, 0, cont.buf, cont.len);
+		  &cont.ts, NULL, 0, cont.buf, cont.len);
 	cont.len = 0;
 }
 
@@ -1884,7 +1896,7 @@ static bool cont_add(u32 caller_id, int facility, int level,
 		cont.facility = facility;
 		cont.level = level;
 		cont.caller_id = caller_id;
-		cont.ts_nsec = local_clock();
+		ktime_get_fast_timestamps(&cont.ts);
 		cont.flags = flags;
 	}
 
-- 
2.26.2

