Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE317C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B66BC2078B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391047AbgEYOvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:51:23 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:20610 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391054AbgEYOvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:51:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TzdBWia_1590418268;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TzdBWia_1590418268)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 May 2020 22:51:09 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [RFC PATCH 2/5] x86/hw_breakpoint: Prevent data breakpoints on direct GDT
Date:   Mon, 25 May 2020 14:50:59 +0000
Message-Id: <20200525145102.122557-3-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200525145102.122557-1-laijs@linux.alibaba.com>
References: <20200525145102.122557-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A data breakpoint on the GDT is terrifying and should be avoided.
The GDT on CPU entry area is already protected. The direct GDT
should be also protected, although it is seldom used and only
used for short time.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/kernel/hw_breakpoint.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index c149c7b29ac3..f859095c1b6c 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -32,6 +32,7 @@
 #include <asm/processor.h>
 #include <asm/debugreg.h>
 #include <asm/user.h>
+#include <asm/desc.h>
 
 /* Per cpu debug control register value */
 DEFINE_PER_CPU(unsigned long, cpu_dr7);
@@ -237,13 +238,26 @@ static inline bool within_area(unsigned long addr, unsigned long end,
 }
 
 /*
- * Checks whether the range from addr to end, inclusive, overlaps the CPU
- * entry area range.
+ * Checks whether the range from addr to end, inclusive, overlaps the fixed
+ * mapped CPU entry area range or other ranges used for CPU entry.
  */
-static inline bool within_cpu_entry_area(unsigned long addr, unsigned long end)
+static inline bool within_cpu_entry(unsigned long addr, unsigned long end)
 {
-	return within_area(addr, end, CPU_ENTRY_AREA_BASE,
-			   CPU_ENTRY_AREA_TOTAL_SIZE);
+	int cpu;
+
+	/* CPU entry erea is always used for CPU entry */
+	if (within_area(addr, end, CPU_ENTRY_AREA_BASE,
+			CPU_ENTRY_AREA_TOTAL_SIZE))
+		return true;
+
+	for_each_possible_cpu(cpu) {
+		/* The original rw GDT is being used after load_direct_gdt() */
+		if (within_area(addr, end, (unsigned long)get_cpu_gdt_rw(cpu),
+				GDT_SIZE))
+			return true;
+	}
+
+	return false;
 }
 
 static int arch_build_bp_info(struct perf_event *bp,
@@ -257,12 +271,12 @@ static int arch_build_bp_info(struct perf_event *bp,
 		return -EINVAL;
 
 	/*
-	 * Prevent any breakpoint of any type that overlaps the
-	 * cpu_entry_area.  This protects the IST stacks and also
+	 * Prevent any breakpoint of any type that overlaps the CPU
+	 * entry area and data.  This protects the IST stacks and also
 	 * reduces the chance that we ever find out what happens if
 	 * there's a data breakpoint on the GDT, IDT, or TSS.
 	 */
-	if (within_cpu_entry_area(attr->bp_addr, bp_end))
+	if (within_cpu_entry(attr->bp_addr, bp_end))
 		return -EINVAL;
 
 	hw->address = attr->bp_addr;
-- 
2.20.1

