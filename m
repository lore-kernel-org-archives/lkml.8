Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714CDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 04:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A60020771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 04:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMcx2+Si"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgGWEy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 00:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGWEy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 00:54:27 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C816C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 21:54:27 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l23so4301144qkk.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 21:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P14GbACJ+OjyBXfMSzdOi6HSYggpVvnS8D4dSW8o1fI=;
        b=eMcx2+SiGg9HS6w7NvoqKzadh3LYe+4OTX3sLOByMdX5sDRQcSLKsqYPgnG/pYqG1x
         bh681HS4zgqFaXTyD2Y2y+es1BeFoDeMoYW+TVrfsPC9UkOEDhCeGwRfP1rOzbkfNyi4
         6g/puAQTjTzZJXP6Qs63zBAAIhxQrdKKl9LfZZS89QEivxvAtuTpi8EIn1kzvE8F6STP
         jvEnsqvz8dDYl43rWLbNyAT+WrKHg5ESxtJC3XsHhcIp8V7Xz42NxlIB4dtvsJ1T/vzY
         L3W+IIpRPdO8V6KeUUdwurwgKxpMlojRmFNOgSmuUvNxMVJvoVSxY56cjQty1puVTvIR
         d5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P14GbACJ+OjyBXfMSzdOi6HSYggpVvnS8D4dSW8o1fI=;
        b=axqAxDdMn196PxrEZFGFFaIU6e2xHVqWdcp0Fem3gNHQFkBAecYUZlP8m8I+3m/Fvx
         fJtm3bX02iRosRz0X3ig6XO2cUOt9hFLf6VUa20Up6+ImQHoCqZsv+qgMptcsgjQslwX
         LnJEAzewa2srtrpoA0tOnc088nx9M0T6oZYUVDZ5GRy1tNS6FihtZVhYBWbBqTCtsIGr
         mdhskjaTlyICxUWz6y323oTzyOfGj7cGuRJggKUv4zdJgqNjRHlL+6U0rgC7SiWw4iPY
         O8inOZWlK7WMsaas1cOc4ZjgG05iwD84yb3bnjVCG9sJdE4BMiV1JGvQjNC16LXXlSwC
         fi3A==
X-Gm-Message-State: AOAM532Fj3pGGKZeFdqYtprM88/7rToLfptzb+uxAqAOcktUuiTWFIey
        GhWwlyjIbQb82lbpzwnkYyE=
X-Google-Smtp-Source: ABdhPJxd/BPaWdg8hcGwaltkoCMk9/DKblV2svbvFdMaHYDl2OViM0U40BbIPBHlpH492OKOy2wiPQ==
X-Received: by 2002:a37:9987:: with SMTP id b129mr3337996qke.315.1595480066725;
        Wed, 22 Jul 2020 21:54:26 -0700 (PDT)
Received: from dev.localdomain ([183.134.211.52])
        by smtp.gmail.com with ESMTPSA id p186sm1819858qkf.33.2020.07.22.21.54.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2020 21:54:26 -0700 (PDT)
From:   qianjun.kernel@gmail.com
To:     tglx@linutronix.de, peterz@infradead.org, will@kernel.org,
        luto@kernel.org, urezki@gmail.com, linux-kernel@vger.kernel.org
Cc:     laoar.shao@gmail.com, jun qian <qianjun.kernel@gmail.com>
Subject: [PATCH V3] Softirq:avoid large sched delay from the pending softirqs
Date:   Thu, 23 Jul 2020 00:54:01 -0400
Message-Id: <1595480041-10597-1-git-send-email-qianjun.kernel@gmail.com>
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
 kernel/softirq.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index c4201b7f..8f47554 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -200,17 +200,15 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 /*
  * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
  * but break the loop if need_resched() is set or after 2 ms.
- * The MAX_SOFTIRQ_TIME provides a nice upper bound in most cases, but in
- * certain cases, such as stop_machine(), jiffies may cease to
- * increment and so we need the MAX_SOFTIRQ_RESTART limit as
- * well to make sure we eventually return from this method.
+ * In the loop, if the processing time of the softirq has exceeded 2
+ * milliseconds, we also need to break the loop to wakeup the ksofirqd.
  *
  * These limits have been established via experimentation.
  * The two things to balance is latency against fairness -
  * we want to handle softirqs as soon as possible, but they
  * should not be able to lock up the box.
  */
-#define MAX_SOFTIRQ_TIME  msecs_to_jiffies(2)
+#define MAX_SOFTIRQ_TIME_NS 2000000
 #define MAX_SOFTIRQ_RESTART 10
 
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -248,7 +246,7 @@ static inline void lockdep_softirq_end(bool in_hardirq) { }
 
 asmlinkage __visible void __softirq_entry __do_softirq(void)
 {
-	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
+	ktime_t end = ktime_get() + MAX_SOFTIRQ_TIME_NS;
 	unsigned long old_flags = current->flags;
 	int max_restart = MAX_SOFTIRQ_RESTART;
 	struct softirq_action *h;
@@ -299,6 +297,13 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		}
 		h++;
 		pending >>= softirq_bit;
+
+		/*
+		 * the softirq's action has been running for too much time
+		 * so it may need to wakeup the ksoftirqd
+		 */
+		if (need_resched() && ktime_get() > end)
+			break;
 	}
 
 	if (__this_cpu_read(ksoftirqd) == current)
@@ -307,8 +312,8 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 	pending = local_softirq_pending();
 	if (pending) {
-		if (time_before(jiffies, end) && !need_resched() &&
-		    --max_restart)
+		if (!need_resched() && --max_restart &&
+		    ktime_get() <= end)
 			goto restart;
 
 		wakeup_softirqd();
-- 
1.8.3.1

