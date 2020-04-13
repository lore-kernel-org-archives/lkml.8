Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD2CC38A2C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A9D720775
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbgDMMFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 08:05:13 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:43272 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgDMMFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:05:06 -0400
Received: from wangqing-virtual-machine.localdomain (unknown [157.0.31.122])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 8A9CD26246F;
        Mon, 13 Apr 2020 20:04:53 +0800 (CST)
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
Subject: [PATCH 0/2] fixed dump_backtrace() when task running on another cpu
Date:   Mon, 13 Apr 2020 20:04:22 +0800
Message-Id: <1586779466-4439-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZTlVMQk5LS0tLTE1JQkhCTllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTo6SSo5KTgzKAsRT041Pz42
        OhQKFEtVSlVKTkNNTExCT0JIQk9KVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZSk5M
        VUtVSEpVSklJWVdZCAFZQUlOSEo3Bg++
X-HM-Tid: 0a71736d95e09375kuws8a9cd26246f
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot get FP and PC when the task is running on another CPU,
task->thread.cpu_context is the last time the task was switched out,
it's better to give a reminder than to provide wrong information.

We have no interface whether the task is running,
so we need to add an interface and distinguish CONFIG_SMP.

Wang Qing (2):
  [V2 1/2]sched:add task_running_oncpu
  [V2 2/2]ARM64:fixed dump_backtrace() when task running on another cpu

 arch/arm64/kernel/traps.c |  7 +++++++
 include/linux/sched.h     | 10 ++++++++++
 2 files changed, 17 insertions(+)

-- 
2.7.4

