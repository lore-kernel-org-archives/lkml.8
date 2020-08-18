Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0C3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2539920658
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgHRRTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:19:43 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63418 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728563AbgHRRTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:19:24 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BWHhS09Ttz9vCxl;
        Tue, 18 Aug 2020 19:19:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id kFOy8En8D3SV; Tue, 18 Aug 2020 19:19:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BWHhR6X75z9vCxg;
        Tue, 18 Aug 2020 19:19:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BCBA58B7EC;
        Tue, 18 Aug 2020 19:19:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id idDfGtHJ5pca; Tue, 18 Aug 2020 19:19:21 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 82E2C8B7D7;
        Tue, 18 Aug 2020 19:19:21 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 63FE465CF4; Tue, 18 Aug 2020 17:19:21 +0000 (UTC)
Message-Id: <13ef6510ce30a4867e043157b93af5bb8c67fb3b.1597770847.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1597770847.git.christophe.leroy@csgroup.eu>
References: <cover.1597770847.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 09/25] powerpc/signal: Remove get_clean_sp()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 18 Aug 2020 17:19:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_clean_sp() is only used once in kernel/signal.c .

GCC is smart enough to see that x & 0xffffffff is a nop
calculation on PPC32, no need of a special PPC32 trivial version.

Include the logic from the PPC64 version of get_clean_sp() directly
in get_sigframe().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/processor.h | 14 --------------
 arch/powerpc/kernel/signal.c         |  5 ++++-
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index e20b0c5abe62..8320aedbdca3 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -406,20 +406,6 @@ static inline void prefetchw(const void *x)
 
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
index 1be5fd01f866..a295d482adec 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -150,7 +150,10 @@ void __user *get_sigframe(struct ksignal *ksig, unsigned long sp,
         unsigned long oldsp, newsp;
 
         /* Default to using normal stack */
-        oldsp = get_clean_sp(sp, is_32);
+	if (is_32)
+		oldsp = sp & 0x0ffffffffUL;
+	else
+		oldsp = sp;
 	oldsp = sigsp(oldsp, ksig);
 	newsp = (oldsp - frame_size) & ~0xFUL;
 
-- 
2.25.0

