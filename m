Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6AAC3F2CE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 04:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5FF24690
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 04:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYIN4TTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgB2EIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 23:08:12 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36792 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgB2EIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 23:08:12 -0500
Received: by mail-pj1-f66.google.com with SMTP id gv17so2097330pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 20:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v5PL0DckcMdjXI0OvIdNniFq0kiSP1GTTk9Nw356ENw=;
        b=RYIN4TTggFdbxLU73hgoFX90EogvSx9+RuGE+rVokerPN5Ubzfylnu4lC7yl4DzDkK
         mWIxkiuNXzP5y8FurNW3S5w9N//W3wPRfEm+ujHg4ohO5aFxHydkyrYtOhDfRQESs8OP
         XBpR8QKfmFxZK0lPx9vUy5BxeMgB/sXBXsM6MSywu8ee0p0KFXaDzQFkLUeum1iDQNNY
         4GjL0neyMaRWAMJMu+nz3L9dRkC/vdTIX4SyEJ+YnXpJPvLbvRfsWYXrjT1lwXXgZf4T
         G+LnhTuN+odaoWBuTr+SteTDXmIpNfi7zUJKaZGTRyKei7GyhtSsN95o3uy8sLG6uvNj
         +S7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v5PL0DckcMdjXI0OvIdNniFq0kiSP1GTTk9Nw356ENw=;
        b=GBYW0DGDcKKC6NhZRCux8ZvdSY2aiWCNlny8AnqMol7fWt2jLqCxnqiOYjUnAc9X+3
         V5rDSLRlbAJ/ci7RhR1rpsV7F45QMMAUw+WrkJiGKdeGf1Z4s7OXgEU1IxnFYQk4U0QV
         ufK5qIo2sYyJRSf8NNa1FTbwodMp4wevSHnCfR6/cwrvwhSNDYsKpcSnJcc9pcqT2gzQ
         lZDmrbUHyWfFxiM/Yl4ShfmhMahmVqxQG87NZrg/WKTu/rwbxeJ7BjzAP5LJurNS6AZ5
         BfT7BmvnpMLvkPtyBL+l6eqNPPPivePQd6+AojyESQNCnWmTc33bRx3iccThzEI4I166
         NYaw==
X-Gm-Message-State: ANhLgQ1uysxoH0Ytl880VM5mV5VVSgGogCjPlzkSjuYpSy2CuqGygAl5
        T14jEvcHRb8OxmdYVzXOEKI=
X-Google-Smtp-Source: ADFU+vtb97VnPqN3jjsuKI3W3y3H5u2PePmg/3qD9kKgIYW44EOcPkPr5terd5DbO1midXG+uCgNQA==
X-Received: by 2002:a17:90b:2301:: with SMTP id mt1mr4389931pjb.76.1582949289153;
        Fri, 28 Feb 2020 20:08:09 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id q187sm12535240pfq.185.2020.02.28.20.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 20:08:08 -0800 (PST)
Date:   Sat, 29 Feb 2020 13:08:06 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof =?utf-8?Q?Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        Pawel Lenkow <p.lenkow@camlintechnologies.com>,
        John Ogness <john.ogness@linutronix.de>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Regression in v4.19.106 breaking waking up of readers of
 /proc/kmsg and /dev/kmsg
Message-ID: <20200229040806.GA72248@google.com>
References: <20200227123633.GB962932@kroah.com>
 <42d3ce5c-5ffe-8e17-32a3-5127a6c7c7d8@camlintechnologies.com>
 <e9358218-98c9-2866-8f40-5955d093dc1b@camlintechnologies.com>
 <20200228031306.GO122464@google.com>
 <20200228100416.6bwathdtopwat5wy@pathway.suse.cz>
 <20200228105836.GA2913504@kroah.com>
 <20200228113214.kew4xi5tkbo7bpou@pathway.suse.cz>
 <20200228130217.rj6qge2en26bdp7b@pathway.suse.cz>
 <20200228205334.GF101220@mit.edu>
 <20200229033253.GA212847@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229033253.GA212847@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/29 12:32), Sergey Senozhatsky wrote:
> > I'm wondering now if we should revert this commit before 5.6 comes out
> > (it landed in 5.6-rc1).  "Is much less likely to happen given the
> > other random initialization patches" is not the same as "guaranteed
> > not to happen".
> > 
> > What do folks think?
> 
> Well, my 5 cents, there is nothing that prevents "too-early"
> printk_deferred() calls in the future. From that POV I'd probably
> prefer to "forbid" printk_deffered() to touch per-CPU deferred
> machinery until it's not "too early" anymore. Similar to what we
> do in printk_safe::queue_flush_work().

Informal patch

=====
Subject: [PATCH] printk: defer printk_deferred() until irq_work is ready

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 kernel/printk/internal.h    |  3 +++
 kernel/printk/printk.c      |  6 ++++++
 kernel/printk/printk_safe.c | 11 ++++++++---
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index c8e6ab689d42..2f051fb83c00 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -23,6 +23,8 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args);
 void __printk_safe_enter(void);
 void __printk_safe_exit(void);
 
+bool printk_irq_work_ready(void);
+
 #define printk_safe_enter_irqsave(flags)	\
 	do {					\
 		local_irq_save(flags);		\
@@ -64,4 +66,5 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
 #define printk_safe_enter_irq() local_irq_disable()
 #define printk_safe_exit_irq() local_irq_enable()
 
+bool printk_irq_work_ready(void) { return false; }
 #endif /* CONFIG_PRINTK */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ad4606234545..bb545c86124e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3009,6 +3009,9 @@ static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) = {
 
 void wake_up_klogd(void)
 {
+	if (!printk_irq_work_ready())
+		return;
+
 	preempt_disable();
 	if (waitqueue_active(&log_wait)) {
 		this_cpu_or(printk_pending, PRINTK_PENDING_WAKEUP);
@@ -3019,6 +3022,9 @@ void wake_up_klogd(void)
 
 void defer_console_output(void)
 {
+	if (!printk_irq_work_ready())
+		return;
+
 	preempt_disable();
 	__this_cpu_or(printk_pending, PRINTK_PENDING_OUTPUT);
 	irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index b4045e782743..5d2c282984d0 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -27,7 +27,7 @@
  * There are situations when we want to make sure that all buffers
  * were handled or when IRQs are blocked.
  */
-static int printk_safe_irq_ready __read_mostly;
+static bool __printk_irq_work_ready __read_mostly;
 
 #define SAFE_LOG_BUF_LEN ((1 << CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT) -	\
 				sizeof(atomic_t) -			\
@@ -48,10 +48,15 @@ static DEFINE_PER_CPU(int, printk_context);
 static DEFINE_PER_CPU(struct printk_safe_seq_buf, nmi_print_seq);
 #endif
 
+bool printk_irq_work_ready(void)
+{
+	return __printk_irq_work_ready;
+}
+
 /* Get flushed in a more safe context. */
 static void queue_flush_work(struct printk_safe_seq_buf *s)
 {
-	if (printk_safe_irq_ready)
+	if (printk_irq_work_ready())
 		irq_work_queue(&s->work);
 }
 
@@ -408,7 +413,7 @@ void __init printk_safe_init(void)
 	 * variable is set.
 	 */
 	barrier();
-	printk_safe_irq_ready = 1;
+	__printk_irq_work_ready = true;
 
 	/* Flush pending messages that did not have scheduled IRQ works. */
 	printk_safe_flush();
-- 
2.25.0.265.gbab2e86ba0-goog

