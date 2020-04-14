Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88329C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722D62078B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502103AbgDNMhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:37:02 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:13683 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502077AbgDNMgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:36:48 -0400
Received: from wangqing-virtual-machine.localdomain (unknown [157.0.31.122])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 572E0261604;
        Tue, 14 Apr 2020 20:36:45 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        jinho lim <jordan.lim@samsung.com>,
        Wang Qing <wangqing@vivo.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [V3 1/3] ARM64:fixed dump_backtrace() when task running on another cpu
Date:   Tue, 14 Apr 2020 20:36:30 +0800
Message-Id: <1586867796-5768-2-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586867796-5768-1-git-send-email-wangqing@vivo.com>
References: <1586867796-5768-1-git-send-email-wangqing@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVMTllXWShZQUhPN1dZLVlBSVdZCQ
        4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kz46LBw4HjgrEgotHRkqMCwt
        Tw4aCSxVSlVKTkNNQ01MQ0tOTE5MVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZSk5M
        VUtVSEpVSklJWVdZCAFZQUhJSEI3Bg++
X-HM-Tid: 0a7178b11de39375kuws572e0261604
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot get FP and PC when the task is running on another CPU,
task->thread.cpu_context is the last time the task was switched out,
it's better to give a reminder than to provide wrong information
for example when Task blocked in spinlock/interrupt/busy loop.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 arch/arm64/kernel/traps.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index cf402be..c74090b 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -106,6 +106,13 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 		start_backtrace(&frame,
 				(unsigned long)__builtin_frame_address(0),
 				(unsigned long)dump_backtrace);
+	} else if (task_running(tsk)) {
+		/*
+		 * The task is running in another cpu, we cannot get it.
+		 */
+		pr_warn("tsk: %s is running in CPU%d, Don't call trace!\n",
+			tsk->comm, task_cpu(tsk));
+		return;
 	} else {
 		/*
 		 * task blocked in __switch_to
-- 
2.7.4

