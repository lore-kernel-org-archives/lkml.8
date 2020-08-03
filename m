Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C022CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A311820781
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgHCPqb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:46:31 -0400
Received: from smtp.h3c.com ([60.191.123.50]:59210 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgHCPqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:46:31 -0400
X-Greylist: delayed 1682 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Aug 2020 11:46:30 EDT
Received: from h3cspam02-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam02-ex.h3c.com with ESMTP id 073FIPg7047534
        for <linux-kernel@vger.kernel.org>; Mon, 3 Aug 2020 23:18:25 +0800 (GMT-8)
        (envelope-from ning.le@h3c.com)
Received: from DAG2EX02-BASE.srv.huawei-3com.com ([10.8.0.65])
        by h3cspam02-ex.h3c.com with ESMTPS id 073FI97Q046708
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Aug 2020 23:18:09 +0800 (GMT-8)
        (envelope-from ning.le@h3c.com)
Received: from localhost.localdomain (10.114.40.30) by
 DAG2EX02-BASE.srv.huawei-3com.com (10.8.0.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 3 Aug 2020 23:18:12 +0800
From:   "ning.le" <ning.le@h3c.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>,
        <linux-kernel@vger.kernel.org>, <he.feng@h3c.com>,
        "ning.le" <ning.le@h3c.com>
Subject: [PATCH] sched/cpuacct:Fix previous bugs submitted in history.
Date:   Mon, 3 Aug 2020 15:14:06 +0000
Message-ID: <20200803151406.59465-1-ning.le@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.114.40.30]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX02-BASE.srv.huawei-3com.com (10.8.0.65)
Content-Transfer-Encoding: 8BIT
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 073FI97Q046708
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Historical submission introduces new issues that When the current cpu
wakes up the thread which works on other cores,the cpuacct module may
add the execution time of thread which on the the other core's rq to
the current core's cpuusage.

Signed-off-by: ning.le <ning.le@h3c.com>
---
 kernel/sched/cpuacct.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 941c28cf9738..bd38c9cffdd6 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -341,6 +341,7 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
        struct cpuacct *ca;
        int index = CPUACCT_STAT_SYSTEM;
        struct pt_regs *regs = get_irq_regs() ? : task_pt_regs(tsk);
+ int cpu = task_cpu(tsk);

        if (regs && user_mode(regs))
                index = CPUACCT_STAT_USER;
@@ -348,8 +349,7 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
        rcu_read_lock();

        for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
-               __this_cpu_add(ca->cpuusage->usages[index], cputime);
-
+   per_cpu_ptr(ca->cpuusage, cpu)->usages[index] += cputime;
        rcu_read_unlock();
 }

--
2.17.1

-------------------------------------------------------------------------------------------------------------------------------------
本邮件及其附件含有新华三集团的保密信息，仅限于发送给上面地址中列出
的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、
或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本
邮件！
This e-mail and its attachments contain confidential information from New H3C, which is
intended only for the person or entity whose address is listed above. Any use of the
information contained herein in any way (including, but not limited to, total or partial
disclosure, reproduction, or dissemination) by persons other than the intended
recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender
by phone or email immediately and delete it!
