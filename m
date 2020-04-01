Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E04FC2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09CFF2077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbgDAGOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 02:14:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731895AbgDAGOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 02:14:46 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03163JB0033084
        for <linux-kernel@vger.kernel.org>; Wed, 1 Apr 2020 02:14:45 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3020700qeu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 02:14:45 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 1 Apr 2020 07:14:41 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Apr 2020 07:14:36 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0316EaEg61276316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Apr 2020 06:14:37 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF0CCA4059;
        Wed,  1 Apr 2020 06:14:36 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6776DA4040;
        Wed,  1 Apr 2020 06:14:33 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.48.114])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Apr 2020 06:14:33 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        christophe.leroy@c-s.fr, naveen.n.rao@linux.vnet.ibm.com,
        peterz@infradead.org, jolsa@kernel.org, oleg@redhat.com,
        fweisbec@gmail.com, mingo@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com
Subject: [PATCH v2 14/16] powerpc/watchpoint: Don't allow concurrent perf and ptrace events
Date:   Wed,  1 Apr 2020 11:43:07 +0530
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401061309.92442-1-ravi.bangoria@linux.ibm.com>
References: <20200401061309.92442-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20040106-0028-0000-0000-000003EFD851
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040106-0029-0000-0000-000024B55D2E
Message-Id: <20200401061309.92442-15-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=910 suspectscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With Book3s DAWR, ptrace and perf watchpoints on powerpc behaves
differently. Ptrace watchpoint works in one-shot mode and generates
signal before executing instruction. It's ptrace user's job to
single-step the instruction and re-enable the watchpoint. OTOH, in
case of perf watchpoint, kernel emulates/single-steps the instruction
and then generates event. If perf and ptrace creates two events with
same or overlapping address ranges, it's ambiguous to decide who
should single-step the instruction. Because of this issue, don't
allow perf and ptrace watchpoint at the same time if their address
range overlaps.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/include/asm/hw_breakpoint.h |   2 +
 arch/powerpc/kernel/hw_breakpoint.c      | 222 +++++++++++++++++++++++
 kernel/events/hw_breakpoint.c            |  16 ++
 3 files changed, 240 insertions(+)

diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index abc4603c0efe..9d3bd1169591 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -70,6 +70,8 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 						unsigned long val, void *data);
 int arch_install_hw_breakpoint(struct perf_event *bp);
 void arch_uninstall_hw_breakpoint(struct perf_event *bp);
+int arch_reserve_bp_slot(struct perf_event *bp);
+void arch_release_bp_slot(struct perf_event *bp);
 void arch_unregister_hw_breakpoint(struct perf_event *bp);
 void hw_breakpoint_pmu_read(struct perf_event *bp);
 extern void flush_ptrace_hw_breakpoint(struct task_struct *tsk);
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 07a6cdea84ed..f813acb0d9f0 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -123,6 +123,228 @@ static bool is_ptrace_bp(struct perf_event *bp)
 	return bp->overflow_handler == ptrace_triggered;
 }
 
