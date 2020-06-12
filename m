Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04196C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D04B2207ED
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgFLHl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:41:57 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:25831 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgFLHl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:41:57 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.226])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id E6F1326151C;
        Fri, 12 Jun 2020 15:41:52 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wang Qing <wangqing@vivo.com>,
        jinho lim <jordan.lim@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH] arm64: smp call when task currently running on other cpu
Date:   Fri, 12 Jun 2020 15:41:46 +0800
Message-Id: <1591947707-15140-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQkJCHR8dHksfTx1DVkpOQkpCT0xMSkhPTk5VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRw6Ehw*HzgrTgsNFhoiSx1L
        AgMwCzFVSlVKTkJKQk9MTEpIQ0xJVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlJTVlXWQgBWUFJTU9CNwY+
X-HM-Tid: 0a72a77a5b3a9375kuwse6f1326151c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot get FP and PC when the task is running on another CPU,
task->thread.cpu_context is the last time the task was switched out,
we can use smp call to print backtrace itself.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 arch/arm64/kernel/traps.c | 11 +++++++++++
 1 file changed, 11 insertions(+)
 mode change 100644 => 100755 arch/arm64/kernel/traps.c

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 50cc30a..17a07b9
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -83,6 +83,11 @@ static void dump_kernel_instr(const char *lvl, struct pt_regs *regs)
 	printk("%sCode: %s\n", lvl, str);
 }
 
+static void dump_backtrace_smp_fun(struct task_struct *tsk)
+{
+	dump_backtrace(NULL, tsk, KERN_DEFAULT);
+}
+
 void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 		    const char *loglvl)
 {
@@ -107,6 +112,12 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 		start_backtrace(&frame,
 				(unsigned long)__builtin_frame_address(0),
 				(unsigned long)dump_backtrace);
+	} else if (task_curr(tsk)) {
+		/*
+		 * The task is currently running on other cpu
+		 */
+		smp_call_function_single(tsk->cpu, dump_backtrace_fun, tsk, 0);
+		return;
 	} else {
 		/*
 		 * task blocked in __switch_to
-- 
2.7.4

