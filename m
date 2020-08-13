Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B870DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B6B920771
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CT2txYln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgHMLdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 07:33:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58608 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726102AbgHMLdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 07:33:02 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07DBWLDn054680;
        Thu, 13 Aug 2020 07:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=mMGMjPv7ZwUAbyTZWDz0DYRlZFQsRe+W3kcv25Wh7eQ=;
 b=CT2txYlnNLArx4h78c2VTVzi5WHyARGTFgp3VGixrL+441QBLocI8oIJ24Bx8yUYvkDE
 1Sh44EXLURVBGz6Xc9ybaWuU7FrQb13nalSfu3Sy+6eavwR035VeTZYXNMRdoJ2xaVBH
 8AucLa7H+xvtxFg3MeDiSrpItTvj3ABJiFfCKbtTEKpiFOnPbFYuW+hzzONKgkFmE7uO
 e9ZAo9ubE0sveBewe1o9rf2pE9LbEjL7XtWlQ6Qg8eq+7XXRiJlfCkmDLxG8EzDlHON+
 nd4RLspQ8xCQd/Oih8cRiNHCQWHdEVye7arTsWDjZAbQW3GpuFXaWXv7WBQ1YdAD+Pob jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32v7v10jvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 07:32:55 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07DBWsrG056562;
        Thu, 13 Aug 2020 07:32:54 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32v7v10jvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 07:32:54 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07DBVUtI009022;
        Thu, 13 Aug 2020 11:32:52 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 32skahdg62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 11:32:52 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07DBWojc25821596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Aug 2020 11:32:50 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DAB64C1AD;
        Thu, 13 Aug 2020 11:32:50 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CCED4C1A6;
        Thu, 13 Aug 2020 11:32:49 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.147.109])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 13 Aug 2020 11:32:49 +0000 (GMT)
Date:   Thu, 13 Aug 2020 13:32:48 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Balamuruhan S <bala24@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH v3 1/2] perf bench numa: use numa_node_to_cpus() to bind
 tasks to nodes
Message-ID: <20200813113247.GA2014@oc3871087118.ibm.com>
References: <cover.1597004831.git.agordeev@linux.ibm.com>
 <a002ebf17a3970e5d2dc7b9869dc180e68b88db4.1597004831.git.agordeev@linux.ibm.com>
 <CAM9d7cjLA29eOm6UU5FVE-Zeg7wm4bJaSdwMOH=ghDn=hfBo=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjLA29eOm6UU5FVE-Zeg7wm4bJaSdwMOH=ghDn=hfBo=A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_09:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=2 mlxscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is currently assumed that each node contains at most
nr_cpus/nr_nodes CPUs and nodes' CPU ranges do not overlap.
That assumption is generally incorrect as there are archs
where a CPU number does not depend on to its node number.

This update removes the described assumption by simply calling
numa_node_to_cpus() interface and using the returned mask for
binding CPUs to nodes.

Also, variable types and names made consistent in functions
using cpumask.

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
 tools/perf/bench/numa.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 9066511..6d5c890 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -247,20 +247,20 @@ static int is_node_present(int node)
  */
 static bool node_has_cpus(int node)
 {
-	struct bitmask *cpu = numa_allocate_cpumask();
+	struct bitmask *cpumask = numa_allocate_cpumask();
 	bool ret = false; /* fall back to nocpus */
-	unsigned int i;
+	int cpu;
 
-	BUG_ON(!cpu);
-	if (!numa_node_to_cpus(node, cpu)) {
-		for (i = 0; i < cpu->size; i++) {
-			if (numa_bitmask_isbitset(cpu, i)) {
+	BUG_ON(!cpumask);
+	if (!numa_node_to_cpus(node, cpumask)) {
+		for (cpu = 0; cpu < (int)cpumask->size; cpu++) {
+			if (numa_bitmask_isbitset(cpumask, cpu)) {
 				ret = true;
 				break;
 			}
 		}
 	}
-	numa_free_cpumask(cpu);
+	numa_free_cpumask(cpumask);
 
 	return ret;
 }
@@ -293,14 +293,10 @@ static cpu_set_t bind_to_cpu(int target_cpu)
 
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
 
@@ -310,13 +306,16 @@ static cpu_set_t bind_to_node(int target_node)
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
+		numa_free_cpumask(cpumask);
 	}
 
 	ret = sched_setaffinity(0, sizeof(mask), &mask);
-- 
1.8.3.1

