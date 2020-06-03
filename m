Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6EBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C589D20738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgFCOT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:19:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5848 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725930AbgFCOT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:19:28 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1A584F554C894F8F56DA;
        Wed,  3 Jun 2020 22:19:26 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 3 Jun 2020
 22:19:15 +0800
From:   Cheng Jian <cj.chengjian@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <cj.chengjian@huawei.com>, <chenwandun@huawei.com>,
        <xiexiuqi@huawei.com>, <bobo.shaobowang@huawei.com>,
        <huawei.libin@huawei.com>, <pmladek@suse.com>,
        <sergey.senozhatsky@gmail.com>, <rostedt@goodmis.org>
Subject: [RFC PATCH] panic: fix deadlock in panic()
Date:   Wed, 3 Jun 2020 14:19:15 +0000
Message-ID: <20200603141915.38739-1-cj.chengjian@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 A deadlock caused by logbuf_lock occurs when panic:

	a) Panic CPU is running in non-NMI context
	b) Panic CPU sends out shutdown IPI via NMI vector
	c) One of the CPUs that we bring down via NMI vector holded logbuf_lock
	d) Panic CPU try to hold logbuf_lock, then deadlock occurs.

we try to re-init the logbuf_lock in printk_safe_flush_on_panic()
to avoid deadlock, but it does not work here, because :

Firstly, it is inappropriate to check num_online_cpus() here.
When the CPU bring down via NMI vector, the panic CPU willn't
wait too long for other cores to stop, so when this problem
occurs, num_online_cpus() may be greater than 1.

Secondly, printk_safe_flush_on_panic() is called after panic
notifier callback, so if printk() is called in panic notifier
callback, deadlock will still occurs. Eg, if ftrace_dump_on_oops
is set, we print some debug information, it will try to hold the
logbuf_lock.

To avoid this deadlock, drop the num_online_cpus() check and call
the printk_safe_flush_on_panic() before panic_notifier_list callback,
attempt to re-init logbuf_lock from panic CPU.

Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
---
 kernel/panic.c              | 3 +++
 kernel/printk/printk_safe.c | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index b69ee9e76cb2..8dbcb2227b60 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -255,6 +255,9 @@ void panic(const char *fmt, ...)
 		crash_smp_send_stop();
 	}
 
+	/* Call flush even twice. It tries harder with a single online CPU */
+	printk_safe_flush_on_panic();
+
 	/*
 	 * Run any panic handlers, including those that might need to
 	 * add information to the kmsg dump output.
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index d9a659a686f3..9ebc1723e1a4 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -269,9 +269,6 @@ void printk_safe_flush_on_panic(void)
 	 * Do not risk a double release when more CPUs are up.
 	 */
 	if (raw_spin_is_locked(&logbuf_lock)) {
-		if (num_online_cpus() > 1)
-			return;
-
 		debug_locks_off();
 		raw_spin_lock_init(&logbuf_lock);
 	}
-- 
2.17.1