+struct breakpoint {
+	struct list_head list;
+	struct perf_event *bp;
+	bool ptrace_bp;
+};
+
+static DEFINE_PER_CPU(struct breakpoint *, cpu_bps[HBP_NUM_MAX]);
+static LIST_HEAD(task_bps);
+
+static struct breakpoint *alloc_breakpoint(struct perf_event *bp)
+{
+	struct breakpoint *tmp;
+
+	tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
+	if (!tmp)
+		return ERR_PTR(-ENOMEM);
+	tmp->bp = bp;
+	tmp->ptrace_bp = is_ptrace_bp(bp);
+	return tmp;
+}
+
+static bool bp_addr_range_overlap(struct perf_event *bp1, struct perf_event *bp2)
+{
+	__u64 bp1_saddr, bp1_eaddr, bp2_saddr, bp2_eaddr;
+
+	bp1_saddr = ALIGN_DOWN(bp1->attr.bp_addr, HW_BREAKPOINT_SIZE);
+	bp1_eaddr = ALIGN(bp1->attr.bp_addr + bp1->attr.bp_len, HW_BREAKPOINT_SIZE) - 1;
+	bp2_saddr = ALIGN_DOWN(bp2->attr.bp_addr, HW_BREAKPOINT_SIZE);
+	bp2_eaddr = ALIGN(bp2->attr.bp_addr + bp2->attr.bp_len, HW_BREAKPOINT_SIZE) - 1;
+
+	return (bp1_saddr <= bp2_eaddr && bp1_eaddr >= bp2_saddr);
+}
+
+static bool alternate_infra_bp(struct breakpoint *b, struct perf_event *bp)
+{
+	return is_ptrace_bp(bp) ? !b->ptrace_bp : b->ptrace_bp;
+}
+
+static bool can_co_exist(struct breakpoint *b, struct perf_event *bp)
+{
+	return !(alternate_infra_bp(b, bp) && bp_addr_range_overlap(b->bp, bp));
+}
+
+static int task_bps_add(struct perf_event *bp)
+{
+	struct breakpoint *tmp;
+
+	tmp = alloc_breakpoint(bp);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+
+	list_add(&tmp->list, &task_bps);
+	return 0;
+}
+
+static void task_bps_remove(struct perf_event *bp)
+{
+	struct list_head *pos, *q;
+	struct breakpoint *tmp;
+
+	list_for_each_safe(pos, q, &task_bps) {
+		tmp = list_entry(pos, struct breakpoint, list);
+
+		if (tmp->bp == bp) {
+			list_del(&tmp->list);
+			kfree(tmp);
+			break;
+		}
+	}
+}
+
+/*
+ * If any task has breakpoint from alternate infrastructure,
+ * return true. Otherwise return false.
+ */
+static bool all_task_bps_check(struct perf_event *bp)
+{
+	struct breakpoint *tmp;
+
+	list_for_each_entry(tmp, &task_bps, list) {
+		if (!can_co_exist(tmp, bp))
+			return true;
+	}
+	return false;
+}
+
+/*
+ * If same task has breakpoint from alternate infrastructure,
+ * return true. Otherwise return false.
+ */
+static bool same_task_bps_check(struct perf_event *bp)
+{
+	struct breakpoint *tmp;
+
+	list_for_each_entry(tmp, &task_bps, list) {
+		if (tmp->bp->hw.target == bp->hw.target &&
+		    !can_co_exist(tmp, bp))
+			return true;
+	}
+	return false;
+}
+
+static int cpu_bps_add(struct perf_event *bp)
+{
+	struct breakpoint **cpu_bp;
+	struct breakpoint *tmp;
+	int i = 0;
+
+	tmp = alloc_breakpoint(bp);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+
+	cpu_bp = per_cpu_ptr(cpu_bps, bp->cpu);
+	for (i = 0; i < nr_wp_slots(); i++) {
+		if (!cpu_bp[i]) {
+			cpu_bp[i] = tmp;
+			break;
+		}
+	}
+	return 0;
+}
+
+static void cpu_bps_remove(struct perf_event *bp)
+{
+	struct breakpoint **cpu_bp;
+	int i = 0;
+
+	cpu_bp = per_cpu_ptr(cpu_bps, bp->cpu);
+	for (i = 0; i < nr_wp_slots(); i++) {
+		if (!cpu_bp[i])
+			continue;
+
+		if (cpu_bp[i]->bp == bp) {
+			kfree(cpu_bp[i]);
+			cpu_bp[i] = NULL;
+			break;
+		}
+	}
+}
+
+static bool cpu_bps_check(int cpu, struct perf_event *bp)
+{
+	struct breakpoint **cpu_bp;
+	int i;
+
+	cpu_bp = per_cpu_ptr(cpu_bps, cpu);
+	for (i = 0; i < nr_wp_slots(); i++) {
+		if (cpu_bp[i] && !can_co_exist(cpu_bp[i], bp))
+			return true;
+	}
+	return false;
+}
+
+static bool all_cpu_bps_check(struct perf_event *bp)
+{
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		if (cpu_bps_check(cpu, bp))
+			return true;
+	}
+	return false;
+}
+
+/*
+ * We don't use any locks to serialize accesses to cpu_bps or task_bps
+ * because are already inside nr_bp_mutex.
+ */
+int arch_reserve_bp_slot(struct perf_event *bp)
+{
+	int ret;
+
+	/* ptrace breakpoint */
+	if (is_ptrace_bp(bp)) {
+		if (all_cpu_bps_check(bp))
+			return -ENOSPC;
+
+		if (same_task_bps_check(bp))
+			return -ENOSPC;
+
+		return task_bps_add(bp);
+	}
+
+	/* perf breakpoint */
+	if (is_kernel_addr(bp->attr.bp_addr))
+		return 0;
+
+	if (bp->hw.target && bp->cpu == -1) {
+		if (same_task_bps_check(bp))
+			return -ENOSPC;
+
+		return task_bps_add(bp);
+	} else if (!bp->hw.target && bp->cpu != -1) {
+		if (all_task_bps_check(bp))
+			return -ENOSPC;
+
+		return cpu_bps_add(bp);
+	}
+
+	if (same_task_bps_check(bp))
+		return -ENOSPC;
+
+	ret = cpu_bps_add(bp);
+	if (ret)
+		return ret;
+	ret = task_bps_add(bp);
+	if (ret)
+		cpu_bps_remove(bp);
+
+	return ret;
+}
+
+void arch_release_bp_slot(struct perf_event *bp)
+{
+	if (!is_kernel_addr(bp->attr.bp_addr)) {
+		if (bp->hw.target)
+			task_bps_remove(bp);
+		if (bp->cpu != -1)
+			cpu_bps_remove(bp);
+	}
+}
+
 /*
  * Perform cleanup of arch-specific counters during unregistration
  * of the perf-event
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 3cc8416ec844..b48d7039a015 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -213,6 +213,15 @@ toggle_bp_slot(struct perf_event *bp, bool enable, enum bp_type_idx type,
 		list_del(&bp->hw.bp_list);
 }
 
+__weak int arch_reserve_bp_slot(struct perf_event *bp)
+{
+	return 0;
+}
+
+__weak void arch_release_bp_slot(struct perf_event *bp)
+{
+}
+
 /*
  * Function to perform processor-specific cleanup during unregistration
  */
@@ -270,6 +279,7 @@ static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
 	struct bp_busy_slots slots = {0};
 	enum bp_type_idx type;
 	int weight;
+	int ret;
 
 	/* We couldn't initialize breakpoint constraints on boot */
 	if (!constraints_initialized)
@@ -294,6 +304,10 @@ static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
 	if (slots.pinned + (!!slots.flexible) > nr_slots[type])
 		return -ENOSPC;
 
+	ret = arch_reserve_bp_slot(bp);
+	if (ret)
+		return ret;
+
 	toggle_bp_slot(bp, true, type, weight);
 
 	return 0;
@@ -317,6 +331,8 @@ static void __release_bp_slot(struct perf_event *bp, u64 bp_type)
 	enum bp_type_idx type;
 	int weight;
 
+	arch_release_bp_slot(bp);
+
 	type = find_slot_idx(bp_type);
 	weight = hw_breakpoint_weight(bp);
 	toggle_bp_slot(bp, false, type, weight);
-- 
2.21.1

