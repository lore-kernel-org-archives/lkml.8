Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661EBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F109208A7
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgFAM25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbgFAM2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:28:08 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C54B207BC;
        Mon,  1 Jun 2020 12:28:08 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jfjXz-00274D-5X; Mon, 01 Jun 2020 08:28:07 -0400
Message-ID: <20200601122807.057114335@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 01 Jun 2020 08:27:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cheng Jian <cj.chengjian@huawei.com>
Subject: [for-next][PATCH 01/12] ftrace: show debugging information when panic_on_warn set
References: <20200601122729.727113609@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cheng Jian <cj.chengjian@huawei.com>

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

Link: https://lkml.kernel.org/r/20200515100828.7091-1-cj.chengjian@huawei.com

Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
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
2.26.2


