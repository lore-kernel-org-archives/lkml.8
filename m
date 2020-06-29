Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DE3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A30622269
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgF2ShS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:37:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5512 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727073AbgF2ShN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:37:13 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05TFd8GP052220;
        Mon, 29 Jun 2020 11:50:18 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ycd47q58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 11:50:18 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05TFibkT078882;
        Mon, 29 Jun 2020 11:50:17 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ycd47q48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 11:50:17 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05TFo8Xi024870;
        Mon, 29 Jun 2020 15:50:15 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 31wwr896gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 15:50:15 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05TFoCXP61997140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jun 2020 15:50:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C516FAE051;
        Mon, 29 Jun 2020 15:50:12 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 765E0AE055;
        Mon, 29 Jun 2020 15:50:12 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.156.24])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 29 Jun 2020 15:50:12 +0000 (GMT)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 1/3] perf bench numa: fix incorrect NUMA toplogy assumption
Date:   Mon, 29 Jun 2020 17:50:07 +0200
Message-Id: <a53eedd6ad2fb46aec4d59066277aad7ace470b7.1593445668.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1593445668.git.agordeev@linux.ibm.com>
References: <cover.1593445668.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-29_15:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 cotscore=-2147483648 malwarescore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 suspectscore=1 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006290103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code assumes that CPUs are evenly spread among
NUMA nodes. That is generally incorrect and leads to failure
on systems that have different NUMA topology.

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 tools/perf/bench/numa.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 5797253..5497c74 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -247,12 +247,13 @@ static int is_node_present(int node)
  */
 static bool node_has_cpus(int node)
 {
-	struct bitmask *cpu = numa_allocate_cpumask();
+	struct bitmask *cpumask = numa_allocate_cpumask();
 	unsigned int i;
 
-	if (cpu && !numa_node_to_cpus(node, cpu)) {
-		for (i = 0; i < cpu->size; i++) {
-			if (numa_bitmask_isbitset(cpu, i))
+	BUG_ON(cpumask);
+	if (!numa_node_to_cpus(node, cpumask)) {
+		for (i = 0; i < cpumask->size; i++) {
+			if (numa_bitmask_isbitset(cpumask, i))
 				return true;
 		}
 	}
@@ -288,14 +289,10 @@ static cpu_set_t bind_to_cpu(int target_cpu)
 
 static cpu_set_t bind_to_node(int target_node)
 {
-	int cpus_per_node = g->p.nr_cpus / nr_numa_nodes();
 	cpu_set_t orig_mask, mask;
 	int cpu;
 	int ret;
 
-	BUG_ON(cpus_per_node * nr_numa_nodes() != g->p.nr_cpus);
-	BUG_ON(!cpus_per_node);
-
 	ret = sched_getaffinity(0, sizeof(orig_mask), &orig_mask);
 	BUG_ON(ret);
 
@@ -305,13 +302,15 @@ static cpu_set_t bind_to_node(int target_node)
 		for (cpu = 0; cpu < g->p.nr_cpus; cpu++)
 			CPU_SET(cpu, &mask);
 	} else {
-		int cpu_start = (target_node + 0) * cpus_per_node;
-		int cpu_stop  = (target_node + 1) * cpus_per_node;
-
-		BUG_ON(cpu_stop > g->p.nr_cpus);
+		struct bitmask *cpumask = numa_allocate_cpumask();
 
-		for (cpu = cpu_start; cpu < cpu_stop; cpu++)
-			CPU_SET(cpu, &mask);
+		BUG_ON(!cpumask);
+		if (!numa_node_to_cpus(target_node, cpumask)) {
+			for (cpu = 0; cpu < (int)cpumask->size; cpu++) {
+				if (numa_bitmask_isbitset(cpumask, cpu))
+					CPU_SET(cpu, &mask);
+			}
+		}
 	}
 
 	ret = sched_setaffinity(0, sizeof(mask), &mask);
-- 
1.8.3.1

