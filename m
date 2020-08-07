Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783CEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 547D5221E5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V6gpAB+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgHGHpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:45:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727077AbgHGHpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:45:52 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0777VVDY083462;
        Fri, 7 Aug 2020 03:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=7APp82u1fCIlemZu0jLuz5QrArJmIFqrMX78hUa7qdo=;
 b=V6gpAB+7J9/ujY1w9q4oJi/jEjLfGyjtqUGqAPsIsnz9WA8wjBa/19pEBTwikE9Xbavl
 wmvLrf8CA4pPDt7mQf+5YyAHDBtY2rdWxqSJYtYr6jg34RZelnhwfd2v7Yz+nyhX1TiE
 ndtEincxtUpJdfngl+523HsE+tR7bKmW/RFdYIsM4Jc2xis33AgmlYlqV0lkymeN6HDE
 mCrgGPkec63NcDbwwJ+11+Ipt307Enz0EZD5n29OmREcJr0WWxamQmAJRPusC5bATmv5
 lSEuQwedO65Y3S+Gj2Ersf9sa3wIB84eBdzx6lyZ6WbuunXLUzFRqfZWUubmTOlpYbOf TA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32rnu9met2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 03:45:30 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0777eQKO019843;
        Fri, 7 Aug 2020 07:45:28 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 32n0186d1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 07:45:28 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0777jQ6u65143248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Aug 2020 07:45:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27605AE056;
        Fri,  7 Aug 2020 07:45:26 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13843AE051;
        Fri,  7 Aug 2020 07:45:22 +0000 (GMT)
Received: from srikart450.in.ibm.com (unknown [9.199.45.118])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  7 Aug 2020 07:45:21 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
Subject: [PATCH v2 1/2] sched/topology: Allow archs to override cpu_smt_mask
Date:   Fri,  7 Aug 2020 13:15:16 +0530
Message-Id: <20200807074517.27957-1-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_02:2020-08-06,2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008070051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_smt_mask tracks topology_sibling_cpumask. This would be good for
most architectures. One of the users of cpu_smt_mask(), would be to
identify idle-cores. On Power9, a pair of SMT4 cores can be presented by
the firmware as a SMT8 core for backward compatibility reasons.

Powerpc allows LPARs to be live migrated from Power8 to Power9. Do note
Power8 had only SMT8 cores. Existing software which has been
developed/configured for Power8 would expect to see SMT8 core.
Maintaining the illusion of SMT8 core is a requirement to make that
work.

In order to maintain above userspace backward compatibility with
previous versions of processor, Power9 onwards there is option to the
firmware to advertise a pair of SMT4 cores as a fused cores aka SMT8
core. On Power9 this pair shares the L2 cache as well. However, from the
scheduler's point of view, a core should be determined by SMT4, since
its a completely independent unit of compute. Hence allow PowerPc
architecture to override the default cpu_smt_mask() to point to the SMT4
cores in a SMT8 mode.

This will ensure the scheduler is always given the right information.

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
Acked-by; Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changelog v1->v2:
	Update the commit msg based on the discussion in community esp
	with Peter Zijlstra and Michael Ellerman.

 include/linux/topology.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/topology.h b/include/linux/topology.h
index 608fa4aadf0e..ad03df1cc266 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -198,7 +198,7 @@ static inline int cpu_to_mem(int cpu)
 #define topology_die_cpumask(cpu)		cpumask_of(cpu)
 #endif
 
-#ifdef CONFIG_SCHED_SMT
+#if defined(CONFIG_SCHED_SMT) && !defined(cpu_smt_mask)
 static inline const struct cpumask *cpu_smt_mask(int cpu)
 {
 	return topology_sibling_cpumask(cpu);
-- 
2.18.2

