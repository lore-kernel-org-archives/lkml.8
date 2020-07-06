Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B223C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EEC92075B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgGFJnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 05:43:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51986 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728517AbgGFJnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 05:43:09 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0669XgDN161450;
        Mon, 6 Jul 2020 05:43:07 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3237cfv6er-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 05:43:07 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0669aM2F003137;
        Mon, 6 Jul 2020 09:43:05 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 322hd7s2vh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 09:43:05 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0669h26F46071966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jul 2020 09:43:02 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CED752059;
        Mon,  6 Jul 2020 09:43:02 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.151.4])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0FEEB5204F;
        Mon,  6 Jul 2020 09:43:02 +0000 (GMT)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 1/3] perf bench numa: fix incorrect NUMA toplogy assumption
Date:   Mon,  6 Jul 2020 11:42:52 +0200
Message-Id: <73667aca03e6f2e1247729f203490166ed16a83d.1594028310.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1594028310.git.agordeev@linux.ibm.com>
References: <cover.1594028310.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_07:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=1 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 cotscore=-2147483648 malwarescore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007060075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code assumes that CPUs are evenly spread among
NUMA nodes. That is generally incorrect and leads to failure
on systems that have different NUMA topology.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 tools/perf/bench/numa.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 5797253..23e224e 100644
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
+	BUG_ON(!cpumask);
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

