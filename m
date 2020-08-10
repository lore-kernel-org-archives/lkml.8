Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1370C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F5722073E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="tkK5Cfok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgHJHYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 03:24:43 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:35494 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725911AbgHJHYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 03:24:42 -0400
Received: from vla1-fdfb804fb3f3.qloud-c.yandex.net (vla1-fdfb804fb3f3.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:3199:0:640:fdfb:804f])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 8931B2E126D;
        Mon, 10 Aug 2020 10:24:38 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
        by vla1-fdfb804fb3f3.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id 5LOezUMGBy-ObwOeiSE;
        Mon, 10 Aug 2020 10:24:38 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1597044278; bh=ZWfU/KIYRh2EbJ1Zuh32IQ5SqNMpfEy9pAR/vYry/3M=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=tkK5CfokMhEgA5OFPeSdtRTyPaeH5rOVZr26KuiSmQMqJmKPiYBDUhW4P19nkCU4q
         uG6OKH3iTjHm/ZlVzPf3PBI8xd+BADXt9bmdmyXqERYG70N8RkLl8XaR7PmO77y2Zn
         LQSuV6T4hUgqemEO3XYDxBlM6OMJuZMoglgCMyXU=
Authentication-Results: vla1-fdfb804fb3f3.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 95.108.174.193-red.dhcp.yndx.net (95.108.174.193-red.dhcp.yndx.net [95.108.174.193])
        by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Lyi483T9f9-ObjiqUQh;
        Mon, 10 Aug 2020 10:24:37 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     koct9i@gmail.com, Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: [PATCH 2/2] lib/test_lockup.c: allow cond_resched inside iteration
Date:   Mon, 10 Aug 2020 07:24:26 +0000
Message-Id: <20200810072426.7180-2-dmtrmonakhov@yandex-team.ru>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200810072426.7180-1-dmtrmonakhov@yandex-team.ru>
References: <20200810072426.7180-1-dmtrmonakhov@yandex-team.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- New options:
  cond_resched_inside=Y  call cond_resched inside iteration under lock
  measure_lockup=Y       measure maximum lockup time

- Rename option:
  call_cond_resched=Y -> cond_resched_outside=Y: call cond_resched()
                                                 between iterations.

This allow us to simulate situation where process call cond_resched()
with locks held.

Example demonstrate priority inversion issue with epbf-program, where
low priority task sheduled out while holding cgroup_mutex for a long
periods of time which blocks others high priority tasks.

CGROUP_MUTEX=$(gawk '$3 == "cgroup_mutex" {print "0x"$1}' /proc/kallsyms)
# Emulate ebpf-applications load which can hung inside cgroup_bpf_attach()
nice -20 modprobe lib/test_lockup.ko \
      time_nsecs=1000 cooldown_nsecs=100000 iterations=100000 \
      lock_mutex_ptr=$CGROUP_MUTEX reacquire_locks=Y\
      cond_resched_inside=Y measure_lockup=Y &

stress-ng -c $(nproc) --timeout 10s&
time mkdir /sys/fs/cgroup/blkio/a
time rmdir /sys/fs/cgroup/blkio/a

Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
---
 lib/test_lockup.c | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/lib/test_lockup.c b/lib/test_lockup.c
index 867b2f4..5666c00 100644
--- a/lib/test_lockup.c
+++ b/lib/test_lockup.c
@@ -73,9 +73,13 @@ static bool touch_hardlockup;
 module_param(touch_hardlockup, bool, 0600);
 MODULE_PARM_DESC(touch_hardlockup, "touch hard-lockup watchdog between iterations");
 
-static bool call_cond_resched;
-module_param(call_cond_resched, bool, 0600);
-MODULE_PARM_DESC(call_cond_resched, "call cond_resched() between iterations");
+static bool cond_resched_inside;
+module_param(cond_resched_inside, bool, 0600);
+MODULE_PARM_DESC(cond_resched_inside, "call cond_resched() during iteration");
+
+static bool cond_resched_outside;
+module_param(cond_resched_outside, bool, 0600);
+MODULE_PARM_DESC(cond_resched_outside, "call cond_resched() between iterations");
 
 static bool measure_alloc_pages_wait;
 module_param(measure_alloc_pages_wait, bool, 0400);
@@ -85,6 +89,10 @@ static bool measure_lock_wait;
 module_param(measure_lock_wait, bool, 0400);
 MODULE_PARM_DESC(measure_lock_wait, "measure lock wait time");
 
