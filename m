Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A33C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFE692073E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgG0FXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 01:23:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10934 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726116AbgG0FXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 01:23:50 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06R5324e100318;
        Mon, 27 Jul 2020 01:23:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32h2bg7cn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 01:23:33 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06R53Ngr101240;
        Mon, 27 Jul 2020 01:23:33 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32h2bg7ckv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 01:23:32 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06R5F3O0013180;
        Mon, 27 Jul 2020 05:18:29 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 32gcy4htf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 05:18:29 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06R5IRHN59244610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 05:18:27 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C266A4053;
        Mon, 27 Jul 2020 05:18:27 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FC8AA404D;
        Mon, 27 Jul 2020 05:18:23 +0000 (GMT)
Received: from srikart450.in.ibm.com (unknown [9.85.97.241])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Jul 2020 05:18:23 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jordan Niethe <jniethe5@gmail.com>
Subject: [PATCH v4 03/10] powerpc/smp: Move powerpc_topology above
Date:   Mon, 27 Jul 2020 10:47:58 +0530
Message-Id: <20200727051805.16728-4-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727051805.16728-1-srikar@linux.vnet.ibm.com>
References: <20200727051805.16728-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_03:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just moving the powerpc_topology description above.
This will help in using functions in this file and avoid declarations.

No other functional changes

Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Anton Blanchard <anton@ozlabs.org>
Cc: Oliver O'Halloran <oohall@gmail.com>
Cc: Nathan Lynch <nathanl@linux.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Jordan Niethe <jniethe5@gmail.com>
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/smp.c | 116 +++++++++++++++++++-------------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 283a04e54f52..a685915e5941 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -818,6 +818,64 @@ static int init_cpu_l1_cache_map(int cpu)
 	return err;
 }
 
+static bool shared_caches;
+
+#ifdef CONFIG_SCHED_SMT
+/* cpumask of CPUs with asymmetric SMT dependency */
+static int powerpc_smt_flags(void)
+{
+	int flags = SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
+
+	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
+		printk_once(KERN_INFO "Enabling Asymmetric SMT scheduling\n");
+		flags |= SD_ASYM_PACKING;
+	}
+	return flags;
+}
+#endif
+
+/*
+ * P9 has a slightly odd architecture where pairs of cores share an L2 cache.
+ * This topology makes it *much* cheaper to migrate tasks between adjacent cores
+ * since the migrated task remains cache hot. We want to take advantage of this
+ * at the scheduler level so an extra topology level is required.
+ */
+static int powerpc_shared_cache_flags(void)
+{
+	return SD_SHARE_PKG_RESOURCES;
+}
+
+/*
+ * We can't just pass cpu_l2_cache_mask() directly because
+ * returns a non-const pointer and the compiler barfs on that.
+ */
+static const struct cpumask *shared_cache_mask(int cpu)
+{
+	if (shared_caches)
+		return cpu_l2_cache_mask(cpu);
+
+	if (has_big_cores)
+		return cpu_smallcore_mask(cpu);
+
+	return per_cpu(cpu_sibling_map, cpu);
+}
+
+#ifdef CONFIG_SCHED_SMT
+static const struct cpumask *smallcore_smt_mask(int cpu)
+{
+	return cpu_smallcore_mask(cpu);
+}
+#endif
+
+static struct sched_domain_topology_level powerpc_topology[] = {
+#ifdef CONFIG_SCHED_SMT
+	{ cpu_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT) },
+#endif
+	{ shared_cache_mask, powerpc_shared_cache_flags, SD_INIT_NAME(CACHE) },
+	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ NULL, },
+};
+
 static int init_big_cores(void)
 {
 	int cpu;
@@ -1247,8 +1305,6 @@ static void add_cpu_to_masks(int cpu)
 			set_cpus_related(cpu, i, cpu_core_mask);
 }
 
-static bool shared_caches;
-
 /* Activate a secondary processor. */
 void start_secondary(void *unused)
 {
@@ -1312,62 +1368,6 @@ int setup_profiling_timer(unsigned int multiplier)
 	return 0;
 }
 
-#ifdef CONFIG_SCHED_SMT
-/* cpumask of CPUs with asymmetric SMT dependency */
-static int powerpc_smt_flags(void)
-{
-	int flags = SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
-
-	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
-		printk_once(KERN_INFO "Enabling Asymmetric SMT scheduling\n");
-		flags |= SD_ASYM_PACKING;
-	}
-	return flags;
-}
-#endif
-
-/*
- * P9 has a slightly odd architecture where pairs of cores share an L2 cache.
- * This topology makes it *much* cheaper to migrate tasks between adjacent cores
- * since the migrated task remains cache hot. We want to take advantage of this
- * at the scheduler level so an extra topology level is required.
- */
-static int powerpc_shared_cache_flags(void)
-{
-	return SD_SHARE_PKG_RESOURCES;
-}
-
-/*
- * We can't just pass cpu_l2_cache_mask() directly because
- * returns a non-const pointer and the compiler barfs on that.
- */
-static const struct cpumask *shared_cache_mask(int cpu)
-{
-	if (shared_caches)
-		return cpu_l2_cache_mask(cpu);
-
-	if (has_big_cores)
-		return cpu_smallcore_mask(cpu);
-
-	return per_cpu(cpu_sibling_map, cpu);
-}
-
-#ifdef CONFIG_SCHED_SMT
-static const struct cpumask *smallcore_smt_mask(int cpu)
-{
-	return cpu_smallcore_mask(cpu);
-}
-#endif
-
-static struct sched_domain_topology_level powerpc_topology[] = {
-#ifdef CONFIG_SCHED_SMT
-	{ cpu_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT) },
-#endif
-	{ shared_cache_mask, powerpc_shared_cache_flags, SD_INIT_NAME(CACHE) },
-	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
-	{ NULL, },
-};
-
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 	/*
-- 
2.17.1

