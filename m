Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E947BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8BB32072D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="spyrhmMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407272AbgE1U1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:27:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36696 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407244AbgE1U0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=g4EutcNkbbAZwusJhcuddPUd/QbVZ/YWbgBnEdm30HY=; b=spyrhmMGGG80+lAOKsWFm0kWZg
        jwKSMKWms4F8g4SvH3UWrkBmI+H4N9P2fa4t7g1DfPL4DLP2MJJO00MA0ubjvT1eTU2OyeRZVeX9B
        CV6WzNSHX/9XfIPFIauml2leVdhEZyRnN9HoPjjY4aju+7m+smm8vGV3HSBycBEXvovYOmxb/ops9
        epSDmrk094A3JraI0Ks3KE+S1IYBYDkI0MkhX6Me8mRtIcP0F8SNhPQrUxjhFKQ5acQv861qOHyYk
        3mV7zNxD7gzjq5UBM1qSNpHaZ55xx6v80UXxVOXfKyxP9H56UgYx9VSdAYRdU6ysTTnaxjNjZHR9z
        2f+mQDcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeP4m-0003gd-TP; Thu, 28 May 2020 20:24:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EB8C9306108;
        Thu, 28 May 2020 22:24:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D6FC82BA01B18; Thu, 28 May 2020 22:24:22 +0200 (CEST)
Message-ID: <20200528202328.588432451@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 28 May 2020 22:19:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@amacapital.net, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, andrew.cooper3@citrix.com,
        daniel.thompson@linaro.org, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 4/6] x86/entry: Optimize local_db_save() for virt
References: <20200528201937.038455891@infradead.org>
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
 arch/x86/include/asm/debugreg.h |    6 ++++++
 arch/x86/kernel/hw_breakpoint.c |   26 ++++++++++++++++++++++----
 arch/x86/kvm/vmx/nested.c       |    2 ++
 3 files changed, 30 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -115,6 +115,12 @@ static inline void debug_stack_usage_dec
 
 static __always_inline void local_db_save(unsigned long *dr7)
 {
+	if (static_cpu_has(X86_FEATURE_HYPERVISOR) && !hw_breakpoint_active()) {
+		*dr7 = 0;
+		barrier();
+		return;
+	}
+
 	get_debugreg(*dr7, 7);
 	if (*dr7)
 		set_debugreg(0, 7);
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -97,6 +97,8 @@ int arch_install_hw_breakpoint(struct pe
 	unsigned long *dr7;
 	int i;
 
+	lockdep_assert_irqs_disabled();
+
 	for (i = 0; i < HBP_NUM; i++) {
 		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
 
@@ -115,6 +117,12 @@ int arch_install_hw_breakpoint(struct pe
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
@@ -134,9 +142,11 @@ int arch_install_hw_breakpoint(struct pe
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
 
@@ -149,12 +159,20 @@ void arch_uninstall_hw_breakpoint(struct
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
@@ -3027,6 +3027,8 @@ static int nested_vmx_check_vmentry_hw(s
 
 	/*
 	 * VMExit clears RFLAGS.IF and DR7, even on a consistency check.
+	 * XXX how is this not broken? access to cpu_dr7 ought to be with
+	 * IRQs disabled.
 	 */
 	local_irq_enable();
 	if (hw_breakpoint_active())


