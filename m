Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F20BC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756F12168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="osJOwHfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgBNNoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:44:19 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:42541 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728437AbgBNNoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:44:18 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48Jvk72V3Vz9vCR9;
        Fri, 14 Feb 2020 14:44:15 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=osJOwHfv; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 0NoDlu6ms6Qm; Fri, 14 Feb 2020 14:44:15 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48Jvk711Dqz9vCR5;
        Fri, 14 Feb 2020 14:44:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1581687855; bh=p5OSchYtuMtDjkKkYQzLUBJDMO3eTkGR/MZiD0IIXe4=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=osJOwHfvoWgb3e+1x6J09Y1VkIdNT7TU2Dctc+uxOkG+hxqPMDxZk7Ub6XRLVnkep
         ddWoKAcvSHjRz95r4OEc+LnqCf9oQj6vHaI5WPbAIC7oXx3GmHXSsx7/smlk5G3tnl
         zzdHTZCbOeZ2fuz7ebtuRQglRxBSzCtOEp0QnwlA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7D51F8B89C;
        Fri, 14 Feb 2020 14:44:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id uy2nkeZb4FMB; Fri, 14 Feb 2020 14:44:16 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2DD4C8B89A;
        Fri, 14 Feb 2020 14:44:16 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0FD6C65284; Fri, 14 Feb 2020 13:44:16 +0000 (UTC)
Message-Id: <b67d6705956a1a294af600700115930ff87e643c.1581687838.git.christophe.leroy@c-s.fr>
In-Reply-To: <642c8b4ca59e658be38d8dde00f994e183790a6a.1581687838.git.christophe.leroy@c-s.fr>
References: <642c8b4ca59e658be38d8dde00f994e183790a6a.1581687838.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/2] powerpc/kprobes: Reduce depth of a test
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 14 Feb 2020 13:44:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	if (a) {
		if (b)
			do_something();
	}

Is equivalent to

	if (a & b)
		do_something();

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/kprobes.c | 58 +++++++++++++++++------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 7a925eb76ec0..d7c80a078c1e 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -277,38 +277,36 @@ int kprobe_handler(struct pt_regs *regs)
 
 	/* Check we're not actually recursing */
 	p = get_kprobe(addr);
-	if (kprobe_running()) {
-		if (p) {
-			kprobe_opcode_t insn = *p->ainsn.insn;
-			if (kcb->kprobe_status == KPROBE_HIT_SS &&
-					is_trap(insn)) {
-				/* Turn off 'trace' bits */
-				regs->msr &= ~MSR_SINGLESTEP;
-				regs->msr |= kcb->kprobe_saved_msr;
-				goto no_kprobe;
-			}
-			/* We have reentered the kprobe_handler(), since
-			 * another probe was hit while within the handler.
-			 * We here save the original kprobes variables and
-			 * just single step on the instruction of the new probe
-			 * without calling any user handlers.
-			 */
-			save_previous_kprobe(kcb);
-			set_current_kprobe(p, regs, kcb);
-			kprobes_inc_nmissed_count(p);
-			kcb->kprobe_status = KPROBE_REENTER;
-			if (p->ainsn.boostable >= 0) {
-				ret = try_to_emulate(p, regs);
-
-				if (ret > 0) {
-					restore_previous_kprobe(kcb);
-					preempt_enable_no_resched();
-					return 1;
-				}
+	if (kprobe_running() && p) {
+		kprobe_opcode_t insn = *p->ainsn.insn;
+
+		if (kcb->kprobe_status == KPROBE_HIT_SS && is_trap(insn)) {
+			/* Turn off 'trace' bits */
+			regs->msr &= ~MSR_SINGLESTEP;
+			regs->msr |= kcb->kprobe_saved_msr;
+			goto no_kprobe;
+		}
+		/* We have reentered the kprobe_handler(), since
+		 * another probe was hit while within the handler.
+		 * We here save the original kprobes variables and
+		 * just single step on the instruction of the new probe
+		 * without calling any user handlers.
+		 */
+		save_previous_kprobe(kcb);
+		set_current_kprobe(p, regs, kcb);
+		kprobes_inc_nmissed_count(p);
+		kcb->kprobe_status = KPROBE_REENTER;
+		if (p->ainsn.boostable >= 0) {
+			ret = try_to_emulate(p, regs);
+
+			if (ret > 0) {
+				restore_previous_kprobe(kcb);
+				preempt_enable_no_resched();
+				return 1;
 			}
-			prepare_singlestep(p, regs);
-			return 1;
 		}
+		prepare_singlestep(p, regs);
+		return 1;
 	}
 
 	if (!p) {
-- 
2.25.0

