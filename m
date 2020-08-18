Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA83EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC7F220658
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgHRRTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:19:20 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:45941 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728511AbgHRRTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:19:15 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BWHhJ5MkSz9vCxn;
        Tue, 18 Aug 2020 19:19:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id bKuQ5JGo67fd; Tue, 18 Aug 2020 19:19:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BWHhJ4VHnz9vCxg;
        Tue, 18 Aug 2020 19:19:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 791C18B7EC;
        Tue, 18 Aug 2020 19:19:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2kYvDiy7EB13; Tue, 18 Aug 2020 19:19:14 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 475FC8B7D7;
        Tue, 18 Aug 2020 19:19:14 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2641B65CF4; Tue, 18 Aug 2020 17:19:14 +0000 (UTC)
Message-Id: <376c258267aeae54a4423bc4a2e107a9611f0039.1597770847.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1597770847.git.christophe.leroy@csgroup.eu>
References: <cover.1597770847.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 02/25] powerpc/ptrace: Move declaration of ptrace_get_reg()
 and ptrace_set_reg()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 18 Aug 2020 17:19:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptrace_get_reg() and ptrace_set_reg() are only used internally by
ptrace.

Move them in arch/powerpc/kernel/ptrace/ptrace-decl.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ptrace.h        | 6 ------
 arch/powerpc/kernel/ptrace/ptrace-decl.h | 3 +++
 arch/powerpc/kernel/ptrace/ptrace32.c    | 2 ++
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 155a197c0aa1..3c3cf537c3bf 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -171,12 +171,6 @@ static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
 		set_thread_flag(TIF_NOERROR); \
 	} while(0)
 
-struct task_struct;
-extern int ptrace_get_reg(struct task_struct *task, int regno,
-			  unsigned long *data);
-extern int ptrace_put_reg(struct task_struct *task, int regno,
-			  unsigned long data);
-
 #define current_pt_regs() \
 	((struct pt_regs *)((unsigned long)task_stack_page(current) + THREAD_SIZE) - 1)
 
diff --git a/arch/powerpc/kernel/ptrace/ptrace-decl.h b/arch/powerpc/kernel/ptrace/ptrace-decl.h
index 67447a6197eb..2ddc68412fa8 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-decl.h
+++ b/arch/powerpc/kernel/ptrace/ptrace-decl.h
@@ -159,6 +159,9 @@ int tm_cgpr32_set(struct task_struct *target, const struct user_regset *regset,
 
 /* ptrace-view */
 
+int ptrace_get_reg(struct task_struct *task, int regno, unsigned long *data);
+int ptrace_put_reg(struct task_struct *task, int regno, unsigned long data);
+
 extern const struct user_regset_view user_ppc_native_view;
 
 /* ptrace-(no)adv */
diff --git a/arch/powerpc/kernel/ptrace/ptrace32.c b/arch/powerpc/kernel/ptrace/ptrace32.c
index 7589a9665ffb..d30b9ad70edc 100644
--- a/arch/powerpc/kernel/ptrace/ptrace32.c
+++ b/arch/powerpc/kernel/ptrace/ptrace32.c
@@ -23,6 +23,8 @@
 
 #include <asm/switch_to.h>
 
+#include "ptrace-decl.h"
+
 /*
  * does not yet catch signals sent when the child dies.
  * in exit.c or in signal.c.
-- 
2.25.0