+static bool measure_lockup;
+module_param(measure_lockup, bool, 0400);
+MODULE_PARM_DESC(measure_lockup, "measure maximum lockup time");
+
 static unsigned long lock_wait_threshold = ULONG_MAX;
 module_param(lock_wait_threshold, ulong, 0400);
 MODULE_PARM_DESC(lock_wait_threshold, "print lock wait time longer than this in nanoseconds, default off");
@@ -167,6 +175,7 @@ static atomic_t alloc_pages_failed = ATOMIC_INIT(0);
 
 static atomic64_t max_lock_wait = ATOMIC64_INIT(0);
 static atomic64_t max_alloc_pages_wait = ATOMIC64_INIT(0);
+static atomic64_t max_lockup_time = ATOMIC64_INIT(0);
 
 static struct task_struct *main_task;
 static int master_cpu;
@@ -369,6 +378,7 @@ static void test_wait(unsigned int secs, unsigned int nsecs)
 static void test_lockup(bool master)
 {
 	u64 lockup_start = local_clock();
+	u64 iter_start;
 	unsigned int iter = 0;
 	LIST_HEAD(pages);
 
@@ -379,12 +389,18 @@ static void test_lockup(bool master)
 	test_alloc_pages(&pages);
 
 	while (iter++ < iterations && !signal_pending(main_task)) {
+		s64 cur_lockup, max_lockup;
+
+		iter_start = local_clock();
 
 		if (iowait)
 			current->in_iowait = 1;
 
 		test_wait(time_secs, time_nsecs);
 
+		if (cond_resched_inside)
+			cond_resched();
+
 		if (iowait)
 			current->in_iowait = 0;
 
@@ -400,7 +416,15 @@ static void test_lockup(bool master)
 		if (touch_hardlockup)
 			touch_nmi_watchdog();
 
-		if (call_cond_resched)
+		cur_lockup  = local_clock() - iter_start;
+		max_lockup = atomic64_read(&max_lockup_time);
+		do {
+			if (cur_lockup < max_lockup)
+				break;
+			max_lockup = atomic64_cmpxchg(&max_lockup_time, max_lockup, cur_lockup);
+		} while (max_lockup != cur_lockup);
+
+		if (cond_resched_outside)
 			cond_resched();
 
 		test_wait(cooldown_secs, cooldown_nsecs);
@@ -515,8 +539,8 @@ static int __init test_lockup_init(void)
 		return -EINVAL;
 #endif
 
-	if ((wait_state != TASK_RUNNING ||
-	     (call_cond_resched && !reacquire_locks) ||
+	if ((wait_state != TASK_RUNNING || cond_resched_inside ||
+	     (cond_resched_outside && !reacquire_locks) ||
 	     (alloc_pages_nr && gfpflags_allow_blocking(alloc_pages_gfp))) &&
 	    (test_disable_irq || disable_softirq || disable_preempt ||
 	     lock_rcu || lock_spinlock_ptr || lock_rwlock_ptr)) {
@@ -552,7 +576,7 @@ static int __init test_lockup_init(void)
 	if (test_lock_sb_umount && test_inode)
 		lock_rwsem_ptr = (unsigned long)&test_inode->i_sb->s_umount;
 
-	pr_notice("START pid=%d time=%u +%u ns cooldown=%u +%u ns iterations=%u state=%s %s%s%s%s%s%s%s%s%s%s%s\n",
+	pr_notice("START pid=%d time=%u +%u ns cooldown=%u +%u ns iterations=%u state=%s %s%s%s%s%s%s%s%s%s%s%s%s\n",
 		  main_task->pid, time_secs, time_nsecs,
 		  cooldown_secs, cooldown_nsecs, iterations, state,
 		  all_cpus ? "all_cpus " : "",
@@ -564,7 +588,8 @@ static int __init test_lockup_init(void)
 		  lock_read ? "lock_read " : "",
 		  touch_softlockup ? "touch_softlockup " : "",
 		  touch_hardlockup ? "touch_hardlockup " : "",
-		  call_cond_resched ? "call_cond_resched " : "",
+		  cond_resched_inside ? "cond_resched_inside " : "",
+		  cond_resched_outside ? "cond_resched_outside " : "",
 		  reacquire_locks ? "reacquire_locks " : "");
 
 	if (alloc_pages_nr)
@@ -605,6 +630,10 @@ static int __init test_lockup_init(void)
 			pr_notice("Maximum pages allocation wait: %lld ns\n",
 				  atomic64_read(&max_alloc_pages_wait));
 	}
+	if (measure_lockup)
+		pr_notice("Maximum lockup time: %lld ns\n",
+			  atomic64_read(&max_lockup_time));
+
 	pr_notice("FINISH in %llu ns\n", local_clock() - test_start);
 
 	if (test_file)
-- 
2.7.4

