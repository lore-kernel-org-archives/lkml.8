Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F32C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACBBF22CF7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgGWJJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 05:09:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725984AbgGWJJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 05:09:19 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06N93Xm8188784;
        Thu, 23 Jul 2020 05:08:54 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32f1gxgxpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 05:08:54 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06N93ipM190333;
        Thu, 23 Jul 2020 05:08:53 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32f1gxgxnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 05:08:53 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06N981mG017940;
        Thu, 23 Jul 2020 09:08:51 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 32brq837c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 09:08:51 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06N98kis23069116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 09:08:47 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE3684C040;
        Thu, 23 Jul 2020 09:08:46 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAE914C044;
        Thu, 23 Jul 2020 09:08:39 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.40.160])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jul 2020 09:08:39 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org
Cc:     ravi.bangoria@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        christophe.leroy@c-s.fr, naveen.n.rao@linux.vnet.ibm.com,
        peterz@infradead.org, jolsa@kernel.org, oleg@redhat.com,
        fweisbec@gmail.com, mingo@kernel.org, pedromfc@br.ibm.com,
        miltonm@us.ibm.com, jniethe5@gmail.com, rogealve@br.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/10] powerpc/watchpoint: Fix DAWR exception for CACHEOP
Date:   Thu, 23 Jul 2020 14:38:06 +0530
Message-Id: <20200723090813.303838-4-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723090813.303838-1-ravi.bangoria@linux.ibm.com>
References: <20200723090813.303838-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_03:2020-07-22,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=991
 suspectscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'ea' returned by analyse_instr() needs to be aligned down to cache
block size for CACHEOP instructions. analyse_instr() does not set
size for CACHEOP, thus size also needs to be calculated manually.

Fixes: 27985b2a640e ("powerpc/watchpoint: Don't ignore extraneous exceptions blindly")
Fixes: 74c6881019b7 ("powerpc/watchpoint: Prepare handler to handle more than one watchpoint")
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/kernel/hw_breakpoint.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index a971e22aea81..c55e67bab271 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -538,7 +538,12 @@ static bool check_dawrx_constraints(struct pt_regs *regs, int type,
 	if (OP_IS_LOAD(type) && !(info->type & HW_BRK_TYPE_READ))
 		return false;
 
-	if (OP_IS_STORE(type) && !(info->type & HW_BRK_TYPE_WRITE))
+	/*
+	 * The Cache Management instructions other than dcbz never
+	 * cause a match. i.e. if type is CACHEOP, the instruction
+	 * is dcbz, and dcbz is treated as Store.
+	 */
+	if ((OP_IS_STORE(type) || type == CACHEOP) && !(info->type & HW_BRK_TYPE_WRITE))
 		return false;
 
 	if (is_kernel_addr(regs->nip) && !(info->type & HW_BRK_TYPE_KERNEL))
@@ -601,6 +606,15 @@ static bool check_constraints(struct pt_regs *regs, struct ppc_inst instr,
 	return false;
 }
 
+static int cache_op_size(void)
+{
+#ifdef __powerpc64__
+	return ppc64_caches.l1d.block_size;
+#else
+	return L1_CACHE_BYTES;
+#endif
+}
+
 static void get_instr_detail(struct pt_regs *regs, struct ppc_inst *instr,
 			     int *type, int *size, unsigned long *ea)
 {
@@ -616,7 +630,12 @@ static void get_instr_detail(struct pt_regs *regs, struct ppc_inst *instr,
 	if (!(regs->msr & MSR_64BIT))
 		*ea &= 0xffffffffUL;
 #endif
+
 	*size = GETSIZE(op.type);
+	if (*type == CACHEOP) {
+		*size = cache_op_size();
+		*ea &= ~(*size - 1);
+	}
 }
 
 static bool is_larx_stcx_instr(int type)
-- 
2.26.2

