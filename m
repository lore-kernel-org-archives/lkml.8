Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD1CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE85B2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgHLMGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:06:53 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:30573 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727954AbgHLMGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:06:11 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BRT1l1ycHzB09Zg;
        Wed, 12 Aug 2020 14:06:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id OJbrP9l1vozO; Wed, 12 Aug 2020 14:06:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BRT1l0t0bzB09Zf;
        Wed, 12 Aug 2020 14:06:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4B53C8B828;
        Wed, 12 Aug 2020 14:06:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id nf98ln0ZK9eP; Wed, 12 Aug 2020 14:06:04 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E7A308B7FC;
        Wed, 12 Aug 2020 14:06:03 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id CA6F465C34; Wed, 12 Aug 2020 12:06:03 +0000 (UTC)
Message-Id: <6257c01d5d6ac6da85de023a5b223ccf5021437b.1597233555.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1597233555.git.christophe.leroy@csgroup.eu>
References: <cover.1597233555.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 12/19] powerpc/signal32: Regroup copies in
 save_user_regs() and save_tm_user_regs()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ldv@altlinux.org,
        viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 12 Aug 2020 12:06:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder actions in save_user_regs() and save_tm_user_regs() to
regroup copies together in order to switch to user_access_begin()
logic in a later patch.

In save_tm_user_regs(), first perform copies to frame, then
perform copies to tm_frame.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_32.c | 153 +++++++++++++++++++-------------
 1 file changed, 91 insertions(+), 62 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 495bee1b713d..2c3d5d4400ec 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -243,6 +243,20 @@ static int save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
 
 	/* Make sure floating point registers are stored in regs */
 	flush_fp_to_thread(current);
+#ifdef CONFIG_ALTIVEC
+	if (current->thread.used_vr)
+		flush_altivec_to_thread(current);
+	if (cpu_has_feature(CPU_FTR_ALTIVEC))
+		current->thread.vrsave = mfspr(SPRN_VRSAVE);
+#endif
+#ifdef CONFIG_VSX
+	if (current->thread.used_vsr && ctx_has_vsx_region)
+		flush_vsx_to_thread(current);
+#endif
+#ifdef CONFIG_SPE
+	if (current->thread.used_spe)
+		flush_spe_to_thread(current);
+#endif
 
 	/* save general registers */
 	if (save_general_regs(regs, frame))
