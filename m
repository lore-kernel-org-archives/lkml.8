Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C023BC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A677120658
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgHRRUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:20:08 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11306 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728630AbgHRRTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:19:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BWHhj5Mjyz9vCy7;
        Tue, 18 Aug 2020 19:19:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 10qMUz2cC2BH; Tue, 18 Aug 2020 19:19:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BWHhj4cSHz9vCxg;
        Tue, 18 Aug 2020 19:19:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 441588B7EC;
        Tue, 18 Aug 2020 19:19:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id faFp51Yn7eYl; Tue, 18 Aug 2020 19:19:35 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1551C8B7D7;
        Tue, 18 Aug 2020 19:19:35 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E0A0765CF4; Tue, 18 Aug 2020 17:19:34 +0000 (UTC)
Message-Id: <c3ac4f2d134a3391bb51bdaa2d00e9a409aba9f8.1597770847.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1597770847.git.christophe.leroy@csgroup.eu>
References: <cover.1597770847.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 22/25] powerpc/signal32: Switch swap_context() to
 user_access_begin() logic
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 18 Aug 2020 17:19:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As this was the last user of put_sigset_t(), remove it as well.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_32.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 3f9f315dd036..5b8a4ede142c 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -82,11 +82,6 @@
  * Functions for flipping sigsets (thanks to brain dead generic
  * implementation that makes things simple for little endian only)
  */
-static inline int put_sigset_t(compat_sigset_t __user *uset, sigset_t *set)
-{
-	return put_compat_sigset(uset, set, sizeof(*uset));
-}
-
 #define unsafe_put_sigset_t	unsafe_put_compat_sigset
 
 static inline int get_sigset_t(sigset_t *set,
@@ -138,11 +133,6 @@ static inline int restore_general_regs(struct pt_regs *regs,
 
 #define GP_REGS_SIZE	min(sizeof(elf_gregset_t), sizeof(struct pt_regs))
 
-static inline int put_sigset_t(sigset_t __user *uset, sigset_t *set)
-{
-	return copy_to_user(uset, set, sizeof(*uset));
-}
-
 #define unsafe_put_sigset_t(uset, set, label) do {			\
 	sigset_t __user *__us = uset	;				\
 	const sigset_t *__s = set;					\
@@ -1048,11 +1038,13 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 		 */
 		mctx = (struct mcontext __user *)
 			((unsigned long) &old_ctx->uc_mcontext & ~0xfUL);
-		if (!access_ok(old_ctx, ctx_size)
-		    || save_user_regs(regs, mctx, NULL, ctx_has_vsx_region)
-		    || put_sigset_t(&old_ctx->uc_sigmask, &current->blocked)
-		    || __put_user(to_user_ptr(mctx), &old_ctx->uc_regs))
+		if (save_user_regs(regs, mctx, NULL, ctx_has_vsx_region))
+			return -EFAULT;
+		if (!user_write_access_begin(old_ctx, ctx_size))
 			return -EFAULT;
+		unsafe_put_sigset_t(&old_ctx->uc_sigmask, &current->blocked, failed);
+		unsafe_put_user(to_user_ptr(mctx), &old_ctx->uc_regs, failed);
+		user_write_access_end();
 	}
 	if (new_ctx == NULL)
 		return 0;
@@ -1076,6 +1068,10 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 
 	set_thread_flag(TIF_RESTOREALL);
 	return 0;
+
+failed:
+	user_write_access_end();
+	return -EFAULT;
 }
 
 #ifdef CONFIG_PPC64
-- 
2.25.0

