Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF8DC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 11:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1082080C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 11:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbgDAL2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 07:28:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33182 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732276AbgDAL2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 07:28:00 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D3D1850F367A102C20A9;
        Wed,  1 Apr 2020 19:27:46 +0800 (CST)
Received: from huawei.com (10.175.104.193) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 1 Apr 2020
 19:27:40 +0800
From:   Cheng Jian <cj.chengjian@huawei.com>
To:     <vpillai@digitalocean.com>
CC:     <aaron.lwe@gmail.com>, <aubrey.intel@gmail.com>,
        <aubrey.li@linux.intel.com>, <fweisbec@gmail.com>,
        <jdesfossez@digitalocean.com>, <joel@joelfernandes.org>,
        <joelaf@google.com>, <keescook@chromium.org>, <kerrnel@google.com>,
        <linux-kernel@vger.kernel.org>, <mgorman@techsingularity.net>,
        <mingo@kernel.org>, <naravamudan@digitalocean.com>,
        <pauld@redhat.com>, <pawan.kumar.gupta@linux.intel.com>,
        <pbonzini@redhat.com>, <peterz@infradead.org>, <pjt@google.com>,
        <tglx@linutronix.de>, <tim.c.chen@linux.intel.com>,
        <torvalds@linux-foundation.org>, <valentin.schneider@arm.com>,
        <cj.chengjian@huawei.com>, <xiexiuqi@huawei.com>,
        <huawei.libin@huawei.com>, <w.f@huawei.com>
Subject: [PATCH] sched/arm64: store cpu topology before notify_cpu_starting
Date:   Wed, 1 Apr 2020 11:42:15 +0000
Message-ID: <20200401114215.36640-1-cj.chengjian@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <855831b59e1b3774b11c3e33050eac4cc4639f06.1583332765.git.vpillai@digitalocean.com>
References: <855831b59e1b3774b11c3e33050eac4cc4639f06.1583332765.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.193]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when SCHED_CORE enabled, sched_cpu_starting() uses thread_sibling as
SMT_MASK to initialize rq->core, but only after store_cpu_topology(),
the thread_sibling is ready for use.

	notify_cpu_starting()
	    -> sched_cpu_starting()	# use thread_sibling

	store_cpu_topology(cpu)
	    -> update_siblings_masks	# set thread_sibling

Fix this by doing notify_cpu_starting later, just like x86 do.

Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
---
 arch/arm64/kernel/smp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 5407bf5d98ac..a427c14e82af 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -236,13 +236,18 @@ asmlinkage notrace void secondary_start_kernel(void)
 	cpuinfo_store_cpu();
 
 	/*
-	 * Enable GIC and timers.
+	 * Store cpu topology before notify_cpu_starting,
+	 * CPUHP_AP_SCHED_STARTING requires SMT topology
+	 * been initialized for SCHED_CORE.
 	 */
-	notify_cpu_starting(cpu);
-
 	store_cpu_topology(cpu);
 	numa_add_cpu(cpu);
 
+	/*
+	 * Enable GIC and timers.
+	 */
+	notify_cpu_starting(cpu);
+
 	/*
 	 * OK, now it's safe to let the boot CPU continue.  Wait for
 	 * the CPU migration code to notice that the CPU is online
-- 
2.17.1

