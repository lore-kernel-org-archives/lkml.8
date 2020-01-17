Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791C6C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B8624681
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbgAQKKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:10:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55368 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbgAQKIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:08:51 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isOYX-0005Sk-NW; Fri, 17 Jan 2020 11:08:45 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 239431C19D1;
        Fri, 17 Jan 2020 11:08:42 +0100 (CET)
Date:   Fri, 17 Jan 2020 10:08:41 -0000
From:   "tip-bot2 for Yangtao Li" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] stop_machine: Make stop_cpus() static
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191228161912.24082-1-tiny.windzz@gmail.com>
References: <20191228161912.24082-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Message-ID: <157925572197.396.6580962318661308779.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     35f4cd96f5551dc1b2641159e7bb7bf91de6600f
Gitweb:        https://git.kernel.org/tip/35f4cd96f5551dc1b2641159e7bb7bf91de6600f
Author:        Yangtao Li <tiny.windzz@gmail.com>
AuthorDate:    Sat, 28 Dec 2019 16:19:12 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Jan 2020 10:19:21 +01:00

stop_machine: Make stop_cpus() static

The function stop_cpus() is only used internally by the
stop_machine for stop multiple cpus.

Make it static.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191228161912.24082-1-tiny.windzz@gmail.com
---
 include/linux/stop_machine.h |  9 ---------
 kernel/stop_machine.c        |  2 +-
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
index 648298f..76d8b09 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -32,7 +32,6 @@ int stop_one_cpu(unsigned int cpu, cpu_stop_fn_t fn, void *arg);
 int stop_two_cpus(unsigned int cpu1, unsigned int cpu2, cpu_stop_fn_t fn, void *arg);
 bool stop_one_cpu_nowait(unsigned int cpu, cpu_stop_fn_t fn, void *arg,
 			 struct cpu_stop_work *work_buf);
-int stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg);
 void stop_machine_park(int cpu);
 void stop_machine_unpark(int cpu);
 void stop_machine_yield(const struct cpumask *cpumask);
@@ -81,14 +80,6 @@ static inline bool stop_one_cpu_nowait(unsigned int cpu,
 	return false;
 }
 
-static inline int stop_cpus(const struct cpumask *cpumask,
-			    cpu_stop_fn_t fn, void *arg)
-{
-	if (cpumask_test_cpu(raw_smp_processor_id(), cpumask))
-		return stop_one_cpu(raw_smp_processor_id(), fn, arg);
-	return -ENOENT;
-}
-
 #endif	/* CONFIG_SMP */
 
 /*
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 5d68ec4..865bb02 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -442,7 +442,7 @@ static int __stop_cpus(const struct cpumask *cpumask,
  * @cpumask were offline; otherwise, 0 if all executions of @fn
  * returned 0, any non zero return value if any returned non zero.
  */
-int stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg)
+static int stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg)
 {
 	int ret;
 
