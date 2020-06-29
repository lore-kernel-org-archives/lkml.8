Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61944C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A4F82064B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbgF2SnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgF2Smx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:42:53 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBC9C033C23;
        Mon, 29 Jun 2020 11:26:33 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyU8-002Dt7-Tw; Mon, 29 Jun 2020 18:26:28 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 03/41] x86: kill dump_fpu()
Date:   Mon, 29 Jun 2020 19:25:50 +0100
Message-Id: <20200629182628.529995-3-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

dead since the removal of aout coredump support...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/fpu/internal.h |  1 -
 arch/x86/kernel/fpu/regset.c        | 16 ----------------
 2 files changed, 17 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 42159f45bf9c..0c85a08176c0 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -34,7 +34,6 @@ extern int  fpu__copy(struct task_struct *dst, struct task_struct *src);
 extern void fpu__clear_user_states(struct fpu *fpu);
 extern void fpu__clear_all(struct fpu *fpu);
 extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
-extern int  dump_fpu(struct pt_regs *ptregs, struct user_i387_struct *fpstate);
 
 /*
  * Boot time FPU initialization functions:
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index bd1d0649f8ce..91f80aca27fb 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -356,20 +356,4 @@ int fpregs_set(struct task_struct *target, const struct user_regset *regset,
 	return ret;
 }
 
-/*
- * FPU state for core dumps.
- * This is only used for a.out dumps now.
- * It is declared generically using elf_fpregset_t (which is
- * struct user_i387_struct) but is in fact only used for 32-bit
- * dumps, so on 64-bit it is really struct user_i387_ia32_struct.
- */
-int dump_fpu(struct pt_regs *regs, struct user_i387_struct *ufpu)
-{
-	struct task_struct *tsk = current;
-
-	return !fpregs_get(tsk, NULL, 0, sizeof(struct user_i387_ia32_struct),
-			   ufpu, NULL);
-}
-EXPORT_SYMBOL(dump_fpu);
-
 #endif	/* CONFIG_X86_32 || CONFIG_IA32_EMULATION */
-- 
2.11.0