@@ -251,7 +265,6 @@ static int save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
 #ifdef CONFIG_ALTIVEC
 	/* save altivec registers */
 	if (current->thread.used_vr) {
-		flush_altivec_to_thread(current);
 		if (__copy_to_user(&frame->mc_vregs, &current->thread.vr_state,
 				   ELF_NVRREG * sizeof(vector128)))
 			return 1;
@@ -267,8 +280,6 @@ static int save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
 	 * most significant bits of that same vector. --BenH
 	 * Note that the current VRSAVE value is in the SPR at this point.
 	 */
-	if (cpu_has_feature(CPU_FTR_ALTIVEC))
-		current->thread.vrsave = mfspr(SPRN_VRSAVE);
 	if (__put_user(current->thread.vrsave, (u32 __user *)&frame->mc_vregs[32]))
 		return 1;
 #endif /* CONFIG_ALTIVEC */
@@ -288,7 +299,6 @@ static int save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
 	 * contains valid data
 	 */
 	if (current->thread.used_vsr && ctx_has_vsx_region) {
-		flush_vsx_to_thread(current);
 		if (copy_vsx_to_user(&frame->mc_vsregs, current))
 			return 1;
 		msr |= MSR_VSX;
@@ -297,7 +307,6 @@ static int save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
 #ifdef CONFIG_SPE
 	/* save spe registers */
 	if (current->thread.used_spe) {
-		flush_spe_to_thread(current);
 		if (__copy_to_user(&frame->mc_vregs, current->thread.evr,
 				   ELF_NEVRREG * sizeof(u32)))
 			return 1;
@@ -314,20 +323,22 @@ static int save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
 
 	if (__put_user(msr, &frame->mc_gregs[PT_MSR]))
 		return 1;
-	/* We need to write 0 the MSR top 32 bits in the tm frame so that we
-	 * can check it on the restore to see if TM is active
-	 */
-	if (tm_frame && __put_user(0, &tm_frame->mc_gregs[PT_MSR]))
-		return 1;
 
 	if (sigret) {
 		/* Set up the sigreturn trampoline: li 0,sigret; sc */
 		if (__put_user(PPC_INST_ADDI + sigret, &frame->tramp[0])
 		    || __put_user(PPC_INST_SC, &frame->tramp[1]))
 			return 1;
+	}
+	if (sigret)
 		flush_icache_range((unsigned long) &frame->tramp[0],
 				   (unsigned long) &frame->tramp[2]);
-	}
+
+	/* We need to write 0 the MSR top 32 bits in the tm frame so that we
+	 * can check it on the restore to see if TM is active
+	 */
+	if (tm_frame && __put_user(0, &tm_frame->mc_gregs[PT_MSR]))
+		return 1;
 
 	return 0;
 }
@@ -349,18 +360,16 @@ static int save_tm_user_regs(struct pt_regs *regs,
 {
 	WARN_ON(tm_suspend_disabled);
 
-	/* Save both sets of general registers */
-	if (save_general_regs(&current->thread.ckpt_regs, frame)
-	    || save_general_regs(regs, tm_frame))
-		return 1;
+#ifdef CONFIG_ALTIVEC
+	if (cpu_has_feature(CPU_FTR_ALTIVEC))
+		current->thread.ckvrsave = mfspr(SPRN_VRSAVE);
+#endif
+#ifdef CONFIG_SPE
+	if (current->thread.used_spe)
+		flush_spe_to_thread(current);
+#endif
 
-	/* Stash the top half of the 64bit MSR into the 32bit MSR word
-	 * of the transactional mcontext.  This way we have a backward-compatible
-	 * MSR in the 'normal' (checkpointed) mcontext and additionally one can
-	 * also look at what type of transaction (T or S) was active at the
-	 * time of the signal.
-	 */
-	if (__put_user((msr >> 32), &tm_frame->mc_gregs[PT_MSR]))
+	if (save_general_regs(&current->thread.ckpt_regs, frame))
 		return 1;
 
 #ifdef CONFIG_ALTIVEC
@@ -369,17 +378,6 @@ static int save_tm_user_regs(struct pt_regs *regs,
 		if (__copy_to_user(&frame->mc_vregs, &current->thread.ckvr_state,
 				   ELF_NVRREG * sizeof(vector128)))
 			return 1;
-		if (msr & MSR_VEC) {
-			if (__copy_to_user(&tm_frame->mc_vregs,
-					   &current->thread.vr_state,
-					   ELF_NVRREG * sizeof(vector128)))
-				return 1;
-		} else {
-			if (__copy_to_user(&tm_frame->mc_vregs,
-					   &current->thread.ckvr_state,
-					   ELF_NVRREG * sizeof(vector128)))
-				return 1;
-		}
 
 		/* set MSR_VEC in the saved MSR value to indicate that
 		 * frame->mc_vregs contains valid data
@@ -392,32 +390,13 @@ static int save_tm_user_regs(struct pt_regs *regs,
 	 * significant bits of a vector, we "cheat" and stuff VRSAVE in the
 	 * most significant bits of that same vector. --BenH
 	 */
-	if (cpu_has_feature(CPU_FTR_ALTIVEC))
-		current->thread.ckvrsave = mfspr(SPRN_VRSAVE);
 	if (__put_user(current->thread.ckvrsave,
 		       (u32 __user *)&frame->mc_vregs[32]))
 		return 1;
-	if (msr & MSR_VEC) {
-		if (__put_user(current->thread.vrsave,
-			       (u32 __user *)&tm_frame->mc_vregs[32]))
-			return 1;
-	} else {
-		if (__put_user(current->thread.ckvrsave,
-			       (u32 __user *)&tm_frame->mc_vregs[32]))
-			return 1;
-	}
 #endif /* CONFIG_ALTIVEC */
 
 	if (copy_ckfpr_to_user(&frame->mc_fregs, current))
 		return 1;
-	if (msr & MSR_FP) {
-		if (copy_fpr_to_user(&tm_frame->mc_fregs, current))
-			return 1;
-	} else {
-		if (copy_ckfpr_to_user(&tm_frame->mc_fregs, current))
-			return 1;
-	}
-
 #ifdef CONFIG_VSX
 	/*
 	 * Copy VSR 0-31 upper half from thread_struct to local
@@ -428,15 +407,6 @@ static int save_tm_user_regs(struct pt_regs *regs,
 	if (current->thread.used_vsr) {
 		if (copy_ckvsx_to_user(&frame->mc_vsregs, current))
 			return 1;
-		if (msr & MSR_VSX) {
-			if (copy_vsx_to_user(&tm_frame->mc_vsregs,
-						      current))
-				return 1;
-		} else {
-			if (copy_ckvsx_to_user(&tm_frame->mc_vsregs, current))
-				return 1;
-		}
-
 		msr |= MSR_VSX;
 	}
 #endif /* CONFIG_VSX */
@@ -445,7 +415,6 @@ static int save_tm_user_regs(struct pt_regs *regs,
 	 * simply the same as in save_user_regs().
 	 */
 	if (current->thread.used_spe) {
-		flush_spe_to_thread(current);
 		if (__copy_to_user(&frame->mc_vregs, current->thread.evr,
 				   ELF_NEVRREG * sizeof(u32)))
 			return 1;
@@ -466,9 +435,69 @@ static int save_tm_user_regs(struct pt_regs *regs,
 		if (__put_user(PPC_INST_ADDI + sigret, &frame->tramp[0])
 		    || __put_user(PPC_INST_SC, &frame->tramp[1]))
 			return 1;
+	}
+	if (sigret)
 		flush_icache_range((unsigned long) &frame->tramp[0],
 				   (unsigned long) &frame->tramp[2]);
+
+	if (save_general_regs(regs, tm_frame))
+		return 1;
+
+	/* Stash the top half of the 64bit MSR into the 32bit MSR word
+	 * of the transactional mcontext.  This way we have a backward-compatible
+	 * MSR in the 'normal' (checkpointed) mcontext and additionally one can
+	 * also look at what type of transaction (T or S) was active at the
+	 * time of the signal.
+	 */
+	if (__put_user((msr >> 32), &tm_frame->mc_gregs[PT_MSR]))
+		return 1;
+
+#ifdef CONFIG_ALTIVEC
+	if (current->thread.used_vr) {
+		if (msr & MSR_VEC) {
+			if (__copy_to_user(&tm_frame->mc_vregs,
+					   &current->thread.vr_state,
+					   ELF_NVRREG * sizeof(vector128)))
+				return 1;
+		} else {
+			if (__copy_to_user(&tm_frame->mc_vregs,
+					   &current->thread.ckvr_state,
+					   ELF_NVRREG * sizeof(vector128)))
+				return 1;
+		}
+	}
+
+	if (msr & MSR_VEC) {
+		if (__put_user(current->thread.vrsave,
+			       (u32 __user *)&tm_frame->mc_vregs[32]))
+			return 1;
+	} else {
+		if (__put_user(current->thread.ckvrsave,
+			       (u32 __user *)&tm_frame->mc_vregs[32]))
+			return 1;
 	}
+#endif /* CONFIG_ALTIVEC */
+
+	if (msr & MSR_FP) {
+		if (copy_fpr_to_user(&tm_frame->mc_fregs, current))
+			return 1;
+	} else {
+		if (copy_ckfpr_to_user(&tm_frame->mc_fregs, current))
+			return 1;
+	}
+
+#ifdef CONFIG_VSX
+	if (current->thread.used_vsr) {
+		if (msr & MSR_VSX) {
+			if (copy_vsx_to_user(&tm_frame->mc_vsregs,
+						      current))
+				return 1;
+		} else {
+			if (copy_ckvsx_to_user(&tm_frame->mc_vsregs, current))
+				return 1;
+		}
+	}
+#endif /* CONFIG_VSX */
 
 	return 0;
 }
-- 
2.25.0

