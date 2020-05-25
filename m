Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BCAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6279E20890
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404024AbgEYOzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:55:11 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:40686 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391001AbgEYOzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:55:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TzcvFfu_1590418266;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TzcvFfu_1590418266)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 May 2020 22:51:07 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [RFC PATCH 1/5] x86/hw_breakpoint: add within_area() to check data breakpoints
Date:   Mon, 25 May 2020 14:50:58 +0000
Message-Id: <20200525145102.122557-2-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200525145102.122557-1-laijs@linux.alibaba.com>
References: <20200525145102.122557-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

within_area() is added for checking if the data breakpoints overlap
with cpu_entry_area, and will be used for checking if the data
breakpoints overlap with GDT, IDT, or TSS in places other than
cpu_entry_area next patches.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/kernel/hw_breakpoint.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 9ddf441ccaa8..c149c7b29ac3 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -227,14 +227,23 @@ int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
 	return (va >= TASK_SIZE_MAX) || ((va + len - 1) >= TASK_SIZE_MAX);
 }
 
+/*
+ * Checks whether the range [addr, end], overlaps the area [base, base + size).
+ */
+static inline bool within_area(unsigned long addr, unsigned long end,
+			       unsigned long base, unsigned long size)
+{
+	return end >= base && addr < (base + size);
+}
+
 /*
  * Checks whether the range from addr to end, inclusive, overlaps the CPU
  * entry area range.
  */
 static inline bool within_cpu_entry_area(unsigned long addr, unsigned long end)
 {
-	return end >= CPU_ENTRY_AREA_BASE &&
-	       addr < (CPU_ENTRY_AREA_BASE + CPU_ENTRY_AREA_TOTAL_SIZE);
+	return within_area(addr, end, CPU_ENTRY_AREA_BASE,
+			   CPU_ENTRY_AREA_TOTAL_SIZE);
 }
 
 static int arch_build_bp_info(struct perf_event *bp,
-- 
2.20.1

