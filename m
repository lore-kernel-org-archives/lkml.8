Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E108C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5A1246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgB1JIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:08:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57606 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726796AbgB1JIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:08:19 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01S91Tqf060474
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 04:08:18 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yepx4f1jb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 04:08:18 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Fri, 28 Feb 2020 09:08:16 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Feb 2020 09:08:11 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01S98A7w53674042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 09:08:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49B17AE058;
        Fri, 28 Feb 2020 09:08:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92E12AE053;
        Fri, 28 Feb 2020 09:08:07 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.18])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Feb 2020 09:08:07 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com,
        chris.hyser@oracle.com, pkondeti@codeaurora.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        David.Laight@ACULAB.COM, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com
Subject: [PATCH v5 4/4] sched/core: Add permission checks for setting the latency_nice value
Date:   Fri, 28 Feb 2020 14:37:55 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200228090755.22829-1-parth@linux.ibm.com>
References: <20200228090755.22829-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20022809-0028-0000-0000-000003DECBEA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022809-0029-0000-0000-000024A3EDFB
Message-Id: <20200228090755.22829-5-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-28_02:2020-02-26,2020-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 phishscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 clxscore=1015 mlxscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002280075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the latency_nice uses the similar infrastructure as NICE, use the
already existing CAP_SYS_NICE security checks for the latency_nice. This
should return -EPERM for the non-root user when trying to set the task
latency_nice value to any lower than the current value.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
Reviewed-by: Chris Hyser <chris.hyser@oracle.com>
---
 kernel/sched/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cd1fb9c8be26..564b3a2036d4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4875,6 +4875,10 @@ static int __sched_setscheduler(struct task_struct *p,
 			return -EINVAL;
 		if (attr->sched_latency_nice < MIN_LATENCY_NICE)
 			return -EINVAL;
+		/* Use the same security checks as NICE */
+		if (attr->sched_latency_nice < p->latency_nice &&
+		    !capable(CAP_SYS_NICE))
+			return -EPERM;
 	}
 
 	if (pi)
-- 
2.17.2

