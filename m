Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD44C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 06:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 711752078D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 06:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q77inBMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgHJGWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 02:22:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725808AbgHJGWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 02:22:19 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07A62mDr003317;
        Mon, 10 Aug 2020 02:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=+vOVDz5vOViBE0HyVBNzS9vH4zM4sWUVSg7XjMPQCf4=;
 b=Q77inBMnCSgf1lWojDBd58hgijbjvZL6j3rjSmQ0h43bKcmB5ODoAH8RqNBdEcmltyIx
 O4UAZumNUCbOHxtvmvyoN63re6IWAd/JSLyqMMSQefDmeooQ38wJzlpIRMiHx7tcf+o4
 N3FtDTgyNlb9s+JeHC3wG3/t5HWGRUdgWn5lCcx0tBXEvDEjKtyBQbLLPf0s3hgTB8gT
 oSd5syQ+S/i5J2QguQEF8nscUsEE/AG+mAuv6yfzy7nhho8P4jZMGgjCtAlZsQ4L6tG1
 RGOEYG2Y4duW9HUIl0K3zeEeE7VD6zpCk8XHtUJNuQuaTD9w7QLeLcxq4DdN2fduVQLP Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32src11uqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 02:22:08 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07A62n9O003438;
        Mon, 10 Aug 2020 02:22:08 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32src11uq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 02:22:08 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07A6LhxS016005;
        Mon, 10 Aug 2020 06:22:06 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 32skah9xcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 06:22:05 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07A6M3UC13893912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Aug 2020 06:22:03 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF7F1A404D;
        Mon, 10 Aug 2020 06:22:03 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F214A4055;
        Mon, 10 Aug 2020 06:22:03 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.20.209])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 Aug 2020 06:22:03 +0000 (GMT)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Balamuruhan S <bala24@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v2 1/3] perf bench numa: use numa_node_to_cpus() to bind tasks to nodes
Date:   Mon, 10 Aug 2020 08:21:58 +0200
Message-Id: <a002ebf17a3970e5d2dc7b9869dc180e68b88db4.1597004831.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1597004831.git.agordeev@linux.ibm.com>
References: <cover.1597004831.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-10_02:2020-08-06,2020-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008100043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is currently assumed that each node contains at most
nr_cpus/nr_nodes CPUs and node CPU ranges do not overlap.
That assumption is generally incorrect as there are archs
where a CPU number does not depend on to its node number.

This update removes the described assumption by simply calling
numa_node_to_cpus() interface and using the returned mask for
binding CPUs to nodes. It also tightens a cpumask allocation
failure check a bit.

Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Balamuruhan S <bala24@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
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

