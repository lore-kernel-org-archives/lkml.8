Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6479C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B62D02075D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgG0FS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 01:18:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62710 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726064AbgG0FS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 01:18:56 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06R51qEH021032;
        Mon, 27 Jul 2020 01:18:40 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32hrcy0dvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 01:18:40 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06R51vOm021564;
        Mon, 27 Jul 2020 01:18:39 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32hrcy0dua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 01:18:39 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06R5EnOt013182;
        Mon, 27 Jul 2020 05:18:37 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 32gcr0h3sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 05:18:37 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06R5IZ5Z17498154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 05:18:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AABFA404D;
        Mon, 27 Jul 2020 05:18:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F138DA4040;
        Mon, 27 Jul 2020 05:18:31 +0000 (GMT)
Received: from srikart450.in.ibm.com (unknown [9.85.97.241])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Jul 2020 05:18:31 +0000 (GMT)
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
Subject: [PATCH v4 05/10] powerpc/smp: Dont assume l2-cache to be superset of sibling
Date:   Mon, 27 Jul 2020 10:48:00 +0530
Message-Id: <20200727051805.16728-6-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727051805.16728-1-srikar@linux.vnet.ibm.com>
References: <20200727051805.16728-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_03:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 clxscore=1015 mlxscore=0 phishscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007270032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code assumes that cpumask of cpus sharing a l2-cache mask will
always be a superset of cpu_sibling_mask.

Lets stop that assumption. cpu_l2_cache_mask is a superset of
cpu_sibling_mask if and only if shared_caches is set.

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
Changelog v1 -> v2:
	Set cpumask after verifying l2-cache. (Gautham)

 arch/powerpc/kernel/smp.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index da27f6909be1..d997c7411664 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1194,6 +1194,7 @@ static bool update_mask_by_l2(int cpu, struct cpumask *(*mask_fn)(int))
 	if (!l2_cache)
 		return false;
 
+	cpumask_set_cpu(cpu, mask_fn(cpu));
 	for_each_cpu(i, cpu_online_mask) {
 		/*
 		 * when updating the marks the current CPU has not been marked
@@ -1276,29 +1277,30 @@ static void add_cpu_to_masks(int cpu)
 	 * add it to it's own thread sibling mask.
 	 */
 	cpumask_set_cpu(cpu, cpu_sibling_mask(cpu));
+	cpumask_set_cpu(cpu, cpu_core_mask(cpu));
 
 	for (i = first_thread; i < first_thread + threads_per_core; i++)
 		if (cpu_online(i))
 			set_cpus_related(i, cpu, cpu_sibling_mask);
 
 	add_cpu_to_smallcore_masks(cpu);
-	/*
-	 * Copy the thread sibling mask into the cache sibling mask
-	 * and mark any CPUs that share an L2 with this CPU.
-	 */
-	for_each_cpu(i, cpu_sibling_mask(cpu))
-		set_cpus_related(cpu, i, cpu_l2_cache_mask);
 	update_mask_by_l2(cpu, cpu_l2_cache_mask);
 
-	/*
-	 * Copy the cache sibling mask into core sibling mask and mark
-	 * any CPUs on the same chip as this CPU.
-	 */
-	for_each_cpu(i, cpu_l2_cache_mask(cpu))
-		set_cpus_related(cpu, i, cpu_core_mask);
+	if (pkg_id == -1) {
+		struct cpumask *(*mask)(int) = cpu_sibling_mask;
+
+		/*
+		 * Copy the sibling mask into core sibling mask and
+		 * mark any CPUs on the same chip as this CPU.
+		 */
+		if (shared_caches)
+			mask = cpu_l2_cache_mask;
+
+		for_each_cpu(i, mask(cpu))
+			set_cpus_related(cpu, i, cpu_core_mask);
 
-	if (pkg_id == -1)
 		return;
+	}
 
 	for_each_cpu(i, cpu_online_mask)
 		if (get_physical_package_id(i) == pkg_id)
-- 
2.17.1

