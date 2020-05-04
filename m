Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FD8C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D993E206B9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L026+B3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgEDOvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 10:51:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41812 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgEDOvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 10:51:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044Elb1t116460;
        Mon, 4 May 2020 14:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=61u5E3r7FKjiKSK7bv9u8QvVvHDSNPsfx2pYV6Bq610=;
 b=L026+B3QsjeTLnHt5BXCtOMcdosY2tn5zYViP0f12HHDe3jihPgn/7lfW5ZH/xzGf6tV
 lvYMdtvHS/531InAezTehMs4M93vNxtBR+bu1U+UmXd22N2Xx3UQZ/XBG5B0C+rJANGs
 2Ooqmh+mZdqogknL8hnhEK5GqUHklgsn3AeIWWROmhHGEyB454kX7kptGDQ0ZNmOP8JY
 Ad2fcWFKMbDm+NulBfZ0Zf0Uezijyrz7A7neqWC1ss3rnqzHrf1c9fVN6KrdWWacz0zy
 CHRafa0abI0/BNS1AmzUqLDAhjHMwxC+uCJYlc/shODumFcX/IvVEfO9xrCFSGpyMcyj rQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30s09qydud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:51:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044EmWa9105788;
        Mon, 4 May 2020 14:51:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30sjjvyw3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:51:23 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044EpL4E027428;
        Mon, 4 May 2020 14:51:21 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 07:51:21 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-1 5/7] mm/asi: Exit/enter ASI when task enters/exits scheduler
Date:   Mon,  4 May 2020 16:49:37 +0200
Message-Id: <20200504144939.11318-6-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504144939.11318-1-alexandre.chartre@oracle.com>
References: <20200504144939.11318-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exit ASI as soon as a task is entering the scheduler (__schedule()),
otherwise ASI will likely quick fault, for example when accessing
run queues. The task will return to ASI when it is scheduled again.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/asi.h |  3 ++
 arch/x86/mm/asi.c          | 67 ++++++++++++++++++++++++++++++++++++++
 include/linux/sched.h      |  9 +++++
 kernel/sched/core.c        | 17 ++++++++++
 4 files changed, 96 insertions(+)

diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
index d240954b2f85..a0733f1e4a67 100644
--- a/arch/x86/include/asm/asi.h
+++ b/arch/x86/include/asm/asi.h
@@ -102,6 +102,9 @@ struct asi {
 	unsigned long		base_cr3;	/* base ASI CR3 */
 };
 
+void asi_schedule_out(struct task_struct *task);
+void asi_schedule_in(struct task_struct *task);
+
 extern struct asi *asi_create(struct asi_type *type);
 extern void asi_destroy(struct asi *asi);
 extern void asi_set_pagetable(struct asi *asi, pgd_t *pagetable);
diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
index c91ba82a095b..3795582c66d8 100644
--- a/arch/x86/mm/asi.c
+++ b/arch/x86/mm/asi.c
@@ -229,3 +229,70 @@ void asi_prepare_resume(void)
 
 	asi_switch_to_asi_cr3(asi_session->asi, ASI_SWITCH_ON_RESUME);
 }
+
+void asi_schedule_out(struct task_struct *task)
+{
+	struct asi_session *asi_session;
+	unsigned long flags;
+	struct asi *asi;
+
+	asi = this_cpu_read(cpu_asi_session.asi);
+	if (!asi)
+		return;
+
+	/*
+	 * Save the ASI session.
+	 *
+	 * Exit the session if it hasn't been interrupted, otherwise
+	 * just save the session state.
+	 */
+	local_irq_save(flags);
+	if (!this_cpu_read(cpu_asi_session.idepth)) {
+		asi_switch_to_kernel_cr3(asi);
+		task->asi_session.asi = asi;
+		task->asi_session.idepth = 0;
+	} else {
+		asi_session = &get_cpu_var(cpu_asi_session);
+		task->asi_session = *asi_session;
+		asi_session->asi = NULL;
+		asi_session->idepth = 0;
+	}
+	local_irq_restore(flags);
+}
+
+void asi_schedule_in(struct task_struct *task)
+{
+	struct asi_session *asi_session;
+	unsigned long flags;
+	struct asi *asi;
+
+	asi = task->asi_session.asi;
+	if (!asi)
+		return;
+
+	/*
+	 * At this point, the CPU shouldn't be using ASI because the
+	 * ASI session is expected to be cleared in asi_schedule_out().
+	 */
+	WARN_ON(this_cpu_read(cpu_asi_session.asi));
+
+	/*
+	 * Restore ASI.
+	 *
+	 * If the task was scheduled out while using ASI, then the ASI
+	 * is already setup and we can immediately switch to ASI page
+	 * table.
+	 *
+	 * Otherwise, if the task was scheduled out while ASI was
+	 * interrupted, just restore the ASI session.
+	 */
+	local_irq_save(flags);
+	if (!task->asi_session.idepth) {
+		asi_switch_to_asi_cr3(asi, ASI_SWITCH_NOW);
+	} else {
+		asi_session = &get_cpu_var(cpu_asi_session);
+		*asi_session = task->asi_session;
+	}
+	task->asi_session.asi = NULL;
+	local_irq_restore(flags);
+}
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4418f5cb8324..ea86bda713ee 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -10,6 +10,7 @@
 #include <uapi/linux/sched.h>
 
 #include <asm/current.h>
+#include <asm/asi_session.h>
 
 #include <linux/pid.h>
 #include <linux/sem.h>
@@ -1289,6 +1290,14 @@ struct task_struct {
 	unsigned long			prev_lowest_stack;
 #endif
 
+#ifdef CONFIG_ADDRESS_SPACE_ISOLATION
+	/*
+	 * ASI session is saved here when the task is scheduled out
+	 * while an ASI session was active or interrupted.
+	 */
+	struct asi_session		asi_session;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9a2fbf98fd6f..140071cfa25d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -14,6 +14,7 @@
 
 #include <asm/switch_to.h>
 #include <asm/tlb.h>
+#include <asm/asi.h>
 
 #include "../workqueue_internal.h"
 #include "../../fs/io-wq.h"
@@ -3241,6 +3242,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	}
 
 	tick_nohz_task_switch();
+
 	return rq;
 }
 
@@ -4006,6 +4008,14 @@ static void __sched notrace __schedule(bool preempt)
 	struct rq *rq;
 	int cpu;
 
+	/*
+	 * If the task is using ASI then exit it right away otherwise the
+	 * ASI will likely quickly fault, for example when accessing run
+	 * queues.
+	 */
+	if (IS_ENABLED(CONFIG_ADDRESS_SPACE_ISOLATION))
+		asi_schedule_out(current);
+
 	cpu = smp_processor_id();
 	rq = cpu_rq(cpu);
 	prev = rq->curr;
@@ -4087,6 +4097,13 @@ static void __sched notrace __schedule(bool preempt)
 	}
 
 	balance_callback(rq);
+
+	/*
+	 * Now the task will resume execution, we can safely return to
+	 * its ASI if one was in used.
+	 */
+	if (IS_ENABLED(CONFIG_ADDRESS_SPACE_ISOLATION))
+		asi_schedule_in(current);
 }
 
 void __noreturn do_task_dead(void)
-- 
2.18.2

