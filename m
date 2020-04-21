Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F0CC55181
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A4F20857
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgDUJ1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 05:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728528AbgDUJ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 05:27:01 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DC6C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 02:27:00 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jQpB6-0007ym-PQ; Tue, 21 Apr 2020 11:26:53 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 2C987104099;
        Tue, 21 Apr 2020 11:26:52 +0200 (CEST)
Message-Id: <20200421092558.939985695@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 21 Apr 2020 11:20:29 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [patch V2 02/16] x86/cpu: Uninline CR4 accessors
References: <20200421092027.591582014@linutronix.de>
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

cpu_tlbstate is exported because various TLB related functions need access
to it, but cpu_tlbstate is sensitive information which should only be
accessed by well contained kernel functions and not be directly exposed to
modules.

The various CR4 accessors require cpu_tlbstate as the CR4 shadow cache is
located there.

In preparation of unexporting cpu_tlbstate create a builtin function for
manipulating CR4 and rework the various helpers to use it.

Export native_write_cr4() only when CONFIG_LKTDM=m.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/tlbflush.h |   36 +++++-------------------------------
 arch/x86/kernel/cpu/common.c    |   25 ++++++++++++++++++++++++-
 arch/x86/kernel/process.c       |   11 +++++++++++
 3 files changed, 40 insertions(+), 32 deletions(-)

--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -276,37 +276,25 @@ static inline bool nmi_uaccess_okay(void
 
 #define nmi_uaccess_okay nmi_uaccess_okay
 
+void cr4_update_irqsoff(unsigned long set, unsigned long clear);
+unsigned long cr4_read_shadow(void);
+
 /* Initialize cr4 shadow for this CPU. */
 static inline void cr4_init_shadow(void)
 {
 	this_cpu_write(cpu_tlbstate.cr4, __read_cr4());
 }
 
-static inline void __cr4_set(unsigned long cr4)
-{
-	lockdep_assert_irqs_disabled();
-	this_cpu_write(cpu_tlbstate.cr4, cr4);
-	__write_cr4(cr4);
-}
-
 /* Set in this cpu's CR4. */
 static inline void cr4_set_bits_irqsoff(unsigned long mask)
 {
-	unsigned long cr4;
-
-	cr4 = this_cpu_read(cpu_tlbstate.cr4);
-	if ((cr4 | mask) != cr4)
-		__cr4_set(cr4 | mask);
+	cr4_update_irqsoff(mask, 0);
 }
 
 /* Clear in this cpu's CR4. */
 static inline void cr4_clear_bits_irqsoff(unsigned long mask)
 {
-	unsigned long cr4;
-
-	cr4 = this_cpu_read(cpu_tlbstate.cr4);
-	if ((cr4 & ~mask) != cr4)
-		__cr4_set(cr4 & ~mask);
+	cr4_update_irqsoff(0, mask);
 }
 
 /* Set in this cpu's CR4. */
@@ -329,20 +317,6 @@ static inline void cr4_clear_bits(unsign
 	local_irq_restore(flags);
 }
 
-static inline void cr4_toggle_bits_irqsoff(unsigned long mask)
-{
-	unsigned long cr4;
-
-	cr4 = this_cpu_read(cpu_tlbstate.cr4);
-	__cr4_set(cr4 ^ mask);
-}
-
-/* Read the CR4 shadow. */
-static inline unsigned long cr4_read_shadow(void)
-{
-	return this_cpu_read(cpu_tlbstate.cr4);
-}
-
 /*
  * Mark all other ASIDs as invalid, preserves the current.
  */
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -387,7 +387,30 @@ void native_write_cr4(unsigned long val)
 			  bits_missing);
 	}
 }
-EXPORT_SYMBOL(native_write_cr4);
+#if IS_MODULE(CONFIG_LKDTM)
+EXPORT_SYMBOL_GPL(native_write_cr4);
+#endif
+
+void cr4_update_irqsoff(unsigned long set, unsigned long clear)
+{
+	unsigned long newval, cr4 = this_cpu_read(cpu_tlbstate.cr4);
+
+	lockdep_assert_irqs_disabled();
+
+	newval = (cr4 & ~clear) | set;
+	if (newval != cr4) {
+		this_cpu_write(cpu_tlbstate.cr4, newval);
+		__write_cr4(newval);
+	}
+}
+EXPORT_SYMBOL(cr4_update_irqsoff);
+
+/* Read the CR4 shadow. */
+unsigned long cr4_read_shadow(void)
+{
+	return this_cpu_read(cpu_tlbstate.cr4);
+}
+EXPORT_SYMBOL_GPL(cr4_read_shadow);
 
 void cr4_init(void)
 {
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -612,6 +612,17 @@ void speculation_ctrl_update_current(voi
 	preempt_enable();
 }
 
+static inline void cr4_toggle_bits_irqsoff(unsigned long mask)
+{
+	unsigned long newval, cr4 = this_cpu_read(cpu_tlbstate.cr4);
+
+	newval = cr4 ^ mask;
+	if (newval != cr4) {
+		this_cpu_write(cpu_tlbstate.cr4, newval);
+		__write_cr4(newval);
+	}
+}
+
 void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 {
 	unsigned long tifp, tifn;

