Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C7DC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 232F1207DA
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbgEXPIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 11:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbgEXPIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 11:08:45 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDF2C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 08:08:45 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jcsF1-00046M-94; Sun, 24 May 2020 17:08:43 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 89F1C100D0B;
        Sun, 24 May 2020 17:08:42 +0200 (CEST)
Date:   Sun, 24 May 2020 15:08:03 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v5.7-rc7
References: <159033288117.21635.13199705716119914103.tglx@nanos.tec.linutronix.de>
Message-ID: <159033288358.21635.2357843074773527660.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-05-24

up to:  187b96db5ca7: x86/unwind/orc: Fix unwind_get_return_address_ptr() for inactive tasks


Two fixes for x86:

  - Unbreak stack dumps for inactive tasks by interpreting the special
    first frame left by __switch_to_asm() correctly. The recent change not
    to skip the first frame so ORC and frame unwinder behave in the same
    way caused all entries to be unreliable, i.e. prepended with '?'.

  - Use cpumask_available() instead of an implicit NULL check of a
    cpumask_var_t in mmio trace to prevent a Clang build warning

Thanks,

	tglx

------------------>
Josh Poimboeuf (1):
      x86/unwind/orc: Fix unwind_get_return_address_ptr() for inactive tasks

Nathan Chancellor (1):
      x86/mmiotrace: Use cpumask_available() for cpumask_var_t variables


 arch/x86/kernel/unwind_orc.c | 7 +++++++
 arch/x86/mm/mmio-mod.c       | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index fa79e4227d3d..7f969b2d240f 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -320,12 +320,19 @@ EXPORT_SYMBOL_GPL(unwind_get_return_address);
 
 unsigned long *unwind_get_return_address_ptr(struct unwind_state *state)
 {
+	struct task_struct *task = state->task;
+
 	if (unwind_done(state))
 		return NULL;
 
 	if (state->regs)
 		return &state->regs->ip;
 
+	if (task != current && state->sp == task->thread.sp) {
+		struct inactive_task_frame *frame = (void *)task->thread.sp;
+		return &frame->ret_addr;
+	}
+
 	if (state->sp)
 		return (unsigned long *)state->sp - 1;
 
diff --git a/arch/x86/mm/mmio-mod.c b/arch/x86/mm/mmio-mod.c
index 109325d77b3e..43fd19b3f118 100644
--- a/arch/x86/mm/mmio-mod.c
+++ b/arch/x86/mm/mmio-mod.c
@@ -372,7 +372,7 @@ static void enter_uniprocessor(void)
 	int cpu;
 	int err;
 
-	if (downed_cpus == NULL &&
+	if (!cpumask_available(downed_cpus) &&
 	    !alloc_cpumask_var(&downed_cpus, GFP_KERNEL)) {
 		pr_notice("Failed to allocate mask\n");
 		goto out;
@@ -402,7 +402,7 @@ static void leave_uniprocessor(void)
 	int cpu;
 	int err;
 
-	if (downed_cpus == NULL || cpumask_weight(downed_cpus) == 0)
+	if (!cpumask_available(downed_cpus) || cpumask_weight(downed_cpus) == 0)
 		return;
 	pr_notice("Re-enabling CPUs...\n");
 	for_each_cpu(cpu, downed_cpus) {

