Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B7FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 492DE21475
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgE3J5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 05:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbgE3J5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 05:57:33 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BFEC03E969;
        Sat, 30 May 2020 02:57:32 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeyF1-0002sM-IJ; Sat, 30 May 2020 11:57:23 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1A9A01C032F;
        Sat, 30 May 2020 11:57:23 +0200 (CEST)
Date:   Sat, 30 May 2020 09:57:22 -0000
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/hw_breakpoint: Prevent data breakpoints on direct GDT
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200526014221.2119-3-laijs@linux.alibaba.com>
References: <20200526014221.2119-3-laijs@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <159083264294.17951.4573330706886496463.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     92a6521bf846dd08768bc4de447b79e8bd2cdb2f
Gitweb:        https://git.kernel.org/tip/92a6521bf846dd08768bc4de447b79e8bd2cdb2f
Author:        Lai Jiangshan <laijs@linux.alibaba.com>
AuthorDate:    Fri, 29 May 2020 23:27:30 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 30 May 2020 10:00:06 +02:00

x86/hw_breakpoint: Prevent data breakpoints on direct GDT

A data breakpoint on the GDT can be fatal and must be avoided.  The GDT in
the CPU entry area is already protected, but not the direct GDT.

Add the necessary protection.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200526014221.2119-3-laijs@linux.alibaba.com
Link: https://lkml.kernel.org/r/20200529213320.840953950@infradead.org

---
 arch/x86/kernel/hw_breakpoint.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index c149c7b..f859095 100644
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
