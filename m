Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4E4C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA45520643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgEGNhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 09:37:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725857AbgEGNht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 09:37:49 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047DXLcf089550;
        Thu, 7 May 2020 09:37:37 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30ux6ex67m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 09:37:37 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 047DXQQ5089814;
        Thu, 7 May 2020 09:37:36 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30ux6ex65w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 09:37:36 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 047DV7Z3002197;
        Thu, 7 May 2020 13:37:34 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 30s0g5mmre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 13:37:33 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 047DbVmh64422016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 May 2020 13:37:31 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B2AEAE053;
        Thu,  7 May 2020 13:37:31 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9521AAE051;
        Thu,  7 May 2020 13:37:28 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.85.97.135])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 May 2020 13:37:28 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com,
        chris.hyser@oracle.com, pkondeti@codeaurora.org,
        valentin.schneider@arm.com, rjw@rjwysocki.net
Subject: [RFC 1/4] sched/core: Introduce per_cpu counter to track latency sensitive tasks
Date:   Thu,  7 May 2020 19:07:20 +0530
Message-Id: <20200507133723.18325-2-parth@linux.ibm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200507133723.18325-1-parth@linux.ibm.com>
References: <20200507133723.18325-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_08:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=1 phishscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "nr_lat_sensitive" per_cpu variable provides hints on the possible
number of latency-sensitive tasks occupying the CPU. This hints further
helps in inhibiting the CPUIDLE governor from calling deeper IDLE states
(next patches includes this).

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 kernel/sched/core.c  | 2 ++
 kernel/sched/sched.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2576fd8cacf9..2d8b76f41d61 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6606,6 +6606,7 @@ static struct kmem_cache *task_group_cache __read_mostly;
 
 DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
 DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
+DEFINE_PER_CPU(int, nr_lat_sensitive);
 
 void __init sched_init(void)
 {
@@ -6737,6 +6738,7 @@ void __init sched_init(void)
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
+		per_cpu(nr_lat_sensitive, i) = 0;
 	}
 
 	set_load_weight(&init_task, false);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b2c86dfe913e..5c41020c530e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1439,6 +1439,8 @@ DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
+DECLARE_PER_CPU(int, nr_lat_sensitive);
+
 extern struct static_key_false sched_asym_cpucapacity;
 
 struct sched_group_capacity {
-- 
2.17.2

