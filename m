Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3670C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FDF62071A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CVzO0U5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgE2Vh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:37:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54868 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbgE2VhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=kCq/YA1qx0uRBYOl4jkN6Xm4uyIDYdkjDqm1F572WOs=; b=CVzO0U5zBknKpEJL7ZbZ3qwfRF
        srkuDrNZly+ms0pk1MmKDBv/DYwkuDr9+rTESiFrWxoJ6WukraDmV1dVLQMbPDJdlkanpNr7C4kIc
        4pYv92nyNSdzpYv5Y70An5tD47mtFHsWnnRhrz53dpJOJB2R9oaTD7f/QgO3HslgBGiT5GaxKiVnR
        suVjgB0Ks5AmU0jvf8TtKoGM/LwHKM4cUHVVyOj/u7awd1W1a7sodJH0ZqugKqT/SQC3Gxsl1gjVy
        hcQ32q4vTzxDDrURa/xJcy1fXszoUPtxAtYqpUfEVQCDqiOIR+4CLf0tNDrPMjTdzovHu4bGT/ibq
        uwpIXS9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jemeP-0007Iz-V4; Fri, 29 May 2020 21:34:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 006F43075EF;
        Fri, 29 May 2020 23:34:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 334FF2B9B1BC0; Fri, 29 May 2020 23:34:41 +0200 (CEST)
Message-ID: <20200529213321.187833200@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 29 May 2020 23:27:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@amacapital.net, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, andrew.cooper3@citrix.com,
        daniel.thompson@linaro.org, a.darwish@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 08/14] x86/entry: Optimize local_db_save() for virt
References: <20200529212728.795169701@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because DRn access is 'difficult' with virt; but the DR7 read is
cheaper than a cacheline miss on native, add a virt specific
fast path to local_db_save(), such that when breakpoints are not in
use we avoid touching DRn entirely.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/debugreg.h |    7 ++++++-
 arch/x86/kernel/hw_breakpoint.c |   26 ++++++++++++++++++++++----
 arch/x86/kvm/vmx/nested.c       |    2 +-
 3 files changed, 29 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -85,8 +85,8 @@ static inline void hw_breakpoint_disable
 	set_debugreg(0UL, 3);
 }
 
-static inline int hw_breakpoint_active(void)
+static inline bool hw_breakpoint_active(void)
 {
 	return __this_cpu_read(cpu_dr7) & DR_GLOBAL_ENABLE_MASK;
 }
 
@@ -117,6 +119,9 @@ static __always_inline unsigned long loc
 {
 	unsigned long dr7;
 
+	if (static_cpu_has(X86_FEATURE_HYPERVISOR) && !hw_breakpoint_active())
+		return 0;
+
 	get_debugreg(dr7, 7);
 	dr7 &= ~0x400; /* architecturally set bit */
 	if (dr7)
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -99,6 +99,8 @@ int arch_install_hw_breakpoint(struct pe
 	unsigned long *dr7;
 	int i;
 
+	lockdep_assert_irqs_disabled();
+
 	for (i = 0; i < HBP_NUM; i++) {
 		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
 
@@ -117,6 +119,12 @@ int arch_install_hw_breakpoint(struct pe
 	dr7 = this_cpu_ptr(&cpu_dr7);
 	*dr7 |= encode_dr7(i, info->len, info->type);
 
+	/*
+	 * Ensure we first write cpu_dr7 before we set the DR7 register.
+	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
+	 */
+	barrier();
+
 	set_debugreg(*dr7, 7);
 	if (info->mask)
 		set_dr_addr_mask(info->mask, i);
@@ -136,9 +144,11 @@ int arch_install_hw_breakpoint(struct pe
 void arch_uninstall_hw_breakpoint(struct perf_event *bp)
 {
 	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-	unsigned long *dr7;
+	unsigned long dr7;
 	int i;
 
+	lockdep_assert_irqs_disabled();
+
 	for (i = 0; i < HBP_NUM; i++) {
 		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
 
@@ -151,12 +161,20 @@ void arch_uninstall_hw_breakpoint(struct
 	if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
 		return;
 
-	dr7 = this_cpu_ptr(&cpu_dr7);
-	*dr7 &= ~__encode_dr7(i, info->len, info->type);
+	dr7 = this_cpu_read(cpu_dr7);
+	dr7 &= ~__encode_dr7(i, info->len, info->type);
 
-	set_debugreg(*dr7, 7);
+	set_debugreg(dr7, 7);
 	if (info->mask)
 		set_dr_addr_mask(0, i);
+
+	/*
+	 * Ensure the write to cpu_dr7 is after we've set the DR7 register.
+	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
+	 */
+	barrier();
+
+	this_cpu_write(cpu_dr7, dr7);
 }
 
 static int arch_bp_generic_len(int x86_len)
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3028,9 +3028,9 @@ static int nested_vmx_check_vmentry_hw(s
 	/*
 	 * VMExit clears RFLAGS.IF and DR7, even on a consistency check.
 	 */
-	local_irq_enable();
 	if (hw_breakpoint_active())
 		set_debugreg(__this_cpu_read(cpu_dr7), 7);
+	local_irq_enable();
 	preempt_enable();
 
 	/*


