Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9209CC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C89922525
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgCII7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:59:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11512 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726781AbgCII7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:59:16 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0298pHsW005056
        for <linux-kernel@vger.kernel.org>; Mon, 9 Mar 2020 04:59:16 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ym7t6e1d0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:59:16 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 9 Mar 2020 08:59:13 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Mar 2020 08:59:10 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0298x87g56492268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Mar 2020 08:59:08 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 945A0A404D;
        Mon,  9 Mar 2020 08:59:08 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 258ECA4051;
        Mon,  9 Mar 2020 08:59:06 +0000 (GMT)
Received: from bangoria.in.ibm.com (unknown [9.124.31.44])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Mar 2020 08:59:05 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        christophe.leroy@c-s.fr, naveen.n.rao@linux.vnet.ibm.com,
        peterz@infradead.org, jolsa@kernel.org, oleg@redhat.com,
        fweisbec@gmail.com, mingo@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 10/15] powerpc/watchpoint: Use loop for thread_struct->ptrace_bps
Date:   Mon,  9 Mar 2020 14:28:01 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com>
References: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030908-0012-0000-0000-0000038E7F66
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030908-0013-0000-0000-000021CB467B
Message-Id: <20200309085806.155823-11-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-09_02:2020-03-06,2020-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 mlxscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=939
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptrace_bps is already an array of size HBP_NUM_MAX. But we use
hardcoded index 0 while fetching/updating it. Convert such code
to loop over array.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/kernel/hw_breakpoint.c |  7 +++++--
 arch/powerpc/kernel/process.c       |  6 +++++-
 arch/powerpc/kernel/ptrace.c        | 28 +++++++++++++++++++++-------
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index f4d48f87dcb8..b27aca623267 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -419,10 +419,13 @@ NOKPROBE_SYMBOL(hw_breakpoint_exceptions_notify);
  */
 void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
 {
+	int i;
 	struct thread_struct *t = &tsk->thread;
 
-	unregister_hw_breakpoint(t->ptrace_bps[0]);
-	t->ptrace_bps[0] = NULL;
+	for (i = 0; i < nr_wp_slots(); i++) {
+		unregister_hw_breakpoint(t->ptrace_bps[i]);
+		t->ptrace_bps[i] = NULL;
+	}
 }
 
 void hw_breakpoint_pmu_read(struct perf_event *bp)
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 42ff62ef749c..b9ab740fcacf 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1628,6 +1628,9 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
 	void (*f)(void);
 	unsigned long sp = (unsigned long)task_stack_page(p) + THREAD_SIZE;
 	struct thread_info *ti = task_thread_info(p);
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	int i;
+#endif
 
 	klp_init_thread_info(p);
 
@@ -1687,7 +1690,8 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
 	p->thread.ksp_limit = (unsigned long)end_of_stack(p);
 #endif
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
-	p->thread.ptrace_bps[0] = NULL;
+	for (i = 0; i < nr_wp_slots(); i++)
+		p->thread.ptrace_bps[i] = NULL;
 #endif
 
 	p->thread.fp_save_area = NULL;
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index f6d7955fc61e..e2651f86d56f 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -2829,6 +2829,19 @@ static int set_dac_range(struct task_struct *child,
 }
 #endif /* CONFIG_PPC_ADV_DEBUG_DAC_RANGE */
 
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+static int empty_ptrace_bp(struct thread_struct *thread)
+{
+	int i;
+
+	for (i = 0; i < nr_wp_slots(); i++) {
+		if (!thread->ptrace_bps[i])
+			return i;
+	}
+	return -1;
+}
+#endif
+
 #ifndef CONFIG_PPC_ADV_DEBUG_REGS
 static int empty_hw_brk(struct thread_struct *thread)
 {
@@ -2915,8 +2928,9 @@ static long ppc_set_hwdebug(struct task_struct *child,
 		len = 1;
 	else
 		return -EINVAL;
-	bp = thread->ptrace_bps[0];
-	if (bp)
+
+	i = empty_ptrace_bp(thread);
+	if (i < 0)
 		return -ENOSPC;
 
 	/* Create a new breakpoint request if one doesn't exist already */
@@ -2925,14 +2939,14 @@ static long ppc_set_hwdebug(struct task_struct *child,
 	attr.bp_len = len;
 	arch_bp_generic_fields(brk.type, &attr.bp_type);
 
-	thread->ptrace_bps[0] = bp = register_user_hw_breakpoint(&attr,
+	thread->ptrace_bps[i] = bp = register_user_hw_breakpoint(&attr,
 					       ptrace_triggered, NULL, child);
 	if (IS_ERR(bp)) {
-		thread->ptrace_bps[0] = NULL;
+		thread->ptrace_bps[i] = NULL;
 		return PTR_ERR(bp);
 	}
 
-	return 1;
+	return i + 1;
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 
 	if (bp_info->addr_mode != PPC_BREAKPOINT_MODE_EXACT)
@@ -2979,10 +2993,10 @@ static long ppc_del_hwdebug(struct task_struct *child, long data)
 		return -EINVAL;
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
-	bp = thread->ptrace_bps[0];
+	bp = thread->ptrace_bps[data - 1];
 	if (bp) {
 		unregister_hw_breakpoint(bp);
-		thread->ptrace_bps[0] = NULL;
+		thread->ptrace_bps[data - 1] = NULL;
 	} else
 		ret = -ENOENT;
 	return ret;
-- 
2.21.1

