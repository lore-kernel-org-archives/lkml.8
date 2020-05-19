Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DA2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27D3D20849
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgESUAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbgEST7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:59:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3CBC08C5C1;
        Tue, 19 May 2020 12:59:11 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8OI-0000IT-3T; Tue, 19 May 2020 21:59:06 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ABA4D1C086B;
        Tue, 19 May 2020 21:58:50 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:50 -0000
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/hw_breakpoint: Prevent data breakpoints on
 cpu_entry_area
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134058.272448010@linutronix.de>
References: <20200505134058.272448010@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991833058.17951.5755686483787789680.tip-bot2@tip-bot2>
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

Commit-ID:     3ea11ac991d594728e5df42f7eb1145072b9c2bc
Gitweb:        https://git.kernel.org/tip/3ea11ac991d594728e5df42f7eb1145072b9c2bc
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Mon, 24 Feb 2020 13:24:58 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 15 May 2020 20:03:03 +02:00

x86/hw_breakpoint: Prevent data breakpoints on cpu_entry_area

A data breakpoint near the top of an IST stack will cause unrecoverable
recursion.  A data breakpoint on the GDT, IDT, or TSS is terrifying.
Prevent either of these from happening.

Co-developed-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Link: https://lkml.kernel.org/r/20200505134058.272448010@linutronix.de

---
 arch/x86/kernel/hw_breakpoint.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 4d8d53e..d42fc0e 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -227,10 +227,35 @@ int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
 	return (va >= TASK_SIZE_MAX) || ((va + len - 1) >= TASK_SIZE_MAX);
 }
 
+/*
+ * Checks whether the range from addr to end, inclusive, overlaps the CPU
+ * entry area range.
+ */
+static inline bool within_cpu_entry_area(unsigned long addr, unsigned long end)
+{
+	return end >= CPU_ENTRY_AREA_BASE &&
+	       addr < (CPU_ENTRY_AREA_BASE + CPU_ENTRY_AREA_TOTAL_SIZE);
+}
+
 static int arch_build_bp_info(struct perf_event *bp,
 			      const struct perf_event_attr *attr,
 			      struct arch_hw_breakpoint *hw)
 {
+	unsigned long bp_end;
+
+	bp_end = attr->bp_addr + attr->bp_len - 1;
+	if (bp_end < attr->bp_addr)
+		return -EINVAL;
+
+	/*
+	 * Prevent any breakpoint of any type that overlaps the
+	 * cpu_entry_area.  This protects the IST stacks and also
+	 * reduces the chance that we ever find out what happens if
+	 * there's a data breakpoint on the GDT, IDT, or TSS.
+	 */
+	if (within_cpu_entry_area(attr->bp_addr, bp_end))
+		return -EINVAL;
+
 	hw->address = attr->bp_addr;
 	hw->mask = 0;
 
