Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06608C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC3FA20732
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404695AbgDNDWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 23:22:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404366AbgDNDWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 23:22:51 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03E33GvG033549
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 23:22:51 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30b6sfmp1y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 23:22:50 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 14 Apr 2020 04:22:31 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Apr 2020 04:22:25 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03E3Mf1Z58589230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 03:22:41 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D3F65204F;
        Tue, 14 Apr 2020 03:22:41 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.60.157])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 77BB752051;
        Tue, 14 Apr 2020 03:22:06 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        christophe.leroy@c-s.fr, naveen.n.rao@linux.vnet.ibm.com,
        peterz@infradead.org, jolsa@kernel.org, oleg@redhat.com,
        fweisbec@gmail.com, mingo@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com
Subject: [PATCH v3 12/16] powerpc/watchpoint: Use builtin ALIGN*() macros
Date:   Tue, 14 Apr 2020 08:46:55 +0530
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200414031659.58875-1-ravi.bangoria@linux.ibm.com>
References: <20200414031659.58875-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20041403-0012-0000-0000-000003A4115B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041403-0013-0000-0000-000021E1462B
Message-Id: <20200414031659.58875-13-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_11:2020-04-13,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004140024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we calculate hw aligned start and end addresses manually.
Replace them with builtin ALIGN_DOWN() and ALIGN() macros.

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/include/asm/hw_breakpoint.h  |  5 +++--
 arch/powerpc/kernel/hw_breakpoint.c       | 12 ++++++------
 arch/powerpc/kernel/process.c             |  8 ++++----
 arch/powerpc/kernel/ptrace/ptrace-noadv.c |  2 +-
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index d472b2eb757e..add5aa076919 100644
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
index 319a761b7412..02ffd14f4519 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -145,10 +145,10 @@ int arch_bp_generic_fields(int type, int *gen_bp_type)
  *    <---8 bytes--->
  *
  * In this case, we should configure hw as:
- *   start_addr = address & ~HW_BREAKPOINT_ALIGN
+ *   start_addr = address & ~(HW_BREAKPOINT_SIZE - 1)
  *   len = 16 bytes
  *
- * @start_addr and @end_addr are inclusive.
+ * @start_addr is inclusive but @end_addr is exclusive.
  */
 static int hw_breakpoint_validate_len(struct arch_hw_breakpoint *hw)
 {
@@ -156,14 +156,14 @@ static int hw_breakpoint_validate_len(struct arch_hw_breakpoint *hw)
 	u16 hw_len;
 	unsigned long start_addr, end_addr;
 
-	start_addr = hw->address & ~HW_BREAKPOINT_ALIGN;
-	end_addr = (hw->address + hw->len - 1) | HW_BREAKPOINT_ALIGN;
-	hw_len = end_addr - start_addr + 1;
+	start_addr = ALIGN_DOWN(hw->address, HW_BREAKPOINT_SIZE);
+	end_addr = ALIGN(hw->address + hw->len, HW_BREAKPOINT_SIZE);
+	hw_len = end_addr - start_addr;
 
 	if (dawr_enabled()) {
 		max_len = DAWR_MAX_LEN;
 		/* DAWR region can't cross 512 bytes boundary */
-		if ((start_addr >> 9) != (end_addr >> 9))
+		if ((start_addr >> 9) != ((end_addr - 1) >> 9))
 			return -EINVAL;
 	} else if (IS_ENABLED(CONFIG_PPC_8xx)) {
 		/* 8xx can setup a range without limitation */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index aab82ab80dfa..06679adac447 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -800,12 +800,12 @@ static inline int set_breakpoint_8xx(struct arch_hw_breakpoint *brk)
 	unsigned long lctrl1 = LCTRL1_CTE_GT | LCTRL1_CTF_LT | LCTRL1_CRWE_RW |
 			       LCTRL1_CRWF_RW;
 	unsigned long lctrl2 = LCTRL2_LW0EN | LCTRL2_LW0LADC | LCTRL2_SLW0EN;
-	unsigned long start_addr = brk->address & ~HW_BREAKPOINT_ALIGN;
-	unsigned long end_addr = (brk->address + brk->len - 1) | HW_BREAKPOINT_ALIGN;
+	unsigned long start_addr = ALIGN_DOWN(brk->address, HW_BREAKPOINT_SIZE);
+	unsigned long end_addr = ALIGN(brk->address + brk->len, HW_BREAKPOINT_SIZE);
 
 	if (start_addr == 0)
 		lctrl2 |= LCTRL2_LW0LA_F;
-	else if (end_addr == ~0U)
+	else if (end_addr - 1 == ~0U)
 		lctrl2 |= LCTRL2_LW0LA_E;
 	else
 		lctrl2 |= LCTRL2_LW0LA_EandF;
@@ -821,7 +821,7 @@ static inline int set_breakpoint_8xx(struct arch_hw_breakpoint *brk)
 		lctrl1 |= LCTRL1_CRWE_WO | LCTRL1_CRWF_WO;
 
 	mtspr(SPRN_CMPE, start_addr - 1);
-	mtspr(SPRN_CMPF, end_addr + 1);
+	mtspr(SPRN_CMPF, end_addr);
 	mtspr(SPRN_LCTRL1, lctrl1);
 	mtspr(SPRN_LCTRL2, lctrl2);
 
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

