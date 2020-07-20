Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87528C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E4C722BF3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/6oWHkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgGTNJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgGTNJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:09:16 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485B7C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 06:09:16 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id el4so7289435qvb.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 06:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9iUiA8hpgrDue90CgbblWZY/7YeOJPzjCeM5ckVrY1o=;
        b=Q/6oWHkT/ivwRAxTtYJvdOJcYL8Xf3L06SwHehsI1GfbZL185vxDgHM/In9RtGpDLc
         UvN/UFAmt0lUnsNQsbAxf8L1pjx5PRLxAmLCKmkdAaER+Hx6KHl2ltIsW5VCJ9HG7xqW
         4WX+JAUHxNoamAIO8vlAiCayK810vZJIBnP40wy5CfHNf0ddNnV23QIPsVwT5tg0FV1c
         0cUFRFQv6rgX7OmTX47t7memG3C/pT5fSiJzNYKs7IKfskju1Z+/AchH8bxeiE6DbfFW
         5BHGnX0MChaDEffuX6G2LE9u1X10MQtZfO9iaeul1I0abWCmhZsvr1IRgjDFdbXPLJ8V
         B40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9iUiA8hpgrDue90CgbblWZY/7YeOJPzjCeM5ckVrY1o=;
        b=gNfM+8xR0PB147fQB9N5pVp/QsWC+lZmmuLFw36SQSWVNJsegCReQIR849IBShX12S
         hTkOTDZ3OjorFjpToE5DEUn04J6yvS3ddw+fanwM7nTvCkslx/rftwwHgTOSRpv6+ZX5
         PbuwMQ6O2IuZH7TujNNGqQTAxde2bhDER2y7cPUz1U1COopMaJVJdxHRauoE1QOPiPZW
         i/cf8T8F5D3wAx5WNulwSEmSBs9fkVny3sSGW7HDqRYvEQKsrUoCkeuspKlvPiVUI49o
         g2L3NYYv1DxFU69G48bKbbURxUUiTZHQ/f4tgXE81+B5U10xRxNN9DLLvMmEb9GdI88C
         Ds2A==
X-Gm-Message-State: AOAM532gv0wjtIl9I/1Eu9jjbZIy09yfTqDmtd38pqZirwdQVfKuGr/g
        Gg017VJayb8wnxCbqWjDuxN+Pz437rM=
X-Google-Smtp-Source: ABdhPJw4M2ba7QQF6Z5FhfI2i9qg0slIoAwZx1n3HURnfc05dAwAHo7sYx4+TNWB+JmG1CK06po+BA==
X-Received: by 2002:ad4:4a6d:: with SMTP id cn13mr22174125qvb.165.1595250555525;
        Mon, 20 Jul 2020 06:09:15 -0700 (PDT)
Received: from dev.localdomain ([183.134.211.54])
        by smtp.gmail.com with ESMTPSA id p36sm19943574qte.90.2020.07.20.06.09.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2020 06:09:14 -0700 (PDT)
From:   qianjun.kernel@gmail.com
To:     tglx@linutronix.de, peterz@infradead.org, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org, urezki@gmail.com
Cc:     laoar.shao@gmail.com, jun qian <qianjun.kernel@gmail.com>
Subject: [RFC PATCH v2] Softirq:avoid large sched delay from the pending softirqs
Date:   Mon, 20 Jul 2020 09:08:26 -0400
Message-Id: <1595250506-9769-1-git-send-email-qianjun.kernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jun qian <qianjun.kernel@gmail.com>

When get the pending softirqs, it need to process all the pending
softirqs in the while loop. If the processing time of each pending
softirq is need more than 2 msec in this loop, or one of the softirq
will running a long time, according to the original code logic, it
will process all the pending softirqs without wakeuping ksoftirqd,
which will cause a relatively large scheduling delay on the
corresponding CPU, which we do not wish to see. The patch will check
the total time to process pending softirq, if the time exceeds 2 ms
we need to wakeup the ksofirqd to aviod large sched delay.

Signed-off-by: jun qian <qianjun.kernel@gmail.com>
---
 kernel/softirq.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index c4201b7f..f8e5be9 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -210,7 +210,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
  * we want to handle softirqs as soon as possible, but they
  * should not be able to lock up the box.
  */
-#define MAX_SOFTIRQ_TIME  msecs_to_jiffies(2)
+#define MAX_SOFTIRQ_TIME 2000	/* In microseconds */
 #define MAX_SOFTIRQ_RESTART 10
 
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -248,7 +248,8 @@ static inline void lockdep_softirq_end(bool in_hardirq) { }
 
 asmlinkage __visible void __softirq_entry __do_softirq(void)
 {
-	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
+	ktime_t end, start;
+	s64 delta;
 	unsigned long old_flags = current->flags;
 	int max_restart = MAX_SOFTIRQ_RESTART;
 	struct softirq_action *h;
@@ -256,6 +257,8 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	__u32 pending;
 	int softirq_bit;
 
+	start = ktime_get();
+
 	/*
 	 * Mask out PF_MEMALLOC as the current task context is borrowed for the
 	 * softirq. A softirq handled, such as network RX, might set PF_MEMALLOC
@@ -299,6 +302,15 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		}
 		h++;
 		pending >>= softirq_bit;
+
+		end = ktime_get();
+		delta = ktime_to_us(end - start);
+		/*
+		 * the softirq's action has been running for too much time
+		 * so it may need to wakeup the ksoftirqd
+		 */
+		if (delta > MAX_SOFTIRQ_TIME && need_resched())
+			break;
 	}
 
 	if (__this_cpu_read(ksoftirqd) == current)
@@ -307,7 +319,9 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 	pending = local_softirq_pending();
 	if (pending) {
-		if (time_before(jiffies, end) && !need_resched() &&
+		end = ktime_get();
+		delta = ktime_to_us(end - start);
+		if (delta < MAX_SOFTIRQ_TIME && !need_resched() &&
 		    --max_restart)
 			goto restart;
 
-- 
1.8.3.1

