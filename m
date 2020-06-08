Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF74DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A8392063A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgFHHyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 03:54:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60280 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727966AbgFHHyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 03:54:15 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6739D3DC3A0F43311A98;
        Mon,  8 Jun 2020 15:54:09 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 8 Jun 2020 15:54:02 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Divya Indi <divya.indi@oracle.com>, <linux-kernel@vger.kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] sample-trace-array: Fix sleeping function called from invalid context
Date:   Mon, 8 Jun 2020 07:54:37 +0000
Message-ID: <20200608075437.1760242-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 BUG: sleeping function called from invalid context at kernel/locking/mutex.c:935
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/5
 1 lock held by swapper/5/0:
  #0: ffff80001002bd90 (samples/ftrace/sample-trace-array.c:38){+.-.}-{0:0}, at: call_timer_fn+0x8/0x3e0
 CPU: 5 PID: 0 Comm: swapper/5 Not tainted 5.7.0+ #8
 Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
 Call trace:
  dump_backtrace+0x0/0x1a0
  show_stack+0x20/0x30
  dump_stack+0xe4/0x150
  ___might_sleep+0x160/0x200
  __might_sleep+0x58/0x90
  __mutex_lock+0x64/0x948
  mutex_lock_nested+0x3c/0x58
  __ftrace_set_clr_event+0x44/0x88
  trace_array_set_clr_event+0x24/0x38
  mytimer_handler+0x34/0x40 [sample_trace_array]

mutex_lock() will be called in interrupt context, using workqueueu to fix it.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 samples/ftrace/sample-trace-array.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/samples/ftrace/sample-trace-array.c b/samples/ftrace/sample-trace-array.c
index d523450d73eb..41684c7dbd7b 100644
--- a/samples/ftrace/sample-trace-array.c
+++ b/samples/ftrace/sample-trace-array.c
@@ -20,6 +20,16 @@ struct trace_array *tr;
 static void mytimer_handler(struct timer_list *unused);
 static struct task_struct *simple_tsk;
 
+static void trace_work_fn(struct work_struct *work)
+{
+	/*
+	 * Disable tracing for event "sample_event".
+	 */
+	trace_array_set_clr_event(tr, "sample-subsystem", "sample_event",
+			false);
+}
+static DECLARE_WORK(trace_work, trace_work_fn);
+
 /*
  * mytimer: Timer setup to disable tracing for event "sample_event". This
  * timer is only for the purposes of the sample module to demonstrate access of
@@ -29,11 +39,7 @@ static DEFINE_TIMER(mytimer, mytimer_handler);
 
 static void mytimer_handler(struct timer_list *unused)
 {
-	/*
-	 * Disable tracing for event "sample_event".
-	 */
-	trace_array_set_clr_event(tr, "sample-subsystem", "sample_event",
-			false);
+	schedule_work(&trace_work);
 }
 
 static void simple_thread_func(int count)
-- 
2.27.0

