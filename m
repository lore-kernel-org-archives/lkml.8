Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6A9C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDE822525
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgBXI7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:59:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726509AbgBXI7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 03:59:35 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01O8pYW1030428
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 03:59:34 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ybu12mrc7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 03:59:34 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Mon, 24 Feb 2020 08:59:30 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Feb 2020 08:59:25 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01O8xOhs57081930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 08:59:24 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F1B84204B;
        Mon, 24 Feb 2020 08:59:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0FF142049;
        Mon, 24 Feb 2020 08:59:21 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.160])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Feb 2020 08:59:21 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, David.Laight@ACULAB.COM,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org,
        dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com
Subject: [PATCH v4 1/4] sched: Introduce latency-nice as a per-task attribute
Date:   Mon, 24 Feb 2020 14:29:15 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200224085918.16955-1-parth@linux.ibm.com>
References: <20200224085918.16955-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20022408-0020-0000-0000-000003AD0595
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022408-0021-0000-0000-0000220515D1
Message-Id: <20200224085918.16955-2-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-24_02:2020-02-21,2020-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=1
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Latency-nice indicates the latency requirements of a task with respect
to the other tasks in the system. The value of the attribute can be within
the range of [-20, 19] both inclusive to be in-line with the values just
like task nice values.

latency_nice = -20 indicates the task to have the least latency as
compared to the tasks having latency_nice = +19.

The latency_nice may affect only the CFS SCHED_CLASS by getting
latency requirements from the userspace.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
---
 include/linux/sched.h |  1 +
 kernel/sched/sched.h  | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 467d26046416..0668948fddcd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -676,6 +676,7 @@ struct task_struct {
 	int				static_prio;
 	int				normal_prio;
 	unsigned int			rt_priority;
+	int				latency_nice;
 
 	const struct sched_class	*sched_class;
 	struct sched_entity		se;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 878910e8b299..26b9758075e4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -101,6 +101,24 @@ extern long calc_load_fold_active(struct rq *this_rq, long adjust);
  */
 #define NS_TO_JIFFIES(TIME)	((unsigned long)(TIME) / (NSEC_PER_SEC / HZ))
 
+/*
+ * Latency nice is meant to provide scheduler hints about the relative
+ * latency requirements of a task with respect to other tasks.
+ * Thus a task with latency_nice == 19 can be hinted as the task with no
+ * latency requirements, in contrast to the task with latency_nice == -20
+ * which should be given priority in terms of lower latency.
+ */
+#define MAX_LATENCY_NICE	19
+#define MIN_LATENCY_NICE	-20
+
+#define LATENCY_NICE_WIDTH	\
+	(MAX_LATENCY_NICE - MIN_LATENCY_NICE + 1)
+
+/*
+ * Default tasks should be treated as a task with latency_nice = 0.
+ */
+#define DEFAULT_LATENCY_NICE	0
+
 /*
  * Increase resolution of nice-level calculations for 64-bit architectures.
  * The extra resolution improves shares distribution and load balancing of
-- 
2.17.2

