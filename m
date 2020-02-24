Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18977C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B892192A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgBXI7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:59:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726509AbgBXI7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 03:59:31 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01O8okXk067623
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 03:59:29 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yb1ar74vb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 03:59:29 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Mon, 24 Feb 2020 08:59:28 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Feb 2020 08:59:22 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01O8xL4C35782706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 08:59:21 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D88942049;
        Mon, 24 Feb 2020 08:59:21 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED01242041;
        Mon, 24 Feb 2020 08:59:18 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.160])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Feb 2020 08:59:18 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, David.Laight@ACULAB.COM,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org,
        dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com
Subject: [PATCH v4 0/4] Introduce per-task latency_nice for scheduler hints
Date:   Mon, 24 Feb 2020 14:29:14 +0530
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 20022408-0016-0000-0000-000002E9B3D3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022408-0017-0000-0000-0000334CD9F6
Message-Id: <20200224085918.16955-1-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-24_02:2020-02-21,2020-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 4th revision of the patch set to introduce latency_nice as a
per task attribute.

The previous version can be found at:
v1: https://lkml.org/lkml/2019/11/25/151
v2: https://lkml.org/lkml/2019/12/8/10
v3: https://lkml.org/lkml/2020/1/16/319

Changes in this revision are:
v3->v4:
- Based on Chris's comment, added security check to refrain non-root user
  set lower value than the current latency_nice values.
v2 -> v3:
- This series changes the longer attribute name to "latency_nice" as per
  the comment from Dietmar Eggemann https://lkml.org/lkml/2019/12/5/394
v1 -> v2:
- Addressed comments from Qais Yousef
- As per suggestion from Dietmar, moved content from newly created
  include/linux/sched/latency_tolerance.h to kernel/sched/sched.h
- Extend sched_setattr() to support latency_tolerance in tools headers UAPI


Introduction:
==============
This patch series introduces a new per-task attribute latency_nice to
provide the scheduler hints about the latency requirements of the task [1].

Latency_nice is a ranged attribute of a task with the value ranging
from [-20, 19] both inclusive which makes it align with the task nice
value.

The value should provide scheduler hints about the relative latency
requirements of tasks, meaning the task with "latency_nice = -20"
should have lower latency requirements than compared to those tasks with
higher values. Similarly a task with "latency_nice = 19" can have higher
latency and hence such tasks may not care much about latency.

The default value is set to 0. The usecases discussed below can use this
range of [-20, 19] for latency_nice for the specific purpose. This
patch does not implement any use cases for such attribute so that any
change in naming or range does not affect much to the other (future)
patches using this. The actual use of latency_nice during task wakeup
and load-balancing is yet to be coded for each of those usecases.

As per my view, this defined attribute can be used in following ways for a
some of the usecases:
1 Reduce search scan time for select_idle_cpu():
- Reduce search scans for finding idle CPU for a waking task with lower
  latency_nice values.

2 TurboSched:
- Classify the tasks with higher latency_nice values as a small
  background task given that its historic utilization is very low, for
  which the scheduler can search for more number of cores to do task
  packing.  A task with a latency_nice >= some_threshold (e.g, == 19)
  and util <= 12.5% can be background tasks.

3 Optimize AVX512 based workload:
- Bias scheduler to not put a task having (latency_nice == -20) on a
  core occupying AVX512 based workload.


Series Organization:
====================
- Patch 1-3: Add support for latency_nice attr in the task struct using
  	     sched_{set,get}attr syscall
- Patch 4  : Add permission checks for setting the value.


The patch series can be applied on tip/sched/core at the
commit 000619680c37 ("sched/fair: Remove wake_cap()")


References:
============
[1]. Usecases for the per-task latency-nice attribute,
     https://lkml.org/lkml/2019/9/30/215
[2]. Task Latency-nice, "Subhra Mazumdar",
     https://lkml.org/lkml/2019/8/30/829
[3]. Introduce per-task latency_tolerance for scheduler hints,
     https://lkml.org/lkml/2019/12/8/10



Parth Shah (4):
  sched: Introduce latency-nice as a per-task attribute
  sched/core: Propagate parent task's latency requirements to the child
    task
  sched: Allow sched_{get,set}attr to change latency_nice of the task
  sched/core: Add permission checks for setting the latency_nice value

 include/linux/sched.h            |  1 +
 include/uapi/linux/sched.h       |  4 +++-
 include/uapi/linux/sched/types.h | 19 +++++++++++++++++++
 kernel/sched/core.c              | 25 +++++++++++++++++++++++++
 kernel/sched/sched.h             | 18 ++++++++++++++++++
 tools/include/uapi/linux/sched.h |  4 +++-
 6 files changed, 69 insertions(+), 2 deletions(-)

-- 
2.17.2

