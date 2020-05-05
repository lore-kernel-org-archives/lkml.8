Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C7BC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E98920675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgEEONu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729332AbgEEONr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:13:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E32C061BD3
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:13:47 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyJw-0000Hb-KI; Tue, 05 May 2020 16:13:16 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 22E8DFFC8D;
        Tue,  5 May 2020 16:13:16 +0200 (CEST)
Message-Id: <20200505134058.272448010@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:16:04 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V4 part 1 02/36] x86/hw_breakpoint: Prevent data breakpoints
 on cpu_entry_area
References: <20200505131602.633487962@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

A data breakpoint near the top of an IST stack will cause unresoverable
recursion.  A data breakpoint on the GDT, IDT, or TSS is terrifying.
Prevent either of these from happening.

Co-developed-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hw_breakpoint.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -227,10 +227,35 @@ int arch_check_bp_in_kernelspace(struct
 	return (va >= TASK_SIZE_MAX) || ((va + len - 1) >= TASK_SIZE_MAX);
 }
 
+/*
+ * Checks whether the range from addr to end, inclusive, overlaps the CPU
+ * entry area range.
+ */
+static inline bool within_cpu_entry_area(unsigned long addr, unsigned long end)
+{
+	return end >= CPU_ENTRY_AREA_PER_CPU &&
+	       addr < (CPU_ENTRY_AREA_PER_CPU + CPU_ENTRY_AREA_TOTAL_SIZE);
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
 

