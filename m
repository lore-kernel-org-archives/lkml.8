Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F4FC54E49
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5879208D6
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgEGPBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:01:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3902 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727795AbgEGPBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:01:05 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DB54F71F3AD21596FD66;
        Thu,  7 May 2020 23:01:00 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 23:00:54 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Alan Kao <alankao@andestech.com>
Subject: [PATCH -next] riscv: perf: RISCV_BASE_PMU should be closeable
Date:   Thu, 7 May 2020 23:04:45 +0800
Message-ID: <20200507150445.174390-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507150445.174390-1-wangkefeng.wang@huawei.com>
References: <20200507150445.174390-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As 178e9fc47aae("perf: riscv: preliminary RISC-V support") said,
For RISCV_BASE_PMU, 'this option can also be disable to reduce kernel size',
but it could not work well, we need diable both RISCV_BASE_PMU and
PERF_EVENTS manually, or build error will occur when only disable
RISCV_BASE_PMU.

Cc: Alan Kao <alankao@andestech.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/riscv/include/asm/perf_event.h | 8 ++------
 arch/riscv/kernel/Makefile          | 2 +-
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/perf_event.h b/arch/riscv/include/asm/perf_event.h
index 0234048b12bc..062efd3a1d5d 100644
--- a/arch/riscv/include/asm/perf_event.h
+++ b/arch/riscv/include/asm/perf_event.h
@@ -12,19 +12,14 @@
 #include <linux/ptrace.h>
 #include <linux/interrupt.h>
 
+#ifdef CONFIG_RISCV_BASE_PMU
 #define RISCV_BASE_COUNTERS	2
 
 /*
  * The RISCV_MAX_COUNTERS parameter should be specified.
  */
 
-#ifdef CONFIG_RISCV_BASE_PMU
 #define RISCV_MAX_COUNTERS	2
-#endif
-
-#ifndef RISCV_MAX_COUNTERS
-#error "Please provide a valid RISCV_MAX_COUNTERS for the PMU."
-#endif
 
 /*
  * These are the indexes of bits in counteren register *minus* 1,
@@ -82,6 +77,7 @@ struct riscv_pmu {
 	int		irq;
 };
 
+#endif
 #ifdef CONFIG_PERF_EVENTS
 #define perf_arch_bpf_user_pt_regs(regs) (struct user_regs_struct *)regs
 #endif
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 1f5736e996fd..b355cf485671 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -43,7 +43,7 @@ obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
 
-obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o
+obj-$(CONFIG_RISCV_BASE_PMU)	+= perf_event.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
 obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
 obj-$(CONFIG_RISCV_SBI)		+= sbi.o
-- 
2.26.2

