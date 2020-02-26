Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FBEC4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76590206E6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eS7tcg1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgBZQX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:23:59 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55844 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgBZQX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:23:58 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QFwbRZ093991;
        Wed, 26 Feb 2020 16:22:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=BxYF9cq4UU9TQOASTVG9NArzmzjgQ08TqlVgsZKfwvw=;
 b=eS7tcg1WMSlgvI/kqUtdnxTQfrXCrYzt6Vpp8KeqM6TuQr53OAhIEitxxucohUasU9sL
 nvI8clOY/E1aNVN1FBMmNyHa/gH4QrD1S80vcr7IPn50A3rqWRBBf7qNJhf7HveHQuNW
 I+uMQ/GXjGJgrLZNH0nIJ3rDJqNCKSDfOvzzUZpPzlx1xYWjRhuubTFdpQoPhEkWsR6w
 tE188idOg3LYRuokEVLMJcI3gMWmsKS2iBOzKpaw9kKxamfrxqo+hQRCL8p8EoYr0Z03
 fiaomKUnKlAHR0lwc03BFX0NyimtdUPlyPNU+cgcVDxQlBpEPBCWn08hjL0Zqrg+8B0v rA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2ydct34r3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 16:22:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QGM8LI024961;
        Wed, 26 Feb 2020 16:22:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2ydj4hvv6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 16:22:27 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01QGMPS6028981;
        Wed, 26 Feb 2020 16:22:25 GMT
Received: from achartre-desktop.us.oracle.com (/10.39.232.60)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Feb 2020 08:22:25 -0800
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
Subject: [RFC PATCH v3 5/7] mm/asi: Switch ASI on task switch
Date:   Wed, 26 Feb 2020 17:21:58 +0100
Message-Id: <1582734120-26757-6-git-send-email-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1582734120-26757-1-git-send-email-alexandre.chartre@oracle.com>
References: <1582734120-26757-1-git-send-email-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a task using ASI is scheduled in/out then save/restore the
corresponding ASI and update the cpu ASI session.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/asi.h |    3 ++
 arch/x86/mm/asi.c          |   67 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/sched.h      |    9 ++++++
 kernel/sched/core.c        |    8 +++++
 4 files changed, 87 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
index d240954..a0733f1 100644
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
index c91ba82..9955eb2 100644
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
+		task->asi_session.asi = NULL;
+	}
+	local_irq_restore(flags);
+}
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 716ad1d..66cc583 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -10,6 +10,7 @@
 #include <uapi/linux/sched.h>
 
 #include <asm/current.h>
+#include <asm/asi_session.h>
 
 #include <linux/pid.h>
 #include <linux/sem.h>
@@ -1281,6 +1282,14 @@ struct task_struct {
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
index 90e4b00..a2c8604 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -14,6 +14,7 @@
 
 #include <asm/switch_to.h>
 #include <asm/tlb.h>
+#include <asm/asi.h>
 
 #include "../workqueue_internal.h"
 #include "../../fs/io-wq.h"
@@ -3153,6 +3154,9 @@ static inline void finish_lock_switch(struct rq *rq)
 prepare_task_switch(struct rq *rq, struct task_struct *prev,
 		    struct task_struct *next)
 {
+	if (IS_ENABLED(CONFIG_ADDRESS_SPACE_ISOLATION))
+		asi_schedule_out(prev);
+
 	kcov_prepare_switch(prev);
 	sched_info_switch(rq, prev, next);
 	perf_event_task_sched_out(prev, next);
@@ -3259,6 +3263,10 @@ static inline void finish_lock_switch(struct rq *rq)
 	}
 
 	tick_nohz_task_switch();
+
+	if (IS_ENABLED(CONFIG_ADDRESS_SPACE_ISOLATION))
+		asi_schedule_in(current);
+
 	return rq;
 }
 
-- 
1.7.1

