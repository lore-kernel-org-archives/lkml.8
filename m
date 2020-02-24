Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18326C11D29
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DBE22525
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgBXI7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:59:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727276AbgBXI7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 03:59:36 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01O8oix6145400
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 03:59:35 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yb1qc6w0s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 03:59:35 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Mon, 24 Feb 2020 08:59:33 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Feb 2020 08:59:28 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01O8xRnY51511500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 08:59:27 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2965842042;
        Mon, 24 Feb 2020 08:59:27 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 919144203F;
        Mon, 24 Feb 2020 08:59:24 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.160])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Feb 2020 08:59:24 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, David.Laight@ACULAB.COM,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org,
        dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com
Subject: [PATCH v4 2/4] sched/core: Propagate parent task's latency requirements to the child task
Date:   Mon, 24 Feb 2020 14:29:16 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200224085918.16955-1-parth@linux.ibm.com>
References: <20200224085918.16955-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20022408-0012-0000-0000-00000389B4C3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022408-0013-0000-0000-000021C6534D
Message-Id: <20200224085918.16955-3-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-24_02:2020-02-21,2020-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=1 phishscore=0
 mlxlogscore=924 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clone parent task's latency_nice attribute to the forked child task.

Reset the latency_nice value to default value when the child task is
set to sched_reset_on_fork.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 377ec26e9159..65b6c00d6dac 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2860,6 +2860,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	 */
 	p->prio = current->normal_prio;
 
+	/* Propagate the parent's latency requirements to the child as well */
+	p->latency_nice = current->latency_nice;
+
 	uclamp_fork(p);
 
 	/*
@@ -2876,6 +2879,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		p->prio = p->normal_prio = __normal_prio(p);
 		set_load_weight(p, false);
 
+		p->latency_nice = DEFAULT_LATENCY_NICE;
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
 		 * fulfilled its duty:
-- 
2.17.2

