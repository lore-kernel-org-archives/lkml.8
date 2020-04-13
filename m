Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE06C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A344020787
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgDMMFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 08:05:02 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:43726 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbgDMMFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:05:01 -0400
Received: from wangqing-virtual-machine.localdomain (unknown [157.0.31.122])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 77C5926249B;
        Mon, 13 Apr 2020 20:04:57 +0800 (CST)
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
Subject: [PATCH 1/2] [V2 1/2]sched:add task_running_oncpu
Date:   Mon, 13 Apr 2020 20:04:23 +0800
Message-Id: <1586779466-4439-2-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586779466-4439-1-git-send-email-wangqing@vivo.com>
References: <1586779466-4439-1-git-send-email-wangqing@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVPTkhLS0tLTUNNTU9OTllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MjY6FDo6Pjg6PAstCk4DPysy
        Tk1PCz5VSlVKTkNNTExCT0JMQ05LVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZSk5M
        VUtVSEpVSklJWVdZCAFZQUhKSE43Bg++
X-HM-Tid: 0a71736da5329375kuws77c5926249b
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have no interface whether the task is running,
so we need to add an interface and distinguish CONFIG_SMP.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 include/linux/sched.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4418f5c..13cc8f5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1843,6 +1843,11 @@ static inline unsigned int task_cpu(const struct task_struct *p)
 
 extern void set_task_cpu(struct task_struct *p, unsigned int cpu);
 
+static inline int task_running_oncpu(const struct task_struct *p)
+{
+	return p->on_cpu;
+}
+
 #else
 
 static inline unsigned int task_cpu(const struct task_struct *p)
@@ -1854,6 +1859,11 @@ static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
 {
 }
 
+static inline int task_running_oncpu(const struct task_struct *p)
+{
+	return p == current;
+}
+
 #endif /* CONFIG_SMP */
 
 /*
-- 
2.7.4

