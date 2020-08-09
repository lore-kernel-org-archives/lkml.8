Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2B2C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 19:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E406206A2
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 19:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="G/gcuEL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgHITG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 15:06:28 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:47134 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726291AbgHITG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 15:06:28 -0400
Received: from iva8-d077482f1536.qloud-c.yandex.net (iva8-d077482f1536.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:2f26:0:640:d077:482f])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 2FE392E127E;
        Sun,  9 Aug 2020 22:06:25 +0300 (MSK)
Received: from iva4-7c3d9abce76c.qloud-c.yandex.net (iva4-7c3d9abce76c.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:7c3d:9abc])
        by iva8-d077482f1536.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id x8mVRy9JtI-6OvKrvxm;
        Sun, 09 Aug 2020 22:06:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1596999985; bh=bg8bt4sg63bFgRB6X7POdC9ro4upPz/aUusM1xmvRd4=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=G/gcuEL3rBRs5zZg9AVOyxOng5oT+Q1qPhyKen1Xf21bu/hCX75N0v/JsAeheJ4ID
         WUDGvCxF3QIQdKsr8hC+1XbwRHLbJzIZNAEo7u7hcFAASve/WEvQocoHf33waN6brs
         1An4ReVuiElNnxrNbklAZ4fdvBe1i+AysuqwYeNw=
Authentication-Results: iva8-d077482f1536.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 95.108.174.193-red.dhcp.yndx.net (95.108.174.193-red.dhcp.yndx.net [95.108.174.193])
        by iva4-7c3d9abce76c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id ktorfQ91zx-6OmWRtrg;
        Sun, 09 Aug 2020 22:06:24 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     koct9i@gmail.com, Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: [PATCH] lib/test_lockup.c: add parameters for cond_resched inside loop
Date:   Sun,  9 Aug 2020 19:06:15 +0000
Message-Id: <20200809190615.25647-1-dmtrmonakhov@yandex-team.ru>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

call_cond_resched_before=Y  call cond_resched with resource before wait
call_cond_resched_after=Y   call cond_resched with resource after wait
measure_cond_resched=Y      measure maximum cond_resched time inside loop

This simulate situation where process call cond_resched() with lock held.

Example demonstrate priority inversion issue with epbf-program, where
low priority task sheduled out while holding cgroup_mutex for a long
periods of time which blocks others programs with high priority.

CGROUP_MUTEX=$(gawk '$3 == "cgroup_mutex" {print "0x"$1}' /proc/kallsyms)
# Emulate ebpf-application load which can hung inside cgroup_bpf_attach()
nice -20 modprobe lib/test_lockup.ko \
      time_nsecs=1000 cooldown_nsecs=100000 iterations=100000 \
      lock_mutex_ptr=$CGROUP_MUTEX \
      measure_lock_wait=Y call_cond_resched_after=Y &

stress-ng -c $(nproc) --timeout 10s&
time mkdir /sys/fs/cgroup/blkio/a

Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
---
 lib/test_lockup.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/lib/test_lockup.c b/lib/test_lockup.c
index 0f81252..3e05d6e 100644
--- a/lib/test_lockup.c
+++ b/lib/test_lockup.c
@@ -77,6 +77,18 @@ static bool call_cond_resched;
 module_param(call_cond_resched, bool, 0600);
 MODULE_PARM_DESC(call_cond_resched, "call cond_resched() between iterations");
 
+static bool call_cond_resched_before;
+module_param(call_cond_resched_before, bool, 0600);
+MODULE_PARM_DESC(call_cond_resched_before, "call cond_resched() before wait");
+
+static bool call_cond_resched_after;
+module_param(call_cond_resched_after, bool, 0600);
+MODULE_PARM_DESC(call_cond_resched_after, "call cond_resched() after wait");
+
+static bool measure_cond_resched;
+module_param(measure_cond_resched, bool, 0400);
+MODULE_PARM_DESC(measure_cond_resched, "measure cond_resched time");
+
 static bool measure_lock_wait;
 module_param(measure_lock_wait, bool, 0400);
 MODULE_PARM_DESC(measure_lock_wait, "measure lock wait time");
