Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0B5C433F7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE8522D04
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgHFIuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 04:50:25 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:42872 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbgHFIuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 04:50:22 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BMhyg3Nfcz9v0TG;
        Thu,  6 Aug 2020 10:50:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id VhIF0KbsPeBM; Thu,  6 Aug 2020 10:50:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BMhyg2Wcfz9v0St;
        Thu,  6 Aug 2020 10:50:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B26658B7FA;
        Thu,  6 Aug 2020 10:50:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id o0efautfMvDK; Thu,  6 Aug 2020 10:50:20 +0200 (CEST)
Received: from po16052vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 89F438B75E;
        Thu,  6 Aug 2020 10:50:20 +0200 (CEST)
Received: by po16052vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 765F965BC9; Thu,  6 Aug 2020 08:50:20 +0000 (UTC)
Message-Id: <04169f40c09682ce5747518268ca84285bc17fbc.1596703345.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/signal: Move and simplify get_clean_sp()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  6 Aug 2020 08:50:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_clean_sp() is only used in kernel/signal.c . Move it there.

And GCC is smart enough to reduce the function when on PPC32, no
need of a special PPC32 simple version.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/processor.h | 14 --------------
 arch/powerpc/kernel/signal.c         |  7 +++++++
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index ed0d633ab5aa..5c20b6d509ae 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -404,20 +404,6 @@ static inline void prefetchw(const void *x)
 
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
 
-#ifdef CONFIG_PPC64
-static inline unsigned long get_clean_sp(unsigned long sp, int is_32)
-{
-	if (is_32)
-		return sp & 0x0ffffffffUL;
-	return sp;
-}
-#else
-static inline unsigned long get_clean_sp(unsigned long sp, int is_32)
-{
-	return sp;
-}
-#endif
-
 /* asm stubs */
 extern unsigned long isa300_idle_stop_noloss(unsigned long psscr_val);
 extern unsigned long isa300_idle_stop_mayloss(unsigned long psscr_val);
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index d15a98c758b8..bd0ba7c5e2cf 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -171,6 +171,13 @@ inline unsigned long copy_ckfpr_from_user(struct task_struct *task,
 
 int show_unhandled_signals = 1;
 
+static unsigned long get_clean_sp(unsigned long sp, int is_32)
+{
+	if (is_32)
+		return sp & 0x0ffffffffUL;
+	return sp;
+}
+
 /*
  * Allocate space for the signal frame
  */
-- 
2.25.0

