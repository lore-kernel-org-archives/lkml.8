Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D79C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3042077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731987AbgDAGOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 02:14:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19172 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731895AbgDAGOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 02:14:38 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03163STa018278
        for <linux-kernel@vger.kernel.org>; Wed, 1 Apr 2020 02:14:37 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30227wrksx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 02:14:37 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 1 Apr 2020 07:14:21 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Apr 2020 07:14:16 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0316ESO958917010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Apr 2020 06:14:28 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7F30A405B;
        Wed,  1 Apr 2020 06:14:28 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AA36A4040;
        Wed,  1 Apr 2020 06:14:25 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.48.114])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Apr 2020 06:14:25 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        christophe.leroy@c-s.fr, naveen.n.rao@linux.vnet.ibm.com,
        peterz@infradead.org, jolsa@kernel.org, oleg@redhat.com,
        fweisbec@gmail.com, mingo@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com
Subject: [PATCH v2 12/16] powerpc/watchpoint: Use builtin ALIGN*() macros
Date:   Wed,  1 Apr 2020 11:43:05 +0530
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401061309.92442-1-ravi.bangoria@linux.ibm.com>
References: <20200401061309.92442-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20040106-4275-0000-0000-000003B769CD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040106-4276-0000-0000-000038CCBB7B
Message-Id: <20200401061309.92442-13-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004010054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we calculate hw aligned start and end addresses manually.
Replace them with builtin ALIGN_DOWN() and ALIGN() macros.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/include/asm/hw_breakpoint.h  | 5 +++--
 arch/powerpc/kernel/hw_breakpoint.c       | 6 +++---
 arch/powerpc/kernel/process.c             | 4 ++--
 arch/powerpc/kernel/ptrace/ptrace-noadv.c | 2 +-
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index fae33c729ba9..abc4603c0efe 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -34,10 +34,11 @@ struct arch_hw_breakpoint {
 #define HW_BRK_TYPE_PRIV_ALL	(HW_BRK_TYPE_USER | HW_BRK_TYPE_KERNEL | \
 				 HW_BRK_TYPE_HYP)
 
+/* Minimum granularity */
 #ifdef CONFIG_PPC_8xx
-#define HW_BREAKPOINT_ALIGN 0x3
+#define HW_BREAKPOINT_SIZE  0x4
 #else
-#define HW_BREAKPOINT_ALIGN 0x7
+#define HW_BREAKPOINT_SIZE  0x8
 #endif
 
 #define DABR_MAX_LEN	8
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 8d3f7d87d790..71274fbbac38 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -145,7 +145,7 @@ int arch_bp_generic_fields(int type, int *gen_bp_type)
  *    <---8 bytes--->
  *
  * In this case, we should configure hw as:
- *   start_addr = address & ~HW_BREAKPOINT_ALIGN
+ *   start_addr = address & ~(HW_BREAKPOINT_SIZE - 1)
  *   len = 16 bytes
  *
  * @start_addr and @end_addr are inclusive.
@@ -156,8 +156,8 @@ static int hw_breakpoint_validate_len(struct arch_hw_breakpoint *hw)
 	u16 hw_len;
 	unsigned long start_addr, end_addr;
 
-	start_addr = hw->address & ~HW_BREAKPOINT_ALIGN;
-	end_addr = (hw->address + hw->len - 1) | HW_BREAKPOINT_ALIGN;
+	start_addr = ALIGN_DOWN(hw->address, HW_BREAKPOINT_SIZE);
+	end_addr = ALIGN(hw->address + hw->len, HW_BREAKPOINT_SIZE) - 1;
 	hw_len = end_addr - start_addr + 1;
 
 	if (dawr_enabled()) {
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 73c0800f0bcf..cbd6e9b79401 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -794,8 +794,8 @@ static inline int set_breakpoint_8xx(struct arch_hw_breakpoint *brk)
 	unsigned long lctrl1 = LCTRL1_CTE_GT | LCTRL1_CTF_LT | LCTRL1_CRWE_RW |
 			       LCTRL1_CRWF_RW;
 	unsigned long lctrl2 = LCTRL2_LW0EN | LCTRL2_LW0LADC | LCTRL2_SLW0EN;
-	unsigned long start_addr = brk->address & ~HW_BREAKPOINT_ALIGN;
-	unsigned long end_addr = (brk->address + brk->len - 1) | HW_BREAKPOINT_ALIGN;
+	unsigned long start_addr = ALIGN_DOWN(brk->address, HW_BREAKPOINT_SIZE);
+	unsigned long end_addr = ALIGN(brk->address + brk->len, HW_BREAKPOINT_SIZE) - 1;
 
 	if (start_addr == 0)
 		lctrl2 |= LCTRL2_LW0LA_F;
diff --git a/arch/powerpc/kernel/ptrace/ptrace-noadv.c b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
index 08cb8c1b504c..697c7e4b5877 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-noadv.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
@@ -216,7 +216,7 @@ long ppc_set_hwdebug(struct task_struct *child, struct ppc_hw_breakpoint *bp_inf
 	if ((unsigned long)bp_info->addr >= TASK_SIZE)
 		return -EIO;
 
-	brk.address = bp_info->addr & ~HW_BREAKPOINT_ALIGN;
+	brk.address = ALIGN_DOWN(bp_info->addr, HW_BREAKPOINT_SIZE);
 	brk.type = HW_BRK_TYPE_TRANSLATE;
 	brk.len = DABR_MAX_LEN;
 	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_READ)
-- 
2.21.1