@@ -162,6 +174,7 @@ MODULE_PARM_DESC(lock_sb_umount, "lock file -> sb -> s_umount");
 static atomic_t alloc_pages_failed = ATOMIC_INIT(0);
 
 static atomic64_t max_lock_wait = ATOMIC64_INIT(0);
+static atomic64_t max_cond_resched = ATOMIC64_INIT(0);
 
 static struct task_struct *main_task;
 static int master_cpu;
@@ -346,6 +359,22 @@ static void test_wait(unsigned int secs, unsigned int nsecs)
 	}
 }
 
+static void test_cond_resched(void)
+{
+	s64 cur, old_max;
+	s64 start = local_clock();
+
+	cond_resched();
+
+	cur  = local_clock() - start;
+	old_max = atomic64_read(&max_cond_resched);
+	do {
+		if (cur < old_max)
+			break;
+		old_max = atomic64_cmpxchg(&max_cond_resched, old_max, cur);
+	} while (old_max != cur);
+}
+
 static void test_lockup(bool master)
 {
 	u64 lockup_start = local_clock();
@@ -363,8 +392,14 @@ static void test_lockup(bool master)
 		if (iowait)
 			current->in_iowait = 1;
 
+		if (call_cond_resched_before)
+			test_cond_resched();
+
 		test_wait(time_secs, time_nsecs);
 
+		if (call_cond_resched_after)
+			test_cond_resched();
+
 		if (iowait)
 			current->in_iowait = 0;
 
@@ -497,6 +532,7 @@ static int __init test_lockup_init(void)
 
 	if ((wait_state != TASK_RUNNING ||
 	     (call_cond_resched && !reacquire_locks) ||
+	     call_cond_resched_before || call_cond_resched_after ||
 	     (alloc_pages_nr && gfpflags_allow_blocking(alloc_pages_gfp))) &&
 	    (test_disable_irq || disable_softirq || disable_preempt ||
 	     lock_rcu || lock_spinlock_ptr || lock_rwlock_ptr)) {
@@ -532,7 +568,7 @@ static int __init test_lockup_init(void)
 	if (test_lock_sb_umount && test_inode)
 		lock_rwsem_ptr = (unsigned long)&test_inode->i_sb->s_umount;
 
-	pr_notice("START pid=%d time=%u +%u ns cooldown=%u +%u ns iterations=%u state=%s %s%s%s%s%s%s%s%s%s%s%s\n",
+	pr_notice("START pid=%d time=%u +%u ns cooldown=%u +%u ns iterations=%u state=%s %s%s%s%s%s%s%s%s%s%s%s%s%s\n",
 		  main_task->pid, time_secs, time_nsecs,
 		  cooldown_secs, cooldown_nsecs, iterations, state,
 		  all_cpus ? "all_cpus " : "",
@@ -545,6 +581,8 @@ static int __init test_lockup_init(void)
 		  touch_softlockup ? "touch_softlockup " : "",
 		  touch_hardlockup ? "touch_hardlockup " : "",
 		  call_cond_resched ? "call_cond_resched " : "",
+		  call_cond_resched_before ? "call_cond_resched_before " : "",
+		  call_cond_resched_after ? "call_cond_resched_after " : "",
 		  reacquire_locks ? "reacquire_locks " : "");
 
 	if (alloc_pages_nr)
@@ -578,6 +616,10 @@ static int __init test_lockup_init(void)
 		pr_notice("Maximum lock wait: %lld ns\n",
 			  atomic64_read(&max_lock_wait));
 
+	if (measure_cond_resched)
+		pr_notice("Maximum cond resched time: %lld ns\n",
+			  atomic64_read(&max_cond_resched));
+
 	if (alloc_pages_nr)
 		pr_notice("Page allocation failed %u times\n",
 			  atomic_read(&alloc_pages_failed));
-- 
2.7.4

