Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D988C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8841B20838
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgEEOPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729778AbgEEOPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:15:16 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BC6C061A41
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:15:16 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyLa-0001J6-Pc; Tue, 05 May 2020 16:14:58 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 44A9AFFC8D;
        Tue,  5 May 2020 16:14:58 +0200 (CEST)
Message-Id: <20200505134903.841853522@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:44:00 +0200
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
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 3 06/29] x86/entry/64: Reorder idtentries
References: <20200505134354.774943181@linutronix.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

Move them all together so verifying the cleanup patches for binary
equivalence will be easier.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Andy Lutomirski <luto@kernel.org>

---
 arch/x86/entry/entry_64.S |   36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1021,20 +1021,36 @@ SYM_CODE_START(\sym)
 SYM_CODE_END(\sym)
 .endm
 
+
 idtentry divide_error			do_divide_error			has_error_code=0
 idtentry overflow			do_overflow			has_error_code=0
+idtentry int3				do_int3				has_error_code=0	create_gap=1
 idtentry bounds				do_bounds			has_error_code=0
 idtentry invalid_op			do_invalid_op			has_error_code=0
 idtentry device_not_available		do_device_not_available		has_error_code=0
-idtentry double_fault			do_double_fault			has_error_code=1 paranoid=2 read_cr2=1
 idtentry coprocessor_segment_overrun	do_coprocessor_segment_overrun	has_error_code=0
 idtentry invalid_TSS			do_invalid_TSS			has_error_code=1
 idtentry segment_not_present		do_segment_not_present		has_error_code=1
+idtentry stack_segment			do_stack_segment		has_error_code=1
+idtentry general_protection		do_general_protection		has_error_code=1
 idtentry spurious_interrupt_bug		do_spurious_interrupt_bug	has_error_code=0
 idtentry coprocessor_error		do_coprocessor_error		has_error_code=0
 idtentry alignment_check		do_alignment_check		has_error_code=1
 idtentry simd_coprocessor_error		do_simd_coprocessor_error	has_error_code=0
 
+idtentry page_fault		do_page_fault		has_error_code=1	read_cr2=1
+
+#ifdef CONFIG_X86_MCE
+idtentry machine_check		do_mce			has_error_code=0 paranoid=1
+#endif
+idtentry debug			do_debug		has_error_code=0 paranoid=1 shift_ist=IST_INDEX_DB ist_offset=DB_STACK_OFFSET
+idtentry double_fault		do_double_fault		has_error_code=1 paranoid=2 read_cr2=1
+
+#ifdef CONFIG_XEN_PV
+idtentry hypervisor_callback	xen_do_hypervisor_callback	has_error_code=0
+idtentry xennmi			do_nmi				has_error_code=0
+idtentry xendebug		do_debug			has_error_code=0
+#endif
 
 /*
  * Reload gs selector with exception handling
@@ -1085,8 +1101,6 @@ SYM_FUNC_END(do_softirq_own_stack)
 .popsection
 
 #ifdef CONFIG_XEN_PV
-idtentry hypervisor_callback xen_do_hypervisor_callback has_error_code=0
-
 /*
  * A note on the "critical region" in our callback handler.
  * We want to avoid stacking callback handlers due to events occurring
@@ -1189,22 +1203,6 @@ apicinterrupt3 HYPERVISOR_CALLBACK_VECTO
 	acrn_hv_callback_vector acrn_hv_vector_handler
 #endif
 
-idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=IST_INDEX_DB ist_offset=DB_STACK_OFFSET
-idtentry int3			do_int3			has_error_code=0	create_gap=1
-idtentry stack_segment		do_stack_segment	has_error_code=1
-
-#ifdef CONFIG_XEN_PV
-idtentry xennmi			do_nmi			has_error_code=0
-idtentry xendebug		do_debug		has_error_code=0
-#endif
-
-idtentry general_protection	do_general_protection	has_error_code=1
-idtentry page_fault		do_page_fault		has_error_code=1	read_cr2=1
-
-#ifdef CONFIG_X86_MCE
-idtentry machine_check		do_mce			has_error_code=0	paranoid=1
-#endif
-
 /*
  * Save all registers in pt_regs, and switch gs if needed.
  * Use slow, but surefire "are we in kernel?" check.

