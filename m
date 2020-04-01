Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37D0C2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916CC21841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbgDAGOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 02:14:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46778 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731895AbgDAGOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 02:14:30 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03163qWE058843
        for <linux-kernel@vger.kernel.org>; Wed, 1 Apr 2020 02:14:29 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 304g85y8xj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 02:14:29 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 1 Apr 2020 07:14:13 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Apr 2020 07:14:08 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0316ELrf58720272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Apr 2020 06:14:21 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA9D8A404D;
        Wed,  1 Apr 2020 06:14:20 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DCDBA4051;
        Wed,  1 Apr 2020 06:14:17 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.48.114])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Apr 2020 06:14:17 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        christophe.leroy@c-s.fr, naveen.n.rao@linux.vnet.ibm.com,
        peterz@infradead.org, jolsa@kernel.org, oleg@redhat.com,
        fweisbec@gmail.com, mingo@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com
Subject: [PATCH v2 10/16] powerpc/watchpoint: Use loop for thread_struct->ptrace_bps
Date:   Wed,  1 Apr 2020 11:43:03 +0530
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401061309.92442-1-ravi.bangoria@linux.ibm.com>
References: <20200401061309.92442-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20040106-0016-0000-0000-000002FC23E2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040106-0017-0000-0000-0000335FE69B
Message-Id: <20200401061309.92442-11-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=924 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004010049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptrace_bps is already an array of size HBP_NUM_MAX. But we use
hardcoded index 0 while fetching/updating it. Convert such code
to loop over array.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/kernel/hw_breakpoint.c       |  7 ++++--
 arch/powerpc/kernel/process.c             |  6 ++++-
 arch/powerpc/kernel/ptrace/ptrace-noadv.c | 28 +++++++++++++++++------
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 7562f9ceb77e..6daa95b8bb88 100644
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
index f5b4f21e822b..73c0800f0bcf 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1618,6 +1618,9 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
 	void (*f)(void);
 	unsigned long sp = (unsigned long)task_stack_page(p) + THREAD_SIZE;
 	struct thread_info *ti = task_thread_info(p);
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	int i;
+#endif
 
 	klp_init_thread_info(p);
 
@@ -1677,7 +1680,8 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
 	p->thread.ksp_limit = (unsigned long)end_of_stack(p);
 #endif
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
-	p->thread.ptrace_bps[0] = NULL;
+	for (i = 0; i < nr_wp_slots(); i++)
+		p->thread.ptrace_bps[i] = NULL;
 #endif
 
 	p->thread.fp_save_area = NULL;
diff --git a/arch/powerpc/kernel/ptrace/ptrace-noadv.c b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
index 0dbb35392dd2..08cb8c1b504c 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-noadv.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
@@ -168,6 +168,19 @@ int ptrace_set_debugreg(struct task_struct *task, unsigned long addr, unsigned l
 	return 0;
 }
 
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+static int find_empty_ptrace_bp(struct thread_struct *thread)
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
 static int find_empty_hw_brk(struct thread_struct *thread)
 {
 	int i;
@@ -217,8 +230,9 @@ long ppc_set_hwdebug(struct task_struct *child, struct ppc_hw_breakpoint *bp_inf
 		len = 1;
 	else
 		return -EINVAL;
-	bp = thread->ptrace_bps[0];
-	if (bp)
+
+	i = find_empty_ptrace_bp(thread);
+	if (i < 0)
 		return -ENOSPC;
 
 	/* Create a new breakpoint request if one doesn't exist already */
@@ -228,13 +242,13 @@ long ppc_set_hwdebug(struct task_struct *child, struct ppc_hw_breakpoint *bp_inf
 	arch_bp_generic_fields(brk.type, &attr.bp_type);
 
 	bp = register_user_hw_breakpoint(&attr, ptrace_triggered, NULL, child);
-	thread->ptrace_bps[0] = bp;
+	thread->ptrace_bps[i] = bp;
 	if (IS_ERR(bp)) {
-		thread->ptrace_bps[0] = NULL;
+		thread->ptrace_bps[i] = NULL;
 		return PTR_ERR(bp);
 	}
 
-	return 1;
+	return i + 1;
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 
 	if (bp_info->addr_mode != PPC_BREAKPOINT_MODE_EXACT)
@@ -263,10 +277,10 @@ long ppc_del_hwdebug(struct task_struct *child, long data)
 		return -EINVAL;
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
-	bp = thread->ptrace_bps[0];
+	bp = thread->ptrace_bps[data - 1];
 	if (bp) {
 		unregister_hw_breakpoint(bp);
-		thread->ptrace_bps[0] = NULL;
+		thread->ptrace_bps[data - 1] = NULL;
 	} else {
 		ret = -ENOENT;
 	}
-- 
2.21.1

