Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E99C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 12:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF3920663
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 12:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgAPMCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:02:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53368 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726903AbgAPMCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 07:02:48 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GBwAhg085645
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 07:02:48 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xhbptwnj7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 07:02:47 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Thu, 16 Jan 2020 12:02:45 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 Jan 2020 12:02:42 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00GC1qmM33292728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 12:01:52 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3BA9A4055;
        Thu, 16 Jan 2020 12:02:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEBF6A4059;
        Thu, 16 Jan 2020 12:02:38 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.120])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Jan 2020 12:02:38 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        qais.yousef@arm.com, pavel@ucw.cz, dhaval.giani@oracle.com,
        qperret@qperret.net, David.Laight@ACULAB.COM, pjt@google.com,
        tj@kernel.org, dietmar.eggemann@arm.com
Subject: [PATCH v3 3/3] sched: Allow sched_{get,set}attr to change latency_nice of the task
Date:   Thu, 16 Jan 2020 17:32:30 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200116120230.16759-1-parth@linux.ibm.com>
References: <20200116120230.16759-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20011612-0012-0000-0000-0000037DDA99
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011612-0013-0000-0000-000021BA0E60
Message-Id: <20200116120230.16759-4-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_03:2020-01-16,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=1 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001160103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the latency_nice attribute to sched_attr and provide a
mechanism to change the value with the use of sched_setattr/sched_getattr
syscall.

Also add new flag "SCHED_FLAG_LATENCY_NICE" to hint the change in
latency_nice of the task on every sched_setattr syscall.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
---
 include/uapi/linux/sched.h       |  4 +++-
 include/uapi/linux/sched/types.h | 19 +++++++++++++++++++
 kernel/sched/core.c              | 17 +++++++++++++++++
 tools/include/uapi/linux/sched.h |  4 +++-
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 4a0217832464..88ce1e8d7553 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -121,6 +121,7 @@ struct clone_args {
 #define SCHED_FLAG_KEEP_PARAMS		0x10
 #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
 #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+#define SCHED_FLAG_LATENCY_NICE	0x80
 
 #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
 				 SCHED_FLAG_KEEP_PARAMS)
@@ -132,6 +133,7 @@ struct clone_args {
 			 SCHED_FLAG_RECLAIM		| \
 			 SCHED_FLAG_DL_OVERRUN		| \
 			 SCHED_FLAG_KEEP_ALL		| \
-			 SCHED_FLAG_UTIL_CLAMP)
+			 SCHED_FLAG_UTIL_CLAMP		| \
+			 SCHED_FLAG_LATENCY_NICE)
 
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
index c852153ddb0d..626ab61c1145 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -10,6 +10,7 @@ struct sched_param {
 
 #define SCHED_ATTR_SIZE_VER0	48	/* sizeof first published struct */
 #define SCHED_ATTR_SIZE_VER1	56	/* add: util_{min,max} */
+#define SCHED_ATTR_SIZE_VER2	60	/* add: latency_nice */
 
 /*
  * Extended scheduling parameters data structure.
@@ -96,6 +97,22 @@ struct sched_param {
  * on a CPU with a capacity big enough to fit the specified value.
  * A task with a max utilization value smaller than 1024 is more likely
  * scheduled on a CPU with no more capacity than the specified value.
+ *
+ * Latency Tolerance Attributes
+ * ===========================
+ *
+ * A subset of sched_attr attributes allows to specify the relative latency
+ * requirements of a task with respect to the other tasks running/queued in the
+ * system.
+ *
+ * @ sched_latency_nice	task's latency_nice value
+ *
+ * The latency_nice of a task can have any value in a range of
+ * [LATENCY_NICE_MIN..LATENCY_NICE_MAX].
+ *
+ * A task with latency_nice with the value of LATENCY_NICE_MIN can be
+ * taken for a task with lower latency requirements as opposed to the task with
+ * higher latency_nice.
  */
 struct sched_attr {
 	__u32 size;
@@ -118,6 +135,8 @@ struct sched_attr {
 	__u32 sched_util_min;
 	__u32 sched_util_max;
 
+	/* latency requirement hints */
+	__s32 sched_latency_nice;
 };
 
 #endif /* _UAPI_LINUX_SCHED_TYPES_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a7359836bf17..a9e5d157b1a5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4713,6 +4713,8 @@ static void __setscheduler_params(struct task_struct *p,
 	p->rt_priority = attr->sched_priority;
 	p->normal_prio = normal_prio(p);
 	set_load_weight(p, true);
+
+	p->latency_nice = attr->sched_latency_nice;
 }
 
 /* Actually do priority change: must hold pi & rq lock. */
@@ -4870,6 +4872,13 @@ static int __sched_setscheduler(struct task_struct *p,
 			return retval;
 	}
 
+	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE) {
+		if (attr->sched_latency_nice > MAX_LATENCY_NICE)
+			return -EINVAL;
+		if (attr->sched_latency_nice < MIN_LATENCY_NICE)
+			return -EINVAL;
+	}
+
 	if (pi)
 		cpuset_read_lock();
 
@@ -4904,6 +4913,9 @@ static int __sched_setscheduler(struct task_struct *p,
 			goto change;
 		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
 			goto change;
+		if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE &&
+		    attr->sched_latency_nice != p->latency_nice)
+			goto change;
 
 		p->sched_reset_on_fork = reset_on_fork;
 		retval = 0;
@@ -5152,6 +5164,9 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
 	    size < SCHED_ATTR_SIZE_VER1)
 		return -EINVAL;
 
+	if ((attr->sched_flags & SCHED_FLAG_LATENCY_NICE) &&
+	    size < SCHED_ATTR_SIZE_VER2)
+		return -EINVAL;
 	/*
 	 * XXX: Do we want to be lenient like existing syscalls; or do we want
 	 * to be strict and return an error on out-of-bounds values?
@@ -5381,6 +5396,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	else
 		kattr.sched_nice = task_nice(p);
 
+	kattr.sched_latency_nice = p->latency_nice;
+
 #ifdef CONFIG_UCLAMP_TASK
 	kattr.sched_util_min = p->uclamp_req[UCLAMP_MIN].value;
 	kattr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index 4a0217832464..fa67e2527169 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -121,6 +121,7 @@ struct clone_args {
 #define SCHED_FLAG_KEEP_PARAMS		0x10
 #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
 #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+#define SCHED_FLAG_LATENCY_NICE	0X80
 
 #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
 				 SCHED_FLAG_KEEP_PARAMS)
@@ -132,6 +133,7 @@ struct clone_args {
 			 SCHED_FLAG_RECLAIM		| \
 			 SCHED_FLAG_DL_OVERRUN		| \
 			 SCHED_FLAG_KEEP_ALL		| \
-			 SCHED_FLAG_UTIL_CLAMP)
+			 SCHED_FLAG_UTIL_CLAMP		| \
+			 SCHED_FLAG_LATENCY_NICE)
 
 #endif /* _UAPI_LINUX_SCHED_H */
-- 
2.17.2

