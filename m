Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CAEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C54452075D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H7bwpans"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgHJHT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 03:19:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47570 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726361AbgHJHTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 03:19:25 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07A73N0l196195;
        Mon, 10 Aug 2020 03:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7UTETwyFm7KGZrmv+lVcWIti+O4pQ926ZhBvhr3W6Mc=;
 b=H7bwpansGCM71shNYtVGltcIZyovdl9CelXNwwr9m5IpQDOw3AZVTLxcvSZ170fpUDuY
 M4YtUvvgm1GIYgoy/KWS21tWty413Qbf6q8KgpwjAg8a5RVu0QxhUqosHfVpdwX0uD4c
 d8iKm0wZTcQLDMJoUt2ElcCjYq7sOMifq8jKPvMCwZFWN0oICOKpDypVEsmfnxuBBbJZ
 xpcZ2JOzOaCdTOZVMxlGCgYifkSop4gaPhLBnehSvtj3RrxqndOPVP7iFBQkUQvHy85E
 15IhqJO5xPvvpdSb7YvdfmlKRg7/DlnijJt8ZzSBByAwoHQ9bQfsi6Mt0PNrW3ScKWDb TA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32sr4qus41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 03:19:06 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07A74drN005371;
        Mon, 10 Aug 2020 03:19:06 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32sr4qus2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 03:19:05 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07A7GDpg003619;
        Mon, 10 Aug 2020 07:19:04 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 32skp7s7ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 07:19:03 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07A7J1MZ24576434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Aug 2020 07:19:01 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C65911C05B;
        Mon, 10 Aug 2020 07:19:01 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5485711C052;
        Mon, 10 Aug 2020 07:18:58 +0000 (GMT)
Received: from srikart450.in.ibm.com (unknown [9.102.18.208])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 Aug 2020 07:18:58 +0000 (GMT)
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
        Jordan Niethe <jniethe5@gmail.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
Subject: [PATCH v5 06/10] powerpc/smp: Optimize start_secondary
Date:   Mon, 10 Aug 2020 12:48:30 +0530
Message-Id: <20200810071834.92514-7-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200810071834.92514-1-srikar@linux.vnet.ibm.com>
References: <20200810071834.92514-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-10_02:2020-08-06,2020-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008100048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In start_secondary, even if shared_cache was already set, system does a
redundant match for cpumask. This redundant check can be removed by
checking if shared_cache is already set.

While here, localize the sibling_mask variable to within the if
condition.

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
Cc: Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changelog v4 ->v5:
	Retain cache domain, no need for generalization
		 (Michael Ellerman, Peter Zijlstra,
		 Valentin Schneider, Gautham R. Shenoy)

Changelog v1 -> v2:
	Moved shared_cache topology fixup to fixup_topology (Gautham)

 arch/powerpc/kernel/smp.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 0c960ce3be42..91cf5d05e7ec 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -851,7 +851,7 @@ static int powerpc_shared_cache_flags(void)
  */
 static const struct cpumask *shared_cache_mask(int cpu)
 {
-	return cpu_l2_cache_mask(cpu);
+	return per_cpu(cpu_l2_cache_map, cpu);
 }
 
 #ifdef CONFIG_SCHED_SMT
@@ -1305,7 +1305,6 @@ static void add_cpu_to_masks(int cpu)
 void start_secondary(void *unused)
 {
 	unsigned int cpu = smp_processor_id();
-	struct cpumask *(*sibling_mask)(int) = cpu_sibling_mask;
 
 	mmgrab(&init_mm);
 	current->active_mm = &init_mm;
@@ -1331,14 +1330,20 @@ void start_secondary(void *unused)
 	/* Update topology CPU masks */
 	add_cpu_to_masks(cpu);
 
-	if (has_big_cores)
-		sibling_mask = cpu_smallcore_mask;
 	/*
 	 * Check for any shared caches. Note that this must be done on a
 	 * per-core basis because one core in the pair might be disabled.
 	 */
-	if (!cpumask_equal(cpu_l2_cache_mask(cpu), sibling_mask(cpu)))
-		shared_caches = true;
+	if (!shared_caches) {
+		struct cpumask *(*sibling_mask)(int) = cpu_sibling_mask;
+		struct cpumask *mask = cpu_l2_cache_mask(cpu);
+
+		if (has_big_cores)
+			sibling_mask = cpu_smallcore_mask;
+
+		if (cpumask_weight(mask) > cpumask_weight(sibling_mask(cpu)))
+			shared_caches = true;
+	}
 
 	set_numa_node(numa_cpu_lookup_table[cpu]);
 	set_numa_mem(local_memory_node(numa_cpu_lookup_table[cpu]));
-- 
2.18.2

