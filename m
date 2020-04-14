Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7B0C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F85320775
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502089AbgDNMgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:36:52 -0400
Received: from m177134.mail.qiye.163.com ([123.58.177.134]:14867 "EHLO
        m177134.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502073AbgDNMgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:36:47 -0400
Received: from wangqing-virtual-machine.localdomain (unknown [157.0.31.122])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id CFD13261925;
        Tue, 14 Apr 2020 20:36:41 +0800 (CST)
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
Subject: [V3 0/3] Fixed dump_backtrace() when task running on another cpu 
Date:   Tue, 14 Apr 2020 20:36:29 +0800
Message-Id: <1586867796-5768-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUlXWQgYFAkeWUFZTVVOTUxCQkJDSEJMQ0lMSllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mi46Aio4KjgzQwoTHRkwMCkL
        LQ4wCTBVSlVKTkNNQ01MQ0tJSU5NVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZSk5M
        VUtVSEpVSklJWVdZCAFZQUhLTks3Bg++
X-HM-Tid: 0a7178b1103a9375kuwscfd13261925
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot get FP and PC when the task is running on another CPU,
task->thread.cpu_context is the last time the task was switched out,
it's better to give a reminder than to provide wrong information
for example when Task blocked in spinlock/interrupt/busy loop.

The task_running() should be renamed to task_running_on_rq()
like the naming of task_running_on_cpu(), this is what it
originally mean.

Add task_running() no rq required.

V2:
- Add task_running_oncpu()
v3:
- Renamed task_running() to task_running_on_rq()
- Renamed task_running_oncpu() to task_running()

Wang Qing (3):
  ARM64:fixed dump_backtrace() when task running on another cpu
  sched:add task_running()
  sched:rename task_running() and to task_running_on_rq

 arch/arm64/kernel/traps.c |  7 +++++++
 include/linux/sched.h     | 10 ++++++++++
 kernel/sched/core.c       | 14 +++++++-------
 kernel/sched/deadline.c   |  6 +++---
 kernel/sched/fair.c       |  2 +-
 kernel/sched/rt.c         |  6 +++---
 kernel/sched/sched.h      |  2 +-
 7 files changed, 32 insertions(+), 15 deletions(-)

-- 
2.7.4

