Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C76C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADDD320870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgEGNiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 09:38:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52016 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725857AbgEGNiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 09:38:18 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047DWYvc003581;
        Thu, 7 May 2020 09:38:08 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30sp8n1fj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 09:38:07 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 047DWsi8006339;
        Thu, 7 May 2020 09:37:53 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30sp8n1fab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 09:37:53 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 047DUqkb022864;
        Thu, 7 May 2020 13:37:39 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 30s0g5mmdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 13:37:39 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 047Dbbjq61079800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 May 2020 13:37:37 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E79B5AE055;
        Thu,  7 May 2020 13:37:36 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07F8CAE057;
        Thu,  7 May 2020 13:37:32 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.85.97.135])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 May 2020 13:37:31 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com,
        chris.hyser@oracle.com, pkondeti@codeaurora.org,
        valentin.schneider@arm.com, rjw@rjwysocki.net
Subject: [RFC 2/4] sched/core: Set nr_lat_sensitive counter at various scheduler entry/exit points
Date:   Thu,  7 May 2020 19:07:21 +0530
Message-Id: <20200507133723.18325-3-parth@linux.ibm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200507133723.18325-1-parth@linux.ibm.com>
References: <20200507133723.18325-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_08:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=1 priorityscore=1501 spamscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Monitor tasks at:
1. wake_up_new_task() - forked tasks

2. set_task_cpu() - task migrations, Load balancer

3. __sched_setscheduler() - set/unset latency_nice value
Increment the nr_lat_sensitive count on the CPU with task marked with
latency_nice == -20.
Similarly, decrement the nr_lat_sensitive counter upon re-marking the task
with >-20 latency_nice task.

4. finish_task_switch() - dying task

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 kernel/sched/core.c  | 30 ++++++++++++++++++++++++++++--
 kernel/sched/sched.h |  5 +++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d8b76f41d61..ad396c36eba6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1744,6 +1744,11 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 	trace_sched_migrate_task(p, new_cpu);
 
 	if (task_cpu(p) != new_cpu) {
+		if (task_is_lat_sensitive(p)) {
+			per_cpu(nr_lat_sensitive, task_cpu(p))--;
+			per_cpu(nr_lat_sensitive, new_cpu)++;
+		}
+
 		if (p->sched_class->migrate_task_rq)
 			p->sched_class->migrate_task_rq(p, new_cpu);
 		p->se.nr_migrations++;
@@ -2947,6 +2952,7 @@ void wake_up_new_task(struct task_struct *p)
 {
 	struct rq_flags rf;
 	struct rq *rq;
+	int target_cpu = 0;
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 	p->state = TASK_RUNNING;
@@ -2960,9 +2966,17 @@ void wake_up_new_task(struct task_struct *p)
 	 * as we're not fully set-up yet.
 	 */
 	p->recent_used_cpu = task_cpu(p);
-	__set_task_cpu(p, select_task_rq(p, task_cpu(p), SD_BALANCE_FORK, 0));
+	target_cpu = select_task_rq(p, task_cpu(p), SD_BALANCE_FORK, 0);
+	__set_task_cpu(p, target_cpu);
+
 #endif
 	rq = __task_rq_lock(p, &rf);
+
+#ifdef CONFIG_SMP
+	if (task_is_lat_sensitive(p))
+		per_cpu(nr_lat_sensitive, target_cpu)++;
+#endif
+
 	update_rq_clock(rq);
 	post_init_entity_util_avg(p);
 
@@ -3248,6 +3262,9 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		if (prev->sched_class->task_dead)
 			prev->sched_class->task_dead(prev);
 
+		if (task_is_lat_sensitive(prev))
+			per_cpu(nr_lat_sensitive, prev->cpu)--;
+
 		/*
 		 * Remove function-return probe instances associated with this
 		 * task and put them back on the free list.
@@ -4732,8 +4749,17 @@ static void __setscheduler_params(struct task_struct *p,
 	p->normal_prio = normal_prio(p);
 	set_load_weight(p, true);
 
-	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE)
+	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE) {
+		if (p->state != TASK_DEAD &&
+		    attr->sched_latency_nice != p->latency_nice) {
+			if (attr->sched_latency_nice == MIN_LATENCY_NICE)
+				per_cpu(nr_lat_sensitive, task_cpu(p))++;
+			else if (task_is_lat_sensitive(p))
+				per_cpu(nr_lat_sensitive, task_cpu(p))--;
+		}
+
 		p->latency_nice = attr->sched_latency_nice;
+	}
 }
 
 /* Actually do priority change: must hold pi & rq lock. */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5c41020c530e..56f885e37451 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -211,6 +211,11 @@ static inline int task_has_dl_policy(struct task_struct *p)
 	return dl_policy(p->policy);
 }
 
+static inline int task_is_lat_sensitive(struct task_struct *p)
+{
+	return p->latency_nice == MIN_LATENCY_NICE;
+}
+
 #define cap_scale(v, s) ((v)*(s) >> SCHED_CAPACITY_SHIFT)
 
 /*
-- 
2.17.2

