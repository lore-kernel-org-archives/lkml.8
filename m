Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6EEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0FB620709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgEOKIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:08:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48874 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727999AbgEOKIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:08:37 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 202F6BC4D3A5C439F8EB;
        Fri, 15 May 2020 18:08:35 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Fri, 15 May 2020
 18:08:28 +0800
From:   Cheng Jian <cj.chengjian@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <rostedt@goodmis.org>
CC:     <xiexiuqi@huawei.com>, <bobo.shaobowang@huawei.com>,
        <huawei.libin@huawei.com>, <cj.chengjian@huawei.com>,
        <chenwandun@huawei.com>, <mingo@redhat.com>
Subject: [PATCH] ftrace: show debugging information when panic_on_warn set
Date:   Fri, 15 May 2020 10:08:28 +0000
Message-ID: <20200515100828.7091-1-cj.chengjian@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an anomaly is detected in the function call modification
code, ftrace_bug() is called to disable function tracing as well
as give some warn and information that may help debug the problem.

But currently, we call FTRACE_WARN_ON_ONCE() first in ftrace_bug(),
so when panic_on_warn is set, we can't see the debugging information
here. Call FTRACE_WARN_ON_ONCE() at the end of ftrace_bug() to ensure
that the debugging information is displayed first.

after this patch, the dmesg looks like:

	------------[ ftrace bug ]------------
	ftrace failed to modify
	[<ffff800010081004>] bcm2835_handle_irq+0x4/0x58
	 actual:   1f:20:03:d5
	Setting ftrace call site to call ftrace function
	ftrace record flags: 80000001
	 (1)
	 expected tramp: ffff80001009d6f0
	------------[ cut here ]------------
	WARNING: CPU: 2 PID: 1635 at kernel/trace/ftrace.c:2078 ftrace_bug+0x204/0x238
	Kernel panic - not syncing: panic_on_warn set ...
	CPU: 2 PID: 1635 Comm: sh Not tainted 5.7.0-rc5-00033-gb922183867f5 #14
	Hardware name: linux,dummy-virt (DT)
	Call trace:
	 dump_backtrace+0x0/0x1b0
	 show_stack+0x20/0x30
	 dump_stack+0xc0/0x10c
	 panic+0x16c/0x368
	 __warn+0x120/0x160
	 report_bug+0xc8/0x160
	 bug_handler+0x28/0x98
	 brk_handler+0x70/0xd0
	 do_debug_exception+0xcc/0x1ac
	 el1_sync_handler+0xe4/0x120
	 el1_sync+0x7c/0x100
	 ftrace_bug+0x204/0x238

Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
---
 kernel/trace/ftrace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index bd030b1b9514..cd39cbf3631a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2027,14 +2027,14 @@ void ftrace_bug(int failed, struct dyn_ftrace *rec)
 {
 	unsigned long ip = rec ? rec->ip : 0;
 
+	pr_info("------------[ ftrace bug ]------------\n");
+
 	switch (failed) {
 	case -EFAULT:
-		FTRACE_WARN_ON_ONCE(1);
 		pr_info("ftrace faulted on modifying ");
 		print_ip_sym(ip);
 		break;
 	case -EINVAL:
-		FTRACE_WARN_ON_ONCE(1);
 		pr_info("ftrace failed to modify ");
 		print_ip_sym(ip);
 		print_ip_ins(" actual:   ", (unsigned char *)ip);
@@ -2045,12 +2045,10 @@ void ftrace_bug(int failed, struct dyn_ftrace *rec)
 		}
 		break;
 	case -EPERM:
-		FTRACE_WARN_ON_ONCE(1);
 		pr_info("ftrace faulted on writing ");
 		print_ip_sym(ip);
 		break;
 	default:
-		FTRACE_WARN_ON_ONCE(1);
 		pr_info("ftrace faulted on unknown error ");
 		print_ip_sym(ip);
 	}
@@ -2077,6 +2075,8 @@ void ftrace_bug(int failed, struct dyn_ftrace *rec)
 		ip = ftrace_get_addr_curr(rec);
 		pr_cont("\n expected tramp: %lx\n", ip);
 	}
+
+	FTRACE_WARN_ON_ONCE(1);
 }
 
 static int ftrace_check_record(struct dyn_ftrace *rec, bool enable, bool update)
-- 
2.17.1

