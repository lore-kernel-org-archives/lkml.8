Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B82C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 03:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27C5420738
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 03:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgHDDiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 23:38:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39602 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728516AbgHDDiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 23:38:23 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0743blDc134506;
        Mon, 3 Aug 2020 23:38:02 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32pxt518jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 23:37:58 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0743EnHM018095;
        Tue, 4 Aug 2020 03:33:37 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 32n0189qww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 03:33:37 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0743XYmd32440750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Aug 2020 03:33:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A173F11C04A;
        Tue,  4 Aug 2020 03:33:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3376111C04C;
        Tue,  4 Aug 2020 03:33:31 +0000 (GMT)
Received: from srikart450.in.ibm.com (unknown [9.77.201.172])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Aug 2020 03:33:30 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
Subject: [PATCH 2/2] powerpc/topology: Override cpu_smt_mask
Date:   Tue,  4 Aug 2020 09:03:07 +0530
Message-Id: <20200804033307.76111-2-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200804033307.76111-1-srikar@linux.vnet.ibm.com>
References: <20200804033307.76111-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_15:2020-08-03,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008040025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Power9 a pair of cores can be presented by the firmware as a big-core
for backward compatibility reasons, with 4 threads per (small) core and 8
threads per big-core. cpu_smt_mask() should generally point to the cpu mask
of the (small)core.

In order to maintain userspace backward compatibility (with Power8 chips in
case of Power9) in enterprise Linux systems, the topology_sibling_cpumask
has to be set to big-core. Hence override the default cpu_smt_mask() to be
powerpc specific allowing for better scheduling behaviour on Power.

Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cputhreads.h |  1 -
 arch/powerpc/include/asm/smp.h        | 13 +++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include/asm/cputhreads.h
index deb99fd6e060..98c8bd155bf9 100644
--- a/arch/powerpc/include/asm/cputhreads.h
+++ b/arch/powerpc/include/asm/cputhreads.h
@@ -23,7 +23,6 @@
 extern int threads_per_core;
 extern int threads_per_subcore;
 extern int threads_shift;
-extern bool has_big_cores;
 extern cpumask_t threads_core_mask;
 #else
 #define threads_per_core	1
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 9cd0765633c5..d4bc28accb28 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -131,6 +131,19 @@ static inline struct cpumask *cpu_smallcore_mask(int cpu)
 
 extern int cpu_to_core_id(int cpu);
 
+extern bool has_big_cores;
+
+#define cpu_smt_mask cpu_smt_mask
+#ifdef CONFIG_SCHED_SMT
+static inline const struct cpumask *cpu_smt_mask(int cpu)
+{
+	if (has_big_cores)
+		return per_cpu(cpu_smallcore_map, cpu);
+
+	return per_cpu(cpu_sibling_map, cpu);
+}
+#endif /* CONFIG_SCHED_SMT */
+
 /* Since OpenPIC has only 4 IPIs, we use slightly different message numbers.
  *
  * Make sure this matches openpic_request_IPIs in open_pic.c, or what shows up
-- 
2.18.2

